<%@ page contentType="text/html; charset=GBK" %>
<%@include file="/system/app/skin/import.jsp"%>
<%@page import="com.util.CMessage"%>
<%

//根据dealType来标识处理方式
//0 暂存
//1 进行中
//
String sqlStr = "";
String wo_id = "";
String dealType = "";
String opinion = "";
String pr_name = "";
String us_id = "";
String us_name = "";
String senderId = "";
String senderName = "";
String senderDtId = "";
String msgContent = "";
String senderDesc = "";

wo_id = CTools.dealString(request.getParameter("wo_id")).trim();
dealType = CTools.dealString(request.getParameter("dealType")).trim();
opinion = CTools.dealString(request.getParameter("wo_opinion")).trim();

//update20080122

CDataCn dCn=null;   //新建数据库连接对象
CDataImpl dImpl=null;  //新建数据接口对象

try {
 dCn = new CDataCn(); 
 dImpl = new CDataImpl(dCn); 



dCn.beginTrans();
dImpl.edit("tb_work","wo_id",wo_id);
if (dealType.equals("0")) //暂存
{
	dealType = "1";
}
else if (dealType.equals("3")||dealType.equals("4"))
{
	dImpl.setValue("wo_finishtime",new CDate().getNowTime(),CDataImpl.DATE);
}
dImpl.setValue("wo_status",dealType,CDataImpl.STRING);
dImpl.update();

dImpl.setClobValue("wo_opinion",opinion);
//发消息
if (!dealType.equals("1"))
{
	if (dealType.equals("3"))
	{
		msgContent = "已经通过";
	}
	else if (dealType.equals("4"))
	{
		msgContent = "没有通过";
	}
	sqlStr = "select us_id,wo_applypeople,wo_projectname from tb_work where wo_id='"+wo_id+"'";
	Hashtable content = dImpl.getDataInfo(sqlStr);
	if (content!=null)
	{
		pr_name = content.get("wo_projectname").toString();
		us_id = content.get("us_id").toString();
		us_name = content.get("wo_applypeople").toString();
	}
	com.app.CMySelf mySelf = (com.app.CMySelf)session.getAttribute("myUser");
	if (mySelf!=null&&mySelf.isLogin())
	{
		senderId = Long.toString(mySelf.getMyID());
		senderName = mySelf.getMyName();
		senderDtId = Long.toString(mySelf.getDtId());
	}
	
	if (!senderDtId.equals(""))
	{
		sqlStr = "select dt_name from tb_deptinfo where dt_id="+senderDtId;
		content = dImpl.getDataInfo(sqlStr);
		if (content!=null)
		{
			senderDesc = content.get("dt_name").toString();
		}
	}


	CMessage msg = new CMessage(dImpl);
	msg.addNew();
	msg.setValue(CMessage.msgReceiverId,us_id);
	msg.setValue(CMessage.msgReceiverName,us_name);
	msg.setValue(CMessage.msgTitle,"您申请的项目“"+pr_name+"”"+msgContent);
	msg.setValue(CMessage.msgSenderId,senderId);
	msg.setValue(CMessage.msgSenderName,senderName);
	msg.setValue(CMessage.msgSenderDesc,senderDesc);
	msg.setValue(CMessage.msgIsNew,"1");
	msg.setValue(CMessage.msgRelatedType,"1");
	msg.setValue(CMessage.msgPrimaryId,wo_id);
	msg.setValue(CMessage.msgSendTime,new CDate().getNowTime());
	msg.setValue(CMessage.msgContent,opinion);
	msg.update();
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
response.sendRedirect("WaitList.jsp");
%>