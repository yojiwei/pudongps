<%@page contentType="text/html; charset=GBK"%>
<%@include file="../skin/import.jsp"%>
<%@page import="java.util.*,com.webservise.NewProceedingService"%>
<%
com.app.CMySelf mySelf = (com.app.CMySelf)session.getAttribute("mySelf");
if (mySelf==null) //预防有人下载该页面，然后用url的方式提交
{
	%>
	<script language="javascript">
	alert("请您先登陆！");
	window.location.href="../logout.jsp";
	</script>
	<%
}
else
{
	String cwList         = "";//选择的常用办事
	String projectId      = "";
	String commonWork     = "";
	String sortWork       = "";
	String projectName    = "";
	String departIdOut    = "";//对外显示的部门
	String departId       = "";//实际处理该项目的部门
	String projectContent = "";
	String pr_imgpath     = "";//图片存放的相对路径
	String pr_attachpath  = "";//附件存放的相对路径
	String path           = "";
	String pr_timeLimit   = "";//项目时限
	String pr_code        = "";//项目编号
	String [] pa_name;         //相应附件的说明
	String [] pa_upload;       //附件是否需要上传
	String pr_isaccept    = "";//项目是否可在网上受理
	String pr_url 	      = "";//项目的受理地址
	String pr_img 	      = "";
	String pr_sequence    = "";//项目的排序字段
	String pr_isdel       = "";//项目是否可在前台显示
	String ga_sortid      = "";//部门分类办事
	String ws_id          = "";
	String pr_gut         = "";
	String pr_sourcedtid  = "";//来源部门id

	String pr_cc = "";
	String pr_root = "";
	String pr_table = "";
	String OType = "";
	String mytest="";
	String pr_by="";//办事依据
	String pr_area = "";//办事范围
	String pr_stuff="";//办事
	String pr_money="";//办事费用
	String pr_telephone="";//电话
	String pr_tstype="";//投诉类型
	String pr_sxtype="";//类型
	String pr_address="";//投诉地址
	String pr_address_old = "";//原办事地址
	String pr_tstel="";
	String pr_tsemail="";//投诉email
	String pr_qt="";//其它投诉 
	String pr_bc = "";//不能明确办理时限的补充
	String pr_blcx="";//办理程序
	String pr_gisaddress = "";//GIS地图地址
	String [] filename = null;
  	String [] fileRealName = null;
	String ctids = "";
	String filePath = "";
	String sToday = "";
	String pr_outurl = "";//外部链接用来办事
	//保存附件的代码段
	com.jspsmart.upload.SmartUpload myUpload = new com.jspsmart.upload.SmartUpload();
	myUpload.initialize(pageContext);
	myUpload.setDeniedFilesList("exe,bat,jsp");//设置上传文件后缀限制
	myUpload.setMaxFileSize(2097152);
	myUpload.upload();
	
	String uk_id = CTools.dealUploadString(myUpload.getRequest().getParameter("userKind")).trim();
	
	pr_img = CTools.dealUploadString(myUpload.getRequest().getParameter("pr_img")).trim();
	cwList = CTools.dealUploadString(myUpload.getRequest().getParameter("cwList")).trim();
	projectId = CTools.dealUploadString(myUpload.getRequest().getParameter("projectId")).trim();
	commonWork = CTools.dealUploadString(myUpload.getRequest().getParameter("commonWork")).trim();
	sortWork = CTools.dealUploadString(myUpload.getRequest().getParameter("sortWork")).trim();
	projectName = CTools.dealUploadString(myUpload.getRequest().getParameter("projectName")).trim();
	departIdOut = CTools.dealNumber(myUpload.getRequest().getParameter("departIdOut")).trim();
	departId = CTools.dealNumber(myUpload.getRequest().getParameter("departId")).trim();
	pr_sourcedtid = CTools.dealNumber(myUpload.getRequest().getParameter("pr_sourcedtid")).trim();
	pr_by = CTools.dealUploadString(myUpload.getRequest().getParameter("pr_by")).trim();
	pr_area = CTools.dealUploadString(myUpload.getRequest().getParameter("pr_area")).trim();
	pr_stuff = CTools.dealUploadString(myUpload.getRequest().getParameter("pr_stuff")).trim();
	pr_blcx = CTools.dealUploadString(myUpload.getRequest().getParameter("pr_blcx")).trim();
	pr_money = CTools.dealUploadString(myUpload.getRequest().getParameter("pr_money")).trim();
	pr_telephone = CTools.dealUploadString(myUpload.getRequest().getParameter("pr_telephone")).trim();
	pr_tstype = CTools.dealUploadString(myUpload.getRequest().getParameter("pr_tstype")).trim();
	pr_tsemail = CTools.dealUploadString(myUpload.getRequest().getParameter("pr_tsemail")).trim();
	pr_tstel = CTools.dealUploadString(myUpload.getRequest().getParameter("pr_tstel")).trim();
	pr_qt = CTools.dealUploadString(myUpload.getRequest().getParameter("pr_qt")).trim();
	pr_bc = CTools.dealUploadString(myUpload.getRequest().getParameter("pr_bc")).trim();
	pr_address = CTools.dealUploadString(myUpload.getRequest().getParameter("pr_address")).trim();
	pr_address_old = CTools.dealUploadString(myUpload.getRequest().getParameter("pr_address_old")).trim();
	pr_sxtype = CTools.dealUploadString(myUpload.getRequest().getParameter("pr_sxtype")).trim();
	pr_imgpath = CTools.dealUploadString(myUpload.getRequest().getParameter("pr_imgpath")).trim();
	
	pr_timeLimit = CTools.dealNumber(myUpload.getRequest().getParameter("pr_timeLimit")).trim();
	pr_code = CTools.dealUploadString(myUpload.getRequest().getParameter("pr_code")).trim();
	pr_attachpath = CTools.dealString(myUpload.getRequest().getParameter("pr_attachpath")).trim();
	pr_isaccept = CTools.dealUploadString(myUpload.getRequest().getParameter("pr_isaccept")).trim();
	pr_url = CTools.dealUploadString(myUpload.getRequest().getParameter("pr_url")).trim();
	pr_sequence = CTools.dealUploadString(myUpload.getRequest().getParameter("pr_sequence")).trim();
	pr_isdel = CTools.dealUploadString(myUpload.getRequest().getParameter("pr_isdel")).trim();
	ga_sortid = CTools.dealUploadString(myUpload.getRequest().getParameter("ga_sortid")).trim();
	pr_gut = CTools.dealUploadString(myUpload.getRequest().getParameter("pr_gut")).trim();

	pr_cc = CTools.dealUploadString(myUpload.getRequest().getParameter("pr_cc")).trim();
	pr_root = CTools.dealUploadString(myUpload.getRequest().getParameter("pr_root")).trim();
	pr_table = CTools.dealUploadString(myUpload.getRequest().getParameter("pr_table")).trim();
	pr_gisaddress = CTools.dealUploadString(myUpload.getRequest().getParameter("pr_gisaddress")).trim();
	pr_outurl = CTools.dealUploadString(myUpload.getRequest().getParameter("pr_outurl")).trim();
	
	mytest = CTools.dealUploadString(myUpload.getRequest().getParameter("hehe")).trim();

	pa_name = myUpload.getRequest().getParameterValues("fjsm1");//附件说明
	pa_upload = myUpload.getRequest().getParameterValues("notUpload");
	//update by dongliang
	String curpage = CTools.dealNumber(myUpload.getRequest().getParameter("curpage"));
	//update by beginning.....
	ctids = CTools.dealUploadString(myUpload.getRequest().getParameter("ctids")).trim();//相关法规
	//update by ending.....
	
	
	if (pr_isaccept.equals("")) pr_isaccept = "0";
	if (pr_sequence.equals("")) pr_sequence = "-10";
	
	CDataCn dCn = null;
	CDataImpl dImpl = null;
	try{
	dCn = new CDataCn();
	dImpl = new CDataImpl(dCn);
	
	dCn.beginTrans();
	path = dImpl.getInitParameter("prAttach_save_path");
	if(projectId.equals(""))
	{
		projectId = dImpl.addNew("tb_proceeding_new","pr_id",CDataImpl.PRIMARY_KEY_IS_VARCHAR);
	}
	else
	{
		OType = "manage";
		dImpl.edit("tb_proceeding_new","pr_id",projectId);
	}
	if(mytest.equals("rini"))
	{
		OType="manage&myname=wssb";
	}
	dImpl.setValue("cw_id",commonWork,CDataImpl.STRING);
	dImpl.setValue("sw_id",sortWork,CDataImpl.STRING);
	dImpl.setValue("pr_name",projectName,CDataImpl.STRING);
	dImpl.setValue("dt_idext",departIdOut,CDataImpl.INT);
	dImpl.setValue("dt_id",departId,CDataImpl.INT);
	dImpl.setValue("pr_sourcedtid",pr_sourcedtid,CDataImpl.INT);
	dImpl.setValue("pr_imgpath",pr_imgpath,CDataImpl.STRING);
	if(!myUpload.getRequest().getParameter("pr_timeLimit").equals("")){
	dImpl.setValue("pr_timeLimit",pr_timeLimit,CDataImpl.INT);
	}else{
	dImpl.setValue("pr_timeLimit","5201314",CDataImpl.INT);
	}
	dImpl.setValue("pr_money",pr_money,CDataImpl.STRING);
	dImpl.setValue("pr_telephone",pr_telephone,CDataImpl.STRING);
	dImpl.setValue("pr_tstype",pr_tstype,CDataImpl.STRING);
	dImpl.setValue("pr_tstel",pr_tstel,CDataImpl.STRING);
	dImpl.setValue("pr_tsemail",pr_tsemail,CDataImpl.STRING);
	dImpl.setValue("pr_sxtype",pr_sxtype,CDataImpl.STRING);
	dImpl.setValue("pr_address",pr_address,CDataImpl.STRING);
	dImpl.setValue("pr_code",pr_code,CDataImpl.STRING);
	dImpl.setValue("pr_isaccept",pr_isaccept,CDataImpl.STRING);
	dImpl.setValue("pr_url",pr_url,CDataImpl.STRING);
	dImpl.setValue("pr_flowimgpath",pr_img,CDataImpl.STRING);
	dImpl.setValue("pr_sequence",pr_sequence,CDataImpl.INT);
	dImpl.setValue("pr_edittime",new java.util.Date().toLocaleString(),CDataImpl.DATE);
	dImpl.setValue("pr_isdel",pr_isdel,CDataImpl.STRING);
	dImpl.setValue("pr_gut",pr_gut,CDataImpl.STRING);
	dImpl.setValue("pr_cc",pr_cc,CDataImpl.STRING);
	dImpl.setValue("pr_root",pr_root,CDataImpl.STRING);
	dImpl.setValue("uk_id",uk_id,CDataImpl.STRING);
	dImpl.setValue("pr_bc",pr_bc,CDataImpl.STRING);
	dImpl.setValue("pr_gisaddress",pr_gisaddress,CDataImpl.STRING);
	dImpl.setValue("pr_outurl",pr_outurl,CDataImpl.STRING);
	dImpl.update();
	dImpl.setClobValue("pr_table",pr_table);
	//2008-10-16 panh
	dImpl.setClobValue("pr_by",pr_by);
	dImpl.setClobValue("pr_area",pr_area);
	dImpl.setClobValue("pr_stuff",pr_stuff);
	dImpl.setClobValue("pr_blcx",pr_blcx);
	dImpl.setClobValue("pr_qt",pr_qt);
	//2008-10-16
	//保存子部门分类办事
	if(!projectId.equals(""))
	{
		if(!ga_sortid.equals(""))
		{
			String ws_sql = "select ws_id from tb_worklinksort_new where pr_id='"+projectId+"'";
			Hashtable ws_content = dImpl.getDataInfo(ws_sql);
			if(ws_content!=null)
			{
				ws_id = ws_content.get("ws_id").toString();
			}
		}
	}

	if(!ga_sortid.equals(""))
	{
		if(ws_id.equals(""))
		{
			dImpl.addNew("tb_worklinksort_new","ws_id",CDataImpl.PRIMARY_KEY_IS_VARCHAR);
		}
		else
		{
			dImpl.edit("tb_worklinksort_new","ws_id",ws_id);
		}
		dImpl.setValue("pr_id",projectId,CDataImpl.STRING);
		dImpl.setValue("gw_id",ga_sortid,CDataImpl.STRING);
		dImpl.update();
	}

	//update by  beginning....
	if(!"".equals(projectId)){
	dImpl.delete("tb_proceeding_content","pr_id",(String)projectId);
	}
	String [] ct_ids = CTools.split(ctids,",");
	if (ct_ids!=null)
	{
		for (int i=0;i<ct_ids.length;i++)
		{
			if(!ct_ids[i].equals("")){
			dImpl.addNew("tb_proceeding_content","pc_id",CDataImpl.PRIMARY_KEY_IS_VARCHAR);
			dImpl.setValue("pr_id",projectId,CDataImpl.STRING);
			dImpl.setValue("ct_id",ct_ids[i],CDataImpl.STRING);
			dImpl.update();
			}
		}
	}
	//update by  ending......
	
	//update by 2012 beginning....
	if(!"".equals(projectId)&&"manage".equals(OType)&&!pr_address.equals(pr_address_old)){
		dImpl.addNew("tb_proceedingcontrol_new","id");
		dImpl.setValue("title",projectName,CDataImpl.STRING);
		dImpl.setValue("address",pr_address_old,CDataImpl.STRING);
		dImpl.setValue("address_new",pr_address,CDataImpl.STRING);
		dImpl.setValue("updatetime",new java.util.Date().toLocaleString(),CDataImpl.DATE);
		dImpl.setValue("dtid",departId,CDataImpl.STRING);
		dImpl.setValue("pr_id",projectId,CDataImpl.STRING);
		dImpl.update();
	}
	//update by  ending......
	

	//把文件保存到指定的目录
	int count = 0; //上传文件个数
	CDate oDate = new CDate();
	sToday = oDate.getThisday();
	
	if(pa_name!=null)
	{
		if (pr_attachpath.equals("")) //附件的存放目录不存在
		{
			int numeral = 0;
			numeral =(int)(Math.random()*100000);
			pr_attachpath = sToday + Integer.toString(numeral);
			java.io.File newDir = new java.io.File(path + pr_attachpath);
			if(!newDir.exists())
			{
			  newDir.mkdirs();
			}
		}
		
		
		count = myUpload.save(path + pr_attachpath);//保存文件
		if(count>=1) {
	    filename = new String[count];
	    fileRealName = new String[count];
	   }
		  //把附件信息写入数据库		  
		for(int i=0;i<count;i++)
		{
			filename[i] = myUpload.getFiles().getFile(i).getFileName();
			int filenum = 0;
			filenum =(int)(Math.random()*100000);
		
			String realName = sToday + Integer.toString(filenum) + filename[i].substring(filename[i].lastIndexOf("."));
			fileRealName[i] = realName;
			java.io.File file = new java.io.File(path + pr_attachpath + "\\\\" +filename[i]);
			java.io.File file1 = new java.io.File(path + pr_attachpath + "\\\\" +realName);
			file.renameTo(file1);
			
			
			//
			String sId = dImpl.addNew("tb_proceedingattach_new","pa_id",CDataImpl.PRIMARY_KEY_IS_VARCHAR);
			dImpl.setValue("pr_id",projectId,CDataImpl.STRING);  //项目id
			dImpl.setValue("pa_name",pa_name[i],CDataImpl.STRING);//附件说明必填
			dImpl.setValue("pa_path",pr_attachpath,CDataImpl.STRING);//附件存放路径
			dImpl.setValue("pa_fileName",fileRealName[i],CDataImpl.STRING);//附件文件名
			dImpl.setValue("pa_upload",pa_upload[i],CDataImpl.STRING);//附件是否需要上传
			dImpl.update();
			//dImpl.setBlobValue("pa_content",file);//置于表格中的BLOB字段!
			
			
		}
	}
	String [] cWork = CTools.split(cwList,",");
	
	dImpl.delete("tb_commonproceed_new","pr_id",(String)projectId); //在新增之前先删除原有的级联关系
	
	if (cWork!=null)
	{
		for (int i=0;i<cWork.length;i++)
		{
			//System.out.println(i+"=="+cWork[i]);
			dImpl.addNew("tb_commonproceed_new","cp_id",CDataImpl.PRIMARY_KEY_IS_VARCHAR);
			dImpl.setValue("pr_id",projectId,CDataImpl.STRING);
			dImpl.setValue("cw_id",cWork[i],CDataImpl.STRING);
			dImpl.update();
		}
	}
	
	dCn.commitTrans();

	%>
	<!-- 记录日志 -->
	<%
	String logstrMenu = "办事大厅办事事项";
	String logstrModule = "办事事项操作"+OType;
	String cw_id = projectId;
	%>
	<%@include file="/system/app/writelogs/WriteDetailLog.jsp"%>
	<!-- 记录日志 -->
	<%
	/*
	//调用机器人接口 update by 2011-11-16
	if("manage".equals(OType)){
		OType = "update";
	}else{
		OType = "add";
	}
	NewProceedingService nps = new NewProceedingService();
	nps.proceeding(OType,projectId);
	//
	*/
	}
	catch(Exception e){
		System.out.println(new java.util.Date()+"---"+request.getServletPath()+"----"+e.getMessage()+"-----"+dCn.getLastErrString());
	}
	finally{
		dImpl.closeStmt();
		dCn.closeCn(); 
	}
	
	%>
	<script language="javascript">
		window.location.href="./ProceedingList.jsp?OType=<%=OType%>&strPage=<%=curpage%>";
	</script>
<%
}
%>
