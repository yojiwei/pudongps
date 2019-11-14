<%@include file="/system/app/skin/import.jsp"%>
<%@ page contentType="text/html; charset=GBK"%>
<%
  java.util.Date FinishTime = new java.util.Date();
  
  com.jspsmart.upload.SmartUpload myUpload = new com.jspsmart.upload.SmartUpload();
  myUpload.initialize(pageContext);
  myUpload.setDeniedFilesList("exe,bat,jsp");//设置上传文件后缀限制
  myUpload.upload();
  
  //获得时间
  DateFormat df = DateFormat.getDateInstance(DateFormat.DEFAULT , Locale.CHINA);
  String IN_showtime = df.format(new java.util.Date());

  //String io_id = CTools.dealUploadString(myUpload.getRequest().getParameter("io_id")).trim();
  String io_id = request.getParameter("io_id");
  //out.println("id=" + io_id);
  String io_reback = CTools.dealUploadString(myUpload.getRequest().getParameter("io_reback")).trim();
  String io_reback_kind =  CTools.dealUploadString(myUpload.getRequest().getParameter("io_reback_kind")).trim();
  String if_nick_name = CTools.dealUploadString(myUpload.getRequest().getParameter("fj1")).trim();
  String if_path = "";   //附件存放目录

//update20080122

CDataCn dCn=null;   //新建数据库连接对象
CDataImpl dImpl=null;  //新建数据接口对象

try {
 dCn = new CDataCn(); 
 dImpl = new CDataImpl(dCn); 
  String path = dImpl.getInitParameter("workattach_save_path"); //附件存放默认路径
  
  dImpl.edit("tb_infoOpen","io_id",io_id);
  dImpl.setValue("io_status","3",CDataImpl.STRING);//办理状态
  dImpl.setValue("io_reback ",io_reback,CDataImpl.STRING); //反馈信息
  dImpl.setValue("io_reback_kind ",io_reback_kind,CDataImpl.STRING); //反馈信息类别
  dImpl.setValue("io_reback_time",IN_showtime,CDataImpl.STRING); //处理完成时间
  dImpl.update();
  
  //保存附件到指定目录
int count = myUpload.getFiles().getCount();
if (count>0)
{
	if (if_path.equals("")) //附件的存放目录不存在
	{
		CDate oDate = new CDate();
		String sToday = oDate.getThisday();
		int numeral = 0;
		numeral =(int)(Math.random()*100000);
		if_path = sToday + Integer.toString(numeral);
		java.io.File newDir = new java.io.File(path + if_path);
		if(!newDir.exists()) //如果目录不存在，则生成目录
		{
		  newDir.mkdirs();
		}
	}
	count = myUpload.save(path + if_path,2);//保存文件
	
	if (count>0)
	{
		//规定上传的附件及其相关信息存放到tbinfoFile表里
		if (io_id!=null)
		{
			        dCn.beginTrans();	
				String fileName = myUpload.getFiles().getFile(0).getFileName();
				//out.println(fileName);
				//out.close();
				java.io.File file = new java.io.File(path + if_path + "\\" + fileName);
				dImpl.addNew("tb_infoFile","if_id",CDataImpl.PRIMARY_KEY_IS_VARCHAR);
				//dImpl.setValue("if_id",if_id,CDataImpl.STRING);    //项目id
				dImpl.setValue("if_path",if_path,CDataImpl.STRING);  //附件存放路径
				dImpl.setValue("if_name",fileName,CDataImpl.STRING);  //附件文件名
				dImpl.setValue("io_id",io_id,CDataImpl.STRING);
				dImpl.setValue("if_nick_name",fileName,CDataImpl.STRING);
				dImpl.setValue("if_kind","1",CDataImpl.STRING);  //类别
				dImpl.update();
				dImpl.setBlobValue("if_content",file);
				dCn.commitTrans();		
		}
	}
}
 // 
  

  dImpl.closeStmt();
  dCn.closeCn();
  } catch (Exception ex) {
	System.out.println(new java.util.Date() + "--"
			+ request.getServletPath() + " : " + ex.getMessage());
} finally {
	if(dImpl != null)
	dImpl.closeStmt();
	if(dCn != null)
	dCn.closeCn();
}
  response.sendRedirect("OpenList.jsp?io_status=3");
%>