<%@page contentType="text/html; charset=GBK"%>
<%@include file="../../skin/head.jsp"%>
<%
  CMySelf self = (CMySelf)session.getAttribute("mySelf");
  String selfdtid = String.valueOf(self.getDtId());
  String sender_id = String.valueOf(self.getMyID());

  String actiontype,wd_id,wd_name,sequence;

  actiontype = CTools.dealString(request.getParameter("actiontype")).trim();//存储类型
  wd_id = CTools.dealString(request.getParameter("wd_id"));//事项id
  wd_name = CTools.dealString(request.getParameter("wd_name"));//事项名称
  sequence = CTools.dealNumber(request.getParameter("wd_sequence"));

  //update20080122

CDataCn dCn=null;   //新建数据库连接对象
CDataImpl dImpl=null;  //新建数据接口对象

try {
 dCn = new CDataCn(); 
 dImpl = new CDataImpl(dCn); 
  dCn.beginTrans();

  if(actiontype.equals("add"))			//新增事项
  {
     wd_id = dImpl.addNew("tb_warden","wd_id",CDataImpl.PRIMARY_KEY_IS_VARCHAR);
  }
  else  //修改事项
  {
    dImpl.edit("tb_warden","wd_id",wd_id);
  }
    dImpl.setValue("wd_name",wd_name,CDataImpl.STRING);//事项名称
    dImpl.setValue("wd_sequence",sequence,CDataImpl.STRING);//事项名称
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
    response.sendRedirect("WardenList.jsp");
%>

