<%@page contentType="text/html; charset=GBK"%>
<%@include file="/system/app/skin/head.jsp"%>

<%@include file="/system/app/skin/skin4/template/info_top.jsp"%>
<!--    模块名称开始    -->
督办单查询
<!--    模块名称结束    -->
<%@include file="/system/app/skin/skin4/template/info_funtion.jsp"%>
<!--    功能按钮开始    -->
督办单查询
<!--    功能按钮结束    -->
<%@include file="/system/app/skin/skin4/template/info_main.jsp"%>
<!--    表单提交开始    -->
<table  align="center" width="100%" CELLPADDING="1" cellspacing="1">
 <form name="formData" action="SupervisalSign.jsp" method="post">
 <tr class="line-even">
    <td  align="right">督办事项:
    </td>
    <td align="left"><input type="text" name="pjcode" size="50" class = "text-line">
    </td>
    </tr>
    <tr class="line-even">
    <td align="right">督办类型:</td>
             <td align="left">
 	    <select name="sv_type" class="select-a">
                <option value="4">项目督办
		</options>
		<option value="5">协调单督办
		</options>

             </td>
    </tr>
 	<tr class="line-even" width="100%">
		<td width="20%" align="right">受理单位：</td>
		<td align="left">
				<select class=select-a name="dt_name" size='1'>
<option value='' >上海市浦东新区</option>
<option value="档案局" >&nbsp;&nbsp;&nbsp;&nbsp;
档案局</option>
<option value="信访办" >&nbsp;&nbsp;&nbsp;&nbsp;信访办</option>
<option value="外事办" >&nbsp;&nbsp;&nbsp;&nbsp;外事办</option>
<option value="民防办" >&nbsp;&nbsp;&nbsp;&nbsp;民防办</option>
<option value="人事局" >&nbsp;&nbsp;&nbsp;&nbsp;人事局</option>
<option value="监察委" >&nbsp;&nbsp;&nbsp;&nbsp;监察委</option>

<option value="监察员" >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;监察员</option>
<option value="文广局" >&nbsp;&nbsp;&nbsp;&nbsp;文广局</option>
<option value="对台办" >&nbsp;&nbsp;&nbsp;&nbsp;对台办</option>
<option value="民宗办">&nbsp;&nbsp;&nbsp;&nbsp;民宗办</option>
<option value="侨办" >&nbsp;&nbsp;&nbsp;&nbsp;侨办</option>
<option value="计划局" >&nbsp;&nbsp;&nbsp;&nbsp;计划局</option>
<option value="经贸局" >&nbsp;&nbsp;&nbsp;&nbsp;经贸局</option>
<option value="科技局" >&nbsp;&nbsp;&nbsp;&nbsp;科技局</option>
<option value="劳保局" >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;劳保局</option>
<option value='29' >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;gs</option>
<option value="办领导" >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;办领导</option>
<option value="社发局">&nbsp;&nbsp;&nbsp;&nbsp;社发局</option>
<option value="农发局" >&nbsp;&nbsp;&nbsp;&nbsp;农发局</option>
<option value="建设局" >&nbsp;&nbsp;&nbsp;&nbsp;建设局</option>
<option value="环保局" >&nbsp;&nbsp;&nbsp;&nbsp;环保局</option>
<option value="财政局" >&nbsp;&nbsp;&nbsp;&nbsp;财政局</option>
<option value="审计局" >&nbsp;&nbsp;&nbsp;&nbsp;审计局</option>
<option value="工商局" >&nbsp;&nbsp;&nbsp;&nbsp;工商局</option>
<option value="税务局" >&nbsp;&nbsp;&nbsp;&nbsp;税务局</option>
<option value="公安局" >&nbsp;&nbsp;&nbsp;&nbsp;公安局</option>
<option value="司法局" >&nbsp;&nbsp;&nbsp;&nbsp;司法局</option>
<option value="工会" >&nbsp;&nbsp;&nbsp;&nbsp;工会</option>
<option value="妇联" >&nbsp;&nbsp;&nbsp;&nbsp;妇联</option>
<option value="团委" >&nbsp;&nbsp;&nbsp;&nbsp;团委</option>
<option value='质监局' >&nbsp;&nbsp;&nbsp;&nbsp;质监局</option>

<option value="药监局" >&nbsp;&nbsp;&nbsp;&nbsp;药监局</option>
<option value="投资办" >&nbsp;&nbsp;&nbsp;&nbsp;投资办</option>
<option value="外管委" >&nbsp;&nbsp;&nbsp;&nbsp;外管委</option>
<option value="张江园区办" >&nbsp;&nbsp;&nbsp;&nbsp;张江园区办</option>
<option value="金桥管委会" >&nbsp;&nbsp;&nbsp;&nbsp;金桥管委会</option>
<option value="其他">&nbsp;&nbsp;&nbsp;&nbsp;其他</option>
<option value="南区管委会">&nbsp;&nbsp;&nbsp;&nbsp;南区管委会</option>
<option value="办公室" >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;办公室</option>
<option value="社会发展处" >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;社会发展处</option>
<option value="经济贸易处" >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;经济贸易处</option>
<option value="规划建设处">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;规划建设处</option>
<option value="国资办" >&nbsp;&nbsp;&nbsp;&nbsp;国资办</option>
</select>
</td>
</tr>

	<tr class="line-odd">
		<td width="15%" align="right">申请时间</td>
		<td align="left"><input name="beginTime" style="cursor:hand" class="text-line" readonly size="10" onclick="showCal()">&nbsp;至&nbsp;<input style="cursor:hand" name="endTime" class="text-line" readonly size="10" onclick="showCal()"></td>
	</tr>


  <tr class="title1" align="center">
	 <td colspan="2" class="outset-table">
	<input type="submit" class="bttn" value="查 询" >&nbsp;
	<input type="reset" class="bttn"  value="重 写">&nbsp;
  <input type="button" class="bttn" name="back" value="返 回" onclick="history.back();">
	</tr>

</form>
</table>
<!--    表单提交结束    -->
<%@include file="/system/app/skin/skin4/template/info_bottom.jsp"%> 

<%@include file="/system/app/skin/bottom.jsp"%>
                                     
