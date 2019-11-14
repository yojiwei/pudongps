<%@page contentType="text/html;charset=GBK"%>
<%@include file="/system/app/skin/import.jsp"%>
<%
	String parentId = CTools.dealString(request.getParameter("upperid")).trim();
	String deptTableName = CTools.dealString(request.getParameter("tabName")).trim();
	StringBuffer sb = new StringBuffer();
	String name = "";
	String id = "";
	String nonode = "";
	//update20080122

CDataCn dCn=null;   //新建数据库连接对象
CDataImpl dImpl=null;  //新建数据接口对象

try {
 dCn = new CDataCn(); 
 dImpl = new CDataImpl(dCn); 
	String sqlStr = "select * from " + deptTableName + " where sj_parentid=" + parentId + " order by sj_sequence";
	Vector vPage1 = dImpl.splitPage(sqlStr,1000,1);
	if (vPage1!=null)
	{   
		for (int i=0;i<vPage1.size();i++)
		{
			Hashtable content = (Hashtable)vPage1.get(i);
			name += "；" + content.get("sj_name").toString();
			id += "；" + content.get("sj_id").toString();
			parentId = content.get("sj_id").toString();	
			sqlStr = "select count(*) num from " + deptTableName + " where sj_parentid=" + parentId + " order by sj_sequence";
			Hashtable content1 = dImpl.getDataInfo(sqlStr);
			int  num = Integer.parseInt(content1.get("num").toString());	
			if (num==0)
			{
				nonode = nonode + "；true";
			}
			else
			{
				nonode = nonode + "；false";
			}
		}
		if (name.length()>0)
		{
			name = name.substring(1,name.length());
			id = id.substring(1,id.length());
		}
		if (nonode.length()>0)
		{
			nonode = nonode.substring(1,nonode.length());
		}
		sb.append("<childTree><name>" + name + "</name>" + "<id>" + id + "</id>" +"<nonode>"+nonode+"</nonode></childTree>");
	 }		 
	 else
	 {
		sb.append("<childTree>");
		sb.append("<name></name>");
		sb.append("<id></id>");
		sb.append("<nonode></nonode>");
		sb.append("</childTree>");
	 }
	dImpl.closeStmt();
	dCn.closeCn();
	out.println(sb.toString().trim());
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