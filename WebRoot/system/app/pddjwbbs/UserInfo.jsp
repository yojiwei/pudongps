<%@page contentType="text/html; charset=GBK"%>
<%@include file="/system/app/skin/head.jsp"%>
<%
String us_id="";
String us_name="";
String us_uid  = "";
String us_pwd = "";
String OPType = "";
//
CDataCn dCn = null;
CDataImpl dImpl = null;
try{
dCn = new CDataCn("pddjw");
dImpl = new CDataImpl(dCn);
//
OPType = CTools.dealString(request.getParameter("OPType")).trim();
us_id = CTools.dealString(request.getParameter("us_id")).trim();

if(OPType.equals("Edit"))
{
	String sql="select us_id,us_uid,us_name from forum_user where us_id='"+us_id+"'";
	
	Hashtable content=dImpl.getDataInfo(sql);
	us_name = content.get("us_name").toString();
	us_uid = content.get("us_uid").toString();
	us_id = content.get("us_id").toString();

}
%>

<script>
    function check()
    {
      if(formData.us_uid.value=="")
      {
				alert("登录名不能为空！");
				formData.us_uid.focus();
        return false;
      }
      if (formData.us_name.value == "") {
				alert("用户名不能为空！");
				formData.us_name.focus();
        return false;
      }
      if(formData.us_pwd.value=="")
      {
				alert("登录密码不能为空！");
				formData.us_pwd.focus();
        return false;
      }
      document.formData.submit();
   }
</script>
<%@include file="/system/app/skin/skin4/template/info_top.jsp"%>
<!--    模块名称开始    -->
用户信息维护
<!--    模块名称结束    -->
<%@include file="/system/app/skin/skin4/template/info_funtion.jsp"%>
<!--    功能按钮开始    -->

<!--    功能按钮结束    -->
<%@include file="/system/app/skin/skin4/template/info_main.jsp"%>
<!--    表单提交开始    -->
<table WIDTH="100%" CELLPADDING="0" cellspacing="0" BORDER="0">
<form action="UserInfoResult.jsp" method="post" name="formData">
    <tr>
     <td width="100%">
		<table border="0" width="100%" cellpadding="0" cellspacing="0" class="content-table">
      	<tr>
        	<td width="100%" align="left" valign="top">
	  		<table border="0" width="100%" cellspacing="1" cellpadding="0">
						<tr class="line-even" >
       				 <td width="19%" align="right">用户名：</td>
        				 <td width="81%" ><input type="text" class="text-line" size="20" name="us_name" maxlength="50"  value="<%=us_name%>" ></td>
      			 </tr>
					 <tr class="line-odd">
	  	    		<td width="15%" align="right">登录名：</td>
	  	    		<td width="85%"><input name="us_uid" size="20" class="text-line" value="<%=us_uid%>" maxlength="30" <%=OPType.equals("Edit")?"readonly":""%>>
							<font color="#FF0000">*</font>
							</td>
            </tr>
		  		<tr class="line-even">
	  	    		<td width="15%" align="right">密码：</td>
	  	    		<td width="85%"><input name="us_pwd" type="password" size="20" class="text-line" value="<%=us_pwd%>" maxlength="50">
					<font color="#FF0000">*</font>
					</td>
		       </tr>
	  		</table>
        	</td>
      	</tr>
      	<tr colspan="2" class="outset-table">
        <td width="100%" align="center">
        	<input type="hidden" name="optype" value="<%=OPType%>"/>
        	<input type="hidden" name="us_id" value="<%=us_id%>"/>
          <input class="bttn" value="提交" type="button" onclick="check();" size="6" name="btnSubmit">&nbsp;
          <input class="bttn" value="重置" type="reset" size="6" >&nbsp;
          <input class="bttn" value="返回" type="button" onclick="history.back();" size="6" >&nbsp;
        </td>
      </tr>
    </table>
    </td>
  </tr>
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
                                     
