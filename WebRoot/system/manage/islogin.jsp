<%@page import="com.platform.*" %>
<%//后台不是所有页面都加入了上面这个包,所以在这里加入%>
<%
  CManager manager = (CManager)session.getAttribute("manager");
  if(manager==null || !manager.isLogin())
  {
      out.print("<script LANGUAGE='javascript'>");
      out.print("alert('请您登录！！');");
      out.print("top.location.href='/system/platform';");
      out.print("</script>");
  }
  %>