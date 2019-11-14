<%@ page contentType="text/html; charset=GBK" %>
<%@include file="/system/app/skin/import.jsp"%>
<%
String wo_id = "";
String sqlStr = "";
String wf_id = "";

wo_id = CTools.dealString(request.getParameter("wo_id")).trim();
sqlStr = "select wf_id from tb_workfrozen where wo_id='"+wo_id+"' and wf_endtime is null";
//update20080122

CDataCn dCn=null;   //新建数据库连接对象
CDataImpl dImpl=null;  //新建数据接口对象

try {
 dCn = new CDataCn(); 
 dImpl = new CDataImpl(dCn); 

dCn.beginTrans();

//取得在冻结表中的记录id
Hashtable content = dImpl.getDataInfo(sqlStr);
if (content!=null)
{
	wf_id = content.get("wf_id").toString();
}
//补充冻结结束时间
dImpl.edit("tb_workfrozen","wf_id",wf_id);
dImpl.setValue("wf_endtime",new CDate().getNowTime(),CDataImpl.DATE);
dImpl.update();
//修改tb-work表里记录的状态为“进行中“
dImpl.edit("tb_work","wo_id",wo_id);
dImpl.setValue("wo_status","1",CDataImpl.STRING);
dImpl.update();

dCn.commitTrans();
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
response.sendRedirect("WaitList.jsp?status=2");
%>