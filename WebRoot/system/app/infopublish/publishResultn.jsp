<%@page contentType="text/html; charset=GBK"%>
<%@ page import="com.beyondbit.web.publishinfo.PublishOperate" %>
<%@ page import="com.beyondbit.web.form.TaskInfoForm" %>
<%@ page import="com.beyondbit.web.publishinfo.Messages,com.smsCase.*" %>
<%@ page import="com.beyondbit.dataexchange.*,org.apache.log4j.*" %>
<%@include file="../skin/head.jsp"%>
  <!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
  <body>
<%
  CMySelf mySelf = (CMySelf)session.getAttribute("mySelf");
  String userName = mySelf.getMyName();
  String userId = String.valueOf(mySelf.getMyUid());
  String mydtid= String.valueOf(mySelf.getDtId());
  com.beyondbit.web.form.PublishForm publishform = new com.beyondbit.web.form.PublishForm();
  TaskInfoForm taskinfoform = new TaskInfoForm();
  PublishOperate operate = new PublishOperate();
  com.jspsmart.upload.SmartUpload myUpload = new com.jspsmart.upload.SmartUpload();
  myUpload.initialize(pageContext);
  myUpload.setDeniedFilesList("exe,bat,jsp");
  myUpload.upload();
  Hashtable contentwh = null;
  Hashtable contentyn = null;
  Hashtable contentlj = null;
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

  String ct_IsComment = CTools.dealNumber(myUpload.getRequest().getParameter("ct_IsComment"));

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
  String dtName = CTools.dealUploadString(myUpload.getRequest().getParameter("dtName"));
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
  String openType = CTools.dealUploadString(myUpload.getRequest().getParameter("IN_OPENTYPE"));
  String publishStatus = CTools.dealUploadString(myUpload.getRequest().getParameter("publishStatus"));
  String contentFlag = CTools.dealUploadString(myUpload.getRequest().getParameter("ct_contentflag"));
  
  String messages = CTools.dealUploadString(myUpload.getRequest().getParameter("messages"));
  messages=messages+" 详见“上海浦东”";
  String my_sj_id = CTools.dealUploadString(myUpload.getRequest().getParameter("mysj_id"));
  String sendTime = new CDate().getNowTime();

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
  publishform.setIsComment(ct_IsComment);  
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

  if(contentFlag.equals("1")){
    publishform.setCatchNum(catchNum);
    publishform.setCateGory(cateGory);
    publishform.setDescRiption(descRiption);
    publishform.setMediaType(mediaType);
    publishform.setInfoType(infoType);
	
    publishform.setFileNum(fileNum);
  }

  String path = Messages.getString("filepath");
  String cctid = "";
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
	  count = myUpload.save(path + filePath);//保存文件
	
	  if(count>=1) {
	    filename = new String[count];
	    fileRealName = new String[count];
	  }
	
	  for(int i=0;i<count;i++)
	  {
	    filename[i] = myUpload.getFiles().getFile(i).getFileName();
	
	    int filenum = 0;
	    filenum =(int)(Math.random()*100000);
	
	    String realName = sToday + Integer.toString(filenum) + filename[i].substring(filename[i].lastIndexOf("."));
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
//if (true) return;

  //1--新增 2--修改  3--审核 4-审批 5-退回 6-正式发布 7-退回修改
  switch(Integer.parseInt(infoStatus))
  {
        case 1:{
		cctid=operate.addNew(publishform); 
		
		
		break;
	}
    case 2: {
		
		//logger.error(sjName);
		operate.editPublish(publishform);
		/**
		System.out.println("状态是："+publishStatus);
		//如果是 图片新闻 人事任免"
		if( sjName != null){
			String[] b =sjName.split(",");
			for(int i=0;i<b.length;i++){
				if("图片新闻".equals(b[i])){
					ThreadCache.pushItem(publishform.getCtId(),"1","图片新闻");
				}
				if("区管干部任免".equals(b[i])){
					ThreadCache.pushItem(publishform.getCtId(),"1","人事任免");
				}
				
			}
		}**/
		break;
	}
    case 3: operate.checkPublish(publishform);break;
    case 5: operate.checkPublish(publishform);break;
    case 7: operate.checkPublish(publishform);break;
    case 4: operate.submitPublish(publishform);break;
    case 6: operate.resumePublish(publishform);break;
  }
  

  //保存发布机构
CDataCn dCn = new CDataCn(); //新建数据库连接对象
CDataImpl dImpl = new CDataImpl(dCn); //新建数据接口对象
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
			for(int i=0;i<b.length;i++){
				if("图片新闻".equals(b[i])){ 
					 // System.out.println("开始判断："+c[i]);
					  String ispublishsql = "select * from tb_contentpublish t where ct_id = "+publishform.getCtId() + " and sj_id= "+ c[i] +" and cp_ispublish = 1 ";

					  Hashtable cp_ispublish_content = dImpl.getDataInfo(ispublishsql);
					  if( cp_ispublish_content != null){
						//System.out.println("执行了："+publishStatus);
						ThreadCache.pushItem(publishform.getCtId(),synstatus,"图片新闻");
					  }
				}
				if("区管干部任免".equals(b[i])){
					 String ispublishsql = "select * from tb_contentpublish t where ct_id = "+publishform.getCtId() + " and sj_id= "+ c[i] +" and cp_ispublish = 1 ";

					 Hashtable cp_ispublish_content = dImpl.getDataInfo(ispublishsql);
					 if( cp_ispublish_content != null){
						ThreadCache.pushItem(publishform.getCtId(),synstatus,"人事任免");
					 }


				}
				
			}
		}
		

dImpl.executeUpdate("update tb_content set dt_name = '" + dtName +"' where ct_id = '"+ publishform.getCtId() + "'");
//更新办事结果查询
if(contentFlag.equals("1")){
dImpl.executeUpdate("update tb_content set in_opentype = '" + openType +"' where ct_id = '"+ publishform.getCtId() + "'");
}


//复制今日浦东的条件

switch(Integer.parseInt(infoStatus))
{
        case 1:{
		//传入参数 1:ctid ,调用doitp的存储过程，实现自动将今日浦东栏目拷贝一份。2008-4-2
		//对于ctid记录，如果存在 今日浦东栏目，并且还存在其他栏目，将会执行拷贝数据。
		CallableStatement proc = dCn.getConnection().prepareCall("{ call copyjrpdcontent(?) }");
		proc.setInt(1, Integer.parseInt(publishform.getCtId()));
		proc.execute(); 
		////////////////////////////////////////////////////////////////////////
		break;
		}
		case 2:{
		//传入参数 1:ctid ,调用doitp的存储过程，实现自动将今日浦东栏目拷贝一份。2008-4-2
		//对于ctid记录，如果存在 今日浦东栏目，并且还存在其他栏目，将会执行拷贝数据。
		CallableStatement proc = dCn.getConnection().prepareCall("{ call copyjrpdcontent(?) }");
		proc.setInt(1, Integer.parseInt(publishform.getCtId()));
		proc.execute(); 
		////////////////////////////////////////////////////////////////////////
		break;
		}

}

//更新tb_infostatic的addtime（统计使用）
String is_strSql="select infoid,opertime from tb_infostatic where addnum = 1 and infoid = '" + publishform.getCtId() + "'";
System.out.println(is_strSql);
Hashtable is_content = dImpl.getDataInfo(is_strSql);

  if(is_content!=null)
  {
    String is_infoid = is_content.get("infoid").toString();
    String is_opertime = is_content.get("opertime").toString();
    String rightstr = CTools.right(is_opertime,2);
    if (rightstr.equals(".0"))
    {
      is_opertime = CTools.left(is_opertime,is_opertime.length()-2);
    }
    
		CDataImpl dImpl1 = new CDataImpl(dCn); //新建数据接口对象
    dImpl1.executeUpdate("update tb_infostatic set addtime = to_date('" + is_opertime +"','yyyy-mm-dd hh24:mi:ss') where infoid = '"+ is_infoid + "'");
		dImpl1.closeStmt();
  }
  
  
  
  
//---------------------------------------------------------短信频道-------------------
		if(!messages.equals(" 详见“上海浦东”"))
		{
		if(OPType.equals("Edit"))
		{
			cctid=ctId;
		}
		//out.println("xiaosuo--"+cctid+"--xiaowei");
		//if(true)return;
		String sm_tel="";
		String sm_con =messages;
		String strId = "";
		String chao = "";
		String strId1="";
		int sm_flag=2; //发送与否的标志没有发送1发送成功0发送失败3正在发送中.......
		int sm_flagtoo=10;//发送级别的标志发送的是短信内容
		int ischeck=1;//待审核没有通过3通过2
		String sm_id="";
		dImpl.setTableName("tb_sms");
		dImpl.setPrimaryFieldName("sm_id");
		String xxSql = "select max(sm_id) as sm_id from tb_sms";
		contentyn = (Hashtable)dImpl.getDataInfo(xxSql);
		if (contentyn != null) {
			strId = contentyn.get("sm_id").toString();
		}
		String sjFirId = strId;
		sjFirId = String.valueOf(dImpl.addNew()); // 主键自增好吧
		strId = sjFirId;
		//System.out.println("干撒呀这是");
		dImpl.setValue("sm_tel", sm_tel, CDataImpl.STRING);// 用户手机号码----保存为空
		dImpl.setValue("sm_con", sm_con, CDataImpl.STRING);// 发送内容----------手机短信
		dImpl.setValue("sm_flag", String.valueOf(sm_flag), CDataImpl.STRING);// 发送与否的标志1已发送2没有发送
		dImpl.setValue("sm_flagtoo", String.valueOf(sm_flagtoo), CDataImpl.STRING);//发送的优先级别1发送验证码快10发送短信内容垃圾
		dImpl.setValue("sm_check",String.valueOf(ischeck),CDataImpl.STRING);//待审核的标志
		dImpl.setValue("sm_dtid", mydtid, CDataImpl.STRING);//部门ID
		dImpl.setValue("sm_sj_id",my_sj_id,CDataImpl.STRING);//所属栏目ID
		dImpl.setValue("sm_sendtime",sendTime,CDataImpl.DATE);	//发布的时间
		dImpl.setValue("sm_ct_id",cctid,CDataImpl.STRING);	//跟发布的哪个信息有关
		dImpl.setValue("sm_detail",chao,CDataImpl.STRING);	//发布内容为空
		dImpl.update();
		//保存subscriptlog里放一份
	    dImpl.setTableName("subscibelog");
		dImpl.setPrimaryFieldName("id");
		String xlSql = "select max(id) as id from subscibelog";
		contentlj = (Hashtable)dImpl.getDataInfo(xlSql);
		if (contentlj != null) {
			strId = contentlj.get("id").toString();
		}
		String sjFirId1 = strId1;
		sjFirId1 = String.valueOf(dImpl.addNew()); // 主键自增好吧
		strId1 = sjFirId1;
		dImpl.setValue("content", sm_con, CDataImpl.STRING);// 发送内容--------手机验证码--手机短信
		dImpl.setValue("sendflag", String.valueOf(2), CDataImpl.STRING);// 2待审核3审核通过
		dImpl.setValue("sj_id", my_sj_id, CDataImpl.STRING);//发送的优先级别1发送验证码快10发送短信内容垃圾
		dImpl.setValue("subscibeid",sm_tel,CDataImpl.STRING);//审核没有通过的标志
		dImpl.setValue("sendtime",sendTime,CDataImpl.DATE);	//发布的时间
		dImpl.update();
		}
//---------------------------------------------------------垃圾东东-------------------  
  
  
  
  
  dImpl.closeStmt();
  dCn.closeCn();
  //end 更新
	//modify for hh
	com.beyondbit.web.publishinfo.LogAction lan = new com.beyondbit.web.publishinfo.LogAction(publishform);
	lan.setLog(userName,infoStatus,userId);
	//end modify

 if(OPType.equals("Add"))
 {
  switch(Integer.parseInt(returnPage))
  {
    case 0: redirectURL = "publishList.jsp?sj_id="+CTools.split(CTools.trimEx (sjId,",")+",",",")[0] + "&sjName1=" + CTools.split(CTools.trimEx (sjName,",")+",",",")[0];break;
    case 1: redirectURL = "PublishEdit.jsp?goon=1&sj_id=" + sjId + "&sjName1=" + sjName;break;
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
   redirectURL = "publishList.jsp?sj_id="+CTools.split(CTools.trimEx (sjId,",")+",",",")[0] + "&sjName1=" + CTools.split(CTools.trimEx (sjName,",")+",",",")[0];
 }
 else if(OPType.equals("ShenHeBack"))
 {
   redirectURL = "publisheditList.jsp";
 }
 else if(OPType.equals("Wenji"))
 {
   redirectURL = "publishListWJ.jsp?Menu=问计建言留言&Module=浏览&SubMenuID=";
 }
 else if(OPType.equals("Tingzheng"))
 {
   redirectURL = "publishListTZ.jsp?Menu=听政于民留言&Module=浏览&SubMenuID=";
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