<%
//Update 20061231
User checkLogin = (User)session.getAttribute("user");
if(checkLogin==null||!checkLogin.isLogin())
{
      out.println("<script LANGUAGE='javascript'>");
      out.println("alert('ÇëÄúÏÈµÇÂ¼£¡');");
      out.println("window.location.href=\"/website/login/Login.jsp\"");
      out.println("</script>");
      if (true) return;
}
%>