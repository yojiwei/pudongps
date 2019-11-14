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
	//导入到浦东环境数据库里
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
	String uk_id = "";
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
	String pr_tstel="";
	String pr_tsemail="";//投诉email
	String pr_qt="";//其它投诉 
	String pr_bc = "";//不能明确办理时限的补充
	String pr_blcx="";//办理程序
	String [] filename = null;
  String [] fileRealName = null;
	String ctids = "";
	String filePath = "";
	String sToday = "";
	//保存附件的代码段
	//读取需要导入的数据行
	String v_sname = "";//事项名称
	String ivname = "";//事项分类名称
	String ovname = "";//办理部门名称
	String v_stype = "";//事项类型
	String c_sobject = "";//服务对象
	String cavailable = "";//控制办理事项是否前台显示Y有效N无效
	String vurl = "";//网上在线服务
	String vremark = "";//备注
	String vgist = "";//办理依据
	String vcondition = "";//办理条件
	String vprocess = "";//办理程序
	String vcharge = "";//收费标准及依据
	String vtimelimit = "";//办理期限及服务承诺
	String vdoclist = "";//办事需提交的材料目录
	String vcontacttel = "";//联系电话
	String vaddress = "";//办理地点
	String vwindowsno = "";//受理窗口
	String vweburl = "";//办理网址
	String vlawsuittel = "";//投诉电话
	String vlawsuitpro = "";//投诉处理时限
	String vworkflow = ""; //存放办事流程图片路径
	String v_onlineservice = ""; //记录网上办事模块网址
	
	//
	String v_sid = CTools.dealString(request.getParameter("v_sid")).trim();
	String protypeSql = "";
	String QuerySql = "select distinct s.v_sid,s.v_sname,i.v_name as ivname,o.v_name as ovname,s.v_stype,s.c_sobject,s.C_Available,s.v_url,s.v_remark,g.v_gist,g.v_condition,g.v_process,g.v_charge,g.v_timelimit,      g.v_doclist,g.v_contacttel,g.v_address,g.v_windowsno,g.v_weburl,g.v_lawsuittel,g.v_lawsuitpro,g.v_workflow,g.v_onlineservice from hss_serviceitem s, hss_serviceguide g,hsm_organ o, hss_serviceindex i  where s.v_sid = g.v_sid and s.v_orgid = o.v_orgid and s.v_sid = i.v_sid and s.v_sid = "+v_sid+"";
	
	
	
	CDataCn dCn = null;
	CDataImpl dImpl = null;
	Hashtable content = null;
	Hashtable contentPro = null;
	Vector vectorPage = null;
	try{
	dCn = new CDataCn();
	dImpl = new CDataImpl(dCn);
	
	dCn.beginTrans();
	
	content = dImpl.getDataInfo(QuerySql);
	if(content!=null){
	   v_sid = CTools.dealNull(content.get("v_sid"));
	   v_sname= CTools.dealNull(content.get("v_sname"));//办理事项的全名称
	   ivname = CTools.dealNull(content.get("ivname"));
	   if(!"".equals(ivname)){
	   	 protypeSql = "select sw_id from tb_sortwork where sw_name = '"+ivname+"' ";
		   contentPro = dImpl.getDataInfo(protypeSql);
		   if(contentPro!=null){
		   	  ivname = CTools.dealNull(contentPro.get("sw_id")); //办理事项分类名称
		   }
	   }
	   v_stype= CTools.dealNull(content.get("v_stype"));
	   ovname= CTools.dealNull(content.get("ovname"));
	   c_sobject= CTools.dealNull(content.get("c_sobject"));//服务对象A:个人，B:企业，C:投资，D:旅游 uk_id o1市民、o2企业、o11特别关爱
	   vcharge = CTools.dealNull(content.get("v_charge"));//收费标准
	   vworkflow=CTools.dealNull(content.get("v_workflow"));//存放办事流程图形的路径，含文件名
	   vtimelimit=CTools.dealNull(content.get("v_timelimit"));//办理期限及服务承诺
	   vweburl = CTools.dealNull(content.get("v_weburl"));//记录某单位与本办理事项相关的网址
	   vlawsuitpro = CTools.dealNull(content.get("v_lawsuitpro"));//投诉处理时限
	   vlawsuittel = CTools.dealNull(content.get("v_lawsuittel"));//投诉电话
	   v_stype = CTools.dealNull(content.get("v_stype"));//事项类型:行政许可，行政审批
	   vaddress = CTools.dealNull(content.get("v_address"));//办理地点
	   vgist = CTools.dealNull(content.get("v_gist"));//办理依据
	   vdoclist = CTools.dealNull(content.get("v_doclist"));//办事需提交的材料/申报材料
	   vprocess = CTools.dealNull(content.get("v_process"));//办理程序
	   vcontacttel = CTools.dealNull(content.get("v_contacttel"));//联系电话
	   cavailable = CTools.dealNull(content.get("C_Available"));//是否前台显示 
	}
	
	pr_img = vworkflow;
	sortWork = ivname;
	projectName = v_sname;
	pr_by = vgist;
	pr_stuff = vdoclist;
	pr_blcx = vprocess;
	pr_money = vcharge;
	pr_telephone = vcontacttel;
	pr_tstype =  vlawsuitpro + vlawsuittel;
	pr_tstel = vlawsuittel;
	pr_address = vaddress;
	pr_sxtype = v_stype;
	pr_timeLimit = vtimelimit;
	pr_url = vweburl;
	uk_id = c_sobject;
	pr_isdel = cavailable;
	
	projectId = dImpl.addNew("tb_proceeding_new","pr_id",CDataImpl.PRIMARY_KEY_IS_VARCHAR);
	dImpl.setValue("cw_id",v_sid,CDataImpl.STRING);
	dImpl.setValue("sw_id",sortWork,CDataImpl.STRING);
	dImpl.setValue("pr_name",projectName,CDataImpl.STRING);
	//dImpl.setValue("dt_idext",departIdOut,CDataImpl.INT);
	//dImpl.setValue("dt_id",departId,CDataImpl.INT);
	//dImpl.setValue("pr_sourcedtid",pr_sourcedtid,CDataImpl.INT);
	//dImpl.setValue("pr_imgpath",pr_imgpath,CDataImpl.STRING);
	//?dImpl.setValue("pr_timeLimit",!"".equals(pr_timeLimit)?"5201314":pr_timeLimit,CDataImpl.INT);
	dImpl.setValue("pr_money",pr_money,CDataImpl.STRING);
	dImpl.setValue("pr_telephone",pr_telephone,CDataImpl.STRING);
	dImpl.setValue("pr_tstype",pr_tstype,CDataImpl.STRING);
	dImpl.setValue("pr_tstel",pr_tstel,CDataImpl.STRING);
	//dImpl.setValue("pr_tsemail",pr_tsemail,CDataImpl.STRING);
	dImpl.setValue("pr_sxtype",pr_sxtype,CDataImpl.STRING);
	dImpl.setValue("pr_address",pr_address,CDataImpl.STRING);
	//dImpl.setValue("pr_code",pr_code,CDataImpl.STRING);
	//dImpl.setValue("pr_isaccept",pr_isaccept,CDataImpl.STRING);
	dImpl.setValue("pr_url",pr_url,CDataImpl.STRING);
	dImpl.setValue("pr_flowimgpath",pr_img,CDataImpl.STRING);
	//dImpl.setValue("pr_sequence",pr_sequence,CDataImpl.INT);
	dImpl.setValue("pr_edittime",new java.util.Date().toLocaleString(),CDataImpl.DATE);
	dImpl.setValue("pr_isdel",pr_isdel,CDataImpl.STRING);
	//dImpl.setValue("pr_gut",pr_gut,CDataImpl.STRING);
	//dImpl.setValue("pr_cc",pr_cc,CDataImpl.STRING);
	//dImpl.setValue("pr_root",pr_root,CDataImpl.STRING);
	dImpl.setValue("uk_id",uk_id,CDataImpl.STRING);
	dImpl.setValue("pr_bc",pr_timeLimit,CDataImpl.STRING);
	dImpl.update();
	//dImpl.setClobValue("pr_table",pr_table);
	//2008-10-16 panh
	dImpl.setClobValue("pr_by",pr_by);
	//dImpl.setClobValue("pr_area",pr_area);
	dImpl.setClobValue("pr_stuff",pr_stuff);
	dImpl.setClobValue("pr_blcx",pr_blcx);
	//dImpl.setClobValue("pr_qt",pr_qt);
	//2008-10-16
	
	String downSql = "select v_dtid,v_docname,v_docpath,d_addtime,v_orgid from hss_downtable where v_sid = "+v_sid+"";
	String v_docname = "";
	String v_docpath = "";
	String d_addtime = "";
	String v_docfilename = "";
	String v_docfilenames[] = null;
	vectorPage = dImpl.splitPage(downSql,request,20);
	if(vectorPage!=null)
	{
	  for(int i=0;i<vectorPage.size();i++)
	  {
		  content = (Hashtable)vectorPage.get(i);
		   v_docname = CTools.dealNull(content.get("v_docname"));
		   v_docpath = CTools.dealNull(content.get("v_docpath"));
		   d_addtime = CTools.dealNull(content.get("d_addtime"));	
		   //v_docpath中包含文件名
		   v_docfilenames = v_docpath.split("/");
		   if(v_docfilenames!=null){
		   	v_docfilename = v_docfilenames[v_docfilenames.length-1];	
		   }
		    
		  String sId = dImpl.addNew("tb_proceedingattach_new","pa_id",CDataImpl.PRIMARY_KEY_IS_VARCHAR);
			dImpl.setValue("pr_id",projectId,CDataImpl.STRING);  //项目id
			dImpl.setValue("pa_name",v_docname,CDataImpl.STRING);//附件说明必填
			dImpl.setValue("pa_path","/NHZF/UPFiles/WorkGuide/",CDataImpl.STRING);//附件存放路径
			dImpl.setValue("pa_fileName",v_docfilename,CDataImpl.STRING);//附件文件名
			dImpl.setValue("pa_upload","1",CDataImpl.STRING);//附件是否需要上传1需要
			dImpl.update();
			  
		}
	}
	//转移成功
	dImpl.edit("hss_serviceitem","v_sid",v_sid);
	dImpl.setValue("ismove","1",CDataImpl.STRING);//转移成功
	dImpl.update();
	
	dCn.commitTrans();
	}
	catch(Exception e){
		//转移成功
		dImpl.edit("hss_serviceitem","v_sid",v_sid);
		dImpl.setValue("ismove","2",CDataImpl.STRING);//转移成功
		dImpl.update();
		dCn.rollbackTrans();
		System.out.println(new java.util.Date() + "--"
			+ request.getServletPath() + " : " + e.getMessage());
	}
	finally{
		dImpl.closeStmt();
		dCn.closeCn(); 
	}
	%>
	<script language="javascript">
		window.location.href="./NanHuiProceedingList.jsp";
	</script>
<%
}
%>
