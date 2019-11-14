<%@page contentType="text/html; charset=GBK"%>
<%@include file="/system/app/skin/head.jsp"%>
<%@page import="com.util.*"%>
<%@page import="Evaluate.*"%>

<%
String jd_id = CTools.dealString(request.getParameter("jd_id"));




CDataCn dCn = null;
CDataImpl dImpl = null;
try{
dCn = new CDataCn();
dImpl = new CDataImpl(dCn);


dImpl.executeUpdate("delete from tb_onlinesubject where jd_id='"+jd_id+"'");
dImpl.executeUpdate("delete from tb_onlinewt where jd_id='"+jd_id+"'");


%>
<script language="javascript">
	alert("操作已成功！");
	window.location="list.jsp";
</script>
<%
	
}
catch(Exception e){
//e.printStackTrace();
out.print(e.toString());
}
finally{
dImpl.closeStmt();
dCn.closeCn(); 
}
%>
