<%@page contentType="text/html; charset=GBK"%>
<%@page buffer="32kb" autoFlush="true" %>
<%@page import="com.component.database.*"%>
<%@ page import="java.util.Hashtable" %>
<%@page import="com.util.*" %>
<%
//update20080122

CDataCn dCn=null;   //新建数据库连接对象
CDataImpl dImpl=null;  //新建数据接口对象
	String bi_path = "";
	String bi_filename = "";
	String bi_radomname = "";
	String http = "";
try {
 dCn = new CDataCn(); 
 dImpl = new CDataImpl(dCn); 

	String bi_id = CTools.dealString(request.getParameter("bi_id")).trim();

	 http = "http://" + request.getServerName() + ":" + request.getServerPort() + "/" + "attach/bbs/";
	
	String sqlStr = "select bi_path,bi_filename,bi_radomname from tb_bimage where bi_tablename = 'forum_post' and bi_id = " + bi_id; 
	
	Hashtable content = dImpl.getDataInfo(sqlStr);
	if (content != null) {
		bi_path = content.get("bi_path").toString();
		bi_filename = content.get("bi_filename").toString();
		bi_radomname = content.get("bi_radomname").toString();
	}
	} catch (Exception ex) {
	System.out.println(new java.util.Date() + "--"
			+ request.getServletPath() + " : " + ex.getMessage());
} finally {
	if(dImpl != null)
	dImpl.closeStmt();
	if(dCn != null)
	dCn.closeCn();
}
	
	response.setContentType("application/download");
	response.setHeader("Content-Disposition","attachment;filename=" + bi_filename);
	response.sendRedirect(http + bi_path + "/" + java.net.URLEncoder.encode(bi_radomname,"ISO8859_1"));
	
%>





