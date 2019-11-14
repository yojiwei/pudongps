<%@page contentType="text/html; charset=GBK"%>
<%@include file="/website/include/import.jsp"%>
<%@page import="java.text.*" %>
<%
	String us_uid = CTools.dealString(request.getParameter("us_uid")).trim();
	String gu_check = CTools.dealString(request.getParameter("gu_check")).trim();
	String strSql = "";
	String gu_id = "";
	SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd hh:MM:ss");
	CDataCn dCn = null;
	CDataImpl dImpl = null;
	Hashtable content = null;
	try {
		dCn = new CDataCn();
		dImpl = new CDataImpl(dCn);
		
		strSql = "select gu_id from tb_usergsj where gu_uid = '"+us_uid+"'";
		content  =dImpl.getDataInfo(strSql);
		if(content!=null){
			gu_id = CTools.dealNull(content.get("gu_id"));
		}
		if(!"".equals(gu_id)){
			dImpl.edit("tb_usergsj","gu_id",gu_id);
		}else{
			dImpl.addNew("tb_usergsj","gu_id");	
		}
		dImpl.setValue("gu_uid",us_uid,CDataImpl.STRING);
		dImpl.setValue("gu_check",gu_check,CDataImpl.STRING);
		dImpl.setValue("gu_time",df.format(new java.util.Date()),CDataImpl.DATE);
		dImpl.update();
		
	}catch (Exception e) {
		out.print(e.toString());
	} finally {
		dImpl.closeStmt();
		dCn.closeCn();
	}
%>
<script type="text/javascript">
	window.location.href="AnswerUser.jsp";
</script>