<%@page contentType="text/html; charset=GBK"%>
<%@page import="java.sql.*"%>
<%@page import="java.io.*"%>
<%@page import="java.util.*"%>
<%@page import="com.component.database.*"%>
<%@page import="com.util.*"%>
<%@include file="../skin/import.jsp"%>
<%
String OPType = "";
//update20080122
CDataCn dCn=null;   //新建数据库连接对象
CDataImpl dImpl=null;  //新建数据接口对象
try {
 dCn = new CDataCn(); 
 dImpl = new CDataImpl(dCn); 
 
String imp_status = "";
String ti_sequence = "";
String in_content = "";
String ti_name = "";
String ti_id = "";
String tc_id = "";
String ti_upperid = "";
String dt_id = "";
String cp_id = "";

  ti_upperid = CTools.dealString(request.getParameter("ti_upperid")).trim();
  ti_id = CTools.dealString(request.getParameter("ti_id")).trim();
  OPType = CTools.dealString(request.getParameter("OPType")).trim();//操作方式 Add是添加 Edit是修改
  ti_name = CTools.dealString(request.getParameter("jz_name")).trim();
  ti_sequence = CTools.dealString(request.getParameter("ti_sequence")).trim();
  imp_status = CTools.dealString(request.getParameter("imp_status")).trim();
  
  try
  {
  	String sql_dtid = "select d.dt_id,c.cp_id,c.cp_name,t.tc_id from tb_deptinfo d,tb_connproc c,tb_titlelinkconn t where d.dt_id = c.dt_id and c.cp_id = t.cp_id and c.cp_upid = 'o10000' and d.dt_name like '%"+ti_name+"'";
		Hashtable content_dtid = dImpl.getDataInfo(sql_dtid);
		if(content_dtid!=null){
			dt_id = CTools.dealNull(content_dtid.get("dt_id"));
			cp_id = CTools.dealNull(content_dtid.get("cp_id"));
			tc_id = CTools.dealNull(content_dtid.get("tc_id"));
		}
  
  
		dImpl.setTableName("tb_title");
	  dImpl.setPrimaryFieldName("ti_id");
	  if (OPType.equals("Add"))
		{
			ti_id = Long.toString(dImpl.addNew());
		}
	  else if (OPType.equals("Edit"))
	  {
	    dImpl.edit("tb_title","ti_id",ti_id);
	  }
		dImpl.setValue("ti_name",ti_name,CDataImpl.STRING);
		dImpl.setValue("ti_sequence",ti_sequence,CDataImpl.STRING);
		dImpl.setValue("tm_id","-1",CDataImpl.STRING);
		dImpl.setValue("ti_upperid",ti_upperid,CDataImpl.STRING);
		dImpl.setValue("ti_createtime",CDate.getNowTime(),CDataImpl.DATE);
		dImpl.setValue("ti_browsenum","0",CDataImpl.STRING);
		dImpl.setValue("ti_kind","2",CDataImpl.STRING);
		dImpl.setValue("ti_ownerdtid",dt_id,CDataImpl.STRING);
		dImpl.setValue("ti_needaudit","0",CDataImpl.STRING);
		dImpl.setValue("ti_deleteflag","0",CDataImpl.STRING);
		dImpl.setValue("ti_keywordrelation","2",CDataImpl.STRING);
	  dImpl.setValue("imp_status","".equals(imp_status)?"0":"1",CDataImpl.STRING);
    dImpl.update() ;
    //
    dImpl.edit("tb_titlelinkconn","tc_id",tc_id);
		dImpl.setValue("ti_id",ti_id,CDataImpl.STRING);
		dImpl.setValue("cp_id",cp_id,CDataImpl.STRING);
		dImpl.setValue("dt_id",dt_id,CDataImpl.STRING);
    dImpl.update() ;

  }
  catch(Exception e)
  {
    out.println("error message:" + e.getMessage() +e.toString());
  }
  }catch (Exception ex) {
	System.out.println(new java.util.Date() + "--"
			+ request.getServletPath() + " : " + ex.getMessage());
} finally {
	if(dImpl != null)
	dImpl.closeStmt();
	if(dCn != null)
	dCn.closeCn();
}
out.print("<script>window.location.href='leadBoxList2.jsp';</script>");
%>