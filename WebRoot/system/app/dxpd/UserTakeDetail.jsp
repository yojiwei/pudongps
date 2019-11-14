<%@page contentType="text/html; charset=GBK"%>
<%@include file="/system/app/skin/head.jsp"%>
<%
String strTitle="短信栏目订阅一览表";
String subjectname = "";
String  username="";
String  userid="";
String strSql="";
String us_id = "";
String subid = "";
//
CDataCn dCn = null;
CDataImpl dImpl = null;
try{
dCn = new CDataCn();
dImpl = new CDataImpl(dCn);

userid=CTools.dealString(request.getParameter("id")).trim();//表tb_usertake表中的ut_id
us_id=CTools.dealString(request.getParameter("us_id")).trim();//表tb_user表中的用户的登录id

strSql = "select s.sj_name,b.flag,b.id as subid from tb_subject s,subscibesetting b,tb_usertake u where s.sj_id = b.subjectid and b.userid = u.ut_id and u.ut_id = "+userid+"";

%>
<%@include file="/system/app/skin/skin4/template/list_top.jsp"%>
<!--    模块名称开始    -->
<%=username%>,<%=strTitle%>
<!--    模块名称结束    -->
<%@include file="/system/app/skin/skin4/template/list_function.jsp"%>                                                            
<!--    功能按钮开始    -->
<img src="images/goback.gif" border="0" onClick="javascript:history.back();" title="返回" style="cursor:hand" align="absmiddle">
返回    
<!--    功能按钮结束    -->
<%@include file="/system/app/skin/skin4/template/list_listtop.jsp"%>                                                                                        
<!--    列表开始    -->
<table class="FindAreaTable1" cellspacing="1" rules="cols" border="0" id="ctl00_DataGrid_DataGrid1" style="border-width:0px;">
  <tr class="bttn">
  <td width="14%" height="17" class="outset-table">栏目编号</td>
  <td width="46%" class="outset-table">栏目名称</td>
  <td width="12%" class="outset-table">订制与否</td>
  <td width="11%" class="outset-table"> 操作</td>
  </tr>
    <%
    Vector vectorPage = dImpl.splitPage(strSql,request,20);
		  if(vectorPage!=null)
		  {
		  int i=0;
			for(int j=0;j<vectorPage.size();j++)
			{
			  Hashtable content = (Hashtable)vectorPage.get(j);
			  subjectname=CTools.dealNull(content.get("sj_name"));
	  		subid = CTools.dealNull(content.get("subid"));

	  if(j % 2 == 0)  out.print("<tr class=\"line-even\">");
	  else out.print("<tr class=\"line-odd\">"); 
  %>   
	<td align="center"><%=++i%></td>
  <td align="center"><%=subjectname%></td>
  <td align="center">订制成功</td>
  <td align="center">
  <a href="resetTake.jsp?subid=<%=subid%>&ut_id=<%=userid%>">取消该订制</a>
  </td>
  <%
      }
}
else
{
  out.println("<tr><td colspan=20>无记录</td></tr>");
}
%>
</table>
<!--    列表结束    -->
<%@include file="/system/app/skin/skin4/template/list_bottom.jsp"%> 
<%
}
catch(Exception e){
	System.out.println(new java.util.Date() + "--"
			+ request.getServletPath() + " : " + e.getMessage());
}
finally{
	dImpl.closeStmt();
	dCn.closeCn(); 
}
%>
<%@include file="/system/app/skin/bottom.jsp"%>