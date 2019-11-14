<%//@page contentType="APPLICATION/OCTET-STREAM; charset=gb2312"%>
<%@ page contentType="text/html; charset=GBK" %>
<%@page buffer="32kb" autoFlush="true" %>
<%@include file="/website/include/import.jsp"%>
<%@page import="java.net.URLEncoder"%>
<%
//Update 20061231
CDataCn dCn = null;
CDataImpl dImpl = null;
try{
dCn = new CDataCn();
dImpl = new CDataImpl(dCn); 

String aa_id = CTools.dealString(request.getParameter("aa_id")).trim();
String sqlStr = "";
String zipFile = "";
String rdName = "";
String aa_path = "";

if (!aa_id.equals(""))
{
	sqlStr = "select aa_filename,aa_path,aa_im_name from tb_appealattach where aa_id = '"+aa_id+"'";
	Hashtable content = dImpl.getDataInfo(sqlStr);
	if (content!=null)
	{
		zipFile = content.get("aa_filename").toString();
		aa_path = content.get("aa_path").toString();
		rdName = content.get("aa_im_name").toString();
	}
}

/*
try {	
		CDate date = new CDate();
		String stPath = config.getServletContext().getRealPath("/");
		String stFile = stPath + "\\IP_Log\\IP_"+date.getThisday()+".txt";

		File file= new File(stFile);
		if(!file.exists()){
			file.createNewFile();					
		}
		RandomAccessFile rf =new RandomAccessFile(file, "rw");
		long rflengt=rf.length();
		rf.seek(rflengt);
		String a = "\r\n"+date.getNowTime()+" IP="+request.getRemoteAddr()+" File=/attach/workattach2007/"+aa_path+"/"+zipFile;
		byte[] by =a.getBytes();
		rf.write(by);
		rf.close();
		
} catch (IOException e) {
	e.printStackTrace();
}
*/
		
String localIP = request.getServerName();
int localPort = request.getServerPort();
String http = "http://"+localIP+":"+localPort+"/attach/workattach2007/"+aa_path+"/";

response.setContentType("application/download");
response.setHeader("Content-Disposition","attachment;filename=" + URLEncoder.encode(zipFile,"utf-8"));
response.sendRedirect(http + URLEncoder.encode(rdName,"utf-8"));

}
catch(Exception e){
out.print(e.toString());
}
finally{
dImpl.closeStmt();
dCn.closeCn(); 
}

%>