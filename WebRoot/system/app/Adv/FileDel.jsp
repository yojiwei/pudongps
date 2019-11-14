<%@page contentType="text/html;charset=GBK"%>
<%@include file="../skin/head.jsp"%>
<%
CDataCn dCn = new CDataCn();
CDataImpl dImpl = new CDataImpl(dCn);

String OPType = "";
String ai_id = "";
String ai_filepath = "";
String ai_filename = "";
String path = "";

OPType = CTools.dealString(request.getParameter("OPType1")).trim();
ai_id = CTools.dealString(request.getParameter("ai_id1")).trim();
ai_filepath = CTools.dealString(request.getParameter("ai_filepath1")).trim();
ai_filename = CTools.dealString(request.getParameter("ai_filename1")).trim();
path = dImpl.getInitParameter("adv_save_path"); //获取路径
boolean successDel=false;
File delFile = new File(path+ai_filepath+"\\\\"+ai_filename);
//out.print(delFile.length());
successDel=delFile.delete();
if (successDel)
{
	dCn.beginTrans();

	if(!ai_id.equals(""))
	{
		dImpl.edit("tb_advinfo","ai_id",Integer.parseInt(ai_id));
		dImpl.setValue("ai_filename","",CDataImpl.STRING);//附件文件名
		dImpl.update();
	}

	dCn.commitTrans();

	dImpl.closeStmt();
	dCn.closeCn();
	response.sendRedirect("AdvInfo.jsp?OPType=Edit&ai_id="+ ai_id + "&OPType="+OPType);
}
else
{
	out.print("<SCRIPT LANGUAGE=\"JavaScript\">");
	out.print("alert('删除该文件时失败！');");
	out.print("window.history.go(-1);");
	out.print("</SCRIPT>");
}
%>