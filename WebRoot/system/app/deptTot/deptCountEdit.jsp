<%@page contentType="text/html; charset=GBK"%>
<%@include file="/system/app/skin/head.jsp"%>
<link href="../style.css" rel="stylesheet" type="text/css">
<script LANGUAGE="javascript">
<!--
function check()
{
	var form = document.formData ;
	if (form.tt_dtname.value == "" ) { 
		alert("名称不能为空！") ;
		form.tt_dtname.focus();
		return;
	}
	if (form.tt_dir.value == "" ) { 
		alert("代码不能为空！") ;
		form.tt_dir.focus();
		return;
	}
	form.submit() ;
}

function del()
{
  if (!confirm("您确定要删除该数据吗？")) return;
  formData.action = "deptCountDel.jsp";
  formData.submit();
}
//-->
</script>

<script language="javascript" for="window" event="onload">
	document.formData.tt_dtname.focus();
</script>
<%
String tt_type = CTools.dealString(request.getParameter("tt_type"));					//存储的类型
String type = CTools.dealString(request.getParameter("type"));						 	//添加 add，修改 edit
String tt_id = CTools.dealString(request.getParameter("tt_id"));

String sqlStr = "";	
Hashtable content = null;
String tt_dtname = "";
String tt_dir = "";
String percent = "";
String title = "新增";

if (type.equals("edit")) {
	sqlStr = "select * from tb_totdept where tt_id = " + tt_id;
	title = "修改";
}
CDataCn dCn = null;
CDataImpl dImpl = null;
try{
dCn = new CDataCn();
dImpl = new CDataImpl(dCn);

content = dImpl.getDataInfo(sqlStr);
if (content != null) {
	tt_dtname = content.get("tt_dtname").toString();
	tt_dir = content.get("tt_dir").toString();
	percent = content.get("tt_dtids").toString();
}
%>
<%@include file="/system/app/skin/skin4/template/info_top.jsp"%>
<!--    模块名称开始    -->
<%=title %>
<!--    模块名称结束    -->
<%@include file="/system/app/skin/skin4/template/info_funtion.jsp"%>
<!--    功能按钮开始    -->
<img src="/system/images/dialog/return.gif" border="0" onclick="javascirpt:history.go(-1);" title="返回" style="cursor:hand" align="absmiddle" id="image3" name="image3" WIDTH="14" HEIGHT="14">
返回			
<!--    功能按钮结束    -->
<%@include file="/system/app/skin/skin4/template/info_main.jsp"%>
<!--    表单提交开始    -->
<table CELLPADDING="0" width="100%" BORDER="0">
<form action="deptCountEditResult.jsp" method="post" name="formData">
<input type="hidden" name="tt_id" value="<%=tt_id%>">
<input type="hidden" name="tt_type" value="<%=tt_type%>">
<input type="hidden" name="type" value="<%=type%>">
      <tr>
        <td width="100%" align="left" valign="top">
	  	 <table border="0" width="100%" cellspacing="1" cellpadding="0">
	  	  <tr class="line-odd">
	  	    <td width="15%" align="right">名称：</td>
	  	    <td width="85%"><input class="text-line" name="tt_dtname" size="20" value="<%=tt_dtname%>" maxlength="20"></td>
		  </tr>
	  	  <tr class="line-even">
	  	    <td width="15%" align="right">代码：</td>
	  	    <td width="85%"> <input class="text-line" type="text" name="tt_dir" value="<%=tt_dir%>" maxlength="20">&nbsp;&nbsp;</td>
	  	  </tr>
	  	  <%
	  	  	if (tt_type.equals("0")) {
	  	  %>
	  	  <tr class="line-even">
	  	    <td width="15%" align="right">百分比统计：</td>
	  	    <td width="85%"> 
				<input type="radio" name="percent" value="1" <%=percent.equals("1") ? "checked" : ""%>>是&nbsp;&nbsp;
				<input type="radio" name="percent" value="" <%="".equals(percent) ? "checked" : ""%>>否	  	    
	  	    </td>
	  	  </tr>
	  	  <%
	  	  	}
	  	  %>
	  	</table>
        </td>
       </tr>
	   <tr>
		  <td width="100%" align="right" colspan="2" class="outset-table">
		      <p align="center">
				<% if (type.equals("add")) {//新增
				 %>
	  		<input class="bttn" value="提交" type="button" onclick="check()" size="6">&nbsp;
				<% }else{ %>
	  		<input class="bttn" value="修改" type="button" onclick="check()" size="6">&nbsp;
	  		<input class="bttn" value="删除" type="button" size="6" onclick="del()">&nbsp;
				<% } %>
	  		<input class="bttn" value="返回" type="button" onclick="history.back()" size="6">&nbsp;

		    </td>
		</tr>
    </table>
  </div>
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
                                     
