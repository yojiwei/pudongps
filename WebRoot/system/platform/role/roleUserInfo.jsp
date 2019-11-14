<%@ page contentType="text/html; charset=GBK"%>
<%@ page import="com.platform.CManager"%>
<%@ include file="../head.jsp"%>
<%
String tr_id = ""; //角色id
		String sql = "";
		long id;

		tr_id = CTools.dealNumber(request.getParameter("tr_id"));

		%>
<script LANGUAGE="javascript"
	src="/system/common/treeview/chooseTreeJs.js"></script>
<script LANGUAGE="javascript">
function on_choose_user()
{
  if(chooseTree('user')) formData.submit();
}
function SelectAll()
{
        formData.delList.checked=formData.CheckList1.checked;
        var o = formData.delList ;
        for (var i = 0; i < o.length; i++) {
                if (!o[i].disabled)
                        o[i].checked = formData.CheckList1.checked;
        }
}
function on_del_user()
{
  var bHaveSelected=false;
  if (formData.delList.checked==true)
    bHaveSelected=true;

  var o = formData.delList;
  for (var i = 0; i < o.length; i++) {
      //如果选中了任何一个，设定标志
      if(o[i].checked ==true)
              bHaveSelected= true;
  }

   if (!bHaveSelected)
   {
      alert("请选择需要移出的用户！");
      return false;
   }

  if (confirm("确定要将选中的用户从该角色中移出吗？"))
  {
    formData.action = "roleUserMove.jsp";
    formData.submit();
  }
}
</script>
<table class="main-table" width="100%">
	<form name="formData" method="post" action="roleUserResult.jsp">
	<tr class="title1">
		<td width="100%" align="left" colspan="2">
		<table WIDTH="100%" BORDER="0" CELLSPACING="0" CELLPADDING="0">
			<tr>
				<td id="TitleTd" width="100%" align="left"><b>当前角色：<%=session.getAttribute("_platform_tr_name").toString()%>&nbsp;&nbsp;当前操作：用户</b></td>
				<td align="right" nowrap><img src="/system/images/dialog/split.gif"
					align="middle" border="0"> <input type="checkbox" id="CheckList1"
					title="选中所有的目录。" style="cursor:hand" value="全选"
					onclick="SelectAll();"> <label for="CheckList1" class="hand"
					title="选中所有的目录。">全选</label> <img
					src="/system/images/dialog/split.gif" align="middle" border="0"> <img
					src="/system/images/dialog/new.gif" border="0" title="新增用户"
					style="cursor:hand" onclick="on_choose_user()" align="absmiddle"
					WIDTH="16" HEIGHT="16"> <img src="/system/images/dialog/split.gif"
					align="middle" border="0"> <img
					src="/system/images/dialog/delete.gif" border="0" title="移出用户"
					style="cursor:hand" onclick="on_del_user();" align="absmiddle"
					WIDTH="16" HEIGHT="16"> <img src="/system/images/dialog/split.gif"
					align="middle" border="0"> <img
					src="/system/images/dialog/return.gif" border="0"
					onclick="javascript:history.back();" title="返回" style="cursor:hand"
					align="absmiddle" WIDTH="14" HEIGHT="14"> <img
					src="/system/images/dialog/split.gif" align="middle" border="0"> <input
					type="hidden" name="tr_id" value="<%=tr_id%>"> <input type="hidden"
					name="user" value="" treeType="Dept" treeTitle="选择部门用户"
					isSupportMultiSelect="1" isSupportFile="1"> <input type="hidden"
					name="userDirIds" value> <input type="hidden" name="userFileIds"
					value></td>
			</tr>

			<tr class="igray">
				<td width="100%" align="left" colspan="2"><a
					href="roleInfo.jsp?tr_id=<%=tr_id%>">基本</a>&nbsp;&nbsp; <a
					href="roleUserInfo.jsp?tr_id=<%=tr_id%>">用户</a>&nbsp;&nbsp; <a
					href="roleModuleInfo.jsp?tr_id=<%=tr_id%>">权限</a>&nbsp;&nbsp; <a
					href="roleSubjectInfo.jsp?tr_id=<%=tr_id%>">栏目</a>&nbsp;&nbsp; <a
					href="roleAuditInfo.jsp?tr_id=<%=tr_id%>">审核</a>&nbsp;&nbsp;</td>
			</tr>
		</table>
		</td>
	</tr>

	<tr>
		<td width="100%">
		<table border="0" width="100%" cellpadding="0" cellspacing="1"
			height="44">
			<tr class="bttn">
				<td width="10%" height="1" class="outset-table">序号</td>
				<td width="40%" height="1" class="outset-table">部门</td>
				<td width="40%" height="1" class="outset-table">用户</td>
				<td width="10%" height="1" class="outset-table">删除</td>

			</tr>
			<%

		CDataCn dCn = null;
CRoleInfo jdo= null;
  try{
  	dCn = new CDataCn();
  	jdo= new CRoleInfo(dCn);

		CManager manage = (CManager) session.getAttribute("manager");
		String orgname = manage.getAtOrgname();
		id = java.lang.Long.parseLong(tr_id);
		sql = jdo.getUsers(id);
		//      out.print(sql);
		if (sql.equals(""))
			sql = "select UR_id,ur_ic from UserInfo where 1<>1"  ;
		jdo.setTableName("TB_ROLEINFO");
		jdo.setSql(sql);

		Vector vectorPage = jdo.splitPage(request);
		if (vectorPage != null) {
			for (int j = 0; j < vectorPage.size(); j++) {
				Hashtable content = (Hashtable) vectorPage.get(j);
				if (j % 2 == 0)
					out.print("<tr class=\"line-even\">");
				else
					out.print("<tr class=\"line-odd\">");

				out.println("<td>" + (j + 1) + "</td>");
				out.println("<td>" + content.get("dt_name").toString()
						+ "</td>");
				out.println("<td>" + content.get("ui_name").toString()
						+ "</td>");
				out.println("<td><input type=checkbox name=delList value='"
						+ content.get("ui_id").toString() + "'></td>");
				out.println("</tr>");
			}
		} else {
			out.print("<td>没有记录！</td>");
		}
		%>
		</form>
			<tr>
				<td colspan=10><%out.println(jdo.getTail(request));%></td>
			</tr>
		</table>
		</td>
	</tr>
</table>
</td>
</tr>

</table>
<%
jdo.closeStmt();
		dCn.closeCn();
		} catch (Exception ex) {
	System.out.println(new java.util.Date() + "--"
			+ request.getServletPath() + " : " + ex.getMessage());
} finally {
	if(jdo!= null)
	jdo.closeStmt();
	if(dCn != null)
	dCn.closeCn();
}
%>

