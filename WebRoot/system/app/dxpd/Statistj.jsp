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


try{

Vector vectorPage=null;
Vector vectorPage1=null;
//String sqltj="select distinct s.sm_dtid from tb_sms s where s.sm_check=2";
//sqltj+=" and s.sm_flagtoo=10 and s.sm_dtid is not null";


String sqltj="select sm_dtid, count(*) as ccc from (select l.id as id,s.sm_dtid as sm_dtid";
sqltj+=" from subscibelog l ";
sqltj+=" left join tb_sms s on l.content=s.sm_con where l.sendflag=1 and s.sm_check=2 and s.sm_flagtoo=10 and s.sm_dtid is not null";
sqltj+=" group by s.sm_dtid,l.id) group by sm_dtid  ";

vectorPage = dImpl.splitPageOpt(sqltj,request,15);
//out.println(sqltj);
%>

 <table class="main-table" width="100%">
    <tr>
  <td width="100%">
       <table class="content-table" width="100%">
	           <tr class="title1">
            <td colspan="4" align="center">
                <table WIDTH="100%" BORDER="0" CELLSPACING="1" CELLPADDING="1">
                    <tr>
                        <td valign="center" nowrap><%=strTitle%></td>
			<td valign="center" align=left></td>
                      <td valign="center" align="right" nowrap>
                          <img src="images/split.gif" align="middle" border="0" WIDTH="5" HEIGHT="8">
                          <img src="images/menu_about.gif" width="16" height="16" border="0" align="absmiddle" style="cursor:hand" title="查找" onClick="javascript:window.location.href='Statisearch.jsp' ">
                          <img src="images/split.gif" align="middle" border="0" WIDTH="5" HEIGHT="8">
                          <img src="images/goback.gif" width="16" height="16" border="0" align="absmiddle" style="cursor:hand" title="返回" onClick="javascript:history.back();">
                          <img src="images/split.gif" align="middle" border="0" WIDTH="5" HEIGHT="8">   </td>
  </tr>
 </table>  </td>
        </tr>
        <tr class="bttn">
            <td width="16%" class="outset-table" nowrap>部门ID</td>
            <td width="48%" class="outset-table" nowrap>部门名称</td>
            <td width="15%" nowrap class="outset-table">部门发布的信息数</td>
            <td width="21%" nowrap class="outset-table">查看详情</td>
         </tr>
<%
  if(vectorPage!=null)
  {
    int coo=0;
    for(int j=0;j<vectorPage.size();j++)
    {
      Hashtable content = (Hashtable)vectorPage.get(j);
	  String sm_dtid = content.get("sm_dtid").toString();
	  String ccc=content.get("ccc").toString();
	  coo=Integer.parseInt(ccc);
	  //coo+=coo;
	 
	  String xqSql = "select dt_name from tb_deptinfo where dt_id="+sm_dtid+"";
	  //out.println(xqSql);
	  //if(true)return;
	  Hashtable contently = dImpl.getDataInfo(xqSql);
	  String dt_name=contently.get("dt_name").toString();
	  
	  
	 /* String sm_con = "";
	  String xxSql = "select content,count(*) as ccc from subscibelog where content='"+sm_con+"' and sendflag=1";
	  String ccc = "";
	  int coo=0;
	  vectorPage1 = dImpl.splitPageOpt(xxSql,request,15);
	    if(vectorPage1!=null)
	    {
		for(int v=0;v<vectorPage1.size();v++)
		{
	    Hashtable contentyu = (Hashtable)vectorPage1.get(v);
		sm_con = contentyu.get("content").toString();
	    ccc=contentyu.get("ccc").toString();
		coo=Integer.parseInt(ccc);
		coo+=coo;
		}
		}*/
		
      if(j % 2 == 0)  out.print("<tr class=\"line-even\">");
      else out.print("<tr class=\"line-odd\">");
%>

                <td align=center nowrap ><%=sm_dtid%></td>
                <td align="center" nowrap><%=dt_name%></td>
                <td align=center nowrap><%=coo%></td>
                 <td align=center><a href="msDetail.jsp?sm_id=<%=sm_dtid%>&sm_dtname=<%=dt_name%>">查看</a></td>
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
}catch(Exception e)
{

}finally{
  dImpl.closeStmt();
  dCn.closeCn();
  }
%>
<%@ include file="../skin/bottom.jsp"%>
