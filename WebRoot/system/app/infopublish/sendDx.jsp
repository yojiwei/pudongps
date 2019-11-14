<%@ page contentType="text/html; charset=GBK" language="java" import="java.sql.*" errorPage="" %>
<%@include file="/system/app/skin/head.jsp"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GBK" />
<title>短信发送</title>
</head>
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
<body>
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
<form name="formData" action="sendResult.jsp" method="post" >
<table class="main-table" width="100%" >
     <tr class="line-even">
        <td colspan="4">
       §(<span id=mess>注意：您还可以输入</span>
       <input name="message" value="51" type="text" size="4" readonly/>个字！超出部分将分条收费！) </td>
     </tr>
	 <tr class="line-odd">
         <td width="18%" align="left">短信所属栏目：</td>
          <td width="82%" align='left'>
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
	<tr class="line-odd"><input type="hidden" name="ct_id" value="<%=ct_id%>"/>
         <td colspan="2" align="center"><input type="button" name="提交" class="bttn" onClick="return mess()" value="提交">&nbsp;&nbsp;&nbsp;&nbsp;<input type="reset" value="重置" class="bttn" /></td>
     </tr>
</table>
</form>
</body>
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
</html>

