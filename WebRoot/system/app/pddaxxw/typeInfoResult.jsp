<%@ page contentType="text/html; charset=GBK" %>
<%@include file="../skin/head.jsp"%>
<%
//update 20091103

CDataCn dCn=null;   //新建数据库连接对象
CDataImpl dImpl=null;  //新建数据接口对象
String ty_id="";
String ty_name="";
String optype = "";
String ty_ispublic = "";
String ty_imgrealname = "";
String ty_imgpath = "";
com.jspsmart.upload.SmartUpload uploader = new com.jspsmart.upload.SmartUpload();
try {
dCn = new CDataCn(); 
dImpl = new CDataImpl(dCn); 

uploader.initialize(pageContext);
uploader.setDeniedFilesList("exe,bat,jsp");//设置上传文件后缀限
uploader.setAllowedFilesList("jpg,jpeg,gif,png,bmp");
uploader.setMaxFileSize(2097152);
uploader.upload();

optype = CTools.dealUploadString(uploader.getRequest().getParameter("OPType")).trim();
ty_id = CTools.dealUploadString(uploader.getRequest().getParameter("ty_id")).trim();
ty_name = CTools.dealUploadString(uploader.getRequest().getParameter("ty_name")).trim();
ty_ispublic = CTools.dealUploadString(uploader.getRequest().getParameter("ty_ispublic")).trim();
ty_imgpath = CTools.dealUploadString(uploader.getRequest().getParameter("ty_imgpath")).trim();
ty_imgrealname = CTools.dealUploadString(uploader.getRequest().getParameter("ty_imgrealname")).trim();


		//生成日期加随机数
	 	CDate date = new CDate();
	 	String wa_path = "";
	 	String random_realName = "";
	  String today = date.getThisday();
	  String path = dImpl.getInitParameter("workattach_save_path");//档案局征集图片放置路径
	  int numeral = 0;
	  numeral = (int)(Math.random()*1000000); 
	  wa_path = today + Integer.toString(numeral);//日期+随机
	  //
	  int count = uploader.getFiles().getCount(); 
	  int savedCount = 0;
	  if(count > 0){
		 java.io.File fileDir = new java.io.File(path + wa_path);
		 if( !fileDir.exists() ){//如果文件不存在，创建
						fileDir.mkdirs();
			}
		  savedCount = uploader.save(path+wa_path,2);
		  if(savedCount > 0){
				String fileName = uploader.getFiles().getFile(0).getFileName();
				java.io.File file = new java.io.File(path + wa_path +"\\"+ fileName);
				int random_filenum =(int)(Math.random()*1000000);
				
				random_realName = today + Integer.toString(random_filenum) + fileName.substring(fileName.indexOf("."));
				java.io.File random_file = new java.io.File(path + wa_path + "\\\\" + random_realName);
			  file.renameTo(random_file);
		  }
		}

	if(optype.equals("Edit"))
	{
		dImpl.edit("tb_daxxtype","ty_id",ty_id);
	}
	else
	{
		dImpl.addNew("tb_daxxtype","ty_id");
	}
	
	dImpl.setValue("ty_name",ty_name,CDataImpl.STRING);
	dImpl.setValue("ty_ispublic",ty_ispublic,CDataImpl.STRING);
	if(savedCount > 0){
		dImpl.setValue("ty_imgpath",wa_path,CDataImpl.STRING);
		dImpl.setValue("ty_imgrealname",random_realName,CDataImpl.STRING);
	}
	dImpl.update();


} catch (Exception ex) {
	System.out.println(new java.util.Date() + "--"
			+ request.getServletPath() + " : " + ex.getMessage());
} finally {
	if(dImpl != null)
	dImpl.closeStmt();
	if(dCn != null)
	dCn.closeCn();
}
%>
<script language="javascript">
window.location.href="typeList.jsp";
</script>
<%@include file="../skin/bottom.jsp"%>