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
String sqlStr = "";
String sqlWhere = "";
String strTitle = "";
String dt_id = "";
String s_flownum = "";
String s_keyword = "";

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
strTitle = "信息公开一体化 > 已办任务";

sqlStr = "select distinct i.id iid,i.flownum,to_char(i.applytime,'yyyy-mm-dd') applytime,i.signmode,i.commentinfo,i.dname from infoopen i,taskcenter t where i.status=2 and i.checktype!=9 and i.fdid ="+dt_id+sqlWhere.toString();
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
				<tr class="">
					<td colspan="9" align="center"><form name="formSearch" method="post" action="doList.jsp">
						<table WIDTH="100%" BORDER="0" CELLSPACING="1" CELLPADDING="1">
							<tr>
								<td align="left" width="220">流水号：<input name="s_flownum" type="text"></td>
								<td align="left" width="250">信息关键字：<input name="s_keyword" type="text"></td>
								<td align="left" nowrap><input class="bttn" type="submit" value="检索"> <input class="bttn" type="button" value="高级检索 >>" onclick="javascript:window.location.href='searchTerm.jsp';"></td>
							</tr></form>
						</table>
					</td>
				</tr>
				<tr class="bttn">
					<td width="2%" class="outset-table"><font color="gray">*</font></td>
					<td width="15%" class="outset-table">事项流水号</td>
					<td width="30%" class="outset-table">申请信息描述</td>
					<td width="15%" class="outset-table">申请时间</td>
					<td width="10%" class="outset-table">受理方式</td>
					<td width="15%" class="outset-table">登记部门</td>
					<td width="5%" class="outset-table">指定</td>
					<td width="5%" class="outset-table" nowrap>查看</td>
				</tr><form name="formData" method="post">
				<%
				String commentinfo = "";
				if(vPage!=null){
					for(int i=0; i<vPage.size(); i++){
						content = (Hashtable)vPage.get(i);
						commentinfo = content.get("commentinfo").toString();
						if(commentinfo.length()>18) commentinfo = commentinfo.substring(0,17) + "...";
						commentinfo = commentinfo.replaceAll("&","&amp;");
						commentinfo = commentinfo.replaceAll("<","&lt;");
						commentinfo = commentinfo.replaceAll(">","&gt;");
						commentinfo = commentinfo.replaceAll("\"","&quot;");
						if(i%2 == 0) out.print("<tr class=\"line-even\">");
						else out.print("<tr class=\"line-odd\">");
				%>
					<td align="center"><font color="red">*</font></td>
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
					<td align="center"><%=content.get("dname").toString().equals("")?"--":content.get("dname").toString()%></td>
					<td align="center">--<%//=content.get("dname")%></td>
					<td align="center"><a href="taskInfo.jsp?iid=<%=content.get("iid")%>&ttd=1"><img class="hand" border="0" src="../../images/modi.gif" title="查看" WIDTH="16" HEIGHT="16"></a></td>
				</tr>
				<%
					}
					out.println("</form>");
				}else{
					out.println("<tr><td colspan=20>暂时没有信息！</td></tr>");
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