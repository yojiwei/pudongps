<%@page contentType="text/html; charset=GBK"%>
<%@include file="/system/app/skin/head.jsp"%>

<%
CDataCn dCn = null;
CDataImpl dImpl = null;
try{
dCn = new CDataCn();
dImpl = new CDataImpl(dCn);
//
java.util.Date date = new java.util.Date();
java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyy-MM-dd");
String cp_id = CTools.dealString(request.getParameter("type"));
String cs_id = CTools.dealString(request.getParameter("cs_id"));
String str_sql="select to_char(cs.cs_date,'yyyy-MM-dd') cs_date,cs.cs_title,cs_content from tb_conncase cs where cs_id = " + cs_id;
String cs_title = "";
String cs_content = "";
String cs_date = "";
  if(!cs_id.equals("")){
		Hashtable content = dImpl.getDataInfo(str_sql);  
		cs_title = content.get("cs_title").toString();
		cs_content = content.get("cs_content").toString();
		cs_date = content.get("cs_date").toString();
  }
  if(cs_date.equals("")){
	cs_date = sdf.format(date).toString();//结束时间
}
%>
<!-- 记录日志 -->
<%
String logstrMenu = "典型案例";
String logstrModule = "典型案例";
String cw_id = cs_id;
%>
<%@include file="/system/app/writelogs/WriteDetailLog.jsp"%>
<!-- 记录日志 -->
<%@include file="/system/app/skin/skin4/template/info_top.jsp"%>
<!--    模块名称开始    -->
典型案例
<!--    模块名称结束    -->
<%@include file="/system/app/skin/skin4/template/info_funtion.jsp"%>
<!--    功能按钮开始    -->
典型案例
<!--    功能按钮结束    -->
<%@include file="/system/app/skin/skin4/template/info_main.jsp"%>
<!--    表单提交开始    -->
<table align="center" width="100%" CELLPADDING="1" cellspacing="1">
<form name="formData" method="post" action="caseResult.jsp">
  <input type="hidden" name="type" value="<%=cp_id%>"> 
	<input type="hidden" name="cs_id" value="<%=cs_id%>"> 
	<tr class="line-odd">
		<td width="15%" align="right">时&nbsp;&nbsp;&nbsp;&nbsp;间</td>
		<td align="left"><input name="beginTime" style="cursor:hand" class="text-line" readonly size="10" onclick="showCal()" value="<%=cs_date%>"></td>
	</tr>
	<tr class="line-even">
		<td width="15%" align="right">案例主题</td>
		<td align="left"><input name="cs_title" size="40" class="text-line" maxlength="40" value="<%=cs_title%>"></td>
	</tr>
	<tr class="line-odd">
		<td width="15%" align="right">案例内容</td>
		<td align="left">
			<textarea class="text-area" name="cs_content" cols="60" rows="6" title="案例内容"><%=cs_content%></textarea>
		</td>
	</tr>
	<tr class="title1" width="100%">
		<td colspan="2" class="outset-table">
			<input type='button' onclick='finish_2(document.formData)' class="bttn" value="提交">&nbsp;
			<input type="reset" class="bttn" value="重写">&nbsp;
			<input type='button' onclick='delCase(document.formData)' class="bttn" value="删除">&nbsp;
		</td>
	</tr>
</form>
</table>
<script language="javascript">
  function finish_2(formData){  
	var form = document.formData;   
	if(document.formData.cs_title.value==""){
		alert("请填案例主题！");
        document.formData.cs_title.focus();
		return false;
	}
	else if(document.formData.cs_content.value==""){
		alert("请填案例内容！");
		document.formData.cs_content.focus();
		return false;
	}
	if(document.formData.cs_content.value.length>2000){
		alert("内容不得超过2000字！");
        document.formData.cs_title.focus();
		return false;
	}
    if(window.confirm('确认要这样处理吗？')){   
    form.action = "caseResult.jsp";
    form.submit();
    }
  }
  function delCase(formData){  
	var form = document.formData;   	
    if(window.confirm('确认要删除吗？')){   
    form.action = "caseDel.jsp";
    form.submit();
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
                                     
