<%@page import="com.util.*"%>
<%@page import="com.component.database.*"%>
<%@page contentType="text/html; charset=GBK"%>
<%

String uc_id="";
String uc_status = "";
String th_id ="";


//update20080122

CDataCn dCn=null;   //新建数据库连接对象
CDataImpl dImpl=null;  //新建数据接口对象

try {
 dCn = new CDataCn(); 
 dImpl = new CDataImpl(dCn); 
 
 uc_id=CTools.dealString(request.getParameter("uc_id")).trim();//主键id
 uc_status = CTools.dealString(request.getParameter("uc_status")).trim();
 th_id = CTools.dealString(request.getParameter("th_id")).trim();


  dImpl.edit("tb_voteusercomment","uc_id",uc_id);
  dImpl.setValue("uc_status",uc_status,CDataImpl.STRING);
  dImpl.update() ;
  
	out.write("<script language='javascript'>");
	out.write("alert('操作成功');");
	out.write("window.location.href='commentlist.jsp?th_id="+th_id+"&th_votetype=1';");
	out.write("</script>");

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