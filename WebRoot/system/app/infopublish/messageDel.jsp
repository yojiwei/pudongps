<%@include file="/system/app/skin/import.jsp"%>
<%@page contentType="text/html; charset=GBK"%>
<%
CDataCn dCn = new CDataCn(); //新建数据库连接对象
CDataImpl dImpl = new CDataImpl(dCn); //新建数据接口对象
com.jspsmart.upload.SmartUpload myUpload = new com.jspsmart.upload.SmartUpload();
myUpload.initialize(pageContext);
myUpload.setDeniedFilesList("exe,bat,jsp");
myUpload.upload();
String senderId = "";
String senderName = "";
String senderDtId = "";
String ct_id_all = "";//编号
String cp_id= "" ;
String mmt_id = CTools.dealUploadString(myUpload.getRequest().getParameter("sm_id"));

com.app.CMySelf mySelf = (com.app.CMySelf)session.getAttribute("mySelf");
if (mySelf!=null&&mySelf.isLogin())
{
     senderId = Long.toString(mySelf.getMyID());
	 senderName = mySelf.getMyName();
	 senderDtId = Long.toString(mySelf.getDtId());
}
String sql_dt = "select dt_name from tb_deptinfo where dt_id="+senderDtId;
Hashtable content1 = dImpl.getDataInfo(sql_dt);
if (content1!=null)
{
	String senderDesc = content1.get("dt_name").toString();
}
  dCn.beginTrans();
  dImpl.executeUpdate("delete from tb_sms where sm_id = '" + mmt_id + "'");
  dCn.commitTrans();
  dImpl.closeStmt();
  dCn.closeCn();
  out.print("<script>alert('删除成功！');</script>");
		%>
    <script>
  	window.location="message.jsp";
	</script>