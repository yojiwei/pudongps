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

String aa_id = CTools.dealString(request.getParameter("ia_id")).trim();
String sqlStr = "";
String zipFile = "";
String rdName = "";
String aa_path = "";

if (!aa_id.equals(""))
{
	sqlStr = "select va_id,va_realname,va_path,va_filename from tb_voteattach where va_id= '"+aa_id+"'";
	out.print(sqlStr);
	Hashtable content = dImpl.getDataInfo(sqlStr);
	if (content!=null)
	{
		zipFile = content.get("va_filename").toString();
		aa_path = content.get("va_path").toString();
		rdName = content.get("va_realname").toString();
	}
	
}



try {	
			CDate date = new CDate();
			
			//String stPath  =request.getRealPath(".");
			//String stPath  ="E:\\bea\\user_projects\\webdomain\\applications\\DefaultWebApp";
			String stPath = getServletConfig().getServletContext().getRealPath("/");
			//System.out.println(stPath);

			String stFile = stPath + "\\IP_Log\\IP_"+date.getThisday()+".txt";

			File file= new File(stFile);
				if(!file.exists()){
					file.createNewFile();					
				}
			RandomAccessFile rf =new RandomAccessFile(file, "rw");
			long rflengt=rf.length();
			rf.seek(rflengt);
			String a = "\r\n"+date.getNowTime()+" IP="+request.getRemoteAddr()+" File=/attach/infoattach/"+aa_path+"/"+rdName;
			byte[] by =a.getBytes();
			rf.write(by);
			rf.close();
		} catch (IOException e) {
			e.printStackTrace();
		}
String localIP = request.getServerName();
int localPort = request.getServerPort();
String http = "http://"+localIP+":"+localPort+"/attach/infoattach/"+aa_path+"/";

response.setContentType("application/download");
response.setHeader("Content-Disposition","attachment;filename=" + URLEncoder.encode(rdName,"utf-8"));
//out.print(http + URLEncoder.encode(rdName,"utf-8"));

response.sendRedirect(http + URLEncoder.encode(rdName,"utf-8"));

/*
 javax.servlet.ServletOutputStream stream = response.getOutputStream();
 BufferedInputStream fif = new BufferedInputStream(new FileInputStream(new File(request.getRealPath("/") + "attach/workattach2007" + "\\" + aa_path + "\\" + new String(rdName.getBytes("utf-8")))));
 byte[] data = new byte[1000];
 int li_size;
 while((li_size = fif.read(data))!= -1)
 {	
     stream.write(data,0,li_size);
 }
 fif.close(); 
 stream.flush();
 
 */


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