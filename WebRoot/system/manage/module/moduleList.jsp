<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="../head.jsp" %>
<link href="../style.css" rel="stylesheet" type="text/css">
<script LANGUAGE="javascript">
<!--
function addnew(list_id,node_title)
{
  var form = document.formData ;
  form.list_id.value = list_id ;
  form.node_title.value = node_title ;
  form.action = "moduleInfo.jsp";
  form.submit();
}
function query(list_id,node_title)
{
	//alert(node_title)
	var form = document.formData ;
	form.list_id.value = list_id ;
	form.node_title.value = node_title ;
	form.submit();
}
function edit(ft_id,list_id,node_title)
{
        //alert(node_title)
        var form = document.formData ;
        form.list_id.value = list_id ;
        form.node_title.value = node_title ;
        form.action = "moduleInfo.jsp?ft_id="+ft_id;
        form.submit();
}

function setSequence(list_id,node_title)
{
	var form = document.formData ;
	form.list_id.value = list_id ;
	form.node_title.value = node_title ;
	form.action = "setSequence.jsp";
	form.submit();
}

document.onkeypress = checkKey;
function checkKey()
{
	if (!(event.keyCode > 47 && event.keyCode < 58))
	{
		alert("请您输入0-9的数值!");
		return false;
	}


}
//-->
</script>
<%
   String list_id,node_title ;
   String sql = "";
   String title = "管理系统模块(注:若不清楚该功能,请勿使用,谢谢!)";
   String se ;
   CTools tools = null;
%>
<%
 //CManager manage = (CManager)session.getAttribute("manager");
 //String moduleName = manage.getAtModule();


    CDataCn  dCn = null; 
    CRoleAccess ado=null;
    try{
    	dCn = new CDataCn(); 
        ado=new CRoleAccess(dCn);
    CModuleXML tree = new com.platform.module.CModuleXML();
    
    CMySelf self = (CMySelf)session.getAttribute("mySelf");
    String user_id = String.valueOf(self.getMyID());
    String filterSql="";

    if(!ado.isAdmin(user_id))
      filterSql=ado.getAccessSqlByUser(user_id,ado.ModuleAccess);


 tools = new CTools();
 list_id    =CTools.dealString(request.getParameter("list_id"));
 // if(list_id.equals("")) list_id = "1";
 node_title = tools.iso2gb(request.getParameter("node_title"));

 if (list_id == null || list_id.equals("")){
	 list_id = "1";
	 sql = "select * from tb_function where ft_parent_id = " + list_id + " "+filterSql+" order by ft_sequence";
 }else{
	 sql = "select * from tb_function where ft_parent_id = " + list_id + " "+filterSql+" order by ft_sequence";
 }
//out.print(list_id);

// out.print(list_id);
// out.close();
 CModuleInfo jdo = new CModuleInfo();
 jdo.setSql(sql);
%>


 <table class="main-table" width="100%">
 <form name="formData" action="moduleList.jsp" method="post">
<input type="hidden" name="list_id" value=<%=list_id%>>
<input type="hidden" name="node_title" value=<%=node_title%>>
	<tr>
  <td width="100%">
       <table class="content-table" width="100%">

		<tr class="title1">
			<td colspan="5" align="center">
				<table WIDTH="100%" BORDER="0" CELLSPACING="1" CELLPADDING="1">
					<tr>
						<td valign="center"><%=title%></td>
						<td valign="center" align="right" nowrap>
              <img src="/system/images/dialog/split.gif" align="middle" border="0" WIDTH="5" HEIGHT="8">
              <img src="/system/images/dialog/new.gif" border="0" onclick="addnew(<%=list_id%>,'<%=node_title%>')" title="新建模块" style="cursor:hand" align="absmiddle" WIDTH="16" HEIGHT="16">
              <img src="/system/images/dialog/split.gif" align="middle" border="0" WIDTH="5" HEIGHT="8">
              <img src="/system/images/dialog/sort.gif" border="0" onclick="setSequence(<%=list_id%>,'<%=node_title%>')" title="修改排序" style="cursor:hand" align="absmiddle" WIDTH="15" HEIGHT="15">
              <img src="/system/images/dialog/split.gif" align="middle" border="0" WIDTH="5" HEIGHT="8">
              <img src="/system/images/dialog/print.gif" border="0" onclick="javascript:printTree('functions','',<%=list_id %>,true);" title="返回" style="cursor:hand" align="absmiddle">

              <img src="/system/images/dialog/split.gif" align="middle" border="0" WIDTH="5" HEIGHT="8">
              <img src="/system/images/dialog/goback.gif" border="0" onclick="javascript:history.back();" title="返回" style="cursor:hand" align="absmiddle">

              <img src="/system/images/dialog/split.gif" align="middle" border="0" WIDTH="5" HEIGHT="8">
						</td>
					</tr>
				</table>
			</td>
		</tr>
               <tr class="bttn">
			<td width="25%" class="outset-table">模块名称</td>
			<td width="42%" class="outset-table">可操作角色</td>
			<td width="15%" class="outset-table">权限代号</td>
			<td width="8%" class="outset-table" nowrap>编辑</td>
    			<td width="10%" class="outset-table">排序</td>
		</tr>
<%

  Vector vectorPage = jdo.splitPage(request);
 if (vectorPage != null){
    for(int j=0;j<vectorPage.size();j++)
    {
      Hashtable content = (Hashtable)vectorPage.get(j);
      if(j % 2 == 0)  out.print("<tr class=\"line-even\">");
      else out.print("<tr class=\"line-odd\">");
      se = content.get("ft_sequence").toString() ;
      String ft_id = content.get("ft_id").toString() ;
      String roleNames=jdo.getRoleNames(Long.parseLong(ft_id));
      if (se==null) se = "";
      out.println("<td><a href=javascript:query(" + content.get("ft_id") + ",'" + content.get("ft_name") + "') >" + content.get("ft_name")+ "</a></td>");
      out.println("<td title=\""+roleNames+"\">" + CTools.trimTitle(roleNames,20) + "</td>");
      out.println("<td>" + content.get("ft_code") + "</td>");
      out.println("<td align=center><a href=javascript:edit("+content.get("ft_id")+","+list_id+",'"+node_title+"')><img src='/system/images/dialog/icon3.gif' border='0' height=16 width=16 title='修改'></a></td>");
      out.println("<td><input type=text class=text-line name='module"+content.get("ft_id")+"' value='" + se + "' size=4 maxlength=4></td>");
      out.println("</tr>");
    }

  }else{
    out.println("<tr><td>没有记录！</td></tr>");
  }

%>
</form>
<%
out.println("<tr><td colspan=10>" + jdo.getTail(request) + "</td></tr>"); //输出尾部文件
%>
</table>
		</td>
	</tr>
</table>

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

