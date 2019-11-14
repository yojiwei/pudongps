<%@page contentType="text/html;charset=GBK"%>
<%@include file="../skin/head.jsp"%>
<%
CDataCn dCn = new CDataCn();
CDataImpl dImpl = new CDataImpl(dCn);

String OPType = "";
String ap_id = "";
String ap_filepath = "";
String ap_filename = "";
String path = "";

OPType = CTools.dealString(request.getParameter("OPType1")).trim();
ap_id = CTools.dealString(request.getParameter("ap_id1")).trim();
ap_filepath = CTools.dealString(request.getParameter("ap_filepath1")).trim();
ap_filename = CTools.dealString(request.getParameter("ap_filename1")).trim();
path = dImpl.getInitParameter("adv_save_path"); //获取路径
boolean successDel=false;
File delFile = new File(path+ap_filepath+"\\\\"+ap_filename);
//out.print(delFile.length());
successDel=delFile.delete();
if (successDel)
{
	dCn.beginTrans();

	if(!ap_id.equals(""))
	{
		dImpl.edit("tb_advposition","ap_id",Integer.parseInt(ap_id));
		dImpl.setValue("ap_filename","",CDataImpl.STRING);//附件文件名
		dImpl.update();
	}

	dCn.commitTrans();

	dImpl.closeStmt();
	dCn.closeCn();
	response.sendRedirect("PositionInfo.jsp?OPType=Edit&ap_id="+ ap_id + "&OPType="+OPType);
}
else
{
	out.print("<SCRIPT LANGUAGE=\"JavaScript\">");
	out.print("alert('删除该文件时失败！');");
	out.print("window.history.go(-1);");
	out.print("</SCRIPT>");
}
%>