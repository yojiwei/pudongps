<%@page contentType="text/html; charset=GBK"%>
<%@ page import="com.beyondbit.web.publishinfo.Messages" %>
<script LANGUAGE="javascript" src="./common/common.js"></script>
<%
String strTitle = "网站访问量统计";

%>
<%@include file="../../manage/head.jsp"%>
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
//update20080122

CDataCn dCn=null;   //新建数据库连接对象
CDataImpl dImpl=null;  //新建数据接口对象

try {
 dCn = new CDataCn(); 
 dImpl = new CDataImpl(dCn); 

/*得到当前登陆的用户id  开始*/
String uiid="";
CMySelf myProject = (CMySelf)session.getAttribute("mySelf");
if(myProject!=null && myProject.isLogin()){
	uiid = Long.toString(myProject.getMyID());
}else{
	uiid= "2";
}

/*得到当前登陆的用户id  结束*/

String strSql = "select sj_id,vc_count from tb_visitcount where sj_id = 0" ;

Vector vectorPage = dImpl.splitPageOpt(strSql,request,20);

%>

 <table class="main-table" width="100%">
    <tr>
  <td width="100%">
       <table class="content-table" width="100%">
		 <form name="formData">
        <tr class="title1">
            <td colspan="7" align="center">
                <table WIDTH="100%" BORDER="0" CELLSPACING="1" CELLPADDING="1">
                    <tr>
                        <td valign="center" nowrap><%=strTitle%></td>
			<td valign="center" align=left><%//=strSelect%></td>
			
                        <td valign="center" align="right" nowrap>

                            <!-- <img src="/system/images/split.gif" align="middle" border="0" WIDTH="5" HEIGHT="8">
                            <img src="/system/images/new.gif" border="0" onclick="window.location='ipInfo.jsp?OPType=Add'" title="新增信息" style="cursor:hand" align="absmiddle" WIDTH="16" HEIGHT="16">
                            img src="/system/images/split.gif" align="middle" border="0" WIDTH="5" HEIGHT="8">
                            <img src="/system/images/dialog/sort.gif" border="0" onclick="setSequence()" title="修改排序" style="cursor:hand" align="absmiddle" WIDTH="15" HEIGHT="15"-->
                            <!-- <img src="/system/images/split.gif" align="middle" border="0" WIDTH="5" HEIGHT="8">
                            <img src="/system/images/menu_about.gif" border="0" onclick="javascript:window.location.href='publishSearch.jsp' " title="查找" style="cursor:hand" align="absmiddle"> -->
                            <img src="/system/images/split.gif" align="middle" border="0" WIDTH="5" HEIGHT="8">
                            <img src="/system/images/goback.gif" border="0" onclick="javascript:history.back();" title="返回" style="cursor:hand" align="absmiddle">
                            <img src="/system/images/split.gif" align="middle" border="0" WIDTH="5" HEIGHT="8">
   </td>
  </tr>
 </table>
  </td>
        </tr>
        <tr class="bttn">
            <td width="10%" class="outset-table">&nbsp;</td>
            <td width="40%" class="outset-table">&nbsp;</td>
            <td width="50%" class="outset-table">访问量</td>
        </tr>
<%
  if(vectorPage!=null)
  {
    for(int j=0;j<vectorPage.size();j++)
    {
      Hashtable content = (Hashtable)vectorPage.get(j);
      String sj_id = content.get("sj_id").toString();
	  String vc_count = content.get("vc_count").toString();

      if(j % 2 == 0)  out.print("<tr class=\"line-even\">");
      else out.print("<tr class=\"line-odd\">");
%>

                <td align="center"><%=j+1%></td>
                <td align="center" nowrap>网站首页</td>
                <td align=center nowrap><%=content.get("vc_count")%></td>
            </tr>

<%
    }
%>
</form>
<%
      out.println("<tr><td colspan=7>" + dImpl.getTail(request) + "</td></tr>"); //输出尾部文件
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
  dImpl.closeStmt();
  dCn.closeCn();
  } catch (Exception ex) {
	System.out.println(new java.util.Date() + "--"
			+ request.getServletPath() + " : " + ex.getMessage());
} finally {
	if(dImpl != null)
	dImpl.closeStmt();
	if(dCn != null)
	dCn.closeCn();
}
%>
<%@ include file="../skin/bottom.jsp"%>