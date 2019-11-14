<%@page contentType="text/html; charset=GBK"%>
<%@include file="/system/app/skin/head.jsp"%>
<%
String us_id="";
String us_uid = "";
String us_pwd = "";
String OPType="";
String ec_name="";
String ec_enroladd="";
String ec_enrolzip="";
String ec_corporation="";
String ec_produceadd="";
String ec_producezip="";
String ec_mgr="";
String ec_linkman="";
String ec_fax="";
String ec_email="";
String us_istemp = "";
String optype ="";
//
CDataCn dCn = null;
CDataImpl dImpl = null;
try{
dCn = new CDataCn();
dImpl = new CDataImpl(dCn);
//
us_id=CTools.dealString(request.getParameter("us_id")).trim();
OPType=CTools.dealString(request.getParameter("OPType")).trim();

if(OPType.equals("")){
OPType = "Add";
}
if(OPType.equals("Add")){
	optype = "新增企业用户";
}else if(OPType.equals("Edit")){
	optype = "修改企业用户";
}else if(OPType.equals("Audit")){
	optype = "审核企业用户";
} 

if(!OPType.equals("Add"))
{
	String sql_userinfo  ="select u.us_uid,u.us_pwd,u.us_istemp,e.ec_name,e.ec_enroladd,e.ec_enrolzip,e.ec_corporation,e.ec_produceadd,e.ec_producezip,e.ec_mgr,e.ec_linkman,e.ec_fax,e.ec_email from tb_user u ,tb_enterpvisc e where u.us_id = e.us_id and u.us_id = '"+us_id+"'";
	Hashtable userinfo = dImpl.getDataInfo(sql_userinfo);
	us_uid=userinfo.get("us_uid").toString();
	us_pwd=userinfo.get("us_pwd").toString();
	ec_name=userinfo.get("ec_name").toString();
	ec_enroladd=userinfo.get("ec_enroladd").toString();
	ec_enrolzip=userinfo.get("ec_enrolzip").toString();
	ec_corporation=userinfo.get("ec_corporation").toString();
	ec_produceadd=userinfo.get("ec_produceadd").toString();
	ec_producezip=userinfo.get("ec_producezip").toString();
	ec_mgr=userinfo.get("ec_mgr").toString();
	ec_linkman=userinfo.get("ec_linkman").toString();
	ec_fax=userinfo.get("ec_fax").toString();
	ec_email=userinfo.get("ec_email").toString();
	us_istemp=userinfo.get("us_istemp").toString();
}
%>
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
		alert("用户帐号不能为空！");
		formData.us_uid.focus();
        return false;
      }
      if (checkSpace(formData.us_uid.value) == true) {
		alert("用户帐号不能为空！");
		formData.us_uid.focus();
        return false;
      }
      if(formData.us_pwd.value=="")
      {
		alert("用户密码不能为空！");
		formData.us_pwd.focus();
        return false;
      }
      if(formData.ec_name.value=="")
      {
		alert("单位名称不能为空！");
		formData.ec_name.focus();
        return false;
      }
      if(formData.ec_enroladd.value=="")
      {
		alert("注册地址不能为空！");
		formData.ec_enroladd.focus();
        return false;
      }
      if(formData.ec_enrolzip.value=="")
      {
		alert("注册邮编不能为空！");
		formData.ec_enrolzip.focus();
        return false;
      }
      if(formData.ec_corporation.value=="")
      {
		alert("注册法人代表不能为空！");
		formData.ec_corporation.focus();
        return false;
      }
      document.formData.submit();
   }

	function winopen(url){
		window.open(url);
	}
</script>
<%@include file="/system/app/skin/skin4/template/info_top.jsp"%>
<!--    模块名称开始    -->
<%=optype%>
<!--    模块名称结束    -->
<%@include file="/system/app/skin/skin4/template/info_funtion.jsp"%>
<!--    功能按钮开始    -->

<!--    功能按钮结束    -->
<%@include file="/system/app/skin/skin4/template/info_main.jsp"%>
<!--    表单提交开始    -->
<table WIDTH="100%" CELLPADDING="0" cellspacing="0" BORDER="0">
<form action="BEUserInfoResult.jsp" method="post" name="formData">
    <tr>
     <td width="100%">
	<table border="0" width="100%" cellpadding="0" cellspacing="0" class="content-table">
      	<tr>
        	<td width="100%" align="left" valign="top">
	  		<table border="0" width="100%" cellspacing="1" cellpadding="0">
	  	 		 
				 <tr class="line-even" >
					 <td width="19%" align="right">用户帐号</td>
						 <td width="81%" ><input type="text" class="text-line" size="20" name="us_uid" maxlength="150"  value="<%=us_uid%>" <%="修改企业用户".equals(optype)?"readonly":""%>>
						 <font color="#FF0000">*</font>
						 </td>
				 </tr>
		  		<tr class="line-odd">
	  	    		<td width="15%" align="right">密码：</td>
	  	    		<td width="85%"><input name="us_pwd" size="20" type="password" class="text-line" value="<%=us_pwd%>" maxlength="30">
					<font color="#FF0000">*</font>
					</td>
				</tr>
				 <tr class="line-even" >
					 <td width="19%" align="right">单位名称：</td>
					 <td width="81%" ><input type="text" class="text-line" size="20" name="ec_name" maxlength="150"  value="<%=ec_name%>" <%="修改企业用户".equals(optype)?"readonly":""%>>
						 <font color="#FF0000">*</font>
						 </td>
				 </tr>
		  		<tr class="line-odd">
	  	    		<td width="15%" align="right">注册地址：</td>
	  	    		<td width="85%"><input name="ec_enroladd" size="20" class="text-line" value="<%=ec_enroladd%>" maxlength="30">
					<font color="#FF0000">*</font>
					</td>
				</tr>
				 <tr class="line-even" >
					 <td width="19%" align="right">注册邮编：</td>
						 <td width="81%" ><input type="text" class="text-line" size="20" name="ec_enrolzip" maxlength="150"  value="<%=ec_enrolzip%>" >
						 <font color="#FF0000">*</font>
						 </td>
				 </tr>
		  		<tr class="line-odd">
	  	    		<td width="15%" align="right">注册法人代表：</td>
	  	    		<td width="85%"><input name="ec_corporation" size="20" class="text-line" value="<%=ec_corporation%>" maxlength="30">
					<font color="#FF0000">*</font>
					</td>
				</tr>
		  		<tr class="line-even">
	  	    		<td width="15%" align="right">生产/办公地址：</td>
	  	    		<td width="85%"><input name="ec_produceadd"  size="20" class="text-line" value="<%=ec_produceadd%>" maxlength="50">					
					</td>
		         </tr>
                 <tr class="line-even">
                    <td width="15%" align="right">生产/办公邮编：</td>
	  	    		<td width="85%"><input name="ec_producezip" size="20" class="text-line" value="<%=ec_producezip%>" maxlength="50"></td>
	  	  		</tr>
					<tr class="line-odd">
					<td width="15%" align="right">总经理：</td>
	  	    		<td width="85%"><input name="ec_mgr" size="20" class="text-line" value="<%=ec_mgr%>" maxlength="40"></td>
	  	  		</tr>
				<tr class="line-even">
					<td width="15%" align="right">联系方式：</td>
	  	    		<td width="85%"><input name="ec_linkman" size="20" class="text-line" value="<%=ec_linkman%>" maxlength="50"></td>
	  	  		</tr>
				<tr class="line-even">
					<td width="15%" align="right">传真：</td>
	  	    		<td width="85%"><input name="ec_fax" size="20" class="text-line" value="<%=ec_fax%>" maxlength="50"></td>
	  	  		</tr>
				<tr class="line-even">
					<td width="15%" align="right">电子邮编:</td>
	  	    		<td width="85%"><input name="ec_email" size="20" class="text-line" value="<%=ec_email%>" maxlength="50">
					</td>
			 </tr>
				<%
				if(!OPType.equals("Add")){
				%>
				<tr class="line-even">
					<td width="15%" align="right">申请事项:</td>
	  	    		<td width="85%"><%
					String sql_list = "select pp_id,pp_value from tb_passport where pp_id = ( select  pp_id from tb_entemprvisexml where ec_id = (select ec_id from tb_enterpvisc where us_id ='"+us_id+"'))";
					Vector vec_list  =  dImpl.splitPage(sql_list,request,100);
					if(vec_list!=null){
						for (int q= 0 ; q<vec_list.size() ; q++){
							Hashtable has_list = (Hashtable)vec_list.get(q);
							out.println("<A HREF=javascript:winopen(\"ProjectNewTable.jsp?us_id="+us_id+"&pp_id="+has_list.get("pp_id").toString()+"\");>"+has_list.get("pp_value").toString()+"</A><br>");
						}
					}
					
					%>
					</td>
			 </tr>

			<%   
				 }
			
			if(OPType.equals("Audit")){
				
			
			%>
				<tr class="line-even">
					<td width="15%" align="right">审核状态:</td>
	  	    		<td width="85%">
					 <select name="us_istemp" class="select-a">
						<option value="0" <%if(us_istemp.equals("0")) out.print("selected");%>>否
						<option value="1" <%if(us_istemp.equals("1")) out.print("selected");%>>是	
					</select>
				</td>
			 </tr>
<%}%>
	  		</table>
        	</td>
      	</tr>
      	<tr colspan="2" class="outset-table">
        <td width="100%" align="center">
          <INPUT TYPE="hidden" name="OPType" value="<%=OPType%>">
          <INPUT TYPE="hidden" name="us_id" value="<%=us_id%>">
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
                                     
