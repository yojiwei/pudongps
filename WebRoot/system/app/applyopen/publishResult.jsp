<%@page contentType="text/html; charset=GBK"%>
<%@ page import="com.beyondbit.web.publishinfo.PublishOperate" %>
<%@ page import="com.beyondbit.web.form.TaskInfoForm" %>
<%@ page import="com.beyondbit.web.publishinfo.Messages" %>
<%@include file="../skin/head.jsp"%>
<%
CDataCn dCn = null;
CDataImpl dImpl = null;

try{
dCn = new CDataCn();
dImpl = new CDataImpl(dCn);
CMySelf mySelf = (CMySelf)session.getAttribute("mySelf");
String userName = mySelf.getMyName();
String userId = String.valueOf(mySelf.getMyUid());
com.beyondbit.web.form.PublishForm publishform = new com.beyondbit.web.form.PublishForm();
TaskInfoForm taskinfoform = new TaskInfoForm();
PublishOperate operate = new PublishOperate();
com.jspsmart.upload.SmartUpload myUpload = new com.jspsmart.upload.SmartUpload();
myUpload.initialize(pageContext);
myUpload.setDeniedFilesList("exe,bat,jsp");
myUpload.upload();

String redirectURL = "";

String ctCommend = CTools.dealNumber(myUpload.getRequest().getParameter("ctCommend"));//特别推荐
operate.setCp_commend(ctCommend);

String ci_id = "";

String OPType = CTools.dealNull(CTools.dealUploadString(myUpload.getRequest().getParameter("OPType")),"Add");
String ctTitle = CTools.dealUploadString(myUpload.getRequest().getParameter("ctTitle"));
String ci_title = CTools.dealUploadString(myUpload.getRequest().getParameter("ci_title"));
String ci_content = CTools.dealUploadString(myUpload.getRequest().getParameter("CT_content"));
String ctKeywords = CTools.dealUploadString(myUpload.getRequest().getParameter("ctKeywords"));
String ctUrl = CTools.dealUploadString(myUpload.getRequest().getParameter("ctUrl"));
if(ctUrl.trim().equals("http://")) ctUrl = "";
String ctSource = CTools.dealUploadString(myUpload.getRequest().getParameter("ctSource"));
String ctSequence = CTools.dealNumber(myUpload.getRequest().getParameter("ctSequence"));
String ctCreateTime = CTools.dealUploadString(myUpload.getRequest().getParameter("ctCreateTime"));
String ctFileFlag = CTools.dealNumber(myUpload.getRequest().getParameter("ctFileFlag"));
String sjId = CTools.dealUploadString(myUpload.getRequest().getParameter("sjId"));

String sjName = CTools.dealUploadString(myUpload.getRequest().getParameter("sjName"));
String ctFocusFlag = CTools.dealNumber(myUpload.getRequest().getParameter("ctFocusFlag"));
String ctInsertTime = CTools.dealUploadString(myUpload.getRequest().getParameter("ctInsertTime"));
String ctBrowseNum = CTools.dealNumber(myUpload.getRequest().getParameter("ctBrowseNum"));
String ctFeedbackFlag = CTools.dealNumber(myUpload.getRequest().getParameter("ctFeedbackFlag"));
String ctContent = CTools.dealUploadString(myUpload.getRequest().getParameter("CT_content"));
String ctImgpath = CTools.dealUploadString(myUpload.getRequest().getParameter("ctImgpath"));
String infoStatus = CTools.dealNumber(myUpload.getRequest().getParameter("infoStatus"));
String urId = CTools.dealUploadString(myUpload.getRequest().getParameter("urId"));
String dtId = CTools.dealUploadString(myUpload.getRequest().getParameter("dtId"));

String ctId = CTools.dealUploadString(myUpload.getRequest().getParameter("ctId"));
String iid = CTools.dealUploadString(myUpload.getRequest().getParameter("iid"));
ci_id = CTools.dealUploadString(myUpload.getRequest().getParameter("ciid"));
String tid = CTools.dealUploadString(myUpload.getRequest().getParameter("tid"));
String orgSjId = CTools.dealUploadString(myUpload.getRequest().getParameter("orgSjId"));
String returnPage = CTools.dealNumber(myUpload.getRequest().getParameter("returnPage"));
String filePath = CTools.dealUploadString(myUpload.getRequest().getParameter("filePath"));

String tcPerson = CTools.dealUploadString(myUpload.getRequest().getParameter("checkPersonId"));
String tcPersonName = CTools.dealUploadString(myUpload.getRequest().getParameter("checkPerson"));
String tcMemo = CTools.dealUploadString(myUpload.getRequest().getParameter("tcMemo"));
String tcTime = CTools.dealUploadString(myUpload.getRequest().getParameter("tcTime"));
String tcStatus = CTools.dealUploadString(myUpload.getRequest().getParameter("tcStatus"));
String tcParentId = CTools.dealUploadString(myUpload.getRequest().getParameter("tcParentId"));
String tcSenderId = CTools.dealUploadString(myUpload.getRequest().getParameter("tcSenderId"));
String chkIDs = CTools.dealUploadString(myUpload.getRequest().getParameter("chkIDs"));

String catchNum = CTools.dealUploadString(myUpload.getRequest().getParameter("IN_CATCHNUM"));
String fileNum = CTools.dealUploadString(myUpload.getRequest().getParameter("IN_FILENUM"));
//String cateGory = CTools.dealUploadString(myUpload.getRequest().getParameter("IN_CATEGORY"));
String descRiption = CTools.dealUploadString(myUpload.getRequest().getParameter("IN_DESCRIPTION"));
String mediaType = CTools.dealUploadString(myUpload.getRequest().getParameter("IN_MEDIATYPE"));
String infoType = CTools.dealUploadString(myUpload.getRequest().getParameter("IN_INFOTYPE"));
String publishStatus = CTools.dealUploadString(myUpload.getRequest().getParameter("publishStatus"));
String contentFlag = CTools.dealUploadString(myUpload.getRequest().getParameter("ct_contentflag"));
  

if(session.getAttribute("temppath")!=null){
	ctImgpath = (String)session.getAttribute("temppath");
	session.setAttribute("temppath",null);
}

/*taskinfoform.setTcMemo(tcMemo);
taskinfoform.setTcParentId(tcParentId);
taskinfoform.setTcPerson(tcPerson);
taskinfoform.setTcPersonName(tcPersonName);
taskinfoform.setTcStatus(tcStatus);
taskinfoform.seTcSenderId(tcSenderId);
taskinfoform.setPublishStatus(publishStatus);
taskinfoform.setTcTime(tcTime);
taskinfoform.setChkIDs(chkIDs);
*/

String [] filename = null;
String [] fileRealName = null;
dCn.beginTrans();
//publishform.setCtContent(ctContent);
if(ctId.equals("")){
	publishform.setCtCreateTime(ctCreateTime);
	publishform.setCtFeedbackFlag(ctFeedbackFlag);
	publishform.setCtFileFlag(ctFileFlag);
	publishform.setCtFocusFlag(ctFocusFlag);
	publishform.setCtInsertTime(CDate.getNowTime());
	publishform.setCtKeywords(ctKeywords);
	publishform.setCtSequence(ctSequence);
	publishform.setCtSource(ctSource);
	publishform.setUpdateTime(CDate.getNowTime());
	publishform.setCtTitle(ctTitle);
	publishform.setCtUrl(ctUrl);
	publishform.setCtImgPath(ctImgpath);
	publishform.setSjId(sjId);
	publishform.setUrId(urId);
	publishform.setDtId(dtId);
	publishform.setCtId(ctId);
	publishform.setSjName(sjName);
	publishform.setOrgSjId(orgSjId);
	publishform.setContentFlag(contentFlag);
	publishform.setTaskInfoForm(taskinfoform);

	publishform.setCatchNum(catchNum);
	publishform.setCateGory("2");
	publishform.setDescRiption(descRiption);
	publishform.setMediaType(mediaType);
	publishform.setInfoType(infoType);
	publishform.setFileNum(fileNum);

	//1--新增 2--修改  3--审核 4-审批 5-退回 6-正式发布 7-退回修改
	switch(Integer.parseInt(infoStatus)){
		case 1: operate.addNew(publishform);break;
		case 2: operate.editPublish(publishform);break;
		case 3: operate.checkPublish(publishform);break;
		case 5: operate.checkPublish(publishform);break;
		case 7: operate.checkPublish(publishform);break;
		case 4: operate.submitPublish(publishform);break;
		case 6: operate.resumePublish(publishform);break;
	}

	ctId = publishform.getCtId();
	
	dImpl.edit("infoopen","id",Integer.parseInt(iid));
	dImpl.setValue("infoid",ctId,CDataImpl.INT);
	dImpl.setValue("indexnum",catchNum,CDataImpl.STRING);
	dImpl.update();
}

if(Integer.parseInt(infoStatus)!=2){
//out.println("<script language='javascript'>alert(\"小日的\");</script>");
dImpl.setTableName("tb_contentinfo");
dImpl.setPrimaryFieldName("ci_id");
ci_id = String.valueOf(dImpl.addNew());//主键加一
}
else
{
	dImpl.edit("tb_contentinfo","ci_id",Integer.parseInt(ci_id));
}
dImpl.setValue("ct_id",ctId,CDataImpl.INT);
dImpl.setValue("ci_title",ci_title,CDataImpl.STRING);
dImpl.update();

dImpl.setClobValue("ci_content",ci_content);


  
String path = Messages.getString("filepath");
int count = myUpload.getFiles().getCount(); //上传文件个数

if (count > 0 ){//没有附件的时候不用新建文件夹
	CDate oDate = new CDate();
	String sToday = oDate.getThisday();
	if (filePath.equals("")){//附件的存放目录不存在
		int numeral = 0;
		numeral =(int)(Math.random()*100000);
		filePath = sToday + Integer.toString(numeral);
		java.io.File newDir = new java.io.File(path + filePath);
		if(!newDir.exists()){
			newDir.mkdirs();
		}
	}
	count = myUpload.save(path + filePath,2);//保存文件
	if(count>=1) {
		filename = new String[count];
		fileRealName = new String[count];
	}

	for(int i=0;i<count;i++){
		filename[i] = myUpload.getFiles().getFile(i).getFileName();

		int filenum = 0;
		filenum =(int)(Math.random()*100000);

		String realName = sToday + Integer.toString(filenum) + filename[i].substring(filename[i].lastIndexOf("."));
		fileRealName[i] = realName;

		java.io.File file = new java.io.File(path + filePath + "\\\\" +filename[i]);
		java.io.File file1 = new java.io.File(path + filePath + "\\\\" +realName);
		file.renameTo(file1);

		dImpl.setTableName("accessories");
		dImpl.setPrimaryFieldName("id");
		dImpl.addNew();
		dImpl.setValue("indextable","tb_contentinfo",CDataImpl.STRING);
		dImpl.setValue("indexid",ci_id,CDataImpl.INT);
		dImpl.setValue("originname",filename[i],CDataImpl.STRING);
		dImpl.setValue("filename",fileRealName[i],CDataImpl.STRING);
		dImpl.setValue("filepath",filePath,CDataImpl.STRING);
		dImpl.update();
	}

//publishform.setFileRealName(filename);
//publishform.setFileList(fileRealName);
//publishform.setFilePath(filePath);
}
//if (true) return;
if(dCn.getLastErrString().equals("")){
	//out.println("strange");
	dCn.commitTrans();
}else{
	dCn.rollbackTrans();
}
	
//modify for hh
com.beyondbit.web.publishinfo.LogAction lan = new com.beyondbit.web.publishinfo.LogAction(publishform);
lan.setLog(userName,infoStatus,userId);
//end modify

out.println("<script language=\"javascript\">");
out.println("function addOptions(){");
//out.println("var objLen = eval(opener.formData.onlineopen.length + 1);");
//out.println("alert(objLen);");
out.println("var oOption = opener.document.createElement(\"OPTION\");");
out.println("oOption.text=\""+ci_title+"\";");
out.println("oOption.value=\""+ci_id+"\";");
out.println("oOption.selected=\"true\";");
if(Integer.parseInt(infoStatus)!=2){
out.println("opener.document.formData.onlineopen.add(oOption);");
}
//out.println("opener.document.formData.onlineopen.options[objLen].selected;");
//out.println("opener.formData.onlineopen.options[objLen] = new Option('"+ci_title+"','"+ci_id+"');");
out.println("opener.document.getElementById('aaaa').innerHTML='"+ci_title+"&nbsp;&nbsp;&nbsp;&nbsp;<a href=publishInfo.jsp?iid="+iid+"&tid="+tid+"&ci_id="+ci_id+"&method=update target=_blank><font color=red><b>编辑</b></font></a>&nbsp;&nbsp;&nbsp;&nbsp;<a href=taskInfoDel.jsp?ci_id="+ci_id+"&iid="+iid+"&tid="+tid+"><font color=red><b>删除</b></font></a>';");
out.println("window.close();");
out.println("}");
out.println("addOptions();");
out.println("</script>");
//response.sendRedirect("taskInfo.jsp?myid=1");
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