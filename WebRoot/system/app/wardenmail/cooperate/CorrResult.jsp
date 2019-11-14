<%@ page contentType="text/html; charset=GBK" %>
<%@include file="../../skin/head.jsp"%>
<%
String cw_id = "";
String cp_id = "";
String OPType = "";
//String sender_id="";

//CMySelf self = (CMySelf)session.getAttribute("mySelf");
//out.println(self.getDtId());/
//selfdtid = String.valueOf(self.getDtId());
//sender_id = String.valueOf(self.getMyID());

cw_id = CTools.dealString(request.getParameter("cw_id")).trim();
cp_id = CTools.dealString(request.getParameter("conntype")).trim();
OPType = CTools.dealString(request.getParameter("OPType")).trim();
out.println(cw_id + " cp ");
out.println(cp_id);

/*out.println(selfdtid);
out.println(sender_id);
out.println(wo_id);
out.println(pr_id);*/

/*
out.println(corrdt_id);
out.println(pc_timelimit);
*/
//update20080122

CDataCn dCn=null;   //新建数据库连接对象
CDataImpl dImpl=null;  //新建数据接口对象

try {
 dCn = new CDataCn(); 
 dImpl = new CDataImpl(dCn); 

dCn.beginTrans();
dImpl.edit("tb_connwork","cw_id",cw_id);

dImpl.setValue("cp_id",cp_id,CDataImpl.STRING);
dImpl.update();

if(dCn.getLastErrString().equals(""))
{
  dCn.commitTrans();
}
else
{
  dCn.rollbackTrans();
}

dImpl.closeStmt();
dCn.closeCn();
%>
<script language="javascript">
window.opener.location.href = "CorrForm.jsp?cw_id=<%=cw_id%>&cp_id=<%=cp_id%>&OPType=<%=OPType%>";
window.close();
</script>
<%@include file="../../skin/bottom.jsp"%>
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