<%@page contentType="text/html; charset=GBK"%>
<%@ page import="com.beyondbit.web.publishinfo.PublishOperate" %>
<%@ page import="com.beyondbit.web.form.TaskInfoForm" %>
<%@ page import="com.beyondbit.web.publishinfo.Messages" %>
<%@include file="../skin/head.jsp"%>
  <!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
  <body>
<%
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

  String OPType = CTools.dealNull(CTools.dealUploadString(myUpload.getRequest().getParameter("OPType")),"Add");
  String ctTitle = CTools.dealUploadString(myUpload.getRequest().getParameter("ctTitle"));
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
  String cateGory = CTools.dealUploadString(myUpload.getRequest().getParameter("IN_CATEGORY"));
  String descRiption = CTools.dealUploadString(myUpload.getRequest().getParameter("IN_DESCRIPTION"));
  String mediaType = CTools.dealUploadString(myUpload.getRequest().getParameter("IN_MEDIATYPE"));
  String infoType = CTools.dealUploadString(myUpload.getRequest().getParameter("IN_INFOTYPE"));
  String publishStatus = CTools.dealUploadString(myUpload.getRequest().getParameter("publishStatus"));
  String contentFlag = CTools.dealUploadString(myUpload.getRequest().getParameter("ct_contentflag"));
  
  String ct_guildtitle = CTools.dealUploadString(myUpload.getRequest().getParameter("ctGuildTitle"));
  String ct_subtitle = CTools.dealUploadString(myUpload.getRequest().getParameter("ctSubTitle"));

  if(session.getAttribute("temppath")!=null){
    ctImgpath = (String)session.getAttribute("temppath");
    session.setAttribute("temppath",null);
  }

  taskinfoform.setTcMemo(tcMemo);
  taskinfoform.setTcParentId(tcParentId);
  taskinfoform.setTcPerson(tcPerson);
  taskinfoform.setTcPersonName(tcPersonName);
  taskinfoform.setTcStatus(tcStatus);
  taskinfoform.seTcSenderId(tcSenderId);
  taskinfoform.setPublishStatus(publishStatus);
  taskinfoform.setTcTime(tcTime);
  taskinfoform.setChkIDs(chkIDs);


  String [] filename = null;
  String [] fileRealName = null;
  publishform.setCtContent(ctContent);
  publishform.setCtCreateTime(ctCreateTime);
  publishform.setCtFeedbackFlag(ctFeedbackFlag);
  publishform.setCtFileFlag(ctFileFlag);
  publishform.setCtFocusFlag(ctFocusFlag);
  publishform.setCtInsertTime(ctInsertTime);
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
  
  publishform.setCtGuildTitle(ct_guildtitle);
  publishform.setCtSubTitle(ct_subtitle);
System.out.println("ct_guildtitle="+ct_guildtitle+",ct_subtitle="+ct_subtitle);
  if(contentFlag.equals("1")){
    publishform.setCatchNum(catchNum);
    publishform.setCateGory(cateGory);
    publishform.setDescRiption(descRiption);
    publishform.setMediaType(mediaType);
    publishform.setInfoType(infoType);
    publishform.setFileNum(fileNum);
  }

  String path = Messages.getString("filepath");

  int count = myUpload.getFiles().getCount(); //上传文件个数
  //modify for hh 
  //没有附件的时候不用新建文件夹
  if (count > 0 ) {
	  CDate oDate = new CDate();
	  String sToday = oDate.getThisday();
	  if (filePath.equals("")) //附件的存放目录不存在
	  {
	    int numeral = 0;
	    numeral =(int)(Math.random()*100000);
	    filePath = sToday + Integer.toString(numeral);
	    java.io.File newDir = new java.io.File(path + filePath);
	    if(!newDir.exists())
	    {
	      newDir.mkdirs();
	    }
	  }
	  count = myUpload.save(path + filePath,2);//保存文件
	
	  if(count>=1) {
	    filename = new String[count];
	    fileRealName = new String[count];
	  }
	
	  for(int i=0;i<count;i++)
	  {
	    filename[i] = myUpload.getFiles().getFile(i).getFileName();
	
	    int filenum = 0;
	    filenum =(int)(Math.random()*100000);
	
	    String realName = sToday + Integer.toString(filenum) + filename[i].substring(filename[i].indexOf("."));
	    fileRealName[i] = realName;
	
	    java.io.File file = new java.io.File(path + filePath + "\\\\" +filename[i]);
	    java.io.File file1 = new java.io.File(path + filePath + "\\\\" +realName);
	    file.renameTo(file1);
	
	  }
	
	  publishform.setFileRealName(filename);
	  publishform.setFileList(fileRealName);
	  publishform.setFilePath(filePath);
  }//end modify
  //out.println(infoStatus);

  //1--新增 2--修改  3--审核 4-审批 5-退回 6-正式发布 7-退回修改
  switch(Integer.parseInt(infoStatus))
  {
    case 1: operate.addNew(publishform);break;
    case 2: operate.editPublish(publishform);break;
    case 3: operate.checkPublish(publishform);break;
    case 5: operate.checkPublish(publishform);break;
    case 7: operate.checkPublish(publishform);break;
    case 4: operate.submitPublish(publishform);break;
    case 6: operate.resumePublish(publishform);break;
  }

 if(OPType.equals("Add"))
 {
  switch(Integer.parseInt(returnPage))
  {
    case 0: redirectURL = "publishListZB.jsp?sj_id="+CTools.split(CTools.trimEx (sjId,",")+",",",")[0] + "&sjName1=" + CTools.split(CTools.trimEx (sjName,",")+",",",")[0];break;
    case 1: redirectURL = "PublishInfoZB.jsp?sj_id=" + sjId + "&sjName=" + sjName;break;
  }
 }
 else if(OPType.equals("ShenHe"))
 {
   redirectURL="publishcheckList.jsp?divName=summarize&status=unchecked&strPage=1";
 }
 else if(OPType.equals("ShenHeEdit"))
 {
   redirectURL="publishcheckList.jsp?divName=baseinfo&status=checked&strPage=1";
 }
 else if(OPType.equals("ShenPi"))
 {
   redirectURL="publishShePiList.jsp?divName=summarize&status=unchecked&strPage=1";
 }
 else if(OPType.equals("ShenPiEdit"))
 {
   redirectURL="publishShePiList.jsp?divName=baseinfo&status=checked&strPage=1";
 }
 else if(OPType.equals("ShenPiCancel"))
 {
   redirectURL="publishShePiList.jsp?divName=cancelinfo&status=checked&strPage=1";
 }
 else if(OPType.equals("Edit"))
 {
   redirectURL = "publishListZB.jsp?sj_id="+CTools.split(CTools.trimEx (sjId,",")+",",",")[0] + "&sjName1=" + CTools.split(CTools.trimEx (sjName,",")+",",",")[0];
 }
 else if(OPType.equals("ShenHeBack"))
 {
   redirectURL = "publisheditList.jsp";
 }


  //response.sendRedirect(redirectURL);

%>
<form name="rstform" method="post">
 <input type="hidden" value="<%=sjName%>">
 <input type="hidden" value="<%=sjId%>">
</form>
<script language='javascript'>
 document.rstform.action = "<%=redirectURL%>";
   document.rstform.submit();
</script>
  </body>
</html>