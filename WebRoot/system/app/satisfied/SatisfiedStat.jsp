<%@page contentType="text/html; charset=GBK"%>
<%@include file="/system/app/skin/head.jsp"%>
<script src="wdatepicker/WdatePicker.js" type="text/javascript"></script>
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
<%@include file="/system/app/skin/skin4/template/info_top.jsp"%>
<!--    模块名称开始    -->
满意度查询
<!--    模块名称结束    -->
<%@include file="/system/app/skin/skin4/template/info_funtion.jsp"%>
<!--    功能按钮开始    -->
满意度查询&nbsp;&nbsp;&nbsp;&nbsp;<a href="voteSee.jsp">满意度统计</a> 
<!--    功能按钮结束    -->
<%@include file="/system/app/skin/skin4/template/info_main.jsp"%>
<!--    表单提交开始    -->

<table align="center" width="100%" CELLPADDING="1" cellspacing="1">
<form name="formData" method="post" action="SatisfiedStat.jsp">
	<input type="hidden" name="status1" value="">
	<tr class="line-odd">
		<td width="15%" align="right">查询时间</td>
		<td width="18%" align="left"><input name="beginTime" type="text" class="text-line" size="10" value="" readonly onClick="WdatePicker()" style="cursor:hand">&nbsp;至&nbsp;<input name="endTime" type="text" class="text-line" size="10" value="" readonly onClick="WdatePicker()" style="cursor:hand"></td>
	    <td align="left"><select name="mailtype">
		<option value="">请选择</option>
		<option value="o1">区长信箱</option>
		<option value="o5">信访信箱、人民意见征集</option>
		<option value="mailYGXX">区委书记信箱</option>
		<option value="mailWSZX">网上咨询</option>
		</select></td>
    </tr>
	<tr class="title1" width="100%">
		<td colspan="3" class="outset-table">
			<input type="button" class="bttn" value="查询" onClick="doAction();">&nbsp;
			<input type="reset" class="bttn" value="重写">&nbsp;		</td>
	</tr>
</form>
</table>

<!-- 查询结果 -->
<%
String begintime = "";
String endtime = "";
String mailtype = "";
String my = "";
String jbmy = "";
String bmy = "";
String timemy = "";
String timejbmy = "";
String timebmy = "";
String resultmy = "";
String resultjbmy = "";
String resultbmy = "";

String staSql = "select count(decode(c.cs_satis,'1','1','')) as my,count(decode(c.cs_satis,'2','1','')) as yb,count(decode(c.cs_satis,'3','1','')) as bmy,count(decode(c.cs_timesatis,'1','1','')) as timemy,count(decode(c.cs_timesatis,'2','1','')) as timeyb,count(decode(c.cs_timesatis,'3','1','')) as timebmy,count(decode(c.cs_resultsatis,'1','1','')) as resultmy,count(decode(c.cs_resultsatis,'2','1','')) as resultyb,count(decode(c.cs_resultsatis,'3','1','')) as resultbmy from tb_connsatisfied c,tb_connwork w where c.cw_id = w.cw_id ";

CDataCn dCn = null;
CDataImpl dImpl = null;
Hashtable stacontent = null;
try{
dCn = new CDataCn();
dImpl = new CDataImpl(dCn);

begintime = CTools.dealString(request.getParameter("beginTime")).trim();
endtime = CTools.dealString(request.getParameter("endTime")).trim();
mailtype = CTools.dealString(request.getParameter("mailtype")).trim();
if(!"".equals(begintime)){
	staSql += " and c.cs_date > to_date('"+begintime+"','yyyy-MM-dd')";
}
if(!"".equals(endtime)){
	staSql += " and c.cs_date < to_date('"+endtime+"','yyyy-MM-dd')";
}
if(!"".equals(mailtype)){
	if("mailWSZX".equals(mailtype)){
		staSql += " and w.cp_id in(select c.cp_id from tb_connproc c,tb_deptinfo d where c.cp_id <> 'o11893' and c.cp_id <> 'o11890' and c.cp_id <> 'o11835' and c.dt_id=d.dt_id and (c.cp_upid='o7' or c.cp_upid = 'o10000'))";
	}else{
		staSql += " and w.cp_id  ='"+mailtype+"'";
	}
}
staSql += " order by c.cs_id desc ";

//out.println(staSql);

stacontent = dImpl.getDataInfo(staSql);
if(stacontent!=null){
	my = CTools.dealNull(stacontent.get("my"));
	jbmy = CTools.dealNull(stacontent.get("yb"));
	bmy = CTools.dealNull(stacontent.get("bmy"));
	timemy = CTools.dealNull(stacontent.get("timemy"));
	timejbmy = CTools.dealNull(stacontent.get("timeyb"));
	timebmy = CTools.dealNull(stacontent.get("timebmy"));
	resultmy = CTools.dealNull(stacontent.get("resultmy"));
	resultjbmy = CTools.dealNull(stacontent.get("resultyb"));
	resultbmy = CTools.dealNull(stacontent.get("resultbmy"));
}
%>
<table align="center" width="100%" CELLPADDING="1" cellspacing="1">
	<tr class="line-odd">
		<td width="37%" rowspan="2" align="right">来信人对办理部门工作作风、工作态度的评价统计</td>
		<td width="23%" align="center">满意</td>
		<td width="20%" align="center">基本满意</td>
	    <td width="20%" align="center">不满意</td>
	</tr>
	<tr class="line-even">
	    <td align="center"><a href="SatisfiedList.jsp?ac_type=1&caf_type=cs_satis&beginTime=<%=begintime%>&endTime=<%=endtime%>&mailtype=<%=mailtype%>"><strong><%=my%></strong></a></td>
		<td align="center"><a href="SatisfiedList.jsp?ac_type=2&caf_type=cs_satis&beginTime=<%=begintime%>&endTime=<%=endtime%>&mailtype=<%=mailtype%>"><strong><%=jbmy%></strong></a></td>
	    <td align="center"><a href="SatisfiedList.jsp?ac_type=3&caf_type=cs_satis&beginTime=<%=begintime%>&endTime=<%=endtime%>&mailtype=<%=mailtype%>"><font color="red"><strong><%=bmy%></strong></font></a></td>
	</tr>
		<tr class="line-odd">
		<td width="37%" rowspan="2" align="right">来信人对信访事项办理时效的评价统计</td>
		<td width="23%" align="center">满意</td>
		<td width="20%" align="center">基本满意</td>
	    <td width="20%" align="center">不满意</td>
	</tr>
	<tr class="line-even">
	    <td align="center"><a href="SatisfiedList.jsp?ac_type=1&caf_type=cs_timesatis&beginTime=<%=begintime%>&endTime=<%=endtime%>&mailtype=<%=mailtype%>"><strong><%=timemy%></strong></a></td>
		<td align="center"><a href="SatisfiedList.jsp?ac_type=2&caf_type=cs_timesatis&beginTime=<%=begintime%>&endTime=<%=endtime%>&mailtype=<%=mailtype%>"><strong><%=timejbmy%></strong></a></td>
	    <td align="center"><a href="SatisfiedList.jsp?ac_type=3&caf_type=cs_timesatis&beginTime=<%=begintime%>&endTime=<%=endtime%>&mailtype=<%=mailtype%>"><font color="red"><strong><%=timebmy%></strong></font></a></td>
	</tr>
		<tr class="line-odd">
		<td width="37%" rowspan="2" align="right">来信人对信访事项办理结果的意见统计</td>
		<td width="23%" align="center">满意</td>
		<td width="20%" align="center">基本满意</td>
	    <td width="20%" align="center">不满意</td>
	</tr>
	<tr class="line-even">
	    <td align="center"><a href="SatisfiedList.jsp?ac_type=1&caf_type=cs_resultsatis&beginTime=<%=begintime%>&endTime=<%=endtime%>&mailtype=<%=mailtype%>"><strong><%=resultmy%></strong></a></td>
		<td align="center"><a href="SatisfiedList.jsp?ac_type=2&caf_type=cs_resultsatis&beginTime=<%=begintime%>&endTime=<%=endtime%>&mailtype=<%=mailtype%>"><strong><%=resultjbmy%></strong></a></td>
	    <td align="center"><a href="SatisfiedList.jsp?ac_type=3&caf_type=cs_resultsatis&beginTime=<%=begintime%>&endTime=<%=endtime%>&mailtype=<%=mailtype%>"><font color="red"><strong><%=resultbmy%></strong></font></a></td>
	</tr>
</table>
<%
}
catch(Exception ex){
	out.println(ex.toString());
}
finally{
	dImpl.closeStmt();
	dCn.closeCn(); 
}
%>



<!--    表单提交结束    -->
<%@include file="/system/app/skin/skin4/template/info_bottom.jsp"%> 
 
<%@include file="/system/app/skin/bottom.jsp"%>
                    
