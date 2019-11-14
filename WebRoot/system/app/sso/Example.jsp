<%@page contentType="text/html;charset=GBK"%>
<%@include file="../skin/head.jsp"%>
<!--开始-->
<%
//update20080122

CDataCn dCn=null;   //新建数据库连接对象


try {
 dCn = new CDataCn();


//CDataImpl dImpl = new CDataImpl(dCn); //新建数据接口对象
Adv adv  = new Adv(dCn); //新建广告对象

%>
<table border="1">
<tr>
	<td><%=adv.ShowAdv("home_bannerhead")%></td>
</tr>
</table>
<%

//out.println(adv.ShowAdv("sp"));
out.println(adv.ShowAdv("ff"));
out.println(adv.ShowAdv("qq"));
//out.println(adv.ShowAdv("piao"));
//out.println(adv.aaa());
//关闭连接
//dImpl.closeStmt();
dCn.closeCn();
%>
<%


} catch (Exception ex) {
	System.out.println(new java.util.Date() + "--"
			+ request.getServletPath() + " : " + ex.getMessage());
} finally {

	if(dCn != null)
	dCn.closeCn();
}

%>
