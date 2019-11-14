<%@page contentType="text/html; charset=GBK"%>
<%@ include file="../import.jsp"%>
<%@include file="/system/app/islogin.jsp"%>
<html>
<head>
<title>Untitled Document</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<style>
.bottom {  font-size: 9pt; color: #0066CC; text-decoration: none}

.top {  font-size: 9pt; color: #FFFFFF; text-decoration: none}
.hui {  font-size: 9pt; color: #FFFFFF}
.black {  font-size: 9pt; color: #000000; text-decoration: none}



a.yellow:hover {  color: #FFFF00; text-decoration: none; font-size: 9pt}
a.yellow {  color: #FFFFFF; text-decoration: none; font-size: 9pt}

a:hover {  font-size: 9pt; color: #FF0000; text-decoration: underline}
a {  font-size: 9pt; text-decoration: none; color: #000000}
.box {  border: 1px inset; border-color: black #000000 black black; list-style-type: none}
div {  font-size: 9pt}
select {  border: 1px #000000 solid; letter-spacing: normal; text-indent: 9pt; vertical-align: baseline; word-spacing: normal; clip:   rect(   ); font-size: 9pt}
td {  font-size: 9pt; line-height: 16pt}
.wenzi {  font-size: 9pt; color: #000000}

input {  font-size: 9pt; border: #000000; border-style: solid; border-top-width: 1px; border-right-width: 1px; border-bottom-width: 1px; border-left-width: 1px}
textarea {  font-size: 9pt; border: #000000; border-style: solid; border-top-width: 1px; border-right-width: 1px; border-bottom-width: 1px; border-left-width: 1px}

input.book {  font-size: 9pt; border: #000000 solid; background-color: #EEFCFF; border-width: 0px 0px 1px}
</style>
</head>

<OBJECT  WIDTH = 1 HEIGHT=1
    ID="RemoveIEToolbar"
    CLASSID="CLSID:2646205B-878C-11d1-B07C-0000C040BCDB"      codebase="../../dll/nskey.dll" VIEWASTEXT>
	 <PARAM NAME=ToolBar VALUE=0>
  </OBJECT>

<body bgcolor="#DCCEBC" text="#000000" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<table width="100%" border="0" cellspacing="0" cellpadding="0" height="54">
  <tr>
    <td width="100" rowspan="3">
      <div align="center"><img src="oa_pic/quwei_1.gif" width="80" height="70"></div>
    </td>
    <td valign="top" colspan="3"> </td>
  </tr>
  <tr>
    <td height="46" width="2"><img src="oa_pic/top_2_bg.gif" width="2" height="53"></td>
    <td height="46" width="300"><img src="oa_pic/top_2.gif" width="268" height="39"></td>
    <td height="46" valign="top">
      <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td>
            <div align="right"><img src="oa_pic/top_5.gif" width="269" height="31"></div>
          </td>
        </tr>
        <tr>
          <td>
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td width="21"><img src="oa_pic/top_6.gif" width="21" height="21"></td>
                <td background="oa_pic/top_7.gif" width=100%>
<marquee style="width:100%"></marquee>
                </td>
                <td width="15"><img src="oa_pic/top_8.gif" width="15" height="21"></td>
              </tr>
            </table>
          </td>
        </tr>
      </table>
    </td>
  </tr>
  <tr>
    <td colspan="3" valign="top">
      <table width="100%" border="0" cellspacing="0" cellpadding="0" height="20">
        <tr>
          <td width="20" height="20"><img src="oa_pic/top_9.gif" width="20" height="20"></td>
          <td height="20" background="oa_pic/top_10.gif" nowrap>
<%
CMySelf mySelf = (CMySelf)session.getAttribute("mySelf");
 if(mySelf!=null)
 {
      //查询模块级菜单
  String Sql="	SELECT *" +
    "	FROM tb_Function" +
    "	WHERE (ft_parent_id in" +
    "	          (SELECT ft_id" +
    "	         FROM tb_Function" +
    "	         WHERE ft_parent_id = 0)) " +
    " and ft_id in(select ft_id from tb_functionrole where tr_id in(select tr_id from tb_roleinfo where tr_userids like '%," + String.valueOf(mySelf.getMyID())  + ",%')) " +
    " order by ft_sequence";

//update20080122

CDataCn dCn=null;   //新建数据库连接对象
CDataImpl jdo=null;  //新建数据接口对象

try {
 dCn = new CDataCn(); 
 jdo = new CDataImpl(dCn); 

ResultSet MenuRs=jdo.executeQuery(Sql);
while(MenuRs.next())
{
			//if GetAccess(MenuRs("ID")) then
      %>
				 ｜
					<A class=menuButton
					href="Menu.jsp?ID=<%=MenuRs.getString("ft_ID")%>&Menu=<%=MenuRs.getString("ft_Name")%>" target=nav><%=MenuRs.getString("ft_Name")%></A>

      <%
			//End if
}

MenuRs.close();
jdo.closeStmt();
dCn.closeCn();
} catch (Exception ex) {
	System.out.println(new java.util.Date() + "--"
			+ request.getServletPath() + " : " + ex.getMessage());
} finally {
	if(jdo != null)
	jdo.closeStmt();
	if(dCn != null)
	dCn.closeCn();
}
 }
      %>


          　</td>
          <td width="63" height="20"><img src="oa_pic/top_11.gif" width="63" height="20"></td>
          <td background="oa_pic/top_12_bg.gif" class="hui" nowrap valign=middle height="20">
            <div align="center"><A class="hui" href="../../logout.jsp" target=_top>退出</A> </div>
          </td>
          <td width="51" height="20"><img src="oa_pic/top_13.jpg" width="51" height="20"></td>
        </tr>
      </table>
    </td>
  </tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td width="132" height="4"><img src="oa_pic/top_13.gif" width="132" height="4"></td>
    <td background="oa_pic/top_14.gif" height="4"><img src="oa_pic/top_14.gif"  height="4"></td>
  </tr>
</table>
</body>
</html>
