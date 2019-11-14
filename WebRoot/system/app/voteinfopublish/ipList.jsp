<%@page contentType="text/html; charset=GBK"%>
<%@ page import="com.beyondbit.web.publishinfo.Messages" %>
<script LANGUAGE="javascript" src="./common/common.js"></script>
<%
String strTitle = "IP地址配置";

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

String sj_id="";//栏目id
sj_id=CTools.dealNumber(request.getParameter("sj_id")).trim();
String selDt_id = "";//部门id
selDt_id = CTools.dealString(request.getParameter("dt_id")).trim();
String dt_id   = "";
String dt_name = "";
String dtSql   = "";
String isadmin = CTools.dealString(request.getParameter("isadmin"));
String sjName1 = CTools.dealString(request.getParameter("sjName1"));
//dtSql = "select dt_id,dt_name from tb_deptinfo where 1=1 order by dt_sequence,dt_id desc";
//Vector dtList  = dImpl.splitPage(dtSql,100,1);


/*得到当前登陆的用户id  开始*/
String uiid="";
CMySelf myProject = (CMySelf)session.getAttribute("mySelf");
if(myProject!=null && myProject.isLogin()){
	uiid = Long.toString(myProject.getMyID());
}else{
	uiid= "2";
}

/*得到当前登陆的用户id  结束*/

String strSql = "select il_id,il_status,il_begin,il_end,il_date from tb_iplist" ;

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

                            <img src="/system/images/split.gif" align="middle" border="0" WIDTH="5" HEIGHT="8">
                            <img src="/system/images/new.gif" border="0" onclick="window.location='ipInfo.jsp?OPType=Add'" title="新增信息" style="cursor:hand" align="absmiddle" WIDTH="16" HEIGHT="16">
                            <!-- img src="/system/images/split.gif" align="middle" border="0" WIDTH="5" HEIGHT="8">
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
            <td width="40%" class="outset-table">起始地址</td>
            <td width="40%" class="outset-table">结束地址</td>
            <td width="10%" class="outset-table" nowrap>操作</td>
        </tr>
<%
  if(vectorPage!=null)
  {
    for(int j=0;j<vectorPage.size();j++)
    {
      Hashtable content = (Hashtable)vectorPage.get(j);
      String il_id = content.get("il_id").toString();
	    String il_begin = content.get("il_begin").toString();
	    String il_end = content.get("il_end").toString();
	    String il_status = content.get("il_status").toString();
	    String il_date = content.get("il_date").toString();

      if(j % 2 == 0)  out.print("<tr class=\"line-even\">");
      else out.print("<tr class=\"line-odd\">");
%>

                <td ><%=j+1%></td>
                <td align="center" nowrap><%=content.get("il_begin")%></td>
                <td align=center nowrap><%=content.get("il_end")%></td>
                <td align="center" nowrap><a href="ipInfo.jsp?OPType=Edit&il_id=<%=content.get("il_id")%>"><img class="hand" border="0" src="/system/images/modi.gif" title=编辑 WIDTH="16" HEIGHT="16"></a>
								&nbsp;
								<a href="/system/app/pinfopublish/delete.jsp?il_id=<%=il_id%>">
								<img class="hand" border="0" src="../../images/delete.gif" title="删除" WIDTH="16" HEIGHT="16" onclick="return window.confirm('确认要删除该记录么?');"></a>
								</td>
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
%>
<%@ include file="../skin/bottom.jsp"%>
<script LANGUAGE="javascript">
	function onChange()
	{
		var sj_id;
		var audit;
                sj_id=formData.sj_id.value;
                audit=formData.audit.value;
		formData.action='publishList.jsp?sj_id='+sj_id+'&audit='+audit;
		formData.submit();
	}

function setSequence()
{
	//var form = document.formData ;
	document.formData.action = "setSequence.jsp";
	document.formData.submit();
}

function delcontent(ilId){
var objhttpPending=new ActiveXObject("Msxml2.XMLHTTP");
	var objxmlPending =	objxmlPending=new ActiveXObject("Microsoft.XMLDOM");
		strA = "abc"

		objhttpPending.Open("post","<%=Messages.getString("xmlHttp")%>/system/app/pinfopublish/delete.jsp?il_id=" + ilId ,true);
		objhttpPending.setRequestHeader("Content-Length",strA.length);
		objhttpPending.setRequestHeader("CONTENT-TYPE","application/x-www-form-urlencoded");



		objhttpPending.onreadystatechange = function (){
			var statePending = objhttpPending.readyState;
		    if (statePending == 4)
		    {
		    	var returnvalue = objhttpPending.responsetext;
		    	alert(returnvalue);
		    	if(returnvalue.indexOf("yes")!=-1){
		    		document.location.reload();
		    	}
			}
		};

		objhttpPending.Send(strA);

}
</script>


<%


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