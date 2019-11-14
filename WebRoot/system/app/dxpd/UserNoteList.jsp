<%@page contentType="text/html; charset=GBK"%>
<%@ page import="com.beyondbit.web.publishinfo.Messages" %>
<%@page import="com.util.*"%>
<%@page import="Evaluate.*"%>
<%@page import="vote.*"%>
<%@page import="java.text.*"%>
<%@page import="java.util.Date"%>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.util.Vector" %>
<script LANGUAGE="javascript" src="common/common.js"></script>

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
String strTitle = "用户订阅短信信息维护";
CDataCn dCn = new CDataCn(); //新建数据库连接对象
CDataImpl dImpl = new CDataImpl(dCn); //新建数据接口对象

String bootid = "";
CMySelf mySelf = (CMySelf)session.getAttribute("mySelf");
String subjectCode="";
subjectCode=CTools.dealString(request.getParameter("subjectCode")).trim();
String strSql1 = "select sj_id from tb_subjectsub where dt_id = '" + mySelf.getDtId() + "' and sj_parentid=0";

Vector vectorPage = null;
Vector vectorPage123 = null;
Hashtable contentSJ = dImpl.getDataInfo(strSql1);

if(contentSJ!=null)
	bootid = contentSJ.get("sj_id").toString();
else
	bootid = "0";

String ct_id="";
String cna_str="";
Vector vPage=null;


String sj_id="";//栏目id
sj_id=CTools.dealNumber(request.getParameter("sj_id")).trim();
//out.println("woshixiaowei"+sj_id);
String selDt_id = "";//部门id
selDt_id = CTools.dealString(request.getParameter("dt_id")).trim();
String dt_id   = "";
String dt_name = "";
String dtSql   = "";
String mydir="";
String isadmin = CTools.dealString(request.getParameter("isadmin"));
String sjName1 = CTools.dealString(request.getParameter("sjName1"));

String sql="select t.sj_id,t.sj_dir from tb_subject t connect by prior t.sj_id=t.sj_parentid start with t.sj_parentid="+sj_id;
ResultSet rs=dImpl.executeQuery(sql);
boolean canAdd=!rs.next(); //说明它是最后一个节点

String mysql="select sj_dir from tb_subject where sj_id="+sj_id;
vectorPage123 = dImpl.splitPageOpt(mysql,request,15);
if(vectorPage123!=null)
{
    for(int q=0;q<vectorPage123.size();q++)
    {
      Hashtable content123 = (Hashtable)vectorPage123.get(q);
	  mydir=content123.get("sj_dir").toString();
	}
}

String strSql="";
if(canAdd) //只显示它下面的所有信息
{
//strSql="select distinct s.content,s.sendtime, b.sj_name,s.sendflag,s.sj_id";//这个暂时用不到耶!s.subscibeid,
//strSql+=" from subscibelog s left join tb_subject b on s.sj_id = b.sj_id where";
//strSql+=" s.sj_id="+sj_id+" and b.sj_name is not null order by s.sendtime desc";

strSql="select s.*,b.sj_name from tb_sms s left join tb_subject b on s.sm_sj_id=b.sj_id where s.sm_sj_id="+sj_id+" ";
strSql+="and s.sm_tel is null and s.sm_flag!=0 and s.sm_flagtoo=10";
strSql+=" order by s.sm_sendtime desc ";
}
else  //显示子栏目下的所有信息
{
//strSql="select distinct s.content,s.sendtime,j.sj_name,s.sendflag,s.sj_id";//s.subscibeid,
//strSql+=" from subscibelog s left join tb_subject j on s.sj_id = j.sj_id where s.sj_id in(";
//strSql+=" select t.sj_id  from tb_subject t connect by prior t.sj_id=t.sj_parentid start with t.sj_parentid='"+sj_id+"')  order by  s.sendtime desc desc";

strSql="select s.*,b.sj_name from tb_sms s left join tb_subject b on s.sm_sj_id=b.sj_id  ";
strSql+="where s.sm_tel is null and s.sm_flag!=0 and s.sm_flagtoo=10";
strSql+=" and s.sm_sj_id in (select t.sj_id  from tb_subject t connect by prior t.sj_id=t.sj_parentid start with t.sj_parentid='"+sj_id+"')";
strSql+=" order by s.sm_sendtime desc ";

}
vectorPage = dImpl.splitPageOpt(strSql,request,15);

//out.println(strSql);
%>

 <table class="main-table" width="100%">
    <tr>
  <td width="100%">
       <table class="content-table" width="100%">
	   
<form name="formData">
<INPUT TYPE="hidden" name="subjectCode" value="<%=subjectCode%>">
<INPUT TYPE="hidden" name="curpage" value="<%=CTools.dealNumber(request.getParameter("strPage"))%>">

	           <tr class="title1">
            <td colspan="5" align="center">
                <table WIDTH="100%" BORDER="0" CELLSPACING="1" CELLPADDING="1">
                    <tr>
                        <td valign="center" nowrap><%=strTitle%></td>
			<td valign="center" align=left></td>

                      <td valign="center" align="right" nowrap>
<%
if (canAdd&&!mydir.equals("dxdy")&&!mydir.equals("dyphb")&&!mydir.equals("tuiding")&&!mydir.equals("dxhelp")&&!mydir.equals("backusercenter")){ //栏目树的子节点才可以发布信息
%>
                            <img src="images/split.gif" align="middle" border="0" WIDTH="5" HEIGHT="8">
<img src="images/new.gif" border="0" onClick="window.location='SendNote.jsp?OPType=Add&sj_id=<%=sj_id%>&subjectCode=<%=subjectCode%>&audit=false'" title="新增信息" style="cursor:hand" align="absmiddle" WIDTH="16" HEIGHT="16">
<%
    }
%>

                          <img src="images/split.gif" align="middle" border="0" WIDTH="5" HEIGHT="8">
                          <img src="images/menu_about.gif" width="16" height="16" border="0" align="absmiddle" style="cursor:hand" title="查找" onClick="javascript:window.location.href='/system/app/infopublish/publishSearch.jsp' ">
                          <img src="images/split.gif" align="middle" border="0" WIDTH="5" HEIGHT="8">
                          <img src="images/goback.gif" width="16" height="16" border="0" align="absmiddle" style="cursor:hand" title="返回" onClick="javascript:history.back();">
                          <img src="images/split.gif" align="middle" border="0" WIDTH="5" HEIGHT="8">   </td>
  </tr>
 </table>  </td>
        </tr>
        <tr class="bttn">
            <td width="32%" class="outset-table" nowrap>信息主题</td>
            <td width="14%" class="outset-table" nowrap>发布日期</td>
            <td width="22%" nowrap class="outset-table">所属栏目</td>
            <td nowrap class="outset-table">发送状态</td>
            <td width="11%" class="outset-table" nowrap>
             操作</td>
        </tr>
<%
  if(vectorPage!=null)
  {
    for(int j=0;j<vectorPage.size();j++)
    {
      Hashtable content = (Hashtable)vectorPage.get(j);
	  String sendtime =CTools.getDate(CTools.dealString(content.get("sm_sendtime").toString()));
	  String sm_id = content.get("sm_id").toString();
	  String content1 = content.get("sm_con").toString();
	  String sj_name = content.get("sj_name").toString();
	  String sendflag = content.get("sm_flag").toString();
	  String sm_check = content.get("sm_check").toString();
	  String sj_iid = content.get("sm_sj_id").toString();
	  String sm_ct_id=content.get("sm_ct_id").toString();
	  String ct_content = content.get("sm_detail").toString();
	  
      if(j % 2 == 0)  out.print("<tr class=\"line-even\">");
      else out.print("<tr class=\"line-odd\">");
%>

                <td ><img border="0" src="images/arrow_yellow.gif" WIDTH="15" HEIGHT="13">&nbsp;<%=content1%></td>
                <td align="center" nowrap><%=sendtime%></td>
                <td align=center nowrap><%=sj_name%></td>
                 <td align=center>
				 <%
				 //sendflag状态0发送失败1发送成功2未发送3正在发送中4只是保存
				  if(sendflag.equals("1")){
				  out.print("已发送");
				  }
				  else if(sendflag.equals("2")){
				  if(sm_check.equals("1")){
				  	out.print("待审核");
				  }else if(sm_check.equals("3")){
				  	out.print("审核不通过");
				  }
				  }
				   else if(sendflag.equals("3")){ //sendflag==3标志正在发送中.....
					out.print("审核通过待发送");
				  }
				  else if(sendflag.equals("4")){ //sendflag==4暂时保存
out.print("<a href=\"SendNoteResult.jsp?sendtime="+sendtime+"&sm_id="+sm_id+"&content1="+content1+"&sjId="+sj_iid+"&sm_ct_id="+sm_ct_id+"&CT_content="+ct_content+"&ttid=1\">暂存</a>");
				  }
				  %></td>
                <td align="center" nowrap>
<a href="javascript:delcontent('<%=sm_id%>','<%=CTools.htmlEncode(content.get("sm_con").toString())%>','<%=sj_id%>');">
<img class="hand" border="0" src="../../images/delete.gif" title="删除" WIDTH="16" HEIGHT="16" onClick="return window.confirm('确认要删除该记录么?');"></a>
                </td>
            </tr>

<%
    }
%>
</form>
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

function delcontent(ctId,ctTitle,sj_id){
  window.location.href="NoteDelete.jsp?ct_id="+ctId +"&ctTitle=" +ctTitle+"&sj_id="+sj_id+"";

}
</script>