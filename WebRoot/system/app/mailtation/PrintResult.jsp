<%@include file="../skin/import.jsp"%>
<%
  //java.util.Date ApplyTime = new java.util.Date();
  String ApplyTime = CDate.getNowTime();

  String cw_id = request.getParameter("cw_id").toString();

  //update20080122

CDataCn dCn=null;   //
CDataImpl dImpl=null;  //

try {
 dCn = new CDataCn(); 
 dImpl = new CDataImpl(dCn); 

  String strStatus = "2";//投诉处理中
  String strSql = "select cw_id from tb_connwork where cw_id = '"+cw_id+"' and cw_status = 2";	
  out.println(strSql);
  Hashtable content_deal = dImpl.getDataInfo(strSql);
  if(content_deal==null){

  dImpl.edit("tb_connwork","cw_id",cw_id);
  dImpl.setValue("cw_status",CTools.dealNumber(strStatus),CDataImpl.INT);//投诉状态
  dImpl.setValue("cw_managetime",ApplyTime,CDataImpl.DATE); //开始处理时间
  dImpl.setValue("cw_finishtime",ApplyTime,CDataImpl.DATE); //开始处理时间
  //dImpl.setValue("cw_applytime",ApplyTime,CDataImpl.DATE); //发送时间
  dImpl.update();

  }
  dImpl.closeStmt();
  dCn.closeCn();
  response.sendRedirect("AppealList.jsp?cw_status=2");
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