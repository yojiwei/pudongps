<%@ page contentType="text/html; charset=GBK"%>
<%@ page import="com.component.treeview.*"%>
<%@ page import="com.component.database.*"%>
<script LANGUAGE="javascript">
</script>
</head>

<xml id=xmlDoc>
<%
	CDataCn dCn = null;
	CTreeXML tree = null;
	try {
		dCn = new CDataCn();
		tree = new CTreeXML(dCn, "Subject");
		out.print(tree.getXMLByParentID(0));
		dCn.closeCn();
	} catch (Exception ex) {
		System.out.println(new java.util.Date() + "--"
		+ request.getServletPath() + " : " + ex.getMessage());
	} finally {
		if (tree != null)
			tree.closeStmt();
		if (dCn != null)
			dCn.closeCn();
	}
%>
</xml>

<span id=t></span>
