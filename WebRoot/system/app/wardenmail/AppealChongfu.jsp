<%@page contentType="text/html; charset=GBK"%>
<%@include file="../skin/import.jsp"%>
<%
  //java.util.Date FinishTime = new java.util.Date();
  String FinishTime = CDate.getNowTime();
  String cw_id = request.getParameter("cw_id").toString();
  String isOver = request.getParameter("isOver").toString();
  String cw_number = request.getParameter("cw_number").toString();
  String serSql="";
  String cw_parentid="";
  String strStatus = "";//标记重复信件
  strStatus = "1".equals(isOver)?"12":"3";
  

  
  
//处理重复信件
CDataCn dCn=null;   //
CDataImpl dImpl=null;  //
Hashtable content = null;

try {
 dCn = new CDataCn(); 
 dImpl = new CDataImpl(dCn); 

//反馈信息
   
String cw_subject = CTools.dealString(request.getParameter("strSubject"));
String ma_title = cw_subject+"：处理完成";
String ma_content = CTools.dealString(request.getParameter("strChongfu"));
String cw_typecode = CTools.dealString(request.getParameter("classtype"));
String sqlStr = "select cw_applyingname,us_id from tb_connwork where cw_id='"+cw_id+"'";
String receiverId = "";
String receiverName ="";
String senderId = "";
String senderName = "";
String senderDtId = "";
String senderDesc = "";
String strTitle = "给申请人发消息";

if(ma_content.equals(""))
ma_content = "回复已经通过E-mail反馈给您了！";

dCn.beginTrans();
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

content = dImpl.getDataInfo(sqlStr);
if (content!=null)
{
	receiverId = content.get("us_id").toString();
	receiverName = content.get("cw_applyingname").toString();
	if(!receiverId.equals("")&&!strStatus.equals("9")){
	ma_content=ma_content;
	
	 CMessage msg = new CMessage(dImpl);
	 msg.addNew();
	 msg.setValue(CMessage.msgReceiverId,receiverId);
	 msg.setValue(CMessage.msgReceiverName,receiverName);
	 msg.setValue(CMessage.msgTitle,ma_title);
	 msg.setValue(CMessage.msgSenderId,senderId);
	 msg.setValue(CMessage.msgSenderName,senderName);
	 msg.setValue(CMessage.msgSenderDesc,senderDesc);
	 msg.setValue(CMessage.msgIsNew,"1");
	 msg.setValue(CMessage.msgRelatedType,"1");
	 msg.setValue(CMessage.msgPrimaryId,cw_id);
	 msg.setValue(CMessage.msgSendTime,new CDate().getNowTime());
	 msg.setValue(CMessage.msgContent,ma_content);
	 msg.update();
 
 }
}
 
 String app_sql="select cw_parentid from tb_connwork where cw_id='"+cw_id+"'";

 Hashtable contentsh=dImpl.getDataInfo(app_sql);
 if(contentsh!=null){
 	cw_parentid=contentsh.get("cw_parentid").toString();
	if(!"".equals(cw_parentid)){
   serSql="select k.cw_id from tb_connwork k connect by prior k.cw_id=k.cw_parentid start with ";
   serSql+=" k.cw_id in(select cw_parentid from tb_connwork where cw_id='"+cw_id+"') ";
 }else{
 	serSql="select k.cw_id from tb_connwork k where k.cw_id='"+cw_id+"'";
 }
  
  Vector vectorPage = dImpl.splitPage(serSql,request,20);
  if(vectorPage!=null){
  for(int j=0;j<vectorPage.size();j++)
    {
      content = (Hashtable)vectorPage.get(j);
	  
		  dImpl.edit("tb_connwork","cw_id",content.get("cw_id").toString());
		  dImpl.setValue("cw_typecode",cw_typecode,CDataImpl.STRING);//信件内容分类
		  dImpl.setValue("cw_number",cw_number,CDataImpl.STRING);//信件编号
		  dImpl.setValue("cw_status",CTools.dealNumber(strStatus),CDataImpl.INT);//重复状态
		  dImpl.setValue("cw_finishtime",FinishTime,CDataImpl.DATE); //处理完成时间
		  dImpl.update();
		  dImpl.setClobValue("cw_chongfu",CTools.dealString(request.getParameter("strChongfu")));//重复反馈
	  
	}
  }
  dCn.commitTrans();
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
  
  response.sendRedirect("AppealList.jsp?cw_status=12");
%>

