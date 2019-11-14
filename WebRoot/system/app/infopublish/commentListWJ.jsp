<%@page contentType="text/html; charset=GBK"%>
<%@ page import="com.beyondbit.web.publishinfo.Messages" %>
<script LANGUAGE="javascript" src="./common/common.js"></script>
<%
String strTitle = "评论列表";

%>
<%@include file="../../manage/head.jsp"%>
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

<head>
<meta http-equiv="pragma" content="no-cache">

<%
//update20080122

CDataCn dCn=null;   //新建数据库连接对象
CDataImpl dImpl=null;  //新建数据接口对象

try {
 dCn = new CDataCn(); 
 dImpl = new CDataImpl(dCn); 

String Ct_id = CTools.dealString(request.getParameter("ct_id"));
String publishFlag = CTools.dealString(request.getParameter("publishFlag"));
String answerFlag = CTools.dealString(request.getParameter("answerFlag"));

String cc_id = ""; //评论id
String cc_us_ip = "";  //评论者ip
String cc_us_name = "";  //评论者姓名
String cc_publish_flag = "";  //是否发布标志
String cc_create_time = "";  //评论时间
String cc_content = "";  //评论内容
String cc_answer_time = "";  //评论答复时间
String cc_answer = "";  //评论答复内容

String sWhere="";
if (publishFlag.equals("0"))
{
  sWhere += "cc_publish_flag = '0' and ";
  strTitle = "待审核评论列表";
}
if (answerFlag.equals("0"))
{
  sWhere += "cc_answer_time is null and ";
  strTitle = "待回复评论列表";
}


Hashtable content = null;
Vector vectorPage = null;

String strSql="";

String subIds = "";
strSql = "select cc_id,cc_us_ip,cc_us_name,cc_publish_flag,cc_create_time,cc_content,cc_answer_time,cc_answer from tb_contentcomment where " + sWhere + " cc_corid_name = 'ct_id' and cc_corid_value = '"+ Ct_id +"' order by cc_create_time desc";
vectorPage = dImpl.splitPage(strSql,request,20);

%>

 <table class="main-table" width="100%">
    <tr>
  <td width="100%">
       <table class="content-table" width="100%">
		 <form name="formData">
     <INPUT TYPE="hidden" name="curpage" value="<%=CTools.dealNumber(request.getParameter("strPage"))%>">
        <tr class="title1">
            <td colspan="7" align="center">
                <table WIDTH="100%" BORDER="0" CELLSPACING="1" CELLPADDING="1">
                    <tr>
                        <td valign="center" nowrap><%=strTitle%></td>
                        <td valign="center" align="right" nowrap>
                            <img src="/system/images/split.gif" align="middle" border="0" WIDTH="5" HEIGHT="8">
                            <img src="/system/images/menu_about.gif" border="0" onclick="javascript:window.location.href='commentSearch.jsp' " title="查找" style="cursor:hand" align="absmiddle">
                            <img src="/system/images/split.gif" align="middle" border="0" WIDTH="5" HEIGHT="8">
                            <img src="/system/images/goback.gif" border="0" onclick="javascript:history.back();" title="返回" style="cursor:hand" align="absmiddle">
                            <img src="/system/images/split.gif" align="middle" border="0" WIDTH="5" HEIGHT="8">
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr class="bttn">
            <td width="40%" class="outset-table">留言内容</td>
            <td width="30%" class="outset-table">留言者信息</td>
            <td width="12%" class="outset-table">留言日期</td>
            <td width="10%" class="outset-table">留言者IP</td>
            <td width="8%" class="outset-table" nowrap>操作</td>
        </tr>
<%
  if(vectorPage!=null)
  {
    for(int j=0;j<vectorPage.size();j++)
    {
      content = (Hashtable)vectorPage.get(j);
      if(j % 2 == 0)  out.print("<tr class=\"line-even\">");
      else out.print("<tr class=\"line-odd\">");
      	
      cc_id = content.get("cc_id").toString();
      cc_us_ip = content.get("cc_us_ip").toString();
      cc_us_name = content.get("cc_us_name").toString();
      cc_publish_flag = content.get("cc_publish_flag").toString();
      cc_create_time = content.get("cc_create_time").toString();
      cc_content = content.get("cc_content").toString();
      cc_answer_time = content.get("cc_answer_time").toString();
      cc_answer = content.get("cc_answer").toString();
	  if(cc_content.length()>41){
		  cc_content = cc_content.substring(0,40)+"...";
	  }
%>

                <td ><img border="0" src="/system/images/arrow_yellow.gif" WIDTH="15" HEIGHT="13">&nbsp;&nbsp;<a href="commentInfoWJ.jsp?cc_id=<%=cc_id%>&ct_id=<%=Ct_id%>" title="点击答复"><%=cc_content%></a></td>
                <td align="center" ><%=cc_us_name%></td>
                <td align="center"><%=cc_create_time%></td>
                <td align=center><%=cc_us_ip%></td>
                <td align="center" nowrap>
								<a href="commentInfoWJ.jsp?cc_id=<%=cc_id%>&ct_id=<%=Ct_id%>">
								<img class="hand" border="0" src="../../images/modi.gif" <%if (cc_answer_time.equals("")) out.println("title='答复'"); else out.println("title='查看'");%> WIDTH="16" HEIGHT="16"></a>
								&nbsp;
								<a href="javascript:delcomment('<%=cc_id%>');">
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
    out.println("<tr><td colspan=6>该新闻没有相关评论记录！</td></tr>");
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

function delcomment(ccId){
var objhttpPending=new ActiveXObject("Msxml2.XMLHTTP");
	var objxmlPending =	objxmlPending=new ActiveXObject("Microsoft.XMLDOM");

		strA = "abc"

		objhttpPending.Open("post","http://<%=request.getServerName()%>:<%=request.getServerPort()%>/system/app/infopublish/deletecommentZB.jsp?cc_id=" + ccId ,true);
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