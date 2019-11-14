<%@include file="../skin/head.jsp"%>
<!-- 程序开始 -->
<%
CDataCn dCn = new CDataCn();
CDataImpl dImpl = new CDataImpl(dCn);
ddd adv = new ddd();
String AType = "";
/*得到上一个页面传过来的参数  开始*/
AType=CTools.dealString(request.getParameter("AType")).trim();
/*得到上一个页面传过来的参数  结束*/

out.println(adv.ShowAdv(AType));

//关闭连接
dImpl.closeStmt();
dCn.closeCn();
%>