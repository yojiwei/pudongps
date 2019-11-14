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
<style type="text/css">
<!--
.STYLE1 {color: #FF0000}
-->
</style>
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
String sj_id = CTools.dealString(request.getParameter("sj_id"));
String dt_id = CTools.dealString(request.getParameter("dt_id"));
String start_date = CTools.dealString(request.getParameter("start_date"));
String end_date = CTools.dealString(request.getParameter("end_date"));
String sm_flags = CTools.dealString(request.getParameter("sm_flag"));
String sm_ids = "";
String sm_idms="";

//这是一个
String sqltj="select s.sm_dtid,d.dt_name,j.sj_name,s.sm_sj_id,count(*) as ccc from tb_sms s,tb_subject j,tb_deptinfo d ";
sqltj+="where s.sm_dtid = d.dt_id and s.sm_sj_id = j.sj_id and s.sm_tel is not null";
if(!dt_id.equals(""))
{
	sqltj+="and s.sm_dtid="+dt_id+"";
}
if(!sj_id.equals(""))
{
	sqltj+=" and s.sm_sj_id="+sj_id+"";
}
sqltj+=" and s.sm_flagtoo=10 and s.sm_check=2";
if(!sm_flags.equals(""))
{
	sqltj+=" and s.sm_flag="+sm_flags+"";
}
if(!end_date.equals("")){
sqltj+=" and floor(to_date('"+end_date+"','yyyy-MM-dd')-to_date(to_char(s.sm_sendtime,'yyyy-MM-dd'),'yyyy-MM-dd'))>0 "; 
}
if(!start_date.equals("")){
sqltj+=" and floor(to_date(to_char(s.sm_sendtime,'yyyy-MM-dd'),'yyyy-MM-dd')-to_date('"+start_date+"','yyyy-MM-dd'))>0";
}
sqltj+=" group by s.sm_dtid,d.dt_name,j.sj_name,s.sm_sj_id";

//另一个
String sqltj1="select s.sm_id,count(*) as ccc from tb_sms s,tb_subject j,tb_deptinfo d ";
sqltj1+="where s.sm_dtid = d.dt_id and s.sm_sj_id = j.sj_id and s.sm_tel is not null";
if(!dt_id.equals(""))
{
	sqltj1+="and s.sm_dtid="+dt_id+"";
}
if(!sj_id.equals(""))
{
	sqltj1+=" and s.sm_sj_id="+sj_id+"";
}
sqltj1+=" and s.sm_flagtoo=10 and s.sm_check=2";
if(!sm_flags.equals(""))
{
	sqltj1+=" and s.sm_flag="+sm_flags+" ";
}
if(!end_date.equals("")){
sqltj1+=" and floor(to_date('"+end_date+"','yyyy-MM-dd')-to_date(to_char(s.sm_sendtime,'yyyy-MM-dd'),'yyyy-MM-dd'))>0 "; 
}
if(!start_date.equals("")){
sqltj1+=" and floor(to_date(to_char(s.sm_sendtime,'yyyy-MM-dd'),'yyyy-MM-dd')-to_date('"+start_date+"','yyyy-MM-dd'))>0";
}
sqltj1+=" group by s.sm_id";

///统计选中的组合
vectorPage1 = dImpl.splitPageOpt(sqltj1,request,100);
if(vectorPage1!=null)
{
	for(int i=0;i<vectorPage1.size();i++)
	{
		Hashtable contentfj = (Hashtable)vectorPage1.get(i);
		sm_ids += contentfj.get("sm_id").toString()+",";
	}
	if(sm_ids.endsWith(",")){
		sm_ids = sm_ids.substring(0,sm_ids.length()-1);
	}
}
//呵呵
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
            <td width="16%" class="outset-table" nowrap>部门ID</td>
            <td width="48%" class="outset-table" nowrap>部门名称</td>
            <td width="15%" nowrap class="outset-table">所属栏目</td>
            <td width="15%" nowrap class="outset-table">部门发布的信息数</td>
            <td width="21%" nowrap class="outset-table">查看详情</td>
         </tr>
<%
  if(vectorPage!=null)
  {
    int coo=0;
	int cee=0;
    for(int j=0;j<vectorPage.size();j++)
    {
      Hashtable content = (Hashtable)vectorPage.get(j);
	  String sm_dtid = content.get("sm_dtid").toString();
	  String dt_name = content.get("dt_name").toString();
	  String sj_name = content.get("sj_name").toString();
	  String sj_id123 = content.get("sm_sj_id").toString();
	  String ccc=content.get("ccc").toString();
	  coo=Integer.parseInt(ccc);
	  cee+=coo;
	  
	  
      if(j % 2 == 0)  out.print("<tr class=\"line-even\">");
      else out.print("<tr class=\"line-odd\">");
%>

                <tr><td align=center nowrap ><%=sm_dtid%></td>
                <td align="center" nowrap><%=dt_name%></td>
                <td align=center nowrap><%=sj_name%></td>
                <td align=center nowrap><%=coo%></td>
                 <td align=center><a href="msDetail.jsp?sj_name=<%=sj_name%>&sm_idms=<%=sm_ids%>&sj_id=<%=sj_id123%>&sm_flag=<%=sm_flags%>&sm_dtid=<%=sm_dtid%>">查看</a></td>
                </tr>

<%
    }
%>
                <tr><td colspan="2" align=center nowrap >&nbsp;</td>
                <td align=center nowrap><span class="STYLE1">本页总记录数为</span></td>
                <td align=center nowrap><span class="STYLE1"><%=cee%></span></td>
                 <td align=center><span class="STYLE1">条</span></td>
                </tr>
<%
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
}catch(Exception e){
  out.print(e.toString());
}finally{
  dImpl.closeStmt();
  dCn.closeCn();
  }
%>
<%@ include file="../skin/bottom.jsp"%>
