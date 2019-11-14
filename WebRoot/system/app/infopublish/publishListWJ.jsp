<%@page contentType="text/html; charset=GBK"%>
<%@ page import="com.beyondbit.web.publishinfo.Messages" %>
<script LANGUAGE="javascript" src="./common/common.js"></script>
<%
String strTitle = "问计建言列表";
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


//String sj_dir="comment_";//栏目名
String sWhere="";
Hashtable content = null;
Vector vectorPage = null;

String strSql="";
strSql = "select distinct t.sj_name, t.ct_id,t.ct_create_time,t.ct_title,t.ct_updatetime,t.ct_publish_flag,t.dt_id,t.dt_name,ct_sequence,t.sj_id from tb_content t,tb_contentpublish ct ,tb_subject s,tb_contentcomment cc where s.sj_dir = 'govOpen_wjym' and ct.sj_id =s.sj_id and ct.ct_id=t.ct_id and to_number(cc.cc_corid_value) = t.ct_id order by to_date(t.ct_create_time,'YYYY-MM-DD') desc,t.ct_id desc" ;
//out.println(strSql);
 vectorPage = dImpl.splitPageOpt(strSql,request,20);
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
						<td valign="center" align="left"></td>
						<td valign="center" align="left"></td>
                        <td valign="center" align="right" nowrap>
                           
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
            <td width="16%" class="outset-table">发布栏目</td>
            <td width="11%" class="outset-table">发布日期</td>
            <td width="10%" class="outset-table">部门</td>
            <td width="11%" class="outset-table">更新时间</td>
            <td width="8%" class="outset-table">留言查看</td>
            <td width="8%" class="outset-table" nowrap>操作</td>
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

                <td ><img border="0" src="/system/images/arrow_yellow.gif" WIDTH="15" HEIGHT="13">&nbsp;&nbsp;<a href="PublishEdit.jsp?OPType=Wenji&ct_id=<%=content.get("ct_id")%>&subjectCode=&curpage=<%=CTools.dealNumber(request.getParameter("strPage"))%>&audit="><%=content.get("ct_title")%></a></td>
                <td align="center" ><%=content.get("sj_name")%></td>
                <td align="center" nowrap><%=content.get("ct_create_time")%></td>
                <td align="center" nowrap><%=content.get("dt_name")%></td>
                <td align="center"><%=ct_updatetime%></td>
                <td align="center">
                <%
                String auditNum = "0";
                String answerNum = "0"; 
                String tot = "0";
                //String auditSql = "select count(cc_id) as auditnum from tb_contentcomment where cc_publish_flag = '0' and cc_corid_name = 'ct_id' and cc_corid_value = '"+ content.get("ct_id") +"'";
                //String answerSql = "select count(cc_id) as answer from tb_contentcomment where cc_answer_time is null and cc_corid_name = 'ct_id' and cc_corid_value = '"+ content.get("ct_id") +"'";
                String totSql = "select count(cc_id) as tot from tb_contentcomment where cc_corid_name = 'ct_id' and cc_corid_value = '"+ content.get("ct_id") +"'";				
                /*Hashtable audit_content = dImpl.getDataInfo(auditSql);
                
                if (audit_content != null)
                {
                auditNum = audit_content.get("auditnum").toString();
                }
                Hashtable answer_content = dImpl.getDataInfo(answerSql);
                if (answer_content != null)
                {
                answerNum = answer_content.get("answer").toString();
                }*/
                Hashtable tot_content = dImpl.getDataInfo(totSql);
                if (tot_content != null)
                {
                tot = tot_content.get("tot").toString();
                }
                out.println("<strong><a href='commentListWJ.jsp?ct_id=" + content.get("ct_id") + "' title='点击查看' style='cursor:hand'><font color='#FF0000'>" + tot + "</font></a></strong>");
                %>
                </td>
               
                <td align="center" nowrap><a href="PublishEdit.jsp?OPType=Wenji&ct_id=<%=content.get("ct_id")%>&subjectCode=&curpage=<%=CTools.dealNumber(request.getParameter("strPage"))%>&audit=">
								<img class="hand" border="0" src="
                <%               
                out.print("/system/images/modi.gif\" title=编辑");
              
                %>
                  WIDTH="16" HEIGHT="16"></a>
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
