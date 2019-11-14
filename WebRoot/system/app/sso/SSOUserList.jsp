<%@page contentType="text/html; charset=GBK"%>
<%@include file="/system/app/skin/head.jsp"%>
<script language="javascript">
function formSubmit(position)
{
	var form = document.formData;
	form.action="AdvList.jsp?ai_position="+position;
	form.submit();
}

function ShowAdv(ai_id,width,height)
{
	var w = width ;
	var h = height;
	var url = "ViewAdv.jsp?ai_id="+ai_id+"&width="+width+"&height="+height;
	window.open( url, "", "Top=100px,Left=200px,Width="+w+"px, Height="+h+"px,toolbar=no,location=no,derectories=no,status=no,menubar=no,scrollbars=no" );
}
</script>
<%	
//update by 20090429

CDataCn dCn=null;   //新建数据库连接对象
CDataImpl dImpl=null;  //新建数据接口对象

try {
dCn = new CDataCn(); 
dImpl = new CDataImpl(dCn); 

String ai_position = CTools.dealString(request.getParameter("ai_position")).trim();
String OPType = CTools.dealString(request.getParameter("OPType")).trim();
String strTitle = "";
String strSelect = "单点登录管理";
String Operate = "";
String sqlwhereep = "";
String sqlwherearea = "";
String sqlwherehire = "";
String sqlwhereStatus = "";

Operate = "操作";

String sqlStr = "select s.us_id,s.us_sso,i.ui_uid,i.ui_name from tb_userinfo i,tb_usersso s where i.ui_id = s.ui_id order by s.ui_id";

String us_id = "";
String us_sso = "";
String ui_uid = "";
String ui_name = "";
%>
<%@include file="/system/app/skin/skin4/template/list_top.jsp"%>
<!--    模块名称开始    -->
<%=strSelect%>
<!--    模块名称结束    -->
<%@include file="/system/app/skin/skin4/template/list_function.jsp"%>                                                            
<!--    功能按钮开始    -->
<img src="../../images/new.gif" border="0" onclick="window.location='SSOUserInfo.jsp?OPType=Addnew'" title="新增" style="cursor:hand" align="absmiddle" WIDTH="16" HEIGHT="16">
新增
<img src="../../images/goback.gif" border="0" onclick="javascript:history.back();" title="返回" style="cursor:hand" align="absmiddle">
返回
<!--    功能按钮结束    -->
<%@include file="/system/app/skin/skin4/template/list_listtop.jsp"%>                                                                                        
<!--    列表开始    -->
<table class="FindAreaTable1" cellspacing="1" rules="cols" border="0" id="ctl00_DataGrid_DataGrid1" style="border-width:0px;">
<form name="formData">
	<tr class="bttn" width="100%" height="22">
		<td align="center" background="../../skin/skin1/images/background-_15a.gif" width="30%">浦东用户</td>
		<td align="center" background="../../skin/skin1/images/background-_15a.gif" width="50%">统一授权用户</td>
		<td align="center" background="../../skin/skin1/images/background-_15a.gif" width="10%">修改</td>
	</tr>
<%
Vector vPage = dImpl.splitPage(sqlStr,request,20);
if (vPage != null)
{
  for(int j=0;j<vPage.size();j++)
  {
   Hashtable content = (Hashtable)vPage.get(j);
   us_id = content.get("us_id").toString();
   us_sso = content.get("us_sso").toString();
   ui_uid = content.get("ui_uid").toString();
   ui_name = content.get("ui_name").toString();
   if(j % 2 == 0)  out.print("<tr class=\"line-even\">");
   else out.print("<tr class=\"line-odd\">");
 %>
  <td align="center"><%=ui_uid%></td>
  <td align="center"><%=us_sso%></td>
  <td align="center"><a href="SSOUserInfo.jsp?OPType=Edit&us_id=<%=us_id%>"><img class="hand" border="0" src="../../images/modi.gif" title="编辑" WIDTH="16" HEIGHT="16"></a></td>
 </tr>
<%
  }
%>
</form>
<%
}
else
{
	out.println("<tr><td colspan=\"17\">没有记录！</td></tr>");
}
%>
</table>
<!--    列表结束    -->
<%@include file="/system/app/skin/skin4/template/list_bottom.jsp"%> 
<%
}
catch(Exception ex){
	System.out.println(new java.util.Date() + "--"
			+ request.getServletPath() + " : " + ex.getMessage());
}
finally{
	dImpl.closeStmt();
	dCn.closeCn(); 
}
%>
<%@include file="/system/app/skin/bottom.jsp"%>