<%@include file="/system/app/skin/import.jsp"%>
<%@page contentType="text/html; charset=GBK"%>
<%
   // java.util.Date FinishTime = new java.util.Date();
String FinishTime = CDate.getNowTime();
	//update20080122

CDataCn dCn=null;   //新建数据库连接对象
CDataImpl dImpl=null;  //新建数据接口对象

try {
 dCn = new CDataCn(); 
 dImpl = new CDataImpl(dCn); 
    String cw_id_all = "";//编号
    String cp_id = "";//项目编号
	String dd_id = "";
    String us_id = "";//用户id
    String is_us = "否";//是否注册用户
    String applyname = "";//投诉人姓名
    String applydept = "";//投诉人单位
    String strTel = "";//投诉人电话
    String strEmail = "";//投诉人邮件
    String appealname = "";//被投诉人姓名
    String appealdept = "";//被投诉人单位
    String strSubject = "";//投诉主题
    String strContent = "";//投诉内容
    String strfeedback = "";//投诉反馈
    String feedbackType = "";//投诉反馈
    int cw_status;//投诉状态
    String cw_statusStr = "";
    String strStatus = "";//投诉状态
    String strSql = "";
    String sqlcorr = "";//判断是否转办
    String receivername = "";//转办部门
    String dept_name = "";
    String co_corropioion = "";//转办部门意见
    String co_id = "";//转办编号
    String de_requesttime = "";//转办时限
    String cp_id_conn = "";
    String cp_name_conn = "";
    String cw_code = "";
    String cw_codestr = "否";
    String cw_applytime = "";
	String cw_transmittime = "";
	String cw_ispublish = "";
    String list="";
	String url_target="";
	String oldcw_id = "";
	String outCon="";
	String cw_emailtype = "";
	cw_id_all = request.getParameter("cw_id").toString();
	String [] cw_id = cw_id_all.split(",");
	String deptconn = request.getParameter("conntype").toString();
	 String ma_title ="";
   
  String ma_content = CTools.dealString(request.getParameter("strFeedback"));

  if(ma_content.equals(""))
  	ma_content = "回复已经通过E-mail反馈给您了！";
String receiverId = "";
String receiverName ="";
String senderId = "";
String senderName = "";
String senderDtId = "";
String senderDesc = "";
String strTitle = "给申请人发消息";

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

  dCn.beginTrans();
	if(!"".equals(deptconn)){
	for(int j = 0;j < cw_id.length;j++) {
		//String pr_name= request.getParameter("pr_name");
		strSql = "select cw_emailtype,cw_parentid,cw_id,us_id,cp_id,cw_status,dd_id,cw_ispublish,cw_code,cw_applyingname,cw_applyingdept,cw_email,to_char(cw_transmittime,'yyyy-mm-dd hh24:mi:ss') cw_transmittime,cw_telcode,cw_appliedname,cw_emailtype,cw_applieddept,cw_subject,cw_content,cw_feedback,cw_applytime,cw_trans_id,cw_status from tb_connwork where cw_id='"+cw_id[j]+"'";
		strSql += " order by cw_applytime desc";
		Hashtable content = dImpl.getDataInfo(strSql);
			if(content!=null)
			{
			 
			  oldcw_id = content.get("cw_id").toString();
			  cp_id = content.get("cp_id").toString();
			  us_id = content.get("us_id").toString();
			  dd_id = content.get("dd_id").toString();
			  applyname = content.get("cw_applyingname").toString();
			  applydept = content.get("cw_applyingdept").toString();
			  strTel = content.get("cw_telcode").toString();
			  strEmail = content.get("cw_email").toString();
			  strSubject = content.get("cw_subject").toString();
			  strContent = content.get("cw_content").toString();
			  cw_applytime = content.get("cw_applytime").toString();
			  cw_ispublish =  content.get("cw_ispublish").toString();
			  strStatus = content.get("cw_status").toString();
			  cw_code = content.get("cw_code").toString();
			  cw_emailtype = content.get("cw_emailtype").toString();
			    receiverId = content.get("us_id").toString();
			   if(!receiverId.equals("")){
	               receiverName = content.get("cw_applyingname").toString();
 ma_title = strSubject+"：处理完成";
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
 msg.setValue(CMessage.msgPrimaryId,oldcw_id);
 msg.setValue(CMessage.msgSendTime,new CDate().getNowTime());
 msg.setValue(CMessage.msgContent,ma_content);
  //out.print(ma_content);
  //if(true) return;
 msg.update();
	//out.println(receiverId);
 }
	dImpl.addNew("tb_connwork","cw_id",CDataImpl.PRIMARY_KEY_IS_VARCHAR);//新增
  	dImpl.setValue("cp_id",deptconn,CDataImpl.STRING);//事项id
  	dImpl.setValue("cw_applyingname",applyname,CDataImpl.STRING);//投诉人姓名
        dImpl.setValue("cw_applyingdept",applydept,CDataImpl.STRING);//投诉人单位
        dImpl.setValue("cw_applytime",FinishTime,CDataImpl.DATE); //投诉时间
        dImpl.setValue("cw_status","1",CDataImpl.INT); //投诉状态
        dImpl.setValue("us_id",us_id,CDataImpl.STRING);//投诉人
        dImpl.setValue("cw_email",strEmail,CDataImpl.STRING);//投诉人Email
        dImpl.setValue("cw_telcode",strTel,CDataImpl.STRING);
        dImpl.setValue("cw_subject",strSubject,CDataImpl.STRING);//投诉主题
		//dImpl.setValue("cw_subject",,CDataImpl.STRING);//投诉主题
        dImpl.setValue("cw_code",cw_code,CDataImpl.STRING);
		dImpl.setValue("cw_transmittime",FinishTime,CDataImpl.DATE);//部门转发时间
		dImpl.setValue("cw_parentid",oldcw_id,CDataImpl.STRING);//转发源记录
		dImpl.setValue("cw_emailtype",cw_emailtype,CDataImpl.STRING);
		dImpl.setValue("dd_id",dd_id,CDataImpl.STRING);
		dImpl.setValue("cw_ispublish",cw_ispublish,CDataImpl.STRING);
        dImpl.update();
        dImpl.setClobValue("cw_content",strContent);
		 dImpl.edit("tb_connwork","cw_id",oldcw_id);//修改网上投诉

	  dImpl.setValue("cw_status","8",CDataImpl.INT);//投诉状态
  dImpl.setValue("cw_finishtime",FinishTime,CDataImpl.DATE); //处理完成时间
  if (strStatus.equals("2"))dImpl.setValue("cw_managetime",FinishTime,CDataImpl.DATE); //开始处理时间
  dImpl.setValue("cw_trans_id",deptconn,CDataImpl.STRING); 
  dImpl.update();
			}
		}
	}
	dCn.commitTrans();
	dImpl.closeStmt();
	dCn.closeCn();
	out.print("<script>alert('批处理成功！');</script>");
	if (!"".equals(deptconn)){
		%>
		<script>
  	window.location="AppealList.jsp?cw_status=8";
		</script>
  <% }else{%>
    <script>
  	window.location="AppealList.jsp?cw_status=1";
	</script>
  <% }
%>
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