<%@page contentType="text/html; charset=GBK"%>
<%@include file="/system/app/skin/head.jsp"%>
<%
CDataCn dCn = null;
CDataImpl dImpl = null;

String OPType = "";
String id = "";
String strTitle = "";
String sqlStr = "";

String did = "";
String dname = "";
String dfunction = "";

Hashtable content = null;
Vector vec=null;
try{
dCn = new CDataCn();
dImpl = new CDataImpl(dCn);

OPType = CTools.dealString(request.getParameter("OPType")).trim();
id = CTools.dealString(request.getParameter("id")).trim();
strTitle = "机构职能维护 > 新增";
if(OPType.equals("edit")&&!id.equals("")){
	sqlStr = "select * from deptfunction where id = " + id;
	content = dImpl.getDataInfo(sqlStr);
	if(content!=null){
		did = content.get("did").toString();
		dname = content.get("dname").toString();
		dfunction = content.get("dfunction").toString();
		dfunction = dfunction.replaceAll("&","&amp;");
		dfunction = dfunction.replaceAll("<","&lt;");
		dfunction = dfunction.replaceAll(">","&gt;");
		dfunction = dfunction.replaceAll("\"","&quot;");
	}
}
%>
<script LANGUAGE="javascript" src="/system/common/treeview/chooseTreeJs.jsp"></script>
<script LANGUAGE="javascript">
function check(){
	var form = document.formData ;
	if(form.ModuleDirIds.value==0){
		alert("请选择部门！");
		form.ModuleDirIds.focus();
		return false;
	}
	if(form.dfunction.value==""){
		alert("请输入机构职能！");
		form.dfunction.focus();
		return false;
	}
	form.Module.value=form.ModuleDirIds.options[form.ModuleDirIds.selectedIndex].innerText;
	form.submit() ;
}

function del()
{
  if(!confirm("您确定要删除吗？"))return;
  formData.action = "deptfunctionDel.jsp"
  formData.submit();
}
</script>
<%@include file="/system/app/skin/skin4/template/info_top.jsp"%>
<!--    模块名称开始    -->
<%=strTitle%>
<!--    模块名称结束    -->
<%@include file="/system/app/skin/skin4/template/info_funtion.jsp"%>
<!--    功能按钮开始    -->
<img src="../../images/goback.gif" border="0" onclick="javascript:history.back();" title="返回" style="cursor:hand" align="absmiddle">
返回
<!--    功能按钮结束    -->
<%@include file="/system/app/skin/skin4/template/info_main.jsp"%>
<!--    表单提交开始    -->
<table  width="100%"><form action="deptfunctionResult.jsp" method="post" name="formData">
				<tr class="line-even">
					<td width="15%" align="center">选择部门</td>
					<td width="35%" align="left">
						<SELECT NAME="ModuleDirIds" SIZE="1" class="text-line">
						<OPTION value="0" <%=did.equals("")?"selected":""%>>请选择部门
						<%
							sqlStr="select * from tb_deptinfo where dt_infoopendept=1 order by dt_sequence";
							vec=dImpl.splitPage(sqlStr,100,1);
							vec=vec!=null?vec:new Vector();
							for(int i=0;i<vec.size();i++){
								content=(Hashtable)vec.get(i);
						%>
							<OPTION <%=content.get("dt_id").toString().equals(did)?"selected":""%> VALUE="<%=content.get("dt_id").toString()%>"><%=content.get("dt_name").toString()%>
							<%}%>
						</SELECT>
						
						<input type="hidden" name="Module" value="<%=dname%>">
						<input type="hidden" name="ModuleFileIds" value>
						<input type="hidden" name="id" value="<%=id%>">
						<input type="hidden" name="OPType" value="<%=OPType%>">
					</td>
					<td width="15%" align="center">机构职能</td>
					<td width="35%" align="left"><input name="dfunction" type="text" class="text-line" value="<%=dfunction%>" maxlength="16">&nbsp<font color="red">*</font></td>
				</tr>

				<tr class=outset-table>
					<td width="100%" align="center" colspan="4">
					<%if(OPType.equals("add")){%>
					<input class="bttn" value="提交" type="button" onclick="check()" size="6" id="button2" name="button2">&nbsp;
					<%}else{%>
					<input class="bttn" value="修改" type="button" onclick="check()" size="6" id="button4" name="button4">&nbsp;
					<input class="bttn" value="删除" type="button" onclick="del()" size="6" id="button4" name="button4">&nbsp;
					<%}%>
					<input class="bttn" value="返回" type="button" onclick="history.back();" size="6" >
					</td>
				</tr>
		</form>
</table>
<!--    表单提交结束    -->
<%@include file="/system/app/skin/skin4/template/info_bottom.jsp"%> 
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
<%@include file="/system/app/skin/bottom.jsp"%>
                                     
