<%@page contentType="text/html; charset=GBK"%>
<%@include file="/system/app/skin/import.jsp"%>
<%@include file="/system/app/islogin.jsp"%>
<link href="/system/app/applyopen/print.css" rel="stylesheet" type="text/css">
<script language="javascript" src="applyopen.js"></script>
<%
//by ph 2007-3-3  信息公开一体化
String sqlStr = "";
Vector vPage = null;
Hashtable content = null;
//String did = "";//任务处理部门编号
String dt_id = "";//业务人员所属部门编号

String cid = "";//征询单编号
cid = CTools.dealString(request.getParameter("cid")).trim();

String proposer = "";
String ename = "";
String pname = "";
String iid = "";
String tid = "";
String did = "";
String rname = "";
String dname = "";
String status = "";
String caddress = "";
String czipcode = "";
String conreason = "";
String applytime = "";
String commentinfo = "";
String starttime = "";

String finishtime = "";
String finishyear = "";
String flownum = "";

CDataCn dCn = null;
CDataImpl dImpl = null;

try{
dCn = new CDataCn();
dImpl = new CDataImpl(dCn);

CMySelf mySelf = (CMySelf)session.getAttribute("mySelf");
if (mySelf!=null){
	dt_id = Long.toString(mySelf.getDtId());
}

sqlStr = "select to_char(i.applytime,'yyyy#mm$dd%') applytime,i.proposer,i.pname,i.ename,i.flownum,to_char(i.finishtime,'yyyy/mm/dd') finishtime,c.iid,c.tid,c.did,c.rname,c.dname,c.caddress,c.czipcode,c.conreason,c.commentinfo,c.status,to_char(c.starttime,'yyyy#mm$dd%') starttime from infoopen i,consult c where i.id = c.iid and c.id = " + cid;
//out.println(sqlStr);
content = dImpl.getDataInfo(sqlStr);
if (content!=null){
	applytime = content.get("applytime").toString();
	proposer = content.get("proposer").toString();
	ename = content.get("ename").toString();
	pname = content.get("pname").toString();
	iid = content.get("iid").toString();
	tid = content.get("tid").toString();
	did = content.get("did").toString();
	rname = content.get("rname").toString();
	dname = content.get("dname").toString();
	status = content.get("status").toString();
	caddress = content.get("caddress").toString();
	czipcode = content.get("czipcode").toString();
	conreason = content.get("conreason").toString();
	commentinfo = content.get("commentinfo").toString();
	starttime = content.get("starttime").toString();

	flownum = content.get("flownum").toString();
	finishtime = content.get("finishtime").toString();
	if(!finishtime.equals("")){
		java.util.Date dt = new java.util.Date(finishtime);
		finishyear = String.valueOf(dt.getYear()+1900);
	}
}

%>
<table class="printtable">
	<tr>
		<td class="printtitle">第三方意见征询单</td>
	</tr>
	<tr>
		<td class="printlineone">沪浦信息公开（<%=finishyear%>）第<%=flownum%>号-意征告</td>
	</tr>
	<tr>
		<td class="printlinethree"><%=rname%>：</td>
	</tr>
	<tr>
		<td class="printlinetwo">本机关于<%=CTools.replace(CTools.replace(CTools.replace(applytime,"#","年"),"$","月"),"%","日")%>收到<%=proposer.equals("0")?pname:ename%>根据《上海市政府信息公开规定》提出的政府信息公开信申请（详情参见《政府信息公开申请书》）。由于其申请的政府信息信息：</td>
	</tr>

	<tr>
		<td class="printlinetwo"><%=conreason%>。</td>
	</tr>

	<tr>
		<td class="printlinetwo">根据《上海市政府信息公开规定》第十四条规定，特向您（单位）征询是否同意提供该政府信息的意见，并将意见邮寄至：<%=caddress%>（邮政编码：<%=czipcode%>）</td>
	</tr>

	<tr>
		<td class="printlinetwo">如果您（单位）在收到本征询单之后10个工作日内未作出答复，则视为您（单位）不同意提供上述信息。</td>
	</tr>

	<tr>
		<td class="printlineone"><%=dname%></td>
	</tr>

	<tr>
		<td class="printlineone"><%=CTools.replace(CTools.replace(CTools.replace(starttime,"#","年"),"$","月"),"%","日")%></td>
	</tr>
</table>
<div id="pb"><!-- <input type="button" class="bttn" name="" value=" 网上公开 " onclick="javascript:checkform();">&nbsp; --><input type="button" class="bttn" name="" value=" 打印告知书 " onclick="javascript:printIt('pb');">&nbsp;<input type="button" value=" 关闭窗口 " onclick="javascript:window.close();"></div>
<%}
catch(Exception e){
	out.print(e.toString());
}finally{
	dImpl.closeStmt();
	dCn.closeCn(); 
}
%>