<%@ page contentType="text/html; charset=GBK" %>
<%@include file="/system/app/skin/import.jsp"%>
<%@page import="com.util.CMessage"%>
<%
String wo_id = "";
String reason = "";
String sqlStr = "";
String pr_name = "";
String us_id = "";
String us_name = "";
String senderId = "";
String senderName = "";
String senderDtId = "";
String senderDesc = "";

wo_id = CTools.dealString(request.getParameter("wo_id")).trim();
reason = CTools.dealString(request.getParameter("wf_reason")).trim();

CDataCn dCn_add = null;
CDataImpl dImpl_add = null;
//update20080122



try {
 dCn_add = new CDataCn(); 
 dImpl_add = new CDataImpl(dCn_add); 
//操作涉及到tb_work  和 tb_workfrozen 两个表，所以要用到事务
dCn_add.beginTrans();
sqlStr = "select us_id,wo_applypeople,wo_projectname from tb_work where wo_id='"+wo_id+"'";
Hashtable content = dImpl_add.getDataInfo(sqlStr);
if (content!=null)
{
	pr_name = content.get("wo_projectname").toString();
	us_id = content.get("us_id").toString();
	us_name = content.get("wo_applypeople").toString();
}
//往项目冻结表里加数据
dImpl_add.addNew("tb_workfrozen","wf_id",CDataImpl.PRIMARY_KEY_IS_VARCHAR);
dImpl_add.setValue("wo_id",wo_id,CDataImpl.STRING);
dImpl_add.setValue("wf_reason",reason,CDataImpl.STRING);
dImpl_add.setValue("wf_starttime",new CDate().getNowTime(),CDataImpl.DATE);
dImpl_add.update();

//修改tb_work表里该项目的状态
dImpl_add.edit("tb_work","wo_id",wo_id);
dImpl_add.setValue("wo_status","2",CDataImpl.STRING);
dImpl_add.update();

//发消息
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
	content = dImpl_add.getDataInfo(sqlStr);
	if (content!=null)
	{
		senderDesc = content.get("dt_name").toString();
	}
}

CMessage msg = new CMessage(dImpl_add);
msg.addNew();
msg.setValue(CMessage.msgReceiverId,us_id);
msg.setValue(CMessage.msgReceiverName,us_name);
msg.setValue(CMessage.msgTitle,"您申请的项目\""+pr_name+"\"需要补充材料");
msg.setValue(CMessage.msgSenderId,senderId);
msg.setValue(CMessage.msgSenderName,senderName);
msg.setValue(CMessage.msgSenderDesc,senderDesc);
msg.setValue(CMessage.msgIsNew,"1");
msg.setValue(CMessage.msgRelatedType,"1");
msg.setValue(CMessage.msgPrimaryId,wo_id);
msg.setValue(CMessage.msgSendTime,new CDate().getNowTime());
msg.setValue(CMessage.msgContent,reason);
msg.update();

dCn_add.commitTrans();

}
catch(Exception e){
out.print(e.toString());
}
finally{
dImpl_add.closeStmt();
dCn_add.closeCn();
}

%>
<script language="javascript">
alert("需要补件请求已发送！");
window.opener.location.href="WaitList.jsp";
window.close();
</script>