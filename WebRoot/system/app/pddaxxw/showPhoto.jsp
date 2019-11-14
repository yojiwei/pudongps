<%@page contentType="text/html; charset=GBK"%>
<%@include file="/system/app/skin/head.jsp"%>
<%
String op_imgpath = "";
String op_id = "";
String op_imgname = "";
String op_imgrealname = "";
String path = "";
String imgpath = "";
CDataCn dCn = null;
CDataImpl dImpl = null;
try{
dCn = new CDataCn();
dImpl = new CDataImpl(dCn);

path = dImpl.getInitParameter("workattach_http_path");//档案局征集图片放置路径
op_id = CTools.dealString(request.getParameter("op_id")).trim();

String sql_list = " select op_imgname,op_imgpath,op_imgrealname from tb_daxxphoto where op_id= "+op_id+"";

	Vector vectorList = dImpl.splitPage(sql_list,request,20);
	Hashtable content = null;
	if(vectorList!=null)
	{
		for(int i=0;i<vectorList.size();i++)
		{
			content = (Hashtable)vectorList.get(i);
			op_imgpath = CTools.dealNull(content.get("op_imgpath"));
			op_imgname = CTools.dealNull(content.get("op_imgname"));
			op_imgrealname = CTools.dealNull(content.get("op_imgrealname"));
			imgpath = path+op_imgpath+"/"+op_imgname;
			
			if(i % 2 == 0)  out.print("<tr class=\"line-even\">");
			else out.print("<tr class=\"line-odd\">");
	%>
	<img src="<%=imgpath%>" width="600" height="500" border="0">
<%
    }
  }
  else
  {
    out.println("<tr><td colspan=20>没有记录！</td></tr>");
  }
}
catch(Exception e){
	System.out.println(new java.util.Date() + "--"
			+ request.getServletPath() + " : " + e.getMessage());
}
finally{
	dImpl.closeStmt();
	dCn.closeCn(); 
}
%>