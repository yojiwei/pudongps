<%@page contentType="text/html; charset=GBK"%>
<%@include file="/system/app/skin/head.jsp"%>
<%
String optype="";
String ty_id="";
String ty_name="";
String ty_ispublic = "";
String stroptype = "";
optype = CTools.dealString(request.getParameter("OPType")).trim();
ty_id = CTools.dealString(request.getParameter("ty_id")).trim();

if(optype.equals("Edit"))
{
	stroptype="修改档案图片类别";
}
else 
{
	stroptype="新增档案图片类别";
}
String sqlInfo = "";
Hashtable contInfo = null;
CDataCn dCn = null;
CDataImpl dImpl = null;
try{
dCn = new CDataCn();
dImpl = new CDataImpl(dCn);
//
if(optype.equals("Edit"))
{
	sqlInfo = "select ty_id,ty_name,ty_ispublic from tb_daxxtype where ty_id='"+ty_id+"'";
	contInfo = dImpl.getDataInfo(sqlInfo);
	if(contInfo!=null){
		ty_id = CTools.dealNull(contInfo.get("ty_id"));
		ty_name = CTools.dealNull(contInfo.get("ty_name"));
		ty_ispublic = CTools.dealNull(contInfo.get("ty_ispublic"));
	}
}
%>
<%@include file="/system/app/skin/skin4/template/info_top.jsp"%>
<!--    模块名称开始    -->
档案图片类别管理
<!--    模块名称结束    -->
<%@include file="/system/app/skin/skin4/template/info_funtion.jsp"%>
<!--    功能按钮开始    -->
<%=stroptype%>
<!--    功能按钮结束    -->
<%@include file="/system/app/skin/skin4/template/info_main.jsp"%>
<!--    表单提交开始    -->
<table align="center" width="100%" CELLPADDING="1" cellspacing="1">
<tr>
<td>
<form method="post" name="formData" action="typeInfoResult.jsp" enctype="multipart/form-data">
	<table border="0" width="100%" cellpadding="0" cellspacing="0" class="content-table">
      	<tr>
        	<td width="100%" align="left" valign="top">
	  		<table border="0" width="100%" cellspacing="1" cellpadding="0">
				<tr class="line-odd" >
           			<td width="14%" align="right">是否前台发布：</td>
            		<td width="86%"><input type="checkbox" name="ty_ispublic" value="0" <%=ty_ispublic.equals("0")?"checked":""%>/>是</td>
          		</tr>
	  	 		 <tr class="line-even" >
           			<td width="14%" align="right">类别名称：</td>
            		<td width="86%" ><input type="text" name="ty_name" value="<%=ty_name%>"/></td>
          		</tr>
                 <tr class="line-even" >
           				 <td align="right">类别图片：</td>
            				 <td><input type="file" name="ty_filename" /></td>
          		</tr>
			</table>
        	</td>
      	</tr>
      	<tr colspan="2" class="outset-table">
        <td width="100%" align="center">
          <input class="bttn" value="提交" type="button" size="6" name="btnSubmit" onclick="check();">&nbsp;
				  <%if(optype.equals("Edit")){%>
				  <input class="bttn" value="删除" type="button" size="6" name="btnSubmit" onclick="del();">&nbsp;
				  <%}%>
          <input class="bttn" value="返回" type="button" onclick="history.back();" size="6" >
		  		<INPUT TYPE="hidden" name="OPType" value="<%=optype%>">
		  		<INPUT TYPE="hidden" name="ty_id" value="<%=ty_id%>">
        </td>
      </tr>
    </table>
</form>
</td>
</tr>
</table>
<script>
function check()
{
	if(formData.ty_name.value == "")
	{
		alert("请填写类别名称!");
		formData.pa_ask.focus();
		return false;
	}
	formData.submit();
}
function del()
{
	if(confirm("确认删除该问答?"))
	{
		window.location.href("typeDel.jsp?ty_id=<%=ty_id%>");
	}
}
</script>
<!--    表单提交结束    -->
<%@include file="/system/app/skin/skin4/template/info_bottom.jsp"%> 
<%
}
catch(Exception e){
	System.out.println(new java.util.Date() + "--"
			+ request.getServletPath() + " : " + e.getMessage());
}
finally{
	dImpl.closeStmt();
	dCn.closeCn(); 
}
%>
<%@include file="/system/app/skin/bottom.jsp"%>
                                     
