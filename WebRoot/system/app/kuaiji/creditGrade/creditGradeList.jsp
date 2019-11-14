<%@page contentType="text/html; charset=GBK"%>
<%@include file="/system/app/skin/head.jsp"%>
<%
String strTitle = "财务会计信用等级列表";
CDataCn dCn = null;
CDataImpl dImpl = null;

try{
dCn = new CDataCn();
dImpl = new CDataImpl(dCn);

String cg_grade = CTools.dealString(request.getParameter("cg_grade")).trim();
String sWhere = "";
if (!cg_grade.equals(""))
{
	sWhere = " and cg_grade = '"+ cg_grade +"'";
}
String strSql="";
strSql = "select cg_id,cg_ep_code,cg_ep_name,cg_ep_kind,cg_grade,cg_sequence from tb_kjcreditgrade where 1=1 "+ sWhere +" order by cg_sequence,cg_id desc";
Vector vectorPage = dImpl.splitPage(strSql,request,20);
String [] gd = new String[5];
if (cg_grade.equals("A"))
{
	gd[1] = "selected";
}
else if (cg_grade.equals("B"))
{
	gd[2] = "selected"; 
}
else if (cg_grade.equals("C"))
{
	gd[3] = "selected"; 
}
else if (cg_grade.equals("D"))
{
	gd[4] = "selected"; 
}
else
{
	gd[0] = "selected"; 
}
%>
<%@include file="/system/app/skin/skin4/template/list_top.jsp"%>
<!--    模块名称开始    -->
<%=strTitle%>
<!--    模块名称结束    -->
<%@include file="/system/app/skin/skin4/template/list_function.jsp"%>                                                            
<!--    功能按钮开始    -->
<select name="cg_grade" class="select-a" onChange="setCreditGrade(this.value)">
  <option value="" <%=gd[0]%>>请选择财务会计信用等级</option>
  <option id="1" value="A" <%=gd[1]%>>财务会计信用等级A类</option>
  <option id="2" value="B" <%=gd[2]%>>财务会计信用等级B类</option>
  <option id="3" value="C" <%=gd[3]%>>财务会计信用等级C类</option>
  <option id="4" value="D" <%=gd[4]%>>财务会计信用等级D类</option>
</select>
<img src="/system/images/new.gif" border="0" onclick="window.location='creditGradeInfo.jsp?OPType=Add'" title="新增信息" style="cursor:hand" align="absmiddle" WIDTH="16" HEIGHT="16">
新增信息
<img src="/system/images/dialog/sort.gif" border="0" onclick="setSequence()" title="修改排序" style="cursor:hand" align="absmiddle" WIDTH="15" HEIGHT="15">
修改排序
<img src="/system/images/menu_about.gif" border="0" onclick="javascript:window.location.href='creditGradeSearch.jsp' " title="查找" style="cursor:hand" align="absmiddle">
查找
<img src="/system/images/goback.gif" border="0" onclick="javascript:history.back();" title="返回" style="cursor:hand" align="absmiddle">
返回                        
<!--    功能按钮结束    -->
<%@include file="/system/app/skin/skin4/template/list_listtop.jsp"%>                                                                                        
<!--    列表开始    -->
<table class="FindAreaTable1" cellspacing="1" rules="cols" border="0" id="ctl00_DataGrid_DataGrid1" style="border-width:0px;">
	<form name="formData">
  <tr class="bttn">
      <td width="44%" class="outset-table">单位名称</td>
      <td width="18%" class="outset-table">企业类型</td>
      <td width="10%" class="outset-table">主管部门</td>
      <td width="12%" class="outset-table">会计信用等级</td>
      <td width="8%" class="outset-table">排序</td>
      <td width="8%" class="outset-table">操作</td>
  </tr>
<%
  if(vectorPage!=null)
  {
    for(int j=0;j<vectorPage.size();j++)
    {
      Hashtable content = (Hashtable)vectorPage.get(j);
      if(j % 2 == 0)  out.print("<tr class=\"line-even\">");
      else out.print("<tr class=\"line-odd\">");
%>
                <td align="center"><%=CTools.dealNull(content.get("cg_ep_name"))%></td>
                <td align="center"><%=CTools.dealNull(content.get("cg_ep_kind"))%></td>
                <td align="center"><%=CTools.dealNull(content.get("cg_ep_code"))%></td>
                <td align="center"><%=CTools.dealNull(content.get("cg_grade"))%></td>
                <td align=center><input type=text class=text-line name='<%="module"+CTools.dealNull(content.get("cg_id"))%>' value="<%=CTools.dealNull(content.get("cg_sequence"))%>" size=4 maxlength=4></td>
                <td align="center"><a href="creditGradeInfo.jsp?OPType=Edit&cg_id=<%=CTools.dealNull(content.get("cg_id"))%>"><img class="hand" border="0" src="/system/images/modi.gif" title=编辑" WIDTH="16" HEIGHT="16"></a>
								&nbsp;
								<a href="creditGradeDel.jsp?OPType=del&cg_id=<%=CTools.dealNull(content.get("cg_id"))%>">
								<img class="hand" border="0" src="/system/images/delete.gif" title="删除" WIDTH="16" HEIGHT="16" onclick="return window.confirm('确认要删除该记录么?');"></a>
								</td>
            </tr>
<%
    }
%>
	</form>
<%
  }
  else
  {
    out.println("<tr><td colspan=20>没有记录！</td></tr>");
  }
%>
</table>
<!--    列表结束    -->
<%@include file="/system/app/skin/skin4/template/list_bottom.jsp"%> 
<%
}
catch(Exception e){
	System.out.print(e.toString());
}
finally{
	dImpl.closeStmt();
	dCn.closeCn(); 
}
%>
<script language="javascript">
function setSequence()
{
	document.formData.action = "setSequence.jsp";
	document.formData.submit();
}
function setCreditGrade(cg_grade)
{
	window.location.href= "creditGradeList.jsp?cg_grade="+cg_grade+"";
}
</script>
<%@include file="/system/app/skin/bottom.jsp"%>