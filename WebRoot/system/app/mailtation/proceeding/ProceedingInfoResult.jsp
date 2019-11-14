<%@page contentType="text/html; charset=GBK"%>
<%@include file="../../skin/head.jsp"%>
<%
  String actiontype = "";
  String actiontype_corr = "";
  String cp_id = "";
  String cp_name = "";
  String deal_time = "";
  String pc_id = "";
  String dt_id = "";
  String corr_time = "";
  String dt_name = "";//承办单位
  String dealing_time ="";
  String sqlStr = "";
  String ti_id = "";
  String tc_id = "";
  
  actiontype = CTools.dealString(request.getParameter("actiontype")).trim();//存储类型
  cp_id = CTools.dealString(request.getParameter("cp_id")).trim();//事项id
  cp_name = CTools.dealString(request.getParameter("cp_name")).trim();//事项名称
  deal_time = CTools.dealString(request.getParameter("deal_time")).trim();//受理时限
  dealing_time = CTools.dealString(request.getParameter("dealing_time")).trim();//受理中时限  
  dt_id = CTools.dealString(request.getParameter("commonWork")).trim();//转办单位
  ti_id = CTools.dealString(request.getParameter("ti_id")).trim();//街镇领导信箱tb_title
  tc_id = CTools.dealString(request.getParameter("tc_id")).trim();//街镇领导信箱tb_titlelinkconn
  
//update20090909
CDataCn dCn=null;   //新建数据库连接对象
CDataImpl dImpl=null;  //新建数据接口对象
try {
 dCn = new CDataCn(); 
 dImpl = new CDataImpl(dCn); 
	sqlStr = "select dt_name from tb_deptinfo where dt_id="+dt_id;
  Hashtable content = dImpl.getDataInfo(sqlStr);
  if(content!=null){
  	dt_name = CTools.dealNull(content.get("dt_name"));
  }

  dCn.beginTrans();
/*操作表tb_connproc开始*/
  if(actiontype.equals("add"))
  {
	//判断信箱名称是否重复，若重复返回重新填写
	String sqlHasName = "select cp_id from tb_connproc where cp_name = '"+ cp_name +"' and cp_upid = 'o10000'";
	ResultSet rs_sh = dImpl.executeQuery(sqlHasName);
	if (rs_sh.next()) {
		out.print("<script>alert('事项名称已经存在，请核实后填写！');history.back();</script>");
		return;
	}
     cp_id = dImpl.addNew("tb_connproc","cp_id",CDataImpl.PRIMARY_KEY_IS_VARCHAR);
     dImpl.setValue("cp_upid","o10000",CDataImpl.STRING);//事项上级id
  }
  else  //修改事项
  {
    dImpl.edit("tb_connproc","cp_id",cp_id);
  }
    dImpl.setValue("dt_id",dt_id,CDataImpl.STRING);
    dImpl.setValue("dt_name",dt_name,CDataImpl.STRING);
    dImpl.setValue("cp_name",cp_name,CDataImpl.STRING);//信箱名称
    dImpl.setValue("cp_timelimit",deal_time,CDataImpl.STRING);//事项时限
    dImpl.setValue("cp_timelimiting",dealing_time,CDataImpl.STRING);//事项时限
    dImpl.update();

/*操作表tb_titlelinkman开始*/
	dImpl.setTableName("tb_titlelinkconn");
	dImpl.setPrimaryFieldName("tc_id");
	if (actiontype.equals("add"))
	{
		tc_id = Long.toString(dImpl.addNew());
		dImpl.setValue("cp_id",cp_id,CDataImpl.STRING);
	}
	else
	{
	  dImpl.edit("tb_titlelinkconn","tc_id",tc_id);     
	}
	dImpl.setValue("dt_id",dt_id,CDataImpl.STRING);//事项受理单位
	dImpl.setValue("ti_id",ti_id,CDataImpl.STRING);
	dImpl.update();


if(dCn.getLastErrString().equals(""))
  dCn.commitTrans();
else
  dCn.rollbackTrans();
  
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

