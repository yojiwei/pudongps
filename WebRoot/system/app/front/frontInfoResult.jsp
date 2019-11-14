<%@page contentType="text/html; charset=GBK"%>
<%@include file="../skin/head.jsp"%>
<%@ page import="com.beyondbit.web.form.TaskInfoForm" %>
<%@ page import="com.beyondbit.web.publishinfo.PublishOperate" %>
<%@ page import="java.awt.Image" %>
<%@ page import="java.awt.image.BufferedImage" %>
<%@ page import="java.io.File" %>
<%@ page import="java.io.FileOutputStream" %>
<%@ page import="javax.imageio.ImageIO" %>
<%@ page import="com.sun.image.codec.jpeg.JPEGCodec" %>
<%@ page import="com.sun.image.codec.jpeg.JPEGImageEncoder" %>

<%
String actiontype,fi_id,fi_title,fi_url,fi_sequence,fi_content,list_id,fi_type,path;
String frim_path = ""; //文件路径
String frim_name = ""; //文件名
String frim_id = ""; //文件id
String frim_filename =""; //转换后的新文件名
 CDataCn dCn = new CDataCn(); //新建数据库连接对象
  CDataImpl dImpl = new CDataImpl(dCn); //新建数据接口对象
  CDataImpl dImpl_new = new CDataImpl(dCn); //新建数据接口对象

  com.beyondbit.web.form.PublishForm publishform = new com.beyondbit.web.form.PublishForm();
  TaskInfoForm taskinfoform = new TaskInfoForm();
  PublishOperate operate = new PublishOperate();
  com.jspsmart.upload.SmartUpload myUpload = new com.jspsmart.upload.SmartUpload();

  myUpload.initialize(pageContext);
  myUpload.upload();
   frim_id =CTools.dealUploadString(myUpload.getRequest().getParameter("frim_id"));//图片ID
   actiontype = CTools.dealString(myUpload.getRequest().getParameter("actiontype")).trim();//存储类型

  String zoomPic = CTools.dealString(myUpload.getRequest().getParameter("zoomPic")).trim();  //07.11.13胡刚（缩略图）
  String z_wh = CTools.dealString(myUpload.getRequest().getParameter("z_width")).trim(); //07.11.13胡刚（缩略图）
  String zp_para = CTools.dealString(myUpload.getRequest().getParameter("zip_para")).trim(); //07.11.13胡刚（缩略图）
  if(true)
  {
	  //out.print("<br>zoomPic:"+zoomPic);
	  //out.print("<br>z_width:"+z_width);
	  //out.print("<br>z_height:"+z_height);
	  //return;
  }

  fi_id = CTools.dealString(myUpload.getRequest().getParameter("fi_id"));//栏目id 
  fi_title = CTools.dealUploadString(myUpload.getRequest().getParameter("fi_title"));//栏目名称
  fi_url = CTools.dealUploadString(myUpload.getRequest().getParameter("fi_url"));//url连接
  fi_sequence =CTools.dealNumber(myUpload.getRequest().getParameter("fi_sequence"));//排序
  fi_content =CTools.dealUploadString(myUpload.getRequest().getParameter("fi_content"));//信息内容
  String ct_fileflag = CTools.dealString(myUpload.getRequest().getParameter("ct_fileflag"));
  list_id = CTools.dealString(myUpload.getRequest().getParameter("list_id"));
  fi_type = CTools.dealString(myUpload.getRequest().getParameter("fi_type"));

if (frim_id.equals("")|| actiontype.equals("add") ) //附件没修改
{
//out.print(frim_id+"---------");if(true)return;
	frim_name = myUpload.getFiles().getFile(0).getFileName();//原文件名
	if(!frim_name.equals(""))
	{   
		String frim_name_low = frim_name.toLowerCase();
		if(frim_name_low.endsWith(".jpg") || frim_name_low.endsWith(".jpeg") || frim_name_low.endsWith(".gif") ){}//设置上传文件后缀限制
		else {
			out.print("<script language='javascript'>alert('文件类型不对，请上传jpg,jpeg,gif类型的图片！');window.history.go(-1);</script>");			    	 if(true)return ;  }
	}
	//if(true)return;
	 int filenum = 0;
	CDate oDate = new CDate();
	String sToday = oDate.getThisday();
	filenum =(int)(Math.random()*100000);
		if(!frim_name.equals(""))frim_filename = sToday + Integer.toString(filenum) + frim_name.substring(frim_name.lastIndexOf("."));
 
dCn.beginTrans();

path = dImpl.getInitParameter("front_save_path");
  if(!frim_filename.equals(""))
{
	
		
		int numeral = 0;
		numeral =(int)(Math.random()*100000);
		frim_path = sToday + Integer.toString(numeral);
		java.io.File newDir = new java.io.File(path + frim_path);

		if(!newDir.exists())
		{
		  newDir.mkdirs();
		}
	
}
  ct_fileflag = "".equals(ct_fileflag) ? "0" : ct_fileflag;

  if(actiontype.equals("add"))			//新增栏目
  {
     fi_id = dImpl.addNew("tb_frontinfo","fi_id",CDataImpl.STRING);
		if(!frim_name.equals(""))
		{
			    dImpl_new.setTableName("tb_frontinfo_image");
				dImpl_new.setPrimaryFieldName("frim_id");
				dImpl_new.addNew();
				dImpl_new.setValue("frim_path",frim_path,CDataImpl.STRING);
				dImpl_new.setValue("frim_filename",frim_filename,CDataImpl.STRING);
				dImpl_new.setValue("frim_name",frim_name,CDataImpl.STRING);
				dImpl_new.setValue("fi_id",fi_id,CDataImpl.STRING);
				dImpl_new.update();
		}
  }
  else  //修改栏目
  {
    dImpl.edit("tb_frontinfo","fi_id",fi_id);
				
				dImpl_new.setTableName("tb_frontinfo_image");
				dImpl_new.setPrimaryFieldName("frim_id");
				dImpl_new.addNew();
				dImpl_new.setValue("frim_path",frim_path,CDataImpl.STRING);
				dImpl_new.setValue("frim_filename",frim_filename,CDataImpl.STRING);
				dImpl_new.setValue("frim_name",frim_name,CDataImpl.STRING);
				dImpl_new.setValue("fi_id",fi_id,CDataImpl.STRING);
				dImpl_new.update();
		
  }
    dImpl.setValue("fi_title",fi_title,CDataImpl.STRING);//栏目名称
    dImpl.setValue("fi_url",fi_url,CDataImpl.STRING);//栏目代码
	dImpl.setValue("fi_sequence",fi_sequence,CDataImpl.STRING);//上级栏目代码
	dImpl.setValue("fi_content",fi_content,CDataImpl.STRING);//上级栏目代码
	dImpl.setValue("fs_id",list_id,CDataImpl.STRING);//上级栏目代码
	dImpl.setValue("fi_type",fi_type,CDataImpl.STRING);//上级栏目代码
	dImpl.setValue("ct_fileflag",ct_fileflag,CDataImpl.STRING);//上级栏目代码
    dImpl.update();

    if(dCn.getLastErrString().equals("")){
      dCn.commitTrans();
  
				myUpload.save(path + frim_path);//保存文件
				java.io.File file = new java.io.File(path + frim_path + "\\\\" +frim_name);
			    java.io.File file1 = new java.io.File(path + frim_path + "\\\\" +frim_filename);
			    file.renameTo(file1);
				if(zoomPic.equals("on"))                 //07.11.13胡刚（缩略图）
				{
					//int height = Integer.parseInt(z_height);
					//int width = Integer.parseInt(z_width);
					File f1 = new File(path + frim_path + "\\" +frim_filename);
					try {
						Image img = ImageIO.read(f1);
						int imgWidth = img.getWidth(null);
						int imgHeight = img.getHeight(null);
						int zip_width = 0;
						int zip_height = 0;
						if(z_wh.equals("zpwidth"))
						{
							zip_width = Integer.parseInt(zp_para);
							zip_height = zip_width*imgHeight/imgWidth;
						}
						else
						{
							zip_height = Integer.parseInt(zp_para);
							zip_width = zip_height*imgWidth/imgHeight;
						}

						BufferedImage tag = new BufferedImage(zip_width,zip_height,BufferedImage.TYPE_INT_RGB);
						tag.getGraphics().drawImage(img,0,0,zip_width,zip_height,null);
						FileOutputStream fos = new FileOutputStream(path + frim_path + "\\" +"zp_"+frim_filename);
						JPEGImageEncoder encoder = JPEGCodec.createJPEGEncoder(fos);
						encoder.encode(tag);
						fos.close();
						
					} catch (Exception e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
				}
				else       ///胡刚 11.20修改增加图片默认缩略图功能
				{
					File f1 = new File(path + frim_path + "\\" +frim_filename);
					try 
					{
						Image img = ImageIO.read(f1);
						int imgWidth = img.getWidth(null);
						int imgHeight = img.getHeight(null);
						int zip_width = 0;
						int zip_height = 0;
						zip_width = imgWidth>138?138:imgWidth;   //设置默认缩略图大小参数
						zip_height = zip_width*imgHeight/imgWidth;

						/*if(z_wh.equals("zpwidth"))
						{
							zip_width = Integer.parseInt(zp_para);
							zip_height = zip_width*imgHeight/imgWidth;
						}
						else
						{
							zip_height = Integer.parseInt(zp_para);
							zip_width = zip_height*imgWidth/imgHeight;
						}*/

						BufferedImage tag = new BufferedImage(zip_width,zip_height,BufferedImage.TYPE_INT_RGB);
						tag.getGraphics().drawImage(img,0,0,zip_width,zip_height,null);
						FileOutputStream fos = new FileOutputStream(path + frim_path + "\\" +"zp_"+frim_filename);
						JPEGImageEncoder encoder = JPEGCodec.createJPEGEncoder(fos);
						encoder.encode(tag);
						fos.close();
						
					} catch (Exception e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
				}
			
	  out.print("<script> alert('录入成功');window.location='frontSubjectList.jsp?fi_id="+fi_id+"&list_id="+list_id+"';</script>");
	}

	else{
      dCn.rollbackTrans();
	 out.print("<script language='javascript'>alert('发生错误，录入失败！！');window.history.go(-1);</script>");			   
	}

}else
{	dCn.beginTrans();
	dImpl.edit("tb_frontinfo","fi_id",fi_id);
	dImpl.setValue("fi_title",fi_title,CDataImpl.STRING);//栏目名称
    dImpl.setValue("fi_url",fi_url,CDataImpl.STRING);//栏目代码
	dImpl.setValue("fi_sequence",fi_sequence,CDataImpl.STRING);//上级栏目代码
	dImpl.setValue("fi_content",fi_content,CDataImpl.STRING);//上级栏目代码
	dImpl.setValue("fs_id",list_id,CDataImpl.STRING);//上级栏目代码
	dImpl.setValue("fi_type",fi_type,CDataImpl.STRING);//上级栏目代码
	dImpl.setValue("ct_fileflag",ct_fileflag,CDataImpl.STRING);//上级栏目代码
    dImpl.update();
	  if(dCn.getLastErrString().equals("")){
      dCn.commitTrans();			
	  out.print("<script> alert('修改成功1');window.location='frontSubjectList.jsp?fi_id="+fi_id+"&list_id="+list_id+"';</script>");
	}

	else{
      dCn.rollbackTrans();
	 out.print("<script language='javascript'>alert('发生错误，修改失败1！！');window.history.go(-1);</script>");			   
	}
}
    dImpl.closeStmt();
	dImpl_new.closeStmt();
    dCn.closeCn();

%>

