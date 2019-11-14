<%@ page contentType="text/html; charset=GBK" %>
<%@include file="/system/app/skin/import.jsp"%>
<%@page import="com.util.CMessage"%>

<%
String wo_id = "";       //项目id

String receiverId = "";  //接收者id
String receiverName = "";//接收者姓名

String ma_title = "";    //消息标题
String ma_content = "";  //消息内容

String senderId = "";    //发送人id
String senderName = "";  //发送人姓名
String senderDesc = "";  //发送人的描述（这里是用部门名代替）
String senderDtId = "";  //发送人的部门id

String sqlStr = "";      //用于查询数据库的sql语句

wo_id = CTools.dealString(request.getParameter("wo_id")).trim();

receiverId = CTools.dealString(request.getParameter("receiverId")).trim();
receiverName = CTools.dealString(request.getParameter("receiverName")).trim();

ma_title = CTools.dealString(request.getParameter("ma_title")).trim();
ma_content = CTools.dealString(request.getParameter("ma_content")).trim();

//从session里获取发送人的信息
com.app.CMySelf mySelf = (com.app.CMySelf)session.getAttribute("mySelf");

if (mySelf!=null && mySelf.isLogin())
{
	//out.print("asf");
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

String us_cellphonenumber="";
if (!receiverId.equals(""))
{
	String sql = " select us_cellphonenumber from tb_user where us_id='"+receiverId+"' ";
	//out.println(sql);out.close();
	Hashtable cont = dImpl.getDataInfo(sql);
	if (cont!=null)
	{
		us_cellphonenumber = cont.get("us_cellphonenumber").toString();
	}
}
//out.println(senderDesc);out.close();

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
msg.setValue(CMessage.msgPrimaryId,wo_id);
msg.setValue(CMessage.msgSendTime,(new java.util.Date()).toLocaleString());
msg.setValue(CMessage.msgContent,ma_content);
msg.update();
if(dImpl.getInitParameter("is_sendshortmessage").equals("yes"))
{
if(!us_cellphonenumber.equals(""))
{
	if(us_cellphonenumber.length()!=11)
	{
		out.println("<script>alert('手机号码位数出错！');</script>");
	}
	else
	{
		String content = "[上海浦东"+senderDesc+"发消息]"+ma_title+":"+ma_content;
		msg.addNew2();
		msg.setValue(CMessage.sendType,"0");
		msg.setValue(CMessage.sendMode,"0");
		msg.setValue(CMessage.sender,senderDesc);
		msg.setValue(CMessage.sendTo,receiverName);
		msg.setValue(CMessage.sendMobile,us_cellphonenumber);
		msg.setValue(CMessage.sendMessage,content);
		msg.setValue(CMessage.sendTime,new CDate().getNowTime());
		msg.setValue(CMessage.sendResult,"0");
		msg.setValue(CMessage.sendMemo,"");
		msg.update2();
	}
}
}
if (dCn.getLastErrString().equals(""))
{
	dCn.commitTrans();
	%>
	<script language="javascript">
	alert("消息已发送");
	window.opener.location.href="AppWorkDetail.jsp?wo_id=<%=wo_id%>";
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
%>
