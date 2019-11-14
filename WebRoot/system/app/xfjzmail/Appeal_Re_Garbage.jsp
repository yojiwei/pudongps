<%@include file="/system/app/skin/import.jsp"%>
<%
  //java.util.Date FinishTime = new java.util.Date();
  String FinishTime = CDate.getNowTime();

  String cw_id = request.getParameter("cw_id").toString();


//update20080122

CDataCn dCn=null;   //
CDataImpl dImpl=null;  //

try {
 dCn = new CDataCn(); 
 dImpl = new CDataImpl(dCn); 

  dCn.beginTrans();
  String strStatus = "1";//还原回来的信件
  dImpl.edit("tb_connwork","cw_id",cw_id);
  dImpl.setValue("cw_status",CTools.dealNumber(strStatus),CDataImpl.INT);//信件状态
  dImpl.setValue("cw_finishtime",FinishTime,CDataImpl.DATE); //处理完成时间
  dImpl.update();
  dImpl.setClobValue("cw_feedback",CTools.dealString(request.getParameter("strFeedback")));//信件反馈
  
  dCn.commitTrans();
  dImpl.closeStmt();
  dCn.closeCn();
  
} catch (Exception ex) {
	System.out.println(new java.util.Date() + "--"
			+ request.getServletPath() + " : " + ex.getMessage());
} finally {
	if(dImpl != null)
	dImpl.closeStmt();
	if(dCn != null)
	dCn.closeCn();
}
  response.sendRedirect("AppealList.jsp?cw_status=1&Module=待处理信件");
%>