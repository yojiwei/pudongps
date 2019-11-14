<%@page contentType="text/html; charset=GBK"%>
<%@include file="../skin/import.jsp"%>
<%
  String stype,ssql;
	String strid="";
	stype=CTools.dealNumber(request.getParameter("stype"));
	String[]	delId=request.getParameterValues("delId");
	for(int i=0;i<delId.length;i++)
	{
		strid=strid+delId[i].trim()+",";
	}
	int strlen=strid.length();
	strid=strid.substring(0,strlen-1);
	//out.print(strid);
	
//update20080122

CDataCn dCn=null;   //新建数据库连接对象
CDataImpl dImpl=null;  //新建数据接口对象

try {
 dCn = new CDataCn(); 
 dImpl = new CDataImpl(dCn); 

	ssql="delete from tb_bbscontent where bc_id in ("+strid+")";
	//out.print(ssql);
	
	dImpl.executeUpdate(ssql);
	
 

} catch (Exception ex) {
	System.out.println(new java.util.Date() + "--"
			+ request.getServletPath() + " : " + ex.getMessage());
} finally {
	if(dImpl != null)
	dImpl.closeStmt();
	if(dCn != null)
	dCn.closeCn();
}
  response.sendRedirect("bbscontentDetail.jsp?stype="+stype);

%>
