<%@page contentType="text/html; charset=GBK"%>
<%@include file="/system/app/skin/head.jsp"%>
<%
//by ph 2007-3-3  信息公开一体化
String pname = "";
String ename = "";
String infoid = "";
String infotitle = "";
String applytime = "";
String applymode = "";
String applymodeshow = "";
String status = "";

String sqlStr = "";
String sqlWhere = "";
String strTitle = "";

String dt_id = "";

String s_flownum = "";
String s_keyword = "";

String pKind = "";

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

if(!s_flownum.equals("")) sqlWhere += " and flownum='"+s_flownum+"'";
if(!s_keyword.equals("")) sqlWhere += " and commentinfo like'%"+s_keyword+"%'";


strTitle = "信息公开一体化 > 登记列表";

sqlStr = "select id,infoid,infotitle,proposer,pname,ename,to_char(applytime,'yyyy-mm-dd') applytime,indexnum,flownum,commentinfo,signmode,dname,applymode from infoopen where 1 = 1"+sqlWhere+" order by applytime desc,id desc";
//out.println(sqlStr);
vPage = dImpl.splitPage(sqlStr,request,20);
%>
<script language="javascript" src="applyopen.js"></script>
<table class="main-table" width="100%">
	<tr>
		<td width="100%">
			<table class="content-table" width="100%">
				<tr class="title1">
					<td colspan="9" align="center">
						<table WIDTH="100%" BORDER="0" CELLSPACING="1" CELLPADDING="1">
							<tr>
								<td valign="center" align="left"><%=strTitle%></td>
								<td valign="center" align="right" nowrap>
									<img src="../../images/split.gif" align="middle" border="0" WIDTH="5" HEIGHT="8">
									<img src="../../images/goback.gif" border="0" onclick="javascript:history.back();" title="返回" style="cursor:hand" align="absmiddle">
									<img src="../../images/split.gif" align="middle" border="0" WIDTH="5" HEIGHT="8">
								</td>
							</tr>
						</table>
					</td>
				</tr>
				<tr class="">
					<td colspan="9" align="center"><form name="formSearch" method="post" action="sina.jsp">
						<table WIDTH="100%" BORDER="0" CELLSPACING="1" CELLPADDING="1">
							<tr>
								<td align="left" width="220">流水号：<input name="s_flownum" type="text"></td>
								<td align="left" width="250">信息关键字：<input name="s_keyword" type="text"></td>
								<td align="left" nowrap><input class="bttn" type="submit" value="检索"><!--  <input class="bttn" type="button" value="高级检索 >>"> --></td>
							</tr></form>
						</table>
					</td>
				</tr>
				<tr class="bttn">
					<!--td width="3%" class="outset-table"><input type="checkbox" onclick="javascript:SelectAllCheck(this,'checkdel');"></td-->
					<td width="2%" class="outset-table"><font color="gray">*</font></td>
					<td width="15%" class="outset-table">事项流水号</td>
					<td width="45%" class="outset-table">申请信息描述</td>
					<td width="15%" class="outset-table">申请时间</td>
					<td width="10%" class="outset-table">处理方式</td>
					<td width="5%" class="outset-table" nowrap>打印</td>
					<td width="5%" class="outset-table" nowrap>查看</td>
				</tr><form name="formData" method="post">
				<%
				String commentinfo = "";
				if(vPage!=null){
					for(int i=0; i<vPage.size(); i++){
						content = (Hashtable)vPage.get(i);
						applymode = content.get("applymode").toString();
						if (applymode.equals("0")) {
						  applymodeshow = "由申请人另行申请";
						  pKind = "";
						}
					else if (applymode.equals("1")) {
						  applymodeshow = "收件";
						  pKind = "1";
						}
					else if (applymode.equals("2")) {
						  applymodeshow = "代办";
						  pKind = "0";
						}
					else {
						  applymodeshow = "--";
						  pKind = "";
						}
						commentinfo = content.get("commentinfo").toString();
						if(commentinfo.length()>27) commentinfo = commentinfo.substring(0,26) + "...";
						commentinfo = commentinfo.replaceAll("&","&amp;");
						commentinfo = commentinfo.replaceAll("<","&lt;");
						commentinfo = commentinfo.replaceAll(">","&gt;");
						commentinfo = commentinfo.replaceAll("\"","&quot;");
						if(i%2 == 0) out.print("<tr class=\"line-even\">");
						else out.print("<tr class=\"line-odd\">");
				%>
					<!--td align="center"><input name="checkdel" type="checkbox" value="<%=content.get("id")%>"></td-->
					<td align="center"><font color="red">*</font></td>
					<td align="center"><%=content.get("flownum")%></td>
					<td align="left"><%=commentinfo%></td>
					<td align="center"><%=content.get("applytime")%></td>
					<td align="center"><%=applymodeshow%></td>
					<td align="center"><%if (!"".equals(pKind)) {%><a href="javascript:printlist('<%=content.get("id")%>','<%=pKind%>');"><img class="hand" border="0" src="../../images/sort.gif" title="打印" WIDTH="16" HEIGHT="16"></a><%} else {out.println("--");}%></td>
					<td align="center"><a href="applyListInfo.jsp?iid=<%=content.get("id")%>&pKind=<%=pKind%>"><img class="hand" border="0" src="../../images/modi.gif" title="查看" WIDTH="16" HEIGHT="16"></a></td>
				</tr>
				<%
					}
					out.println("</form>");
					out.println("<tr><td colspan=9>" + dImpl.getTail(request) + "</td></tr>");
				}else{
					out.println("<tr><td colspan=9></td></tr>");
				}
				%>

			</table>
		</td>
	</tr>
</table>
<script language="javascript">
	function printlist(iid,pKind) {
		window.open("printApply.jsp?iid="+ iid +"&kind="+ pKind,"","Top=0px,Left=0px,width=930,height=700,scrollbars=yes");
	}
</script>

<%
}catch(Exception e){
	out.print(e.toString());
}finally{
	dImpl.closeStmt();
	dCn.closeCn(); 
}
%>
<%@include file="/system/app/skin/bottom.jsp"%>