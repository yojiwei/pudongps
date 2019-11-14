<%@page contentType="text/html; charset=GBK"%>
<%@include file="/system/app/skin/import.jsp"%>
<%@page import="com.util.CMessage"%>
<%
 // java.util.Date FinishTime = new java.util.Date();
  String FinishTime = CDate.getNowTime();

  //update20080122

CDataCn dCn=null;   //新建数据库连接对象
CDataImpl dImpl=null;  //新建数据接口对象

try {
 dCn = new CDataCn(); 
 dImpl = new CDataImpl(dCn); 
  
  String st_id = CTools.dealString(request.getParameter("st_id")).trim();
  String st_status = CTools.dealString(request.getParameter("st_status")).trim();					//投诉状态，１：待处理信件；２，处理中信件；３．已处理信件
  String st_reontent = CTools.dealString(request.getParameter("st_recontent")).trim();
  
  dImpl.edit("tb_suggestmail","st_id",st_id);//
  dImpl.setValue("st_restatus",CTools.dealNumber(st_status),CDataImpl.INT);//投诉状态
  dImpl.setValue("st_redate",FinishTime,CDataImpl.DATE); //处理完成时间
  dImpl.setValue("st_recontent",st_reontent,CDataImpl.STRING); //处理完成时间
  dImpl.update();
  
  dImpl.closeStmt();
  dCn.closeCn();
  out.println("<script language='javascript'>location.href='AppealList.jsp?st_status=" + st_status + "'</script>");
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
