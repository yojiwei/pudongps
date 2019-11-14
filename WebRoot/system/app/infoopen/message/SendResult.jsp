<%@ page contentType="text/html; charset=GBK" %>
<%@include file="/system/app/skin/pophead.jsp"%>
<%@page import="com.util.CMessage"%>

<%
String cw_id = "";       //项目id

String receiverId = "";  //接收者id
String receiverName = "";//接收者姓名

String ma_title = "";    //消息标题
String ma_content = "";  //消息内容

String senderId = "";    //发送人id
String senderName = "";  //发送人姓名
String senderDesc = "";  //发送人的描述（这里是用部门名代替）
String senderDtId = "";  //发送人的部门id
String cw_status = "";

String sqlStr = "";      //用于查询数据库的sql语句

cw_id = CTools.dealString(request.getParameter("cw_id")).trim();
cw_status = CTools.dealString(request.getParameter("cw_status")).trim();
//out.println("id"+cw_id+"cw_status"+cw_status);
receiverId = CTools.dealString(request.getParameter("receiverId")).trim();
receiverName = CTools.dealString(request.getParameter("receiverName")).trim();

ma_title = CTools.dealString(request.getParameter("ma_title")).trim();
ma_content = CTools.dealString(request.getParameter("ma_content")).trim();

//从session里获取发送人的信息
com.app.CMySelf mySelf = (com.app.CMySelf)session.getAttribute("mySelf");
if (mySelf!=null&&mySelf.isLogin())
{
	senderId = Long.toString(mySelf.getMyID());
	senderName = mySelf.getMyName();
	senderDtId = Long.toString(mySelf.getDtId());
}
//update20080122

CDataCn dCn=null;   //新建数据库连接对象
CDataImpl dImpl=null;  //新建数据接口对象

try {
 dCn = new CDataCn(); 
 dImpl = new CDataImpl(dCn); 

dCn.beginTrans();

if (!senderDtId.equals(""))
{
	sqlStr = "select dt_name from tb_deptinfo where dt_id="+senderDtId;
	Hashtable content = dImpl.getDataInfo(sqlStr);
	if (content!=null)
	{
		senderDesc = content.get("dt_name").toString();
	}
}
/*
dImpl.addNew("tb_message","ma_id",CDataImpl.PRIMARY_KEY_IS_VARCHAR);		//新增消息
dImpl.setValue("wo_id",wo_id,CDataImpl.STRING);								//设置项目id
dImpl.setValue("ma_receiverid",receiverId,CDataImpl.STRING);				//设置接收人id
dImpl.setValue("ma_receivername",receiverName,CDataImpl.STRING);			//设置接受人姓名
dImpl.setValue("ma_title",ma_title,CDataImpl.STRING);						//设置消息标题
dImpl.setValue("ma_senderid",senderId,CDataImpl.STRING);
dImpl.setValue("ma_sendername",senderName,CDataImpl.STRING);
dImpl.setValue("ma_senderdesc",senderDesc,CDataImpl.STRING);
dImpl.setValue("ma_isnew","1",CDataImpl.STRING);							//是新消息
dImpl.setValue("ma_isprjrelated","1",CDataImpl.STRING);						//消息与项目相关
dImpl.setValue("ma_sendtime",new CDate().getNowTime(),CDataImpl.DATE);		//消息发送时间
dImpl.update();
dImpl.setClobValue("ma_content",ma_content);
*/

//需要修改，内容包括数据库的表结构
CMessage msg = new CMessage(dImpl);
msg.addNew();
msg.setValue(CMessage.msgReceiverId,receiverId);
msg.setValue(CMessage.msgReceiverName,receiverName);
msg.setValue(CMessage.msgTitle,ma_title);
msg.setValue(CMessage.msgSenderId,senderId);
msg.setValue(CMessage.msgSenderName,senderName);
msg.setValue(CMessage.msgSenderDesc,senderDesc);
msg.setValue(CMessage.msgIsNew,"1");
msg.setValue(CMessage.msgRelatedType,"2");
msg.setValue(CMessage.msgPrimaryId,cw_id);
msg.setValue(CMessage.msgSendTime,new CDate().getNowTime());
msg.setValue(CMessage.msgContent,ma_content);
msg.update();
if (dCn.getLastErrString().equals(""))
{
	dCn.commitTrans();
	%>
	<script language="javascript">
	alert("消息已发送");
	//window.opener.location.href="/system/app/appeal/AppealInfo.jsp?cw_id=<%=cw_id%>&cw_status=<%=cw_status%>";
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
%>
<%@include file="/system/app/skin/popbottom.jsp"%>
<%


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