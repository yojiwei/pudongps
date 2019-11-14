<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="../head.jsp" %>
<%
String tr_id=""; //角色id
String moduleIds = "";
long id;
tr_id=CTools.dealNumber(request.getParameter("tr_id"));

%>
<script LANGUAGE="javascript" src="/system/common/treeview/treeJs.js"></script>

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
  CDataCn  dCn = null;
  CRoleInfo  jdo = null;
  CModuleXML tree = null;
  try{
  	dCn = new CDataCn();
  	jdo = new CRoleInfo(dCn);
  	tree = new CModuleXML(dCn);
 // CManager manage = (CManager)session.getAttribute("manager");
 // String module = manage.getAtModule();

  CRoleAccess ado=new CRoleAccess(dCn);

  id = java.lang.Long.parseLong(tr_id); //角色的ID
  //moduleIds = jdo.getModules(id); //获取模块的ID列表
  moduleIds=ado.getAccessByRole(tr_id,ado.ModuleAccess);
%>
  <xml id=xmlDoc>
<%
CMySelf self = (CMySelf)session.getAttribute("mySelf");
String user_id = String.valueOf(self.getMyID());
//if(!ado.isAdmin(user_id))
//            tree.setFilterSql(ado.getAccessSqlByRole());

out.print(tree.getXMLByParentID(0)); //输出XML
tree.dataCn.closeCn(); //关闭数据库连接
%>
</xml>
<table class="main-table" width="100%">
  <tr>
   <td>
  <table width="100%">
    <tr>
      <td width="100%" align="left" colspan="2">
<%String Operate="设置管理的模块";%>
<%@ include file="nav.jsp" %>
      </td>
    </tr>

   <tr>
     <td width="100%">
                <span id=TreeRoot>...</span>
         </td>
   </tr>
   <tr class="title1">
      <td width="100%" align="center" colspan="2">
          <input type="button" class="bttn" value="赋予选定权限"  onclick="on_choose()">
         <!-- <input type="button" class="bttn" value="赋予全部权限" onclick="window.navigate('roleInfoResult.asp?id=29&amp;GiveAccess=true');"  id="button1" name="button1">-->
                  <input type="button" class="bttn" value="返回" onclick="javascript:history.back();">
      </td>
   </tr>
</table>
</td>
</tr>
</table>
<form name="formData" method="post" action="roleFunctionsInfoResult.jsp">
<input type="hidden" name="moduleIds" value="<%=moduleIds%>">
<input type="hidden" name="tr_id" value="<%=tr_id%>">
<input type="hidden" name="action" value="">

</form>

<%
  jdo.closeStmt();
  tree.closeStmt();
  dCn.closeCn() ;
  } catch (Exception ex) {
	System.out.println(new java.util.Date() + "--"
			+ request.getServletPath() + " : " + ex.getMessage());
} finally {
	if(jdo != null)
	jdo.closeStmt();
	if(tree != null)
	tree.closeStmt();
	if(dCn != null)
	dCn.closeCn();
}
%>
