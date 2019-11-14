<%@ page contentType="text/html; charset=GBK" %>
<%@include file="/website/include/head.jsp"%>
<%
//update20080122

CDataCn dCn=null;   //新建数据库连接对象
CDataImpl dImpl=null;  //新建数据接口对象

try {
 dCn = new CDataCn(); 
 dImpl = new CDataImpl(dCn); 


String sql="select uk_id,uk_name from tb_userkind";
Vector vectorPage = dImpl.splitPage(sql,request,1000);
%>

<script>
    function check()
    {
      if(formData.us_name.value=="")
      {
	alert("用户名不能为空！");
	form.user_name.focus();
        return false;
      }
      document.formData.submit();
   }
</script>

<table width="100%">
<tr>
<td>
<form action="UserInfoResult.jsp" method="post" name="formData">
<div align="center">
    <table border="0" width="100%" cellpadding="0" cellspacing="0">
	  <tr>
	   <td width="100%" align="left" colspan="4">
		 <table width="100%" cellpadding="3" cellspacing="0">
		  <tr height="4">
			<td width="100%" align="left">新增用户:</td>
		  </tr>
		</table>
	   </td>
	  </tr>
      <tr>
        <td width="100%" align="left" valign="top">
	  	<table border="0" width="100%" cellspacing="1" cellpadding="0">
	  	  <tr>
	  	    <td width="15%" align="center">用户姓名：</td>
	  	    <td width="85%">
			<input name="us_name" size="20" value="" maxlength="20">
                    </td>
	  	  </tr>
	  	  <tr>
	  	    <td width="15%" align="center">用户类型：</td>
	  	    <td width="85%"><select name="us_type">
<%
            if(vectorPage!=null)
	{
	for(int j=0;j<vectorPage.size();j++)
	{
		Hashtable content1 = (Hashtable)vectorPage.get(j);
            %><option value="<%=content1.get("uk_id").toString()%>"><%=content1.get("uk_name").toString()%></option><%
            }}
            %></select>
	  	  </tr>
		  <tr>
	  	    <td width="15%" align="center">用户email：</td>
	  	    <td width="85%"><input name="us_email" size="20" value="" maxlength="30"></td>
	  	  </tr>
		  <tr>
	  	    <td width="15%" align="center">用户地址：</td>
	  	    <td width="85%"><input name="us_addr" size="20" value="" maxlength="50"></td>
	  	  </tr>
                  <tr>
	  	    <td width="15%" align="center">用户电话：</td>
	  	    <td width="85%"><input name="us_tel" size="20" value="" maxlength="20"></td>
	  	  </tr>
	  	  <tr>
	  	    <td width="15%" align="center">用户是否活动：</td>
	  	    <td width="85%">
	  	    <INPUT type="radio"  name=us_active_flag value=1 >是
	  	    <INPUT type="radio"  name=us_active_flag value=0 checked>否
	  	    </td>
	  	  </tr>

	  	</table>
        </td>
      </tr>
      <tr colspan="2">
        <td width="100%" align="center">
          <input value="提交" type="button" onclick="check();" size="6" name="btnSubmit">&nbsp;
          <INPUT TYPE="hidden" name="OPType" value="Add">
          <input value="返回" type="button" onclick="history.back();" size="6" >&nbsp;
        </td>
      </tr>
    </table>
</div>
<input type="hidden" name="us_id" value="0">
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
<%@include file="/website/include/bottom.jsp"%>
