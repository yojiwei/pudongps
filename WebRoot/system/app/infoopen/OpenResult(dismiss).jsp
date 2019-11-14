<%@page contentType="text/html; charset=GBK"%>
<%@include file="/system/app/skin/import.jsp"%>
<%@page import="com.util.CMessage"%>
<%
	//java.util.Date FinishTime = new java.util.Date();
	//CDate finishday = new CDate();
	DateFormat df = DateFormat.getDateInstance(DateFormat.DEFAULT , Locale.CHINA);
	String IN_showtime = df.format(new java.util.Date());
	
//update20080122

CDataCn dCn=null;   //新建数据库连接对象
CDataImpl dImpl=null;  //新建数据接口对象

try {
 dCn = new CDataCn(); 
 dImpl = new CDataImpl(dCn); 
	String io_Status = "3";//申请已办结
	String io_id = request.getParameter("io_id").toString();
	String io_project = CTools.dealString(request.getParameter("io_project"));
	String ma_title = io_project+"：处理完成";
	String ma_content = "";
	String io_reback_kind = CTools.dealString(request.getParameter("io_reback_kind"));
	String io_reback = CTools.dealUploadString(myUpload.getRequest().getParameter("io_reback")).trim();
	String io_reback_kind =  CTools.dealUploadString(myUpload.getRequest().getParameter("io_reback_kind")).trim();
	String if_nick_name = CTools.dealUploadString(myUpload.getRequest().getParameter("fj1")).trim();
	int io_reback_kind_int = Integer.parseInt(io_reback_kind);
	switch(io_reback_kind_int)
	{
		case 1:
		ma_content = "aaa";
		break;
		case 2:
		ma_content = "aaa";
		break;
		case 3:
		ma_content = "aaa";
		break;
		case 4:
		ma_content = "aaa";
		break;
		case 5:
		ma_content = "aaa";
		break;
		case 6:
		ma_content = "aaa";
		break;
		default:
		ma_content = "处理完毕";
		break;
		
	}
	if(ma_content.equals(""))
	ma_content = "回复已经通过E-mail反馈给您了！";
	dCn.beginTrans();

	String sqlStr = "select * from tb_infoOpen where io_id='"+io_id+"'";
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
	
	//String sql_dt = "select dt_name from tb_deptinfo where dt_id="+senderDtId;
	//Hashtable content1 = dImpl.getDataInfo(sql_dt);
	//if (content1!=null)
	//{
	//	senderDesc = content1.get("dt_name").toString();
	//}
	
	Hashtable content = dImpl.getDataInfo(sqlStr);
	if (content!=null)
	{
		receiverId = content.get("us_id").toString();
		receiverName = content.get("io_us_name").toString();
	if(!receiverId.equals("")){
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
	 msg.setValue(CMessage.msgPrimaryId,io_id);
	 msg.setValue(CMessage.msgSendTime,new CDate().getNowTime());
	 msg.setValue(CMessage.msgContent,ma_content);
	 msg.update();
	out.println(receiverId);
	 }
	}

  dImpl.edit("tb_infoOpen","io_id",io_id);//完成申请
  dImpl.setValue("io_status","3",CDataImpl.STRING);//状态
  dImpl.setValue("io_reback_time",IN_showtime,CDataImpl.STRING); //处理完成时间
  dImpl.setValue("io_reback ",io_reback,CDataImpl.STRING); //反馈信息
  dImpl.setValue("io_reback_kind ",io_reback_kind,CDataImpl.STRING); //反馈信息类别
  dImpl.update();
  dCn.commitTrans();
  dImpl.closeStmt();
  dCn.closeCn();
  //update20080122

CDataCn dCn=null;   //新建数据库连接对象
CDataImpl dImpl=null;  //新建数据接口对象

try {
 dCn = new CDataCn(); 
 dImpl = new CDataImpl(dCn); 
  response.sendRedirect("openList.jsp?io_status=3");
%>

