<%@page contentType="text/html; charset=GBK"%>
<%@include file="../../skin/import.jsp"%>

<%
CDataCn dCn = new CDataCn(); //新建数据库连接对象
CDataImpl dImpl = new CDataImpl(dCn); //新建数据接口对象
dCn.beginTrans();
String path = dImpl.getInitParameter("images_save_path"); //获取路径
String Img_path = CTools.dealString(request.getParameter("vde_img"));
String vde_pp=	 CTools.dealString(request.getParameter("vde_pp"));
String File_name =CTools.dealString(request.getParameter("Filename")) ;
String sqlStr = "";
boolean successDel=false;
File delFile = new File(path+Img_path+"\\\\"+File_name);
sqlStr = "select im_id from tb_image where im_path='"+Img_path+"'and im_filename='"+File_name+"'";

Vector vPage = dImpl.splitPage(sqlStr,100,1);
if (vPage!=null)
{
	for (int i=0;i<vPage.size();i++)
	{
		successDel = false;
		Hashtable content = (Hashtable)vPage.get(i);
		String im_id = content.get("im_id").toString();
		dImpl.delete("tb_image","im_id",im_id);
		successDel = true;
	}
}
String sqlStr1="select vt_id from tb_votediyext";
Vector vPage1=dImpl.splitPage(sqlStr1,100,1);
if(vPage1!=null)
{
	for(int j=0;j<vPage1.size();j++){
		Hashtable content1 = (Hashtable)vPage1.get(j);
		String vt_id = content1.get("vt_id").toString();
		dImpl.edit("tb_votediyext","vt_id",vt_id);
		dImpl.setValue("vde_flowimgpath","",CDataImpl.STRING);
		dImpl.update();
	}
}
dCn.commitTrans();
dImpl.closeStmt();
dCn.closeCn();
if (successDel)
{
	successDel=delFile.delete();
}
if (successDel)
{
	out.print("<SCRIPT LANGUAGE=\"JavaScript\">");
	out.print("alert('成功删除该文件！');");
	out.print("window.location='ExplainInfoImg.jsp?vde_img="+Img_path+"&vde_pp='");
	out.print("</SCRIPT>");    
}
else
{
	out.print("<SCRIPT LANGUAGE=\"JavaScript\">");
	out.print("alert('删除该文件时失败！');");
	out.print("window.location='ExplainInfoImg.jsp?vde_img="+Img_path+"&vde_pp="+vde_pp+"'");
	out.print("</SCRIPT>");   
}
%>