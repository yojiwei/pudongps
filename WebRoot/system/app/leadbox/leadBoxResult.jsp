<%@page contentType="text/html; charset=GBK"%>
<%@page import="java.sql.*"%>
<%@page import="java.io.*"%>
<%@page import="java.util.*"%>
<%@page import="com.component.database.*"%>
<%@page import="com.util.*"%>
<%@include file="../skin/import.jsp"%>

<%
String OPType = "";
//update20080122
CDataCn dCn=null;   //新建数据库连接对象
CDataImpl dImpl=null;  //新建数据接口对象

try {
 dCn = new CDataCn(); 
 dImpl = new CDataImpl(dCn); 


String in_title = "";
String in_sequence = "";
String in_content = "";
String in_description = "";
String in_id = "";//编号
String ti_id = "";
String in_img_path="";//图片路径	

	com.jspsmart.upload.SmartUpload myUpload = new com.jspsmart.upload.SmartUpload();
	myUpload.initialize(pageContext);
	myUpload.setDeniedFilesList("rar,zip,exe,bat,jsp");//设置上传文件后缀限制
	myUpload.upload();

  String is_img = CTools.dealUploadString(myUpload.getRequest().getParameter("is_img")).trim();//是否是img
  in_id = CTools.dealNumber(myUpload.getRequest().getParameter("in_id")).trim();//编号
  OPType = CTools.dealUploadString(myUpload.getRequest().getParameter("OPType")).trim();//操作方式 Add是添加 Edit是修改
  in_title = CTools.dealUploadString(myUpload.getRequest().getParameter("in_title")).trim();//主题
  in_description = CTools.dealUploadString(myUpload.getRequest().getParameter("in_description")).trim();  
  in_img_path = CTools.dealUploadString(myUpload.getRequest().getParameter("in_img_path")).trim();
  ti_id = CTools.dealNumber(myUpload.getRequest().getParameter("ti_id")).trim();//所属栏目
  in_content = CTools.unHtmlEncode(CTools.dealUploadString(myUpload.getRequest().getParameter("in_content")).trim());//☆☆☆★★★内容★★★☆☆☆
  in_sequence = CTools.dealNumber(myUpload.getRequest().getParameter("in_sequence")).trim();
  try
  {
	dCn.beginTrans();

	String path = dImpl.getInitParameter("images_save_path");
	int count = myUpload.getFiles().getCount(); //上传文件个数
	
	CDate oDate = new CDate();
	String sToday = oDate.getThisday();
  //out.println(path+"--"+in_img_path);
  //if(true)return; 
	if(count!=0){
				if(in_img_path.equals(""))
				{
					//附件的存放目录不存在
					
					int numeral = 0;
					numeral =(int)(Math.random()*100000);
					in_img_path = sToday + Integer.toString(numeral);
					java.io.File newDir = new java.io.File(path + in_img_path);
					if(!newDir.exists())
					{
						newDir.mkdirs();
					}
				}else{
					//附件的存放目录存在
					java.io.File newDir = new java.io.File(path + in_img_path);
					if(!newDir.exists())
					{
						newDir.mkdirs();
					}	
				}
				count = myUpload.save(path + in_img_path,2);//保存文件	
		}


		dImpl.setTableName("tb_info");
    dImpl.setPrimaryFieldName("in_id");
    if (OPType.equals("Add"))
		{
			in_id = Long.toString(dImpl.addNew());
		}
    else if (OPType.equals("Edit"))
    {
      dImpl.edit("tb_info","in_id",Integer.parseInt(in_id));

    }

	dImpl.setValue("in_title",in_title,CDataImpl.STRING);
	dImpl.setValue("in_description",in_description,CDataImpl.STRING);
	dImpl.setValue("in_inputtime",sToday,CDataImpl.DATE);
	dImpl.setValue("in_img_path",in_img_path,CDataImpl.STRING);
	dImpl.setValue("ti_id",ti_id,CDataImpl.INT);
  dImpl.setValue("in_content",in_content,CDataImpl.SLONG);
	dImpl.setValue("in_sequence",in_sequence,CDataImpl.INT);	
  dImpl.update() ;

dCn.commitTrans();
//关闭
dImpl.closeStmt();
dCn.closeCn();

		if(is_img.equals("1"))
		{
			response.sendRedirect("leadBoxInfo.jsp?OPType=Edit&in_id="+in_id);
		}
  	else
  	{
			response.sendRedirect("leadBoxList.jsp");
		}
  }
  catch(Exception e)
  {
    out.println("error message:" + e.getMessage() +e.toString());
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