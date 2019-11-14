<%@page contentType="text/html; charset=GBK"%>
<%@include file="/system/app/skin/head.jsp"%>
<script language="javascript" src="/system/include/common.js"></script>
<script language="javascript" src="/system/include/changeletter.js"></script>
<style>
.topic
{
	color:#333399;
	font-weight:bold;
}

.title_on
{
	border-left:1px solid #A2A2A2;
	border-right:1px solid #A2A2A2;
	border-top:4px solid #A2A2A2;
	font-weight:bold;
	/*cursor:hand;*/
	height:26px;
	width:90px;
}
.title_down
{
	border-left:1px solid #A2A2A2;
	border-right:1px solid #A2A2A2;
	border-top:3px solid #C8C8C8;
	border-bottom:1px solid #A2A2A2;
	background-color:#A2A2A2;
	font-weight:bold;
	cursor:hand;
	color:#FFFFFF;
	height:22px;
	width:90px;
}

.title_mi
{
	border-bottom:1px solid #A2A2A2;
	background-color:white;
}

.table_main
{
	border-left:1px solid #A2A2A2;
	border-right:1px solid #A2A2A2;
	border-bottom:1px solid #A2A2A2;
}
tr
{
	height:23;
}
.mytr
{
	height:18;
}
.removableObj
{
	height:25;
	position:relative;
	border:1px solid #FFFFFF;
	cursor:move;
}
.disremovableObj
{
	height:25;
	position:relative;
	border:1px solid #99CCFF;
	cursor:move;
}
.addObj
{
	height:25;
	position:relative;
	border:1px solid #FFFFFF;
	border-bottom:2px dashed #CC3366;
	cursor:move;
}
.bstitle
{
	font-weight:bold;
	color:#000000;
	height:30px;
	padding-left:20px;
	font-size:12pt;
}
</style>
<%@include file="/system/app/skin/skin4/template/info_top.jsp"%>
<!--    模块名称开始    -->
信箱统计
<!--    模块名称结束    -->
<%//@include file="/system/app/skin/skin4/template/info_funtion.jsp"%>
</p>
                  </td>
              </tr>
          </table>
      </td>
      <td width="42%" align="right" valign="middle">
          &nbsp;</td>
  </tr>
</table>
</td>
</tr>
</table>
<table width="590" border="0" cellspacing="0" cellpadding="0">
<tr>
<td align="left" valign="top" height="2">
</td>
</tr>
</table>
<table width="590" border="0" cellspacing="0" cellpadding="0">
<tr>
<td align="left" valign="top">
</td>
</tr>
</table>
<div class="rolls">
<table width="97%" border="0" align="center" cellpadding="0" cellspacing="0">
<tr>
<td height="67" align="left" valign="top">
  <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" class="TableQuery">
      <tr>
          <td align="center" valign="top">
<!--    功能按钮开始    -->
<!--    功能按钮结束    -->
<%//@include file="/system/app/skin/skin4/template/info_main.jsp"%>
<!--    表单提交开始    -->
<div id="nocount"></div>
<table class="main-table" width="100%" CELLPADDING="0" cellspacing="0">
<form name="formData" enctype="multipart/form-data" method="post">
<tr >
	<td>
		<table width="100%" cellspacing="0" cellpadding="0">
			<tr>
				<!--区长信箱-->
				<td valign="bottom" width="90">
					<table cellspacing="0" cellpadding="0">
						<tr>
					<td id="qzxx_bt" class="title_down" align="center" onClick="javascript:ChangeC('qzxx');">区长信箱</td>
						</tr>
					</table>
				</td>
				<td width="2" class="title_mi">　</td>
				<!--区长信箱-->
				<!--街镇领导信箱-->
				<td valign="bottom" width="90">
					<table cellspacing="0" cellpadding="0">
						<tr>
					<td id="jzldxx_bt" class="title_down" align="center" onClick="javascript:ChangeC('jzldxx');">街镇领导信箱</td>
							</tr>
					</table>
				</td>
				<td width="2" class="title_mi">　</td>
				<!--街镇领导信箱-->
				<!--投诉信箱-->
				<td valign="bottom" width="90">
					<table cellspacing="0" cellpadding="0">
						<tr>
						<td id="tsxx_bt" class="title_down" align="center" onClick="javascript:ChangeC('tsxx');">投诉信箱</td>
							</tr>
					</table>
				</td>
				<td width="2" class="title_mi">　</td>
				<!--投诉信箱-->
				<!--咨询信箱-->
				<td valign="bottom" width="90">
					<table cellspacing="0" cellpadding="0">
						<tr>
						<td id="zxxx_bt" class="title_down" align="center" onClick="javascript:ChangeC('zxxx');">咨询信箱</td>
							</tr>
					</table>
				</td>
				<td width="2" class="title_mi">　</td>
				<!--咨询信箱-->
				<!--互动事项查询-->
				<td valign="bottom" width="90">
					<table cellspacing="0" cellpadding="0">
						<tr>
						<td id="hdsxcx_bt" class="title_down" align="center" onClick="javascript:ChangeC('hdsxcx');">互动事项查询</td>
							</tr>
					</table>
				</td>
				<td width="2" class="title_mi">　</td>
				<!--互动事项查询-->
				<!--信箱反馈情况-->
				<td valign="bottom" width="90">
					<table cellspacing="0" cellpadding="0">
						<tr>
						<td id="xxfkqk_bt" class="title_down" align="center" onClick="javascript:ChangeC('xxfkqk');">信箱反馈情况</td>
							</tr>
					</table>
				</td>
				<td class="title_mi">&nbsp;</td>
				<!--信箱反馈情况-->
				
			</tr>
		</table>
		
		<!--区长信箱-->
		<div id="qzxx" style="display:">
		<table width="100%" class="table_main">
		<tr><td><IFRAME ID="eWebEditor1" src="http://61.129.65.86/system/app/webmonitor/WardenmailSearch.jsp" frameborder="0" scrolling="no" width="100%" height="420"></IFRAME></td></tr></table>
		</div>
		<!--街镇领导信箱--->
		<div id="jzldxx" style="display:none">
		<table width="100%" class="table_main">
		<tr><td><IFRAME ID="eWebEditor1" src="http://61.129.65.86/system/app/stat/Statconnection.jsp?cp=5" frameborder="0" scrolling="yes" width="100%" height="600"></IFRAME></td></tr></table>
		</div>
		<!--投诉信箱--->
		<div id="tsxx" style="display:none">
		<table width="100%" class="table_main"><tr><td>
		<IFRAME ID="eWebEditor1" src="http://61.129.65.86/system/app/stat/Statconnection.jsp?cp=3" frameborder="0" scrolling="no" width="100%" height="400"></IFRAME>
		</td></tr></table>
		</div>
		<!--咨询信箱-->
		<div id="zxxx" style="display:none">
		<table width="100%" class="table_main"><tr><td>
		<IFRAME ID="eWebEditor1" src="http://61.129.65.86/system/app/stat/Statconnection.jsp?cp=4" frameborder="0" scrolling="yes" width="100%" height="600"></IFRAME></td></tr></table>
		</div>
		<!--互动事项查询-->
		<div id="hdsxcx" style="display:none">
		<table width="100%" class="table_main"><tr><td>
		<IFRAME ID="eWebEditor1" src="http://61.129.65.86/system/app/worksearch/AppealSearch.jsp" frameborder="0" scrolling="yes" width="100%" height="600"></IFRAME></td></tr></table>
		</div>
		<!--信箱反馈情况-->
		<div id="xxfkqk" style="display:none">
		<table width="100%" class="table_main"><tr><td>
		<IFRAME ID="eWebEditor1" src="http://61.129.65.86/system/app/stat/AppealSta.jsp" frameborder="0" scrolling="no" width="100%" height="900"></IFRAME></td></tr></table>
		</div>

</td></tr>
<tr class="outset-table" width="100%">
	<td colspan="5">&nbsp;</td>
</tr>
</form>
</table>
<script type="text/javascript" for=window event=onload>
	ChangeC("qzxx");
</script>
<!--    表单提交结束    -->
<%@include file="/system/app/skin/skin4/template/info_bottom.jsp"%> 
<%@include file="/system/app/skin/bottom.jsp"%>
                                     
