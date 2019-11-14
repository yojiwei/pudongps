<%@page contentType="text/html; charset=GBK"%>
<%@include file="/system/app/skin/import.jsp"%>
<%
  java.util.Date FinishTime = new java.util.Date();

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
  dImpl.setValue("cw_finishtime",FinishTime.toLocaleString(),CDataImpl.DATE); //处理完成时间
  dImpl.setValue("cw_trans_id","",CDataImpl.STRING);//清空转办部门ID
  dImpl.update();
  dImpl.setClobValue("cw_feedback",CTools.dealString(request.getParameter("strFeedback")));//信件反馈
  
  

  String sql="select cp_id from tb_connwork where cw_parentid = '"+cw_id+"'";
  Hashtable content = dImpl.getDataInfo(sql);
	if(content!=null)
	{
		String sql_del = "delete from tb_connwork where cw_parentid = '"+cw_id+"'";
		content = dImpl.getDataInfo(sql_del);
	}

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