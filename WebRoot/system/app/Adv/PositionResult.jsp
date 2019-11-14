<%@page contentType="text/html;charset=GBK"%>
<%@include file="../skin/head.jsp"%>
<%
CDataCn dCn = new CDataCn();
CDataImpl dImpl = new CDataImpl(dCn);

String OPType = "";
String ap_id = "";
String ap_name = "";
String ap_code = "";
String ap_width = "";
String ap_height = "";
String ap_memo = "";
String ap_type = "";
String ap_form = "";
String ap_display = "";
String ap_filename = "";
String ap_filepath = "";

com.jspsmart.upload.SmartUpload myUpload = new com.jspsmart.upload.SmartUpload();
myUpload.initialize(pageContext);
myUpload.setDeniedFilesList("exe,bat,jsp");//设置上传文件后缀限制
myUpload.upload();

String rd = CTools.dealString(request.getParameter("rd")).trim();					//保存后返回页面

OPType = CTools.dealNull(myUpload.getRequest().getParameter("OPType")).trim();
ap_id = CTools.dealNull(myUpload.getRequest().getParameter("ap_id")).trim();
ap_name = CTools.dealNull(myUpload.getRequest().getParameter("ap_name")).trim();
ap_code = CTools.dealNull(myUpload.getRequest().getParameter("ap_code")).trim();
ap_width = CTools.dealNull(myUpload.getRequest().getParameter("ap_width")).trim();
ap_height = CTools.dealNull(myUpload.getRequest().getParameter("ap_height")).trim();
ap_memo = CTools.dealNull(myUpload.getRequest().getParameter("ap_memo")).trim();
ap_type = CTools.dealNull(myUpload.getRequest().getParameter("ap_type")).trim();
ap_form = CTools.dealNull(myUpload.getRequest().getParameter("ap_form")).trim();
ap_display = CTools.dealNull(myUpload.getRequest().getParameter("ap_display")).trim();
ap_filename = CTools.dealNull(myUpload.getRequest().getParameter("file_name")).trim();
ap_filepath = CTools.dealNull(myUpload.getRequest().getParameter("ap_filepath")).trim();

  String userFileIds = CTools.dealNull(myUpload.getRequest().getParameter("userFileIds")).trim();	//维护用户id

dCn.beginTrans();

if(!ap_display.equals("0"))
{
	String path = dImpl.getInitParameter("adv_save_path");

	if(ap_filename.equals(""))
	{
		ap_filename = myUpload.getFiles().getFile(0).getFileName();
		if (ap_filepath.equals("")) //附件的存放目录不存在
		{
			CDate oDate = new CDate();
			String sToday = oDate.getThisday();
			int numeral = 0;
			numeral =(int)(Math.random()*100000);
			ap_filepath = sToday + Integer.toString(numeral);
			java.io.File newDir = new java.io.File(path + ap_filepath);
			if(!newDir.exists())
			{
			  newDir.mkdirs();
			}
		}
		myUpload.save(path + ap_filepath);//保存文件
		//java.io.File file = new java.io.File(path + ai_filepath + "\\\\" +ai_filename);
	}
}

dImpl.setTableName("tb_advposition");
dImpl.setPrimaryFieldName("ap_id");
if(OPType.equals("Addnew"))
{
	ap_id = Long.toString(dImpl.addNew());
}
else if(OPType.equals("Edit"))
{
	dImpl.edit("tb_advposition","ap_id",Integer.parseInt(ap_id));
}
dImpl.setValue("ap_name",ap_name,CDataImpl.STRING);
dImpl.setValue("ap_code",ap_code,CDataImpl.STRING);
dImpl.setValue("ap_width",ap_width,CDataImpl.STRING);
dImpl.setValue("ap_height",ap_height,CDataImpl.STRING);
dImpl.setValue("ap_memo",ap_memo,CDataImpl.STRING);
dImpl.setValue("ap_form",ap_form,CDataImpl.STRING);
dImpl.setValue("ap_display",ap_display,CDataImpl.STRING);
if(!ap_display.equals("0"))
{
	dImpl.setValue("ap_type",ap_type,CDataImpl.STRING);
	dImpl.setValue("ap_filepath",ap_filepath,CDataImpl.STRING);//附件存放路径
	dImpl.setValue("ap_filename",ap_filename,CDataImpl.STRING);//附件文件名
}
dImpl.setValue("ur_id",userFileIds,CDataImpl.STRING);//上级栏目代码

dImpl.update();

if (dCn.getLastErrString().equals(""))
{
	dCn.commitTrans();
	%>
	<script language="javascript">
		alert("操作已成功！");
		<%if (rd.equals("1")) {%>
		window.location="PositionInfo.jsp?OPType=Addnew";
		<%}else{%>
		window.location="PositionList.jsp";
		<%}%>
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