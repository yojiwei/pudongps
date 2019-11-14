<%@page contentType="text/html; charset=GBK"%>
<%@include file="/system/app/skin/head.jsp"%>
<script LANGUAGE="javascript" src="./common/common.js"></script>
<script type="text/javascript" src="editor/fckeditor.js"></script>
<script LANGUAGE="javascript" src="/system/common/treeview/chooseTreeJs.js"></script>
<html>
<head>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
	<style type="text/css">
	<!--
	.STYLE1 {color: #FF0000}
	-->
	</style>
</head>
<link href="/system/app/skin/skin3/images/style.css" rel="stylesheet"
	type="text/css">
<link href="../style.css" rel="stylesheet" type="text/css">
<title>短信发布</title>
<style type="text/css">
<!--
@import url("/system/app/skin/skin3/images/main.css");
-->
</style>
<script language=javascript>
function save()
{  
    var form = document.formData ;
	if(document.formData.content1.value=="")
	{
	    alert("请输入您要发送的短信内容！");
		document.formData.content1.focus;
		return false;
	}
	else {
	document.formData.action = "messageReResult.jsp";//只是修改后保存！
	document.formData.submit();
	}
}

function del(){
	document.formData.action="messageDel.jsp";
	document.formData.submit();
}

function cnc(o,t){
	if(o.value.length<=60) t.innerHTML = eval(60-o.value.length);
	else 
	//o.value = o.value.substring(0, 60);
	t.innerHTML = eval(60-o.value.length);
}
</SCRIPT> 
<%
  Hashtable content = null;
  Hashtable content_ym = null;
  Hashtable dt_content1 = null;
  Vector vectorPage = null;
  CMySelf mySelf = (CMySelf)session.getAttribute("mySelf");
  String smm_id="";
  String sm_ct_id = "";
  //
  String mysql="";
  String yousql="";
  String mmt_id="";
  String mmt_con="";
  String mmt_sendtime="";
  String mmt_sj_id ="";
  String mmt_sj_name = "";
  String aa= "";
  String dx_sjname="";
	String dx_sjid = "";
	//
  CDataCn dCn = null;
  CDataImpl dImpl = null;
  try{
  dCn = new CDataCn();
  dImpl = new CDataImpl(dCn);
  
  smm_id=CTools.dealString(request.getParameter("sm_id"));

  mysql="select sm_ct_id from tb_sms where sm_id="+smm_id+" and sm_tel is null";
  aa=request.getParameter("aa");
  dt_content1 = dImpl.getDataInfo(mysql);
  if (dt_content1 != null);
  	sm_ct_id = CTools.dealNull(dt_content1.get("sm_ct_id"));
  	
  if(!"".equals(sm_ct_id)&&aa.equals("1")) //内容为null 直接从别的栏目转回来的
  {
  	 yousql="select s.sm_id,s.sm_con,s.sm_sj_id,s.sm_sendtime,j.sj_name from tb_sms s,tb_subject j where s.sm_sj_id=j.sj_id and s.sm_ct_id="+sm_ct_id+" and s.sm_id="+smm_id+" and rownum=1 order by sm_id desc ";
  }
  else //内容不为null 气象预报和直接从短信频道下面发出去的短信
  {
  	 yousql="select s.sm_id,s.sm_con,s.sm_sj_id,s.sm_sendtime,j.sj_name  from tb_sms s,tb_subject j where s.sm_sj_id=j.sj_id and s.sm_id="+smm_id+" and rownum=1 order by sm_id desc ";
	 	 sm_ct_id="520";
  }
    content_ym = dImpl.getDataInfo(yousql);
    if(content_ym!=null)
    {
      mmt_id=CTools.dealNull(content_ym.get("sm_id")) ;
		  mmt_con=CTools.dealNull(content_ym.get("sm_con")) ;
		  mmt_sendtime=CTools.dealNull(content_ym.get("sm_sendtime")) ;
		  mmt_sj_name=CTools.dealNull(content_ym.get("sj_name")) ;
		  mmt_sj_id=CTools.dealNull(content_ym.get("sm_sj_id"));
	 }
%>
<%@include file="/system/app/skin/skin4/template/info_top.jsp"%>
<!--    模块名称开始    -->
短信信息发布
<!--    模块名称结束    -->
<%@include file="/system/app/skin/skin4/template/info_funtion.jsp"%>
<!--    功能按钮开始    -->

<!--    功能按钮结束    -->
<%@include file="/system/app/skin/skin4/template/info_main.jsp"%>
<!--    表单提交开始    -->
<form name="formData" action="" method="post"  enctype="multipart/form-data" >
<table class="main-table" width="100%">
	<tr class="line-even">
		<td width="19%" align="right">
			发布时间：
		</td>
		<td width="81%" align='left'>
			<input type="text" name="sendtime" class="text-line"
				value="<%=mmt_sendtime%>" readonly="true"
				onClick="javascript:showCal()" style="cursor:hand" />
		</td>
	</tr>
	 <tr class="line-odd">
         <td width="18%" align="right">短信所属栏目：</td>
          <td width="82%" align='left'>
          <select name="mysj_id" class=select-a >
<%
String strSql="select sj_id,sj_parentid,sj_dir,sj_name from tb_subject where sj_dir <> 'xxll' connect by prior sj_id = sj_parentid start with sj_dir = 'xxll' order by SJ_SEQUENCE";
  vectorPage = dImpl.splitPage(strSql,20,1);
  if(vectorPage!=null)
  {
    for(int j=0;j<vectorPage.size();j++)
    {
      content = (Hashtable)vectorPage.get(j);
	    dx_sjname=CTools.dealNull(content.get("sj_name"));
	    dx_sjid = CTools.dealNull(content.get("sj_id"));
%>
   <option value="<%=dx_sjid%>" <%=dx_sjid.equals(mmt_sj_id)?"selected":""%>><%=dx_sjname%></option>
<%
	}
 }
%>
		  </select> </td>
     </tr>
	 <tr class="line-even"> 
		<td width="19%" nowrap align="right">
			规定单条短信字数(60)：
		</td>
		<td width="81%" nowrap align='left'>
		（您还可以输入<span id="numcount1" style="color:red;font-weight:-bold;">10</span>个字）</td>
	</tr>
	<tr class="line-even">
		<td align="left" height="20" colspan=2>
			<textarea name="content1" cols="60" style="WIDTH:100%;HEIGHT:80px" onPropertyChange="cnc(this,document.all.numcount1);"><%=mmt_con%></textarea>
			<script>cnc(document.all.content1,document.all.numcount1);</script>
		</td>
	</tr>
	<tr class="line-even">
		<td align="center" height="20" colspan=2>
			<input type="button" value="保存" class="bttn" onClick="save();"/>
			<input type="button" value="删除" class="bttn" onClick="del()"/>
			<input type="reset" value="重置" class="bttn" />
			<input type="button" name="返回" value="返回" class="bttn" onClick="javascript:history.go(-1)">
			<input type="hidden" value="<%=smm_id%>" class="bttn" name="sm_id" />	
		</td>
	</tr>
</table>
</form>
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
                          
