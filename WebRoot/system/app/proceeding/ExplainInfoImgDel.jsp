<%@page contentType="text/html; charset=GBK"%>
<%@include file="../skin/import.jsp"%>

<%
//update20080122

CDataCn dCn=null;   //新建数据库连接对象
CDataImpl dImpl=null;  //新建数据接口对象

try {
 dCn = new CDataCn(); 
 dImpl = new CDataImpl(dCn); 
dCn.beginTrans();
String path = dImpl.getInitParameter("images_save_path"); //获取路径
String Img_path = CTools.dealString(request.getParameter("pr_img"));
String  img_Path_Part01 = Img_path.substring(0,4);
String  img_Path_Part02 = Img_path.substring(4,6);
String  img_Path_Part03 = Img_path.substring(6,Img_path.length());
Img_path = img_Path_Part01+"-"+img_Path_Part02+"-"+img_Path_Part03;

String File_name =CTools.dealString(request.getParameter("Filename")) ;
String sqlStr = "";
boolean successDel=false;
File delFile = new File(path+Img_path+"\\\\"+File_name);
sqlStr = "select im_id from tb_image where im_path='" + Img_path + "" + "'and im_filename='"+File_name+"'";

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
	out.print("window.location='ExplainInfoImg.jsp?pr_img="+Img_path+"'");
	out.print("</SCRIPT>");    
}
else
{
	out.print("<SCRIPT LANGUAGE=\"JavaScript\">");
	out.print("alert('删除该文件时失败！');");
	out.print("window.location='ExplainInfoImg.jsp?pr_img="+Img_path+"'");
	out.print("</SCRIPT>");   
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