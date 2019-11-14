<%@page contentType="text/html; charset=GBK"%>
<%@page import="java.sql.*"%>
<%@page import="java.io.*"%>
<%@page import="java.util.*"%>
<%@page import="com.component.database.*"%>
<%@page import="com.util.*"%>
<%@include file="../skin/import.jsp"%>
<%@page import="com.util.CMessage"%>

<%
  //update20080122

CDataCn dCn=null;   //新建数据库连接对象
CDataImpl dImpl=null;  //新建数据接口对象

try {
 dCn = new CDataCn(); 
 dImpl = new CDataImpl(dCn); 
  			dCn.beginTrans();

String el_type= "";
el_type=CTools.dealString(request.getParameter("el_type")).trim();

String  textarea ="";
textarea=CTools.dealString(request.getParameter("textarea")).trim();


String[] pr_id = null;

pr_id=request.getParameterValues("pr_id");
String us_id ="";
String el_id ="";
String dt_id ="";
String ec_name ="";
String pp_value ="";

String senderId = "";
String senderName = "";
String senderDtId = "";
String senderDesc = "";
com.app.CMySelf mySelf = (com.app.CMySelf)session.getAttribute("mySelf");
if (mySelf!=null&&mySelf.isLogin())
{
	senderId = Long.toString(mySelf.getMyID());
	senderName = mySelf.getMyName();
	senderDtId = Long.toString(mySelf.getDtId());
}

String sql_dt = "select dt_name from tb_deptinfo where dt_id="+senderDtId;
Hashtable content1 = dImpl.getDataInfo(sql_dt);
if (content1!=null)
{
	senderDesc = content1.get("dt_name").toString();
}
us_id=CTools.dealString(request.getParameter("us_id")).trim();
dt_id=CTools.dealString(request.getParameter("dt_id")).trim();
el_id=CTools.dealString(request.getParameter("el_id")).trim();
ec_name=CTools.dealString(request.getParameter("ec_name")).trim();
pp_value=CTools.dealString(request.getParameter("pp_value")).trim();
pp_value=pp_value+"处理完成：";

if(!el_type.equals("")){
	

    dImpl.edit("tb_entemprvisexml","el_id",Integer.parseInt(el_id));	
	dImpl.setValue("el_type",el_type,CDataImpl.INT);
	dImpl.update() ;
	 CMessage msg = new CMessage(dImpl);
	 msg.addNew();
	 msg.setValue(CMessage.msgReceiverId,us_id);
	 msg.setValue(CMessage.msgReceiverName,ec_name);
	 msg.setValue(CMessage.msgTitle,pp_value);
	 msg.setValue(CMessage.msgSenderId,senderId);
	 msg.setValue(CMessage.msgSenderName,senderName);
	 msg.setValue(CMessage.msgSenderDesc,senderDesc);
	 msg.setValue(CMessage.msgIsNew,"1");
	 msg.setValue(CMessage.msgRelatedType,"1");
	 msg.setValue(CMessage.msgPrimaryId,"0");
	 msg.setValue(CMessage.msgSendTime,new CDate().getNowTime());
	 msg.setValue(CMessage.msgContent,textarea);
	 //System.out.println("*********************************************************************************||"+msg.getValue(CMessage.msgContent));
	 msg.update();
}

	
String deletesql ="delete from tb_user_proc where us_id = '"+us_id+"' and dt_id="+dt_id+"";
/**
try{
	Connection cn =null;
	cn=dCn.getConnection();
	Statement stmt =cn.createStatement(java.sql.ResultSet.TYPE_SCROLL_INSENSITIVE,java.sql.ResultSet.CONCUR_UPDATABLE);
	stmt.executeUpdate(deletesql);
	stmt.close();
}catch(Exception e){
    out.println("error message:" + e.getMessage() +e.toString() );
  }
  **/
//dImpl.delete("tb_user_proc","dt_id",dt_id);

//out.println(deletesql);
dImpl.getDataInfo(deletesql);
if(pr_id!=null){	
	
	for(int i = 0 ;i<pr_id.length;i++){
	dImpl.setTableName("tb_user_proc");
    dImpl.setPrimaryFieldName("up_id");
	dImpl.addNew();
	dImpl.setValue("us_id",us_id,CDataImpl.STRING);
	//out.println(pr_id[i]);
	dImpl.setValue("pr_id",pr_id[i],CDataImpl.STRING);
	dImpl.setValue("dt_id",dt_id,CDataImpl.STRING);
	dImpl.update() ;
	
	}
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

response.sendRedirect("list.jsp");
%>