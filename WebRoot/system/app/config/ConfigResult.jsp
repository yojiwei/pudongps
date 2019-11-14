<%@page contentType="text/html; charset=GBK"%>
<%@include file="../skin/import.jsp"%>
<%
String us_id = "";
String userName = "";
String userPwd = "";
String newPwd = "";
String sqlStr = "";

userName = CTools.dealString(request.getParameter("userName")).trim();
userPwd = CTools.dealString(request.getParameter("oldPwd")).trim();
newPwd = CTools.dealString(request.getParameter("newPwd")).trim();

//update20080122

CDataCn dCn=null;   //新建数据库连接对象
CDataImpl dImpl=null;  //新建数据接口对象

try {
 dCn = new CDataCn(); 
 dImpl = new CDataImpl(dCn); 


if (!(userName.equals("")||userPwd.equals("")))
{
	sqlStr = "select ui_id,ui_uid,ui_password from tb_userinfo where ui_uid='"+userName+"'";
	Hashtable content = dImpl.getDataInfo(sqlStr);
	if (content!=null)
	{
		String ui_pwd = content.get("ui_password").toString();
		String ui_uid = content.get("ui_uid").toString();
		us_id = content.get("ui_id").toString();
		//解密过程开始
		ui_pwd = SecurityTest.decode(ui_pwd);
		byte[] bt = new sun.misc.BASE64Decoder().decodeBuffer(ui_pwd);
		ui_pwd = new String(bt);
		//解密过程结束
		if (!ui_uid.equals(userName))
		{
			%>
			<script language="javascript">
			alert("用户名错误！");
			window.history.go(-1);
			</script>
			<%
			out.close();
		}
		else if (!ui_pwd.equals(userPwd))
		{
			%>
			<script language="javascript">
			alert("原始密码错误！");
			window.history.go(-1);
			</script>
			<%
			out.close();
		}
		else if (!us_id.equals(""))
		{
			//加密过程开始
			newPwd = new sun.misc.BASE64Encoder().encode(newPwd.getBytes());
			newPwd = SecurityTest.encode(newPwd);
			//加密过程结束
			dCn.beginTrans();
			dImpl.edit("tb_userinfo","ui_id",us_id);
			dImpl.setValue("ui_password",newPwd,CDataImpl.STRING);
			dImpl.update();
			if (dCn.getLastErrString().equals(""))
			{
				dCn.commitTrans();
						%>
						<script language="javascript">
						alert("更新成功！");
						window.history.go(-1);
						</script>
				<%
			}
			else
			{
				dCn.rollbackTrans();
						out.print(dCn.getLastErrString());
				%>
				<script language="javascript">
				alert("发生未知错误，密码更改没有成功！");
				window.history.go(-1);
				</script>
				<%
			}
		}
	}
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
%>