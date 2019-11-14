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
//update 20091119 yo

CDataCn dCn=null;   //新建数据库连接对象
CDataImpl dImpl=null;  //新建数据接口对象
Hashtable content = null;
try {
 dCn = new CDataCn(); 
 dImpl = new CDataImpl(dCn); 
 String aa_id = CTools.dealString(request.getParameter("da_id")).trim();
 String filePath = Messages.getString("filepath");
 String sqlStr = "";
 String zipFile = "";
 String pa_path = "";
 String path = dImpl.getInitParameter("workattach_http_path");

 int zipCnt = -1;
 int fileCnt = -1;
 
 if (!aa_id.equals(""))
 {
 	
	sqlStr = "select da_id,da_imgpath,da_imgname from tb_daxxattach where da_id='"+aa_id+"'";
	 
	 content = dImpl.getDataInfo(sqlStr);
	 if (content!=null)
	 {
	 	 zipFile = CTools.dealNull(content.get("da_imgname").toString());
		 zipCnt = zipFile.lastIndexOf("\\\\");
		 if(zipCnt != -1)
		 	zipFile = zipFile.substring(zipCnt+2);
			
		 pa_path = CTools.dealString(content.get("da_imgpath").toString());
		 fileCnt = pa_path.lastIndexOf("\\\\");
		 if(fileCnt != -1)
		 	pa_path = pa_path.substring(fileCnt+2,pa_path.length()-1);
			
		 filePath += pa_path;
		 //out.println(path+"---"+pa_path+"---"+zipFile);if(true)return;
	 }
 }
 dImpl.closeStmt();
 dCn.closeCn();

	String http = "http://" + request.getServerName() + ":" + request.getServerPort() + path;
	String fileurl=http+pa_path+"/"+zipFile;   
	
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