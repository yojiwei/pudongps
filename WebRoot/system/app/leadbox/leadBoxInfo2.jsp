<%@page contentType="text/html; charset=GBK"%>
<%@include file="/system/app/skin/head.jsp"%>
<%@include file="/system/common/parameter.jsp"%>
<%
CDataCn dCn=null;   //新建数据库连接对象
CDataImpl dImpl=null;  //新建数据接口对象
String imp_status = "";
String ti_name = "";
String ti_sequence = "";
String ti_id = "";
String ti_upperid = "";
try {
 dCn = new CDataCn(); 
 dImpl = new CDataImpl(dCn); 

 ti_id = CTools.dealString(request.getParameter("ti_id")).trim();//编号

%>
<%@include file="/system/app/skin/skin4/template/info_top.jsp"%>
<!--    模块名称开始    -->
信息发布
<!--    模块名称结束    -->
<%@include file="/system/app/skin/skin4/template/info_funtion.jsp"%>
<!--    功能按钮开始    -->

<!--    功能按钮结束    -->
<%@include file="/system/app/skin/skin4/template/info_main.jsp"%>
<!--    表单提交开始    -->
<script LANGUAGE="javascript">
function checkform(rd)
{
	var form = document.formData ;
    if(form.jz_name.value =="")
	{
		alert("请填写街道镇名称!");
		form.jz_name.focus();
		return false;
	}
	form.submit();
}
</script>
 <table class="main-table" width="100%">
<form name="formData" method="post" action="leadBoxResult2.jsp">
 <tr class="title1" align=center>
      <td>街道镇维护</td>
    </tr>
 <tr>
     <td width="100%">
		<table width="100%" class="content-table" height="1">
		<%
		if(!ti_id.equals("")){
		String sql_dtid = "select ti_id,ti_name,ti_sequence,imp_status from tb_title where ti_upperid = (select ti_id from tb_title where ti_code = 'pudong_jz') and ti_id = "+ti_id;
		Hashtable content_dtid = dImpl.getDataInfo(sql_dtid);
		if(content_dtid!=null){
			ti_id = CTools.dealNull(content_dtid.get("ti_id"));
			ti_name = CTools.dealNull(content_dtid.get("ti_name"));
			ti_sequence = CTools.dealNull(content_dtid.get("ti_sequence"));
			imp_status = CTools.dealNull(content_dtid.get("imp_status"));
		}
		}
		//
		String sql_upperid = "select ti_id from tb_title where ti_code = 'pudong_jz'";
		Hashtable content_ = dImpl.getDataInfo(sql_upperid);
		if(content_!=null){
			ti_upperid = CTools.dealNull(content_.get("ti_id"));
		}
		%>
		<input type="hidden" name="ti_id" value="<%=ti_id%>">
		<input type="hidden" name="ti_upperid" value="<%=ti_upperid%>">
		<%if("".equals(ti_id)){%>
		<input type="hidden" name="OPType" value="Add">
		<%}else{%>
		<input type="hidden" name="OPType" value="Edit">
		<%}%>
			<tr class="line-even" >
					<td width="19%" align="right">街道镇名称：</td>
					<td width="81%" align="left"><input type="text" class="text-line" size="45" name="jz_name" maxlength="150"  value="<%=ti_name%>" >
					</td>
			</tr>				
			<tr class="line-even">
				<td width="19%"  align="right">排序字段：</td>
				<td width="81%" align="left">
					<input name="ti_sequence" size="4" value="<%=ti_sequence%>" class="text-line">
				</td>
			</tr>
			<tr class="line-even">
				<td width="19%"  align="right">前台不显示：</td>
				<td width="81%" align="left"><input type="checkbox" name="imp_status" value="1" <%="1".equals(imp_status)?"checked":""%>/>(前台不显示)</td>
			</tr>
		</table>
     </td>
   </tr>
   <tr class="outset-table" align="center" id="btnObj" style="display:">
    <td colspan="2">
		<input type="button" class="bttn" name="fsubmit" value="保存并返回列表" onclick="javascript:checkform(0)">&nbsp;
		<input type="reset" class="bttn" name="reset" value="重 写" onclick="fnReset()">&nbsp;
		<input type="button" class="bttn" name="back" value="返 回" onclick="history.back();">
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
                                     
