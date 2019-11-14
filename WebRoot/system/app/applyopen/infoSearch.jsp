<%@page contentType="text/html; charset=GBK"%>
<%@include file="/system/app/skin/head.jsp"%>
<%
String strTitle = "申请信息查询";
/*得到当前登陆的用户id  开始*/
String uiid="";
CMySelf myProject = (CMySelf)session.getAttribute("mySelf");
  if(myProject!=null && myProject.isLogin())
  {
    uiid = Long.toString(myProject.getMyID());
  }
  else
  {
    uiid= "2";
  }
/*得到当前登陆的用户id  结束*/
%>
<%@include file="/system/app/skin/skin4/template/info_top.jsp"%>
<!--    模块名称开始    -->
<%=strTitle%>
<!--    模块名称结束    -->
<%@include file="/system/app/skin/skin4/template/info_funtion.jsp"%>
<!--    功能按钮开始    -->

<!--    功能按钮结束    -->
<%@include file="/system/app/skin/skin4/template/info_main.jsp"%>
<!--    表单提交开始    -->
<script language="javascript">
function checkKey() {
	var iKeyCode = window.event.keyCode;
	if(iKeyCode == 13) { //回车
		fnsearch();
	}
}

function fnsearch(){
	var sear = formData.search.value;
	window.open("infoSearchList.jsp?search=" + sear,"依申请公开搜索","Top=0px,Left=0px,width=600,height=600,scrollbars=yes");
}
</script>

<table CELLPADDING="0" cellspacing="0" BORDER="0" width="100%" >
<form name="formData" method="post" action="">
  <tr>
    <td width="100%">
      <table width="100%" class="content-table" height="1">
        <tr class="line-even" >
          <td width="29%" align="right">请输入事项关键字：</td>
          <td width="71%" align="left"><input name="search" type="text" class="text-line" size="50" onkeydown="checkKey()">
          </td>
        </tr>        
      </table>
    </td>
  </tr>
	<tr>
	 	<td align="center">
	 		<font color="#FF0000">*注：若查询后没有出现弹出窗口请确认您的浏览器没有设置拦截并且您的任务栏中没有打开搜索窗口！</font>
	 	</td>
	</tr>
  <tr class="outset-table" align="center">
		<td>
			<input type="button" class="bttn" name="fsubmit" value="查 询" onclick="fnsearch();">&nbsp;
			<input type="reset" class="bttn" name="freset" value="重 写">&nbsp;
			<input type="button" class="bttn" name="back" value="直接填写申请信息" onclick="javascript:window.location.href='applyInfo.jsp';">
		</td>
	</tr>
</form>
</table>
<!--    表单提交结束    -->
<%@include file="/system/app/skin/skin4/template/info_bottom.jsp"%> 
<%@include file="/system/app/skin/bottom.jsp"%>
                                     
