<%@ page contentType="text/html; charset=GBK" %>
<%@include file="../inc/import.jsp"%>
<%
   out.println(frm.getTopHtml());
%>
<%
  String AT_id=""; //角色id
  String moduleIds = "";
  long id;
  AT_id=CTools.dealNumber(request.getParameter("AT_id"));
%>
<script LANGUAGE="javascript" src="../../common/treeview/treeJs.jsp"></script>
<%
  CDataCn  dCn = null;
  CAdminInfo  jdo = null;
  CModuleXML tree = null;
  try{	
  	dCn = new CDataCn();
  	jdo = new CAdminInfo(dCn);
  	tree = new CModuleXML(dCn);
  id = java.lang.Long.parseLong(AT_id); //角色的ID
  //tree
  moduleIds = jdo.getAccess(id,jdo.STRUCTURE_ACCESS); //获取模块的ID列表

  String title="操作：设置功能集";
%>
  <xml id=xmlDoc>
   <%
           out.print(tree.getXMLByParentID(0)); //输出XML
           tree.dataCn.closeCn(); //关闭数据库连接
   %>
  </xml>
  <br>
  <fieldset class="main-table">
  <legend>&nbsp;
          [<%=CTools.dealNull(session.getAttribute("_platform_AT_realname"))%>]的功能集&nbsp;
  </legend>

<br><span id=TreeRoot></span><br><br>
<form name="formData" method="post" action="adminModuleInfoResult.jsp">
<input type="hidden" name="moduleIds" value="<%=moduleIds%>">
<input type="hidden" name="AT_id" value="<%=AT_id%>">
<input type="hidden" name="action" value="">
</form>
</fieldset>
<%

   //设置本页使用的工具按钮
   String toolsHtml="" +
                    "<input type=button class=imgbtn value=赋予权限 onclick='on_choose()'>&nbsp;\r\n" +
                    "<input type=button class=imgbtn value=返回 onclick=javascript:history.back();>&nbsp;\r\n";

   frm.setCaption(title);
   frm.setToolsHtml(toolsHtml);

   jdo.closeStmt();
   tree.closeStmt();
   dCn.closeCn() ;
%>
<SCRIPT LANGUAGE=javascript>
<!--
function on_choose()
{
  formData.moduleIds.value = getSelectedDirIds();
  formData.submit();
}
function title_click(id,value,node)
{
  //alert(node.xml)
}
function initThis()
{
  setSupportMultiSelect(1);
  setInitDirIds(formData.moduleIds.value);
  setSupportAutoSelect(1);
  init();
}
onload=initThis;
//-->
</SCRIPT>
<%
   out.println(frm.getBottomHtml());
%>
<%


} catch (Exception ex) {
	System.out.println(new java.util.Date() + "--"
			+ request.getServletPath() + " : " + ex.getMessage());
} finally {
	if(tree != null)
	tree.closeStmt();
	if(jdo != null)
	jdo.closeStmt();
	if(dCn != null)
	dCn.closeCn();
}

%>