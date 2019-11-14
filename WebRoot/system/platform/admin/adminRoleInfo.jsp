<%@ page contentType="text/html; charset=GBK" %>
<%@include file="../inc/import.jsp"%>
<%@ page import="com.platform.role.CRoleInfo" %>
<%@ page import="com.platform.admin.*"%>
<%@ page import="java.util.Hashtable"%>
<%@ page import="com.component.database.CDataCn"%>
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
  try{
  	dCn = new CDataCn();
  	jdo = new CAdminInfo(dCn);

  id = java.lang.Long.parseLong(AT_id); //角色的ID
  moduleIds = ","+jdo.getAccess(id,jdo.ROLE_ACCESS)+","; //获取模块的ID列表

  CRoleInfo rInfo = new CRoleInfo(dCn);
  String sql = "select * from RoleInfo where RL_type in (2) order by RL_id desc";
  Vector vectorPage = rInfo.splitPage(sql,request,10000);

  String title="操作：设置角色集";
%>

  <br>
  <form name="formData" method="post" action="adminRoleInfoResult.jsp">
  <fieldset class="main-table">
  <legend>&nbsp;
          [<%=CTools.dealNull(session.getAttribute("_platform_AT_realname"))%>]的角色集&nbsp;
  </legend>

      <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td class=infoTable valign="top">
            <table width="100%" border="0" cellspacing="1" cellpadding="0" align="center">
              <tr class=line-odd>
                <td height="22" width="1%">
                <img src="../images/background-_15.gif" width="15" height="21"></td>
                <td height="22"  align=center background="../images/background-_15a.gif">角色名称</td>
                <td height="22" width="18%" align=center background="../images/background-_15a.gif">角色代码</td>
                <td height="22" width="10%" align=center background="../images/background-_15a.gif">权限</td>
              </tr>
<%
  if (vectorPage != null)
  {
    for(int j=0;j<vectorPage.size();j++)
    {
      Hashtable content = (Hashtable)vectorPage.get(j);
      String RL_name=CTools.dealNull(content.get("rl_name"));
      String RL_code=CTools.dealNull(content.get("rl_code"));
      String RL_id=CTools.dealNull(content.get("rl_id"));
%>
      <tr class=line-odd  onMouseOut="this.style.backgroundColor=''" onMouseOver="this.style.backgroundColor='#ECEAD5'">
      <td align=center><%=j+1%></td>
      <td><%=RL_name%></td>
      <td><%=RL_code%></td>
      <td align=center><input type=checkbox <%if (moduleIds.lastIndexOf(","+RL_id+",")!=-1) out.print("checked");%> class=text-line name='RL_roleids' value='<%=RL_id%>' size=4></td>
      </tr>
<%
    }
  }else{
      out.print("<tr><td colspan=6 align=center class=line-odd><br>没有记录<br><br></td></tr>");
  }

%>

            </table>
          </td>
        </tr>
      </table>
<input type="hidden" name="moduleIds" value="<%=moduleIds%>">
<input type="hidden" name="AT_id" value="<%=AT_id%>">
<input type="hidden" name="action" value="">
</fieldset>
</form>
<%

   //设置本页使用的工具按钮
   String toolsHtml="" +
                    "<input type=button class=imgbtn value=赋予权限 onclick='on_choose()'>&nbsp;\r\n" +
                    "<input type=button class=imgbtn value=返回 onclick=javascript:history.back();>&nbsp;\r\n";

   frm.setCaption(title);
   frm.setToolsHtml(toolsHtml);

   jdo.closeStmt();
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
	if(jdo != null)
	jdo.closeStmt();
	if(dCn != null)
	dCn.closeCn();
}

%>
