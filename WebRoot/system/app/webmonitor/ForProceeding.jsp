<%@ page contentType="text/html;charset=GBK"%>
<%@include file="/system/app/skin/import.jsp"%>
<table class="main-table" width="100%">
	<tr class="title1" width="100%">
		<td align="left" colspan="9">网上办事统计</td>
	</tr>
	<tr class="bttn" width="100%">
		<td align="center" class="outset-table">部门名称</td>
		<td align="center" class="outset-table">网上办事数</td>
		<td align="center" class="outset-table">下载表格数</td>
		<td align="center" class="outset-table">办事指南数</td>
		<td align="center" class="outset-table">常见问题数</td>
		<td align="center" class="outset-table">常办事项数</td>
		<td align="center" class="outset-table">绿色通道数</td>
		<td align="center" class="outset-table">在线办事数</td>
	</tr>
<% 
String sqlStr = "select dt_id,dt_name from tb_deptinfo where dt_id in(select dt_id from tb_proceeding) order by dt_sequence";
String dt_id = "";
String dt_name = "";
String pr_id = "";
String dt_content = "";
String pr_summarize = "";
String pr_isaccept = "";
String pr_isschedule = "";
//update20080122

CDataCn dCn=null;   //新建数据库连接对象
CDataImpl dImpl=null;  //新建数据接口对象

try {
 dCn = new CDataCn(); 
 dImpl = new CDataImpl(dCn); 
Vector vPage = dImpl.splitPage(sqlStr,1000,1);
if (vPage!=null)
{
	for (int i=0;i<vPage.size();i++)//循环取出有办事事项的部门
	{
		int attachnum = 0; //办事提供表格数
		int dt_count = 0;  //办事指南数
		int su_count = 0;  //常见问题数
		int pr_count = 0;  //网上办事数
		int acc_count = 0; //在线办事数
		int gre_count = 0; //绿色通道数
		int com_count = 0; //常办事项数
		Hashtable content = (Hashtable)vPage.get(i);
		dt_id = content.get("dt_id").toString();
		dt_name = content.get("dt_name").toString();
		sqlStr = "select pr_id, pr_isaccept, dt_content, pr_summarize, pr_isaccept, pr_isschedule from tb_proceeding where dt_id="+dt_id;
		out.print(sqlStr);
		Vector proPage = dImpl.splitPage(sqlStr,200,1);
		if (proPage!=null)
		{	
			pr_count = proPage.size();
			for (int j=0;j<pr_count;j++) //循环取出一个部门的办事事项
			{
				Hashtable pContent = (Hashtable)proPage.get(j);
				pr_id = pContent.get("pr_id").toString();
				dt_content = pContent.get("dt_content").toString();
				pr_summarize = pContent.get("pr_summarize").toString();
				pr_isaccept = pContent.get("pr_isaccept").toString();
				pr_isschedule = pContent.get("pr_isschedule").toString();
				if (!dt_content.equals("")) dt_count ++;
				if (!pr_summarize.equals("")) su_count ++;
				if (pr_isschedule.equals("1")) gre_count ++;
				if (pr_isaccept.equals("1")) acc_count ++;
				sqlStr = "select count(pa_id) attachnum from tb_proceedingattach where pr_id='"+pr_id+"'";
				Hashtable aContent = dImpl.getDataInfo(sqlStr);
				if (aContent!=null)
				{
					attachnum += Integer.parseInt(CTools.dealNumber(aContent.get("attachnum").toString()));
				}
				sqlStr = "select count(*) countNum from tb_proceedingex where pr_id in (select pr_id from tb_proceeding where dt_id="+dt_id+")";
				Hashtable cContent = dImpl.getDataInfo(sqlStr);
				if (cContent!=null)
				{
					com_count += Integer.parseInt(CTools.dealNumber(cContent.get("countnum").toString()));
				}
			}
		}
		%>
		<tr <%if (i%2==0) out.print("line-even");else out.print("line-odd");%>>
			<td><%=dt_name%></td>
			<td><%=pr_count%></td>
			<td><%=attachnum%></td>
			<td><%=dt_count%></td>
			<td><%=su_count%></td>
			<td><%=com_count%></td>
			<td><%=gre_count%></td>
			<td><%=acc_count%></td>
		</tr>
		<%
	}
}
%>
</table>
<%
dImpl.closeStmt();
dCn.closeCn();

} catch (Exception ex) {
	System.out.println(new java.util.Date() + "--"
			+ request.getServletPath() + " : " + ex.getMessage());
} finally {
	if(dImpl != null)
	dImpl.closeStmt();
	if(dCn != null)
	dCn.closeCn();
}
%>
