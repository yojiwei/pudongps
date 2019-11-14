<%@page contentType="text/html; charset=GBK"%>
<%@include file="/system/app/skin/head.jsp"%>
<%
String sqlStr = "";
Vector vPage = null;
Hashtable content = null;
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

CDataCn dCn = null;
CDataImpl dImpl = null;
try{
dCn = new CDataCn();
dImpl = new CDataImpl(dCn);

CMySelf mySelf = (CMySelf)session.getAttribute("mySelf");
if (mySelf!=null){
	dt_id = Long.toString(mySelf.getDtId());
}

sqlStr = "select to_char(i.applytime,'yyyy#mm$dd%') applytime,i.proposer,i.pname,i.ename,c.iid,c.tid,c.did,c.rname,c.dname,c.caddress,c.czipcode,c.conreason,c.commentinfo,c.status,to_char(c.starttime,'yyyy#mm$dd%') starttime from infoopen i,consult c where i.id = c.iid and c.id = " + cid;

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
}

%>
<%@include file="/system/app/skin/skin4/template/info_top.jsp"%>
<!--    模块名称开始    -->
信息公开一体化
<!--    模块名称结束    -->
<%@include file="/system/app/skin/skin4/template/info_funtion.jsp"%>
<!--    功能按钮开始    -->

<!--    功能按钮结束    -->
<%@include file="/system/app/skin/skin4/template/info_main.jsp"%>
<!--    表单提交开始    -->
<script>
function conDeal(){
	var form = document.formData;
	if(form.commentinfo.value==""){
		alert("请输入征询意见！");
		form.commentinfo.focus();
		return false;
	}
	if(form.commentinfo.value.length>80)
	{
		alert("输入的征询意见不能大于80个字符！");
		form.commentinfo.focus();
		return false;
	}
	form.submit();
}
</script>
<link href="applyopen.css" type="text/css" rel="stylesheet">
<script language="javascript" src="applyopen.js"></script>
<form name="formData" method="post" action="consultDeal.jsp">
<table CELLPADDING="0" cellspacing="0" BORDER="0" width="100%">
	<tr>
		<td width="100%">
			<table width="100%" class="content-table" height="1">
			<tr class="line-odd" style="white-space:nowrap;">
					<td width="100%" colspan="2" align="left">&nbsp;<b>第三方意见征询单</b></td>
				</tr>
				<tr>
					<td colspan="2" class="line-even">
						<table width="98%" cellspacing="0" cellpadding="0">
							<tr height="30">
								<td colspan="2" align="left"><%=rname%>：</td>
							</tr>
							<tr height="30">
								<td align="left">&nbsp;&nbsp;&nbsp;&nbsp;本机关于<%=CTools.replace(CTools.replace(CTools.replace(applytime,"#","年"),"$","月"),"%","日")%>收到<%=proposer.equals("0")?pname:ename%>根据《上海市政府信息公开规定》提出的政府信息公开信申请（详情参见《政府信息公开申请书》）。由于其申请的政府信息信息：</td>
							</tr>

							<tr height="30">
								<td width="52%" align="left">&nbsp;&nbsp;&nbsp;&nbsp;<%=conreason%>。</td>
							</tr>

							<tr height="30">
								<td align="left">&nbsp;&nbsp;&nbsp;&nbsp;根据《上海市政府信息公开规定》第十四条规定，特向您（单位）征询是否同意提供该政府信息的意见，并将意见邮寄至：<%=caddress%>（邮政编码：<%=czipcode%>）</td>
							</tr>
							<tr height="30">
								<td align="left">&nbsp;&nbsp;&nbsp;&nbsp;如果您（单位）在收到本征询单之后10个工作日内未作出答复，则视为您（单位）不同意提供上述信息。</td>
							</tr>
							<tr height="30">
								<td align="right"><%=dname%></td>
							</tr>
							<tr height="30">
								<td align="right"><%=CTools.replace(CTools.replace(CTools.replace(starttime,"#","年"),"$","月"),"%","日")%></td>
							</tr>
						</table>
					</td>
				</tr>

				<tr class="line-odd" >
					<td width="100%" colspan="2" align="left">&nbsp;<b>征询结果</b></td>
				</tr>

				<tr>
					<td colspan="2" class="line-even">
						<table width="100%">
							<tr class="line-even" id="dealwith">
								<td align="left"><textarea class="" name="commentinfo" cols="60" rows="4" title=""  ><%=commentinfo%></textarea></td>
							</tr>

						</table>
					</td>
				</tr>

			</table>
		</td>
	</tr>

	<tr align="center" id="confirmObj" style="display:none">
		<td colspan="2"><font color="red">您的请求已经提交，操作正在进行，请稍候。</font></td>
	</tr>

	<tr class="outset-table" align="center" id="btnObj" style="display:">
		<td colspan="2">
			<%if(did.equals(dt_id)){%>
			<input type="button" class="bttn" name="back" value=" 打印征询单 " onclick="javascript:window.open('printInfo_h.jsp?cid=<%=cid%>','','Top=0px,Left=0px,width=600,height=450,scrollbars=yes');">&nbsp;
			<%}if(!status.equals("2")){%>
			<input type="button" class="bttn" name="back" value=" 完成征询 " onclick="javascript:conDeal();">&nbsp;
			<%}%>
			<input type="button" class="bttn" name="" value=" 返回 " onclick="javascript:history.back();"><input type="hidden" name="cid" value="<%=cid%>"><input type="hidden" name="iid" value="<%=iid%>"><input type="hidden" name="tid" value="<%=tid%>">
		</td>
	</tr>
</table>
</form>
<!--    表单提交结束    -->
<%@include file="/system/app/skin/skin4/template/info_bottom.jsp"%> 
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
                                     
