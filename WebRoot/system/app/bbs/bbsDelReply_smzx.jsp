<%@ page contentType="text/html; charset=GBK" %>
<%@include file="../skin/import.jsp"%>
<%
	String postId = CTools.dealString(request.getParameter("Returnid"));
	String fid = CTools.dealString(request.getParameter("fid"));
	String replyId = CTools.dealString(request.getParameter("replyId"));
	String checkDel = CTools.dealString(request.getParameter("checkDel"));	
	String page1 = CTools.dealString(request.getParameter("page"));
	
    CDataCn dCn = null;
    try{
    dCn = new CDataCn();
    Connection con = dCn.getConnection();
    Statement stmt = con.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_READ_ONLY);
  
    String sql = "delete from forum_post where post_id = " + replyId;
    stmt.executeUpdate(sql);
          
    //response.sendRedirect("shownote.jsp?fid=" + fid + "&noteid=" + postId + "&checkDel=" + checkDel);
    
%>
<script>
	alert("??");
	location.href = "shownote_smzx.jsp?fid=<%=fid%>&noteid=<%=postId%>&checkDel=<%=checkDel%>&page=<%=page1%>";
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