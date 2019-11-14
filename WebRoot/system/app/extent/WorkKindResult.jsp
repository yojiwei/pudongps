<%@page contentType="text/html; charset=GBK"%>
<%@include file="/system/app/skin/head.jsp"%>
<%
  String actiontype,wk_id,wk_name,wk_parameter;

  actiontype = CTools.dealString(request.getParameter("actiontype")).trim();//存储类型
  wk_id = CTools.dealString(request.getParameter("wk_id"));//事项id
  wk_name = CTools.dealString(request.getParameter("wk_name"));//事项名称
  wk_parameter = CTools.dealNumber(request.getParameter("wk_parameter"));

  //update20080122

CDataCn dCn=null;   //新建数据库连接对象
CDataImpl dImpl=null;  //新建数据接口对象

try {
 dCn = new CDataCn(); 
 dImpl = new CDataImpl(dCn); 
  dCn.beginTrans();

  if(actiontype.equals("add"))			//新增事项
  {
     wk_id = dImpl.addNew("tb_workkind","wk_id",CDataImpl.PRIMARY_KEY_IS_VARCHAR);
  }
  else  //修改事项
  {
    dImpl.edit("tb_workkind","wk_id",wk_id);
  }
    dImpl.setValue("wk_name",wk_name,CDataImpl.STRING);//名称
    dImpl.setValue("wk_parameter",wk_parameter,CDataImpl.STRING);//参数
	dImpl.update();

    if(dCn.getLastErrString().equals(""))
      dCn.commitTrans();
    else
      dCn.rollbackTrans();
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
    response.sendRedirect("WorkKindList.jsp");
%>