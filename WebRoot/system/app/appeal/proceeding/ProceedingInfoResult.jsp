<%@page contentType="text/html; charset=GBK"%>
<%@include file="../../skin/head.jsp"%>
<%
  CMySelf self = (CMySelf)session.getAttribute("mySelf");
  String selfdtid = String.valueOf(self.getDtId());
  String sender_id = String.valueOf(self.getMyID());

  String actiontype,actiontype_corr,cp_id,cp_name,deal_time,pc_id,dt_id,corr_time;

  actiontype = CTools.dealString(request.getParameter("actiontype")).trim();//存储类型
  actiontype_corr = CTools.dealString(request.getParameter("actiontype_corr")).trim();//转办存储类型
  cp_id = CTools.dealString(request.getParameter("cp_id"));//事项id
  cp_name = CTools.dealString(request.getParameter("cp_name"));//事项名称
  deal_time = CTools.dealString(request.getParameter("deal_time"));//受理时限
  String dealing_time = CTools.dealString(request.getParameter("dealing_time"));//受理中时限  
  pc_id = CTools.dealString(request.getParameter("pc_id"));//转办事项id
  dt_id = CTools.dealString(request.getParameter("commonWork"));//转办单位
  corr_time = CTools.dealString(request.getParameter("corr_time"));//转办时限
  
//update20080122

CDataCn dCn=null;   //新建数据库连接对象
CDataImpl dImpl=null;  //新建数据接口对象

try {
 dCn = new CDataCn(); 
 dImpl = new CDataImpl(dCn); 

  dCn.beginTrans();

  if(actiontype.equals("add"))			//新增事项
  {
     cp_id = dImpl.addNew("tb_connproc","cp_id",CDataImpl.PRIMARY_KEY_IS_VARCHAR);
     dImpl.setValue("dt_id",selfdtid,CDataImpl.STRING);//事项受理单位
     dImpl.setValue("dt_name","监察委",CDataImpl.STRING);//事项受理单位
     dImpl.setValue("cp_upid","o4",CDataImpl.STRING);//事项上级id
  }
  else  //修改事项
  {
    dImpl.edit("tb_connproc","cp_id",cp_id);
  }
    dImpl.setValue("cp_name",cp_name,CDataImpl.STRING);//事项名称
    dImpl.setValue("cp_timelimit",deal_time,CDataImpl.INT);//事项时限
    dImpl.setValue("cp_timelimiting",dealing_time,CDataImpl.INT);//事项时限

    dImpl.update();

  if(actiontype_corr.equals("add"))			//新增转办
  {
    pc_id = dImpl.addNew("tb_connproccorr","pc_id",CDataImpl.PRIMARY_KEY_IS_VARCHAR);
  }
  else  //修改转办
  {
    dImpl.edit("tb_connproccorr","pc_id",pc_id);
  }
    dImpl.setValue("cp_id",cp_id,CDataImpl.STRING);//转办单位
    dImpl.setValue("dt_id",dt_id,CDataImpl.INT);//转办单位
    dImpl.setValue("pc_timelimit",corr_time,CDataImpl.INT);//转办时限

    dImpl.update();

    if(dCn.getLastErrString().equals(""))
      dCn.commitTrans();
    else
      dCn.rollbackTrans();
    ///////////////////////
} catch (Exception ex) {
	System.out.println(new java.util.Date() + "--"
			+ request.getServletPath() + " : " + ex.getMessage());
} finally {
	if(dImpl != null)
	dImpl.closeStmt();
	if(dCn != null)
	dCn.closeCn();
}

    response.sendRedirect("ProceedingList.jsp");
%>

