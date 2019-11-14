<%@ page contentType="text/html; charset=GBK" %>
<%@include file="/system/platform/islogin.jsp"%>
<html>
<head>
<link href="style.css" rel="stylesheet" type="text/css">

<SCRIPT LANGUAGE=javascript>
<!--
        function changeMenu(dir)
        {

        var leftUrl,mainUrl;
        if (dir == "")
                {
                        leftUrl = "user/menu.jsp";
                        mainUrl = "user/userList.jsp";
                }
        else
                {
                        leftUrl = dir + "/menu.jsp";
                        mainUrl = dir + "/" + dir + "List.jsp";
                }
                top.main.navigate(mainUrl);
                top.left.navigate(leftUrl);

        }
//-->
</SCRIPT>
</head>
<%!
	int purviewLvl =0;
	String userName = "";
	String messagePrint = "";
	String at_managelvl = ""; //后台权限
%>
<%
	CManager manage = (CManager)session.getAttribute("manager");
	purviewLvl = manage.getPurviewLevel();
	userName = manage.getLoginName();
	System.out.println("--------------------------------------");
	at_managelvl = manage.getManageLvl();
	messagePrint = userName + ",欢迎您!";
%>
<body>

<!--
<OBJECT  WIDTH = 1 HEIGHT=1
    ID="RemoveIEToolbar"
    CLASSID="CLSID:2646205B-878C-11d1-B07C-0000C040BCDB"    codebase="../../dll/nskey.dll" VIEWASTEXT>
         <PARAM NAME=ToolBar VALUE=0>
  </OBJECT>
-->
<table height="1" cellSpacing="0" cellPadding="0" width="100%" border="0">
  <tbody>
    <tr>
      <td vAlign="top" noWrap align="right" width="180" height="1" rowSpan="3"><IMG alt=""
      border=0 src="images/sysLogo.gif" style="LEFT: -1px; TOP: 0px" width="180" height="53"></td>
      <td width="20" height="34">　</td>
      <td vAlign="baseline" align="right" height="34"><img src="images/title.gif" border="0" width="198" height="34"></td>
      <td style="BORDER-BOTTOM: white 1px solid" vAlign="baseline" align="right" background="images/tb.gif" height="34">
        <table height="1" cellSpacing="0" cellPadding="0" width="100%" align="right" bgColor="#9fb7c0" border="0" valign="top">
          <tbody>
            <tr>
              <td align="right" width="9" background="images/tb.gif" height="1"><img src="images/l1.gif" align="top" border="0" width="20" height="20"></td>
              <td style="BORDER-TOP: black 1px solid" vAlign="bottom"><marquee style="WIDTH: 300px; BORDER-BOTTOM: 1px solid">
<%= messagePrint%>
</marquee>
</td>
            </tr>
          </tbody>
        </table>
      </td>
    </tr>
    <tr>
      <td noWrap borderColorLight="#78c1ea" width="20" borderColorDark="#808080" height="1"><img src="images/1.jpg" align="top" border="0" width="20" height="20"></td>
      <td style="BORDER-BOTTOM: black 1px solid" noWrap borderColorLight="#9fb7c0" width="100%" bgColor="#9fb7c0" borderColorDark="#808080" colSpan="2" height="1">
        <div class="menuBar" id="menuBar">
          
          &nbsp; <a class="menuButton" <%= at_managelvl.indexOf("0") == -1 ? "style='display:none'" :""%> href=# onclick="javascript:changeMenu('admin');" target="_self">权限管理</a>
          
          &nbsp; <a class="menuButton" <%= at_managelvl.indexOf("1") == -1 ? "style='display:none'" :""%> href=# onclick="javascript:changeMenu('user');" target="_self">用户管理</a>
		  
          &nbsp; <a class="menuButton" <%= at_managelvl.indexOf("2") == -1 ? "style='display:none'" :""%> href=# onclick="javascript:changeMenu('meta');" target="_self">数据字典</a>
		 
          &nbsp; <a class="menuButton" <%= at_managelvl.indexOf("3") == -1 ? "style='display:none'" :""%> href=# onclick="javascript:changeMenu('role');" target="_self">角色管理</a>
		  
          &nbsp; <a class="menuButton" <%= at_managelvl.indexOf("4") == -1 ? "style='display:none'" :""%> href=# onclick="javascript:changeMenu('module');" target="_self">模块管理</a>

          &nbsp; <a class="menuButton" <%= at_managelvl.indexOf("5") == -1 ? "style='display:none'" :""%> href=# onclick="javascript:changeMenu('parameter');" target="_self">系统配置</a>

          &nbsp; <a class="menuButton" <%= at_managelvl.indexOf("6") == -1 ? "style='display:none'" :""%> href=# onclick="javascript:changeMenu('log');" target="_self">系统日志</a>

	      &nbsp; <a class="menuButton" href='/system/platform/logout.jsp' target="_top">退出</a>


<!--
          &nbsp; <a class="menuButton" href=# onclick="javascript:changeMenu('workflow');" target="_self">业务流程</a>
          &nbsp; <a class="menuButton" href=# onclick="javascript:changeMenu('template');" target="_self">表单管理</a>

          &nbsp; <a class="menuButton" href=# onclick="javascript:changeMenu('database');" target="_self">数据管理</a>

          &nbsp; <a class="menuButton" href=# onclick="javascript:changeMenu('TopNews');" target="_self">即时消息</a>

          &nbsp; <a class="menuButton" href="../logout.jsp" target="_top">注销</a>
          <!--&nbsp; <a class="menuButton" href=# onclick="javascript:changeMenu('log" target="_top">操作日志</a>-->

        </div>
      </td>
    </tr>
  </tbody>
</table>
<div class="menu" id="08">
</div>


</body>

</html>

