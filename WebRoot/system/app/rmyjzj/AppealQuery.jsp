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
		<td width="25%" align="right">申请人</td>
		<td width="75%" align="left"><input name="applyPeople" class="text-line" maxlength="20"></td>
	</tr>
	<tr class="line-odd">
		<td align="right">申请时间</td>
		<td align="left"><input name="beginTime" style="cursor:hand" class="text-line" readonly size="10" onclick="showCal()">&nbsp;至&nbsp;<input style="cursor:hand" name="endTime" class="text-line" readonly size="10" onclick="showCal()"></td>
	</tr>
	<tr class="line-even">
		<td align="right">信件类别</td>
		 <td align="left"> 
		  <select name="pr_name" class="input-mailBox">
			<option value="">所有类别</option>
			<option value="经济发展">经济发展</option>
			<option value="城市建设">城市建设</option>
			<option value="市容环境">市容环境</option>
			<option value="教育医疗">教育医疗</option>
			<option value="社会管理">社会管理</option>
			<option value="就业保障">就业保障</option>
			<option value="政府改革">政府改革</option>
			<option value="科技创新">科技创新</option>
			</select>
		</td>
	</tr>
	<tr class="line-odd">
		<td align="right">事项状态</td>
		<td align="left">
			<input type="checkbox" name="status" class="checkbox1" value="1" checked>待处理
			<input type="checkbox" name="status" class="checkbox1" value="2" checked>进行中
			<input type="checkbox" name="status" class="checkbox1" value="18" checked>协调完成
			<input type="checkbox" name="status" class="checkbox1" value="8" checked>协调中
		</td>
	</tr>
	<tr class="outset-table" width="100%">
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
                                     
