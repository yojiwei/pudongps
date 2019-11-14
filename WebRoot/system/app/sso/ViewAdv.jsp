<%@page contentType="text/html;charset=GBK"%>
<%@include file="../skin/head.jsp"%>

<!-- 程序开始 -->
<%
//update20080122

CDataCn dCn=null;   //新建数据库连接对象
CDataImpl dImpl=null;  //新建数据接口对象

try {
 dCn = new CDataCn(); 
 dImpl = new CDataImpl(dCn); 

//ddd dd = new ddd();
String ai_id = "";
String sql = "";
String at_code = "";
String path = "";
String ai_filename = "";
String ai_filepath = "";
String width = "";
String height = "";
StringBuffer flash = new StringBuffer();


/*得到上一个页面传过来的参数  开始*/
ai_id=CTools.dealString(request.getParameter("ai_id")).trim();
width=CTools.dealString(request.getParameter("width")).trim();
height=CTools.dealString(request.getParameter("height")).trim();
/*得到上一个页面传过来的参数  结束*/

sql="select a.ai_filename,a.ai_filepath,t.at_code from tb_advinfo a,tb_advtype t where a.ai_type = t.at_id and a.ai_id=" + ai_id;
//out.println(sql);
Hashtable content=dImpl.getDataInfo(sql);
if(content != null)
{
	at_code=content.get("at_code").toString();
	ai_filename=content.get("ai_filename").toString();
	ai_filepath=content.get("ai_filepath").toString();
}
path = dImpl.getInitParameter("adv_http_path");
flash.append("<object classid=\"clsid:d27cdb6e-ae6d-11cf-96b8-444553540000\" codebase=\"http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=7,0,0,0\" width=" + width + " height=" + height +" id=\"bannerindex\" align=\"middle\">");
flash.append("<param name=\"allowScriptAccess\" value=\"sameDomain\" />");
flash.append("<param name=\"movie\" value=" + path + ai_filepath + "/" + ai_filename + " />");
flash.append("<param name=\"quality\" value=\"high\" />");
flash.append("<param name=\"wmode\" value=\"transparent\" />");
flash.append("<param name=\"bgcolor\" value=\"#ffffff\" />");
flash.append("<embed src=\"pop_fla.swf\" quality=\"high\" wmode=\"transparent\" bgcolor=\"#ffffff\" name=\"bannerindex\" align=\"middle\" allowScriptAccess=\"sameDomain\" type=\"application/x-shockwave-flash\" pluginspage=\"http://www.macromedia.com/go/getflashplayer\" />");
flash.append("</object>");

%>
<!--程序结束-->

<!--HTML主体开始-->
<form name="formData" method="post" enctype="multipart/form-data">
<%
if(!ai_filename.equals(""))
{
	if(at_code.equals("flash"))
	{
		out.println(flash);
	}
	else if(at_code.equals("gif"))
	{
		out.println("<img src=" + path + ai_filepath + "/" + ai_filename + " border=\"0\" width=" + width + " height=" + height + ">");
	}
}
else
{
	out.println("<table height=\"100%\" width=\"100%\"><tr align=\"center\" valign=\"middle\"><td>没有文件！</td></tr></table>");
}
%>
</form>
<!-- HTML主体结束 -->
<%
//关闭连接
dImpl.closeStmt();
dCn.closeCn();
%>

<%


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

