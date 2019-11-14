<%@page contentType="text/html; charset=GBK"%>
<%@include file="/website/include/import.jsp"%>
<%@page import="java.text.*" %>
<%
	String status = CTools.dealString(request.getParameter("status")).trim();
	String au_id = CTools.dealString(request.getParameter("au_id")).trim();
	SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd");
	CDataCn dCn = null;
	CDataImpl dImpl = null;
	try {
		dCn = new CDataCn();
		dImpl = new CDataImpl(dCn);
		dImpl.edit("tb_auction","au_id",au_id);
		dImpl.setValue("au_check",status,CDataImpl.STRING);
		dImpl.setValue("au_checkdate",df.format(new java.util.Date()),CDataImpl.DATE);
		dImpl.update();
		if (dCn.getLastErrString().equals("")){
			dCn.commitTrans();
		}else{
			dCn.rollbackTrans();
		}
%>
<html>
	<head>
		<META http-equiv="Content-Type" content="text/html; charset=GB2312">
		<title>审核</title>
	</head><body>                <br/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;正在审核已填拍卖......
	<script type="text/javascript">
	window.location.href="AuctionList.jsp";
	</script>
	</body>
</html>
<%
	}catch (Exception e) {
		out.print(e.toString());
	} finally {
		dImpl.closeStmt();
		dCn.closeCn();
	}
%>
