<%@page contentType="text/html; charset=GBK"%>
<%@include file="/system/app/skin/head.jsp"%>
<%
//by ph 2007-3-3  信息公开一体化
String sqlStr = "";
Vector vPage = null;
Hashtable content = null;
String did = "";//任务处理部门编号
String dt_id = "";//业务人员所属部门编号

String adid = "";//申请受理部门编号
String ddid = "";//申请处理部门编号

String iid = CTools.dealString(request.getParameter("iid")).trim();
String pKind = CTools.dealString(request.getParameter("pKind")).trim();

String printTitle = "";
if (pKind.equals("0")) {
  printTitle = "代办证明";
}
else if (pKind.equals("1")) {
	printTitle = "收件证明";
}
else {
	printTitle = "--";
}
String tid = CTools.dealString(request.getParameter("tid")).trim();
CDataCn dCn = null;
CDataImpl dImpl = null;

try{
dCn = new CDataCn();
dImpl = new CDataImpl(dCn);

CMySelf mySelf = (CMySelf)session.getAttribute("mySelf");
if (mySelf!=null){
	dt_id = Long.toString(mySelf.getDtId());
}

sqlStr = "select t.did did,i.did adid from infoopen i,taskcenter t where i.id = t.iid and t.id = " + tid;
content = dImpl.getDataInfo(sqlStr);
if (content!=null){
	did = content.get("did").toString();
	adid = content.get("adid").toString();
}

sqlStr = "select did from taskcenter where genre='受理' and iid = " + iid;
content = dImpl.getDataInfo(sqlStr);
if (content!=null){
	ddid = content.get("did").toString();
}

%>
<link href="applyopen.css" type="text/css" rel="stylesheet">
<script language="javascript" src="applyopen.js"></script>
<table class="main-table" width="100%">
	<tr class="title1" align="left">
		<td>信息公开一体化</td>
	</tr>
	<tr>
		<td width="100%">
			<table width="100%" class="content-table" height="1">
				<tr class="line-odd" >
					<td width="100%" colspan="2" align="left">&nbsp;<b>申请信息</b></td>
				</tr>
				<tr>
					<td colspan="2" class="line-even"><%@include file="applySheet.jsp"%></td>
				</tr>
				<tr class="line-odd" style="white-space:nowrap;">
					<td width="100%" colspan="2" align="left">&nbsp;<b>办理流程</b></td>
				</tr>
				<tr>
					<td colspan="2" class="line-even"><%@include file="applyFlow.jsp"%></td>
				</tr>
			</table>
		</td>
	</tr>
	<tr class="title1" align="center" id="btnObj" style="display:">
		<td colspan="2">
			<%if (!"".equals(pKind)) {%><input type="button" class="bttn" name="pnt" value="打印<%=printTitle%>" onclick="javascript:printlist('<%=iid%>','<%=pKind%>');">&nbsp;<%}%>
			<input type="button" class="bttn" name="" value=" 返回 " onclick="javascript:history.back();">
			<input type="hidden" name="iid" value="<%=iid%>"><input type="hidden" name="tid" value="<%=tid%>"><input type="hidden" name="infoid" value="<%=infoid%>">
		</td>
	</tr>
</table>

<script language="javascript">
	function printlist(iid,pKind) {
		window.open("printApply.jsp?iid="+ iid +"&kind="+ pKind,"","Top=0px,Left=0px,width=930,height=700,scrollbars=yes");
	}
</script>

<%}
catch(Exception e){
	out.print(e.toString());
}finally{
	dImpl.closeStmt();
	dCn.closeCn(); 
}
%>
<%@include file="../skin/bottom.jsp"%>

