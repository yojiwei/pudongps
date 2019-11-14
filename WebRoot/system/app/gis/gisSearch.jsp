<%@page contentType="text/html; charset=GBK"%>
<%@include file="/system/app/skin/head.jsp"%>
<script LANGUAGE="javascript" src="./common/common.js"></script>
<script type="text/javascript" src="/system/app/infopublish/editor/fckeditor.js"></script>
<script language="javascript">
	function doChk() {
		var form1 = document.formData;
		if (form1.BigSort.value == "" && form1.SmallSort.value == "" 
			  && form1.gsName.value == "" && form1.gsAddr.value == "") {
			alert("请至少填写一项查询条件！");
			form1.BigSort.focus();
			return false;
		}
		form1.submit();
	}
</script>
<%@include file="/system/app/skin/skin4/template/info_top.jsp"%>
<!--    模块名称开始    -->
GIS管理
<!--    模块名称结束    -->
<%@include file="/system/app/skin/skin4/template/info_funtion.jsp"%>
<!--    功能按钮开始    -->
GIS查询
<!--    功能按钮结束    -->
<%@include file="/system/app/skin/skin4/template/info_main.jsp"%>
<!--    表单提交开始    -->
<div align="center">
<form action="gisList.jsp" method="post" name="formData">
<table class="main-table" width="100%">
	<tr class="title1" align=center>
      	<td>
    	  <table WIDTH="100%" BORDER="0" CELLSPACING="1" CELLPADDING="1" class="outset-table">
           <tr>
            	<td align="left" WIDTH="40%"></td>
                <td align="center" colspan=2 WIDTH="20%"><b>GIS查询</b></td>      
                <td align="right" WIDTH="40%" nowrap>
					<img src="../../images/split.gif" align="middle" border="0" WIDTH="5" HEIGHT="8">
					<img src="../../images/new.gif" border="0" onclick="javascript:location.href='gisAdd.jsp'" title="新增" style="cursor:hand" align="absmiddle">
                    <img src="../../images/split.gif" align="middle" border="0" WIDTH="5" HEIGHT="8">
                    <img src="../../images/goback.gif" border="0" onclick="javascript:history.back();" title="返回" style="cursor:hand" align="absmiddle">
                    <img src="../..images/split.gif" align="middle" border="0" WIDTH="5" HEIGHT="8">
                </td>
            </tr>
           </table>
    	</td>
    </tr>
    <tr>
	 	<td width="100%">
	 	   <table width="100%" class="content-table" height="1">
			 <tr class="line-even" >
				<td width="19%" align="right">分类选择：</td>
				<td width="81%" align="left">大类：
				  <%=CTools.setSortCommon("formData","","","GIS分类")%>
	            </td>
			 </tr>
			 <tr class="line-even" >
	            <td width="19%" align="right">名称：</td>
	            <td width="81%" align="left"><input type="text" name="gsName"  class="text-line" size="30" value="" maxlength="50"/>
	            </td>
	          </tr>	
	          <tr class="line-even" >
	            <td width="19%" align="right">地址：</td>
	            <td width="81%" align="left"><input type="text" name="gsAddr" class="text-line"  size="60" value="" maxlength="50"/>
	            </td>
	          </tr>
		   </table>
		</td>
	</tr>	
    </tr>
	<tr class=outset-table>
	  <td width="100%" align="center" colspan="2">
        <input class="bttn" value="查询" type="button" onclick="doChk()" size="6" id="button2" name="button2">&nbsp;
		<input class="bttn" value="返回" type="button"  size="6" id="button3" name="button3" onclick="javascript:history.go(-1)">
    </td>
	</tr>
</table>
</form>
</div>
<!--    表单提交结束    -->
<%@include file="/system/app/skin/skin4/template/info_bottom.jsp"%> 

<%@include file="/system/app/skin/bottom.jsp"%>