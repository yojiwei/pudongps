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
     CRoleAccess ado=null; 
     try{
     	dCn = new CDataCn();
     	ado=new CRoleAccess(dCn); 
    
    CSubjectXML tree = new CSubjectXML();
   
    CMySelf self = (CMySelf)session.getAttribute("mySelf");
    String user_id = String.valueOf(self.getMyID());

    if(!ado.isAdmin(user_id))
      tree.setFilterSql(ado.getAccessSqlByUser(user_id,ado.ColumnAccess));

    out.print(tree.getXMLByCurID(0));
    //out.print(tree.getXMLByParentID(0,moduleName));
    tree.dataCn.closeCn();

    ado.closeStmt();
    dCn.closeCn() ;
    } catch (Exception ex) {
	System.out.println(new java.util.Date() + "--"
			+ request.getServletPath() + " : " + ex.getMessage());
} finally {
	if(ado != null)
	ado.closeStmt();
	if(dCn != null)
	dCn.closeCn();
}
%>
</xml>
			<script>
			function title_click(id,value,node)
			{
				var url = "publishList.jsp?sj_id="+id+"&node_title="+value;
				//alert(url)
				parent.frames("main").location.href = url;

			}
			</script>
                        <span id=TreeRoot>...</span>

<SCRIPT LANGUAGE=javascript>
<!--
        onload=init;
//-->
</SCRIPT>
