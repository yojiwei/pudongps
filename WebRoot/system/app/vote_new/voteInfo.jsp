<%@page contentType="text/html; charset=GBK"%>
<%@include file="/system/app/skin/head.jsp"%>
<%
String strTitle="网上投票管理";
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
<script language=javascript>
function dovalidate()
{
  sForm=document.form1;
   for(i=0;i<sForm.length;i++)
   {
    if(sForm[i].title!="")
     if(sForm[i].value=="")//
    {
    sWarn=sForm[i].title+"不能为空!";
    alert(sWarn);
     sForm[i].focus();
     return false ;
     }
   }
  if(isInt(sForm.vt_listnum.value))
  { bl=true;}
  else
    {alert("请输入正确的数字!");
  sForm.vt_listnum.focus();
  return false;
  }
return true;
}
</script>
<table WIDTH="100%" CELLPADDING="0" BORDER="0" class="main-table">
<form name="form1" method="post" action="votelistInfo.jsp" onsubmit="return dovalidate();">
   <tr>
        <td width="100%" align="left" valign="top">
			<table class="content-table" height="" width="100%">
			    <tr align="center" class="title1">
			      <td height="18" colspan="2">网上调查</td>
			    </tr>
				<tr class="line-odd">
			      <td width="13%" height="18"  align="right">调查主题</td>
			      <td width="87%"><input name="vt_content" type="text"  size="60" maxlength="200" title="调查主题">
				  &nbsp;<font color=red>*</font></td>
			    </tr>
			    <tr  class="line-odd">
			      <td align="right">选项个数</td>
			      <td><input name="vt_listnum" type="text" title="选项个数">&nbsp;<font color=red>*</font></td>
			    </tr>
			</table>
		 </td>
</tr>
<tr class=outset-table>
		<td width="100%" align="right" colspan="2">
		    <p align="center">
			<input class="bttn" value="提交" type="submit" size="6" id="button2" name="button2">&nbsp;
			<input class="bttn" value="返回" type="button"  size="6" id="button3" name="button3" onclick="javascript:history.go(-1)">
		 </td>
</tr>
</form>
</table>
<!--    表单提交结束    -->
<%@include file="/system/app/skin/skin4/template/info_bottom.jsp"%> 

<%@include file="/system/app/skin/bottom.jsp"%>
                                     
