<%@ page contentType="text/html; charset=GBK" %>
<%@include file="/system/platform/islogin.jsp"%>
<%!String dir = "";
   String leftUrl = "";
   String mainUrl = "";
   int purviewLvl =0;
   	String at_managelvl = ""; //后台权限
%>
<%
  CManager manage = (CManager)session.getAttribute("manager");
  if(manage!=null){
  purviewLvl = manage.getPurviewLevel();
  at_managelvl = manage.getManageLvl();
  }
  dir = request.getParameter("dir");
  if (dir == null){
	  if(at_managelvl.indexOf("1") != -1){
		  leftUrl = "user/menu.jsp";
		  mainUrl = "user/userList.jsp";
	  }else if(at_managelvl.indexOf("2") != -1){
		  leftUrl = "meta/menu.jsp";
		  mainUrl = "meta/metaList.jsp";
	  }else if(at_managelvl.indexOf("3") != -1){
		  leftUrl = "role/menu.jsp";
		  mainUrl = "role/roleList.jsp";
	  }else if(at_managelvl.indexOf("4") != -1){
		  leftUrl = "module/menu.jsp";
		  mainUrl = "module/moduleList.jsp";
	  }else if(at_managelvl.indexOf("5") != -1){
		  leftUrl = "parameter/menu.jsp";
		  mainUrl = "parameter/parameterList.jsp";
	  }else if(at_managelvl.indexOf("6") != -1){
		  leftUrl = "log/menu.jsp";
		  mainUrl = "log/logList.jsp";
	  }
  }else{
    leftUrl = dir + "/menu.jsp";
    mainUrl = dir + "/" + dir + "List.jsp";
  }
  //out.print(leftUrl);
  //out.close();
%>
<html>
<head>
<link REL="SHORTCUT ICON" href="http://beyondbit/oa20/ACTIVITL.ICO">
<title>系统管理界面</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
</head>

<frameset rows="56,1*" cols="*" border="2" framespacing="2">
  <frame name="baner" scrolling="NO" noresize src="top.jsp">
  <frameset id=frmWnd cols="25%,*" frameborder="NO" border="0" framespacing="0">
    <frame name="left" noresize src="<%=leftUrl%>" scrolling=auto>
    <frame name="main" marginwidth="0" src="<%=mainUrl%>">
  </frameset>
</frameset>
<noframes><body bgcolor="#FFFFFF"></noframes>
</body>
</html>