<%@page contentType="text/html;charset=GBK"%>
<%@include file="/system/app/skin/import.jsp"%>
<%
//update20080122

CDataCn dCn=null;   //新建数据库连接对象
CDataImpl dImpl=null;  //新建数据接口对象

try {
 dCn = new CDataCn(); 
 dImpl = new CDataImpl(dCn); 

CMySelf myProject = (CMySelf)session.getAttribute("mySelf");
String uiid=Long.toString(myProject.getMyID());
String uiDeptId=Long.toString(myProject.getDtId());

String sql_admin = "select * from tb_roleinfo r,tb_functionrole f where tr_userids like '%," + uiid + ",%' and r.tr_id = f.tr_id and f.ft_id = (select ft_id from tb_function where ft_code='ISADMIN')";
ResultSet rs=dImpl.executeQuery(sql_admin);
boolean isAdmin=rs.next();



	String parentId = CTools.dealString(request.getParameter("upperid")).trim();
	String deptTableName = CTools.dealString(request.getParameter("tabName")).trim();
	StringBuffer sb = new StringBuffer();
	String name = "";
	String id = "";
	String nonode = "";
	String tmId = "";
	String sqlStr = "select * from " + deptTableName + " where ti_upperid=" + parentId + " order by Ti_SEQUENCE";
	Vector vPage1 = dImpl.splitPage(sqlStr,1000,1);
	if (vPage1!=null)
	{
		for (int i=0;i<vPage1.size();i++)
		{
			Hashtable content = (Hashtable)vPage1.get(i);

			if(!isAdmin)  //如果不是管理员，别人添加的私有栏目不显示
			{
				if(content.get("ti_kind").toString().equals("2") && !content.get("ti_ownerdtid").toString().equals(uiDeptId)) continue;
			}

			name += "；" + content.get("ti_name").toString();
			id += "；" + content.get("ti_id").toString();
			tmId += "；" + content.get("tm_id").toString();
			parentId = content.get("ti_id").toString();
			sqlStr = "select count(*) num from " + deptTableName + " where ti_upperid=" + parentId + " order by Ti_SEQUENCE";
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
//if(content.get("ti_kind").toString()!="2")
		sb.append("<childTree><name>" + name + "</name>" + "<id>" + id + "</id>" +"<nonode>"+nonode+"</nonode><tmid>" + tmId + "</tmid></childTree>");
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