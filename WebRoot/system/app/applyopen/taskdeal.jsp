<%@page contentType="text/html; charset=GBK"%>
<%@include file="/system/app/skin/head.jsp"%>
<%
//by ph 2007-3-3  信息公开一体化
//标记用户选择的是哪一种操作
String sign = CTools.dealString(request.getParameter("sign")).trim();
//信息公开申请编号
String iid = CTools.dealString(request.getParameter("iid")).trim();
//任务处理部门编号
String did = CTools.dealString(request.getParameter("did")).trim();
//任务编号
String tid = CTools.dealString(request.getParameter("tid")).trim();
String cid = "";
//不公开的原因
String rreason = CTools.dealString(request.getParameter("rreason")).trim();
//公开原因
String oreason = CTools.dealString(request.getParameter("oreason")).trim();
//不公开内容
String whatinfo = CTools.dealString(request.getParameter("whatinfo")).trim();
//可以公开内容
String canopen = CTools.dealString(request.getParameter("canopen")).trim();
//法律法规凭借
String rentry = CTools.dealString(request.getParameter("rentry")).trim();
String comment = CTools.dealString(request.getParameter("commentinfo")).trim();//备注内容

String rname = CTools.dealString(request.getParameter("rname")).trim();
String conreason = CTools.dealString(request.getParameter("conreason")).trim();
String caddress = CTools.dealString(request.getParameter("caddress")).trim();
String czipcode = CTools.dealString(request.getParameter("czipcode")).trim();

String rrname = CTools.dealString(request.getParameter("rrname")).trim();
String rrcaddress = CTools.dealString(request.getParameter("rrcaddress")).trim();

String infoid = CTools.dealString(request.getParameter("infoid")).trim();
String email_id = CTools.dealString(request.getParameter("email_id")).trim();

String ci_id = CTools.dealString(request.getParameter("onlineopen")).trim();

String gmode = CTools.dealString(request.getParameter("gmode")).trim();//信息提供方式
String omode = CTools.dealString(request.getParameter("omode")).trim();//其它信息提供方式

String us_id = CTools.dealString(request.getParameter("us_id")).trim();//注册用户ID
String flownum = CTools.dealString(request.getParameter("flownum")).trim();//注册用户ID

String dt_id = "";
String dt_name = "";
String info_status = "";//申请状态
String task_status = "";//当前任务状态
String feedback = "";
String finishtime = "";

//**********发送邮件给申请者
//予于公开
String online_content="";
String onlineSql="";
//部分公开
String part_content="";
String otherr = CTools.dealString(request.getParameter("otherr")).trim();
String[] noreason=request.getParameterValues("noreason");//
String noreasons="";
String rentrys="";
if(noreason!=null&&noreason.length>0){
for(int i=0;i < noreason.length;i++)
{
	noreasons+="  "+CTools.dealString(noreason[i])+";<br/>";
}
}
part_content="  您（单位）申请获取的政府信息中"+canopen+"可以公开，有关"+whatinfo+"的政府信息:<br/>";
if(!rentry.equals(""))
{
	rentrys="  根据《上海市政府信息公开规定》第十条第一款第"+rentry+"项和第十二条第（二）项，对于您（单位）申请获取的政府信息，本机关不予公开。";
}
if(!otherr.equals(""))
{
	otherr="有法律、法规规定免予公开的其他情形，具体为"+otherr+"<br/>";
}
part_content+=noreasons+otherr+rentrys;
//
String mail_content="";//邮件内容
String mail_subject=CTools.dealString(request.getParameter("infotitle")).trim();//申请的主题
String cw_email="fzb@pudong.gov.cn";//发件箱
String leader_email="";//收件箱
String oemail=CTools.dealString(request.getParameter("oemail")).trim();//申请人的信箱
boolean cmail = false;
//*********结束定义

String sqlStr = "";
Hashtable content = null;
Hashtable contentsh = null;
String redirectUrl = "";

CDataCn dCn = null;
CDataImpl dImpl = null;
try{
	dCn = new CDataCn();
	dImpl = new CDataImpl(dCn);

	SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	CMySelf mySelf = (CMySelf)session.getAttribute("mySelf");

	if (mySelf!=null){
		dt_id = Long.toString(mySelf.getDtId());
		sqlStr = "select dt_name from tb_deptinfo where dt_id = " + dt_id;
		content = dImpl.getDataInfo(sqlStr);
		if (content != null) dt_name = content.get("dt_name").toString();
	}

	dCn.beginTrans();//开始事务
	
	//dImpl.executeUpdate("update taskcenter set status = 2 where iid="+iid);
	
	//业务操作start
	if(sign.equals("0")||sign.equals("1")||sign.equals("2")||sign.equals("3")||sign.equals("6")||sign.equals("7")||sign.equals("12")) {//办理结束
		feedback = comment;
		finishtime = df.format(new java.util.Date());
		redirectUrl = "printApprize.jsp?iid="+iid;
		
		//查找是否已有处理结果数据
		sqlStr = "select id from rejectreason where iid = " + iid;
		content = dImpl.getDataInfo(sqlStr);
		if(content!=null){//有就更新
			dImpl.edit("rejectreason","id",Integer.parseInt(content.get("id").toString()));
		}else{//没有就新增
			dImpl.setTableName("rejectreason");
			dImpl.setPrimaryFieldName("id");
			dImpl.addNew();
		}
		dImpl.setValue("iid",iid,CDataImpl.INT);
		dImpl.setValue("rreason",rreason,CDataImpl.STRING);//不公开原因
		dImpl.setValue("oreason",oreason,CDataImpl.STRING);
		dImpl.setValue("whatinfo",whatinfo,CDataImpl.STRING);
		dImpl.setValue("canopen",canopen,CDataImpl.STRING);
		dImpl.setValue("rentry",rentry,CDataImpl.STRING);
		dImpl.setValue("gmode",gmode,CDataImpl.STRING);
		dImpl.setValue("omode",omode,CDataImpl.STRING);
		dImpl.update();

		if(sign.equals("0")||sign.equals("1")){
			dImpl.setTableName("tb_infopurview");
			dImpl.setPrimaryFieldName("ip_id");
			dImpl.addNew();
			dImpl.setValue("io_id",iid,CDataImpl.INT);
			dImpl.setValue("ci_id",ci_id,CDataImpl.INT);
			dImpl.update();
		}

		if(!"".equals(us_id)) {
		sqlStr = "select us_name from tb_user where us_id = '" + us_id + "'";
		content = dImpl.getDataInfo (sqlStr);
		if (content != null) {
			String receiverName = content.get("us_name").toString();
			
			//********************************************发邮件给申请用户
			if(!oemail.equals("")&&!email_id.equals("")){
			
			if(!"0".equals(ci_id)){ //选择网上公开的内容
			onlineSql="select ci_content from tb_contentinfo where ci_id ="+ci_id+"";
			contentsh = dImpl.getDataInfo(onlineSql);
			if(contentsh!=null)
			online_content=contentsh.get("ci_content").toString();
			}
			if(sign.equals("0"))//予于公开
			{
				mail_content=online_content+"<br/>"+comment;
			}
			if(sign.equals("1"))//部分公开
			{
				mail_content=part_content+"<br/>"+online_content+"<br/>"+comment;
			}
			
			CMail sMail = new CMail("smtp.pudong.gov.cn"); //新建Mail对象  
			sMail.setNeedAuth(true); 
			sMail.setNamePass("fzb","123456"); //发件箱用户名、密码 fzb 123456
			sMail.setSubject("申请公开回复--"+mail_subject);  //发送信件主题
			sMail.setBody("亲爱的"+receiverName+":<br/>   您好！<br/>"+mail_content+"<br/>本信箱仅做信息公开回复用，请不要写信或回复内容到本信箱！");  //发送信件正文
			sMail.setFrom("fzb@pudong.gov.cn"); //发件箱 xxx@xxx.xxx
			sMail.setTo(oemail); //收件箱 xxx@xxx.xxx
			cmail=sMail.sendout();
			if(!cmail){//发送失败
			out.print("<script language='javascript'>alert('发送失败，请重新发送!');");
			out.print("window.history.go(-1);</script>");
			}
			
			//out.println(email_id+"xiaowei"+cmail);
			//if(true)return;
			}
			
			//*******************************************结束
			
			String ma_title = "您申请的流水号为"+ flownum +"信息公开事项已经处理完成";
			String senderId = "";
			String senderName = "";
			String senderDtId = "";
			String senderDesc = "";
			if (mySelf!=null&&mySelf.isLogin())
			{
				senderId = Long.toString(mySelf.getMyID());
				senderName = mySelf.getMyName();
				senderDtId = Long.toString(mySelf.getDtId());
				if (!senderDtId.equals(""))
				{
					sqlStr = "select dt_name from tb_deptinfo where dt_id="+senderDtId;
					content = dImpl.getDataInfo(sqlStr);
					if (content!=null)
					{
						senderDesc = content.get("dt_name").toString();
					}
				}
			}
			////////////////
			String ma_content = "请通过流水号"+ flownum +"至网站信息公开频道查询办理结果";
				CMessage msg = new CMessage(dImpl);
				msg.addNew();
				msg.setValue(CMessage.msgReceiverId,us_id);
				msg.setValue(CMessage.msgReceiverName,receiverName);
				msg.setValue(CMessage.msgTitle,ma_title);
				msg.setValue(CMessage.msgSenderId,senderId);
				msg.setValue(CMessage.msgSenderName,senderName);
				msg.setValue(CMessage.msgSenderDesc,senderDesc);
				msg.setValue(CMessage.msgIsNew,"1");
				msg.setValue(CMessage.msgRelatedType,"1");
				msg.setValue(CMessage.msgPrimaryId,"a"+iid);
				msg.setValue(CMessage.msgSendTime,new CDate().getNowTime());
				msg.setValue(CMessage.msgContent,ma_content);
				msg.update();
				
			}
		}

		info_status = "2";
		task_status = "2";

	/*}else if(){//办理结束
		status = "2";
		feedback = comment;
		finishtime = df.format(new java.util.Date());
		redirectUrl = "printApprize.jsp?iid="+iid;

		dImpl.setTableName("rejectreason");
		dImpl.setPrimaryFieldName("id");
		dImpl.addNew();
		dImpl.setValue("iid",iid,CDataImpl.INT);
		dImpl.setValue("rreason",rreason,CDataImpl.STRING);
		dImpl.setValue("oreason",oreason,CDataImpl.STRING);
		dImpl.setValue("whatinfo",whatinfo,CDataImpl.STRING);
		dImpl.setValue("canopen",canopen,CDataImpl.STRING);
		dImpl.setValue("rentry",rentry,CDataImpl.STRING);
		dImpl.setValue("gmode",gmode,CDataImpl.STRING);
		dImpl.setValue("omode",omode,CDataImpl.STRING);
		dImpl.update();*/
	}else if(sign.equals("4")){//转办
		//新增转办任务
		dImpl.setTableName("taskcenter");
		dImpl.setPrimaryFieldName("id");
		dImpl.addNew();
		dImpl.setValue("iid",iid,CDataImpl.INT);
		dImpl.setValue("did",did,CDataImpl.INT);
		dImpl.setValue("starttime",df.format(new java.util.Date()),CDataImpl.DATE);
		dImpl.setValue("status","0",CDataImpl.INT);
		dImpl.setValue("isovertime","0",CDataImpl.INT);
		dImpl.setValue("genre","转办",CDataImpl.STRING);
		dImpl.setValue("source",dt_id,CDataImpl.INT);
		dImpl.update();
		
		info_status = "1";
		task_status = "2";
		redirectUrl = "taskList.jsp";
	//}else if(sign.equals("3")){
	//	status = "0";
	}else if(sign.equals("5")){//退回认领中心
		//新增退回认领中心任务，同时完成该任务
		dImpl.setTableName("taskcenter");
		dImpl.setPrimaryFieldName("id");
		dImpl.addNew();
		dImpl.setValue("iid",iid,CDataImpl.INT);
		dImpl.setValue("did","0",CDataImpl.INT);
		dImpl.setValue("starttime",df.format(new java.util.Date()),CDataImpl.DATE);
		dImpl.setValue("endtime",df.format(new java.util.Date()),CDataImpl.DATE);
		dImpl.setValue("status","2",CDataImpl.INT);
		dImpl.setValue("isovertime","0",CDataImpl.INT);
		dImpl.setValue("genre","退回",CDataImpl.STRING);
		dImpl.setValue("source",dt_id,CDataImpl.INT);
		dImpl.update();

		info_status = "0";
		task_status = "2";
	}else if(sign.equals("9")){//第三方意见征询
		//新增征询记录，同时任务被挂起
		dImpl.setTableName("consult");
		dImpl.setPrimaryFieldName("id");
		cid = String.valueOf(dImpl.addNew());
		dImpl.setValue("iid",iid,CDataImpl.INT);
		dImpl.setValue("tid",tid,CDataImpl.INT);
		dImpl.setValue("did",dt_id,CDataImpl.INT);
		dImpl.setValue("dname",dt_name,CDataImpl.STRING);

		dImpl.setValue("starttime",df.format(new java.util.Date()),CDataImpl.DATE);
		//dImpl.setValue("endtime",df.format(new java.util.Date()),CDataImpl.DATE);

		dImpl.setValue("rname",rrname,CDataImpl.STRING);
		dImpl.setValue("conreason",conreason,CDataImpl.STRING);
		dImpl.setValue("caddress",rrcaddress,CDataImpl.STRING);
		dImpl.setValue("czipcode",czipcode,CDataImpl.STRING);

		dImpl.setValue("status","0",CDataImpl.INT);
		dImpl.setValue("isovertime","0",CDataImpl.INT);
		dImpl.update();
		redirectUrl = "printInfo_h.jsp?cid="+cid;
		info_status = "3";//任务挂起状态
		task_status = "3";
	}else if(sign.equals("10")){//补正材料
		dImpl.setTableName("consult");
		dImpl.setPrimaryFieldName("id");
		cid = String.valueOf(dImpl.addNew());
		dImpl.setValue("iid",iid,CDataImpl.INT);
		dImpl.setValue("tid",tid,CDataImpl.INT);
		dImpl.setValue("did",dt_id,CDataImpl.INT);
		dImpl.setValue("dname",dt_name,CDataImpl.STRING);

		dImpl.setValue("starttime",df.format(new java.util.Date()),CDataImpl.DATE);
		dImpl.setValue("finishtime",df.format(new java.util.Date().getTime()+10*24*60*60*1000),CDataImpl.DATE);//加十天

		dImpl.setValue("rname",rrname,CDataImpl.STRING);
		dImpl.setValue("conreason",conreason,CDataImpl.STRING);
		dImpl.setValue("caddress",rrcaddress,CDataImpl.STRING);
		dImpl.setValue("czipcode",czipcode,CDataImpl.STRING);

		dImpl.setValue("status","0",CDataImpl.INT);
		dImpl.setValue("isovertime","0",CDataImpl.INT);
		dImpl.update();
		redirectUrl = "printInfo_h.jsp?cid="+cid;
		info_status = "5";//5待补正材料的状态 
		task_status = "0";//待处理
	}

	//out.println("祖国万岁！"+sign);
	//if(true)return;


	//更新原来任务状态
	dImpl.edit("taskcenter","id",Integer.parseInt(tid));
	dImpl.setValue("status",task_status,CDataImpl.INT);
	dImpl.setValue("endtime",df.format(new java.util.Date()),CDataImpl.DATE);//更新办结时间
	if(sign.equals("12")){
	dImpl.setValue("genre","其它方式",CDataImpl.STRING);//通过其它方式处理
	}
	dImpl.setValue("commentinfo",comment,CDataImpl.STRING);//备注
	dImpl.update();

	//更新信息公开申请表状态
	dImpl.edit("infoopen","id",Integer.parseInt(iid));
	dImpl.setValue("status",info_status,CDataImpl.INT); 
	dImpl.setValue("dealmode",sign,CDataImpl.INT);
	dImpl.setValue("feedback",feedback,CDataImpl.STRING);
	dImpl.setValue("fdid",dt_id,CDataImpl.INT);
	dImpl.setValue("fdname",dt_name,CDataImpl.STRING);
	if(!finishtime.equals("")) dImpl.setValue("finishtime",finishtime,CDataImpl.DATE);
	dImpl.update();
	
	
		
	if (dCn.getLastErrString().equals("")){
		dCn.commitTrans();
%>
		<script language="javascript">
			/*if(<%=sign%>=="4"){
				alert("操作已成功！");
				window.location="taskList.jsp";
			}else{
				if(confirm("操作已成功，是否打印告知单？")){
					window.location="<%=redirectUrl%>";
				}else{
					window.location="taskList.jsp";
				}
			}*/
			if(<%=sign%>=="0"&&<%=sign%>=="1"&&<%=sign%>=="2"&&<%=sign%>=="3"&&<%=sign%>=="6"&&<%=sign%>=="7"&&confirm("操作已成功，是否打印告知单？")){
				window.open("<%=redirectUrl%>","","Top=0px,Left=0px,width=720,height=450,scrollbars=auto");
			}else if(<%=sign%>=="9"&&confirm("操作已成功，是否打印意见征询单？")){
				window.open("<%=redirectUrl%>","","Top=0px,Left=0px,width=820,height=600,scrollbars=auto");
			}
			//var infoid = "<%=infoid%>";
			//if(infoid=="") window.open("PublishEdit.jsp?iid=<%=iid%>","","Top=0px,Left=0px,width=600,height=600,scrollbars=yes");
			window.location="taskList.jsp";
		</script>
<%
	}else{
		dCn.rollbackTrans();
		//out.print("<br>error:"+dCn.getLastErrString());
%>
		<script language="javascript">
			alert("发生错误，操作失败！");
			window.history.go(-1);
		</script>
<%
	}

}catch(Exception e){
	out.print(e.toString());
}finally{
	dImpl.closeStmt();
	dCn.closeCn(); 
}
%>
<%@include file="/system/app/skin/bottom.jsp"%>