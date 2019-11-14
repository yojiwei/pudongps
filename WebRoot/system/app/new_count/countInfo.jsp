<%@page contentType="text/html; charset=GBK"%>
<%String strTitle="计数器" ;%>
<%@include file="../skin/head.jsp"%>
<br>
<body>
<%
	String co_name = "";
	String co_webname = "";
    String co_showflag = "1";
	String actiontype="add";
	String co_id="";
	CDataCn dCn = null;
	CDataImpl dImpl = null;
	try{
	dCn = new CDataCn();
    dImpl = new CDataImpl(dCn);
%>
<%
	
	co_id=CTools.dealString(request.getParameter("co_id"));
if(!co_id.equals(""))
{
	String sql="select * from tb_count where co_id='"+co_id+"'";
	//out.println(sql);
	Vector vectorPage = dImpl.splitPage(sql,request,100);
	if(vectorPage!=null)
		{
			actiontype="modify";
            for(int j=0;j<vectorPage.size();j++)
            {
             Hashtable content = (Hashtable)vectorPage.get(j);
             co_webname = content.get("co_webname").toString();
			 co_name = content.get("co_name").toString();
			 co_showflag = content.get("co_showflag").toString();
			}
		}
}
%>
<table class="main-table" width="100%">
<form action="countResult.jsp?co_id=<%=co_id%>" method="post"  onsubmit="return check(this)">
<tr class="title1" align=center>
 <td colspan="2">新增</td>
</tr>
<tr class="line-even">
 <td width="200" align="center">网站名称</td><td><div align="left"><input type="text" size="20" name="co_webname"  value="<%=co_webname%>" class="text-line"><font color="red">&nbsp;*</font></div></td>
</tr>
<tr class="line-even">
 <td width="200" align="center">权限代码</td><td><div align="left"><input type="text" size="20" name="co_name" value="<%=co_name%>" class="text-line"><font color="red">&nbsp;*</font></div></td>
</tr>
<tr class="line-even">
<%
	if(co_showflag.equals("1"))
	{
%>
	<td width="200" align="center">前台是否显示</td><td><div align="left">
				<input type="radio" name="sing" value="是" checked>
				是 　 
				<input type="radio" name="sing" value="否" >
				否</div></td>
<%
	}
else{
%>
	<td width="200" align="center">前台是否显示</td><td><div align="left">
					<input type="radio" name="sing" value="是">
					是 　 
					<input type="radio" name="sing" value="否" checked>
					否</div></td>
<%
	}
%>
	</tr>
<!--tr class="line-even">
 <td width="200" align="center">设置计数器数量：</td><td><div align="left"><input type="text" size="20" name="co_number" class="text-line"></div></td>
</tr-->
<script language="javascript">
	function check(form)
	{
	   if(form.co_webname.value.replace(/^\s+|\s+$/g,"")=="" )
	   //if(form.bbsuser.value.trim()"" || form.bbsuser.value.length < 6)
		 {
			  alert("网站名不能为空！");
			  form.co_webname.focus();
			  return false;
		 } 
		if (form.co_name.value.replace(/^\s+|\s+$/g,"")=="")
    	{
    		alert("请填写权限代码！");
    		form.co_name.focus();
    		return false;
  		}		
		return true;
	}
</script>
<tr class="title1" align="center">
	<td colspan="2">
	<input type="submit" value="提交" class="bttn" >
	&nbsp;
	<input type="reset"  value="重填" class="bttn">
	<input type=hidden name=actiontype value=<%=actiontype%>>
	</td>
</tr>
</form>
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
<%@include file="/system/app/skin/bottom.jsp"%>
</body>


