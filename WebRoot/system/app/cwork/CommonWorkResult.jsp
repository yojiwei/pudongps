<%@page contentType="text/html; charset=GBK"%>
<%@include file="../skin/import.jsp"%>
<%
String workName = "";
String sequence = "";
String userKind = "";
String workId   = "";
String workFlag = "";

workName = CTools.dealString(request.getParameter("workName")).trim();
sequence = CTools.dealNumber(request.getParameter("sequence"));
userKind = CTools.dealString(request.getParameter("userKind")).trim();
workId   = CTools.dealString(request.getParameter("workId")).trim();
workFlag = CTools.dealNumber(request.getParameter("workFlag"));

//update20080122

CDataCn dCn=null;   //新建数据库连接对象
CDataImpl dImpl=null;  //新建数据接口对象

try {
 dCn = new CDataCn(); 
 dImpl = new CDataImpl(dCn); 


if(workId.equals(""))
{
	dImpl.addNew("tb_commonwork","cw_id",CDataImpl.PRIMARY_KEY_IS_VARCHAR);
}
else
{
	dImpl.edit("TB_COMMONWORK","CW_ID",workId);
}
dImpl.setValue("CW_NAME",workName,CDataImpl.STRING);
dImpl.setValue("CW_SEQUENCE",sequence,CDataImpl.INT);
dImpl.setValue("UK_ID",userKind,CDataImpl.STRING);
dImpl.setValue("CW_FLAG",workFlag,CDataImpl.INT);
dImpl.update();
dImpl.closeStmt();
dCn.closeCn();

} catch (Exception ex) {
	System.out.println(new java.util.Date() + "--"
			+ request.getServletPath() + " : " + ex.getMessage());
} finally {
	if(dImpl != null)
	dImpl.closeStmt();
	if(dCn != null)
	dCn.closeCn();
}
response.sendRedirect("CommonWorkList.jsp");
%>
<%@include file="../skin/bottom.jsp"%>


