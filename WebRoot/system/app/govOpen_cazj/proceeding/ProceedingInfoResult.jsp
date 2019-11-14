<%@page contentType="text/html; charset=GBK"%>
<%@include file="../../skin/head.jsp"%>
<%
  String actiontype,actiontype_corr,cp_id,cp_name,deal_time,pc_id,dt_id,corr_time;

  String dt_name = "";//承办单位
  actiontype = CTools.dealString(request.getParameter("actiontype")).trim();//存储类型
  cp_id = CTools.dealString(request.getParameter("cp_id"));//事项id
  cp_name = CTools.dealString(request.getParameter("cp_name"));//事项名称
  deal_time = CTools.dealString(request.getParameter("deal_time"));//受理时限
  String dealing_time = CTools.dealString(request.getParameter("dealing_time"));//受理中时限  
  dt_id = CTools.dealString(request.getParameter("commonWork"));//转办单位
  String sqlStr = "select dt_name from tb_deptinfo where dt_id="+dt_id;

//update20080122

CDataCn dCn=null;   //新建数据库连接对象
CDataImpl dImpl=null;  //新建数据接口对象

try {
 dCn = new CDataCn(); 
 dImpl = new CDataImpl(dCn); 

  Hashtable content = dImpl.getDataInfo(sqlStr);
  dt_name = content.get("dt_name").toString();

  dCn.beginTrans();

  if(actiontype.equals("add"))			//新增事项
  {
     cp_id = dImpl.addNew("tb_connproc","cp_id",CDataImpl.PRIMARY_KEY_IS_VARCHAR);
     dImpl.setValue("cp_upid","o7",CDataImpl.STRING);//事项上级id
  }
  else  //修改事项
  {
    dImpl.edit("tb_connproc","cp_id",cp_id);
  }
    dImpl.setValue("dt_id",dt_id,CDataImpl.STRING);//事项受理单位
    dImpl.setValue("dt_name",dt_name,CDataImpl.STRING);//事项受理单位
    dImpl.setValue("cp_name",cp_name,CDataImpl.STRING);//事项名称
    dImpl.setValue("cp_timelimit",deal_time,CDataImpl.INT);//事项时限
    dImpl.setValue("cp_timelimiting",dealing_time,CDataImpl.INT);//事项时限

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
    response.sendRedirect("ProceedingList.jsp");
%>

