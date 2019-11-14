<%@ page contentType="text/html; charset=GBK"%>
<%@page import="com.util.*"%>
<%@page import="com.component.database.*,com.component.database.CDataControl"%>
<%@include file="/system/app/islogin.jsp"%>

<%

String CT_id="";

CT_id = CTools.dealString(request.getParameter("ct_id")).trim();//??id
String ct_title = CTools.dealString(request.getParameter("ctTitle"));
String sj_id = CTools.dealString(request.getParameter("sj_id"));
//update20080122

CDataCn dCn=null;   //
CDataImpl dImpl=null;  //

try {
 dCn = new CDataCn(); 
 dImpl = new CDataImpl(dCn); 
CDataControl ctrol = new CDataControl();//操作数据库的东西

try
{
	//modify for hh
	CMySelf mySelf = (CMySelf)session.getAttribute("mySelf");
    String userName = mySelf.getMyName();
    String userId = String.valueOf(mySelf.getMyUid());
    String action = "";
	if (!"".equals(userId)) action += "," + userId;
	if (!"".equals(CT_id)) action += "," + CT_id;
	com.beyondbit.web.publishinfo.LogAction lan = new com.beyondbit.web.publishinfo.LogAction();
	lan.setDelLog(userName,action,ct_title);
	//end modify
  dImpl.delete("subscibelog","id",Long.parseLong(CT_id));
  dImpl.update() ;
  String delSql="delete from tb_sms s where s.sm_tel is null and s.sm_id="+CT_id+"";
  ctrol.executeUpdate(delSql);
 
}
catch(Exception e)
{
  out.println("error message:" + e.getMessage());
}
} catch (Exception ex) {
	System.out.println(new java.util.Date() + "--"
			+ request.getServletPath() + " : " + ex.getMessage());
} finally {
	if(dImpl != null)
	dImpl.closeStmt();
	if(dCn != null)
	dCn.closeCn();
}
 out.print("<script language='javascript'>alert(\"删除成功!\");window.location.href='UserNoteList.jsp?sj_id="+sj_id+"';</script>");
/*????  ??*/
%>