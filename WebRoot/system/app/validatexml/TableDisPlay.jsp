<%@page contentType="text/html; charset=GBK"%>
<%@page import="java.sql.*"%>
<%@page import="java.io.*"%>
<%@page import="java.util.*"%>
<%@page import="com.component.database.*"%>
<%@page import="com.util.*"%>
<%@include file="../skin/import.jsp"%>
<%@page import="com.website.*"%>

<%

String el_id= CTools.dealString(request.getParameter("el_id"));
String pp_id= CTools.dealString(request.getParameter("pp_id"));
//update20080122

CDataCn dCn=null;   //新建数据库连接对象
CDataImpl dImpl=null;  //新建数据接口对象

try {
 dCn = new CDataCn(); 
 dImpl = new CDataImpl(dCn); 


if(!pp_id.equals("")){	
	String sql_passport  = "select pp_html ,pp_xmlarray from  tb_passport where pp_typeid = "+pp_id+"";	

	Hashtable htmlxml = dImpl.getDataInfo(sql_passport);
	if(htmlxml!=null){	

		String sqlxml = "select el_xml from tb_entemprvisexml where el_id ="+el_id+"";
		Hashtable axml = dImpl.getDataInfo(sqlxml);
		String el_xml =axml.get("el_xml").toString();
		%>


<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>申办单位情况登记表</title>
<script>
function printpr()
{
var OLECMDID = 7;
/* OLECMDID values:
* 6 - print
* 7 - print preview
* 1 - open window
* 4 - Save As
*/
document.all.dayin.style.display="none";
var PROMPT = 1; // 2 DONTPROMPTUSER 
var WebBrowser = '<OBJECT ID="WebBrowser1" WIDTH=0 HEIGHT=0 CLASSID="CLSID:8856F961-340A-11D0-A96B-00C04FD705A2"></OBJECT>';
document.body.insertAdjacentHTML('beforeEnd', WebBrowser); 
WebBrowser1.ExecWB(OLECMDID, PROMPT);
WebBrowser1.outerHTML = "";
}
function printpr2()
{
var OLECMDID = 4;
/* OLECMDID values:
* 6 - print
* 7 - print preview
* 1 - open window
* 4 - Save As
*/
document.all.lingcun.style.display="none";
var PROMPT = 1; // 2 DONTPROMPTUSER 
var WebBrowser = '<OBJECT ID="WebBrowser1" WIDTH=0 HEIGHT=0 CLASSID="CLSID:8856F961-340A-11D0-A96B-00C04FD705A2"></OBJECT>';
document.body.insertAdjacentHTML('beforeEnd', WebBrowser); 
WebBrowser1.ExecWB(OLECMDID, PROMPT);
WebBrowser1.outerHTML = "";
}
function displayno(){	
	if(document.all.dayin.style.display=="none"){
	document.all.dayin.style.display="";
	}
}
function displayno2(){	
	if(document.all.lingcun.style.display=="none"){
	document.all.lingcun.style.display="";
	}
}
</script>
</head>


		<%
out.println("<body onclick = 'javascript:displayno()'>");
	out.println("<input type='button' value='打印预览' onclick='printpr();'  id='dayin' style='display:'>");
		String pp_xmlarray = htmlxml.get("pp_xmlarray").toString();
		String pp_html =htmlxml.get("pp_html").toString();
		com.website.XmlImpl xml = new com.website.XmlImpl();
		xml.setXmlString(el_xml);
		xml.setXMLTable("substie");

		StringTokenizer st=new StringTokenizer(pp_xmlarray,",");
		while(st.hasMoreTokens())
			{
				String str=st.nextToken();
				xml.setXMLTabSeed(str);
				
			}
			xml.setXMLTabSeed("Annex");
			//xml.setFilePath("/xml.xml");
		xml.RunXML();
		Hashtable xmltable = xml.getXmlHashtable();
		StringTokenizer ste=new StringTokenizer(pp_xmlarray,",");
		while(ste.hasMoreTokens())
			{		
			String str=ste.nextToken();
			pp_html=CTools.replace(pp_html,"{$"+str+"}",xmltable.get(str).toString());			
			}
		pp_html=CTools.replace(pp_html,"{$Annex}",xmltable.get("Annex").toString());
		out.println(pp_html);




%>
</body>
</html>
<%
	}
		
	dImpl.closeStmt();
	dCn.closeCn();
}
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
