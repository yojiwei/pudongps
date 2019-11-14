<%@page contentType="text/html; charset=GBK"%>
<%@ page import="com.beyondbit.web.publishinfo.PublishOperate" %>
<%@ page import="com.beyondbit.web.form.TaskInfoForm" %>
<%@ page import="com.beyondbit.web.publishinfo.Messages,com.smsCase.*" %>
<%@include file="../skin/head.jsp"%>
  <!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
  <body>
<%
CDataCn dCn =null; //新建数据库连接对象
CDataImpl dImpl = null; //新建数据接口对象
Hashtable  content = null;
CMySelf mySelf = (CMySelf)session.getAttribute("mySelf");
String cp_id_all = request.getParameter("cp_id").toString();
String [] cp_ids = cp_id_all.split(",");
String cp_type = request.getParameter("cp_type").toString();
String redirectURL="";
String cpSql="";
try{
dCn = new CDataCn(); //新建数据库连接对象
dImpl = new CDataImpl(dCn); //新建数据接口对象

dCn.beginTrans();
for(int j = 0;j < cp_ids.length;j++) {
cpSql="select ct_id from tb_contentpublish where cp_id = "+cp_ids[j]+"";
content = dImpl.getDataInfo(cpSql);
if(content!=null){
dImpl.executeUpdate("delete from tb_content where ct_id = "+content.get("ct_id").toString()+"");
dImpl.executeUpdate("delete from tb_infostatic where infoid = " + content.get("ct_id").toString() + "");
dImpl.executeUpdate("delete from tb_contentdetail where ct_id = " + content.get("ct_id").toString() + "");
}
dImpl.executeUpdate("delete from tb_contentpublish where cp_id = "+cp_ids[j]+"");
}
dCn.commitTrans();

redirectURL="publishShePiList.jsp?divName="+cp_type+"&status=checked&strPage=1";

} catch (Exception ex) {
	System.out.println(new java.util.Date() + "--"
			+ request.getServletPath() + " : " + ex.getMessage());
} finally {
	if(dImpl != null)
	dImpl.closeStmt();
	if(dCn != null)
	dCn.closeCn();
}
%>

<script language='javascript'>
alert("批处理操作成功！");
window.location="<%=redirectURL%>";
</script>
  </body>
</html>
