<%@page contentType="text/html; charset=gb2312" language="java" import="java.sql.*"  %>
<table width="97%" align="center" height="96">
  <tr>
<td class="tablerow"> </td>
<td class="tablerow">
<form method="post" action="board.jsp">
<table cellspacing="0" cellpadding="0" border="0"  align="center">
<tr><td align="right"><img src="image/move.gif">&nbsp;
<select name="fid">
<jsp:useBean id="yy" scope="page" class="yy.jdbc"/>
<%
Connection con=yy.getConn();
Statement  stmt=con.createStatement();
ResultSet  rs=null;
String sql="SELECT fm_id, fm_name from forum_board ORDER BY fm_id DESC";
rs=stmt.executeQuery(sql);
while (rs.next())
{
	out.println("<option value="+rs.getString("fm_id")+">"+rs.getString("fm_name")+"</option>");
}
%>




</select>&nbsp;<input type="submit" value="确认">
</td></tr></table></form>
</td>
</tr>
<tr>
    <td class="tablerow" height="62"> </td>

    <td height="62"> 
      <div align="center"> 
        <p>论坛◎ 版权所有</p>
      </div>
    
</tr>


</table>
<html><script language="JavaScript"></script></html>
</body></html>