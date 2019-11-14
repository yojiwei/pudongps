<%@page contentType="text/html; charset=GBK"%>
<%@include file="/system/app/skin/head.jsp"%>
<script LANGUAGE="javascript">
function check()
{
	if(formData.ty_name.value =="")
	{
		alert("填写名称！");
		return false;
	}
	if(formData.ty_code.value =="")
	{
		alert("填写权限代码！");
		return false;
	}
	formData.action="voteDirInfoResult.jsp?OType=add";
	formData.submit();
	return true;
}
function editcheck(ty_id)
{
	if(formData.ty_name.value =="")
	{
		alert("填写名称！");
		return false;
	}
	if(formData.ty_code.value =="")
	{
		alert("填写权限代码！");
		return false;
	}
	formData.action="voteDirInfoResult.jsp?OType=edit&ty_id="+ty_id+"";
	formData.submit();
	return true;
}
function del(ty_id)
{
	y = confirm("确认要删除吗！");
	if(y){
	formData.action="voteDirDel.jsp?ty_id="+ty_id+"";
	formData.submit();
	}
}
</script>
<%
//update20080122
CDataCn dCn=null;   //新建数据库连接对象
CDataImpl dImpl=null;  //新建数据接口对象
try {
  dCn = new CDataCn(); 
  dImpl = new CDataImpl(dCn); 
	String OType = CTools.dealString(request.getParameter("OType")).trim();
	String ty_id = "";
	String ty_name = "" ;
	String ty_code = "" ;
	if("edit".equals(OType))
	{
		ty_id = CTools.dealString(request.getParameter("ty_id")).trim();
		String strSql = "select ty_id,ty_name,ty_code from tb_votetype where ty_id='"+ty_id+"'";
		Hashtable content = dImpl.getDataInfo(strSql);
		if(content!=null){
		ty_name = content.get("ty_name").toString();
		ty_code = content.get("ty_code").toString();
	}
}
%>

<%@include file="/system/app/skin/skin4/template/info_top.jsp"%>
<!--    模块名称开始    -->
投票类别管理
<!--    模块名称结束    -->
<%@include file="/system/app/skin/skin4/template/info_funtion.jsp"%>
<!--    功能按钮开始    -->

<!--    功能按钮结束    -->
<%@include file="/system/app/skin/skin4/template/info_main.jsp"%>
<!--    表单提交开始    -->
<table WIDTH="100%" CELLPADDING="0" cellspacing="0" BORDER="0">
<form  method="post" name="formData">
<div align="center">
 <tr>
  <td width="100%">
    <table border="0" width="100%" cellpadding="0" cellspacing="0">
      <tr>
        <td width="100%" align="left" valign="top">
	  		<table border="0" width="100%" cellspacing="1" cellpadding="0">
	  		  <tr class="line-odd">
	  		    <td width="15%" align="right">名称：</td>
	  		    <td width="85%" align="left"><input type="text" class="text-line" size="20" name="ty_name" value="<%=ty_name%>"></font></td>
	  		  </tr>
	  		  <tr class="line-even">
	  		    <td width="15%" align="right">代码：</td>
	  		    <td width="85%" align="left">
	  		    	<input type="text" name="ty_code" value="<%=ty_code%>" class="text-line">
	  		    </td>
	  		  </tr>
			</table>
		</td>
	  </tr>
	  <tr class="outset-table">
	    <td width="100%" align="center" colspan="4">
	  		<%if("add".equals(OType))
						out.print("<input class='bttn' value='提交' type='button' onclick='check()' size='6'>");
					if("edit".equals(OType)) 
					{
						out.print("<input class='bttn' value='修改' type='button' onclick=\"editcheck('"+ty_id+"')\" size='6'>&nbsp;");
						out.print("<input class='bttn' value='删除' type='button' onclick=\"del('"+ty_id+"')\" size='6'>");
					}
				%>
	  		<input class='bttn' value='返回' type='button' onclick='history.back();' size='6' name='button3'>&nbsp;
	    </td>
      </tr>
	</table>
</div>
</td>
</tr>
</form>
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
                                     
