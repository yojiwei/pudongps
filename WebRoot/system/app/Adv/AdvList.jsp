<%@page contentType="text/html; charset=GBK"%>
<%@include file="/system/manage/head.jsp"%>
<%@include file="/system/app/skin/skin3/headold.jsp"%>
<%@include file="/system/app/islogin.jsp"%>
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
	com.app.CMySelf ms = new com.app.CMySelf();
	ms = (com.app.CMySelf)session.getAttribute("mySelf");
	long myId = ms.getMyID();
	String userId = ms.getMyUid();
	
CDataCn dCn = new CDataCn();
CDataImpl dImpl = new CDataImpl(dCn);
//ddd dd = new ddd();

String ai_position = CTools.dealString(request.getParameter("ai_position")).trim();
String OPType = CTools.dealString(request.getParameter("OPType")).trim();
String strTitle = "";
String strSelect = "";
String Operate = "";
String sqlwhereep = "";
String sqlwherearea = "";
String sqlwherehire = "";
String sqlwhereStatus = "";

Operate = "操作";

if(ai_position.equals(""))
{
	ai_position = "0";
}
if(!ai_position.equals("0"))
{
	sqlwhereStatus = " and ai_position=" + ai_position;
}


	String ssql = "";
	
	if (!userId.equals("administrator")) {
		sqlwhereStatus += " and p.ur_id like'%" + myId + "%'";
		ssql = "select ap_name,ap_id from tb_advposition where ur_id like '%" + myId + "%' order by ap_id";
	}
	else {
		ssql = "select ap_name,ap_id from tb_advposition order by ap_id";
	}

String sqlStr = "select a.ai_id,a.ai_type,a.ai_name,to_char(a.ai_date,'yyyy-mm-dd') ai_date,a.ai_isok,a.ai_position,t.at_name as at_name,p.ap_name as ap_name,p.ap_width,p.ap_height from tb_advinfo a,tb_advtype t,tb_advposition p where a.ai_type=t.at_id and a.ai_position = p.ap_id"+ sqlwhereStatus + " order by a.ai_id desc";

//out.println(sqlStr);
String ai_id = "";
String ai_type = "";
String ai_name = "";
String ai_date = "";
String ai_isok = "";
String _name = "";
String __name = "";

String ap_width = "";
String ap_height = "";

//out.println(ssql);
Vector svectorPage = dImpl.splitPage(ssql,1000,1);
if(svectorPage!=null)
{
	strSelect = strSelect + "<select name=\"ai_position\" onchange=\"javascript:formSubmit(this.value);\">";
	strSelect = strSelect + "<option value=\"0\">－－选择所有位置－－</option>";
	for(int j=0;j<svectorPage.size();j++)
	{
		Hashtable scontent = (Hashtable)svectorPage.get(j);
		String ap_id = scontent.get("ap_id").toString();
		String ap_name = scontent.get("ap_name").toString();
		strSelect = strSelect + "<option value="+ap_id;
		if(ap_id.equals(ai_position))
		{
			strSelect = strSelect + " selected";
		}
		strSelect = strSelect + ">" + ap_name + "</option>";
	}
	strSelect = strSelect + "</select>";
}
%>
<table class="main-table" width="100%">
<form name="formData">
	<tr>
		<td width="100%" colspan="7" height="22">
			<table border="0" width="100%" cellspacing="0" cellpadding="0" class="content-table">
				<tr class="title1">
					<td align="left"><%//=strTitle%>&nbsp;&nbsp;<%=strSelect%></td>
					<td valign="center" align="right"  >
						<img src="../../images/split.gif" align="middle" border="0" WIDTH="5" HEIGHT="8">
						<!-- <img src="../../images/menu_about.gif" border="0" onclick="javascript:window.location='AdvSearch.jsp';" title="查询" style="cursor:hand" align="absmiddle">
						<img src="../../images/split.gif" align="middle" border="0" WIDTH="5" HEIGHT="8"> -->
						<img src="../../images/new.gif" border="0" onclick="window.location='AdvInfo.jsp?OPType=Addnew'" title="新增项目信息" style="cursor:hand" align="absmiddle" WIDTH="16" HEIGHT="16">
						<img src="../../images/split.gif" align="middle" border="0" WIDTH="5" HEIGHT="8">
						<img src="../../images/goback.gif" border="0" onclick="javascript:history.back();" title="返回" style="cursor:hand" align="absmiddle">
						<img src="../../images/split.gif" align="middle" border="0" WIDTH="5" HEIGHT="8">&nbsp;  
					</td>
				</tr>
			</table>
		</td>
	</tr>
	<tr class="bttn" width="100%" height="22">
		<td align="center" background="../../skin/skin1/images/background-_15a.gif" width="10%">图片链接ID</td>
		<td align="center" background="../../skin/skin1/images/background-_15a.gif" width="30%">图片链接名称</td>
		<td align="center" background="../../skin/skin1/images/background-_15a.gif" width="15%">图片链接类型</td>
		<td align="center" background="../../skin/skin1/images/background-_15a.gif" width="15%">图片链接位置</td>
		<td align="center" background="../../skin/skin1/images/background-_15a.gif" width="15%">发布时间</td>
		<td align="center" background="../../skin/skin1/images/background-_15a.gif" width="5%">状态</td>
		<td align="center" background="../../skin/skin1/images/background-_15a.gif" width="10%"><%=Operate%></td>
	</tr>
<%
Vector vPage = dImpl.splitPage(sqlStr,request,20);
if (vPage != null)
{
  for(int j=0;j<vPage.size();j++)
  {
   Hashtable content = (Hashtable)vPage.get(j);
   ai_id = content.get("ai_id").toString();
   ai_type = content.get("ai_type").toString();
   ai_name = content.get("ai_name").toString();
   ai_date = content.get("ai_date").toString();
   ai_isok = content.get("ai_isok").toString();
   ai_position = content.get("ai_position").toString();
   _name = content.get("at_name").toString();
   __name = content.get("ap_name").toString();
   ap_width = content.get("ap_width").toString();
   ap_height = content.get("ap_height").toString();
   if(j % 2 == 0)  out.print("<tr class=\"line-even\">");
   else out.print("<tr class=\"line-odd\">");
 %>
  <td align="center"><%=ai_id%></td>
  <td align="center"><a href="javascript:ShowAdv('<%=ai_id%>','<%=ap_width%>','<%=ap_height%>');" title="<%=ai_name%>"><%=ai_name%></a></td>
  <td align="center"><%=_name%></td>
  <td align="center"><%=__name%></td>
  <td align="center"><%=ai_date%></td>
  <td align="center"><%if(ai_isok.equals("0")) out.println("停用");else if(ai_isok.equals("1")) out.println("启用");%></td>
  <td align="center"><a href="AdvInfo.jsp?OPType=Edit&ai_id=<%=ai_id%>"><img class="hand" border="0" src="../../images/modi.gif" title="编辑" WIDTH="16" HEIGHT="16"></a></td>
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
<!-- <tr><td colspan="7" align="center"><a href="Example.jsp">前台显示范例</a></td></tr> -->
</table>
<%
dImpl.closeStmt();
dCn.closeCn();
%>
<%@ include file="/system/app/skin/bottom.jsp"%>
