<%@ page contentType="text/html; charset=GBK" %>
<%@include file="/website/include/head.jsp"%>
<script>
	function query(list_id,node_title)
	{
	var form=Document.formData;
	form.list_id.value=list_id;
	form.node_title.value=node_title;
	form.submit();
	}
</script>
<div align="center">
	<table border="0" width="100%" cellspacing="0" cellpadding="0">
		<tr>
			<td>
				<table border="0" width="100%" cellspacing="0" cellpadding="0">
					<tr>
					<form name="formData" method="post" action="UserList.jsp">
					   <td width="50%" align="left">
						<table width="100%">
						 <tr>
							<td width="100%" align="left"></td>
							<td valign="top" align="right" nowrap>
                                                        <a href="UserInfo.jsp">新增用户</a>
							<a href="">查询用户</a>
							<a href="">删除用户</a>							</td>
						  </tr>
						</table>
					  </td>
					</tr>
				</table>
		   </td>
		</tr>

        <tr>
          <td width="100%" valign="top">
              <table border="0" width="100%" cellspacing="0" cellpadding="0" height="46">
                <tr>
                  <td width="100%" height="32">
					  <table border="0" width="100%" cellpadding="3" height="44">
						<tr>
						    <td width="5%" height="1"></td>
						    <td width="8%" height="1" align="center">用户类型</td>
						    <td width="66%" height="1" align="center">用户名称</td>
						    <td width="30%" height="1" align="center">修改</td>
<input type="hidden" name="list_id" value=1>
<input type="hidden" name="node_title" value=null>
                                                </tr>
<tr><td align=center><input type="checkbox"></input></td>
<td align=center>市民</td>
<td><a href="UserInfo.jsp?us_id=2&list_id=1">关佳</a></td>
<td align=center><a href="UserInfo.jsp?us_id=2&list_id=1">编辑</a></td>
</tr>
<tr><td align=center><input type="checkbox"></input></td>
<td align=center>企业</td>
<td><a href="UserInfo.jsp?us_id=21&list_id=1">上海互联网软件</a></td>
<td align=center><a href="UserInfo.jsp?us_id=21&list_id=1">编辑</a></td>
</tr>
</form>

<script language="javascript">
	function docheck(formname)
	{
	if ( isNaN(formname.strPage.value) )
	{
	alert("转入页面必须为数字！");
	formname.strPage.focus();
	return (false);	}
	if (formname.strPage.value > 1 || formname.strPage.value < 0)
	{
	alert("抱歉！你输入的页数不在查询对象的范围之内，请重新输入。");
	formname.strPage.focus();
	return (false)	}
	return (true)}
	function dopage(strPage)
	{
	document.PageForm.strPage.value = strPage;document.PageForm.submit()
	}
</script>
<table width="100%">
<form action="http://192.168.0.245:8088/system/platform/user/userList.jsp" method="post" name="PageForm" onsubmit="return docheck(this)"><tr><td align="right"><input type="hidden" name="dept21" value="2"><input type="hidden" name="list_id" value="1"><input type="hidden" name="dept2" value="1"><input type="hidden" name="node_title" value="null">共有<span style="color:red">2</span>条匹配记录 <span style="color:silver">第一页</span> <span style="color:silver">上一页</span> <span style="color:silver">下一页</span> <span style="color:silver">最后页</span> 转到第<input style="background:transparent;border:0px solid white;border-bottom:1px solid black" type="normal" name="strPage" size="1">页 页数状态(<span style="color:red">1/1</span>页)&nbsp; </td></tr></form></table>
</table>

		      </td>
			 </tr>
		   </table>
	     </td>
	    </tr>

	</table>
</div>

<%@include file="/website/include/bottom.jsp"%>
