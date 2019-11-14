<%@page contentType="text/html; charset=gb2312" language="java" import="java.sql.*"%>
<%
if ((session.getValue("UserName")==null)||(session.getValue("UserClass")==null)||(!session.getValue("UserClass").equals("系统管理员")))
{
	response.sendRedirect("err.jsp?id=14");
	return;
}
%>
<jsp:useBean id="yy" scope="page" class="yy.jdbc"/>
<%!String sql,Notice_Id,Delete_Id,Notice_Title,user_loginname = "";%>
<%
	Delete_Id=request.getParameter("deleteid");
	Notice_Title=request.getParameter("title");
	Connection con=yy.getConn();
	Statement  stmt=con.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_READ_ONLY);
	user_loginname=request.getParameter("userFileIds");
	Notice_Id=request.getParameter("noticeid");

	ResultSet rs=null;
	if (Delete_Id!=null)
	{
	   try
		{
		   sql="Delete from forum_board Where fm_id="+Delete_Id;		
		   stmt.executeUpdate(sql);
		   sql="Delete Form forum_post where post_board_id="+Delete_Id;
		   stmt.executeUpdate(sql);
		}
		catch(Exception e){
		}
		out.println("<html> <meta http-equiv='refresh' content='1;url=board_manager.jsp'> </html>");
		return;
	}
	if(user_loginname!=null) user_loginname = user_loginname.trim();
	if(user_loginname.equals("")||user_loginname==null)
	{
		out.print("<script language='JavaScript'>alert('论坛斑竹不能为空！');history.back();</script>");
	}
	else
	{
		sql="select * from USERINFO where ur_loginname='"+user_loginname+"'";
		rs=stmt.executeQuery(sql);
		rs.last();
		if(rs.getRow()==0)
		{
			out.println(user_loginname);
			response.sendRedirect("err.jsp?id=16");
			return;
		 }
		 else
		 {
			sql="update USERINFO set ur_grade='斑竹' where ur_loginname='"+user_loginname+"'";
			stmt.executeUpdate(sql);
		 }
	}
   
   if(Notice_Id.equals("0"))
		sql="insert into forum_board(fm_id,fm_name,fm_master_name,fm_create_date,fm_last_post_date) values(SEQ_FORUM_BOARD.nextval,'"+Notice_Title+"','"+user_loginname+"',TO_Date('"+yy.getTime()+"','YYYY-MM-DD HH24:MI:SS'),TO_Date('"+yy.getTime()+"','YYYY-MM-DD HH24:MI:SS'))";
   else
		sql="update forum_board set fm_name='"+Notice_Title+"',fm_master_name='"+user_loginname+"' where fm_id="+Notice_Id;
   //out.println(sql);
//out.close();
   stmt.executeUpdate(sql);
   out.println("<html> <meta http-equiv='refresh' content='1;url=board_manager.jsp'> </html>");
%>
<html>
<meta http-equiv='refresh' content='2;url=board_manager.jsp>'>
<body>
<p>&nbsp;</p>
<table width="75%" border="1" align="center" cellpadding="5" cellspacing="0">
  <tr>
    <td bgcolor="e9e9e9">系统提示：</td>
  </tr>
  <tr>
    <td><font size=2 color=blue>操作已成功，正在处理您的提交信息，稍后自动返回。</td>
  </tr>
</table>
</body>
</html>