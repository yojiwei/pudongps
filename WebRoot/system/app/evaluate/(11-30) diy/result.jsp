<%@page contentType="text/html; charset=GBK"%>
<%@include file="/system/app/skin/head.jsp"%>
<%@page import="com.util.*"%>
<%@page import="java.util.*"%>
<%@page import="Evaluate.*"%>
<%@page import="vote.*"%>
 

<%
CDataCn dCn = new CDataCn();
CDataImpl dImpl = new CDataImpl(dCn);



String vt_id = "";
String vt_name = "";
String vt_type = "";
String vt_upperid = "";
String vt_sequence = "";
String vt_frontpagename = "";
String vt_desc = "";
String vt_parameter = "";
String vt_parameter_text_1 = "";
String vt_parameter_text_2 = "";
String vt_parameter_textarea_1 = "";
String vt_parameter_textarea_2 = "";
String OType = "";
String treeid = "";

String vde_id="";
String vde_starttime = "";//开始时间
String vde_finishtime= "";//结束时间

String vde_img="";



String vde_status="";



vde_status = CTools.dealString(request.getParameter("vde_status")).trim();
vt_id = CTools.dealString(request.getParameter("vt_id")).trim();
vt_name = CTools.dealString(request.getParameter("vt_name")).trim();
vt_type = CTools.dealString(request.getParameter("vt_type")).trim();
vt_upperid = CTools.dealString(request.getParameter("vt_upperid")).trim();
vt_sequence = CTools.dealString(request.getParameter("vt_sequence")).trim();
vt_desc = CTools.dealString(request.getParameter("vt_desc")).trim();
vt_parameter_text_1 = CTools.dealString(request.getParameter("vt_parameter_text_1")).trim();
vt_parameter_text_2 = CTools.dealString(request.getParameter("vt_parameter_text_2")).trim();
vt_parameter_textarea_1 = CTools.dealString(request.getParameter("vt_parameter_textarea_1")).trim();
vt_parameter_textarea_2 = CTools.dealString(request.getParameter("vt_parameter_textarea_2")).trim();
OType = CTools.dealString(request.getParameter("OType")).trim();
treeid = CTools.dealString(request.getParameter("treeid")).trim();
vde_starttime=CTools.dealString(request.getParameter("vde_starttime")).trim();
vde_finishtime=CTools.dealString(request.getParameter("vde_finishtime")).trim(); 
vde_img=CTools.dealString(request.getParameter("vde_img")).trim();



if(OType.equals("Add"))
{
	dImpl.setTableName("tb_votediy");
	dImpl.setPrimaryFieldName("vt_id");
	vt_id = String.valueOf(dImpl.addNew());
	if(vt_upperid.equals("0"))
	{
		Vote vote = new Vote();
		vote.CreateVoteDB(vt_id);
	}
}
if(OType.equals("Edit"))
{
	dImpl.edit("tb_votediy","vt_id",vt_id);
}

if(!vt_upperid.equals("0"))
{
	if(vt_type.equals("radio") || vt_type.equals("checkbox"))
	{
		String tempupperid = vt_upperid;
		String tablename = "";
		while(!tempupperid.equals("0"))
		{
			String sqlStr = "select * from tb_votediy where vt_id= " + tempupperid+"";
			Hashtable content=dImpl.getDataInfo(sqlStr);
			tempupperid = content.get("vt_upperid").toString();
			tablename = "tb_votediy"+content.get("vt_id").toString();
		}
		Vote vote = new Vote();
		out.print(vote.AlterTable(tablename,vt_id,"2","edit"));
	}
	if(vt_type.equals("text") || vt_type.equals("textarea"))
	{
		String tempupperid = vt_upperid;
		String tablename = "";
		while(!tempupperid.equals("0"))
		{
			String sqlStr = "select * from tb_votediy where vt_id= " + tempupperid+"";
			Hashtable content=dImpl.getDataInfo(sqlStr);
			tempupperid = content.get("vt_upperid").toString();
			tablename = "tb_votediy"+content.get("vt_id").toString();
		}
		Vote vote = new Vote();
		vote.AlterTable(tablename,vt_id,"200","edit");
	}
	if(vt_type.equals("title"))
	{
		String tempupperid = vt_upperid;
		String tablename = "";
		while(!tempupperid.equals("0"))
		{
			String sqlStr = "select * from tb_votediy where vt_id= " + tempupperid+"";
			Hashtable content=dImpl.getDataInfo(sqlStr);
			tempupperid = content.get("vt_upperid").toString();
			tablename = "tb_votediy"+content.get("vt_id").toString();
		}
		Vote vote = new Vote();
		vote.AlterTable(tablename,vt_id,"","del");
	}

	if(vt_type.equals("radio"))
		vt_frontpagename = "r"+vt_upperid;
	if(vt_type.equals("checkbox"))
		vt_frontpagename = "c"+vt_upperid;
	if(vt_type.equals("text"))
	{
		vt_frontpagename = "t"+vt_id;
		vt_parameter = vt_parameter_text_1 + "," + vt_parameter_text_2 +",";
	}
	if(vt_type.equals("textarea"))
	{
		vt_frontpagename = "t"+vt_id;
		vt_parameter = vt_parameter_textarea_1 + "," + vt_parameter_textarea_2+",";
	}
	if(vt_type.equals("title"))
		vt_frontpagename = "";
}

dImpl.setValue("vt_name",vt_name,CDataImpl.STRING);
dImpl.setValue("vt_upperid",vt_upperid,CDataImpl.STRING);
dImpl.setValue("vt_type",vt_type,CDataImpl.STRING);
dImpl.setValue("vt_sequence",vt_sequence,CDataImpl.STRING);
dImpl.setValue("vt_dbname","o"+vt_id,CDataImpl.STRING);
dImpl.setValue("vt_frontpagename",vt_frontpagename,CDataImpl.STRING);
dImpl.setValue("vt_desc",vt_desc,CDataImpl.STRING);
dImpl.setValue("vt_parameter",vt_parameter,CDataImpl.STRING);
dImpl.update();
				
if(vt_upperid.equals("0")){
if(OType.equals("Add"))
{
	dImpl.setTableName("tb_votediyext");
	dImpl.setPrimaryFieldName("vde_id");
	vde_id = String.valueOf(dImpl.addNew());
	dImpl.setValue("vde_status","0",CDataImpl.INT);
	dImpl.setValue("vt_id",vt_id,CDataImpl.INT);
DateFormat df = DateFormat.getDateInstance(DateFormat.DEFAULT , Locale.CHINA); 
dImpl.setValue("vde_createtime",df.format(new java.util.Date()),CDataImpl.DATE);

}
if(OType.equals("Edit"))
{
	dImpl.edit("tb_votediyext","vt_id",vt_id);
}
dImpl.setValue("vde_starttime",vde_starttime,CDataImpl.DATE);
dImpl.setValue("vde_finishtime",vde_finishtime,CDataImpl.DATE);
dImpl.setValue("vde_flowimgpath",vde_img,CDataImpl.STRING);

dImpl.update();
}


//======================================================================================================================
//附件上传
//String pr_attachpath  = "";//附件存放的相对路径
//vde_imid=CTools.dealsString(request.getParameter("vde_imid")).trim();
//
//fjName=CTools.dealString(request.getParameter("fjName")).trim();
//if(!fjName.equals(""))
//{
//	fjAddre=myUpload.getRequest().getParameterValues("fjAddre");
//	if(vde_imid.equals("")){
//
//		int count = 0; //上传文件个数
//		if(pa_name!=null)
//		{
//			if (pr_attachpath.equals("")) //附件的存放目录不存在
//			{
//				CDate oDate = new CDate();
//				String sToday = oDate.getThisday();
//				int numeral = 0;
//				numeral =(int)(Math.random()*100000);
//				pr_attachpath = sToday + Integer.toString(numeral);
//				java.io.File newDir = new java.io.File(path + pr_attachpath);
//				if(!newDir.exists())
//				{
//				  newDir.mkdirs();
//				}
//			}
//			count = myUpload.save(path + pr_attachpath,2);//保存文件
//			  //把附件信息写入数据库
//			for(int i=0;i<count;i++)
//			{
//			String fileName = myUpload.getFiles().getFile(i).getFileName();
//			String fileContent = pa_name[i];
//			java.io.File file = new java.io.File(path + pr_attachpath + "\\\\" +fileName);
//			String sId = dImpl.addNew("tb_proceedingattach","pa_id",CDataImpl.PRIMARY_KEY_IS_VARCHAR);
//			dImpl.setValue("pr_id",vde_id,CDataImpl.STRING);  //项目id
//			dImpl.setValue("pa_name",fjName,CDataImpl.STRING);//附件说明
//			dImpl.setValue("pa_path",pr_attachpath,CDataImpl.STRING);//附件存放路径
//			dImpl.setValue("pa_fileName",fjName,CDataImpl.STRING);//附件文件名
//			dImpl.setValue("pa_upload","1",CDataImpl.STRING);//附件是否需要上传
//			dImpl.update();
//			dImpl.setBlobValue("pa_content",file);
//			}
//
//		}
//	}
//}
//======================================================================================================================






if (dCn.getLastErrString().equals(""))
{
	dCn.commitTrans();
	%>
	<script language="javascript">
		//alert("操作已成功");
	<%
	if(treeid.equals(""))
	{
	%>
		window.location.href="list.jsp?upperid=<%=vt_upperid%>&vde_status=<%=vde_status%>&Typepp=1";
	<%
	}
	else
	{
	%>
	window.location.href="listtree.jsp?treeid=<%=treeid%>&vde_status=<%=vde_status%>";
	<%
	}	
	%>
	</script>
	<%
}
else
{
	dCn.rollbackTrans();
	%>
	<script language="javascript">
		alert("发生错误，录入失败！");
		window.history.go(-1);
	</script>
	<%
}

dImpl.closeStmt();
dCn.closeCn();
%>