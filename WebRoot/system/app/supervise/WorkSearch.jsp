<%@page contentType="text/html; charset=GBK"%>
<%@include file="/system/app/skin/head.jsp"%>

<%@include file="/system/app/skin/skin4/template/info_top.jsp"%>
<!--    模块名称开始    -->
项目监控查询
<!--    模块名称结束    -->
<%@include file="/system/app/skin/skin4/template/info_funtion.jsp"%>
<!--    功能按钮开始    -->
项目监控查询
<!--    功能按钮结束    -->
<%@include file="/system/app/skin/skin4/template/info_main.jsp"%>
<!--    表单提交开始    -->
<script language="javascript">
function merger()
{
	var obj1 = formData.status;
	var obj2 = formData.status1;
	var str = "";
	for (var i=0;i<obj1.length;i++)
	{
		if (obj1[i].checked)
		{
			str += obj1[i].value;
			str += ",";
		}
	}
	if (str.length>0)
	{
		str = str.substring(0,str.length-1);
	}
	obj2.value = str;
}
</script>
<table  align="center" width="100%" CELLPADDING="1" cellspacing="1">
	<form name="formData" action="WorkSearchResult.jsp" method="post" onsubmit="merger()">
	<tr class="line-odd">
		<td align="right">
			项目名称：
		</td>
		<td align="left">
			<input type="text" name="work" size="50" class="text-line"
				maxlength="150">
		</td>
	</tr>
	<tr class="line-even" width="100%">
		<td width="20%" align="right">
			受理单位：
		</td>
		<td align="left">
			<%
			CDataCn dCn = null;
			try{
				dCn = new CDataCn();
			CDeptList dList=new CDeptList(dCn);
			dList.setOnchange(false);
			String  seldept=dList.getListByParentID(dList.LISTID,0,"0","dt_name");
			out.print(seldept);
			dCn.closeCn();
			} catch (Exception ex) {
			System.out.println(new java.util.Date() + "--"
			+ request.getServletPath() + " : " + ex.getMessage());
		} finally {
		if(dCn != null)
		dCn.closeCn();
}
			%>
		</td>
	</tr>

	<tr class="line-odd">
		<td width="15%" align="right">
			申请时间：
		</td>
		<td align="left">
			<input name="beginTime" style="cursor:hand" class="text-line"
				readonly size="10" onclick="showCal()">
			&nbsp;至&nbsp;
			<input style="cursor:hand" name="endTime" class="text-line" readonly
				size="10" onclick="showCal()">
		</td>
	</tr>
	<tr class="line-even">
		<td align="right">
			事项申请人：
		</td>
		<td align="left">
			<input type="text" name="applet_people" size="50" class="text-line"
				maxlength="50">
		</td>
	</tr>
<input type="hidden" name="code" size="50" class="text-line"
				maxlength="50">
	<!--tr class="line-odd">
		<td align="right">
			办理人：
		</td>
		<td align="left">
			<input type="text" name="code" size="50" class="text-line"
				maxlength="50">
		</td>
	</tr-->

	<tr class="line-odd">
		<td width="15%" align="right">
			项目状态：
		</td>
		<td align="left">
			<input type="checkbox" name="status" class="checkbox1" value="1"
				checked>
			进行中
			<input type="checkbox" name="status" class="checkbox1" value="3"
				checked>
			已通过
			<input type="checkbox" name="status" class="checkbox1" value="4"
				checked>
			未通过
			<input type="checkbox" name="status" class="checkbox1" value="8"
				checked>
			协调中
			<input type="checkbox" name="status" class="checkbox1" value="2"
				checked>
			待补件
		</td>
	</tr>
	<tr class="title1" align="center">
		<td colspan="2" class="outset-table">
			<input type="submit" class="bttn" value="查 询">
			&nbsp;
			<input type="reset" class="bttn" value="重 写">
			&nbsp;
			<input type="button" class="bttn" name="back" value="返 回"
				onclick="history.back();">
			<input type="hidden" name="status1" value="">
		</td>
	</tr>
	</form>
</table>
<!--    表单提交结束    -->
<%@include file="/system/app/skin/skin4/template/info_bottom.jsp"%> 

<%@include file="/system/app/skin/bottom.jsp"%>
                                     
