<%@page contentType="text/html; charset=GBK"%>
<%@include file="../skin/import.jsp"%>
<%@page import="java.util.*"%>
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

	//保存附件的代码段
	com.jspsmart.upload.SmartUpload myUpload = new com.jspsmart.upload.SmartUpload();
	myUpload.initialize(pageContext);
	myUpload.setDeniedFilesList("exe,bat,jsp");//设置上传文件后缀限制
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
	projectContent = CTools.dealUploadString(myUpload.getRequest().getParameter("dt_content")).trim();
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
	
	mytest = CTools.dealUploadString(myUpload.getRequest().getParameter("hehe")).trim();

	pa_name = myUpload.getRequest().getParameterValues("fjsm1");//附件说明
	pa_upload = myUpload.getRequest().getParameterValues("notUpload");	
	
	if (pr_isaccept.equals("")) pr_isaccept = "0";
	if (pr_sequence.equals("")) pr_sequence = "100";
	
	//update20080122

CDataCn dCn=null;   //新建数据库连接对象
CDataImpl dImpl=null;  //新建数据接口对象

try {
 dCn = new CDataCn(); 
 dImpl = new CDataImpl(dCn); 
	
	dCn.beginTrans();
	path = dImpl.getInitParameter("prAttach_save_path");
	if(projectId.equals(""))
	{
		projectId = dImpl.addNew("tb_proceeding","pr_id",CDataImpl.PRIMARY_KEY_IS_VARCHAR);
	}
	else
	{
		OType = "manage";
		if(mytest.equals("rini"))
		{
		OType="manage&myname=wssb";
		}
		if(mytest.equals("hdxcjd"))
		{
		OType="manage&myname=hdxcjd";
		}
		dImpl.edit("tb_proceeding","pr_id",projectId);
	}
	dImpl.setValue("cw_id",commonWork,CDataImpl.STRING);
	dImpl.setValue("sw_id",sortWork,CDataImpl.STRING);
	dImpl.setValue("pr_name",projectName,CDataImpl.STRING);
	dImpl.setValue("dt_idext",departIdOut,CDataImpl.INT);
	dImpl.setValue("dt_id",departId,CDataImpl.INT);
	dImpl.setValue("pr_sourcedtid",pr_sourcedtid,CDataImpl.INT);
	dImpl.setValue("pr_imgpath",pr_imgpath,CDataImpl.STRING);
	
	dImpl.setValue("pr_timeLimit",pr_timeLimit,CDataImpl.INT);
	
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
	dImpl.update();
	
	dImpl.setClobValue("dt_content",projectContent);  //保存项目说明。注意，在addnew的时候，这个语句要写在dimpl的update方法后面。
	dImpl.setClobValue("pr_table",pr_table);
	//System.out.println("projectId->"+projectId);
	//保存子部门分类办事
	if(!projectId.equals(""))
	{
		if(!ga_sortid.equals(""))
		{
			String ws_sql = "select ws_id from tb_worklinksort where pr_id='"+projectId+"'";
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
			dImpl.addNew("tb_worklinksort","ws_id",CDataImpl.PRIMARY_KEY_IS_VARCHAR);
		}
		else
		{
			dImpl.edit("tb_worklinksort","ws_id",ws_id);
		}
		dImpl.setValue("pr_id",projectId,CDataImpl.STRING);
		dImpl.setValue("gw_id",ga_sortid,CDataImpl.STRING);
		dImpl.update();
	}
	//把文件保存到指定的目录
	int count = 0; //上传文件个数
	if(pa_name!=null)
	{
		if (pr_attachpath.equals("")) //附件的存放目录不存在
		{
			CDate oDate = new CDate();
			String sToday = oDate.getThisday();
			int numeral = 0;
			numeral =(int)(Math.random()*100000);
			pr_attachpath = sToday + Integer.toString(numeral);
			java.io.File newDir = new java.io.File(path + pr_attachpath);
			if(!newDir.exists())
			{
			  newDir.mkdirs();
			}
		}
		
		count = myUpload.save(path + pr_attachpath,2);//保存文件
		  //把附件信息写入数据库		  
		  
		for(int i=0;i<count;i++)
		{
			String fileName = myUpload.getFiles().getFile(i).getFileName();
			String fileContent = pa_name[i];
			java.io.File file = new java.io.File(path + pr_attachpath + "\\\\" +fileName);
			String sId = dImpl.addNew("tb_proceedingattach","pa_id",CDataImpl.PRIMARY_KEY_IS_VARCHAR);
			dImpl.setValue("pr_id",projectId,CDataImpl.STRING);  //项目id
			dImpl.setValue("pa_name",fileContent,CDataImpl.STRING);//附件说明
			dImpl.setValue("pa_path",pr_attachpath,CDataImpl.STRING);//附件存放路径
			dImpl.setValue("pa_fileName",fileName,CDataImpl.STRING);//附件文件名
			dImpl.setValue("pa_upload",pa_upload[i],CDataImpl.STRING);//附件是否需要上传
			dImpl.update();
			dImpl.setBlobValue("pa_content",file);
		}
	}
	String [] cWork = CTools.split(cwList,",");
	
	dImpl.delete("tb_commonproceed","pr_id",(String)projectId); //在新增之前先删除原有的级联关系
	

	if (cWork!=null)
	{
		for (int i=0;i<cWork.length;i++)
		{
			dImpl.addNew("tb_commonproceed","cp_id",CDataImpl.PRIMARY_KEY_IS_VARCHAR);
			dImpl.setValue("pr_id",projectId,CDataImpl.STRING);
			dImpl.setValue("cw_id",cWork[i],CDataImpl.STRING);
			dImpl.update();
		}
	}
	dCn.commitTrans();
	dImpl.closeStmt();
	dCn.closeCn();
	
	%>
	<script language="javascript">
		window.location.href="./ProceedingList.jsp?OType=<%=OType%>";
	</script>
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
}
%>
