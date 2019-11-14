<%@ page contentType="text/html; charset=GBK" %>
<%@include file="../skin/import.jsp"%>
<%
	String postId = CTools.dealString(request.getParameter("Returnid"));
	String fid = CTools.dealString(request.getParameter("fid"));
	
    CDataCn dCn = null;
    try{
     dCn = new CDataCn();
	Connection con = dCn.getConnection();
    Statement stmt = con.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_READ_ONLY);
  
    String sql = "update forum_post set post_reply_id = -1 where post_id = " + postId;
    
    stmt.executeUpdate(sql);



} catch (Exception ex) {
	System.out.println(new java.util.Date() + "--"
			+ request.getServletPath() + " : " + ex.getMessage());
} finally {

	if(dCn != null)
	dCn.closeCn();
}


    
        
    response.sendRedirect("board_smzx.jsp?fid=" + fid);
    
%>