<!--#include file="../../skin/head.asp"-->
<html>
<head>
<title>办公自动化系统 (Ver 2.0)--[当前用户：<%=Session("_userName")%>]--<%=Session("_company")%></title>
<link href="/system/app/skin/default/Include/style.css" rel="stylesheet" type="text/css">
</head>

<body bgcolor="#FFFFFF" text="#000000" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
	<script LANGUAGE="JavaScript">
	function UrlChange(ID,Menu,SubMenuID,Module)
	{
		formurl.ID.value=ID;
		formurl.Menu.value=Menu;

		formurl.SubMenuID.value=SubMenuID;
		formurl.Module.value=Module;
		formurl.submit();
	}
	</script>

<%
	if Session("_userId") = "" or isnull(Session("_userId")) or Session("_userId") = 0 then
		Response.Redirect Application("_root") & "/logout.htm"
	end if

		isMenu=true  '是否是菜单页，决定top.asp的显示样式
		isShowAll=false  '是否显示没有权限的菜单项
%>

<table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0" background="../../skin/default/img1/4.gif">
<tr><td align=center valign=top>
	<center>
<%
		if GetPara("菜单导航显示样式")="true" then isShowAll=true
		MaxRows=9	'每一个栏目中最多显示几个模块
		'查询所有模块中功能菜单项目的最大数目
		Sql="Select max(t.a) as MaxRows from " &_
			"(Select count(*) as a from Functions Where UpperID in " &_
			"( " &_
			"	SELECT id FROM Functions WHERE (UpperID in(SELECT id FROM Functions WHERE UpperID = 0)) " &_
			") " &_
			"group by upperid) t "
		Set Rs=Cn.execute(Sql)
		if not rs.eof then MaxRows=rs("MaxRows")

	%>

<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<form name="formurl" action="default.asp" method="post"  target=_top>
		<input type="hidden" name="Menu">
		<input type="hidden" name="ID">
		<input type="hidden" name="SubMenuID">
		<input type="hidden" name="Module">
	</form>
  <tr>
    <td valign="top" background1="../../skin/default/img/4.gif">
      <table width="85%" border="0" cellspacing="0" cellpadding="0" align="center">
				<%
					'//查询模块级菜单
					Sql="SELECT * FROM Functions WHERE (UpperID in(SELECT id FROM Functions WHERE UpperID = 0))"

	    	        Set MenuRs= server.CreateObject("ADODB.Recordset")
					MenuRs.Open sql,Cn,3,3

					bigMenu=0
					on error resume next
					do while not MenuRs.eof
						if GetAccess(MenuRs("ID")) or isShowAll then
						if not GetAccess(MenuRs("ID")) then isNotShowSubMenu=true else isNotShowSubMenu=false
						bigMenu=bigMenu+1
						if 	bigMenu=1 or bigMenu mod 7=0 then
				%>
                <tr>
        		<%
        				End if
        		%>
          <td valign="top">


            <table width="100" border="0" cellspacing="0" cellpadding="0" height="109">
              <tr>
                <td width="18" height="34" valign="bottom">
                  <p><img src="../../skin/default/img/2.gif" width="16" height="16"></p>
                  </td>
                <td height="34" valign="bottom">
                  <div align="center"><b><%=MenuRs("Name")%></b></div>
                </td>
              </tr>
              <tr>
                <td width="18" background="../../skin/default/img/8.gif" height="1">&nbsp;</td>
                <td height="1">&nbsp;</td>
              </tr>
	<%


						MenuID=MenuRs("ID")
						if MenuRs.EOF then MenuID=-100
						Sql="Select * from Functions Where UpperID="&MenuID&" order by sequence"

						set subMenuRs=cn.execute(Sql)
						MenuItem=0	'//菜单项
						ChildMenuItem=0 '//子菜单项
						FirstUrl=""	 '//第一个模块的url
						Do while not subMenuRs.eof
							if GetAccess(subMenuRs("ID")) or isShowAll  then
							MenuItem=MenuItem+1

							'取出每一个模块的默认网页地址
							URL = subMenuRs("url")
							if trim(URL)<>"" then
								if isNULl(URL) or url <> "" then
									if instr(1,URL,"?") > 0  then
										URL = URL & "&"
									else
										URL = URL & "?"
									end if
								else
									URL = URL & "?"
								end if

								URL="../../"&URL&"Menu="&Menu&"&Module="&subMenuRs("Name")&"&SubMenuID="&subMenuRs("ID")&"&ID="&ID

								'存储第一个模块的url
								if MenuItem=1 then
									FirstUrl=Url
								End if

								if Session("_bFirstLogin") then
									FirstUrl="../../person/today/todayEvent.asp?Menu=个人办公&Module=今日事务&SubMenuID=15"
								end if
							End if
	%>
              <tr>
                <td width="18" valign="top" background="../../skin/default/img1/8.gif" height="22"><img src="../../skin/default/img/1.gif" width="20" height="17"></td>
              </center>
                <td align="center" valign="middle" height="22">
                  <div align="center">
                    <p align="left"><span class="unnamed1">
<%
if not isNotShowSubMenu then
	if GetAccess(subMenuRs("ID")) then

%>
					      <%if instr(lcase(subMenuRs("Url")),"http://")=0 then%>
							<a target="_self" href="Javascript:UrlChange('<%=MenuRs("id")%>','<%=MenuRs("Name")%>','<%=subMenuRs("id")%>','<%=subMenuRs("Name")%>');">
					      <%Else%>
    </a>
							<a href="<%=subMenuRs("Url")%>" target="_blank">
					      <%End if%>
<%
	end if
end if
%>
							<%=subMenuRs("Name")%>
					      <br>
						</a>
                    </span></p>
                  </div>
                </td>
              </tr>

	<center>
	<%
							End if
						subMenuRs.movenext
						loop

		for MenuItem=1  to MaxRows-MenuItem
	%>
              <tr>
                <td width="18" valign="top" background="../../skin/default/img/8.gif" height="22"><img src="../../skin/default/img/1.gif" width="20" height="17"></td>
              </center>
                <td align="center" valign="middle" height="22">
                  <div align="center">
                    <p align="left"><span class="unnamed1">
					      <br>
						</a>
                    </span></p>
                  </div>
                </td>
              </tr>
	<%
		next
	%>
            </table>


          </td>
				 <%
						End if
					MenuRs.movenext
					loop
				%>
<%
		if isShowAll then
%>
          <td valign="top">


            <table width="100" border="0" cellspacing="0" cellpadding="0" height="109">
              <tr>
                <td width="18" height="34" valign="bottom">
                  <p><img src="../../skin/default/img/2.gif" width="16" height="16"></p>
                  </td>
                <td height="34" valign="bottom">
                  <div align="center"><b>后台管理</b></div>
                </td>
              </tr>
              <tr>
                <td width="18" background="../../skin/default/img/8.gif" height="1">&nbsp;</td>
                <td height="1">&nbsp;</td>
              </tr>

              <tr>
                <td width="18" valign="top" background="../../skin/default/img/8.gif" height="22"><img src="../../skin/default/img/1.gif" width="20" height="17"></td>
              </center>
                <td align="center" valign="middle" height="22">
                  <div align="center">
                    <p align="left"><span class="unnamed1">
用户管理
					      <br>
						</a>
                    </span></p>
                  </div>
                </td>
              </tr>

	<center>

              <tr>
                <td width="18" valign="top" background="../../skin/default/img/8.gif" height="22"><img src="../../skin/default/img/1.gif" width="20" height="17"></td>
              </center>
                <td align="center" valign="middle" height="22">
                  <div align="center">
                    <p align="left"><span class="unnamed1">
数据字典
					      <br>
						</a>
                    </span></p>
                  </div>
                </td>
              </tr>

	<center>

              <tr>
                <td width="18" valign="top" background="../../skin/default/img/8.gif" height="22"><img src="../../skin/default/img/1.gif" width="20" height="17"></td>
              </center>
                <td align="center" valign="middle" height="22">
                  <div align="center">
                    <p align="left"><span class="unnamed1">
角色管理
					      <br>
						</a>
                    </span></p>
                  </div>
                </td>
              </tr>
              <tr>
                <td width="18" valign="top" background="../../skin/default/img/8.gif" height="22"><img src="../../skin/default/img/1.gif" width="20" height="17"></td>
              </center>
                <td align="center" valign="middle" height="22">
                  <div align="center">
                    <p align="left"><span class="unnamed1">
模块管理
					      <br>
						</a>
                    </span></p>
                  </div>
                </td>
              </tr>
              <tr>
                <td width="18" valign="top" background="../../skin/default/img/8.gif" height="22"><img src="../../skin/default/img/1.gif" width="20" height="17"></td>
              </center>
                <td align="center" valign="middle" height="22">
                  <div align="center">
                    <p align="left"><span class="unnamed1">
业务流程
					      <br>
						</a>
                    </span></p>
                  </div>
                </td>
              </tr>	<center>


              <tr>
                <td width="18" valign="top" background="../../skin/default/img/8.gif" height="22"><img src="../../skin/default/img/1.gif" width="20" height="17"></td>
              </center>
                <td align="center" valign="middle" height="22">
                  <div align="center">
                    <p align="left"><span class="unnamed1">
表单管理
					      <br>
						</a>
                    </span></p>
                  </div>
                </td>
              </tr>
              <tr>
                <td width="18" valign="top" background="../../skin/default/img/8.gif" height="22"><img src="../../skin/default/img/1.gif" width="20" height="17"></td>
              </center>
                <td align="center" valign="middle" height="22">
                  <div align="center">
                    <p align="left"><span class="unnamed1">
数据管理
					      <br>
						</a>
                    </span></p>
                  </div>
                </td>
              </tr>
              <tr>
                <td width="18" valign="top" background="../../skin/default/img/8.gif" height="22"><img src="../../skin/default/img/1.gif" width="20" height="17"></td>
              </center>
                <td align="center" valign="middle" height="22">
                  <div align="center">
                    <p align="left"><span class="unnamed1">
 即时消息
					      <br>
						</a>
                    </span></p>
                  </div>
                </td>
              </tr>
            </table>


          </td>
<%
		End if
%>

		</tr>
      </table>

    </td>
  </tr>
</table>
</td></tr></table>
</body>
</html>
<!--#include file="../../skin/bottom.asp"-->