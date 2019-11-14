<%@page contentType="text/html; charset=GBK"%>
<%@include file="/system/app/skin/head.jsp"%>

<script LANGUAGE="javascript" src="common/common.js"></script>
<%
String sj_id = "";
String sj_name = "";
String sm_dtid = "";
String us_uid = "";
String sm_tel = "";
String urlurl = "";
String sqltj = "";

CDataCn dCn = null;
CDataImpl dImpl = null;
Hashtable content = null;
Vector vectorPage=null;
try{
dCn = new CDataCn();
dImpl = new CDataImpl(dCn);

urlurl=request.getRequestURI();
if(request.getQueryString()!=null)
{
 urlurl+="?" + CTools.dealString(request.getQueryString());
}

sj_id = CTools.dealString(request.getParameter("sj_id"));
sj_name = CTools.dealString(request.getParameter("sj_name"));

sqltj="select u.us_id,u.us_name,u.us_uid,u.us_cellphonenumber from tb_user u,tb_usertake t,subscibesetting s where u.us_id = t.us_id and t.ut_id = s.userid  and s.subjectid="+sj_id+"";

vectorPage = dImpl.splitPageOpt(sqltj,request,15);
%>
<%@include file="/system/app/skin/skin4/template/list_top.jsp"%>
<!--    模块名称开始    -->
<%=sj_name%>
<!--    模块名称结束    -->
<%@include file="/system/app/skin/skin4/template/list_function.jsp"%>                                                            
<!--    功能按钮开始    -->
<img src="images/goback.gif"width="16" height="16" border="0" align="absmiddle" style="cursor:hand" title="返回" onClick="javascript:history.back();">
返回
<!--    功能按钮结束    -->
<%@include file="/system/app/skin/skin4/template/list_listtop.jsp"%>                                          
<!--    列表开始    -->
<table class="FindAreaTable1" cellspacing="1" rules="cols" border="0" id="ctl00_DataGrid_DataGrid1" style="border-width:0px;">
<tr class="bttn">
    <td width="32%" class="outset-table" nowrap>用户ID</td>
    <td width="30%" class="outset-table" nowrap>用户名称</td>
    <td width="38%" nowrap class="outset-table">手机号码</td>
 </tr>
<%
  if(vectorPage!=null)
  {
    int coo=0;
    for(int j=0;j<vectorPage.size();j++)
    {
      content = (Hashtable)vectorPage.get(j);
		  sm_dtid = CTools.dealNull(content.get("us_id"));
		  us_uid = CTools.dealNull(content.get("us_uid"));
		  sm_tel = CTools.dealNull(content.get("us_cellphonenumber"));
		  
      if(j % 2 == 0)  out.print("<tr class=\"line-even\">");
      else out.print("<tr class=\"line-odd\">");
%>
    <td align=center nowrap ><%=sm_dtid%></td>
    <td align="center" nowrap><%=us_uid%></td>
    <td align=center nowrap><%=sm_tel%></td>
    </tr>
<%
    } 
  }
  else
  {
    out.println("<tr><td colspan=20>没有记录！</td></tr>");
  }
%>
</table>
<!--    列表结束    -->
<%@include file="/system/app/skin/skin4/template/list_bottom.jsp"%> 
<%
}
catch(Exception e){
	System.out.print(e.toString());
}
finally{
	dImpl.closeStmt();
	dCn.closeCn(); 
}
%>
<%@include file="/system/app/skin/bottom.jsp"%>