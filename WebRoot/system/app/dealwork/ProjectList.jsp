<!--后台业务受理页面，列出可在网上受理并且属于当前用户部门办理的业务-->

<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/system/app/skin/head.jsp"%>
<%
String dt_id = "";
String pr_name = "";
String pr_id = "";
String pr_timelimit = "";
String sqlStr = "";

//update20080122

CDataCn dCn=null;   //新建数据库连接对象
CDataImpl dImpl=null;  //新建数据接口对象

try {
 dCn = new CDataCn(); 
 dImpl = new CDataImpl(dCn); 

%>
<table class="main-table" width="100%">
<form name="formData" method="post">
	<tr width="100%" class="title1">
		<td width="100%">
			<table width="100%" class="content-table" border="0" cellspacing="0">
			<tr class="title1">
				<td align="left">可受理业务</td>
				<td align="right">
					<img src="/system/images/split.gif" align="middle" border="0" WIDTH="5" HEIGHT="8">
					<img src="/system/images/menu_about.gif" border="0" onclick="javascript:window.location.href='WorkQuery.jsp' " title="查找" style="cursor:hand" align="absmiddle">
					<img src="/system/images/split.gif" align="middle" border="0" WIDTH="5" HEIGHT="8">
					<img src="/system/images/goback.gif" border="0" onclick="javascript:history.back();" title="返回" style="cursor:hand" align="absmiddle">
					<img src="/system/images/split.gif" align="middle" border="0" WIDTH="5" HEIGHT="8">
				</td>
			</tr>
			</table>
		</td>
	</tr>
	<tr>
		<td>
			<table class="content-table" width="100%">
				<tr class="bttn" width="100%">
					<td align="center" class="outset-table" width="10%">项目id</td>
					<td align="center" class="outset-table" width="50%">项目名称</td>
					<td align="center" class="outset-table" width="10%">项目时限</td>
					<td align="center" class="outset-table" width="10%">受理</td>
				</tr>
				
<%
com.app.CMySelf mySelf = (com.app.CMySelf)session.getAttribute("mySelf"); //当前用户的部门id
if (mySelf!=null)
{
	dt_id = Long.toString(mySelf.getDtId());
}

if (!dt_id.equals(""))
{
	sqlStr = "select pr_id,pr_name,pr_timelimit from tb_proceeding where dt_id="+dt_id+" and pr_isaccept='1'";
}

if (!sqlStr.equals(""))
{
	Vector vPage = dImpl.splitPage(sqlStr,request,20);
	if (vPage!=null)
	{
		for(int i=0;i<vPage.size();i++)
		{
			Hashtable content = (Hashtable)vPage.get(i);
			pr_id = content.get("pr_id").toString();
			pr_name = content.get("pr_name").toString();
			pr_timelimit = content.get("pr_timelimit").toString();
			%>
				<tr <%if(i%2==0) out.print("class=\"line-even\"");else out.print("class=\"line-odd\"");%> width="100%">
					<td align="center"><%=pr_id%></td>
					<td align="left"><a href="AppWorkDetail.jsp?pr_id=<%=pr_id%>"><%=pr_name%></a></td>
					<td align="center"><font color="red"><%=pr_timelimit%></font>个工作日</td>
					<td align="center"><a href="AppWorkDetail.jsp?pr_id=<%=pr_id%>"><img src="/system/images/hammer.gif" border="0"></a></td>
				</tr>
			<%
		}
	}
	else
	{
		%>
				<tr class="line-even" width="100%">
					<td colspan="9">没有记录！</td>
				</tr>
		<%
	}
}
%>
			</table>
		</td>
	</tr>
</form>
	<tr>
		<td align="right"><%=dImpl.getTail(request)%></td>
	</tr>
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
<%@include file="/system/app/skin/bottom.jsp"%>
