<%@include file="../skin/head.jsp"%>
<!-- 程序开始 -->
<%
//update20080122

CDataCn dCn=null;
CDataImpl dImpl=null;

try {
 dCn = new CDataCn();
 dImpl = new CDataImpl(dCn);
Adv adv = new Adv();
String AType = "";
/*得到上一个页面传过来的参数  开始*/
AType=CTools.dealString(request.getParameter("AType")).trim();
/*得到上一个页面传过来的参数  结束*/

out.println(adv.ShowAdv(AType));

//关闭连接
dImpl.closeStmt();
dCn.closeCn();
%>

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
