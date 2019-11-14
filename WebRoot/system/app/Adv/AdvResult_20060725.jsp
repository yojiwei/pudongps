<%@page contentType="text/html;charset=GBK"%>
<%@include file="../skin/head.jsp"%>
<%
CDataCn dCn = new CDataCn();
CDataImpl dImpl = new CDataImpl(dCn);
java.util.Date ai_date = new java.util.Date();

String OPType = "";
String path = "";
String ai_id = "";
String ai_name = "";
String ai_type = "";
String ai_position = "";
String ai_memo = "";
String ai_script = "";
String ai_filepath = "";
String ai_filename = "";
String ai_isok = "";
String ai_pri = "";

String ai_urllink = "";
String ai_content = "";
String ai_islink = "";
String ai_start_time = "";
String ai_end_time = "";

String ai_start_timehx = "";
String ai_start_timeex = "";

String ai_end_timehx = "";
String ai_end_timeex = "";

com.jspsmart.upload.SmartUpload myUpload = new com.jspsmart.upload.SmartUpload();
myUpload.initialize(pageContext);
myUpload.setDeniedFilesList("exe,bat,jsp");//设置上传文件后缀限制

myUpload.upload();

OPType = CTools.dealNull(myUpload.getRequest().getParameter("OPType")).trim();
ai_id = CTools.dealNumber(myUpload.getRequest().getParameter("ai_id")).trim();
ai_name = CTools.dealNull(myUpload.getRequest().getParameter("ai_name")).trim();
ai_type = CTools.dealNumber(myUpload.getRequest().getParameter("ai_type")).trim();
ai_position = CTools.dealNumber(myUpload.getRequest().getParameter("ai_position")).trim();
ai_memo = CTools.dealNull(myUpload.getRequest().getParameter("ai_memo")).trim();
ai_script = CTools.dealNull(myUpload.getRequest().getParameter("ai_script")).trim();
ai_isok = CTools.dealNull(myUpload.getRequest().getParameter("ai_isok")).trim();
ai_filepath = CTools.dealString(myUpload.getRequest().getParameter("ai_filepath")).trim();
ai_filename = CTools.dealString(myUpload.getRequest().getParameter("file_name")).trim();

ai_urllink = CTools.dealString(myUpload.getRequest().getParameter("ai_urllink")).trim();
ai_islink = CTools.dealString(myUpload.getRequest().getParameter("ai_islink")).trim();

ai_pri = CTools.dealString(myUpload.getRequest().getParameter("ai_pri")).trim();

ai_start_timehx = CTools.dealString(myUpload.getRequest().getParameter("ai_start_timehx")).trim();
ai_start_timeex = CTools.dealString(myUpload.getRequest().getParameter("ai_start_timeex")).trim();
ai_end_timehx = CTools.dealString(myUpload.getRequest().getParameter("ai_end_timehx")).trim();
ai_end_timeex = CTools.dealString(myUpload.getRequest().getParameter("ai_end_timeex")).trim();

//out.println(ai_filepath+ai_filename);

if(ai_start_timehx.equals(""))
{
	ai_start_timehx = "1900-01-01";
}

if(ai_end_timehx.equals(""))
{
	ai_end_timehx = "2999-12-30";
}

ai_start_time = ai_start_timehx + " " + ai_start_timeex + ":00";
ai_end_time = ai_end_timehx + " " + ai_end_timeex + ":00";

dCn.beginTrans();

path = dImpl.getInitParameter("adv_save_path");

//out.println(path);


if(ai_filename.equals(""))
{
	ai_filename = myUpload.getFiles().getFile(0).getFileName();
	if (ai_filepath.equals("")) //附件的存放目录不存在
	{
		CDate oDate = new CDate();
		String sToday = oDate.getThisday();
		int numeral = 0;
		numeral =(int)(Math.random()*100000);
		ai_filepath = sToday + Integer.toString(numeral);
		java.io.File newDir = new java.io.File(path + ai_filepath);
		if(!newDir.exists())
		{
		  newDir.mkdirs();
		}
	}
	myUpload.save(path + ai_filepath);//保存文件
	//java.io.File file = new java.io.File(path + ai_filepath + "\\\\" +ai_filename);
}

//String sql = "update tb_advinfo set ai_isok='0' where ai_position="+ai_position+" and ai_isok='1'";
//一个广告位置只能发布一个广告START
/*dImpl.edit("tb_advinfo","ai_position",Integer.parseInt(ai_position));
dImpl.setValue("ai_isok","0",CDataImpl.STRING);
dImpl.update();*/
//END
dImpl.setTableName("tb_advinfo");
dImpl.setPrimaryFieldName("ai_id");
if(OPType.equals("Addnew"))
{
	ai_id = Long.toString(dImpl.addNew());
}
else if(OPType.equals("Edit"))
{
	dImpl.edit("tb_advinfo","ai_id",Integer.parseInt(ai_id));
}
dImpl.setValue("ai_name",ai_name,CDataImpl.STRING);
dImpl.setValue("ai_type",ai_type,CDataImpl.INT);
dImpl.setValue("ai_position",ai_position,CDataImpl.INT);
dImpl.setValue("ai_memo",ai_memo,CDataImpl.STRING);
dImpl.setValue("ai_isok",ai_isok,CDataImpl.STRING);
dImpl.setValue("ai_filepath",ai_filepath,CDataImpl.STRING);//附件存放路径
dImpl.setValue("ai_filename",ai_filename,CDataImpl.STRING);//附件文件名
dImpl.setValue("ai_date",ai_date.toLocaleString(),CDataImpl.DATE);

dImpl.setValue("ai_start_timehx",ai_start_timehx,CDataImpl.STRING);
dImpl.setValue("ai_start_timeex",ai_start_timeex,CDataImpl.STRING);
dImpl.setValue("ai_start_time",ai_start_time,CDataImpl.DATE);

dImpl.setValue("ai_end_timehx",ai_end_timehx,CDataImpl.STRING);
dImpl.setValue("ai_end_timeex",ai_end_timeex,CDataImpl.STRING);
dImpl.setValue("ai_end_time",ai_end_time,CDataImpl.DATE);

dImpl.setValue("ai_islink",ai_islink,CDataImpl.STRING);
dImpl.setValue("ai_urllink",ai_urllink,CDataImpl.STRING);
dImpl.setValue("ai_pri",ai_pri,CDataImpl.INT);
dImpl.update();


if (dCn.getLastErrString().equals(""))
{
	dCn.commitTrans();
	dImpl.setClobValue("ai_script",ai_script);
	%>
	<script language="javascript">
		alert("操作已成功！");
		window.location="<%=()?"":""%>AdvList.jsp";
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
//response.sendRedirect("workshoplist.jsp");
%>