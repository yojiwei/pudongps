<%@page contentType="text/html;charset=GBK"%>
<%@include file="../skin/head.jsp"%>
<%
CDataCn dCn = new CDataCn();
CDataImpl dImpl = new CDataImpl(dCn);

String OPType = "";
String path = "";
String ai_id = "";
String ai_name = "";
String ai_type = "";
String ai_position = "";
String ai_memo = "";
String ai_filepath = "";
String ai_filename = "";
String ai_isok = "";

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
ai_isok = CTools.dealNull(myUpload.getRequest().getParameter("ai_isok")).trim();
ai_filepath = CTools.dealNull(myUpload.getRequest().getParameter("ai_filepath")).trim();
ai_filename = CTools.dealNull(myUpload.getRequest().getParameter("ai_filename")).trim();

dCn.beginTrans();

path = dImpl.getInitParameter("adv_save_path");
ai_filename = myUpload.getFiles().getFile(0).getFileName();

if(!ai_filename.equals(""))
{
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
	java.io.File file = new java.io.File(path + ai_filepath + "\\\\" +ai_filename);
}
dImpl.setTableName("tb_advinfo");
dImpl.setPrimaryFieldName("ai_id");
if(OPType.equals("Addnew"))
{
	ai_id = Long.toString(dImpl.addNew());
}
else if(OPType.equals("Edit"))
{
	dImpl.edit("tbl_advinfo","ai_id",Integer.parseInt(ai_id));
}
dImpl.setValue("ai_name",ai_name,CDataImpl.STRING);
dImpl.setValue("ai_type",ai_type,CDataImpl.INT);
dImpl.setValue("ai_position",ai_position,CDataImpl.INT);
dImpl.setValue("ai_memo",ai_memo,CDataImpl.STRING);
dImpl.setValue("ai_isok",ai_isok,CDataImpl.STRING);
dImpl.setValue("ai_filepath",ai_filepath,CDataImpl.STRING);//附件存放路径
dImpl.setValue("ai_filename",ai_filename,CDataImpl.STRING);//附件文件名

dImpl.update();

if (dCn.getLastErrString().equals(""))
{
	dCn.commitTrans();
	%>
	<script language="javascript">
		alert("操作已成功！");
		window.location="AdvList.jsp";
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