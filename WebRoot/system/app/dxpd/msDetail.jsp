<%@page contentType="text/html; charset=GBK"%>
<%@ page import="com.beyondbit.web.publishinfo.Messages" %>
<%@page import="com.util.*"%>
<%@page import="Evaluate.*"%>
<%@page import="vote.*"%>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.util.Vector" %>
<script LANGUAGE="javascript" src="common/common.js"></script>

<%@include file="../skin/head.jsp"%>
<html>
<head>
<link href="../style.css" rel="stylesheet" type="text/css">
</head>
<body>

<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title>上海浦东门户网站后台管理系统</title>
<style type="text/css">
<!--
@import url("/system/app/skin/skin3/images/main.css");
-->
</style>
<link href="/system/app/skin/skin3/images/style.css" rel="stylesheet" type="text/css">
<html>
<head>
<meta http-equiv="pragma" content="no-cache">
<link href="../style.css" rel="stylesheet" type="text/css">
<title></title>
<%
String strTitle = "用户订阅部门短信发送数据统计";
CDataCn dCn = new CDataCn(); //新建数据库连接对象
CDataImpl dImpl = new CDataImpl(dCn); //新建数据接口对象
//String smmdt = request.getParameter("sm_dtname");
String sm_idms=request.getParameter("sm_idms");
String sm_flags=request.getParameter("sm_flag");
String sm_dtids=request.getParameter("sm_dtid");
String sj_name1=request.getParameter("sj_name");
String sj_name =  new String(sj_name1.getBytes("ISO-8859-1"), "GB2312");
String sj_id=request.getParameter("sj_id");
String sm_dtid="";
String sm_name ="";
String sm_sendtime="";
String sm_con="";
String ccc="";
try{
Vector vectorPage=null;


String sqltj="select s.sm_con,s.sm_dtid,s.sm_sendtime,count(*) as ccc from tb_sms s where s.sm_id in ("+sm_idms+") and";
sqltj+=" s.sm_sj_id= "+sj_id+" and s.sm_flag="+sm_flags+" and s.sm_dtid="+sm_dtids+" group by s.sm_con,s.sm_dtid,s.sm_sendtime";

vectorPage = dImpl.splitPageOpt(sqltj,request,15);
%>

 <table class="main-table" width="100%">
    <tr>
  <td width="100%">
       <table class="content-table" width="100%">
	           <tr class="title1">
            <td colspan="5" align="center">
                <table WIDTH="100%" BORDER="0" CELLSPACING="1" CELLPADDING="1">
                    <tr>
                        <td valign="center" nowrap><%=strTitle%></td>
			<td valign="center" align=left></td>
                      <td valign="center" align="right" nowrap>
                          <img src="images/split.gif" align="middle" border="0" WIDTH="5" HEIGHT="8">
                          <img src="images/goback.gif" width="16" height="16" border="0" align="absmiddle" style="cursor:hand" title="返回" onClick="javascript:history.back();">
                          <img src="images/split.gif" align="middle" border="0" WIDTH="5" HEIGHT="8">   </td>
  </tr>
 </table>  </td>
        </tr>
        <tr class="bttn">
            <td width="13%" class="outset-table" nowrap>栏目ID</td>
            <td width="19%" class="outset-table" nowrap>所属栏目</td>
            <td width="52%" nowrap class="outset-table">信息内容</td>
            <td width="16%" nowrap class="outset-table">订阅个数</td>
            <td width="16%" nowrap class="outset-table">发送日期</td>
         </tr>
<%
  if(vectorPage!=null)
  {
   int amount=0;
    for(int j=0;j<vectorPage.size();j++)
    {
      Hashtable content = (Hashtable)vectorPage.get(j);
	  sm_con = content.get("sm_con").toString();
	  ccc=content.get("ccc").toString();
	  sm_sendtime = content.get("sm_sendtime").toString();
      if(j % 2 == 0)  out.print("<tr class=\"line-even\">");
      else out.print("<tr class=\"line-odd\">");
%>

                <tr><td align=center nowrap ><%=sj_id%></td>
                <td align="center" nowrap><%=sj_name%></td>
                <td align=left nowrap><%=sm_con%></td>
                 <td align=center><a href="../infopublish/SelectList.jsp?sm_sj_id=<%=sj_id%>&sm_con=<%=sm_con%>"><%=ccc%></a></td>
                 <td align=center><%=sm_sendtime%></td>
                </tr>

<%	 
          }		
      out.println("<tr><td colspan=7>" + dImpl.getTail(request) + "</td></tr>");
          }

		  else
		  {
			out.println("<tr><td colspan=7>没有记录！</td></tr>");
		  }
%>
</table>
      </td>
    </tr>
</table>

<%
}catch(Exception ex)
  {}finally{
  dImpl.closeStmt();
  dCn.closeCn();
  }
%>
<%@ include file="../skin/bottom.jsp"%>
