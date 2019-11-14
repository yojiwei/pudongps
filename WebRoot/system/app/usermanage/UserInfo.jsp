<%@page contentType="text/html; charset=GBK"%>
<%@include file="/system/app/skin/head.jsp"%>
<%
String us_id="";
String OPType="";
String curpage="";
String optype="";
String us_name="";
String us_type="";
String us_email="";
String us_tel="";
String us_address="";
String uk_id = "";
String us_password="";
String us_isok="";
String names = "";
String ws_id="";
String ws_name="";
String us_istemp="";
String us_zip="";
String us_idcardnumber="";
String us_cellphonenumber="";
String us_uid  = "";
String us_pwd = "";
//
CDataCn dCn = null;
CDataImpl dImpl = null;
try{
dCn = new CDataCn();
dImpl = new CDataImpl(dCn);
//
OPType=CTools.dealString(request.getParameter("OPType")).trim();
curpage=CTools.dealNumber(request.getParameter("curpage"));
ws_id=CTools.dealString(request.getParameter("ws_id")).trim();
us_id=CTools.dealString(request.getParameter("us_id")).trim();
if(OPType.equals("Add"))
{
optype="新增普通用户";
String sql1 = "select * from tb_user,tb_website where tb_user.ws_id=tb_website.ws_id and ws_name='上海浦东'";
String sql2 = "select * from tb_website";
Vector vectorPage1 = dImpl.splitPage(sql1,request,20);
Vector vectorPage2 = dImpl.splitPage(sql2,request,20);
if(vectorPage1!=null)
{
	  for(int i=0;i<vectorPage1.size();i++)
	  {
	    Hashtable content1 = (Hashtable)vectorPage1.get(i);
            names += content1.get("us_uid").toString() +",";
	  }
	  if(!names.equals(""))
		names = "," + names;
}
}
else if(OPType.equals("Edit"))
{
	optype="修改信息";
	String sql="select * from tb_user,tb_website where tb_user.ws_id=tb_website.ws_id and us_id='"+us_id+"'";
	Hashtable content=dImpl.getDataInfo(sql);
	us_name=content.get("us_name").toString();
	us_uid=content.get("us_uid").toString();
	uk_id = content.get("uk_id").toString();
	us_email=content.get("us_email").toString();
	us_tel=content.get("us_tel").toString();
	us_address=content.get("us_address").toString();
	us_password=content.get("us_pwd").toString();
	us_isok=content.get("us_isok").toString();
	us_istemp=content.get("us_istemp").toString();
	us_zip=content.get("us_zip").toString();
	us_idcardnumber=content.get("us_idcardnumber").toString();
	us_cellphonenumber=content.get("us_cellphonenumber").toString();

}
else
{
	optype="普通用户审核";
	String sql="select * from tb_user,tb_website where tb_user.ws_id=tb_website.ws_id and us_isok=0 and us_id='"+us_id+"'";
	Hashtable content=dImpl.getDataInfo(sql);
	us_name=content.get("us_name").toString();
	us_uid=content.get("us_uid").toString();
	uk_id = content.get("uk_id").toString();
	us_email=content.get("us_email").toString();
	us_tel=content.get("us_tel").toString();
	us_address=content.get("us_address").toString();
	us_password=content.get("us_pwd").toString();
	us_isok=content.get("us_isok").toString();
	ws_id=content.get("ws_id").toString();
	ws_name=content.get("ws_name").toString();
	us_istemp=content.get("us_istemp").toString();
	us_zip=content.get("us_zip").toString();
	us_idcardnumber=content.get("us_idcardnumber").toString();
	us_cellphonenumber=content.get("us_cellphonenumber").toString();
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
		alert("用户名不能为空！");
		formData.us_uid.focus();
        return false;
      }
      if (checkSpace(formData.us_uid.value) == true) {
		alert("用户名不能为空！");
		formData.us_uid.focus();
        return false;
      }
      if(formData.us_password.value=="")
      {
		alert("用户密码不能为空！");
		formData.us_password.focus();
        return false;
      }
	  if(formData.us_idcardnumber.value=="")
		{
		alert("身份证号不能为空！");
		formData.us_idcardnumber.focus();
        return false;
		}
      var names = formData.names.value;
      if(names.indexOf(","+formData.us_uid.value+",")>=0)
		{
		  alert("该用户名在本网站内已经被使用，请重新输入用户名！");
		  formData.us_uid.focus();
		  return false;
		}
      document.formData.submit();
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
<form action="UserInfoResult.jsp" method="post" name="formData">
<input type="hidden" name="names" value="<%=names%>">
    <tr>
     <td width="100%">
		<table border="0" width="100%" cellpadding="0" cellspacing="0" class="content-table">
      	<tr>
        	<td width="100%" align="left" valign="top">
	  		<table border="0" width="100%" cellspacing="1" cellpadding="0">
	  	  		 <tr class="line-even">
			  	    	<td width="15%" align="right">用户类型：</td>
				        <td width="85%"><select name="us_type" class="select-a">
									<%
									String sql1="select * from tb_userkind order by uk_sequence ";
									Vector vectorPage1 = dImpl.splitPage(sql1,request,20);
				           				 if(vectorPage1!=null)
									{
									for(int j=0;j<vectorPage1.size();j++)
									{
										Hashtable content1 = (Hashtable)vectorPage1.get(j);
				            				%><option value="<%=content1.get("uk_id").toString()%>" <%
									if(uk_id.equals(content1.get("uk_id").toString()))
									out.print(" selected");
									%>><%=content1.get("uk_name").toString()%></option><%
				            				}}
				        	%></select>
					  	  		</tr>
               <tr class="line-odd">
        			<td width="15%" align="right">注册网站类型：</td>
			        <td width="85%"><select name="ws_id" class="select-a">
					<%
					String sql2 = "select * from tb_website";
					Vector vectorPage2 = dImpl.splitPage(sql2,request,20);
				        if(vectorPage2!=null)
					{
					for(int i=0;i<vectorPage2.size();i++)
					{
					Hashtable content2 = (Hashtable)vectorPage2.get(i);
			            %><option value="<%=content2.get("ws_id").toString()%>"><%=content2.get("ws_name").toString()%></option><%
            				}}
			            %></select>
				     <script language="javascript">
				     	var obj = formData.ws_id;
				     	var length = 1;
				     	if(typeof(obj.options.length)!="undefined") length = obj.options.length;
				     	for(var i=0;i<length;i++)
				     	{
				     		if(obj.options[i].value=="<%=ws_id%>")
				     			{
				     				obj.selectedIndex = i;
				     				break;
				     			}
				     	}
				     </script>
                                </tr>
								<tr class="line-even" >
           				 <td width="19%" align="right">用户姓名：</td>
            				 <td width="81%" ><input type="text" class="text-line" size="20" name="us_name" maxlength="50"  value="<%=us_name%>" ></td>
          			 </tr>
					 <tr class="line-even" >
           				 <td width="19%" align="right">身份证号：</td>
            				 <td width="81%" ><input type="text" class="text-line" size="20" name="us_idcardnumber" maxlength="30"  value="<%=us_idcardnumber%>" >
							 <font color="#FF0000">*</font>
							 </td>
          			 </tr>
		  		<tr class="line-odd">
	  	    		<td width="15%" align="right">用户名：</td>
	  	    		<td width="85%"><input name="us_uid" size="20" class="text-line" value="<%=us_uid%>" maxlength="30" <%="修改信息".equals(optype)?"readonly":""%>>
					<font color="#FF0000">*</font>
					</td>
                                </tr>
		  		<tr class="line-even">
	  	    		<td width="15%" align="right">密码：</td>
	  	    		<td width="85%"><input name="us_password" type="password" size="20" class="text-line" value="<%=us_password%>" maxlength="50">
					<font color="#FF0000">*</font>
					</td>
		                </tr>

                  		<tr class="line-even">
                                <td width="15%" align="right">email：</td>
	  	    		<td width="85%"><input name="us_email" size="20" class="text-line" value="<%=us_email%>" maxlength="50"></td>
	  	  		</tr>
                                <tr class="line-odd">
                                <td width="15%" align="right">用户电话：</td>
	  	    		<td width="85%"><input name="us_tel" size="20" class="text-line" value="<%=us_tel%>" maxlength="21"></td>
	  	  		</tr>
				<tr class="line-even">
                                <td width="15%" align="right">用户地址：</td>
	  	    		<td width="85%"><input name="us_address" size="20" class="text-line" value="<%=us_address%>" maxlength="50"></td>
	  	  		</tr>
				<tr class="line-even">
                                <td width="15%" align="right">邮政编码：</td>
	  	    		<td width="85%"><input name="us_zip" size="20" class="text-line" value="<%=us_zip%>" maxlength="7"></td>
	  	  		</tr>
				<tr class="line-even">
                    <td width="15%" align="right">手机号码:</td>
	  	    		<td width="85%"><input name="us_cellphonenumber" size="20" class="text-line" value="<%=us_cellphonenumber%>" maxlength="21">
					</td>
			 	</tr>
				<tr class="line-odd">
	  	    		<td width="15%" align="right">是否临时用户：</td>
	  	    		<td width="85%">
					<select name="us_istemp" class="select-a">
					<option value="0" <%if(us_istemp.equals("0"))out.print("selected");%>>否</option>
					<option value="1"<%if(us_istemp.equals("1"))out.print("selected");%>>是</option>
					</select>
					</td>
		        </tr>
	  	  		<tr class="line-odd">
	  	    		<td width="15%" align="right">用户是否活动：</td>
	  	    		<td width="85%">
	  	    		<INPUT type="checkbox" class="checkbox1" name="us_active_flag" value="1" <%if(us_isok.equals("1")) out.print("checked");%>>启用帐号
	  	    		</td>
	  	  		</tr>

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
                                     
