<%@page contentType="text/html; charset=GBK"%>
<%@include file="/website/include/import.jsp"%>
<%
String path              = "";
String fileName          = "";
String DL_directory_name = "";
String sqlStr            = "";
String pr_id             = "";
String wo_id             = "";
String wa_id             = "";
boolean successDel       = false;

com.jspsmart.upload.SmartUpload myUpload = new com.jspsmart.upload.SmartUpload();
int count=0;//上传文件个数
try{
myUpload.initialize(pageContext);
myUpload.setDeniedFilesList("exe,bat,jsp");//设置上传文件后缀限
myUpload.setAllowedFilesList("txt,doc,docx,jpg,jpeg,gif,png,bmp,xls");

myUpload.upload();

pr_id = CTools.dealUploadString(myUpload.getRequest().getParameter("pr_id")).trim();
wo_id = CTools.dealUploadString(myUpload.getRequest().getParameter("wo_id")).trim();  
wa_id = CTools.dealUploadString(myUpload.getRequest().getParameter("wa_id")).trim();//附件id
fileName = CTools.dealUploadString(myUpload.getRequest().getParameter("fileName")).trim();
DL_directory_name =CTools.dealUploadString(myUpload.getRequest().getParameter("wa_path")).trim();
path = CTools.dealUploadString(myUpload.getRequest().getParameter("initPath")).trim();

//Update 20061231
CDataCn dCn = null;
CDataImpl dImpl = null;
try{
dCn = new CDataCn();
dImpl = new CDataImpl(dCn); 
//从文件夹中删除该文件 
File delFile = new File(path+DL_directory_name+"\\\\"+fileName);
successDel = delFile.delete();

//保存文件 
count = myUpload.save(path + DL_directory_name,2);//保存文件

//修改数据库中该文件的记录
if (count>0)
{
	if (!wa_id.equals(""))
	{
		fileName = myUpload.getFiles().getFile(0).getFileName();
		File file = new File(path+DL_directory_name+"\\\\"+fileName);
		dCn.beginTrans();
		dImpl.edit("tb_workattach","wa_id",wa_id);
		dImpl.setValue("wa_fileName",fileName,CDataImpl.STRING);
		dImpl.update();
		dImpl.setBlobValue("wa_content",file);
		if(dCn.getLastErrString().equals(""))
		{
			dCn.commitTrans();
		}
		else
		{
			dCn.rollbackTrans();
		}
	}
}

}
catch(Exception e){
//e.printStackTrace();
out.print(e.toString());
}
finally{
dImpl.closeStmt();
dCn.closeCn(); 
}

%>
<script language="javascript">
alert("文件更新成功！");
window.location="<%=("ProjectUpdate.jsp?wa_id="+wa_id)%>";
</script>
<%
}catch(SecurityException se){
%>
	<script language="javascript">
	alert("您上传的附件格式不符合要求,请重新选择！");
	window.history.back();
	</script>
<%
  }
%>