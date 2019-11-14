<%@ page contentType="text/html; charset=GBK" %>
<%@include file="../skin/import.jsp"%>
<%
	String postId = CTools.dealString(request.getParameter("Returnid"));
	String fid = CTools.dealString(request.getParameter("fid"));
	String replyId = CTools.dealString(request.getParameter("replyId"));
	String checkDel = CTools.dealString(request.getParameter("checkDel"));	
    CDataCn dCn = null;
    try{
    dCn = new CDataCn();
    Connection con = dCn.getConnection();
    Statement stmt = con.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_READ_ONLY);
  
    String sql = "delete from forum_post where post_id = " + replyId;
    stmt.executeUpdate(sql);
          
    //response.sendRedirect("shownote.jsp?fid=" + fid + "&noteid=" + postId + "&checkDel=" + checkDel);
    //更新话题回复数
    sql="update forum_post set post_reply_count=(select count(*)as count from forum_post where post_reply_id='"+postId+"') where post_id='"+postId+"'";
    stmt.executeUpdate(sql);
    
%>
<script>
	alert("删除成功！");
	location.href = "shownote.jsp?fid=<%=fid%>&noteid=<%=postId%>&checkDel=<%=checkDel%>";
</script>
<%


} catch (Exception ex) {
	System.out.println(new java.util.Date() + "--"
			+ request.getServletPath() + " : " + ex.getMessage());
} finally {

	if(dCn != null)
	dCn.closeCn();
}

%>