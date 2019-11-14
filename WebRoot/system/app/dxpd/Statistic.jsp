<%@page contentType="text/html; charset=GBK"%>
<%@include file="/system/app/skin/head.jsp"%>
<%
String strTitle = "用户订阅短信数据统计";
CDataCn dCn = null;
CDataImpl dImpl = null;
String sqltj = "";
Hashtable content = null;
Vector vectorPage=null;
String sj_id = "";
String sj_name = "";
String count = "";
try{
dCn = new CDataCn();
dImpl = new CDataImpl(dCn);

sqltj="select s.subjectid, count(t.ut_id) cou, j.sj_name from subscibesetting s, tb_subject j,tb_usertake t,tb_user u where s.subjectid = j.sj_id and t.ut_id = s.userid and u.us_id = t.us_id  and j.sj_id in(select c.sj_id from tb_subject c connect by prior c.sj_id = c.sj_parentid and c.sj_dir='xxll')group by subjectid,sj_name order by cou desc";

vectorPage = dImpl.splitPageOpt(sqltj,request,15);
%>
<%@include file="/system/app/skin/skin4/template/list_top.jsp"%>
<!--    模块名称开始    -->
<%=strTitle%>
<!--    模块名称结束    -->
<%@include file="/system/app/skin/skin4/template/list_function.jsp"%>                                                            
<!--    功能按钮开始    -->
<img src="images/goback.gif" width="16" height="16" border="0" align="absmiddle" style="cursor:hand" title="返回" onClick="javascript:history.back();">
返回
<!--    功能按钮结束    -->
<%@include file="/system/app/skin/skin4/template/list_listtop.jsp"%>                                                                                        
<!--    列表开始    -->
<table class="FindAreaTable1" cellspacing="1" rules="cols" border="0" id="ctl00_DataGrid_DataGrid1" style="border-width:0px;">
  <tr class="bttn">
      <td width="16%" class="outset-table" nowrap>栏目ID</td>
      <td width="27%" class="outset-table" nowrap>栏目名称</td>
      <td width="21%" nowrap class="outset-table">订阅人数</td>
      <td width="11%" class="outset-table" nowrap>
       排行榜</td>
  </tr>
<%
  if(vectorPage!=null)
  {
   int amount=0;
    for(int j=0;j<vectorPage.size();j++)
    {
      content = (Hashtable)vectorPage.get(j);
		  sj_id = CTools.dealNull(content.get("subjectid"));
		  sj_name = CTools.dealNull(content.get("sj_name"));
		  count = CTools.dealNull(content.get("cou"));
	  
      if(j % 2 == 0)  out.print("<tr class=\"line-even\">");
      else out.print("<tr class=\"line-odd\">");
%>

			<td align=center nowrap ><%=sj_id%></td>
			<td align="center" nowrap><%=sj_name%></td>
			<td align=center><a href="SelectList.jsp?sj_id=<%=sj_id%>&sj_name=<%=sj_name%>"><%=count%></a></td>
			<td align="center" nowrap><%=++amount%></td>
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