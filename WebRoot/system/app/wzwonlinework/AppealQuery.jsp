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
查询信件
<!--    模块名称结束    -->
<%@include file="/system/app/skin/skin4/template/info_funtion.jsp"%>
<!--    功能按钮开始    -->

<!--    功能按钮结束    -->
<%@include file="/system/app/skin/skin4/template/info_main.jsp"%>
<!--    表单提交开始    -->
<table align="center" width="100%" class="main-table">
<form name="formData" method="post" action="QueryList.jsp">
	<tr class="line-even">
		<td width="25%" align="right">收文号</td>
		<td width="75%" align="left"><input name="reciveid" class="text-line" maxlength="20"></td>
	</tr>
	<tr class="line-odd">
		<td align="right">申请时间</td>
		<td align="left"><input name="beginTime" style="cursor:hand" class="text-line" readonly size="10" onclick="showCal()">&nbsp;至&nbsp;<input style="cursor:hand" name="endTime" class="text-line" readonly size="10" onclick="showCal()"></td>
	</tr>
	<tr class="line-even">
		<td align="right">项目名称</td>
       <td align="left"><input name="cp_name" size="40" class="text-line" maxlength="40"></td> 
	</tr>
    <!--tr class="line-odd">
		<td align="right">经办处室</td>
       <td align="left"><input name="depat" size="10" class="text-line" maxlength="10"></td> 
	</tr-->
    <tr class="line-even">
		<td align="right">经办人</td>
       <td align="left"><input name="person" size="10" class="text-line" maxlength="10"></td> 
	</tr>
   <!-- <tr class="line-odd">
		<td align="right">经办处室</td>
       <td><input name="pr_name" size="40" class="text-line" maxlength="40"></td> 
	</tr-->
	<tr class="line-odd">
		<td align="right">办理状态</td>
		<td align="left">
		    <input type="checkbox" name="status1" class="checkbox1" value="审批中" checked>审批中
			<input type="checkbox" name="status2" class="checkbox1" value="待领取" checked>待领取
			<input type="checkbox" name="status3"" class="checkbox1" value="已办结" checked>已办结
		</td>
	</tr>
	<tr class=outset-table width="100%">
		<td colspan="2" class="outset-table">
			<input type="submit" class="bttn" value="搜索">&nbsp;
			<input type="reset" class="bttn" value="重写">&nbsp;
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
                                     
