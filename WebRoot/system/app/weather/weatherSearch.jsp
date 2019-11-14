<%@page contentType="text/html; charset=GBK"%>
<%@include file="/system/app/skin/head.jsp"%>
<%
String strTitle = "天气预报查询";
%>
<script language=javascript>
  function showCal(obj)
  {
      if (!obj) var obj = event.srcElement;
      var obDate;
      if ( obj.value == "" ) {
          obDate = new Date();
      } else {
          var obList = obj.value.split( "-" );
          obDate = new Date( obList[0], obList[1]-1, obList[2] );
      }

      var retVal = showModalDialog( "../../common/include/calendar.htm", obDate,
          "dialogWidth=206px; dialogHeight=206px; help=no; scroll=no; status=no; " );

      if ( typeof(retVal) != "undefined" ) {
          var year = retVal.getFullYear();
          var month = retVal.getMonth()+1;
          var day = retVal.getDate();
          obj.value =year + "-" + month + "-" + day;
      }
}
	function doAction(){
		if (formData.start_date.value == "") {
			alert("请输入开始时间！");
			formData.start_date.focus();
			return false;
		}
		if (formData.end_date.value == "") {
			alert("请输入结束时间！");
			formData.end_date.focus();
			return false;
		}
		var start_date = formData.start_date.value;
		var end_date = formData.end_date.value;
		
		
		if (dateDiff(start_date,end_date) == false) {
			alert("开始时间不能小于结束时间！");
			return false;
		}
		formData.action = "weatherList.jsp";
		formData.submit();
	}
	
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
		if (startMon > endMon)
			return false;
		if (startDay > endDay)
			return false;
		return true;
	}
	
</script>
<%@include file="/system/app/skin/skin4/template/info_top.jsp"%>
<!--    模块名称开始    -->
<%=strTitle%>
<!--    模块名称结束    -->
<%@include file="/system/app/skin/skin4/template/info_funtion.jsp"%>
<!--    功能按钮开始    -->
<%=strTitle%>
<!--    功能按钮结束    -->
<%@include file="/system/app/skin/skin4/template/info_main.jsp"%>
<!--    表单提交开始    -->
<table class="main-table" width="100%">
<form name="formData" method="post" target="">
          <tr class="line-even">
            <td  align="right"> 发布日期： </td>
            <td>
            <table width="100%" border="0" cells>
            	<tr>
	            <td  align="left"> 开始日期：</td>
	            <td><input type="date" size=13 name="start_date" onclick="javascript:showCal()" class=text-line style="cursor:hand" readonly >
	              &nbsp;-&nbsp;</td>
	            <td>结束日期：</td>
	            <td><input type="date" size=13 name="end_date" onclick="javascript:showCal()" class=text-line style="cursor:hand" readonly >
	             </td>
	             </tr>
	         </table>
     </td>
   </tr>
   <tr class="outset-table" align="center">
       <td colspan="2">
<input type="button" class="bttn" name="fsubmit" value="查 询" onClick="doAction();">&nbsp;
<input type="reset" class="bttn" name="freset" value="重 写">&nbsp;
<input type="button" class="bttn" name="back" value="返 回" onclick="history.back();">
 </td>
   </tr>

</form>
</table>
<!--    表单提交结束    -->
<%@include file="/system/app/skin/skin4/template/info_bottom.jsp"%> 

<%@include file="/system/app/skin/bottom.jsp"%>
                                     
