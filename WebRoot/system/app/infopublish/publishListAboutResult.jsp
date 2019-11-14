<%@page contentType="text/html; charset=GBK"%>
<%@include file="../../manage/head.jsp"%>
<%
	String[] chose = request.getParameterValues("checkAt");
	String ct_id = CTools.dealString(request.getParameter("ct_id")).trim();
	String ct_keywords = CTools.dealString(request.getParameter("ct_keywords")).trim();
	String OPType = CTools.dealString(request.getParameter("OPType")).trim();
	int x = chose.length;

	com.website.CountAbout ca = new com.website.CountAbout();
	com.website.CountAboutModel[] cam = new com.website.CountAboutModel[x];

	for (int i = 0;i < x;i++) {
		cam[i] = new com.website.CountAboutModel();
		cam[i].setCt_id_at(chose[i]);			
	}
	
	ca.addAt(cam,ct_id);

%>
<script language="javascript">	
	location.href="publishListAbout.jsp?ct_keywords=<%=ct_keywords%>&ct_id=<%=ct_id%>&OPType=<%=OPType%>";
</script>