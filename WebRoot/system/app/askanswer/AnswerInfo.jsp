<%@page contentType="text/html; charset=GBK"%>
<%@include file="/system/app/skin/head.jsp"%>
<%
String optype="";
String pa_id="";
String stroptype="";
optype = CTools.dealString(request.getParameter("OPType")).trim();
pa_id = CTools.dealString(request.getParameter("pa_id")).trim();
String dt_id="";
String pc_timelimit="";
String dt_name="";
String isChecked = "checked";
String pa_ask="",pa_answer="";
String ac_type = "";
String ac_date = "";
String ac_ispublic = "";

if(optype.equals("Edit"))
{
	stroptype="修改问答信息";
}
else 
{
	stroptype="新增问答信息";
}
String sqlInfo = "";
Hashtable contInfo = null;
//
CDataCn dCn = null;
CDataImpl dImpl = null;
try{
dCn = new CDataCn();
dImpl = new CDataImpl(dCn);
//
if(optype.equals("Edit"))
{
	sqlInfo = " select pa_id,pa_ask,pa_answer,ac_type,ac_date,ac_ispublic from tb_proceeding_ask where  pa_id='"+pa_id+"'";
	contInfo = dImpl.getDataInfo(sqlInfo);
	ac_type = CTools.dealNull(contInfo.get("ac_type"));
	ac_ispublic = CTools.dealNull(contInfo.get("ac_ispublic"));
	ac_date= CTools.dealNull(contInfo.get("ac_date"));
	pa_ask = CTools.dealNull(contInfo.get("pa_ask"));
	pa_answer = CTools.dealNull(contInfo.get("pa_answer"));
}
%>
<%@include file="/system/app/skin/skin4/template/info_top.jsp"%>
<!--    模块名称开始    -->
问答信息
<!--    模块名称结束    -->
<%@include file="/system/app/skin/skin4/template/info_funtion.jsp"%>
<!--    功能按钮开始    -->
<%=stroptype%>
<!--    功能按钮结束    -->
<%@include file="/system/app/skin/skin4/template/info_main.jsp"%>
<!--    表单提交开始    -->
<table align="center" width="100%" CELLPADDING="1" cellspacing="1">
<tr>
<td>
<form method="post" name="formData" action="AnswerInfoResult.jsp">
	<table border="0" width="100%" cellpadding="0" cellspacing="0" class="content-table">
      	<tr>
        	<td width="100%" align="left" valign="top">
	  		<table border="0" width="100%" cellspacing="1" cellpadding="0">
				<tr class="line-even" >
           				 <td width="14%" align="right">选择类型：</td>
            				 <td width="86%">
<select name="ac_type">
<option value="">请选择类型</option>
<option value="a1" <%=ac_type.equals("a1")?"selected":""%>>拍卖</option>
<option value="a2" <%=ac_type.equals("a2")?"selected":""%>>网络</option>
<option value="a3" <%=ac_type.equals("a3")?"selected":""%>>市场</option>
<option value="a4" <%=ac_type.equals("a4")?"selected":""%>>广告</option>
</select>
							</td>
          		</tr>
				<tr class="line-odd" >
           			<td width="14%" align="right">是否前台发布：</td>
            		<td width="86%"><input type="checkbox" name="ac_ispublic" value="1" <%=ac_ispublic.equals("1")?"checked":""%>/>是</td>
          		</tr>
	  	 		 <tr class="line-even" >
           			<td width="14%" align="right">问题：</td>
            		<td width="86%" ><textarea name="pa_ask"  style="display:;WIDTH: 100%; HEIGHT: 100px" maxlength="200"><%=pa_ask%></textarea></td>
          		</tr>
                 <tr class="line-even" >
           				 <td align="right">答案：</td>
            				 <td><textarea name="pa_answer"  style="display:;WIDTH: 100%; HEIGHT: 100px" maxlength="200"><%=pa_answer%></textarea></td>
          		</tr>
			</table>
        	</td>
      	</tr>
      	<tr colspan="2" class="title1">
        <td width="100%" align="center">
          <input class="bttn" value="提交" type="button" size="6" name="btnSubmit" onclick="check();">&nbsp;
		  <%if(optype.equals("Edit")){%>
		  <input class="bttn" value="删除" type="button" size="6" name="btnSubmit" onclick="del();">&nbsp;
		  <%}%>
          <input class="bttn" value="返回" type="button" onclick="history.back();" size="6" >
		  <INPUT TYPE="hidden" name="OPType" value="<%=optype%>">
          <INPUT TYPE="hidden" name="pa_id" value="<%=pa_id%>">
        </td>
      </tr>
    </table>
</form>
</td>
</tr>
</table>
<script>
function check()
{
	if(formData.ac_type.value == "")
	{
		alert("请选择类型!");
		formData.ac_type.focus();
		return false;
	}
	if(formData.pa_ask.value == "")
	{
		alert("请填写问题!");
		formData.pa_ask.focus();
		return false;
	}else{
		if(formData.pa_ask.value.length>200){
			alert("您输入的问题信息请不要超过200个字!");
			formData.pa_ask.focus();
			return false;
		}
	}
	
	if(formData.pa_answer.value=="")
	{
		alert("请输入问题答案!");
		formData.pa_answer.focus();
		return false;
	}else{
		if(formData.pa_answer.value.length>200){
			alert("您输入的答案信息请不要超过200个字!");
			formData.pa_answer.focus();
			return false;
		}
	}
	formData.submit();
}
function del()
{
	if(confirm("确认删除该问答?"))
	{
		window.location.href("AnswerDel.jsp?OPType=Del&pa_id=<%=pa_id%>");
	}
}
</script>
<!--    表单提交结束    -->
<%@include file="/system/app/skin/skin4/template/info_bottom.jsp"%> 
<%
}
catch(Exception e){
	System.out.println(new java.util.Date() + "--"
			+ request.getServletPath() + " : " + e.getMessage());
}
finally{
	dImpl.closeStmt();
	dCn.closeCn(); 
}
%>
<%@include file="/system/app/skin/bottom.jsp"%>
                                     
