<%@page contentType="text/html; charset=GBK"%>
<%@page buffer="32kb" autoFlush="true" %>
<%@include file="/website/include/import.jsp"%>
<%@page import="java.io.*"%>
<%@ page import="java.net.URLEncoder" %>
<%

//update20080122

CDataCn dCn=null;   //新建数据库连接对象
CDataImpl dImpl=null;  //新建数据接口对象

try {
 dCn = new CDataCn(); 
 dImpl = new CDataImpl(dCn); 
 String if_id = CTools.dealString(request.getParameter("if_id")).trim();
 String filePath = dImpl.getInitParameter("workattach_save_path");
 String sqlStr = "";
 String zipFile = "";
 String fileName = "";
 String if_path = "";
 if (!if_id.equals(""))
 {
	 sqlStr = "select if_name,if_path,if_nick_name from tb_infoFile where if_id = '"+if_id+"'";
	 Hashtable content = dImpl.getDataInfo(sqlStr);
	 if (content!=null)
	 {
	 	 fileName = content.get("if_nick_name").toString();
		 zipFile = content.get("if_name").toString();
		 if_path = content.get("if_path").toString();
		 filePath += if_path;
	 }
 }
 dImpl.closeStmt();
 dCn.closeCn();

 response.reset();
 
 response.setContentType("application/download");
 response.setHeader("Content-Disposition","attachment;filename=" + URLEncoder.encode(fileName,"utf-8"));
 
 String http = "http://" + request.getServerName() + ":" + request.getServerPort() + "/attach/workattach2007/";
 response.sendRedirect(http + if_path + "/" + URLEncoder.encode(zipFile,"utf-8"));
 
 
 
/*************************************
 CDataCn dCn = new CDataCn();
 CDataImpl dImpl = new CDataImpl(dCn);
 String if_id = CTools.dealString(request.getParameter("if_id")).trim();
 String filePath = dImpl.getInitParameter("workattach_save_path");
 String sqlStr = "";
 String zipFile = "";
 String if_path = "";
 if (!if_id.equals(""))
 {
	 sqlStr = "select if_name, if_path from tb_infoFile where if_id='"+if_id+"'";
	 Hashtable content = dImpl.getDataInfo(sqlStr);
	 if (content!=null)
	 {
		 zipFile = content.get("if_name").toString();
		 if_path = content.get("if_path").toString();
		 filePath += if_path;
	 }
	//System.out.println("path:" + filePath + zipFile);
 }
 dImpl.closeStmt();
 dCn.closeCn();
 response.reset();
 response.setContentType("application/download");

 response.setHeader("Content-Disposition","attachment;filename=" + new String(zipFile.getBytes("GBK"), "ISO8859_1"));

 javax.servlet.ServletOutputStream stream = response.getOutputStream();
// out.println(filePath + new String(zipFile.getBytes("GBK")));

 BufferedInputStream fif = new BufferedInputStream(new FileInputStream(new File(filePath + "\\\\"+ new String(zipFile.getBytes("GBK")))));
 // byte[] bt = new com.util.test().getByteArray(filePath + "\\\\"+ new String(zipFile.getBytes("GBK")));
//byte[] bt = new com.util.test().getByteArray(pa_id);

 byte[] data = new byte[1000];
 int li_size;
 while((li_size = fif.read(data))!= -1)
 {	stream.write(data,0,li_size);
 }

 stream.flush();
 fif.close();

 //stream.write(bt);
 stream.close();
*******************************************/
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