<%@page contentType="text/html; charset=GBK"%>
<%@include file="../skin/head.jsp"%>
<script language="javascript">
function formSubmit(position)
{
	var form = document.formData;
	form.action="AdvList.jsp?ai_position="+position;
	form.submit();
}

function ShowAdv(ai_id)
{
	var w = 400 ;
	var h = 270;
	var url = "ShowAdv.jsp?ai_id="+ai_id;
	window.open( url, "", "Top=100px,Left=200px,Width="+w+"px, Height="+h+"px,toolbar=no,location=no,derectories=no,status=no,menubar=no,scrollbars=no" );
}
</script>
<%
//update20080122

CDataCn dCn=null;   //新建数据库连接对象
CDataImpl dImpl=null;  //新建数据接口对象

try {
 dCn = new CDataCn(); 
 dImpl = new CDataImpl(dCn); 

String OPType = CTools.dealString(request.getParameter("OPType")).trim();
String strTitle = "";
String Operate = "";

Operate = "操作";

String sqlStr = "select p.*,f.af_name from tb_advposition p,tb_advform f where p.ap_form=f.af_id order by ap_id desc";
//out.println(sqlStr);
String ap_id = "";
String ap_name = "";
String ap_code = "";
String ap_width = "";
String ap_height = "";
String af_name = "";
%>
<table class="main-table" width="100%">
<form name="formData">
	<tr>
		<td width="100%" colspan="7" height="22">
			<table border="0" width="100%" cellspacing="0" cellpadding="0" class="content-table">
				<tr class="title1">
					<td valign="center" align="right"  >
						<!-- <img src="../../images/split.gif" align="middle" border="0" WIDTH="5" HEIGHT="8">
						<img src="../../images/menu_about.gif" border="0" onclick="javascript:window.location='PositionSearch.jsp';" title="查询" style="cursor:hand" align="absmiddle"> -->
						<img src="../../images/split.gif" align="middle" border="0" WIDTH="5" HEIGHT="8">
						<img src="../../images/new.gif" border="0" onclick="window.location='PositionInfo.jsp?OPType=Addnew'" title="新增项目信息" style="cursor:hand" align="absmiddle" WIDTH="16" HEIGHT="16">
						<img src="../../images/split.gif" align="middle" border="0" WIDTH="5" HEIGHT="8">
						<img src="../../images/goback.gif" border="0" onclick="javascript:history.back();" title="返回" style="cursor:hand" align="absmiddle">
						<img src="../../images/split.gif" align="middle" border="0" WIDTH="5" HEIGHT="8">&nbsp;  
					</td>
				</tr>
			</table>
		</td>
	</tr>
	<tr class="bttn" width="100%" height="22">
		<td align="center" background="../../skin/skin1/images/background-_15a.gif" width="10%">ID</td>
		<td align="center" background="../../skin/skin1/images/background-_15a.gif" width="25%">名称</td>
		<td align="center" background="../../skin/skin1/images/background-_15a.gif" width="15%">类型</td>
		<td align="center" background="../../skin/skin1/images/background-_15a.gif" width="15%">代码</td>
		<td align="center" background="../../skin/skin1/images/background-_15a.gif" width="10%">图片链接宽度</td>
		<td align="center" background="../../skin/skin1/images/background-_15a.gif" width="10%">图片链接高度</td>
		<td align="center" background="../../skin/skin1/images/background-_15a.gif" width="10%"><%=Operate%></td>
	</tr>
<%
Vector vPage = dImpl.splitPage(sqlStr,request,20);
if (vPage != null)
{
  for(int j=0;j<vPage.size();j++)
  {
   Hashtable content = (Hashtable)vPage.get(j);
   ap_id = content.get("ap_id").toString();
   ap_name = content.get("ap_name").toString();
   af_name = content.get("af_name").toString();
   ap_code = content.get("ap_code").toString();
   ap_width = content.get("ap_width").toString();
   ap_height = content.get("ap_height").toString();
   if(j % 2 == 0)  out.print("<tr class=\"line-even\">");
   else out.print("<tr class=\"line-odd\">");
 %>
  <td align="center"><%=ap_id%></td>
  <td align="center"><%=ap_name%></td>
  <td align="center"><%=af_name%></td>
  <td align="center"><%=ap_code%></td>
  <td align="center"><%=ap_width%></td>
  <td align="center"><%=ap_height%></td>
  <td align="center"><a href="PositionInfo.jsp?OPType=Edit&ap_id=<%=ap_id%>"><img class="hand" border="0" src="../../images/modi.gif" title="编辑" WIDTH="16" HEIGHT="16"></a></td>
 </tr>
<%
  }
%>
</form>
<%
/*分页的页脚模块*/
out.println("<tr><td colspan=7>" + dImpl.getTail(request) + "</td></tr>"); //输出尾部文件
}
else
{
	out.println("<tr><td colspan=\"7\">没有记录！</td></tr>");
}
%>
</table>
<%
dImpl.closeStmt();
dCn.closeCn();
%>
<%@ include file="/system/app/skin/bottom.jsp"%>


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
