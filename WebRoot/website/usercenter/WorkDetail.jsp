<%@ page contentType="text/html; charset=GBK"%>
<%@include file="/website/include/IsLogin.jsp"%>
<%@include file="/website/include/import.jsp"%>
<title>消息窗口</title>

<%
String OPType = ""; //操作类型，目前只有Read一个值
String cw_id = ""; //消息id ，浏览消息的时候传入的消息
String sqlStr = "";//用于查询数据库的语句
String ma_content = ""; //消息内容
String strTitle = ""; //页面标题
String ma_title = ""; //消息标题
String ma_chongfu = ""; //重复回复
OPType = CTools.dealString(request.getParameter("OPType")).trim();
cw_id = CTools.dealString(request.getParameter("cw_id")).trim();

//Update 20061231
CDataCn dCn = null;
CDataImpl dImpl = null;
try{
dCn = new CDataCn();
dImpl = new CDataImpl(dCn); 

if (!cw_id.equals("")) //浏览消息
{
	strTitle = "查看消息";
	sqlStr = "select cw_subject,cw_feedback,cw_chongfu from tb_connwork where cw_id='"+cw_id+"' and cw_status=3";
	Hashtable content = dImpl.getDataInfo(sqlStr);
	if (content!=null)
	{
		ma_title = content.get("cw_subject").toString();
		ma_content = content.get("cw_feedback").toString();
		ma_chongfu = CTools.dealNull(content.get("cw_chongfu"));
		if(ma_content.equals("")){
			ma_content = ma_chongfu;
		}
	}
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
<div align="center">信件标题：</div></td>
                <td height="35">
<input type="text" name="textfield2" size="45" class="text-line-info" value='<%=ma_title%>'></td>
              </tr>
            </table></td>
</tr>
<tr>
          <td height="100" bgcolor="#F6F9EE"><table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr> 
                <td width="20%" height="100"> 
                  <div align="center">回复内容：</div></td>
                <td height="100">
<textarea name="textarea2" cols="45" rows="8" class="text-area-info"><%=ma_content%></textarea></td>
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

