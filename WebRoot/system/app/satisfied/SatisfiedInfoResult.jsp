<%@ page contentType="text/html; charset=GBK" %>
<%@include file="../skin/head.jsp"%>
<%
//update20090603

CDataCn dCn=null;   //新建数据库连接对象
CDataImpl dImpl=null;  //新建数据接口对象
String optype="";
String pa_id="";
String dt_id="";
String pa_answer="",pa_ask="";
String pr_id="";
boolean flag=true;
String ac_ispublic = "";
String ac_type = "";

try {
dCn = new CDataCn(); 
dImpl = new CDataImpl(dCn); 
SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

optype = CTools.dealString(request.getParameter("OPType")).trim();
pa_id = CTools.dealString(request.getParameter("pa_id")).trim();
ac_type = CTools.dealString(request.getParameter("ac_type")).trim();
pa_ask = CTools.dealString(request.getParameter("pa_ask")).trim();
pa_answer = CTools.dealString(request.getParameter("pa_answer")).trim();
ac_ispublic = CTools.dealString(request.getParameter("ac_ispublic")).trim();

if(optype.equals("Edit"))
{
	dImpl.edit("tb_proceeding_ask","pa_id",pa_id);
	dImpl.setValue("pa_ask",pa_ask,CDataImpl.STRING);
	dImpl.setValue("pa_answer",pa_answer,CDataImpl.STRING);
	dImpl.setValue("ac_type",ac_type,CDataImpl.STRING);
	dImpl.setValue("ac_ispublic",ac_ispublic,CDataImpl.STRING);
	dImpl.setValue("ac_date",df.format(new java.util.Date()),CDataImpl.DATE);//修改的时间
	dImpl.update();
}
else
{
	dImpl.addNew("tb_proceeding_ask","pa_id",CDataImpl.PRIMARY_KEY_IS_VARCHAR);
	dImpl.setValue("ac_type",ac_type,CDataImpl.STRING);
	dImpl.setValue("ac_ispublic",ac_ispublic,CDataImpl.STRING);
	dImpl.setValue("pa_ask",pa_ask,CDataImpl.STRING);
	dImpl.setValue("pa_answer",pa_answer,CDataImpl.STRING);
	dImpl.setValue("table_name","tb_askanswer",CDataImpl.STRING);//工商的新增
	dImpl.setValue("ac_date",df.format(new java.util.Date()),CDataImpl.DATE);//新增的时间
	dImpl.update();
}

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
<script language="javascript">
window.location.href="AnswerList.jsp?pr_id=<%=pr_id%>";
</script>
<%@include file="../skin/bottom.jsp"%>