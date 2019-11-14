<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="../head.jsp" %>
<html>
<head>
<meta http-equiv="pragma" content="no-cache">
<link href="../style.css" rel="stylesheet" type="text/css">
<title></title>
<script LANGUAGE="javascript" src="/system/common/treeview/treeJs.js"></script>
</head>


<body  topmargin="0" leftmargin=10  >
  <xml id=xmlDoc>
<%
    CDataCn  dCn = null;
    CDeptXML tree = new CDeptXML();
    CRoleAccess ado=null;
    try{
    	dCn = new CDataCn();
    	ado=new CRoleAccess(dCn);
    CMySelf self = (CMySelf)session.getAttribute("mySelf");
    String user_id = String.valueOf(self.getMyID());

    if(!ado.isAdmin(user_id))
      tree.setFilterSql(ado.getAccessSqlByUser(user_id,ado.OrganAccess));

    out.print(tree.getXMLByParentID(0));
    //out.print(tree.getXMLByParentID(0,moduleName));
    tree.dataCn.closeCn();

    ado.closeStmt();
    dCn.closeCn() ;
%>
</xml>
   <script>
   function title_click(id,value,node)
{
var url = "userList.jsp?list_id="+id+"&node_title="+value;
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
<%


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
