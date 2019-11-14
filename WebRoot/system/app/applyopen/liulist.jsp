<%@page contentType="text/html; charset=GBK"%>
<%@include file="/system/app/skin/head.jsp"%>
<%
String pname = "";
String ename = "";
String infoid = "";
String infotitle = "";
String applytime = "";
String genre = "";
String status = "";
String dname = "";
String sqlStr = "";
String sqlWhere = "";
String strTitle = "";
String iid = "";
String dt_id = "";
String flownum = "";
String signmode = "";
String s_flownum = "";
String s_keyword = "";
//
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

strTitle = "信息公开一体化 > 流水号查询";

sqlStr = "select i.id iid,i.infoid,i.infotitle,i.proposer,i.pname,i.ename,to_char(i.applytime,'yyyy-mm-dd') applytime,i.indexnum,i.flownum,i.commentinfo,i.signmode,i.dname from infoopen i where 1=1 "+sqlWhere+" order by i.applytime desc";
vPage = dImpl.splitPage(sqlStr,request,20);
%>
<script language="javascript" src="applyopen.js"></script>
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

<table WIDTH="100%" BORDER="0" CELLSPACING="1" CELLPADDING="1">
<form name="formSearch" method="post" action="liulist.jsp">
<tr>
	<td align="left" width="220">流水号：<input name="s_flownum" type="text"></td>
	<td align="left" width="250">信息关键字：<input name="s_keyword" type="text"></td>
	<td align="left" width="50" nowrap><input class="bttn" type="submit" value="检索"></td>
</tr></form>
</table>

<table class="FindAreaTable1" cellspacing="1" rules="cols" border="0" id="ctl00_DataGrid_DataGrid1" style="border-width:0px;">
<tr class="bttn">
	<td width="2%" class="outset-table"><font color="gray">*</font></td>
	<td width="15%" class="outset-table">事项流水号</td>
	<td width="30%" class="outset-table">申请信息描述</td>
	<td width="15%" class="outset-table">申请时间</td>
	<td width="10%" class="outset-table">受理方式</td>
	<td width="15%" class="outset-table">登记部门</td>
	<td width="5%" class="outset-table">指定</td>
	<td width="5%" class="outset-table" nowrap>办理</td>
</tr>
<form name="formData" >
<%
String commentinfo = "";
if(vPage!=null){
	for(int i=0; i<vPage.size(); i++){
		content = (Hashtable)vPage.get(i);
		commentinfo = CTools.dealNull(content.get("commentinfo"));
		dname = CTools.dealNull(content.get("dname"));
		flownum = CTools.dealNull(content.get("flownum"));
		applytime = CTools.dealString(content.get("applytime"));
		signmode = CTools.dealNull(content.get("signmode"));

		iid = CTools.dealNull(content.get("iid"));
		if(commentinfo.length()>18) commentinfo = commentinfo.substring(0,17) + "...";
		commentinfo = commentinfo.replaceAll("&","&amp;");
		commentinfo = commentinfo.replaceAll("<","&lt;");
		commentinfo = commentinfo.replaceAll(">","&gt;");
		commentinfo = commentinfo.replaceAll("\"","&quot;");
		if(i%2 == 0) out.print("<tr class=\"line-even\">");
		else out.print("<tr class=\"line-odd\">");
%>
	<td align="center"><font color="red">*</font></td>
	<td align="center"><%=flownum%></td>
	<td align="left"><%=commentinfo%></td>
	<td align="center"><%=applytime%></td>
	<td align="center"><%
	if(signmode.equals("0")){
		out.println("网上申请");
	}else if(signmode.equals("1")){
		out.println("现场申请");
	}else if(signmode.equals("2")){
		out.println("E-mail申请");
	}else if(signmode.equals("3")){
		out.println("信函申请");
	}else if(signmode.equals("4")){
		out.println("电报申请");
	}else if(signmode.equals("5")){
		out.println("传真申请");
	}else if(signmode.equals("6")){
		out.println("其他");
	}
	else{
		out.println("--");	
	}%></td>
	<td align="center"><%=dname.equals("")?"--":dname%></td>
	<td align="center">--<%//=content.get("genre")%></td>
	<td align="center"><a href="taskInfo.jsp?iid=<%=iid%>"><img class="hand" border="0" src="../../images/modi.gif" title="办理" WIDTH="16" HEIGHT="16"></a></td>
</tr>
<%
	}
	out.print("</form>");
}else{
	out.println("<tr><td colspan=20>没有信息！</td></tr>");
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