<%@ page contentType="text/html; charset=GBK"%>
<%@ include file="/system/app/skin/import.jsp"%>
<link rel="stylesheet" href="/system/app/main.css" type="text/css">
<%
String sqlStr = "";
String dd_name = CTools.dealString(request.getParameter("dd_name")).trim();
//update20080122

CDataCn dCn=null;   //新建数据库连接对象
CDataImpl dImpl=null;  //新建数据接口对象

try {
 dCn = new CDataCn(); 
 dImpl = new CDataImpl(dCn); 
%>

<body bgcolor="#FFFFE1">
<table border=0 cellspacing=0 cellpadding=0 align="left" width="100%">
	<tr>
		<td colspan="2" align="left">&nbsp;<b><%=dd_name%></b></td>
	</tr>
<%
if (!dd_name.equals(""))
{
	sqlStr = "select v.dv_value from tb_datavalue v, tb_datatdictionary d where d.dd_name='" + 
			 dd_name + "' and v.dd_id=d.dd_id";
	//out.print(sqlStr);
}
if (!sqlStr.equals(""))
{
	Vector dvPage = dImpl.splitPage(sqlStr,10,1);
	if (dvPage!=null)
	{
		int size = dvPage.size();
		for (int i=0;i<size-1;i++)
		{
			out.print("<tr>");
			out.print("		<td align=right  width='15%'><img src='/system/common/treeview/images/node.gif'></td>");
			out.print("		<td align=left>");
			Hashtable dvContent = (Hashtable)dvPage.get(i);
			String name = CTools.dealNull(dvContent.get("dv_value").toString());
			out.print("			&nbsp;<span style='cursor:hand' onclick='tdOnClick()'>"+ name +"</span>");
			out.print("		</td>");
			out.print("</tr>");
		}
		Hashtable dvContent = (Hashtable)dvPage.get(size-1);
		String name = CTools.dealNull(dvContent.get("dv_value").toString());
		out.print("<tr>");
		out.print("		<td align=right width='15%'><img src='/system/common/treeview/images/end.gif'></td>");
		out.print("		<td align=left>");
		out.print("			&nbsp;<span style='cursor:hand' onclick='tdOnClick()'>"+ name +"</span>");
		out.print("		</td>");
		out.print("</tr>");
	}
}
dImpl.closeStmt();
dCn.closeCn();
%>
	<tr>
		<td background="/system/images/bj-11.gif" colspan="2"> &nbsp;</td>
	</tr>
</table>
</body>
<script language="javascript">
function tdOnClick()
{
	var obj = event.srcElement;
	returnValue = obj.innerText;
	window.close();
}
</script>
<%


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