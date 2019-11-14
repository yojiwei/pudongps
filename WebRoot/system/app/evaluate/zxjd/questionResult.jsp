
<%@page contentType="text/html; charset=GBK"%>
<%@include file="/system/app/skin/head.jsp"%>
<%@page import="com.util.*"%>
<%@page import="java.util.*"%>
<%@page import="Evaluate.*"%>
<%@page import="vote.*"%>


<%
 CDataCn dCn = null;
 CDataImpl dImpl = null;
try{
  dCn = new CDataCn();
  dImpl = new CDataImpl(dCn);
  

  java.util.Date FinishTime = new java.util.Date();

  String jd_id = CTools.dealString(request.getParameter("jd_id")).trim();
  String wt_id = CTools.dealString(request.getParameter("wt_id")).trim();

  String wt_feddback = CTools.dealString(request.getParameter("wt_feddback")).trim();
  //jd_date = CTools.dealString(request.getParameter("jd_date")).trim();
  //jd_address = CTools.dealString(request.getParameter("jd_address")).trim();
  //jd_depart = CTools.dealString(request.getParameter("jd_depart")).trim();
  //jd_duty = CTools.dealString(request.getParameter("jd_duty")).trim();
 
 //out.print(wt_feddback);
 //if(true) return;

  //dCn.beginTrans();

   dImpl.edit("tb_onlinewt","wt_id",wt_id);
  dImpl.setValue("wt_feddback",wt_feddback,CDataImpl.STRING);
  dImpl.setValue("wt_solvedate",FinishTime.toLocaleString(),CDataImpl.DATE);

  dImpl.update();

  

%>
 <script language="javascript">
  alert("回复信息成功！");
    window.location="list.jsp?jd_id=<%=jd_id%>"
 </script>
<%
 }
catch(Exception e){
	out.print(e.toString());
	%>
	 <script language="javascript">
  alert("发生错误，录入失败！错误：<%=dCn.getLastErrString()%>");
    window.history.go(-1);
 </script>
	<%
 }
 finally{
dImpl.closeStmt();
dCn.closeCn(); 
}
%>