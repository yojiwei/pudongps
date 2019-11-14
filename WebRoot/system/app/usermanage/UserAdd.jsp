<%@ page contentType="text/html; charset=GBK" %>
<%@include file="../skin/head.jsp"%>

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
String us_idcardnumber="";

//update20080122

CDataCn dCn=null;   //新建数据库连接对象
CDataImpl dImpl=null;  //新建数据接口对象

try {
 dCn = new CDataCn(); 
 dImpl = new CDataImpl(dCn); 

us_id=CTools.dealString(request.getParameter("us_id")).trim();
OPType=CTools.dealString(request.getParameter("OPType")).trim();
curpage=CTools.dealNumber(request.getParameter("curpage"));
Audit=CTools.dealString(request.getParameter("audit")).trim();
ws_id=CTools.dealString(request.getParameter("ws_id")).trim();

if(OPType.equals("Add"))
{
optype="新增用户";
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
}
else
{
optype="用户审核";
String sql="select * from tb_user,tb_website where tb_user.ws_id=tb_website.ws_id and us_isok=0 and us_id='"+us_id+"'";
//out.println(sql);
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
}
%>

<script>
    function check(rt)
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
      var names = formData.names.value;
      if(names.indexOf(","+formData.us_uid.value+",")>=0)
		{
		  alert("该用户名在本网站内已经被使用，请重新输入用户名！");
		  formData.us_uid.focus();
		  return false;
		}
  formData.action = "UserAddResult.jsp?rt="+rt;
  formData.target = "_self";

      document.formData.submit();
   }
</script>

<table width="100%" class="main_table">
<tr>
<td>
<form method="post" name="formData">
<input type="hidden" name="names" value="<%=names%>">
    <tr class="title1" align=center>
      	<td><%=optype%></td>
    </tr>
    <tr>
     <td width="100%">
	<table border="0" width="100%" cellpadding="0" cellspacing="0" class="content-table">
      	<tr>
        	<td width="100%" align="left" valign="top">
	  		<table border="0" width="100%" cellspacing="1" cellpadding="0">
	  	 		 <tr class="line-even" >
           				 <td width="19%" align="right">用户姓名：</td>
            				 <td width="81%" ><input type="text" class="text-line" size="45" name="us_name" maxlength="150"  value="<%=us_name%>" ></td>
          			 </tr>
	  	  		 <tr class="line-odd">
			  	    	<td width="15%" align="right">用户类型：</td>
                                        <td width="85%"><select name="us_type" class="select-a">
					<%
					String sql1="select * from tb_userkind";
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
                                <tr class="line-even">
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
		  		<tr class="line-odd">
	  	    		<td width="15%" align="right">用户名：</td>
	  	    		<td width="85%"><input name="us_uid" size="20" class="text-line" value="<%=us_uid%>" maxlength="30">
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
	  	    		<td width="15%" align="right">身份证号：</td>
	  	    		<td width="85%"><input name="us_idcardnumber" type="text" size="20" class="text-line" value="<%=us_idcardnumber%>" maxlength="50">
					<font color="#FF0000">*</font>
					</td>
		                </tr>
                  		<tr class="line-odd">
                                <td width="15%" align="right">email:</td>
	  	    		<td width="85%"><input name="us_email" size="20" class="text-line" value="<%=us_address%>" maxlength="50"></td>
	  	  		</tr>
				<tr class="line-even">
	  	    		<td width="15%" align="right">是否临时用户：</td>
	  	    		<td width="85%">
					<select name="us_istemp" class="select-a">
					<%
						String userSql="select * from tb_user";
						Vector vectorUser=dImpl.splitPage(userSql,request,20);
						if(vectorUser!=null)
						{
							for(int i=0;i<vectorUser.size();i++)
							{
								Hashtable contUser=(Hashtable)vectorUser.get(i);
							}
						}
					%>
					<option value="<%=contUser.get("us_istemp")%>" <%
					if(us_istemp.equals(contUser.get("us_istemp").toString))
					out.print("selected");
					%>>
					<%
					if(contUsr.get("us_istemp").equals("0"))
					out.println("否");
					else out.println("是");
					%>
					</td>
		        </tr>
                  		<tr class="line-odd">
                                <td width="15%" align="right">email:</td>
	  	    		<td width="85%"><input name="us_email" size="20" class="text-line" value="<%=us_address%>" maxlength="50"></td>
	  	  		</tr>
                                <tr class="line-even">
                                <td width="15%" align="right">用户电话：</td>
	  	    		<td width="85%"><input name="us_tel" size="20" class="text-line" value="<%=us_tel%>" maxlength="40"></td>
	  	  		</tr>
				<tr class="line-odd">
                                <td width="15%" align="right">用户地址：</td>
	  	    		<td width="85%"><input name="us_address" size="20" class="text-line" value="<%=us_tel%>" maxlength="50"></td>
	  	  		</tr>
	  	  		<tr class="line-even">
	  	    		<td width="15%" align="right">用户是否活动：</td>
	  	    		<td width="85%">
	  	    		<INPUT type="checkbox" class="checkbox1" name="us_active_flag" value="1" <%if(us_isok.equals("1")) out.print("checked");%>>启用帐号
	  	    		</td>
	  	  		</tr>

	  		</table>
        	</td>
      	</tr>
      	<tr colspan="2" class="title1">
        <td width="100%" align="center">
          <input class="bttn" value="提交并继续添加" type="button" onclick="check(0);" size="6" name="btnAdd">&nbsp;
          <input class="bttn" value="提交并返回用户列表" type="button" onclick="check(1);" size="6" name="btnReturn">&nbsp;
          <INPUT TYPE="hidden" name="OPType" value="<%=OPType%>">
          <INPUT TYPE="hidden" name="us_id" value="<%=us_id%>">
          <input class="bttn" value="返回" type="button" onclick="history.back();" size="6" >&nbsp;
        </td>
      </tr>
    </table>
    </td>
  </tr>
</form>
</td>
</tr>
</table>
<%
dImpl.closeStmt();
dCn.closeCn();
} catch (Exception ex) {
	System.out.println(new java.util.Date() + "--"
			+ request.getServletPath() + " : " + ex.getMessage());
} finally {
	if(dImpl != null)
	dImpl.closeStmt();
	if(dCn != null)
	dCn.closeCn();
}
%>
<%@include file="../skin/bottom.jsp"%>
