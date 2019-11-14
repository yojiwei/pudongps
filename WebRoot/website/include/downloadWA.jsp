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

String aa_id = CTools.dealString(request.getParameter("wa_id")).trim();
String sqlStr = "";
String zipFile = "";
String rdName = "";
String fileName = "";
String aa_path = "";

if (!aa_id.equals(""))
{
	sqlStr = "select wa_filename,wa_path,wa_im_name,pa_name from tb_workattach where wa_id = '"+aa_id+"'";
	Hashtable content = dImpl.getDataInfo(sqlStr);
	if (content!=null)
	{
		zipFile = content.get("wa_filename").toString();
		aa_path = content.get("wa_path").toString();
		rdName = content.get("wa_im_name").toString();
		fileName = content.get("pa_name").toString();
	}
	//System.out.println("path:" + filePath + zipFile);
}

/*******************
try {	
			CDate date = new CDate();
			
			//String stPath  =request.getRealPath(".");
			//String stPath  ="E:\\bea\\user_projects\\webdomain\\applications\\DefaultWebApp";
			String stPath = getServletContext().getRealPath("/");
			//System.out.println(stPath);

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
********************/
String localIP = request.getServerName();
int localPort = request.getServerPort();
String http = "http://"+localIP+":"+localPort+"/attach/workattach2007/"+aa_path+"/";

response.setContentType("application/download");
response.setHeader("Content-Disposition","attachment;filename=" + URLEncoder.encode(fileName,"utf-8"));
response.sendRedirect(http + URLEncoder.encode(rdName,"utf-8"));

/**************
 javax.servlet.ServletOutputStream stream = response.getOutputStream();
 BufferedInputStream fif = new BufferedInputStream(new FileInputStream(new File(request.getRealPath("/") + "attach/workattach2007" + "\\" + aa_path + "\\" + new String(rdName.getBytes("utf-8")))));
 byte[] data = new byte[1000];
 int li_size;
 while((li_size = fif.read(data))!= -1)
 {	
     stream.write(data,0,li_size);
 }

 stream.flush();
 fif.close(); 
 ****************/
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