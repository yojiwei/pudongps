<%@page contentType="text/html; charset=GBK"%>
<%@include file="/system/app/skin/head.jsp"%>
<script language="javascript">
	function doAction() {
		if (formData.beginTime.value != null && formData.endTime.value != "") {
			var startDate = formData.beginTime.value;
			var endDate = formData.endTime.value;
			if (dateDiff(startDate,endDate)	 == false) {
				alert("开始时间不能小于结束时间！");
				return false;
			}
		}
		var statusLen = formData.status.length;
		var status1 = "";
		for (var i = 0; i < statusLen;i++) {
				if (formData.status[i].checked)
					status1 += formData.status[i].value + ",";
		}
		if (status1 != "") {
			status1 = status1.substring(0,status1.length - 1);
			formData.status1.value = status1;
		}
		formData.submit();
	}
	
	
	/**
	 * return false 开始时间小于结束时间
	 * return true 开始时间大于结束时间
	**/
	function dateDiff(start_date,end_date){
		var startDt = start_date.split("-");
		var endDt = end_date.split("-");
		var startYr = new Number(startDt[0]);
		var startMon = new Number(startDt[1]);
		var startDay = new Number(startDt[2]);
		var endYr = new Number(endDt[0]);
		var endMon = new Number(endDt[1]);
		var endDay = new Number(endDt[2]);
		if (startYr > endYr) 
			return false;
		else if (startYr < endYr)
			return true;
		else {
		if (startMon > endMon)
			return false;
		else if (startMon < endMon)
			return true;
		else {
		if (startDay > endDay)
			return false;
		else 
			return true;
		}
		}
		return true;
	}
</script>
<%
CDataCn dCn = null;
CDataImpl dImpl = null;
try{
dCn = new CDataCn();
dImpl = new CDataImpl(dCn);
%>
<%@include file="/system/app/skin/skin4/template/info_top.jsp"%>
<!--    模块名称开始    -->
信件查询
<!--    模块名称结束    -->
<%@include file="/system/app/skin/skin4/template/info_funtion.jsp"%>
<!--    功能按钮开始    -->

<!--    功能按钮结束    -->
<%@include file="/system/app/skin/skin4/template/info_main.jsp"%>
<!--    表单提交开始    -->
<table align="center" width="100%" class="main-table">
<form name="formData" method="post" action="QueryList.jsp">
	<input type="hidden" name="status1" value="">
	<tr class="line-even">
		<td width="15%" align="right">申请人</td>
		<td align="left"><input name="applyPeople" class="text-line" maxlength="20"></td>
	</tr>
	<tr class="line-odd">
		<td width="15%" align="right">申请时间</td>
		<td align="left"><input name="beginTime" style="cursor:hand" class="text-line" readonly size="10" onclick="showCal()">&nbsp;至&nbsp;<input style="cursor:hand" name="endTime" class="text-line" readonly size="10" onclick="showCal()"></td>
	</tr>
	<tr class="line-even">
		<td width="15%" align="right">主题</td>
		<td align="left"><input name="pr_name" size="40" class="text-line" maxlength="40"></td>
	</tr>
	<tr class="line-odd">
		<td width="15%" align="right">信件状态</td>
		<td align="left">
			<input type="checkbox" name="status" class="checkbox1" value="1" checked>待处理
			<input type="checkbox" name="status" class="checkbox1" value="2" checked>处理中
			<input type="checkbox" name="status" class="checkbox1" value="3" checked>已完成
		</td>
	</tr>
		<!--tr class="line-even">
		<td width="15%" align="right">信件类别</td>
		<td align="left">
<select name="cp_id" onchange="selectType(this)">
<option value="11844">投诉监督</option>
</select>
		</td>
	</tr-->
	<tr class=outset-table width="100%">
		<td colspan="2" class="outset-table">
			<input type="button" class="bttn" value="查询" onClick="doAction();">&nbsp;
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
                                     
