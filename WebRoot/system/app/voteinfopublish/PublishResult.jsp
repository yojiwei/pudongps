<%@page contentType="text/html; charset=GBK"%>
<%@ page import="com.beyondbit.web.publishinfo.PublishOperate" %>
<%@ page import="com.beyondbit.web.form.TaskInfoForm" %>
<%@ page import="com.beyondbit.web.publishinfo.Messages" %>
<%@include file="../skin/head.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<%
CDataCn dCn = null;
CDataImpl dImpl = null;
try{
dCn = new CDataCn();
dImpl = new CDataImpl(dCn);

	com.beyondbit.web.form.PublishForm publishform = new com.beyondbit.web.form.PublishForm();
	TaskInfoForm taskinfoform = new TaskInfoForm();
	PublishOperate operate = new PublishOperate();
	com.jspsmart.upload.SmartUpload myUpload = new com.jspsmart.upload.SmartUpload();
	myUpload.initialize(pageContext);
	myUpload.setDeniedFilesList("exe,bat,jsp");
	myUpload.upload();

	String redirectURL = "";
	String OPType = CTools.dealUploadString(myUpload.getRequest().getParameter("OPType")); 
	String ct_title = CTools.dealUploadString(myUpload.getRequest().getParameter("ct_title"));	
	String sj_id = CTools.dealUploadString(myUpload.getRequest().getParameter("sj_id"));		
	String ct_inserttime = CTools.dealUploadString(myUpload.getRequest().getParameter("ct_inserttime"));	
	String ctContent = CTools.dealUploadString(myUpload.getRequest().getParameter("CT_content"));
	String ctImgpath = CTools.dealUploadString(myUpload.getRequest().getParameter("ctImgpath"));
	String ct_id = CTools.dealUploadString(myUpload.getRequest().getParameter("ct_id"));
  String th_id = CTools.dealUploadString(myUpload.getRequest().getParameter("th_id"));
	String filePath = CTools.dealUploadString(myUpload.getRequest().getParameter("filePath"));
  String th_powercode = CTools.dealUploadString(myUpload.getRequest().getParameter("powercode"));
	String oldth_powercode = CTools.dealUploadString(myUpload.getRequest().getParameter("oldth_powercode"));
	String cn_id = CTools.dealUploadString(myUpload.getRequest().getParameter("cn_id"));
	String cd_id = CTools.dealUploadString(myUpload.getRequest().getParameter("cd_id"));

	if(session.getAttribute("temppath")!=null){
		ctImgpath = (String)session.getAttribute("temppath");
		session.setAttribute("temppath",null);
	}

	String [] filename = null;
	String [] fileRealName = null;	
	
	String path = dImpl.getInitParameter("tpfileattach");
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
	
dCn.beginTrans();
//－－－－－－－－tb_content表
dImpl.setTableName("tb_content");
dImpl.setPrimaryFieldName("ct_id");
if(OPType.equals("Add")) //新增
{
	ct_id = Long.toString(dImpl.addNew());	
}
else if(OPType.equals("Edit"))
{
	dImpl.edit("tb_content","ct_id",Integer.parseInt(ct_id));
}
dImpl.setValue("sj_id",sj_id,CDataImpl.STRING);
dImpl.setValue("ct_inserttime",ct_inserttime,CDataImpl.STRING);
dImpl.setValue("ct_img_path",ctImgpath,CDataImpl.STRING);
dImpl.setValue("ct_filepath",filePath,CDataImpl.STRING);
dImpl.setValue("ct_title",ct_title,CDataImpl.STRING);
dImpl.update();
//－－－－－－－－－tb_contentdetail表
dImpl.setTableName("tb_contentdetail");
dImpl.setPrimaryFieldName("cd_id");
if(OPType.equals("Add")) //新增
{
	cd_id = Long.toString(dImpl.addNew());	
}
 if(OPType.equals("Edit"))
{
	dImpl.edit("tb_contentdetail","cd_id",Integer.parseInt(cd_id));
}
dImpl.setValue("ct_id",ct_id,CDataImpl.INT);
dImpl.update();
dImpl.setClobValue("ct_content",ctContent);
//－－－－－－－－－－tb_relate表
if(OPType.equals("Add"))
{
   cn_id=dImpl.addNew("tb_relate","cn_id",CDataImpl.PRIMARY_KEY_IS_VARCHAR);
 }
 if(OPType.equals("Edit"))
{
	dImpl.edit("tb_relate","cn_id",Integer.parseInt(cn_id));
}
dImpl.setValue("th_powercode",th_powercode,CDataImpl.STRING);
dImpl.update();
//－－－－－－－－－－－tb_voteadvanced表
if(OPType.equals("Add"))
{
   dImpl.setTableName("tb_voteadvanced");
   dImpl.setPrimaryFieldName("va_id");
   dImpl.addNew();	
   dImpl.setValue("va_votenum","0",CDataImpl.INT);
   dImpl.setValue("va_votetotalnum","0",CDataImpl.INT);
   dImpl.setValue("ct_id",ct_id,CDataImpl.INT); 
   dImpl.update();
}
//-----------------tb_image表
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
		
		 dImpl.setTableName("tb_image");
		 dImpl.setPrimaryFieldName("im_id");
		 dImpl.addNew();	
		 dImpl.setValue("im_path",filePath,CDataImpl.STRING);
		 dImpl.setValue("im_filename",filename[i],CDataImpl.STRING);
		 dImpl.setValue("im_name",realName,CDataImpl.STRING);
		 dImpl.setValue("ct_id",ct_id,CDataImpl.STRING); 
		 dImpl.update();
	}
	

dCn.commitTrans();	
if (dCn.getLastErrString().equals(""))
{
%>
<script language="javascript">
	alert("操作已成功！");
	window.location="Personlist1.jsp?th_id=<%=th_id%>&th_powercode=<%=oldth_powercode%>";
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
}
catch(Exception e){
	out.print(e.toString());
}
finally{
dImpl.closeStmt();
dCn.closeCn(); 
}
%>
  </body>
</html>
