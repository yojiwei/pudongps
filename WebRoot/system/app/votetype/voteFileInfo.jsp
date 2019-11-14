<%@page contentType="text/html; charset=GBK"%>
<%@include file="/system/app/skin/head.jsp"%>
<script LANGUAGE="javascript">
function check(ty_id)
{
	if(formData.vd_value.value =="")
	{
		alert("填写名称！");
		return false;
	}
	if(formData.vd_code.value =="")
	{
		alert("填写权限代码！");
		return false;
	}
    if(formData.vd_disimage.value =="")
	{
		alert("选择是否显示图片！");
		return false;
	}
	formData.action="voteFileInfoResult.jsp?OType=add&ty_id="+ty_id+"";
	formData.submit();
	return true;
}
function editcheck(ty_id,vd_id)
{
	if(formData.vd_value.value =="")
	{
		alert("填写名称！");
		return false;
	}
	if(formData.vd_code.value =="")
	{
		alert("填写权限代码！");
		return false;
	}
	formData.action="voteFileInfoResult.jsp?OType=edit&ty_id="+ty_id+"&vd_id="+vd_id+"";
	formData.submit();
	return true;
}
function del(vd_id,ty_id)
{
	y = confirm("确认要删除吗！");
	if(y){
	formData.action="voteFileDel.jsp?vd_id="+vd_id+"&ty_id="+ty_id+"";
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
String vd_value = "" ;
String vd_code = "" ;
String vd_id = "";
String vd_number = "";
String vd_disimage = "";
ty_id = CTools.dealString(request.getParameter("ty_id")).trim();
if("edit".equals(OType))
{
	vd_id = CTools.dealString(request.getParameter("vd_id")).trim();
	String strSql = "select vd_id,vd_value,vd_code,vd_disimage,vd_number from tb_votetypedata where vd_id='"+vd_id+"'";
	Hashtable content = dImpl.getDataInfo(strSql);
	if(content!=null){
	vd_value = content.get("vd_value").toString();
	vd_code = content.get("vd_code").toString();
	vd_number = content.get("vd_number").toString();
	vd_disimage = content.get("vd_disimage").toString();
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
	  		    <td width="85%" align="left"><input type="text" class="text-line" size="20" name="vd_value" value="<%=vd_value%>"></font></td>
	  		  </tr>
	  		  <tr class="line-even">
	  		    <td width="15%" align="right">代码：</td>
	  		    <td width="85%" align="left">
	  		    	<input type="text" name="vd_code" value="<%=vd_code%>" class="text-line">
	  		    </td>
	  		  </tr>
			  <tr class="line-even">
	  		    <td width="15%" align="right">最大投票数：</td>
	  		    <td width="85%" align="left">
	  		    	<input type="text" name="vd_number" value="<%=vd_number%>" class="text-line" size="4">
	  		    </td>
	  		  </tr>
			  <tr class="line-even">
	  		    <td width="15%" align="right">是否显示照片：</td>
	  		    <td width="85%" align="left">是
	  		    	<input type="radio" name="vd_disimage" value="1" class="text-line"<%="1".equals(vd_disimage)||"".equals(vd_disimage)?"checked":""%>>&nbsp;&nbsp;
                    否<input type="radio" name="vd_disimage" value="2" class="text-line" <%="2".equals(vd_disimage)?"checked":""%>>
	  		    </td>
	  		  </tr>
			</table>
		</td>
	  </tr>
	  <tr class="outset-table">
	    <td width="100%" align="center" colspan="4">

	  		<%if("add".equals(OType))
			out.print("<input class='bttn' value='提交' type='button' onclick=\"check('"+ty_id+"')\" size='6'>");
			%>
			<%if("edit".equals(OType)) 
			{
			out.print("<input class='bttn' value='修改' type='button' onclick=\"editcheck('"+ty_id+"','"+vd_id+"')\" size='6'>&nbsp;");
			out.print("<input class='bttn' value='删除' type='button' onclick=\"del('"+vd_id+"','"+ty_id+"')\" size='6'>");
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
                                     
