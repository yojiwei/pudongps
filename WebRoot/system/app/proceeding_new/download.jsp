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
 	
	sqlStr = "select pa_id,pa_name,pa_path,pa_upload,pa_filename,pa_content from tb_proceedingattach_new where pa_id='"+pa_id+"'";
	 
	 Hashtable content = dImpl.getDataInfo(sqlStr);
	 if (content!=null)
	 {
	 	 zipFile = CTools.dealNull(content.get("pa_filename").toString());
		 zipCnt = zipFile.lastIndexOf("\\\\");
		 if(zipCnt != -1)
		 	zipFile = zipFile.substring(zipCnt+2);
			
		 pa_path = CTools.dealString(content.get("pa_path").toString());
		 fileCnt = pa_path.lastIndexOf("\\\\");
		 if(fileCnt != -1)
		 	pa_path = pa_path.substring(fileCnt+2,pa_path.length()-1);
			
		 filePath += pa_path;
		 //out.println(path+"---"+pa_path+"---"+zipFile);if(true)return;
		 java.io.File newDir = new java.io.File(path+pa_path);
	    if(!newDir.exists())
	    {
	         newDir.mkdirs();
	    }
//重新生成文件
//dImpl.getBolbValue("tb_proceedingattach_new","pa_id",pa_id,"pa_content","e:/bea/user_projects/webdomain/applications/DefaultWebApp/attach/prattach/"+pa_path+"/"+zipFile);
//e:/bea/user_projects/webdomain/applications/DefaultWebApp/attach/prattach/
//F:/DefaultWebApp/attach/infoattach/
		 
	 }
	
 }
 dImpl.closeStmt();
 dCn.closeCn();

	
	String http = "http://" + request.getServerName() + ":" + request.getServerPort() + "/attach/prattach/";
	String fileurl=http+pa_path+"/"+zipFile;//java.net.URLEncoder.encode(zipFile,"gb2312");
	String filepath="/attach/prattach/"+pa_path+"/"+zipFile;
	filepath="e:\\bea\\user_projects\\webdomain\\applications\\DefaultWebApp"+CTools.replace(filepath,"/","\\");
	//out.println(fileurl);if(true)return;

	//e:\\bea\\user_projects\\webdomain\\applications\\DefaultWebApp
	//F:\\DefaultWebApp
	
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