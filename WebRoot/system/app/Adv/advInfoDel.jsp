<%@page contentType="text/html;charset=GBK"%>
<%@include file="../skin/head.jsp"%>
<%
CDataCn dCn = new CDataCn();
CDataImpl dImpl = new CDataImpl(dCn);

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
	