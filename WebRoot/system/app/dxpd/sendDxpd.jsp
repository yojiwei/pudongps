<%@page contentType="text/html; charset=GBK"%>
<%@include file="/system/app/skin/head.jsp"%>
<style type="text/css">
<!--
@import url("/system/app/skin/skin3/images/main.css");
-->
</style>
<link href="/system/app/skin/skin3/images/style.css" rel="stylesheet" type="text/css">
<SCRIPT   LANGUAGE="JavaScript">   
<!--//   
function   textCounter(field,   countfield,   maxlimit)   {  
	if(field.value.length   >   maxlimit){
	document.getElementById("mess").innerHTML="<font color='#FF0000'>注意：您已经超出了</font>";  
	} 
	else
	document.getElementById("mess").innerHTML="注意：您还可以输入";  
	countfield.value   =   maxlimit   -   field.value.length;   
}
function pp(field,countfield,maxlimit){ 
var clob = "";
}
//-->   
function mess(){
	if(formData.messages.value==""){
		alert("请输入短信内容！");
		formData.messages.focus();
		return false;
	}
	formData.submit();
}
</SCRIPT> 
<%
CMySelf mySelf = (CMySelf)session.getAttribute("mySelf");
 CDataCn dCn = null;
 CDataImpl dImpl = null;
 Hashtable content = null;
 Vector vectorPage = null;
 String ct_id = "";
 try{
 dCn = new CDataCn();
 dImpl = new CDataImpl(dCn);
 ct_id = CTools.dealNumber(request.getParameter("ctId"));
%>
<%@include file="/system/app/skin/skin4/template/info_top.jsp"%>
<!--    模块名称开始    -->
短信发布
<!--    模块名称结束    -->
<%@include file="/system/app/skin/skin4/template/info_funtion.jsp"%>
<!--    功能按钮开始    -->

<!--    功能按钮结束    -->
<%@include file="/system/app/skin/skin4/template/info_main.jsp"%>
<!--    表单提交开始    -->
<table class="main-table" width="100%" >
<form name="formData" action="sendDxpdResult.jsp" method="post" >
<tr class="line-even">
	<td colspan="4" align="left">
   §(<span id=mess>注意：您还可以输入</span>
   <input name="message" value="51" type="text" size="4" readonly/>个字！超出部分将分条收费！) </td>
 </tr>
 <tr class="line-odd">
	 <td width="11%" align="left">短信所属栏目：</td>
	  <td width="89%" align='left'>
	  <select name="mysj_id" class=select-a >
<%
String strSql="select sj_id,sj_parentid,sj_dir,sj_name from tb_subject where sj_dir <> 'xxll' connect by prior sj_id = sj_parentid start with sj_dir = 'xxll' order by SJ_SEQUENCE ";
  vectorPage = dImpl.splitPage(strSql,request,20);
  if(vectorPage!=null)
  {
    for(int j=0;j<vectorPage.size();j++)
    {
      content = (Hashtable)vectorPage.get(j);
	  String ri=content.get("sj_name").toString();
	  String ni = content.get("sj_id").toString();
%>
          <option value="<%=ni%>"><%=ri%></option>
<%
	}
   }
%>
      </select> </td>
    </tr>
     <tr class="line-even">
        <td colspan="4">
          <textarea name="messages" cols="60" rows="8" onPropertyChange="textCounter(document.all.messages,document.all.message,51);"></textarea>&nbsp;&nbsp;       </td>
     </tr>
	<tr class="outset-table"><input type="hidden" name="ct_id" value="<%=ct_id%>"/>
         <td colspan="2" align="center"><input type="button" name="提交" class="bttn" onClick="return mess()" value="提交">&nbsp;&nbsp;&nbsp;&nbsp;<input type="reset" value="重置" class="bttn" />&nbsp;&nbsp;&nbsp;&nbsp;<input type="button" onclick="javascript:history.back();" value="返回" class="bttn" /></td>
     </tr></form>
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
                                     
