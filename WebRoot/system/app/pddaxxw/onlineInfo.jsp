<%@page contentType="text/html; charset=GBK"%>
<%@include file="/system/app/skin/head.jsp"%>
<%
CDate cdate = new CDate();
String ctoday = cdate.getThisday();
String dx_applytime = cdate.getNowTime();
String dx_num = "";
//
String dx_id = "";//表单id
String dx_name = "";//姓名
String dx_backtype = "";//回复方式 1电话回复2电子邮件回复3信件回复
String dx_tel = "";//电话
String dx_address = "";//地址
String dx_codenumber = "";//邮编
String dx_email = "";//电子邮件 
String dx_use = "";//用途
String dx_content = "";//内容
String dx_type = "apply";//在线查档申请表apply/在线咨询表ask

String acids = "";
String otype = "";

String onlineSql = "";
CDataCn dCn = null;
CDataImpl dImpl = null;
Hashtable contentdx = null;
Hashtable content = null;
Hashtable contentus = null;
Vector vPage = null;

String us_id = "";
String us_name = "";
String us_tel = "";
String us_address = "";
String us_zip = "";
String us_email = "";
String us_cellphonenumber = "";
String dx_backcontent = "";
String dx_status = "";

try{
dCn = new CDataCn();
dImpl = new CDataImpl(dCn);

dx_id = CTools.dealString(request.getParameter("dx_id")).trim();
//

onlineSql = "select dx_id,dx_num,dx_applytime,dx_name,dx_backtype,dx_tel,dx_address,dx_codenumber,dx_email,dx_content,dx_use,dx_type,dx_status,dx_backcontent from tb_daxx where dx_type='apply' ";
if(!"".equals(dx_id)){
	onlineSql += " and dx_id = "+dx_id+"";
}

contentdx = dImpl.getDataInfo(onlineSql);
if(contentdx!=null){
	dx_id = CTools.dealNull(contentdx.get("dx_id"));
	dx_num = CTools.dealNull(contentdx.get("dx_num"));
	dx_applytime = CTools.dealNull(contentdx.get("dx_applytime"));
	dx_name = CTools.dealNull(contentdx.get("dx_name"));
	dx_backtype = CTools.dealNull(contentdx.get("dx_backtype"));
	dx_tel = CTools.dealNull(contentdx.get("dx_tel"));
	dx_address = CTools.dealNull(contentdx.get("dx_address"));
	dx_codenumber = CTools.dealNull(contentdx.get("dx_codenumber"));
	dx_email = CTools.dealNull(contentdx.get("dx_email"));
	dx_content = CTools.dealNull(contentdx.get("dx_content"));
	dx_use = CTools.dealNull(contentdx.get("dx_use"));
	dx_type = CTools.dealNull(contentdx.get("dx_type"));
	dx_backcontent = CTools.dealNull(contentdx.get("dx_backcontent"));
	dx_status = CTools.dealNull(contentdx.get("dx_status"));
}
%>
<%@include file="/system/app/skin/skin4/template/info_top.jsp"%>
<!--    模块名称开始    -->
申请查档查看
<!--    模块名称结束    -->
<%@include file="/system/app/skin/skin4/template/info_funtion.jsp"%>
<!--    功能按钮开始    -->

<!--    功能按钮结束    -->
<%@include file="/system/app/skin/skin4/template/info_main.jsp"%>
<!--    表单提交开始    -->
<table  border="0" width="100%" cellpadding="0" cellspacing="1" class="content-table">
<form name="formData" action="onlineInfoResult.jsp" method="post">	
	<input type="hidden" name="dx_id" value="<%=dx_id%>"/>
	<input type="hidden" name="dx_type" value="apply"/>
<tr class="line-even">
  <td width="14%" align="right" valign="middle">序&nbsp;&nbsp;&nbsp; 号：</td>
  <td colspan="3" align="left" valign="middle">
  	<input name="num" type="text" id="num" size="47" readonly value="<%=dx_num%>"/></td>
  </tr>
<tr class="line-odd">
  <td align="right" valign="middle">咨询时间：</td>
  <td colspan="3" align="left" valign="middle">
  	<input name="zxtime" type="text"  id="zxtime" size="47" readonly value="<%=dx_applytime%>"/></td>
  </tr>
<tr class="line-even">
  <td  align="right" valign="middle">姓&nbsp;&nbsp;&nbsp; 名：</td>
  <td colspan="3" align="left" valign="middle">
  	<input name="name" type="text"  id="name" size="47" value="<%=dx_name%>" /></td>
  </tr>
<tr class="line-odd">
  <td align="right" valign="middle">回复方式：</td>
  <td  colspan="3" align="left" valign="middle">
  <select name="backtype" style="width:150px;">
	  <option value="0">请选择回复方式</option>
	  <option value="1" <%=dx_backtype.equals("1")?"selected":""%>>电话回复</option>
	  <option value="2" <%=dx_backtype.equals("2")?"selected":""%>>电子邮箱回复</option>
	  <option value="3" <%=dx_backtype.equals("3")?"selected":""%>>信件回复</option>
	</select>  </td>
</tr>
<%
if(dx_backtype.equals("1")){
%>
<tr class="line-odd">
  <td align="right" valign="middle">联系电话：</td>
  <td  colspan="3" align="left" valign="middle"><input name="tel" type="text"  id="tel" size="47" value="<%=dx_tel%>" /></td>
</tr>
<%
}else if(dx_backtype.equals("2")){
%>
<tr class="line-even">
  <td  align="right" valign="middle">电子邮件：</td>
  <td colspan="3" align="left" valign="middle"><input name="email" type="text"  id="email" size="47" value="<%=dx_email%>"/></td>
</tr>
<%}else{%>
<tr class="line-odd">
  <td align="right" valign="middle">联系地址：</td>
  <td colspan="3" align="left" valign="middle"><input name="address" type="text"  id="address" size="47"  value="<%=dx_address%>"/></td>
</tr>
<tr class="line-even">
  <td  align="right" valign="middle">邮　&nbsp; 编：</td>
  <td  colspan="3" align="left" valign="middle"><input name="codenum" type="text"  id="codenum"  size="47" maxlength="6" value="<%=dx_codenumber%>" /></td>
</tr>
<%}%>
<tr class="line-odd">
  <td align="right" valign="middle">申请内容：</td>
  <td colspan="3" align="left" valign="top">
  	<textarea name="content" readonly cols="45" rows="7" id="content"><%=dx_content%></textarea></td>
</tr>
<tr class="line-even">
  <td align="right" valign="middle">用　　途：</td>
  <td colspan="3" align="left" valign="middle"><input name="usertobe" type="text"   id="usertobe" size="47" value="<%=dx_use%>" /></td>
</tr>
<tr class="line-odd">
  <td align="right" valign="middle">回复意见：</td>
  <td align="left" valign="middle">
  	<textarea name="back_con" cols="45" rows="7" id="content" <%=!"".equals(dx_backcontent)?"readonly":""%>><%=dx_backcontent%></textarea>  </td>
  <td colspan="2" align="left" valign="middle"><font color="red">*</font>&nbsp;</td>
  </tr>
<%if("0".equals(dx_status)){%>
<tr class="outset-table">
  <td valign="middle">&nbsp;</td>
  <td width="35%" align="center" valign="middle"><input type="button" name = "sub1" value="&nbsp;提交&nbsp;" onclick="checkform()"/>
    &nbsp;&nbsp;&nbsp;<input type="button" name = "sub3" value="&nbsp;删除&nbsp;" onclick="javascript:window.location.href='onlineDel.jsp?dx_id=<%=dx_id%>&dx_type=apply';"/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="reset" name = "sub2" value="&nbsp;重置&nbsp;"/></td>
  <td colspan="2"  align="center">&nbsp;</td>
  </tr>
<%}else{%>
<tr class="outset-table">
  <td valign="middle">&nbsp;</td>
  <td colspan="2" align="center" valign="middle"><input type="button" name = "sub3" value="&nbsp;删除&nbsp;" onclick="javascript:window.location.href='onlineDel.jsp?dx_id=<%=dx_id%>&dx_type=apply';"/>&nbsp;&nbsp;<input type="button" name = "sub1" value="&nbsp;返回&nbsp;" onclick="javascript:window.history.back();"/></td>
  <td width="34%"  align="left">&nbsp;</td>
</tr>
<%}%>
</form>
<script language="javascript">
	function checkform(){
		var formda = document.formData;
		var back_con = formda.back_con.value;
	  if(back_con==""){
	  	alert("请填写回复意见！");
	  	formda.back_con.focus();
	  	return false;
	  }
	  formda.submit();
	}
</script>
</table>
<!--    表单提交结束    -->
<%@include file="/system/app/skin/skin4/template/info_bottom.jsp"%> 
<%
}
catch(Exception ex){
	System.out.println(new java.util.Date() + "--"
			+ request.getServletPath() + " : " + ex.getMessage());
}
finally{
	dImpl.closeStmt();
	dCn.closeCn(); 
}
%>
<%@include file="/system/app/skin/bottom.jsp"%>
                                     
