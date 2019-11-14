<%@ page contentType="text/html; charset=GBK" %>
<title>法律法规</title>
<%@include file="/website/include/import.jsp"%>
<%
//Update 20061231
CDataCn dCn = null;
CDataImpl dImpl = null;
try{
dCn = new CDataCn();
dImpl = new CDataImpl(dCn); 
%>
<link rel="stylesheet" href="/website/include/main.css" type="text/css">
<table width="80%" align="center" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td width="78"><img src="/website/images/popo1a.gif" width="78" height="32"></td>
          <td width="101"><img src="/website/images/popo2a.gif" width="101" height="32"></td>
          <td background="/website/images/popo4a.gif">&nbsp;</td>
          <td width="331"><img src="/website/images/popo3a.gif" width="331" height="32"></td>
        </tr>
      </table></td>
  </tr>
  <tr>
    <td><table width="100%" border="0" cellspacing="8" cellpadding="0">
        <tr>
          <td>
          <table width="100%" border="1" cellpadding="0" cellspacing="0" bordercolor="#FFFFFF">
              <tr>
              <%
				String contentid = "";
				String sqlStr = "";
				contentid = CTools.dealString(request.getParameter("id")).trim();
				if (!contentid.equals(""))
				{
					sqlStr = "select contenttitle,contentbody from carmot.tbcontent where contentid="+contentid;
				}
				Hashtable content = dImpl.getDataInfo(sqlStr);
				if(content!=null)
				{
				%>
					<td bordercolor="#CCCCCC">
						<table width="100%" border="0" cellspacing="5">
							<tr><td align="center">
						<font size="2"><b><%=content.get("contenttitle").toString()%></b></font></td></tr>
							<tr><td align="left">
						&nbsp;&nbsp;<font size="2"><%=content.get("contentbody").toString()%></font>
						</td></tr>
					</td>
              <%
              }
              %>
              </tr>
            </table></td>
        </tr>
      </table></td>
  </tr>
  <tr>
    <td><div align="center"> 
        <table width="100%" height="30" border="0" cellpadding="0" cellspacing="0">
          <tr>
            <td width="245" background="/website/images/popo5a.gif">&nbsp;</td>
            <td background="/website/images/popo7a.gif">&nbsp;</td>
            <td width="245" background="/website/images/popo6a.gif" align="right"><a href="javascript:window.close();">关闭</a>&nbsp;</td>
          </tr>
        </table>
      </div></td>
  </tr>
</table>
<%
}
catch(Exception e){
//e.printStackTrace();
out.print(e.toString());
}
finally{
dImpl.closeStmt();
dCn.closeCn(); 
}
%>