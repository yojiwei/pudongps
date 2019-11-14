
<%@page import="com.util.*"%>
<%@page import="com.component.database.*"%>
<%@page contentType="text/html; charset=GBK"%>
<%

String il_id="";

il_id=CTools.dealNumber(request.getParameter("il_id")).trim();//主键id
//out.println("il_id=" + il_id);

//update20080122

CDataCn dCn=null;   //新建数据库连接对象
CDataImpl dImpl=null;  //新建数据接口对象

try {
 dCn = new CDataCn(); 
 dImpl = new CDataImpl(dCn); 

try
{
  dImpl.delete("tb_iplist","il_id",Integer.parseInt(il_id));
  //dImpl.edit("tb_iplist","il_id",Integer.parseInt(il_id));
  //dImpl.setValue("ct_delflag","1",CDataImpl.INT);
  dImpl.update() ;
  dImpl.closeStmt();
  dCn.closeCn();
  //out.println("删除成功");
  
	out.write("<script language='javascript'>");
	out.write("alert('删除成功');");
	out.write("window.location.href='ipList.jsp';");
	out.write("</script>");
}
catch(Exception e)
{
  out.println("error message:" + e.getMessage());
}
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