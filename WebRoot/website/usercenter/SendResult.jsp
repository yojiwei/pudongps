<%@ page contentType="text/html; charset=GBK"%>
<%@include file="/website/include/IsLogin.jsp"%>
<%@include file="/website/include/import.jsp"%>
<%@page import="com.util.CMessage"%>
<%//Update 20061231
String wo_id = CTools.dealString(request.getParameter("wo_id")).trim(); //办事事项id
String msgTitle = CTools.dealString(request.getParameter("msgTitle")).trim(); //消息标题
String receiverId = CTools.dealString(request.getParameter("receiverId")).trim(); //消息接收者id
String receiverName = CTools.dealString(request.getParameter("receiverName")).trim();//消息接收者姓名
String msgContent = CTools.dealString(request.getParameter("msgContent")).trim();//消息内容
String uid = checkLogin.getId(); //发送人id
String uName = checkLogin.getUserName(); //发送人姓名

CDataCn dCn = null;
CDataImpl dImpl = null;
try{
dCn = new CDataCn();
dImpl = new CDataImpl(dCn); 

dCn.beginTrans(); //启用数据库事务
//发送消息
CMessage msg = new CMessage(dImpl);
msg.addNew();
msg.setValue(CMessage.msgReceiverId,","+receiverId+",");
msg.setValue(CMessage.msgReceiverName,receiverName);
msg.setValue(CMessage.msgTitle,msgTitle);
msg.setValue(CMessage.msgSenderId,uid);
msg.setValue(CMessage.msgSenderName,uName);
msg.setValue(CMessage.msgSenderDesc,uName);
msg.setValue(CMessage.msgIsNew,"1");
msg.setValue(CMessage.msgRelatedType,"1");
msg.setValue(CMessage.msgPrimaryId,wo_id);
msg.setValue(CMessage.msgSendTime,(new java.util.Date()).toLocaleString());
msg.setValue(CMessage.msgContent,msgContent);
msg.update();

if (dCn.getLastErrString().equals(""))//没有出错，则提交事务；否则回滚
{
	dCn.commitTrans();
	%>
	<script language="javascript">
	alert("消息已发送");
	window.close();
	</script>
	<%
}
else
{
	dCn.rollbackTrans();
	%>
	<script language="javascript">
	alert("消息未发送");
	window.close();
	</script>
	<%
}

}
catch(Exception e){
//e.printStackTrace();
out.print(e.toString());
}
finally{
dImpl.closeStmt();
dCn.closeCn(); 
}
%>