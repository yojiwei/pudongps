<%@page contentType="text/html; charset=GBK"%>
<%@include file="/system/app/skin/head.jsp"%>
<%
String workId   = ""; //办事id
String userKind = ""; //用户类别
String workName = ""; //办事名称
String sequence = ""; //排序字段
String workFlag = "1"; //该事务是否为活动
String strTitle = "新增常用办事";

CDataCn dCn = null;
CDataImpl dImpl = null;
try{
dCn = new CDataCn();
dImpl = new CDataImpl(dCn);

workId = CTools.dealString(request.getParameter("workId")).trim();
if(!workId.equals(""))
{
   String sqlStr = "select * from tb_commonwork where cw_id = '"+workId+"'";
   Hashtable content = dImpl.getDataInfo(sqlStr);
   if (content != null)
   {
   	userKind = content.get("uk_id").toString();
   	workName = content.get("cw_name").toString();
   	sequence = content.get("cw_sequence").toString();
   	workFlag = content.get("cw_flag").toString();
   	strTitle = "修改常用办事";
   }
}
%>
<%@include file="/system/app/skin/skin4/template/info_top.jsp"%>
<!--    模块名称开始    -->

<!--    模块名称结束    -->
<%@include file="/system/app/skin/skin4/template/info_funtion.jsp"%>
<!--    功能按钮开始    -->

<!--    功能按钮结束    -->
<%@include file="/system/app/skin/skin4/template/info_main.jsp"%>
<!--    表单提交开始    -->
<script language="javascript">
function checkForm()
{
	var cw_name = formData.workName.value;
	var cw_sequence = formData.sequence.value;
	if(cw_name=="")
	{
		alert("请填写办事名称！");
		formData.workName.focus();
		return false;
	}
	if(cw_sequence!="")
	{
		cw_sequence = cw_sequence.replace(/\s/g, "");//去掉两端的空格
		if(isNaN(cw_sequence))
		{
			alert("请输入正确的排序数字！");
			formData.sequence.focus();
			return false;
		}
	}
	formData.action="CommonWorkResult.jsp";
	formData.method="post";
	formData.submit();
}
function doDel() {
	if (confirm("确实要删除此记录吗？")) {
		formData.action="CommonWorkDel.jsp";
		formData.submit();
	}
}
</script>
<table width="100%"  CELLPADDING="0">
<form name="formData" action="CommonWorkResult.jsp" method="post">
    
    <tr class="line-even" width="100%">
     <td align="right" width="20%">
     	用户类别：
     </td>
     <td align="left"><select class="select-a" name="userKind">
     		<%
     		String sqlStr = "select * from tb_userkind";
     		Vector vPage = dImpl.splitPage(sqlStr,request,20);
     		if (vPage != null)
     		{
     			for (int i=0;i<vPage.size();i++)
     			{
     				Hashtable content = (Hashtable)vPage.get(i);
     				%>
     				<option value="<%=content.get("uk_id").toString()%>"<%if (userKind.equals(content.get("uk_id").toString())) out.print("selected");%>><%=content.get("uk_name").toString()%></option>
     				<%
     			}
     		}
     		%>
     	</select>
     </td>
    </tr>
    <tr class="line-odd" width="100%">
    	<td align="right" width="20%">
    		办事名称：
    	</td>
    	<td align="left">
    		<input name="workName" class="text-line" value="<%=workName%>">
    	</td>
    </tr>
    <tr class="line-even" width="100%">
    	<td align="right" width="20%">
    		排序字段：
    	</td>
    	<td align="left">
    		<input name="sequence" class="text-line" value="<%=sequence%>" size="5">
    	</td>
    </tr>
    <tr class="line-even" width="100%">
    	<td align="right" width="20%">
		启用事务:
    	</td>
    	<td align="left">
    		<input type="checkbox" class="checkbox1" name="workFlag" value="1" <% if(workFlag.equals("1")) out.print("checked");%>>
    	</td>
    </tr>
    <tr class="outset-table" width="100%">
    	<td colspan="2" align="center">
    		<input type="button" class="bttn" name="btnSubmit" value="提交" onclick="checkForm()">&nbsp;
    		<input type="reset" class="bttn" name="btnReset" value="重填">&nbsp;
    		<input type="button" class="bttn" name="btnDel" value="删除" onClick="doDel()">&nbsp;
    		<input type="button" class="bttn" name="btnBack" value="返回" onclick="window.history.go(-1);">&nbsp;
    	</td>
    </tr>
    <input type="hidden" name="workId" value="<%=workId%>">
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
                                     
