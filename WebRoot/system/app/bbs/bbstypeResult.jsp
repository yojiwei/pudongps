<%@page contentType="text/html; charset=GBK"%>
<%@include file="../skin/import.jsp"%>
<%
//update20080122

CDataCn dCn=null;   //新建数据库连接对象
CDataImpl dImpl=null;  //新建数据接口对象

try {
 dCn = new CDataCn(); 
 dImpl = new CDataImpl(dCn); 

		String bt_name,bt_manager,bt_id;

		bt_name=CTools.dealString(request.getParameter("bt_name")).trim();
		bt_id=CTools.dealNumber(request.getParameter("bt_id"));
		//////////////////////////////////////////////  后台用户
	CMySelf myBBs = (CMySelf)session.getAttribute("mySelf");
  if(myBBs!=null && myBBs.isLogin())
  {
    bt_manager = Long.toString(myBBs.getMyID());
	
  }
  else
  {
    bt_manager= "2";
	
  }
	////////////////////////////////////////////


if(bt_id.equals("0"))
{
		dImpl.addNew("tb_bbstype","bt_id");
		dImpl.setValue("bt_manager",bt_manager,CDataImpl.STRING);
}
else
{
		int  intId=Integer.parseInt(bt_id);
		dImpl.edit("tb_bbstype","bt_id",intId);
}
		dImpl.setValue("bt_name",bt_name,CDataImpl.STRING);
		

	  dImpl.update() ;

		dImpl.closeStmt();
		dCn.closeCn();
		response.sendRedirect("bbstypeList.jsp");
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