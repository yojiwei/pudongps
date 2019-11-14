<%@ page contentType="text/html; charset=GBK" %>
<%@include file="/system/app/skin/head.jsp"%>
<script LANGUAGE="javascript" src="../infopublish/common/common.js"></script>
<%
String cp = CTools.dealString(request.getParameter("cp"));
%>
<table class="main-table" width="100%">
<form name="formData" method="post" action="StatWorklist.jsp">

            <tr class="title1">
                <td align="left" width="100%" colspan="2">网上办事事项汇总统计&nbsp;&nbsp;&nbsp;&nbsp;<a href="#" onclick="fnsubmit(2);">导出Excel</a></td>
            </tr>

            <tr class="line-odd">
		<td width="15%" align="right">申请时间</td>
		<td  align="left"><input name="beginTime" style="cursor:hand" class="text-line" readonly size="10" onclick="showCal()">&nbsp;至&nbsp;<input style="cursor:hand" name="endTime" class="text-line" readonly size="10" onclick="showCal()"></td>
	    </tr>
            <tr class="title1">
                <td align="right" width="100%" colspan="2">
                    <p align="center">
                    <input type="button" class="bttn" value=" 确 定 " name="fsubmit" onclick="fnsubmit(1);">
                    <input type="button" class="bttn" value=" 返 回 " name="freturn" onclick="history.go(-1);"></p>
               </td>
            </tr>
</form>
</table>

<script language="javascript">
function fnsubmit(flag)
{
	if(flag==2)
	{
		document.formData.action="StatWorklist_Excel.jsp";
	}
	else
	{
		document.formData.action="StatWorklist.jsp";
	}
	document.formData.submit();
}
</script>
<%@include file="/system/app/skin/bottom.jsp"%>