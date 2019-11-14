<%@ page contentType="text/html; charset=GBK" %>
<%@ page import="com.component.database.*" %>
<%@ page import="java.util.*" %>
<%@ page import="com.platform.log.*" %>
<%@ page import="com.util.CTools" %>

<link href="../style.css" rel="stylesheet" type="text/css">
<script LANGUAGE="javascript">
<!--
function del()
{
  if(!confirm("您确认清除吗？")) return;
  formData.submit();
}
-->
</script>
<%
  String sql = "";
  String title = "";
%>
<%
 title = "系统登录日志";

 CDataCn dCn = null;
 CLogInfo jdo = null;
 try{
 	dCn = new CDataCn();
	jdo = new CLogInfo(dCn);
 sql =    "select * from tb_log where lg_type = 1 order by lg_id desc";
 //out.print(sql);
  jdo.setSql(sql);
%>


<table class="main-table" width="100%">
<tr>
 <td width="100%">
   <div align="center">
	<table border="0" width="100%" cellspacing="0" cellpadding="0">
		<tr>
			<td>
				<table border="0" width="100%" cellspacing="0" cellpadding="0">
					<tr class="bttn">
					   <td width="100%">
					   <table width="100%">
						 <tr>
							<td id="TitleTd" width="100%" align="left"><%=title%></td>
							<td valign="top" align="right" nowrap>
							<img src="/system/images/dialog/split.gif" align="middle" border="0">
								<img src="/system/images/dialog/delete.gif" border="0" onclick="del()" title="清除所有系统登录日志" style="cursor:hand" align="absmiddle" id="image2" name="image2" WIDTH="16" HEIGHT="16">
								<img src="/system/images/dialog/split.gif" align="middle" border="0">
								<img src="/system/images/dialog/return.gif" border="0" onclick="javascirpt:history.go(-1);" title="返回" style="cursor:hand" align="absmiddle" id="image3" name="image3" WIDTH="14" HEIGHT="14">
								<img src="/system/images/dialog/split.gif" align="middle" border="0">
							</td>
						  </tr>
						</table>
					   </td>
					</tr>
				</table>
		   </td>
		</tr>
        <tr>
          <td width="100%" valign="top">

			<!--内容-->
              <table border="0" width="100%" cellpadding="3" height="44">
                <tr class="bttn">
				    <td width="8%" height="1" class="outset-table">序号</td>
				    <td width="20%" height="1" class="outset-table">操作</td>
				    <td width="20%" height="1" class="outset-table">时间</td>
				    <td width="12%" height="1" class="outset-table">登录名</td>
				    <td width="40%" height="1" class="outset-table">日志内容</td>
				</tr>
<form name="formData" method="post" action="logDel.jsp">
<%
  Vector vectorPage = jdo.splitPage(request);
  if (vectorPage != null)
  {
    for(int j=0;j<vectorPage.size();j++)
    {
      Hashtable content = (Hashtable)vectorPage.get(j);
      if(j % 2 == 0)  out.print("<tr class=\"line-even\">");
      else out.print("<tr class=\"line-odd\">");

      out.println("<td>" + (j+1) + "</td>");
      out.println("<td>" + content.get("lg_action") + "</td>");
      out.println("<td>" + content.get("lg_rgtime") + "</td>");
      out.println("<td>" + content.get("lg_user") + "</td>");
      out.println("<td>" + content.get("lg_content") + "</td>");
      out.println("</tr>");
    }
  }else{
      out.print("<td>没有记录！</td>");
  }

%>
</form>
<tr><td colspan=10>
<%    out.println(jdo.getTail(request));%>
</td></tr>
				  </table>



				<!--内容-->
		      </td>
			 </tr>

		   </table>
		  </div>
	     </td>
	    </tr>
</table>

<%
 dCn.closeCn() ;
 

} catch (Exception ex) {
	System.out.println(new java.util.Date() + "--"
			+ request.getServletPath() + " : " + ex.getMessage());
} finally {
	if(jdo != null)
	jdo.closeStmt();
	if(dCn != null)
	dCn.closeCn();
}
%>
