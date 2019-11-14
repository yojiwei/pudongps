<%@ page contentType="text/html; charset=GBK" %>
<%@include file="/system/app/skin/import.jsp"%>
<%
CMySelf self = (CMySelf)session.getAttribute("mySelf");
String selfdtid = String.valueOf(self.getDtId());
String sender_id = String.valueOf(self.getMyID());

java.util.Date SendTime = new java.util.Date();
String cw_id = "";
String cp_id = "";
String co_id = "";
String co_question = "";
String co_mainopioion = "";
String Receiverid = "";
String Timelimit = "";

cw_id = CTools.dealString(request.getParameter("cw_id")).trim();
//cp_id = CTools.dealString(request.getParameter("cp_id")).trim();
//co_id = CTools.dealString(request.getParameter("co_id")).trim();
Receiverid = CTools.dealString(request.getParameter("Receiverid")).trim();
Timelimit = CTools.dealString(request.getParameter("Timelimit")).trim();
co_question = CTools.dealString(request.getParameter("co_question")).trim();
co_mainopioion = CTools.dealString(request.getParameter("co_mainopioion")).trim();
out.println(co_mainopioion);
//update20080122

CDataCn dCn=null;   //新建数据库连接对象
CDataImpl dImpl=null;  //新建数据接口对象

try {
 dCn = new CDataCn(); 
 dImpl = new CDataImpl(dCn); 
//操作涉及到tb_connwork,tb_correspond
dCn.beginTrans();

//往投诉协同表里加数据
dImpl.addNew("tb_correspond","co_id",CDataImpl.PRIMARY_KEY_IS_VARCHAR);
dImpl.setValue("cw_id",cw_id,CDataImpl.STRING);
dImpl.setValue("co_status","1",CDataImpl.STRING);

dImpl.update();
dImpl.setClobValue("co_question",co_question);//投诉主要问题
dImpl.setClobValue("co_mainopioion",co_mainopioion);//主办部门意见

//选取co_id
String sqlstr = "select co_id from tb_correspond where cw_id='" + cw_id + "'";
Hashtable content = dImpl.getDataInfo(sqlstr);
co_id = content.get("co_id").toString();;
//往文件交换箱中加数据
dImpl.addNew("tb_documentexchange","de_id",CDataImpl.PRIMARY_KEY_IS_VARCHAR);
dImpl.setValue("de_type","6",CDataImpl.STRING);
dImpl.setValue("de_primaryid",co_id,CDataImpl.STRING);
dImpl.setValue("de_status","1",CDataImpl.STRING);
dImpl.setValue("de_senddeptid",selfdtid,CDataImpl.INT);
dImpl.setValue("de_receiverdeptid",Receiverid,CDataImpl.INT);
dImpl.setValue("de_sendtime",SendTime.toLocaleString(),CDataImpl.DATE);
dImpl.setValue("de_senderid",sender_id,CDataImpl.INT);
dImpl.setValue("de_requesttime",Timelimit,CDataImpl.INT);
dImpl.update();

//修改tb_connwork表里该项目的状态
dImpl.edit("tb_connwork","cw_id",cw_id);
dImpl.setValue("cw_status","8",CDataImpl.STRING);
dImpl.update();

if(dCn.getLastErrString().equals(""))
{
  dCn.commitTrans();
}
else
{
  dCn.rollbackTrans();
}
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
response.sendRedirect("/system/app/wardenmail/AppealList.jsp?cw_status=8");
%>