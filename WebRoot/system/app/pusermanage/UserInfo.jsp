<%@page contentType="text/html; charset=GBK"%>
<%@include file="/system/app/skin/head.jsp"%>
<%
String us_uid="";
String us_id="";
String OPType="";
String curpage="";
String Audit="";
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

CDataCn dCn = null; //新建数据库连接对象
CDataImpl dImpl = null; //新建数据接口对象
try{
dCn = new CDataCn(); //新建数据库连接对象
dImpl = new CDataImpl(dCn); //新建数据接口对象

us_id=CTools.dealString(request.getParameter("us_id")).trim();
OPType=CTools.dealString(request.getParameter("OPType")).trim();
curpage=CTools.dealNumber(request.getParameter("curpage"));
Audit=CTools.dealString(request.getParameter("audit")).trim();
ws_id=CTools.dealString(request.getParameter("ws_id")).trim();

if(OPType.equals("Add"))
{
optype="新增用户";
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
%>
<%@include file="/system/app/skin/skin4/template/info_top.jsp"%>
<!--    模块名称开始    -->
<%=optype%>
<!--    模块名称结束    -->
<%@include file="/system/app/skin/skin4/template/info_funtion.jsp"%>
<!--    功能按钮开始    -->

<!--    功能按钮结束    -->
<%@include file="/system/app/skin/skin4/template/info_main.jsp"%>
<!--    表单提交开始    -->
<table width="100%" class="main_table">
<tr>
<td>
<form action="UserInfoResult.jsp" method="post" name="formData">
	<table border="0" width="100%" cellpadding="0" cellspacing="0" class="content-table">
      	<tr>
        	<td width="100%" align="left" valign="top">
	  		<table border="0" width="100%" cellspacing="1" cellpadding="0">

	  	  		 <tr class="line-even">
			  	    	<td width="15%" align="right">用户类型：</td>
                        <td width="85%">党务专网用户</td>					
	  	  		</tr>
				<tr class="line-even">
			  	    	<td width="15%" align="right">网站类别：</td>
                        <td width="85%">浦东党务网</td>					
	  	  		</tr>		  		
				<tr class="line-odd">
	  	    		<td width="15%" align="right">用户姓名：</td>
	  	    		<td width="85%"><input name="us_name" size="20" class="text-line" value="<%=us_name%>" maxlength="30">
					
					</td>
                </tr>
				<tr class="line-even">
	  	    		<td width="15%" align="right">用户名：</td>
	  	    		<td width="85%">
					<%
					if(OPType.equals("Edit")){					
					out.println(us_uid);
					out.println("<input name='us_uid' type='hidden' size='20' class='text-line' value=" + us_uid +">" );
					}
					else if(OPType.equals("Add") ){
					out.println("<input name='us_uid' type='text' size='20' class='text-line' value='' maxlength='30'>&nbsp;<font color='#FF0000'>*</font>");					
					}
					%>					
					</td>
         </tr>
				<%
				if (OPType.equals("Add")){
				%>
		  		<tr class="line-odd">
	  	    		<td width="15%" align="right">密码：</td>
	  	    		<td width="85%"><input name="us_password" type="password" size="21" class="text-line" value="<%=us_password%>" maxlength="50">
					<font color="#FF0000">*</font>
					</td>
		        </tr>
				<script>
					function check()
					{
					  if(formData.us_uid.value=="")
					  {
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
					  document.formData.submit();
				   }
				</script>

				<%
				}
				else if(OPType.equals("Edit")){	
				%>
					<tr class="line-odd">
	  	    		<td width="15%" align="right">密码：</td>
	  	    		<td width="85%"><input type="checkbox" id="chkpas" class="text-line" value="0" onclick="showedit(this)">	<input name="us_password" type="password" size="17" class="text-line" value="" style="visibility:hidden" maxlength='50'>				
					</td>
		        </tr>
				 <script>
					function check()
					{
					  if(formData.us_uid.value=="")
					  {
						alert("用户名不能为空！");
						formData.us_uid.focus();
						return false;
					  }
					  if (formData.chkpas.checked){
						  if(formData.us_password.value=="")
						  {
							alert("用户密码不能为空！");
							formData.us_password.focus();
							return false;
						  }
					  }
					  if(formData.us_idcardnumber.value=="")
						{
						alert("身份证号不能为空！");
						formData.us_idcardnumber.focus();
						return false;
						}
					  document.formData.submit();
				   }
				</script>
				<%
				}	
				%>
	  		</table>
        	</td>
      	</tr>	<!-- 根据uk_name取党务专网用户的uk_id的值 -->
      <%
		String sql3 = "";
		String uk_id_type="";
		Hashtable content8=null;
		sql3 = "select uk_id from tb_userkind  where uk_name = '党务专网用户' ";
    content8 = dImpl.getDataInfo(sql3);
		if(content8!=null){
			uk_id_type = content8.get("uk_id").toString();	
		}
		%>
		<tr colspan="2" class="outset-table">
        <td width="100%" align="center">
          <input class="bttn" value="提交" type="button" onclick="check();" size="6" name="btnSubmit">&nbsp;		  
          <input class="bttn" value="重置" type="reset" size="6" >&nbsp;
          <input class="bttn" value="返回" type="button" onclick="history.back();" size="6" >&nbsp;
				  <INPUT TYPE="hidden" name="us_type" value="<%=uk_id_type%>"><!-- o11719 -->
				  <INPUT TYPE="hidden" name="ws_id" value="o32">  <!-- 默认添加“党务网代码” -->
				  <INPUT TYPE="hidden" name="us_idcardnumber" value="123456789">
          <INPUT TYPE="hidden" name="OPType" value="<%=OPType%>">
          <INPUT TYPE="hidden" name="us_id" value="<%=us_id%>">
		  <%
			if (OPType.equals("Edit")){
		  %>
			<INPUT TYPE="hidden" name="pas_flag" value="0">
		  <%
		  }
		  else {
		  %>
			<INPUT TYPE="hidden" name="pas_flag" value="1">
		  <%
          }
		  %>
</form>
</td>
</tr>
</table>
<script>
function showedit(obj){
	if (obj.checked)
	{
		document.all.us_password.style.visibility = "visible";
		formData.pas_flag.value="1";
	}
	else {
		document.all.us_password.style.visibility = "hidden";
		formData.pas_flag.value="0";
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
                                     
