<%@ page contentType="text/html; charset=GBK"%>
<%@ include file="/website/include/import.jsp"%>
<%@page import="com.website.*"%>
<%@ page pageEncoding="GBK"%>
<%

User checkLogin = (User)session.getAttribute("user");
if(checkLogin==null||!checkLogin.isLogin())
{
      out.println("<script>");
     out.println(" window.open('/website/login/Login.jsp');");
      out.println("</script>");
      return;
}

String post_id = "";
String post_title = "";
String collection_date = "";
String us_id = "";
String sqlStr = "";

Vector vPage = null;
Hashtable content = new Hashtable();
Hashtable content_in = new Hashtable();
//Update 20061231
CDataCn dCn = null;
CDataImpl dImpl = null;
try{
dCn = new CDataCn();
dImpl = new CDataImpl(dCn); 
User user = (User)session.getAttribute("user");
if(user != null)us_id = user.getId();
%>
<link href="images/newWebMain.css" rel="stylesheet" type="text/css" />
<link href="images/main.css" rel="stylesheet" type="text/css" />

<body topmargin="0" leftmargin="0"  bgcolor="transparent" cellspacing="0" cellpadding="0">
<script language="javascript">
function readMsg(id,type)
{
        var w=450;
        var h=250;
        var url = "/website/usercenter/MessageDetail.jsp?ma_id="+id+"&OPType="+type;        window.open(url,"查看消息","Top=150px,Left=300px,Width="+w+"px,Height="+h+"px,toolbar=no,location=no,derectories=no,status=no,menubar=no,resizable=no,scrollbars=no");
}
function readrevert(id)
{
        var w=450;
        var h=250;
        var url = "/website/usercenter/readrevert.jsp?revert_id="+id;        window.open(url,"我的回复内容","Top=150px,Left=300px,Width="+w+"px,Height="+h+"px,toolbar=no,location=no,derectories=no,status=no,menubar=no,resizable=no,scrollbars=no");
}
</script>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
             
              <tr>
                <td height="4" align="left" valign="top"><img src="images/usercenterNEW_line03.gif" width="515" height="1" /></td>
              </tr>
              <tr>
                <td align="left" valign="top">
                
                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                  <tr>
                    <td width="22" height="30" align="left" valign="top"><img src="images/usercenterNEW_icon16.gif" width="17" height="17" vspace="4" /></td>
                    <td width="250" align="left" valign="middle" class="f14"><font color="#AD0000"><strong>我的回复</strong></font></td>
              <!--查询文件导入 -->
                 <%@include file="/website/usercenter/search.jsp"%>
              <tr>
                <td valign="top"><table width="100%" border="0" cellspacing="0" cellpadding="0">
                  <tr>
                    <td valign="bottom"></td>
                  </tr>
                  <tr>
                    <td valign="top"><table width="100%" border="0" cellspacing="1" cellpadding="0">
                      <tr>
                        <td height="1" colspan="25" bgcolor="#ACC2E9"></td>
                        </tr>
                      <tr bgcolor="#F3F4F6">
                        <td width="10%" align="center" valign="bottom">序&nbsp;&nbsp;号</td>
                        <td width="70%" align="center" valign="bottom">收藏话题</td>
                        <td width="20%" align="center" valign="bottom" bgcolor="#F3F4F6">收藏日期</td>
                      </tr>
                      <tr>
                        <td height="1" colspan="25" bgcolor="#ACC2E9"></td>
                      </tr>
                    </table></td>
                  </tr>
                  <tr>
                    <td valign="top"><table width="100%" border="0" cellspacing="0" cellpadding="0">

<%
 sqlStr = "select post_id,to_char(collection_date,'yyyy-MM-dd HH24:mi')collection_date from forum_collection_pd where us_id='"+us_id+"' order by collection_date desc,collection_date desc";
 vPage = dImpl.splitPage(sqlStr,request,15);//out.print(sqlStr);
    if (vPage!=null)
    {
        for(int i=0;i<vPage.size();i++)
        {
            content = (Hashtable)vPage.get(i);
            post_id = content.get("post_id").toString();
            collection_date = content.get("collection_date").toString();            
            sqlStr = "select post_title from forum_post_pd where post_id="+post_id;
            content_in = dImpl.getDataInfo(sqlStr);
            if(content_in!=null)post_title=content_in.get("post_title").toString();                  
 %>
    <tr height="20">
        <td align="center" width="10%" valign="bottom"><%=i+1%></td>
        <td align="left" width="70%" valign="bottom" >
        <a href="/website/pudongForum/revertlist.jsp?post_id=<%=post_id%>" title="<%=post_title%>" target="_blank"><%if(post_title.length()>31) out.print(post_title.substring(0,30)+"..");else out.print(post_title);%></a></td>
        <td align="center" width="20%" valign="bottom"><%=collection_date%></td>
    </tr>  
    <tr>
        <td height="3" colspan="20" background="images/usercenterNEW_line04.gif"></td>
   </tr>
<%
                }
                 out.print("<tr><td bgcolor='#FFFFFF' colspan=20>"+dImpl.getTail(request)+"</td></tr>");
        } else out.print("<tr height='20'><td  colspan='20' valign='bottom'><font color='#FF0000'>您没有收藏内容！</font></td></tr>");
%>
                </table>
</td></tr>
                </table></td>
              </tr>

            </table>
</body>
<%
}
catch(Exception e){
out.print(e.toString());
}
finally{
dImpl.closeStmt();
dCn.closeCn(); 
}
%>