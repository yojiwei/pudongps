<%@page contentType="text/html; charset=GBK"%>
<%@include file="/system/app/skin/head.jsp"%>
<script>
//判定输入的内容是否全部为空格如果是返回true,否则返回false
function checkSpace(obj) {
	var bool = false;
	for (var i = 0;i < obj.length;i++) {
		if (obj.substring(i,i + 1) == " " || obj.substring(i,i + 1) == "　") {
			bool = true;
		}
		else {
			bool = false;
			break;
		}
	}
	if (bool == true) return true;
	else return false;
}
function check()
{
  if(formData.us_uid.value=="")
  {
	alert("用户名不能为空！");
	formData.us_uid.focus();
	return false;
  }
  if (checkSpace(formData.us_uid.value) == true) {
	alert("用户名不能为空！");
	formData.us_uid.focus();
	return false;
  }
  if(formData.newpassword.value=="")
  {
	alert("用户新密码不能为空！");
	formData.newpassword.focus();
	return false;
  }
  if(formData.renewpassword.value=="")
 {
	alert("请再次输入新密码！");
	formData.renewpassword.focus();
	return false;
 }
  if(formData.renewpassword.value=="")
 {
	alert("请再次输入新密码！");
	formData.us_idcardnumber.focus();
	return false;
 }
  if(formData.newpassword.value!=formData.renewpassword.value){
	alert("两次密码不一致请重新输入！");
	formData.newpassword.value=="";
	formData.renewpassword.value=="";
	formData.newpassword.focus();
	return false;
  }
  document.formData.submit();
}
</script>
<%
String us_id = "";
String us_uid = "";
String us_pwd = "";
String us_name = "";
String strSql = "";
String sqlStr = "";
String us_isok = "";
String pudongus_id = "";
//CASSO数据库
MyCDataCn mydCn = null;
MyCDataImpl mydImpl = null;
//pudong数据库
CDataCn dCn = null;
CDataImpl dImpl = null;

Hashtable content = null;
Hashtable contentdx = null;
try{
//CASSO数据库
mydCn = new MyCDataCn();
mydImpl = new MyCDataImpl(mydCn);
//pudong数据库
dCn = new CDataCn();
dImpl = new CDataImpl(dCn);
//
us_id=CTools.dealString(request.getParameter("us_id")).trim();
sqlStr = "select * from tb_user where us_id = '"+us_id+"'";
content = (Hashtable)mydImpl.getDataInfo(sqlStr);
if(content!=null){
 	  us_uid = CTools.dealNull(content.get("us_uid"));
	  us_uid = us_uid.replaceAll("@pudong.gov.cn","");
	  //
	  sqlStr = "select us_id,us_name from tb_user where us_uid = '"+us_uid+"'";
	  contentdx = (Hashtable)dImpl.getDataInfo(sqlStr);
	  if(contentdx!=null){
	  pudongus_id = CTools.dealNull(contentdx.get("us_id"));
		us_name = CTools.dealNull(contentdx.get("us_name"));
	  }
	  //
	  us_pwd = CTools.dealNull(content.get("us_pwd"));
	  us_isok = CTools.dealNull(content.get("us_isok"));
}
%>

<%@include file="/system/app/skin/skin4/template/info_top.jsp"%>
<!--    模块名称开始    -->
用户修改
<!--    模块名称结束    -->
<%@include file="/system/app/skin/skin4/template/info_funtion.jsp"%>
<!--    功能按钮开始    -->

<!--    功能按钮结束    -->
<%@include file="/system/app/skin/skin4/template/info_main.jsp"%>
<!--    表单提交开始    -->

<table border="0" width="100%" cellpadding="0" cellspacing="1" class="content-table">
<form action="UserInfoResult1.jsp" method="post" name="formData">	<tr class="line-odd">
	<tr class="line-odd">
		<td width="46%" align="right">用户名：</td>
	  <td width="54%" align="left"><input name="us_uid" size="20" class="text-line" value="<%=us_uid%>" maxlength="30" readonly><font color="#FF0000">*</font></td>
	</tr>
	<tr class="line-even">
		 <td width="46%" align="right">用户姓名：</td>
		 <td width="54%" align="left">
	  <input type="text" class="text-line" size="20" name="us_name" maxlength="50"  value="<%=us_name%>" readonly></td>
    </tr>
	 <!--tr class="line-even" >
		 <td width="46%" align="right">原始密码：</td>
		 <td width="54%" >
	   <input type="text" class="text-line" size="20" name="password" maxlength="30"  value="<%=us_pwd%>"  readonly><font color="#FF0000">*</font></td>
	 </tr-->
	<tr class="line-even">
		<td width="46%" align="right">新密码：</td>
	  <td width="54%" align="left"><input name="newpassword" type="password" size="20" class="text-line" value="" maxlength="50"><font color="#FF0000">*</font></td>
	</tr>
	<tr class="line-even">
		<td width="46%" align="right">再次输入新密码：</td>
	  <td width="54%" align="left"><input name="renewpassword" type="password" size="20" class="text-line" value="" maxlength="50"><font color="#FF0000">*</font></td>
	</tr>
	<tr class="line-even">
		<td width="46%" align="right">操作该用户：</td>
	  <td width="54%" align="left"><input type="radio" name="us_isok" value="1" <%out.print("1".equals(us_isok)?"checked":"");%> >启用<input type="radio" name="us_isok" value="0" <%out.print("0".equals(us_isok)?"checked":"");%> >停用<font color="#FF0000">*
		 
	  </font></td>
	</tr>
	<tr colspan="2" class="outset-table">
	<td colspan="2" align="center">
		<INPUT TYPE="hidden" name="pudongus_id" value="<%=pudongus_id%>">
	  <INPUT TYPE="hidden" name="us_id" value="<%=us_id%>">
	  <input class="bttn" value="提交" type="button" onclick="check();" size="6" name="btnSubmit">&nbsp;
	  <input class="bttn" value="重置" type="reset" size="6" >&nbsp;
	  <input class="bttn" value="返回" type="button" onclick="history.back();" size="6" >&nbsp;	</td>
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
	mydImpl.closeStmt();
	mydCn.closeCn(); 
}
%>
<%@include file="/system/app/skin/bottom.jsp"%>
                                     
