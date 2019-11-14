<%@include file="../skin/import.jsp"%>
<%
  //java.util.Date ApplyTime = new java.util.Date();
  String applytime = CDate.getNowTime();

  String cw_id = request.getParameter("cw_id").toString();

  //update20080122

CDataCn dCn=null;   //
CDataImpl dImpl=null;  //

try {
 dCn = new CDataCn(); 
 dImpl = new CDataImpl(dCn); 

  String strStatus = "2";//投诉处理中
  dImpl.edit("tb_connwork","cw_id",cw_id);
  dImpl.setValue("cw_status",CTools.dealNumber(strStatus),CDataImpl.INT);//投诉状态
  //dImpl.setValue("cw_applytime",applytime,CDataImpl.DATE); //发送时间
  dImpl.update();

  dImpl.closeStmt();
  dCn.closeCn();
  response.sendRedirect("AppealInfo.jsp?cw_id="+cw_id+"&cw_status=2");
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