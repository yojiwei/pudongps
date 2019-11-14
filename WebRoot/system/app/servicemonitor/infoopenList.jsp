<%@page contentType="text/html; charset=GBK"%>
<%@include file="/system/app/skin/head.jsp"%>
<%
//update by yo 20091230
String pname = "";
String ename = "";
String infoid = "";
String infotitle = "";
String applytime = "";
String genre = "";
String status = "";

String sqlStr = "";
String sqlWhere = "";
String strTitle = "";
String status_name = "";
String dt_id = "";
String dt_name = "";

String s_flownum = "";
String s_keyword = "";
String info_id = "";
String infostatus = "";

CDataCn dCn = null;
CDataImpl dImpl = null;

Vector vPage = null;
Hashtable content = null;

try{
dCn = new CDataCn();
dImpl = new CDataImpl(dCn);

CMySelf mySelf = (CMySelf)session.getAttribute("mySelf");
if (mySelf!=null){
	dt_id = Long.toString(mySelf.getDtId());
}

s_flownum = CTools.dealString(request.getParameter("s_flownum")).trim();
s_keyword = CTools.dealString(request.getParameter("s_keyword")).trim();

if(!s_flownum.equals("")) sqlWhere += " and i.flownum='"+s_flownum+"'";
if(!s_keyword.equals("")) sqlWhere += " and i.commentinfo like'%"+s_keyword+"%'";

sqlWhere += " and i.applytime > to_date('2009-12-30','yyyy-MM-dd') ";

strTitle = "信息公开一体化 > 依申请公开";

sqlStr = "select i.id iid,i.infoid,i.infotitle,i.proposer,i.status,i.pname,i.ename,to_char(i.applytime,'yyyy-mm-dd') applytime,i.indexnum,i.flownum,i.commentinfo,i.signmode,i.dname,t.id as tid,d.dt_name from infoopen i,taskcenter t,tb_deptinfo d where i.id=t.iid and t.did=d.dt_id and i.status in(1,16) and i.checktype<>9 "+sqlWhere+" order by i.applytime desc";


vPage = dImpl.splitPage(sqlStr,request,20);
%>
<%@include file="/system/app/skin/skin4/template/list_top.jsp"%>
<!--    模块名称开始    -->
<%=strTitle%>
<!--    模块名称结束    -->
<%@include file="/system/app/skin/skin4/template/list_function.jsp"%>                                                            
<!--    功能按钮开始    -->
<img src="../../images/goback.gif" border="0" onclick="javascript:history.back();" title="返回" style="cursor:hand" align="absmiddle">
返回								
<!--    功能按钮结束    -->
<%@include file="/system/app/skin/skin4/template/list_listtop.jsp"%>                                          
<!--    列表开始    -->
<script language="javascript" src="applyopen.js"></script>
<table class="FindAreaTable1" cellspacing="1" rules="cols" border="0" id="ctl00_DataGrid_DataGrid1" style="border-width:0px;">		
<tr class="line-even">
<td colspan="9" align="center">
<form name="formSearch" method="post" action="infoopenList.jsp">
<table WIDTH="100%" BORDER="0" CELLSPACING="1" CELLPADDING="1">
	<tr>
		<td align="left" width="220">流水号：<input name="s_flownum" type="text"></td>
		<td align="left" width="250">信息关键字：<input name="s_keyword" type="text"></td>
		<td align="left" width="50" nowrap><input class="bttn" type="submit" value="检索"></td>
		<td align="left" nowrap>&nbsp;</td>
	</tr>
</table>
</td></form>
</tr>
<tr class="bttn">
	<td width="15%" class="outset-table">事项流水号</td>
	<td width="30%" class="outset-table">申请信息标题</td>
	<td width="15%" class="outset-table">申请状态</td>
	<td width="15%" class="outset-table">申请时间</td>
	<td width="10%" class="outset-table">受理方式</td>
	<td width="15%" class="outset-table">登记部门</td>
	<td width="5%" class="outset-table" nowrap>办理</td>
</tr>
<%
out.println("<form name=\"formData\" method=\"post\">");
String commentinfo = "";
if(vPage!=null){
	for(int i=0; i<vPage.size(); i++){
		content = (Hashtable)vPage.get(i);
		info_id = CTools.dealNull(content.get("iid"));
		infostatus = CTools.dealNull(content.get("status"));
		infotitle = CTools.dealNull(content.get("infotitle"));
		commentinfo = CTools.dealNull(content.get("commentinfo"));
		if(commentinfo.length()>18) commentinfo = commentinfo.substring(0,17) + "...";
		commentinfo = commentinfo.replaceAll("&","&amp;");
		commentinfo = commentinfo.replaceAll("<","&lt;");
		commentinfo = commentinfo.replaceAll(">","&gt;");
		commentinfo = commentinfo.replaceAll("\"","&quot;");
		status_name = "1".equals(infostatus)?"正待调用":"调用失败";
		dt_name = CTools.dealNull(content.get("dt_name"));
		if(i%2 == 0) out.print("<tr class=\"line-even\">");
		else out.print("<tr class=\"line-odd\">");
%>
	<td align="center"><%=content.get("flownum")%></td>
	<td align="left"><a href="../applyopen/applyView.jsp?iid=<%=info_id%>"><%=infotitle%></a></td>
	<td align="center"><%=status_name%></td>
	<td align="center"><%=content.get("applytime")%></td>
	<td align="center"><%
	if(content.get("signmode").toString().equals("0")){
		out.println("网上申请");
	}else if(content.get("signmode").toString().equals("1")){
		out.println("现场申请");
	}else if(content.get("signmode").toString().equals("2")){
		out.println("E-mail申请");
	}else if(content.get("signmode").toString().equals("3")){
		out.println("信函申请");
	}else if(content.get("signmode").toString().equals("4")){
		out.println("电报申请");
	}else if(content.get("signmode").toString().equals("5")){
		out.println("传真申请");
	}else if(content.get("signmode").toString().equals("6")){
		out.println("其他");
	}
	else{
		out.println("--");	
	}%></td>
	<td align="center"><%=dt_name%></td>
	<!--td align="center"><a href="../applyopen/taskInfo.jsp?iid=<%=content.get("iid")%>&tid=<%=content.get("tid")%>"><img class="hand" border="0" src="../../images/modi.gif" title="查看" WIDTH="16" HEIGHT="16"></a></td-->
	<td align="center"><a href="<%="1".equals(infostatus)?"#":"infoopenDetail.jsp?info_id="+info_id%>"><img class="hand" border="0" src="../../images/modi.gif" title="修改" WIDTH="16" HEIGHT="16"></a></td>
</tr>
<%
	}
	out.println("</form>");
}else{
	out.println("<tr><td colspan=20></td></tr>");
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