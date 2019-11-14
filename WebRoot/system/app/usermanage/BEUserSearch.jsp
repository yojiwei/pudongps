<%@page contentType="text/html; charset=GBK"%>
<%@include file="/system/app/skin/head.jsp"%>
<%
CDataCn dCn = null;
CDataImpl dImpl = null;
try{
dCn = new CDataCn();
dImpl = new CDataImpl(dCn);
%>
<%@include file="/system/app/skin/skin4/template/info_top.jsp"%>
<!--    模块名称开始    -->
企业用户查询
<!--    模块名称结束    -->
<%@include file="/system/app/skin/skin4/template/info_funtion.jsp"%>
<!--    功能按钮开始    -->

<!--    功能按钮结束    -->
<%@include file="/system/app/skin/skin4/template/info_main.jsp"%>
<!--    表单提交开始    -->
<table WIDTH="100%" CELLPADDING="0" cellspacing="0" BORDER="0">

<form name="formData" method="post" action="BEUserList.jsp"  target="">
     <td width="100%">
         <table width="100%" class="content-table" height="1">
          <tr class="line-even" >
            <td width="19%" align="right">用户帐号：
            </td>
            <td width="81%"  align="left"><input type="text" class="text-line" size="50" name="us_uid" maxlength="150"   >
            </td>
          </tr>
          <tr class="line-odd">
            <td width="19%" align="right" >单位名称：
            </td>
            <td width="81%" align="left" ><input type="text" class="text-line" size="50" name="ec_name" maxlength="150"  >
            </td>
          </tr>
		  <tr class="line-even" >
            <td width="19%" align="right">注册地址：
            </td>
            <td width="81%"  align="left"><input type="text" class="text-line" size="50" name="ec_enroladd" maxlength="150"   >
            </td>
          </tr>
		<tr class="line-odd">
            <td width="19%" align="right" >email：
            </td>
            <td width="81%" align="left" ><input type="text" class="text-line" size="50" name="ec_email" maxlength="150"  >
            </td>
         </tr>
	<tr class="outset-table" align="center">
	 <td colspan="2">
	<input type="submit" class="bttn" value="查 询" >&nbsp;
	<input type="reset" class="bttn"  value="重 写">&nbsp;
	<input type="hidden" name="OPType" value="Search">
	<input type="button" class="bttn" name="back" value="返 回" onclick="history.back();">
 	</td>
	</tr>
	</table>
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
                                     
