<%//@page contentType="APPLICATION/OCTET-STREAM; charset=gb2312"%>
<%@ page contentType="text/html; charset=GBK" %>
<%@page buffer="32kb" autoFlush="true" %>
<%@ page import="java.net.URLEncoder" %>
<%@include file="/website/include/import.jsp"%>
<%
//Update 20061231
CDataCn dCn = null;
CDataImpl dImpl = null;
try{
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

 response.reset();
 
 response.setContentType("application/download");
 response.setHeader("Content-Disposition","attachment;filename=" + URLEncoder.encode(fileName,"utf-8"));
 
 String http = "http://" + request.getServerName() + ":" + request.getServerPort() + "/attach/workattach2007/";
 response.sendRedirect(http + if_path + "/" + URLEncoder.encode(zipFile,"utf-8"));
 
 /**************
 javax.servlet.ServletOutputStream stream = response.getOutputStream();
 BufferedInputStream fif = new BufferedInputStream(new FileInputStream(new File(filePath + "\\\\"+ new String(zipFile.getBytes("utf-8")))));
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
