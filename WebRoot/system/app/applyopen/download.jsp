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
String fid = CTools.dealString(request.getParameter("fid")).trim();
String filePath = dImpl.getInitParameter("prattach_save_path");
String sqlStr = "";
String fname = "";
String fpath = "";

if (!fid.equals(""))
{
	sqlStr = "select filename, filepath from accessories where id='"+fid+"'";
	Hashtable content = dImpl.getDataInfo(sqlStr);
	if (content!=null)
	{
		fname = content.get("filename").toString();
		fpath = content.get("filepath").toString();
		filePath += fpath;
	}
}



try {

			
			CDate date = new CDate();
			
			//String stPath  ="E:\\bea\\user_projects\\pdapp\\applications\\DefaultWebApp";
			String stPath = getServletConfig().getServletContext().getRealPath("/");

				String stFile = stPath + "IP_Log\\IP_"+date.getThisday()+".txt";
	
				java.io.File file = new java.io.File(stFile);
				if(!file.exists()) {
					file.createNewFile();					
				}
				/*
				String flPath = filePath + "\\\\" + zipFile;
				java.io.File file = new java.io.File(flPath);
				if(!file.exists()) {
				  file.mkdirs();
				}
				*/
				RandomAccessFile rf = new RandomAccessFile(file, "rw");
				long rflengt=rf.length();
				rf.seek(rflengt);
			String a = "\r\n"+date.getNowTime()+" IP="+request.getRemoteAddr()+" File=/attach/infoattach/"+fpath+"/"+fname;
		
			byte[] by =a.getBytes();
			rf.write(by);
			rf.close();
		} catch (IOException e) {
			e.printStackTrace();
		}

String localIP = request.getServerName();
int localPort = request.getServerPort();
String http = "http://"+localIP+":"+localPort+"/attach/infoattach/"+fpath+"/";


response.setContentType("application/download");

response.setHeader("Content-Disposition","attachment;filename=" + fname);

response.sendRedirect(http + java.net.URLEncoder.encode(fname,"UTF-8"));


}
catch(Exception e){
//e.printStackTrace();
out.print(e.toString());
}
finally{
dImpl.closeStmt();
dCn.closeCn(); 
}
%>