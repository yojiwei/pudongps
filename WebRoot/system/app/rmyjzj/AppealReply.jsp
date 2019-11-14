<%@include file="../skin/import.jsp"%>
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

  String strStatus = "3";//投诉完成
  dImpl.edit("tb_connwork","cw_id",cw_id);
  dImpl.setValue("cw_status",CTools.dealNumber(strStatus),CDataImpl.INT);//投诉状态
  dImpl.setValue("cw_finishtime",FinishTime,CDataImpl.DATE); //处理完成时间
  dImpl.update();

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
  response.sendRedirect("AppealList.jsp?cw_status=3");
%>