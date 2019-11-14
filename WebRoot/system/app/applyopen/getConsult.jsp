<%@page contentType="text/html; charset=GBK"%>
<%@ include file="/system/app/skin/import.jsp"%>
<table width=100% border=0>
<tr>
<%
CDataCn dCn = null;
CDataImpl dImpl = null;
String ci_id = CTools.dealString(request.getParameter("ci_id"));
try{
	dCn = new CDataCn();
	dImpl = new CDataImpl(dCn);
	out.println("<table width=100% cellspacing=0 height=0>");
	String sqlStr = "select ci_title,ci_content from tb_contentinfo where ci_id = " + ci_id;
	Hashtable content = dImpl.getDataInfo(sqlStr);
	if(content!=null){
			out.println("<tr><td>"+content.get("ci_content").toString()+"</td></tr>");
	}
	sqlStr = "select id,filepath,filename,originname from accessories where indextable = 'tb_contentinfo' and indexid = " + ci_id;

	Vector vec = dImpl.splitPage(sqlStr,20,1);
	if (vec != null) {
	out.println("<tr><td height=\"16\"></td></tr><tr><td>相关附件：</td></tr>");
		for (int i=0;i<vec.size();i++) {
		content = (Hashtable)vec.get(i);
		String id = content.get("id").toString();
		String filepath = content.get("filepath").toString(); //文件路径
		String filename = content.get("filename").toString(); //实际文件名
		String originname = content.get("originname").toString(); //原文件名
		out.println("<tr><td><a href=\"download.jsp?fid="+id+"\" target=\"_blank\">");
		if(!originname.equals("")) {
		out.println(originname);
		} 
	else{
		out.println(filename);
		}
		out.println("</a></td></tr>");
		}
	}
	out.println("</table>");
}
catch(Exception e){
	out.print(e.toString());
}finally{
	dImpl.closeStmt();
	dCn.closeCn(); 
}
%>
</table>