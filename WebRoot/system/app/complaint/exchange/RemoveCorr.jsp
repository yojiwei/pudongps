<%@page contentType="text/html; charset=GBK" %>
<%@include file="/system/app/skin/head.jsp"%>
<%@page import="com.component.database.*"%>
<%@page import="com.app.*"%>
<%
String cw_id="";
cw_id = CTools.dealString(request.getParameter("cw_id")).trim();

//update20080122

CDataCn dCn=null;   //新建数据库连接对象
CDataImpl dImpl=null;  //新建数据接口对象

try {
 dCn = new CDataCn(); 
 dImpl = new CDataImpl(dCn); 

String sqlRemove = "";
sqlRemove = " select z.cw_applyingname,x.co_id,to_char(y.de_sendtime,'yyyy-mm-dd hh24:mi:ss') de_sendtime,u.dt_name from tb_correspond x,tb_documentexchange y,tb_connwork z,tb_deptinfo u ";
sqlRemove +=" where x.cw_id='"+cw_id+"' and x.co_status='1' and x.co_id=y.de_primaryid and y.de_receiverdeptid=u.dt_id and y.de_type='6' and x.cw_id=z.cw_id ";

%>
<table class="main-table" width="100%">
<tr>
<td>
	<table class="content-table" width="100%">
	<form name="formData" action="RemoveResult.jsp">
	<tr class="title1">
	<td align="center" colspan="4">
		<table WIDTH="100%" BORDER="0" CELLSPACING="1" CELLPADDING="1">
		<tr width="100%" align="center">
		<td width="15%" valign="center"><font size="2"><b>可撤销协调单</b></font></td>
		</tr>
		<tr class="bttn">
            <td width="10%" class="outset-table" align="center">发送人</td>
            <td width="30%" class="outset-table" align="center">发送时间</td>
            <td width="15%" class="outset-table" align="center">接收部门</td>
			<td width="10%" class="outset-table" align="center">撤销</td>
		</tr>
		<%
		Vector vectorRemove=dImpl.splitPage(sqlRemove,request,20);
		if(vectorRemove!=null)
		{
			for(int i=0;i<vectorRemove.size();i++)
			{
				Hashtable contRemove = (Hashtable)vectorRemove.get(i);
				if(i%2==0) out.println("<tr align='center' widthe='100%' class='line-even'>");
				else out.println("<tr align='center' widthe='100%' class='line-odd'>");
		%>
		<td align="center"><%=contRemove.get("cw_applyingname").toString()%></td>
		<td align="center"><%=contRemove.get("de_sendtime").toString()%></td>
		<td align="center"><%=contRemove.get("dt_name").toString()%></td>
		<td align="center"><img src="/system/images/hammer.gif"  style="cursor:hand" width="20" height="20" title="撤销该协调单" onclick="checkRemove('<%=contRemove.get("co_id")%>','<%=cw_id%>');"></td>
	</td>
	</tr>
	</form>
		<%
			}
		      out.println("<tr><td colspan=10>" + dImpl.getTail(request) + "</td></tr>"); //输出尾部文件

		}
		%>
	</table>
</td>
</tr>
</table>
<script>
function checkRemove(co_id,cw_id)
{
	if(confirm("确定撤消该协调单吗？"))
	{
		window.location.href="RemoveResult.jsp?co_id="+co_id+"&cw_id="+cw_id;
	}

}
</script>
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
