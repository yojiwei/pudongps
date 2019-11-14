<%@include file="/system/app/skin/import.jsp"%>
<%
 // java.util.Date FinishTime = new java.util.Date();
  String FinishTime = CDate.getNowTime();

  String cw_id = request.getParameter("cw_id").toString();
  String cw_typecode = request.getParameter("classtype").toString();
  //String strFeedback = request.getParameter("strFeedback").toString();
  //out.print(cw_typecode);
//update20080122

CDataCn dCn=null;   
CDataImpl dImpl=null;  

try {
 dCn = new CDataCn(); 
 dImpl = new CDataImpl(dCn); 


  dImpl.edit("tb_connwork","cw_id",cw_id);
  dImpl.setValue("cw_status","2",CDataImpl.INT);//投诉状态
  dImpl.setValue("cw_typecode ",cw_typecode,CDataImpl.STRING); //投诉分类
  dImpl.update();


} catch (Exception ex) {
	System.out.println(new java.util.Date() + "--"
			+ request.getServletPath() + " : " + ex.getMessage());
} finally {
	if(dImpl != null)
	dImpl.closeStmt();
	if(dCn != null)
	dCn.closeCn();
  response.sendRedirect("AppealList.jsp?cw_status=2");
%>