<%@ page contentType="text/html; charset=GBK" %>
<%@include file="../skin/import.jsp"%>
<%
	String postId = CTools.dealString(request.getParameter("Returnid"));
	String fid = CTools.dealString(request.getParameter("fid"));
	
//update20080122

CDataCn dCn=null;   //新建数据库连接对象
CDataImpl dImpl=null;  //新建数据接口对象

try {
 dCn = new CDataCn(); 
 dImpl = new CDataImpl(dCn); 

	Connection con = dCn.getConnection();
    Statement stmt = con.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_READ_ONLY);
  
    String sql = "update forum_post set post_reply_id = -1 where post_id = " + postId;
    
    stmt.executeUpdate(sql);
        
    response.sendRedirect("board.jsp?fid=" + fid);
    
%>




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