<%@page contentType="text/html; charset=GBK"%>
<%@include file="/system/app/skin/head.jsp"%>
<%
//update by 20090429
CDataCn dCn=null;   //新建数据库连接对象
CDataImpl dImpl=null;  //新建数据接口对象
try {
 dCn = new CDataCn(); 
 dImpl = new CDataImpl(dCn); 

String us_id = "";
boolean b = true;
try{
	us_id = CTools.dealString(request.getParameter("us_id")).trim();
	dImpl.executeUpdate("delete from tb_usersso where us_id="+us_id);
	dImpl.closeStmt();
	dCn.closeCn();
}catch(Exception e){
	out.print(e);
	b = false;
}
%>
	<script language="javascript">
<%
	if(b)
	{
%>
		alert("操作已成功！");
		window.location="SSOUserList.jsp";
<%
	}else{
%>
	alert("操作失败，请重试！");
	history.back();
<%
	}	
%>	
	</script>
	<%
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