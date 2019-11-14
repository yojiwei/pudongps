<%@page contentType="text/html; charset=GBK"%>
<%@page buffer="32kb" autoFlush="true" %>
<%@page import="java.sql.*"%>
<%@page import="java.io.*"%>
<%@page import="java.util.*"%>
<%@page import="com.component.database.*"%>
<%@page import="com.util.*"%>
<%@ page import="com.app.CMySelf" %>
<%@page import="java.io.*"%>
<%@ page import="com.jspsmart.upload.*" %>
<%@ page import="com.beyondbit.web.publishinfo.Messages" %>
<%
//update20081029

CDataCn dCn=null;   //新建数据库连接对象
CDataImpl dImpl=null;  //新建数据接口对象
Blob blob = null;
try {
 dCn = new CDataCn(); 
 dImpl = new CDataImpl(dCn); 
 String pa_id = CTools.dealString(request.getParameter("pa_id")).trim();
 String filePath = Messages.getString("filepath");
 String sqlStr = "";
 String zipFile = "";
 String pa_path = "";
 String path = dImpl.getInitParameter("prAttach_save_path");

 int zipCnt = -1;
 int fileCnt = -1;
 
 if (!pa_id.equals(""))
 {
 	
	sqlStr = "select v_dtid,v_docname,v_docpath from hss_downtable where v_dtid ='"+pa_id+"'";
	 Hashtable content = dImpl.getDataInfo(sqlStr);
	 if (content!=null)
	 {
	 	 pa_path = CTools.dealString(content.get("v_docpath").toString());
	 }
	
 }
 dImpl.closeStmt();
 dCn.closeCn();

	
	String http = "http://" + request.getServerName() + ":" + request.getServerPort() + "/attach/prattach/";
	String fileurl=http+pa_path;
	System.out.println(fileurl);
	//java.net.URLEncoder.encode(zipFile,"gb2312");
	//response.setContentType("application/download");
	//response.setHeader("Content-Disposition","attachment; filename="+zipFile);
	//response.sendRedirect(fileurl);
	%>
	<script>location.href="<%=fileurl%>";</script>
	<%
		if(true)return;

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