<%@page contentType="text/html;charset=GBK"%>
<%@include file="../skin/head.jsp"%>
<%
//update20080122

CDataCn dCn=null;   //新建数据库连接对象
CDataImpl dImpl=null;  //新建数据接口对象

try {
 dCn = new CDataCn(); 
 dImpl = new CDataImpl(dCn); 

String ai_id = "";
boolean b = true;
try{
ai_id = CTools.dealString(request.getParameter("ai_id")).trim();
dImpl.executeUpdate("delete from tb_advinfo where ai_id="+ai_id);

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
		window.location="AdvList.jsp";
		
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