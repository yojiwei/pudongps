<%@page contentType="text/html; charset=GBK"%>
<%@include file="../skin/head.jsp"%>
<script language="javascript">
function checkForm()
{
        var obj = document.formData;
        if (obj.oldPwd.value=="")
        {
                alert("原始密码不能为空！");
                obj.oldPwd.focus();
                return false;
        }
        if (obj.newPwd.value=="")
        {
                alert("新密码不能为空！");
                obj.newPwd.focus();
                return false;
        }
        if (obj.configPwd.value=="")
        {
                alert("密码确认不能为空！");
                obj.configPwd.focus();
                return false;
        }
        if (obj.newPwd.value!=obj.configPwd.value)
        {
                alert("两次输入的密码不相同！");
                return false;
        }
        obj.action = "ConfigResult.jsp";
        obj.submit();
}
</script>
<%
String us_id = "";
String us_uid = "";
String strTitle = "修改密码";
String sqlStr = "";

CMySelf mySelf = (CMySelf)session.getAttribute("mySelf");

if (mySelf!=null)
{
	us_id = Long.toString(mySelf.getMyID());
}
if (!us_id.equals(""))
{
	sqlStr = "select ui_uid from tb_userinfo where ui_id="+us_id;
	//update20080122

CDataCn dCn=null;   //新建数据库连接对象
CDataImpl dImpl=null;  //新建数据接口对象

try {
 dCn = new CDataCn(); 
 dImpl = new CDataImpl(dCn); 

	Hashtable content = dImpl.getDataInfo(sqlStr);
	if (content!=null)
	{
		us_uid = content.get("ui_uid").toString();
	}
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
}
%>
<table class="main-table" width="100%">
<form name="formData" method="post">
	<tr class="title1" width="100%">
		<td colspan="2" align="center"><font size="2"><%=strTitle%></font></td>
	</tr>
	<tr class="line-even" width="100%">
		<td width="15%" align="right">用  户  名</td>
		<td align="left"><input class="text-line" size="20" readonly name="userName" value="<%=us_uid%>"></td>
	</tr>
	<tr class="line-even" width="100%">
		<td width="15%" align="right">原  密  码</td>
		<td align="left"><input type="password" name="oldPwd" class="text-line" size="20" value=""></td>
	</tr>
	<tr class="line-even" width="100%">
		<td width="15%" align="right">新  密  码</td>
		<td align="left"><input type="password" name="newPwd" class="text-line" size="20" value=""></td>
	</tr>
	<tr class="line-even" width="100%">
		<td width="15%" align="right">确认新密码</td>
		<td align="left"><input type="password" name="configPwd" class="text-line" size="20" value=""></td>
	</tr>
	<tr class="title1" width="100%">
		<td colspan="2" align="center">
			<input type="button" name="btnSubmit" value="确认" class="bttn" onclick="checkForm()">&nbsp;
			<input type="button" name="btnCancel" value="取消" class="bttn" onclick="formData.reset()">&nbsp;
		</td>
	</tr>
</form>
</table>

<%@include file="../skin/bottom.jsp"%>