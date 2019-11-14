<%@page contentType="text/html; charset=GBK"%>
<%@ page import="com.beyondbit.web.publishinfo.PublishOperate" %>
<%@ page import="com.beyondbit.web.form.TaskInfoForm" %>
<%@ page import="com.beyondbit.web.publishinfo.Messages,com.smsCase.*" %>
<%@include file="../skin/head.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <body>
<%
//update by yo 
CDataCn dCn = null; //新建数据库连接对象
CDataImpl dImpl = null; //新建数据接口对象
CMySelf mySelf = null;
Hashtable content = null;
String ct_id_all = request.getParameter("cp_id").toString();
String [] ct_id = ct_id_all.split(",");
String redirectURL="";
String ctCreateTime = new CDate().getThisday();
String strsql="";


try{
dCn = new CDataCn(); //新建数据库连接对象
dImpl = new CDataImpl(dCn); //新建数据接口对象
mySelf = (CMySelf)session.getAttribute("mySelf");

dCn.beginTrans();
for(int j = 0;j < ct_id.length;j++) {
strsql="select c.ct_id from tb_content c,tb_contentpublish p where c.ct_id = p.ct_id and p.cp_id ="+ct_id[j]+"";
content = (Hashtable)dImpl.getDataInfo(strsql);
if(content!=null){
dImpl.executeUpdate("update tb_content set ct_updatetime=to_date('"+ctCreateTime+"','yyyy-mm-dd')  where ct_id="+content.get("ct_id").toString()+" ");
}
dImpl.executeUpdate("update tb_contentpublish set CHECK_STATUS=1,CP_ISPUBLISH=1 where cp_id="+ct_id[j]+" ");

}
dCn.commitTrans();

redirectURL="publishShePiList.jsp?divName=summarize&status=checked&strPage=1";

}catch (Exception ex) {
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
