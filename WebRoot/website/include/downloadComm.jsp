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
String cm_id = CTools.dealString(request.getParameter("cm_id")).trim();
String sqlStr = "";
String zipFile = "";
String rdName = "";
String aa_path = "";
String a = "" ;
if (!"".equals(cm_id))
{
	sqlStr = "select cm_filename,cm_path,cm_name from tb_commentattach where cm_id = '"+cm_id+"'";
	Hashtable content = dImpl.getDataInfo(sqlStr);
	if (content!=null)
	{
		zipFile = content.get("cm_name").toString();
		aa_path = content.get("cm_path").toString();
		rdName = content.get("cm_filename").toString();
	}
	//System.out.println("path:" + filePath + zipFile);
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
			 a = "\r\n"+date.getNowTime()+" IP="+request.getRemoteAddr()+" File=/attach/commentattach/"+aa_path+"/"+zipFile;
			byte[] by =a.getBytes();
			rf.write(by);
			rf.close();
		} catch (IOException e) {
			e.printStackTrace();
		}
		String http = "";
String localIP = request.getServerName();
int localPort = request.getServerPort();
 http = "http://"+localIP+":"+localPort+"/attach/commentattach/"+aa_path+"/";
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