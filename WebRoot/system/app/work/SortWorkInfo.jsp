<%@page contentType="text/html; charset=GBK"%>
<%@include file="/system/app/skin/head.jsp"%>
<%
String SW_ID = "";
String sql = "";
String SW_NAME = "";
String SW_SEQUENCE = "";
String actiontype="add";
        
CDataCn dCn = null;
CDataImpl dImpl = null;
try{
dCn = new CDataCn();
dImpl = new CDataImpl(dCn);

String strTitle="新增分类办事";
SW_ID=CTools.dealString(request.getParameter("SW_ID"));
if(!SW_ID.equals(""))
{
  sql = "select * from tb_sortwork where sw_id = '" + SW_ID + "'";
  Hashtable content = dImpl.getDataInfo(sql);
 	if (content!=null)
  {
   SW_NAME=content.get("sw_name").toString();
   SW_SEQUENCE=content.get("sw_sequence").toString();
   actiontype="modify";
   strTitle="修改分类办事";
  }
 }
%>
<%@include file="/system/app/skin/skin4/template/info_top.jsp"%>
<!--    模块名称开始    -->
<%=strTitle %> 
<!--    模块名称结束    -->
<%@include file="/system/app/skin/skin4/template/info_funtion.jsp"%>
<!--    功能按钮开始    -->

<!--    功能按钮结束    -->
<%@include file="/system/app/skin/skin4/template/info_main.jsp"%>
<!--    表单提交开始    -->
<table WIDTH="100%" CELLPADDING="0" BORDER="0" >
<form action="SortWorkResult.jsp" method="post" name="formData">
      <tr class="line-even" >
        <td  colspan=2>请填写分类事项资料：（注意带有<font color=red>*</font>的项目必须填写）</td>
                  </tr>
      <tr class="line-odd">
        <td align="right">事项名称</td><td align="left"><input type="text" name="SW_NAME" value="<%=SW_NAME%>" maxlength="200" class="text-line"></td>
      </tr>
      <tr class="line-odd">
        <td align="right">事项序号</td><td align="left"><input type="text" name="SW_SEQUENCE" value="<%=SW_SEQUENCE%>" maxlength="10" class="text-line"></td>
      </tr>
      <tr class=outset-table>
    <td align=center colspan=2>
	    <input type=button onClick="doAction()" name=b1 value="提交" class="bttn" >&nbsp;
		<input type=reset name=b1 value="重填" class="bttn">&nbsp;
		<input value="返回" class="bttn" onclick="javascript:history.go(-1);" type="button" size="6">&nbsp;
  </td>
 </tr>
<input type=hidden name=actiontype value=<%=actiontype%>>
<input type=hidden name=SW_ID value=<%=SW_ID%>>
</form>
</table>
<script language="javascript">
	  function doAction() {
	  		if (formData.SW_NAME.value == "" || chkKong(formData.SW_NAME.value) == false) {
	  			alert("请输入事项名称！");
	  			formData.SW_NAME.focus();
	  			return false;
	  		}
	  		if (formData.SW_SEQUENCE.value == "" || chkKong(formData.SW_SEQUENCE.value) == false) {
	  			alert("请输入事项序号！");
	  			formData.SW_SEQUENCE.focus();
	  			return false;
	  		}
	  		if (isNaN(formData.SW_SEQUENCE.value)) {
	  			alert("事项序号只能写数字！");
				formData.SW_SEQUENCE.focus();
				return false;
	  		}
	  		formData.submit();
	  }
	  
	//判定是否以空作为组成内容,是返回fasle,否则返回true
	function chkKong(obj) {
		if (obj.length == 0) return false;
		var bool = 0;
		for (var i = 0;i < obj.length;i++) {
			if (obj.substring(i,i+1) == " ") {
				bool = 1;
			}
			else {
				bool = 0;
				return true;
				break;
			}
		}
		if (bool == 1) {
			//alert("不能以空作为内容！");
			return false;
		}
	}
</script>
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
                                     
