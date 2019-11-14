<%@page contentType="text/html; charset=GBK"%>
<%@include file="/system/app/skin/head.jsp"%>

<%@include file="/system/app/skin/skin4/template/info_top.jsp"%>
<!--    模块名称开始    -->
查询
<!--    模块名称结束    -->
<%@include file="/system/app/skin/skin4/template/info_funtion.jsp"%>
<!--    功能按钮开始    -->

<!--    功能按钮结束    -->
<%@include file="/system/app/skin/skin4/template/info_main.jsp"%>
<!--    表单提交开始    -->
<script language="javascript">
	function doSearch() {
		if (formData.et_name.value == "" && formData.et_address.value == "" 
				&& formData.et_corporation.value =="" && formData.et_kind.value == "") {
			alert("请填写至少一项查询条件！");
			formData.et_name.focus();
			return false;
		}
		formData.submit();
	}
</script>
<table width="100%" class="main_table">
<tr>
<td>
<form action="EnterpriseList.jsp" method="post" name="formData">
    <tr>
     <td width="100%">
	<table border="0" width="100%" cellpadding="0" cellspacing="0" class="content-table">
      	<tr>
        	<td width="100%" align="left" valign="top">
	  		<table border="0" width="100%" cellspacing="1" cellpadding="0">
	  	  		 <tr class="line-even">
			  	    	<td width="15%" align="right">类型：</td>
                                        <td width="85%">
										<select name="et_kind" class="select-a">
										<option value="">--请选择类型--</option>
										<option value="0">工商企业</option>
										<option value="1">食品卫生许可</option>
										</select>
	  	  		</tr>
                <tr class="line-odd">
        			<td width="15%" align="right">企业名称：</td>
			        <td width="85%"><input type="text" class="text-line" size="20" name="et_name" maxlength="150"></td>
                                </tr>
								<tr class="line-even" >
           				 <td width="19%" align="right">企业地址：</td>
            				 <td width="81%" ><input type="text" class="text-line" size="20" name="et_address" maxlength="150" ></td>
          		</tr>
		  		<tr class="line-odd">
	  	    		<td width="15%" align="right">法人代表：</td>
	  	    		<td width="85%"><input name="et_corporation" size="20" class="text-line" maxlength="30">
					</td>
                </tr>
	  		</table>
        	</td>
      	</tr>
      	<tr colspan="2" class="outset-table">
        <td width="100%" align="center">
          <input class="bttn" value="查询" type="button" onclick="doSearch();" size="6" name="btnSubmit">&nbsp;
          <input class="bttn" value="返回" type="button" onclick="history.back();" size="6" >&nbsp;
        </td>
      </tr>
    </table>
    </td>
  </tr>
</form>
</td>
</tr>
</table>
<!--    表单提交结束    -->
<%@include file="/system/app/skin/skin4/template/info_bottom.jsp"%> 

<%@include file="/system/app/skin/bottom.jsp"%>
                                     
