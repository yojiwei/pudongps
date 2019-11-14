<%@page contentType="text/html; charset=GBK"%>
<%@include file="../skin/import.jsp"%>
<%
  String actiontype,SW_ID,SW_NAME,SW_SEQUENCE;
  actiontype = CTools.dealString(request.getParameter("actiontype")).trim();
  SW_ID = CTools.dealString(request.getParameter("SW_ID"));
  SW_NAME = CTools.dealString(request.getParameter("SW_NAME"));
  SW_SEQUENCE = CTools.dealNumber(request.getParameter("SW_SEQUENCE"));


  //update20080122

CDataCn dCn=null;   //新建数据库连接对象
CDataImpl dImpl=null;  //新建数据接口对象

try {
 dCn = new CDataCn(); 
 dImpl = new CDataImpl(dCn); 

  dCn.beginTrans();
  if(actiontype.equals("add"))			//新增
  {
     SW_ID = dImpl.addNew("tb_sortwork","SW_ID",CDataImpl.PRIMARY_KEY_IS_VARCHAR);
  }
  else  //修改用户
  {
    dImpl.edit("tb_sortwork","SW_ID",SW_ID);
  }
    dImpl.setValue("SW_NAME",SW_NAME,CDataImpl.STRING);//事项类型
    dImpl.setValue("SW_SEQUENCE",SW_SEQUENCE,CDataImpl.INT);//事项排序
    dImpl.update();
    dCn.commitTrans();
    ///////////////////////
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
    response.sendRedirect("SortWorkList.jsp");
%>

