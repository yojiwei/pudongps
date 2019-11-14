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
//update20080122

CDataCn dCn=null;   //新建数据库连接对象
CDataImpl dImpl=null;  //新建数据接口对象

try {
 dCn = new CDataCn(); 
 dImpl = new CDataImpl(dCn); 
 String pa_id = CTools.dealString(request.getParameter("ia_id")).trim();
 String filePath = Messages.getString("filepath");
 String sqlStr = "";
 String zipFile = "";
 String pa_path = "";
 int zipCnt = -1;
 int fileCnt = -1;
 if (!pa_id.equals(""))
 {
	 sqlStr = "select im_filename,im_path from tb_image where im_id='"+pa_id+"'"; 
	 
	 
	 Hashtable content = dImpl.getDataInfo(sqlStr);
	 if (content!=null)
	 {
		 zipFile = CTools.dealString(content.get("im_filename").toString());
		 zipCnt = zipFile.lastIndexOf("\\\\");
		 if(zipCnt != -1)
		 	zipFile = zipFile.substring(zipCnt+2);
		 
		 //System.out.println(new String(zipFile.getBytes("GBK")));
		 pa_path = content.get("im_path").toString();
		 fileCnt = pa_path.lastIndexOf("\\\\");
		 if(fileCnt != -1)
		 	pa_path = pa_path.substring(fileCnt+2,pa_path.length()-1);
		 	//out.print("-----------------------------------" + pa_path);
		 
		 //if(true)return;
		 filePath += pa_path;

	 }
	 
 }
//out.println(sqlStr);
 dImpl.closeStmt();
 dCn.closeCn();

 //response.setContentType("application/download");

// response.setHeader("Content-Disposition","attachment;filename=" + new String(zipFile.getBytes("GBK"), "ISO8859_1"));

 //javax.servlet.ServletOutputStream stream = response.getOutputStream();
// out.println(filePath + new String(zipFile.getBytes("GBK")));

 //BufferedInputStream fif = new BufferedInputStream(new FileInputStream(new File(filePath + "\\\\"+ new String(zipFile.getBytes("GBK")))));
 // byte[] bt = new com.util.test().getByteArray(filePath + "\\\\"+ new String(zipFile.getBytes("GBK")));
//byte[] bt = new com.util.test().getByteArray(pa_id);

 //byte[] data = new byte[1000];
 //int li_size;
 //while((li_size = fif.read(data))!= -1)
 //{	stream.write(data,0,li_size);
 //}

 //stream.flush();
 //fif.close();
	
	String http = "http://" + request.getServerName() + ":" + request.getServerPort() + "/attach/infoattach/";
	String fileurl=http+pa_path+"/"+java.net.URLEncoder.encode(zipFile,"ISO8859_1");
	String filepath="/attach/infoattach/"+pa_path+"/"+java.net.URLEncoder.encode(zipFile,"ISO8859_1");

	filepath="F:\\DefaultWebApp"+CTools.replace(filepath,"/","\\");
	//E:\\bea\\user_projects\\webdomain\\applications\\DefaultWebApp
//System.out.println(filepath);


	response.setContentType("application/download");
	response.setHeader("Content-Disposition","attachment;filename=" + zipFile);
	response.sendRedirect(fileurl);


	//SmartUpload su=new SmartUpload();
	//su.initialize(pageContext);
	//su.downloadFile(filepath);


	//response.sendRedirect(Messages.getString("httpfilepatn")+pa_path+"/"+java.net.URLEncoder.encode(zipFile,"ISO8859_1"));

 //stream.write(bt);
// stream.close();
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