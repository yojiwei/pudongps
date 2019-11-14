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
//update by yo 20090608

CDataCn dCn=null;   //新建数据库连接对象
CDataImpl dImpl=null;  //新建数据接口对象
Blob blob = null;
try {
 dCn = new CDataCn(); 
 dImpl = new CDataImpl(dCn); 
 String pa_id = CTools.dealString(request.getParameter("wa_id")).trim();
 String filePath = Messages.getString("filepath");
 String sqlStr = "";
 String zipFile = "";
 String pa_path = "";
 String path = dImpl.getInitParameter("prAttach_save_path");

 int zipCnt = -1;
 int fileCnt = -1;
 
 if (!pa_id.equals(""))
 {
 	
	sqlStr = "select wa_id,pa_name,wa_path,wa_filename,wa_im_name,wa_content from tb_workattach where wa_id='"+pa_id+"'";
	 
	 Hashtable content = dImpl.getDataInfo(sqlStr);
	 if (content!=null)
	 {
	 	 zipFile = CTools.dealNull(content.get("wa_im_name").toString());
		 zipCnt = zipFile.lastIndexOf("\\\\");
		 if(zipCnt != -1)
		 	zipFile = zipFile.substring(zipCnt+2);
			
		 pa_path = CTools.dealString(content.get("wa_path").toString());
		 fileCnt = pa_path.lastIndexOf("\\\\");
		 if(fileCnt != -1)
		 	pa_path = pa_path.substring(fileCnt+2,pa_path.length()-1);
			
		 filePath += pa_path;
		 java.io.File newDir = new java.io.File(path+pa_path);
	    if(!newDir.exists())
	    {
	         newDir.mkdirs();
	    }
	 }
	
 }
 dImpl.closeStmt();
 dCn.closeCn();

	String http = "http://" + request.getServerName() + ":" + request.getServerPort() + "/attach/workattach2007/";
	String fileurl=http+pa_path+"/"+zipFile;
	//java.net.URLEncoder.encode(zipFile,"gb2312");
	String filepath="/attach/prattach/"+pa_path+"/"+zipFile;
	//out.println(fileurl);if(true)return;
	
	response.setContentType("application/download");
	response.setHeader("Content-Disposition","attachment; filename="+zipFile);
	response.sendRedirect(fileurl);
	%>
	<!--script>location.href="<%=fileurl%>";</script-->
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