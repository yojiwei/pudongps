<%@ page contentType="text/html; charset=GBK" %>
<%@include file="/system/app/skin/import.jsp"%>
<%@include file="/system/app/islogin.jsp"%>
<%
	/*String Login=(String)session.getAttribute("Login");
	if (Login==null)
	{
		out.print("<script language=javascript>");
		out.print("window.parent.location='/system/index.htm'");
		out.print("</script>");
		return;
	}
	*/
%>
<html>
<head>
<title>后台管理</title>
<link rel="stylesheet" href="main.css" type="text/css">
<script LANGUAGE="javascript" src="../common/treeview/treeJs.js"></script>

</head>
<body>
  <xml id=xmlDoc>
  <%
					CMySelf mySelf = (CMySelf)session.getAttribute("mySelf");
          CModuleXML tree = new com.platform.module.CModuleXML();
          if(mySelf!=null)
          {
            tree.setAccessByMyID(mySelf.getMyID());
          }
          out.print(tree.getXMLByParentID(0));
          tree.dataCn.closeCn();
  %>
</xml>
<table border="0" cellspacing="0" cellpadding="0" height="100%" width="100%">
  <tr>
    <td width="100%" align="left" valign="top">
      <table width="100%" border="0" cellspacing="0" cellpadding="0" height="100%">
        <tr>
          <td width="100" bgcolor="6692BE" valign="top">
            <TABLE BORDER=0 CELLSPACING=2 CELLPADDING=2>
              <tr>
                <td height=1><span id=TreeRoot></span></td>
              </tr>
              </TR>
              <!--
              <tr>
                <td align="center"><a href="http://www.sohu.com" target="_blank">切换系统</a></td>
              </tr>
              </TR>
              -->
            </TABLE>
          </td>
        </tr>
      </table>
    </td>
  </tr>
</table>
</body>
</html>
<script>
function title_click(id,value,node)
{
       //alert(id);
       top.redirect.location.href="navigator.jsp?id=" + id;
       /*
       for(var i=0;i<top.frames.length;i++)
       {
         alert(top.frames[i].name);
       }
       */

}
onload=init;
</script>
