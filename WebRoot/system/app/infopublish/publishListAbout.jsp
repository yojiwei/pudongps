<%
/**************************************
this page is made by honeyday 2002-12-6
***************************************/
%>
<%@page contentType="text/html; charset=GBK"%>
<%@ page import="com.beyondbit.web.publishinfo.Messages" %>
<script LANGUAGE="javascript" src="./common/common.js"></script>
<%
  String strTitle = "关键字：";
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
<script language="javascript">
  function doAction() {
  var num = document.getElementsByName("checkAt").length;//formData.checkAt.length;
  var bool = false;
  if (num != 1) {
	  for (var i = 0;i < num;i++) {
	    if (formData.checkAt[i].checked)
	      bool = true;
	  }
  }
  else {
	if (formData.checkAt.checked)
		bool = true;
  }
  if (bool == false) {
    alert("请选择您要关联的新闻！");
    return false;
  }
  formData.action = "publishListAboutResult.jsp";
  formData.submit();
}
function doDel(cna_id,ct_id) {
  if (confirm("确实要删除这条相关新闻吗?")) {
    location.href = "publishListAboutDel.jsp?OPType=Edit&cna_id="+cna_id+"&ct_id="+ct_id;
  }
}
</script>
<%
    //update20080122

CDataCn dCn=null;   //新建数据库连接对象
CDataImpl dImpl=null;  //新建数据接口对象

try {
 dCn = new CDataCn(); 
 dImpl = new CDataImpl(dCn); 

    String ct_keywords = CTools.dealString(request.getParameter("ct_keywords")).trim();
    String ct_id = CTools.dealString(request.getParameter("ct_id")).trim();
    String OPType = CTools.dealString(request.getParameter("OPType")).trim();
    String strSql = "";
	String ct_str = "";
	Vector vectorPage = null;
	Hashtable content = null;
    if (OPType.equals("Add")) {
      strSql ="select t.ct_id from tb_content t,tb_deptinfo d where t.ct_title like '%" + ct_keywords + "%' and t.dt_id=d.dt_id";
	  
	  vectorPage = dImpl.splitPageOpt(strSql,2000,1);
      if (vectorPage!=null){
		   for(int i=0;i<vectorPage.size();i++){
			   content = (Hashtable)vectorPage.get(i);
			   ct_str += content.get("ct_id")+",";
		   }
		  if (!ct_str.equals("")) ct_str =ct_str.substring(0,ct_str.length()-1);
	  }  
	  
	  strSql = "select * from (select distinct t.ct_id,t.ct_create_time,t.ct_title,t.ct_updatetime,t.ct_publish_flag,t.dt_id,d.dt_name,ct_sequence,t.sj_id from tb_content t,tb_deptinfo d,tb_subject s,tb_contentpublish ct where t.dt_id=d.dt_id and s.sj_id=ct.sj_id and ct.ct_id=t.ct_id and t.ct_delflag = 0 and t.ct_id in("+ct_str+") and ct.cp_ispublish='1' order by to_date(t.ct_create_time,'YYYY-MM-DD') desc,t.ct_id desc) where rownum<=50";
	  
	 // strSql = "select * from (select distinct t.ct_id,t.ct_create_time,t.ct_title,t.ct_updatetime,t.ct_publish_flag,t.dt_id,d.dt_name,ct_sequence,t.sj_id from tb_content t,tb_subject s,tb_deptinfo d,tb_contentpublish ct where t.dt_id=d.dt_id and s.sj_id=ct.sj_id and ct.ct_id=t.ct_id and t.ct_delflag = 0 and t.ct_title like '%" + ct_keywords + "%' and ct.cp_ispublish='1' order by to_date(t.ct_create_time,'YYYY-MM-DD') desc,t.ct_id desc) where rownum<=50";
    }
    else {
      strSql = "select distinct n.cna_id,c.ct_title,c.ct_create_time,c.ct_url,c.ct_specialflag,c.ct_updatetime,t.dt_name" +
               " from tb_content c,tb_countnewsabout n,tb_contentpublish p,tb_subject s,tb_deptinfo t where " +
               "c.ct_id = n.ct_id_at and  p.ct_id = c.ct_id and s.sj_id = p.sj_id and t.dt_id = c.dt_id and n.ct_id = " +
               ct_id + " and c.ct_delflag = 0 and cp_ispublish='1' order by to_date(c.ct_create_time,'YYYY-MM-DD') desc";
    }
	
    vectorPage = dImpl.splitPageOpt(strSql,request,50);
%>
 <table class="main-table" width="100%">
    <tr>
  <td width="100%">
       <table class="content-table" width="100%">
		 <form name="formData">
		<input type="hidden" name="ct_id" value="<%=ct_id%>">
		<input type="hidden" name="ct_keywords" value="<%=ct_keywords%>">
		<input type="hidden" name="OPType" value="<%=OPType%>">
        <tr class="title1">
            <td colspan="7" align="center">
                <table WIDTH="100%" BORDER="0" CELLSPACING="1" CELLPADDING="1">
                    <tr>
                        <td valign="center" nowrap>
                        	<%=strTitle%><%=ct_keywords%>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        	<a href="publishListAbout.jsp?ct_id=<%=ct_id%>&OPType=Edit">查看相关新闻</a>
                        </td>
			<td valign="center" align=left></td>
			<td valign="center" align="left"></td>
			<td valign="center" align="right" nowrap>
<%
					if (OPType.equals("Add")){
%>
					<img src="/system/images/split.gif" align="middle" border="0" WIDTH="5" HEIGHT="8">				
					<img src="/system/images/modi.gif" border="0" onclick="doAction();" title="添加" style="cursor:hand" align="absmiddle" WIDTH="16" HEIGHT="16">
<%
					}
%>
					<img src="/system/images/split.gif" align="middle" border="0" WIDTH="5" HEIGHT="8">
					<img src="/system/images/goback.gif" border="0" onclick="javascript:history.back();" title="返回" style="cursor:hand" align="absmiddle">
					<img src="/system/images/split.gif" align="middle" border="0" WIDTH="5" HEIGHT="8">
   </td>
  </tr>
 </table>
  </td>
        </tr>
        <tr class="bttn">
            <td width="40%" class="outset-table">信息主题</td>
            <td width="10%" class="outset-table">发布日期</td>

            <td width="15%" class="outset-table">部门</td>
            <td width="16%" class="outset-table">更新时间</td>
            <td width="8%" class="outset-table" nowrap>操作</td>
        </tr>
<%
  if(vectorPage!=null)
  {
    for(int j=0;j<vectorPage.size();j++)
    {
      content = (Hashtable)vectorPage.get(j);
      String ct_updatetime = CTools.dealNull(content.get("ct_updatetime"));
      if(j % 2 == 0)  out.print("<tr class=\"line-even\">");
      else out.print("<tr class=\"line-odd\">");
%>
                <td ><img border="0" src="/system/images/arrow_yellow.gif" WIDTH="15" HEIGHT="13">&nbsp;<a href="PublishEdit.jsp?OPType=Edit&ct_id=<%=content.get("ct_id")%>&curpage=<%=CTools.dealNumber(request.getParameter("strPage"))%>"><%=content.get("ct_title")%></a></td>
                <td align="center" nowrap><%=content.get("ct_create_time")%></td>
                <td align=center nowrap><%=content.get("dt_name")%></td>
                <td align=center><%=ct_updatetime%></td>
                <td align="center" nowrap>
                <%if (OPType.equals("Add")) {%>
                <a href="PublishEdit.jsp?OPType=Edit&ct_id=<%=content.get("ct_id")%>&curpage=<%=CTools.dealNumber(request.getParameter("strPage"))%>"><img class="hand" border="0" src="/system/images/dialog/modi.gif" title="查看" WIDTH="16" HEIGHT="16"></a>
				&nbsp;<input type="checkbox" name="checkAt" value="<%=content.get("ct_id")%>">
				<%}else{%>
                <a href="#" onClick="doDel(<%=content.get("cna_id")%>,<%=ct_id%>);"><img class="hand" border="0" src="/system/images/dialog/delete.gif" title="删除" WIDTH="16" HEIGHT="16"></a>
                <%}%>
				</td>
            </tr>

<%
    }
%>
</form>
<%
  }
  else {
    out.println("<tr><td colspan=7>没有相关记录！</td></tr>");
  }
%>
</table>
        </td>
    </tr>
</table>
</html>
</body>
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