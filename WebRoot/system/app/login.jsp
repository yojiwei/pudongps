<%@page contentType="text/html; charset=GBK"%>
<%@include file="/system/app/skin/import.jsp"%>
<%
CDataCn dCn = null;
CMySelf mySelf = null;
try{
	dCn = new CDataCn();
   mySelf = new CMySelf(dCn);
String uid = CTools.dealString(request.getParameter("UI_name")).trim();
       uid = uid.toLowerCase();
String pwd = CTools.dealString(request.getParameter("UI_password")).trim();
if(uid.indexOf("'")>=0||uid.indexOf("=")>=0)
{
%>
  <script language="javascript">
  alert("您的输入包含非法字符！");
  window.location="/system/app/index.jsp"; 
	</script>
<%
}
if(pwd.indexOf("'")>=0||pwd.indexOf("=")>=0)
{
%>
  <script language="javascript">
  alert("您的输入包含非法字符！");
  window.location="/system/app/index.jsp"; 
	</script>
<%
}
String applySkin2 = CTools.dealString(request.getParameter("applySkin2")).trim();
String applySkin3 = CTools.dealString(request.getParameter("applySkin3")).trim();
String rand = (String)session.getAttribute("rand");
String input = request.getParameter("rand");
if (rand.equals(input))
{
session.setAttribute("_InfoSubject","");
boolean b = mySelf.login(uid,pwd);

if(b == true) {
  session.setAttribute("mySelf",mySelf);
  if(applySkin2.equals("true"))
  {
    session.setAttribute("skin","2");
    response.sendRedirect("skin/skin2/default.jsp");
  }
  //update by yao 20081215
  if(applySkin3.equals("true"))
  {
    //session.setAttribute("skin","3");
    //response.sendRedirect("skin/skin3/default.jsp");
    session.setAttribute("skin","4");
    response.sendRedirect("skin/skin4/default.jsp");
  }
  else
  {
    session.setAttribute("skin","1");
    response.sendRedirect("/system/app/frame.jsp");
  }
} else {
  session.removeAttribute("mySelf"); //清除变量
%>
  <script language="javascript">
  alert("用户名或密码错误！");
  window.location="/system/app/index.jsp"; 
	</script>
<%
}
}
else {
	  session.removeAttribute("mySelf"); //清除变量
%>
  <script language="javascript">
  alert("验证码输入有误,请重新输入！");
  window.location="/system/app/skin/skin3/login.jsp";
	</script>
<%
	//out.println(rand + "输入" + input);
}

mySelf.closeStmt();
dCn.closeCn();
} catch (Exception ex) {
	System.out.println(new java.util.Date() + "--"
			+ request.getServletPath() + " : " + ex.getMessage());
} finally {
	if(mySelf != null)
	mySelf.closeStmt();
	if(dCn != null)
	dCn.closeCn();
}
%>