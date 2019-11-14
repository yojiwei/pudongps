<%@page contentType="text/html; charset=GBK"%>
<%@include file="/system/app/skin/head.jsp"%>
<%
//by ph 2007-3-3  信息公开一体化
String pname = "";
String ename = "";
String infoid = "";
String infotitle = "";
String applytime = "";

String sqlStr = "";
String sqlWhere = "";
String strTitle = "";
String checktype="";//监查类别1指派任务2即将超时
String ids="";

CDataCn dCn = null;
CDataImpl dImpl = null;
CDataImpl dImpl1 = null;

Vector vPage = null;
Vector vpd = null;
Hashtable content = null;
Hashtable content1 = null;

try{
dCn = new CDataCn();
dImpl = new CDataImpl(dCn);
dImpl1 = new CDataImpl(dCn);
ids = CTools.dealString(request.getParameter("ids")).trim();
strTitle = "信息公开一体化 > 事项查看列表";
Object status = null;
status = request.getParameter("status");

sqlStr = "select id,infoid,infotitle,proposer,pname,ename,to_char(applytime,'yyyy-mm-dd') applytime,indexnum,flownum,commentinfo,signmode,dname,checktype from infoopen ";
sqlStr+="where id in ("+ids+")";
sqlStr+=" order by applytime desc ";

//out.println(status+"======"+checktype+"----"+sqlStr);
vPage = dImpl.splitPage(sqlStr,request,20);


String sql = "select dt_id,dt_name from tb_deptinfo where dt_infoopendept = 1 order by dt_sequence";
vpd = dImpl1.splitPage(sql,200,1);
%>
<table class="main-table" width="100%">
	<tr>
		<td width="100%">
			<table class="content-table" width="100%">
				<tr class="title1">
					<td colspan="11" align="center">
						<table WIDTH="100%" BORDER="0" CELLSPACING="1" CELLPADDING="1">
							<tr>
								<td valign="center" align="left"><%=strTitle%></td>
								<td valign="center" align="right" nowrap>
								</td>
							</tr>
						</table></td>
				</tr>
				<tr class="bttn">
					<td width="11%" class="outset-table">事项流水号</td>
					<td width="22%" class="outset-table">申请信息描述</td>
					<td width="11%" class="outset-table">申请时间</td>
					<td width="8%" class="outset-table">受理方式</td>
					<td width="13%" class="outset-table">监查类别</td>
					<td width="21%" class="outset-table">登记部门</td>
					<td colspan="2" class="outset-table">查看</td>
				</tr>
				<form name="formData" method="post">
				<input type="hidden" name="hDepart" />
				<%
				String commentinfo = "";
				if(vPage!=null){
					for(int i=0; i<vPage.size(); i++){
						content = (Hashtable)vPage.get(i);
						commentinfo = content.get("commentinfo").toString();
						if(commentinfo.length()>13) commentinfo = commentinfo.substring(0,12) + "...";
						commentinfo = commentinfo.replaceAll("&","&amp;");
						commentinfo = commentinfo.replaceAll("<","&lt;");
						commentinfo = commentinfo.replaceAll(">","&gt;");
						commentinfo = commentinfo.replaceAll("\"","&quot;");
						if(i%2 == 0) out.print("<tr class=\"line-even\">");
						else out.print("<tr class=\"line-odd\">");
				%>
					<tr class="bttn">
					<td align="center"><%=content.get("flownum")%></td>
					<td align="left"><%=commentinfo%></td>
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
					<td align="center">
					  <%
					  if(content.get("checktype").toString().equals("1"))
					  {
					  	out.println("指派任务");
					  }else if(content.get("checktype").toString().equals("2"))
					  {
					  	out.println("即将超时");
					  }
					  %>
					</td>
					<td align="center"><%=content.get("dname").toString().equals("")?"--":content.get("dname").toString()%>					</td>
					<td align="center">
<a href="taskInfo.jsp?iid=<%=content.get("id")%>"><img class="hand" border="0" src="../../images/modi.gif" title="查看信息" WIDTH="16" HEIGHT="16"></a></td>
				</tr>
				<%
					}
					out.println("</form>");
					out.println("<tr><td colspan=9>" + dImpl.getTail(request) + "</td></tr>");
				}else{
					out.println("<tr><td colspan=9>无记录</td></tr>");
				}
				%>
			</table>
		</td>
	</tr>
</table>
<%
}catch(Exception e){
	out.print(e.toString());
}finally{
	dImpl.closeStmt();
	dCn.closeCn(); 
}
%>
<%@include file="/system/app/skin/bottom.jsp"%>