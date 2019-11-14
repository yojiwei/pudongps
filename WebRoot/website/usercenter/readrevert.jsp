<%@ page contentType="text/html; charset=GBK"%>
<%@include file="/website/include/IsLogin.jsp"%>
<%@include file="/website/include/import.jsp"%>
<title>消息窗口</title>

<%
String sqlStr = "";
String revert_id = "";
String revert_title = "";
String revert_content = "";
revert_id = CTools.dealString(request.getParameter("revert_id")).trim();

CDataCn dCn = null;
CDataImpl dImpl = null;
try{
dCn = new CDataCn();
dImpl = new CDataImpl(dCn); 

	sqlStr = "select revert_content,revert_title from forum_revert where revert_id='"+revert_id+"'";
	Hashtable content = dImpl.getDataInfo(sqlStr);
	if (content!=null)
	{
		revert_content = content.get("revert_content").toString();
		revert_title = content.get("revert_title").toString();
	}
}

catch(Exception e){
out.print(e.toString());
}
finally{
dImpl.closeStmt();
dCn.closeCn(); 
}
%>
<link rel="stylesheet" href="/website/include/main.css" type="text/css">
<body topmargin=5>
<table width=98% border=0 align="center" cellpadding=0 cellspacing=0>
  <tr>
  <td bgcolor="#D6E1C1">
<table border=0 width=100% cellspacing=1 cellpadding=0>
<tr>
    <td width=100% height=25 background="/website/images/title.gif"> 
      <div align="center">消息窗口</div></td>
</tr>
<tr>
          <td height="35" bgcolor="#F6F9EE"><table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td width="20%" height="35">
<div align="center">回复标题：</div></td>
                <td height="35">
<input type="text" name="textfield2" size="45" class="text-line-info" value='<%=revert_title%>'></td>
              </tr>
            </table></td>
</tr>
<tr>
          <td height="100" bgcolor="#F6F9EE"><table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr> 
                <td width="20%" height="100"> 
                  <div align="center">回复内容：</div></td>
                <td height="100">
<textarea name="textarea2" cols="45" rows="8" class="text-area-info"><%=revert_content%></textarea></td>
              </tr>
              <tr> 
                <td height="30" colspan="2">
<div align="center"> 
                    <input type="button" name="Submit" value="关闭" class="bttn-info" onclick="javascipt:window.close();">
                    　　
                    
                    </form>
                  </div></td>
              </tr>
            </table></td>
</tr>
<tr>
    <td width=100% height=18 bgcolor="#E3F1D0">
</tr>
</table>
</td>
</tr>
</table>
</center>

