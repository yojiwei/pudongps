<%@page contentType="text/html; charset=GBK"%>
<%@include file="/system/app/skin/import.jsp"%>
<%
  String actiontype,GW_ID,GW_NAME,GW_SEQUENCE,DT_ID;
  actiontype = CTools.dealString(request.getParameter("actiontype")).trim();
  GW_ID = CTools.dealString(request.getParameter("GW_ID"));
  GW_NAME = CTools.dealString(request.getParameter("GW_NAME"));
  GW_SEQUENCE = CTools.dealNumber(request.getParameter("GW_SEQUENCE"));
  DT_ID = CTools.dealNumber(request.getParameter("commonWork"));

  CDataCn dCn = null;
  CDataImpl dImpl = null;
  try{
	  dCn = new CDataCn(); //新建数据库连接对象
	  dImpl = new CDataImpl(dCn); //新建数据接口对象
	  dCn.beginTrans();
	  if(actiontype.equals("add"))			//新增
	  {
	     GW_ID = dImpl.addNew("tb_gasortwork","gw_id",CDataImpl.PRIMARY_KEY_IS_VARCHAR);
	  }
	  else  //修改用户
	  {
	    dImpl.edit("tb_gasortwork","gw_id",GW_ID);
	  }
	    dImpl.setValue("gw_name",GW_NAME,CDataImpl.STRING);//事项类型
	    dImpl.setValue("gw_sequence",GW_SEQUENCE,CDataImpl.INT);//事项排序
		dImpl.setValue("dt_id",DT_ID,CDataImpl.INT);//所属单位
	    dImpl.update();
	    dCn.commitTrans();
	} catch (Exception ex) {
		dCn.rollbackTrans();
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

