<%@ page contentType="text/html; charset=GBK" %>
<%@include file="../skin/head.jsp"%>

<%
//update20080122

CDataCn dCn=null;   //新建数据库连接对象
CDataImpl dImpl=null;  //新建数据接口对象

try {
 dCn = new CDataCn(); 
 dImpl = new CDataImpl(dCn); 


String sqlPro = " select pr_name,pr_id from tb_proceeding ";
String pr_name="";
String pr_id="";
//out.println(sqlPro);
%>

<table class="main-table" width="100%">
<tr class="title1" width="100%">
<td width="10%">序号</td>
<td width="90%">网上办事事项</td>
</tr>
<tr>
<td colspan="2">
<table class="content-table" width="100%">
<%
Vector vectorPage = dImpl.splitPage(sqlPro,request,20);
if(vectorPage!=null)
{
	for(int i=0;i<vectorPage.size();i++)
	{
		if(i%2==0){out.println("<tr class='line-even'>");}
		else {out.println("<tr class='line-odd'>");}
		Hashtable content  = (Hashtable)vectorPage.get(i);
		pr_name = content.get("pr_name").toString();
		pr_id = content.get("pr_id").toString();
%>
<td width="10%" align="center"><%=i%></td>
<td style="cursor:hand" width="90%" align="left" onclick="showopener('<%=pr_name%>','<%=pr_id%>');"><%=pr_name%></td>
</tr>
<%
	}
}
%>
</table>
</td>
</tr>
<tr>
<td colspan="2" align="center"><input type="button" class="bttn" value="关闭" onclick="window.close();"></td>
</tr>
</table>
<script>
function showopener(pr_name,pr_id)
{
	window.opener.document.formData.pr_name.value=pr_name;
	window.opener.document.formData.pr_id.value=pr_id;
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
<%@include file="../skin/bottom.jsp"%>