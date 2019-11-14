<%//@page contentType="APPLICATION/OCTET-STREAM; charset=gb2312"%>
<%@ page contentType="text/html; charset=GBK" %>
<%//@page buffer="32kb" autoFlush="true" %>
<%@include file="/website/include/import.jsp"%>
<%@page import="java.io.*"%>
<%@page import="java.util.*"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="com.component.database.*"%>
<%@page import="com.util.*"%>
<%
//Update 20061231
CDataCn dCn = null;
CDataImpl dImpl = null;
try{
dCn = new CDataCn();
dImpl = new CDataImpl(dCn); 
String pa_id = CTools.dealString(request.getParameter("pa_id")).trim();
String filePath = dImpl.getInitParameter("prattach_save_path");
String sqlStr = "";
String zipFile = "";
String pa_path = "";

if (!pa_id.equals(""))
{
	sqlStr = "select pa_filename, pa_path from tb_proceedingattach where pa_id='"+pa_id+"'";
	Hashtable content = dImpl.getDataInfo(sqlStr);
	if (content!=null)
	{
		zipFile = content.get("pa_filename").toString();
		pa_path = content.get("pa_path").toString();
		filePath += pa_path;
	}
}
/*
try {
			CDate date = new CDate();
			String stPath = config.getServletContext().getRealPath("/");
			String stFile = stPath + "IP_Log\\IP_"+date.getThisday()+".txt";
	
			java.io.File file = new java.io.File(stFile);
			if(!file.exists()) {
				file.createNewFile();					
			}
			RandomAccessFile rf = new RandomAccessFile(file, "rw");
			long rflengt=rf.length();
			rf.seek(rflengt);
			String a = "\r\n"+date.getNowTime()+" IP="+request.getRemoteAddr()+" File=/attach/prattach/"+pa_path+"/"+zipFile;
		
			byte[] by =a.getBytes();
			rf.write(by);
			rf.close();
} catch (IOException e) {
	e.printStackTrace();
}
*/
String localIP = request.getServerName();
int localPort = request.getServerPort();
String http = "http://"+localIP+":"+localPort+"/attach/prattach/"+pa_path+"/";

response.setContentType("application/download");

response.setHeader("Content-Disposition","attachment;filename=" + zipFile);

response.sendRedirect(http + java.net.URLEncoder.encode(zipFile,"UTF-8"));


}
catch(Exception e){
out.print(e.toString());
}
finally{
dImpl.closeStmt();
dCn.closeCn(); 
}
%>