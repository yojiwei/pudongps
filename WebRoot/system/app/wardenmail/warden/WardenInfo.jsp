<%@page contentType="text/html; charset=GBK"%>
<%@include file="/system/app/skin/head.jsp"%>
<%
String wd_id = "";
String sql = "";
String sql_judge = "";
String sqlStr = "";
String sqlCorr = "";
String wd_name = "";
String actiontype="add";
String wd_sequence = "";
Vector vPage = null;

CDataCn dCn = null;
CDataImpl dImpl = null;
try{
dCn = new CDataCn();
dImpl = new CDataImpl(dCn);

String strTitle="新增区长";
	wd_id=CTools.dealString(request.getParameter("wd_id"));
	if(!wd_id.equals(""))
	{
		sql = "select wd_id,wd_name,wd_sequence from tb_warden where wd_id = '" + wd_id + "'";
		   Hashtable content = dImpl.getDataInfo(sql);
		   if (content!=null)
		   {
			 wd_id = content.get("wd_id").toString();
			 wd_name = content.get("wd_name").toString();
			 wd_sequence = content.get("wd_sequence").toString();
			 actiontype = "modify";
			 strTitle = "编辑区长";
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
<form action="WardenInfoResult.jsp" method="post" name="formData">
      <tr class="line-even">
        <td align="right">区长姓名：</td><td align="left"><input type="text" name="wd_name" value="<%=wd_name%>" class="text-line"> <font color=red>*</font></td>
      </tr>
      <tr class="line-even">
        <td align="right">排&nbsp;&nbsp;序：</td><td align="left"><input type="text" name="wd_sequence" value="<%=wd_sequence%>" class="text-line" onKeyDown="numOnly(value)" maxlength="13"> <font color=red>*</font></td>
      </tr>
      <tr class=outset-table>
    <td align=center colspan=2>
    <input type=button name=b1 value="提交" class="bttn" onClick="doAction()">&nbsp;
    <%if(!wd_id.equals("")) {%>
    	<input value="删除" class="bttn" onclick="javascript:del()" type="button" size="6">&nbsp;
    <%}%>
    <input type=reset name=b1 value="重填" class="bttn">&nbsp;
    <input value="返回" class="bttn" onclick="javascript:history.go(-1);" type="button" size="6">
  </td>
 </tr>

<input type=hidden name=actiontype value=<%=actiontype%>>
<input type=hidden name=wd_id value=<%=wd_id%>>
</form>
</table>
<script language="javascript">
	
	function numOnly(value) {
   		if (((event.keyCode >= 48) & (event.keyCode <= 57))|((event.keyCode <= 105) &
   			  (event.keyCode >= 96)) | (event.keyCode == 8) | (event.keyCode == 37) | (event.keyCode == 39) 
   				 | (event.keyCode == 46) | (event.keyCode == 9)) 
   		{	}
   		else {
       		event.returnValue=false;
   		}
   	}
	
  function doAction() {
  	if (formData.wd_name.value == "") {
  		alert("区长姓名不能为空！");
  		formData.wd_name.focus();
  		return false;
  	}
  	if (formData.wd_sequence.value == "") {
  		alert("排序不能为空！");
  		formData.wd_sequence.focus();
  		return false;
  	}
  	formData.submit();
  }
  
  function  del()
  {
    if(window.confirm('确认要删除该记录么?'))
   {
    window.location="WardenDel.jsp?wd_id=<%=wd_id%>";
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
                                     
