<%@page contentType="text/html; charset=GBK"%>
<%@include file="/system/app/skin/head.jsp"%>
<%
String strTitle = "用户查询";
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
<table class="main-table" width="100%">
<script LANGUAGE="javascript" src="./common/common.js"></script>
<form name="formData" method="post" action="searchList.jsp"  target="">
 <tr class="title1" align=center>
      <td><%=strTitle%></td>
    </tr>
  <tr>
     <td width="100%">

         <table width="100%" class="content-table" height="1">
          <tr class="line-even" >
            <td width="19%" align="right">用户名：</td>
            <td width="81%" align="left">
            	<input type="text" class="text-line" size="50" name="us_uid" maxlength="150">
            </td>
          </tr>
          <tr class="line-odd" >
            <td width="19%" align="right">单位名称：</td>
            <td width="81%" align="left">
            	<input type="text" class="text-line" size="50" name="ec_name" maxlength="150">
            </td>
          </tr>
          <tr class="line-even" >
            <td width="19%" align="right">法人代表：</td>
            <td width="81%" align="left">
            	<input type="text" class="text-line" size="50" name="ec_corporation" maxlength="150">
            </td>
          </tr>
   <tr class="outset-table" align="center">
       <td colspan="2">
<input type="submit" class="bttn" name="fsubmit" value="查 询" >&nbsp;
<input type="reset" class="bttn" name="fsubmit" value="重 写">&nbsp;
<input type="button" class="bttn" name="back" value="返 回" onclick="history.back();">
 </td>
   </tr>
  </table>
</tr>
</td>

</form>
</table>
<!--    表单提交结束    -->
<%@include file="/system/app/skin/skin4/template/info_bottom.jsp"%> 

<%@include file="/system/app/skin/bottom.jsp"%>
                                     
