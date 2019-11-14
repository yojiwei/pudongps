<%@page contentType="text/html; charset=GBK"%>
<%@ page import="com.beyondbit.web.publishinfo.PublishOperate" %>
<%@ page import="com.beyondbit.web.form.TaskInfoForm" %>
<%@ page import="com.beyondbit.web.publishinfo.Messages" %>
<%@ page import="com.beyondbit.dataexchange.*,org.apache.log4j.*" %>

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
	
	//operate.setCp_commend("0");
	String ctTitle = CTools.dealUploadString(myUpload.getRequest().getParameter("ctTitle"));
	String ctKeywords = CTools.dealUploadString(myUpload.getRequest().getParameter("ctKeywords"));
	String ctUrl = CTools.dealUploadString(myUpload.getRequest().getParameter("ctUrl"));
	if(ctUrl.trim().equals("http://")) ctUrl = "";
	String ctSource = CTools.dealUploadString(myUpload.getRequest().getParameter("ctSource"));
	String ctAuthor = CTools.dealUploadString(myUpload.getRequest().getParameter("ctAuthor"));
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
	
		
	String cttimelimit = CTools.dealUploadString(myUpload.getRequest().getParameter("ct_timelimit"));
    if("".equals(cttimelimit)){cttimelimit="2999-12-30";}
	String ctright = CTools.dealUploadString(myUpload.getRequest().getParameter("ct_right"));	


	String tcPerson = CTools.dealUploadString(myUpload.getRequest().getParameter("checkPersonId"));
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

	String contentFlag = CTools.dealUploadString(myUpload.getRequest().getParameter("ct_contentflag"));

	if(!"".equals(ctAuthor))
		ctSource = ctAuthor;

	if(session.getAttribute("temppath")!=null){
		ctImgpath = (String)session.getAttribute("temppath");
		session.setAttribute("temppath",null);
	}

	taskinfoform.setTcMemo(tcMemo);
	taskinfoform.setTcParentId(tcParentId);
	taskinfoform.setTcPerson(tcPerson);
	taskinfoform.setTcStatus(tcStatus);
	taskinfoform.seTcSenderId(tcSenderId);
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
	publishform.setCtTimeLimit(cttimelimit);
	publishform.setCtRight(ctright);

	if(contentFlag.equals("1")){
		publishform.setCatchNum(catchNum);
		publishform.setCateGory(cateGory);
		publishform.setDescRiption(descRiption);
		publishform.setMediaType(mediaType);
		publishform.setInfoType(infoType);

		publishform.setFileNum(fileNum);

	}

	String path = Messages.getString("filepath");

	CDate oDate = new CDate();
	String sToday = oDate.getThisday();
	int count = 0; //上传文件个数
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

		//out.println(filename[i]);
	}

	publishform.setFileRealName(filename);
	publishform.setFileList(fileRealName);
	publishform.setFilePath(filePath);
	//out.println(infoStatus);

	//1--新增 2--修改  3--审核
	switch(Integer.parseInt(infoStatus))
	{
		case 1: operate.addNew(publishform);break;
		case 2: operate.editPublish(publishform);break;
		case 3:	operate.checkPublish(publishform);break;
		case 4:	operate.submitPublish(publishform);break;
	}

	switch(Integer.parseInt(returnPage))
	{
		case 0: redirectURL = "publishList.jsp?sj_id="+CTools.split(CTools.trimEx (sjId,",")+",",",")[0] + "&sjName1=" + CTools.split(CTools.trimEx (sjName,",")+",",",")[0];break;
		case 1: redirectURL = "PublishInfo.jsp?sj_id=" + sjId + "&sjName=" + sjName;break;


	}


/************************同步传送数据到中台***********************************************/
CDataCn dCn = new CDataCn(); //新建数据库连接对象
CDataImpl dImpl = new CDataImpl(dCn); //新建数据接口对象
try{
	String synstatus = "0";
	if(Integer.parseInt(infoStatus) == 2){
		 synstatus = "1";
	}
		//logger.error(sjName);
		//如果是 图片新闻 人事任免"
		if( sjName != null){
			String[] b =sjName.split(",");
			String[] c= sjId.split(",");
			//  System.out.println("来了");
			for(int i=0;i<c.length;i++){
				//if("图片新闻".equals(c[i])){ 
				if("26639".equals(c[i])){ 
					 // System.out.println("开始判断："+c[i]);
					  String ispublishsql = "select * from tb_contentpublish t where ct_id = "+publishform.getCtId() + " and sj_id= "+ c[i] +" and cp_ispublish = 1 ";

					  Hashtable cp_ispublish_content = dImpl.getDataInfo(ispublishsql);
					  if( cp_ispublish_content != null){
						//System.out.println("执行了："+publishStatus);
						//    public static String[] SITEURLArray = new String[] {
						//        "http://in-inforportal.pudong.sh/sites/manage", "http://inforportal.pudong.sh/sites/manage"};

						ThreadCache.pushItem(publishform.getCtId(),synstatus,"图片新闻","271","http://in-inforportal.pudong.sh/sites/manage");
						ThreadCache.pushItem(publishform.getCtId(),synstatus,"图片新闻","270","http://inforportal.pudong.sh/sites/manage");
					  }
				}
				//if("区管干部任免".equals(c[i])){
				if("17751".equals(c[i])){
					 String ispublishsql = "select * from tb_contentpublish t where ct_id = "+publishform.getCtId() + " and sj_id= "+ c[i] +" and cp_ispublish = 1 ";

					 Hashtable cp_ispublish_content = dImpl.getDataInfo(ispublishsql);
					 if( cp_ispublish_content != null){
						ThreadCache.pushItem(publishform.getCtId(),synstatus,"人事任免","269","http://in-inforportal.pudong.sh/sites/manage");
						ThreadCache.pushItem(publishform.getCtId(),synstatus,"人事任免","260","http://inforportal.pudong.sh/sites/manage");
					 }
				}

			}

		}
}catch(Exception innerex){
	innerex.printStackTrace();
}finally{
  dImpl.closeStmt();
  dCn.closeCn();
}

/************************同步传送数据到中台结束***********************************************/
	//response.sendRedirect(redirectURL);
	
	//out.println("&&" + ctright);

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
