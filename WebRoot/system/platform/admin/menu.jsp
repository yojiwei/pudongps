<%@ page contentType="text/html; charset=GBK" %>
<%@ page import="com.component.database.*" %>
<%@ page import="com.platform.role.CRoleInfo" %>
<%@ page import="java.util.*" %>
<%
  CDataCn dCn = null;
  CRoleInfo rInfo = null;
  try{
  	dCn = new CDataCn();
  	rInfo = new CRoleInfo();
  String sql = "SELECT * FROM TB_ADMINISTRATOR ORDER BY AT_ID ASC";
  Vector vectorPage = rInfo.splitPage(sql,request,10000);

%>
<html>
<head>
<meta http-equiv="pragma" content="no-cache">
<link href="../style.css" rel="stylesheet" type="text/css">
<title></title>

</head>


<body bgcolor="#9FB7C0" topmargin="0" leftmargin=10  style="font-size: 8pt; border: 1 dotted #000000" >

<div style="position: absolute; top: 7; left: 29; width: 86; height: 10;TEXT-ALIGN:center;COLOR: #99ccff;" class="dotted-table">
权限管理
</div>
<table border="0" cellpadding="0" cellspacing="0" style="border-collapse: collapse" bordercolor="#111111" width="26%" id="AutoNumber1">
  <tr>
    <td width="100%" colspan="3">
    <table border="0" cellpadding="0" cellspacing="0" style="border-collapse: collapse" bordercolor="#111111" width="100%" id="AutoNumber2">
      <tr>
        <td width="19%" background="../images/FrameTopLeft.gif">
        <img border="0" src="../images/FrameTopLeft.gif" width="136" height="31"></td>
        <td width="82%" background="../images/FrameTopcenter.gif" align=right>
        <a href="javascript:window.location.reload();">刷新</a>
        </td>
        <td width="100%"  align="right"><img border="0" src="../images/FrameTopRight.gif" width="12" height="31"></td>
      </tr>
    </table>
    </td>
  </tr>
  <tr>
    <td width="100%" colspan="3">
    <table border="0" cellpadding="0" id="dataBoard" cellspacing="0" style="border-collapse: collapse" bordercolor="#111111" width="100%" id="AutoNumber3" height="54">
      <tr>
        <td width="3%" background="../images/FrameLeft.gif" height="54">
        <img border="0" src="../images/FrameLeft.gif" width="13" height="9"></td>
        <td width="208%" height="355" valign=top class=dotted-table>
        <%
        if(vectorPage!=null)
        {
          Hashtable content = null;
          Hashtable contentTr_name = null;
         
          
          for(int j=0;j<vectorPage.size();j++)
          {
            content = (Hashtable)vectorPage.get(j);
            
           
           
        %>
                        <img src="/system/images/arrow.gif" border="0" WIDTH="12" HEIGHT="13">
                        <a href="adminList.jsp?at_loginname=<%=content.get("at_loginname")%>&OP=UPD" target="main"><%= content.get("at_loginname")  %></a>
                        <br>
        <%
          }
        }
        else
        {
          out.println("没有角色");
        }
        %>
                </td>
        <td width="22%" background="../images/FrameRight.gif" height="54">
        <p align="right">
        <img border="0" src="../images/FrameRight.gif" width="7" height="9"></td>
      </tr>
    </table>
    </td>
  </tr>
  <tr>
    <td width="3%" background="../images/FrameBottomCenter.gif" height="8">
    <img border="0" src="../images/FrameBottomLeft.gif" width="15" height="8"></td>
    <td width="97%" background="../images/FrameBottomCenter.gif">
    <img border="0" src="../images/FrameBottomCenter.gif" width="10" height="8"></td>
    <td width="3%" align=right>
    <img border="0" src="../images/FrameBottomRight.gif" width="11" height="8"></td>
  </tr>
</table>
<%
rInfo.closeStmt();
dCn.closeCn();
} catch (Exception ex) {
	System.out.println(new java.util.Date() + "--"
			+ request.getServletPath() + " : " + ex.getMessage());
} finally {
	if(rInfo != null)
	rInfo.closeStmt();
	if(dCn != null)
	dCn.closeCn();
}
%>
