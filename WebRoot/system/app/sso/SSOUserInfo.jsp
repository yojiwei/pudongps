<%@page contentType="text/html; charset=GBK"%>
<%@include file="/system/app/skin/head.jsp"%>
<script LANGUAGE="javascript">
function checkform(rd)
{
	var form = document.formData ;
	if(form.ui_uid.value=="")
	{
		alert("请填写浦东用户！");
		form.ui_uid.focus();
		return false;
	}
	if(form.us_sso.value=="")
	{
		alert("请填写单点登录用户！");
		form.us_sso.focus();
		return false;
	}
	form.action = "SSOUserResult.jsp?rd="+rd;
	form.submit();
}
</script>
<%
//update by 20090429
CDataCn dCn = null;
CDataImpl dImpl = null;
try{
dCn = new CDataCn();
dImpl = new CDataImpl(dCn);
//
String Isactivity = "";
String Isactivity1 = "";
String sql="";
String OPType="";//操作方式 Add是添加 Edit是修改

String us_id = "";

String us_sso = "";
String ui_id = "";
String ui_uid = "";
String ui_name = "";

/*得到上一个页面传过来的参数  开始*/
us_id = CTools.dealString(request.getParameter("us_id")).trim();
OPType = CTools.dealString(request.getParameter("OPType")).trim();//如果是编辑情况

if (OPType.equals("Edit")||OPType.equals("Check"))
{
	Isactivity = " class='text-line'";

	sql = "select s.us_id,s.us_sso,s.ui_id,i.ui_uid,i.ui_name from tb_userinfo i,tb_usersso s where i.ui_id = s.ui_id and s.us_id = " + us_id;
	//out.println(sql);
	Hashtable content=dImpl.getDataInfo(sql);
	if(content != null)
	{
		us_id=CTools.dealNull(content.get("us_id"));
		us_sso=CTools.dealNull(content.get("us_sso"));
		ui_id=CTools.dealNull(content.get("ui_id"));
		ui_uid = CTools.dealNull(content.get("ui_uid"));
	}
}
else
{
	Isactivity = "class='text-line'";
}

if(OPType.equals("Check"))
{
	Isactivity = Isactivity + " readonly";
	Isactivity1 = " disabled";
}

com.app.CMySelf ms = new com.app.CMySelf();
ms = (com.app.CMySelf)session.getAttribute("mySelf");
long myId = ms.getMyID();
String userId = ms.getMyUid();
%>
<%@include file="/system/app/skin/skin4/template/info_top.jsp"%>
<!--    模块名称开始    -->
单点登录
<!--    模块名称结束    -->
<%@include file="/system/app/skin/skin4/template/info_funtion.jsp"%>
<!--    功能按钮开始    -->

<!--    功能按钮结束    -->
<%@include file="/system/app/skin/skin4/template/info_main.jsp"%>
<!--    表单提交开始    -->
<table WIDTH="100%" CELLPADDING="0" cellspacing="0" BORDER="0">
<form name="formData" method="post">
	<tr>
		<td width="100%">
			<table width="100%" class="content-table" height="1">
				<tr class="line-odd" >
					<td width="15%" align="right">浦东用户</td>
					<td width="35%" colspan="3" align="left"><input type="text" size="50" name="ui_uid" maxlength="150" value="<%=ui_uid%>" <%=Isactivity%>>
					</td>
				</tr>
				<tr class="line-odd" >
					<td width="15%" align="right">统一授权用户（用户名）</td>
					<td width="35%" colspan="3" align="left"><input type="text" size="50" name="us_sso" maxlength="150" value="<%=us_sso%>" <%=Isactivity%>>
					</td>
				</tr>
				<tr height="30" class="line-odd">
					<td colspan="4" align="middle">
					<%
					if(OPType.equals("Addnew"))
					{
					%>
						<input type="button" class="bttn" name="fsubmit" value="保存并返回列表" onclick="javascript:checkform(0)">&nbsp;
						<input type="reset" class="bttn" name="reset" value="重 写">&nbsp;
						<input type="button" class="bttn" name="back" value="返 回" onclick="javascript:history.back();">
					<%
					}
					else if(OPType.equals("Edit"))
					{
					%>
						<input type="button" class="bttn" name="fsubmit" value="保存并返回列表" onclick="javascript:checkform(0)">&nbsp;
						<input type="button" class="bttn" name="del" value="删 除" onclick="javascript:if(confirm('真的要删除吗？')){self.location='SSOUserDel.jsp?us_id=<%=us_id%>';}">&nbsp;
						<input type="reset" class="bttn" name="reset" value="重 写">&nbsp;
						<input type="button" class="bttn" name="back" value="返 回" onclick="javascript:history.back();">
					<%
					}
					else if(OPType.equals("Check"))
					{
					%>
						<input type="button" class="bttn" name="back" value="返 回" onclick="javascript:history.back();">
					<%}%>
					</td>
				</tr>
				<INPUT TYPE="hidden" name="us_id" value="<%=us_id%>">
				<INPUT TYPE="hidden" name="OPType" value="<%=OPType%>">
			</table>
		</td>
	</tr>
</form>
<form name="formData1" method="post" >
<INPUT TYPE="hidden" name="us_id" value="<%=us_id%>">
<INPUT TYPE="hidden" name="OPType" value="<%=OPType%>">
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
                                     
