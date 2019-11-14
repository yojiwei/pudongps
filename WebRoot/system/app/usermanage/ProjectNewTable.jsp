<%@ page contentType="text/html; charset=GBK" %>
<%@include file="/system/app/skin/import.jsp"%>
<%@page import="com.website.*"%>

<%
String us_id=CTools.dealString(request.getParameter("us_id")).trim();
String pp_id=CTools.dealString(request.getParameter("pp_id")).trim();
if(!us_id.equals("")){
	String sql_enterpvisc = "select el_xml from tb_entemprvisexml where ec_id = (select ec_id from tb_enterpvisc where us_id ='"+us_id+"' and pp_id = "+pp_id+")";
	String sql_passport  = "select pp_html ,pp_xmlarray,pp_value from  tb_passport where pp_id = "+pp_id+"";	
	//update20080122

CDataCn dCn=null;   //新建数据库连接对象
CDataImpl dImpl=null;  //新建数据接口对象

try {
 dCn = new CDataCn(); 
 dImpl = new CDataImpl(dCn); 
	Hashtable content=dImpl.getDataInfo(sql_enterpvisc);
	Hashtable htmlxml = dImpl.getDataInfo(sql_passport);
	if(htmlxml!=null){	
		%>
		<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title><%=htmlxml.get("pp_value").toString()%></title>
</head>
<body>
		
		<%

	//	out.println("1");
		String el_xml=content.get("el_xml").toString() ;
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
		xml.RunXML();
		Hashtable xmltable = xml.getXmlHashtable();
		StringTokenizer ste=new StringTokenizer(pp_xmlarray,",");
		while(ste.hasMoreTokens())
			{
		
			String str=ste.nextToken();
			pp_html=CTools.replace(pp_html,"{$"+str+"}",xmltable.get(str).toString());
			}
		out.println(pp_html);
	%>
	</body>
</html>
	<%
	}
		
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
}
%>

