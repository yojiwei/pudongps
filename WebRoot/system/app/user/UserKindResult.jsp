<%@page contentType="text/html; charset=GBK"%>
<%@include file="../skin/import.jsp"%>
<%
  String actiontype,UK_ID,UK_NAME;
  actiontype = CTools.dealString(request.getParameter("actiontype")).trim();
  UK_ID = CTools.dealString(request.getParameter("UK_ID"));
  UK_NAME = CTools.dealString(request.getParameter("UK_NAME"));


  //update20080122

CDataCn dCn=null;   //新建数据库连接对象
CDataImpl dImpl=null;  //新建数据接口对象

try {
 dCn = new CDataCn(); 
 dImpl = new CDataImpl(dCn); 
  //DataDealImpl dDealImpl = new DataDealImpl(dCn.getConnection()); //数据交换实现

  dCn.beginTrans();

  if(actiontype.equals("add"))			//新增
  {
     UK_ID = dImpl.addNew("tb_userkind","UK_ID",CDataImpl.PRIMARY_KEY_IS_VARCHAR);
     //dDealImpl.setRecord("tb_userkind",ConstantList.RECORDINSERT,UK_ID);
  }
  else  //修改用户
  {
    dImpl.edit("tb_userkind","UK_ID",UK_ID);
    //dDealImpl.setRecord("tb_userkind",ConstantList.RECORDUPDATE,UK_ID);
  }
    dImpl.setValue("UK_NAME",UK_NAME,CDataImpl.STRING);//用户类型
    dImpl.update();

    dCn.commitTrans(); //
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
    
    response.sendRedirect("UserKindList.jsp");
%>

