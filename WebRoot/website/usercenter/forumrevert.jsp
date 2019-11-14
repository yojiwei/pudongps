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
String revert_id = "";
String revert_title = "";
String revert_author = "";
String revert_status = "";
String revert_date = "";
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
                        <td width="30%" align="center" valign="bottom">话题名称</td>
                        <td width="30%" align="center" valign="bottom">回复标题</td>
                        <td width="10%" align="center" valign="bottom">状&nbsp;&nbsp;态</td>
                        <td width="20%" align="center" valign="bottom" bgcolor="#F3F4F6">回复日期</td>
                      </tr>
                      <tr>
                        <td height="1" colspan="25" bgcolor="#ACC2E9"></td>
                      </tr>
                    </table></td>
                  </tr>
                  <tr>
                    <td valign="top"><table width="100%" border="0" cellspacing="0" cellpadding="0">

<%
 sqlStr = "select post_id,revert_id,revert_title,to_char(revert_date,'yyyy-MM-dd HH24:mi')revert_date,revert_status from forum_revert where revert_author_id='"+us_id+"' order by revert_date desc,revert_id desc";
 vPage = dImpl.splitPage(sqlStr,request,15);//out.print(sqlStr);
    if (vPage!=null)
    {
        for(int i=0;i<vPage.size();i++)
        {
            content = (Hashtable)vPage.get(i);
            post_id = content.get("post_id").toString();
            revert_id = content.get("revert_id").toString();
            revert_title = content.get("revert_title").toString();
            revert_date = content.get("revert_date").toString();
            revert_status = content.get("revert_status").toString();
            if(revert_status.equals("0"))revert_status="未审核";
            else if(revert_status.equals("2"))revert_status="审核不通过";
            else revert_status="通过";
            sqlStr = "select post_title from forum_post_pd where post_id="+post_id;
            content_in = dImpl.getDataInfo(sqlStr);
            if(content_in!=null)post_title=content_in.get("post_title").toString();                  
 %>
    <tr height="20">
        <td align="center" width="10%" valign="bottom"><%=i+1%></td>
        <td align="left" width="30%" valign="bottom" >
        <a href="/website/pudongForum/revertlist.jsp?post_id=<%=post_id%>" title="<%=post_title%>" target="_blank"><%if(post_title.length()>13) out.print(post_title.substring(0,12)+"..");else out.print(post_title);%></a></td>
        <td align="left" width="30%" valign="bottom"><a href="javascript:readrevert('<%=revert_id%>');"  title="<%=revert_title%>"><%if(revert_title.length()>13) out.print(revert_title.substring(0,12)+"..");else out.print(revert_title);%></a></td>
        <td align="center" width="10%" valign="bottom" ><%=revert_status%></td>
        <td align="center" width="20%" valign="bottom"><%=revert_date%></td>
    </tr>  
    <tr>
        <td height="3" colspan="20" background="images/usercenterNEW_line04.gif"></td>
   </tr>
<%
                }
                 out.print("<tr><td bgcolor='#FFFFFF' colspan=20>"+dImpl.getTail(request)+"</td></tr>");
        } else out.print("<tr height='20'><td  colspan='20' valign='bottom'><font color='#FF0000'>您没有回复内容！</font></td></tr>");
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