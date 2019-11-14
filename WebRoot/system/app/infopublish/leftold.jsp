<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="../../manage/head.jsp" %>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title>上海浦东门户网站后台管理系统</title>
<style type="text/css">
<!--
@import url("/system/app/skin/skin3/images/main.css");
-->
</style>
<link href="/system/app/skin/skin3/images/style.css" rel="stylesheet" type="text/css">
<html>
<head>
<meta http-equiv="pragma" content="no-cache">
<link href="../style.css" rel="stylesheet" type="text/css">
<title></title>
<script LANGUAGE="javascript" src="/system/common/treeview/treeJs.js"></script>
</head>
<body topmargin=0 leftmargin=0>

  <xml id=xmlDoc>
<%
    CDataCn  dCn = null;
    try{
    	 dCn = new CDataCn();
    CSubjectXML tree = new CSubjectXML(dCn);
    CRoleAccess ado=new CRoleAccess(dCn);
    CMySelf self = (CMySelf)session.getAttribute("mySelf");
    String user_id = String.valueOf(self.getMyID());
//out.print((ado.getAccessSqlByUser(user_id,ado.ColumnAccess)));

	String strXml=CTools.dealNull(session.getAttribute("_InfoSubject"));
	if(strXml.equals(""))
	{
		if(!ado.isAdmin(user_id))
		  tree.setFilterSql(ado.getAccessSqlByUser(user_id,ado.ColumnAccess));
		strXml=tree.getXMLByCurID(0);
		session.setAttribute("_InfoSubject",strXml);
	}

    out.print(strXml);
    tree.dataCn.closeCn();

    ado.closeStmt();
    dCn.closeCn() ;
%>
</xml>
			<script>
			function title_click(id,value,node)
			{
				var url = "publishList.jsp?sj_id="+id+"&node_title="+value;
				parent.frames("main").location.href = url;

			}
			</script>
                        <span id=TreeRoot>...</span>

<SCRIPT LANGUAGE=javascript>
<!--
        onload=init;
//-->
</SCRIPT>
<%


} catch (Exception ex) {
	System.out.println(new java.util.Date() + "--"
			+ request.getServletPath() + " : " + ex.getMessage());
} finally {

	if(dCn != null)
	dCn.closeCn();
}

%>
