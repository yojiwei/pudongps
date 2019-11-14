<%@page contentType="text/html; charset=GBK"%>
<%@include file="/system/app/skin/head.jsp"%>
<%
String strTitle="新增用户类型";
String UK_ID = "";
String UK_NAME = "";
String actiontype="add";
//
CDataCn dCn = null;
CDataImpl dImpl = null;
try{
dCn = new CDataCn();
dImpl = new CDataImpl(dCn);
//
UK_ID = CTools.dealString(request.getParameter("UK_ID")).trim();
if(!UK_ID.equals(""))
{
  String strSql = "select * from tb_userkind where UK_ID = '" + UK_ID + "'";
  Hashtable content = dImpl.getDataInfo(strSql);
  if (content!=null)
  {
    UK_NAME=content.get("uk_name").toString();
    actiontype="modify";
	}
  strTitle = "用户类别管理";
}
%>
<%@include file="/system/app/skin/skin4/template/info_top.jsp"%>
<!--    模块名称开始    -->
<%=strTitle%>
<!--    模块名称结束    -->
<%@include file="/system/app/skin/skin4/template/info_funtion.jsp"%>
<!--    功能按钮开始    -->

<!--    功能按钮结束    -->
<%@include file="/system/app/skin/skin4/template/info_main.jsp"%>
<!--    表单提交开始    -->
<script>
	function checkSpace(obj) {
		var bool = false;
		for (var i = 0;i < obj.length;i++) {
			if (obj.substring(i,i + 1) == " " || obj.substring(i,i + 1) == "　") {
				bool = true;
			}
			else {
				bool = false;
				break;
			}
		}
		if (bool == true) return true;
		else return false;
	}
	function checkForm()
	{
	    if(formData.UK_NAME.value=="")
	    {
	       alert("请填写类别名称");
	       formData.UK_NAME.focus();
	       return false;
	    }
	    if (checkSpace(formData.UK_NAME.value) == true)  {
	    	alert("类别名称不能全部为空格！");
	    	formData.UK_NAME.focus();
	    	return false;
	    }
	    formData.submit();
	}
</script>
<table WIDTH="100%" CELLPADDING="0" cellspacing="0" BORDER="0">
<form action="UserKindResult.jsp" method="post" name="formData">
   <tr>
     <td width="100%" align="left" valign="top">
      <table class="content-table"  width="100%">
      <tr class="line-even" >
        <td  colspan=2>请填写注册资料：（注意带有<font color=red>*</font>的项目必须填写）</td>
		  </tr>
      <tr class="line-odd">
        <td align="right">类别名称<font color=red>*</font></td><td align="left">
       		<input type="text" name="UK_NAME" value="<%=UK_NAME%>" class="text-line" maxlength="50">
        </td>
      </tr>
      <tr class=outset-table>
  <td align=center colspan=2>
    <input type=button name=b1 onclick="checkForm()" value="提交" class="bttn" >&nbsp;
    <input type=reset name=b3 value="重填" class="bttn">&nbsp;
    <input type=button name=b2 onclick="javascript:history.go(-1);" value="返回" class="bttn" >&nbsp;
  </td>
 </tr>
</table>
  </td>
 </tr>
<input type=hidden name=actiontype value=<%=actiontype%>>
<input type=hidden name=UK_ID value=<%=UK_ID%>>
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
                                     
