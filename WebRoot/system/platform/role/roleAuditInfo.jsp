<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="../head.jsp" %>
<%
String tr_id=""; //角色id
String subjectIds = "";
long id;
tr_id=CTools.dealNumber(request.getParameter("tr_id"));

%>
<script LANGUAGE="javascript" src="/system/common/treeview/treeJs.js"></script>
<SCRIPT LANGUAGE=javascript>
<!--
function on_choose()
{
  formData.subjectIds.value = getSelectedDirIds();
  formData.submit();
}
function title_click(id,value,node)
{
  //alert(node.xml)
  //alert(getSelectedDirIds());
}
function initThis()
{
  setSupportMultiSelect(1);
  setInitDirIds(formData.subjectIds.value);
  setSupportAutoSelect(1);
  init();
}
onload=initThis;
//-->
</SCRIPT>
<%
  CDataCn  dCn = null;
  CRoleInfo  jdo = null;
  CSubjectXML tree = null;
  try{
  	dCn = new CDataCn();
  	jdo = new CRoleInfo(dCn);
    tree = new CSubjectXML(dCn);
    
    
  id = java.lang.Long.parseLong(tr_id); //角色的ID
  subjectIds = jdo.getAudits(id); //获取模块的ID列表
%>
  <xml id=xmlDoc>
  <%
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
                <table width="100%" cellspacing="0">
                        <tr class="title1">
                                <td id="TitleTd" width="100%" align="left">当前角色：<%=session.getAttribute("_platform_tr_name").toString()%> 当前操作：栏目</td>
                                <td valign="top" align="right" nowrap>
                                <img src="/system/images/dialog/split.gif" align="middle" border="0">

                                <img src="/system/images/dialog/return.gif" border="0" onclick="javascirpt:history.go(-1);" title="返回" style="cursor:hand" align="absmiddle" id="image3" name="image3" WIDTH="14" HEIGHT="14">
                                <img src="/system/images/dialog/split.gif" align="middle" border="0">
                             </td>
                         </tr>

                   <tr class="igray" height="3">
                      <td width="100%" align="left" colspan="2">
                                <a href="roleInfo.jsp?tr_id=<%=tr_id%>">基本</a>&nbsp;&nbsp;
                                <a href="roleUserInfo.jsp?tr_id=<%=tr_id%>">用户</a>&nbsp;&nbsp;
                                <a href="roleModuleInfo.jsp?tr_id=<%=tr_id%>">权限</a>&nbsp;&nbsp;
                                <a href="roleSubjectInfo.jsp?tr_id=<%=tr_id%>">栏目</a>&nbsp;&nbsp;
  <a href="roleAuditInfo.jsp?tr_id=<%=tr_id%>">审核</a>&nbsp;&nbsp;
                                <span style="color:red"></span>
                      </td>
                   </tr>


                </table>
      </td>
    </tr>

   <tr>
     <td width="100%">
                <span id=TreeRoot>...</span>
         </td>
   </tr>
   <tr class="title1">
      <td width="100%" align="center" colspan="2">
          <input type="button" class="bttn" value="赋予选定栏目" onclick="on_choose()">
         <!-- <input type="button" class="bttn" value="赋予全部权限" onclick="window.navigate('roleInfoResult.asp?id=29&amp;GiveAccess=true');"  id="button1" name="button1">-->
                  <input type="button" class="bttn" value="返回" onclick="javascript:history.back();">
      </td>
   </tr>
</table>
</td>
</tr>
</table>
<form name="formData" method="post" action="roleAuditResult.jsp">
<input type="hidden" name="subjectIds" value="<%=subjectIds%>">
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
