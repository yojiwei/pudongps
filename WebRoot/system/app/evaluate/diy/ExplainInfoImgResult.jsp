<%@page contentType="text/html; charset=GBK"%>
<%@include file="../../skin/import.jsp"%>
<%
//update20080122

CDataCn dCn=null;   //新建数据库连接对象
CDataImpl dImpl=null;  //新建数据接口对象

try {
 dCn = new CDataCn(); 
 dImpl = new CDataImpl(dCn); 

dCn.beginTrans();
String path = dImpl.getInitParameter("images_save_path"); //获取路径
try
{
	String sDocument = "";
	String sSavePath = "";
	String vde_pp="";
	com.jspsmart.upload.SmartUpload myUpload = new com.jspsmart.upload.SmartUpload();
	
	int count=0;//上传文件个数
	myUpload.initialize(pageContext);
	myUpload.setDeniedFilesList("exe,bat,jsp");//设置上传文件后缀限制
	myUpload.upload();
	vde_pp = CTools.dealUploadString(myUpload.getRequest().getParameter("vde_pp")).trim();
	sDocument = CTools.dealUploadString(myUpload.getRequest().getParameter("vde_img")).trim();
	if (sDocument == null || sDocument.equals("") )
	{
		  CDate oDate = new CDate();
		  String sToday = oDate.getThisday();
		  int numeral = 0;
		  numeral =(int)(Math.random()*100000);
		  sDocument = sToday + Integer.toString(numeral);
	}
	sSavePath = path + sDocument;
	java.io.File newDir=new java.io.File(sSavePath);
	if(!newDir.exists())
	{
	      newDir.mkdirs();
	}
	count = myUpload.save(sSavePath,2);
	for (int i=0;i<count;i++)
	{
	      String fileName = myUpload.getFiles().getFile(i).getFileName();
	      dImpl.addNew("tb_image","im_id",CDataImpl.PRIMARY_KEY_IS_VARCHAR);
	      dImpl.setValue("im_path",sDocument,CDataImpl.STRING);
	      dImpl.setValue("im_filename",fileName,CDataImpl.STRING);
	      dImpl.update();
	      java.io.File file = new java.io.File(sSavePath + "\\\\" +fileName);
	      dImpl.setBlobValue("im_content",file);
	}
	dCn.commitTrans();
	dImpl.closeStmt();
	dCn.closeCn();
	response.sendRedirect("ExplainInfoImg.jsp?vde_img="+sDocument+"&vde_pp="+vde_pp);
}
catch (Exception e)
{
	out.print(e.getMessage());
}
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
