<%@page contentType="text/html; charset=GBK"%>
<%@ page import="com.beyondbit.web.publishinfo.Messages" %>
<script LANGUAGE="javascript" src="./common/common.js"></script>
<%
String strTitle = "信息维护";

//判断是否需要审核
String audit = CTools.dealString(request.getParameter("audit"));
if(!audit.equals(""))
{
  strTitle = "审核";
}
//

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
<%
//update20080122

CDataCn dCn=null;   //新建数据库连接对象
CDataImpl dImpl=null;  //新建数据接口对象

try {
 dCn = new CDataCn(); 
 dImpl = new CDataImpl(dCn); 

String sj_id="";//栏目id
String sj_dir="pudongWeekly";//栏目名
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
if(myProject!=null && myProject.isLogin())
{
  uiid = Long.toString(myProject.getMyID());
}
else
{
  uiid= "2";
}

/*得到当前登陆的用户id  结束*/

/*生成栏目列表  开始*/
String subject_ids="";
String subjectCode="";
subjectCode=CTools.dealString(request.getParameter("subjectCode")).trim();
String strSelect="";

/*生成栏目列表  结束*/
if (subject_ids.length()>0){
  subject_ids=subject_ids.substring(0,subject_ids.length()-1);
}

//out.print(subject_ids);
/*得到是否审核的标志  开始  1=审核  0=该栏目不要审核 */
String NeedAudit="0";
String auditsql="";


//audit=CTools.dealString(request.getParameter("audit")).trim();
/*得到是否审核的标志  结束*/

String sj_ids="";

String sWhere="";

Hashtable content = null;
Vector vectorPage = null;

if(!myProject.getMyName().equals("超级管理员")) {
	//out.println(myProject.getMyName());
	sWhere += " and t.ur_id=" + uiid;
}

//if(!sj_id.equals("")&&!sj_id.equals("0")) sWhere = " and ','||t.sj_id||',' like '%," + sj_id + ",%'";

//if(!sj_dir.equals("")) sWhere += " and s.sj_dir='" + sj_dir + "'"; //&&!sj_id.equals("0")&&!sj_id.equals("-1")
//out.print(subjectCode);

/*
if (NeedAudit.equals("1"))
{
  sWhere=sWhere + " and t.ct_publish_flag=0 ";
  strTitle="信息审核";
}
*/

//if(!sj_id.equals("")&&!sj_id.equals("0")) sWhere = " and ct.sj_id = " + sj_id ;

String strSql="";

String subIds = "";
strSql = "select sj_id from tb_subject connect by prior sj_id = sj_parentid start with sj_dir = '"+sj_dir+"'";
vectorPage = dImpl.splitPage(strSql,1000,1);
if(vectorPage!=null){
	for(int i=0; i<vectorPage.size(); i++){
		content = (Hashtable)vectorPage.get(i);
		subIds += content.get("sj_id").toString();
		if(vectorPage.size()!=i+1) subIds += ",";
	}
}

if(audit.equals(""))
{
  strSql = "select * from (select distinct t.sj_name, t.ct_id,t.ct_create_time,t.ct_title,t.ct_updatetime,t.ct_publish_flag,t.dt_id,d.dt_name,ct_sequence,t.sj_id from tb_content t,tb_deptinfo d,tb_contentpublish ct ,tb_subject s where ct.sj_id =s.sj_id and t.dt_id=d.dt_id and ct.ct_id=t.ct_id " + sWhere + " and ct.sj_id in ("+subIds+") order by to_date(t.ct_create_time,'YYYY-MM-DD') desc,t.ct_id desc) where rownum<=200" ;
 //out.println(strSql);
}
else if (audit.equals("true"))
{
  //strSql = "select t.ct_id,t.ct_create_time,t.ct_publish_flag,t.ct_focus_flag,t.ct_updatetime,t.ct_image_flag,t.ct_message_flag,t.ct_title,t.ct_sequence,t.dt_id,s.sj_name,d.dt_name from tb_content t,tb_subject s,tb_deptinfo d where 1=1 and t.dt_id=d.dt_id and t.sj_id=s.sj_id and t.ct_publish_flag <> 1 "+ sWhere +" and s.sj_id in(select sj_id from tb_auditrole where  tr_id in (select tr_id from tb_roleinfo where tr_userids like '%,"+uiid+",%')) order by to_date(t.ct_create_time,'YYYY-MM-DD') desc,t.ct_id desc";
}
vectorPage = dImpl.splitPageOpt(strSql,request,20);
//out.println(request.getParameter("strPage"));

%>

 <table class="main-table" width="100%">
    <tr>
  <td width="100%">
       <table class="content-table" width="100%">
		 <form name="formData">
     <INPUT TYPE="hidden" name="subjectCode" value="<%=subjectCode%>">
     <INPUT TYPE="hidden" name="curpage" value="<%=CTools.dealNumber(request.getParameter("strPage"))%>">
     <INPUT TYPE="hidden" name="audit" value="<%=audit%>">

        <tr class="title1">
            <td colspan="7" align="center">
                <table WIDTH="100%" BORDER="0" CELLSPACING="1" CELLPADDING="1">
                    <tr>
                        <td valign="center" nowrap><%=strTitle%></td>
			<td valign="center" align=left><%//=strSelect%></td>
			<td valign="center" align="left">
				<!-- 栏目选择：
            	<input type="hidden" name="sj_id" class="text-line" style="cursor:hand" value="<%=sj_id%>" />
	            <input type="text" name="sjName1" class="text-line" style="cursor:hand" onclick="fnSelectSJ2(0,0);" readonly="true" size="40" value="<%=sjName1%>" />
	            <input type="hidden" name="autho_Ids" value="" />
	            <input type="hidden" name="autho_Names" value="" /> -->
			</td>
                        <td valign="center" align="right" nowrap>

                            <img src="/system/images/split.gif" align="middle" border="0" WIDTH="5" HEIGHT="8">
                            <img src="/system/images/new.gif" border="0" onclick="window.location='PublishInfoZB.jsp?OPType=Add&sj_id=<%=sj_id%>&subjectCode=<%=subjectCode%>&audit=false'" title="新增信息" style="cursor:hand" align="absmiddle" WIDTH="16" HEIGHT="16">
                            <!-- img src="/system/images/split.gif" align="middle" border="0" WIDTH="5" HEIGHT="8">
                            <img src="/system/images/dialog/sort.gif" border="0" onclick="setSequence()" title="修改排序" style="cursor:hand" align="absmiddle" WIDTH="15" HEIGHT="15"-->
                            <img src="/system/images/split.gif" align="middle" border="0" WIDTH="5" HEIGHT="8">
                            <img src="/system/images/menu_about.gif" border="0" onclick="javascript:window.location.href='publishSearch.jsp' " title="查找" style="cursor:hand" align="absmiddle">
                            <img src="/system/images/split.gif" align="middle" border="0" WIDTH="5" HEIGHT="8">
                            <img src="/system/images/goback.gif" border="0" onclick="javascript:history.back();" title="返回" style="cursor:hand" align="absmiddle">
                            <img src="/system/images/split.gif" align="middle" border="0" WIDTH="5" HEIGHT="8">
   </td>
  </tr>
 </table>
  </td>
        </tr>
        <tr class="bttn">
            <td width="36%" class="outset-table">信息主题</td>
            <!-- td width="10%" class="outset-table">分类</td-->
            <td width="16%" class="outset-table">发布栏目</td>
            <td width="11%" class="outset-table">发布日期</td>
            <td width="10%" class="outset-table">部门</td>
            <td width="11%" class="outset-table">更新时间</td>
            <td width="8%" class="outset-table">评论数</td>
            <!-- td width="8%" class="outset-table">排序</td-->
            <td width="8%" class="outset-table" nowrap>
            <%
            //if (NeedAudit.equals("1"))
            //{
            //out.print("审核");
            //}
            //else
            //{
            out.print("操作");
            //}
            %>
            </td>
        </tr>
<%
  if(vectorPage!=null)
  {
    for(int j=0;j<vectorPage.size();j++)
    {
      content = (Hashtable)vectorPage.get(j);
      String ct_updatetime = CTools.dealString(content.get("ct_updatetime").toString());
      if(j % 2 == 0)  out.print("<tr class=\"line-even\">");
      else out.print("<tr class=\"line-odd\">");
%>

                <td ><img border="0" src="/system/images/arrow_yellow.gif" WIDTH="15" HEIGHT="13">&nbsp;&nbsp;<a href="PublishEditZB.jsp?OPType=Edit&ct_id=<%=content.get("ct_id")%>&subjectCode=<%=subjectCode%>&curpage=<%=CTools.dealNumber(request.getParameter("strPage"))%>&audit=<%=audit%>"><%=content.get("ct_title")%></a></td>
                <td align="center" ><%=content.get("sj_name")%></td>
                <td align="center" nowrap><%=content.get("ct_create_time")%></td>
                <td align=center nowrap><%=content.get("dt_name")%></td>
                <td align=center><%=ct_updatetime%></td>
                <td align=center>
                <%
                String auditNum = "0";
                String answerNum = "0"; 
                String tot = "0";
                String auditSql = "select count(cc_id) as audit from tb_contentcomment where cc_publish_flag = '0' and cc_corid_name = 'ct_id' and cc_corid_value = '"+ content.get("ct_id") +"'";
                String answerSql = "select count(cc_id) as answer from tb_contentcomment where cc_answer_time is null and cc_corid_name = 'ct_id' and cc_corid_value = '"+ content.get("ct_id") +"'";
                String totSql = "select count(cc_id) as tot from tb_contentcomment where cc_corid_name = 'ct_id' and cc_corid_value = '"+ content.get("ct_id") +"'";
                Hashtable audit_content = dImpl.getDataInfo(auditSql);
                if (audit_content != null)
                {
                auditNum = audit_content.get("audit").toString();
                }
                Hashtable answer_content = dImpl.getDataInfo(answerSql);
                if (answer_content != null)
                {
                answerNum = answer_content.get("answer").toString();
                }
                Hashtable tot_content = dImpl.getDataInfo(totSql);
                if (tot_content != null)
                {
                tot = tot_content.get("tot").toString();
                }
                out.println("<strong><a href='commentListZB.jsp?ct_id=" + content.get("ct_id") + "&publishFlag=0' title='待审核评论数' style='cursor:hand'><font color='#FF0000'>" + auditNum + "</font></a>/ <a href='commentListZB.jsp?ct_id=" + content.get("ct_id") + "&answerFlag=0' title='待答复评论数' style='cursor:hand'><font color='#0000FF'>" + answerNum + "</font></a>/ <a href='commentListZB.jsp?ct_id=" + content.get("ct_id") + "' title='评论总数' style='cursor:hand'>" + tot + "</a></strong>");
                %>
                </td>
                <!-- td align=center><input type=text class=text-line name='<%//="module"+content.get("ct_id").toString()%>' value="<%//=content.get("ct_sequence").toString()%>" size=4 maxlength=4></td-->
                <td align="center" nowrap><a href="PublishEditZB.jsp?OPType=Edit&ct_id=<%=content.get("ct_id")%>&subjectCode=<%=subjectCode%>&curpage=<%=CTools.dealNumber(request.getParameter("strPage"))%>&audit=<%=audit%>"><img class="hand" border="0" src="
                <%
                if (audit.equals("true"))
                {
                out.print("/system/images/dialog/hammer.gif\" title=审核");
                }
                else
                {
                out.print("/system/images/modi.gif\" title=编辑");
                }
                %>
                  WIDTH="16" HEIGHT="16"></a>
								&nbsp;
								<a href="javascript:delcontent('<%=content.get("ct_id")%>');">
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

function delcontent(ctId){
var objhttpPending=new ActiveXObject("Msxml2.XMLHTTP");
	var objxmlPending =	objxmlPending=new ActiveXObject("Microsoft.XMLDOM");

		strA = "abc"

		objhttpPending.Open("post","http://<%=request.getServerName()%>:<%=request.getServerPort()%>/system/app/infopublish/deleteZB.jsp?ct_id=" + ctId ,true);
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
