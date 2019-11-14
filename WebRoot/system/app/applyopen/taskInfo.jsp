<%@page contentType="text/html; charset=GBK"%>
<%@include file="/system/app/skin/head.jsp"%>
<%
String sqlStr = "";
Vector vPage = null;
Hashtable content = null;
Hashtable contentfzb = null;
String did = "";//任务处理部门编号
String dt_id = "";//业务人员所属部门编号

String adid = "";//申请受理部门编号
String ddid = "";//申请处理部门编号

String intonline="";//网上公开是什么东东呀！·
String inid="";
String oemail=""; //申请东西的email
String infotitle1="";//申请的主题

String iid = CTools.dealString(request.getParameter("iid")).trim();
String tid = CTools.dealString(request.getParameter("tid")).trim();
String ttd = CTools.dealString(request.getParameter("ttd")).trim();//从查看页面传来
//
CDataCn dCn = null;
CDataImpl dImpl = null;
try{
dCn = new CDataCn();
dImpl = new CDataImpl(dCn);
//
CMySelf mySelf = (CMySelf)session.getAttribute("mySelf");
if (mySelf!=null){
	dt_id = Long.toString(mySelf.getDtId());
}

if(tid.equals("")){
	sqlStr = "select id from taskcenter where (status = 0 or status = 3) and iid = " + iid;
	content = dImpl.getDataInfo(sqlStr);
	if (content!=null){
		tid = content.get("id").toString();
	}
}
sqlStr="select s.did did ,s.adid adid ,s.infoid infoid ,s.pemail pemail,s.infotitle infotitle,c.ci_id ciid,c.ci_title cititle,s.tid tid from(";
sqlStr+=" select t.id tid,t.did did,i.did adid,i.id infoid,i.pemail pemail,i.infotitle infotitle from infoopen i,taskcenter t where i.id = t.iid and i.id="+iid+")";
sqlStr+=" s left join tb_infopurview f on s.infoid = f.io_id left join tb_contentinfo c on f.ci_id=c.ci_id order by tid desc ";

content = dImpl.getDataInfo(sqlStr);
if (content!=null){
	did = content.get("did").toString();
	adid = content.get("adid").toString();
	inid = content.get("ciid").toString();
	infotitle1 = content.get("infotitle").toString();
	intonline = content.get("cititle").toString();
	oemail = content.get("pemail").toString();
}

sqlStr = "select did from taskcenter where genre='受理' and iid = " + iid;
content = dImpl.getDataInfo(sqlStr);
if (content!=null){
	ddid = content.get("did").toString();
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
<script language="javascript">
function xx()
{
if(document.formData.oemail.value=="")
{
	alert("申请人的邮箱为空！");
	return;
}
if(document.formData.gm[1].value==1)
{
   document.formData.gm[1].checked=true;
}
checkform();

}
function mm(iid)
{
  window.location.href="daiResult.jsp?iid="+iid+"";
}
</script>
<link href="applyopen.css" type="text/css" rel="stylesheet">
<script language="javascript" src="applyopen.js"></script>
<form name="formData" method="post" action="taskdeal.jsp">
<table class="main-table" width="100%">
	<tr>
		<td width="100%">
			<table width="100%" class="content-table" height="1">
				<tr class="line-odd" >
					<td colspan="2" align="left">&nbsp;<b>申请信息</b></td>
				</tr>
				<tr>
					<td colspan="2" class="line-even"><%@include file="applySheet.jsp"%></td>
				</tr>
				<tr class="line-odd" style="white-space:nowrap;">
					<td colspan="2" align="left">&nbsp;<b>办理流程</b></td>
				</tr>
				<tr>
					<td colspan="2" class="line-even"><%@include file="applyFlow.jsp"%></td>
				</tr>

				<tr class="line-odd" style="white-space:nowrap;">
					<td colspan="2" align="left">&nbsp;<b>第三方意见征询</b> [+]</td>
				</tr>
				<tr>
					<td colspan="2" class="line-even"><%@include file="applyConsult.jsp"%></td>
				</tr>

				<tr class="line-odd" style="white-space:nowrap;">
					<td colspan="2" align="left">&nbsp;<b>延期答复申请记录</b> [+]</td>
				</tr>
				<tr>
					<td colspan="2" class="line-even"><%@include file="applyPostponed.jsp"%></td>
				</tr>
				<%
				if(status.equals("2")||!did.equals(dt_id)){
					if (!"".equals(dealmode)) {
				%>
				<tr class="line-odd" >
					<td colspan="2" align="left">&nbsp;<b>办理结果</b></td>
				</tr>
				
				<tr class="line-even">
					<td width="12%">状态：</td>
					<td width="88%" align="left">
					<%
						int de = Integer.parseInt(dealmode);
						switch (de){
						case 0 : out.print("于以公开");break;
						case 1 : out.print("部分公开");break;
						case 2 : out.print("不于公开");break;
						case 3 : out.print("信息不存在");break;
						case 4 : out.print("转办");break;
						case 5 : out.print("退回认领中心");break;
						case 6 : out.print("非政府信息公开");break;
						case 7 : out.print("非《上海市政府信息公开规定》所指政府信息");break;
						case 8 : out.print("延期答复");break;
						case 9 : out.print("第三方意见征询");break;
						case 10 : out.print("补正材料");break;
						case 12 : out.print("通过其它方式处理");
						}
					%>
					</td>
				</tr>
				<tr class="line-odd">
					<td width="12%">网上公开：</td>
					<td width="88%" align="left">
					<a href="" onClick="javascript:addElem('div3','getConsult.jsp?ci_id=<%=inid%>');return false;"><%=intonline%></a>
					</td>
				</tr>
				<!------>
				<tr class="line-even">
					<td width="12%">反馈信息：</td>
					<td align="left"><%=feedback.equals("")?"--":feedback%></td>
				</tr>
				<%
					}
				}else if(status.equals("3")){
				%>
				<tr class="line-even">
					<td align="left" colspan="2">&nbsp;任务被挂起，请先处理未完成的第三方意见征询单。</td>
				</tr>
				<%
				}else if(status.equals("5")){
				%>
				<tr class="line-even">
					<td align="left" colspan="2">&nbsp;请求客户提供补正材料。</td>
				</tr>
				<%}else{%>
				<tr>
					<td colspan="2">
						<table width="100%">
							<tr class="line-even">
								<td align="left" colspan="2">
									<table width="100%">
										<tr>
											<td height="35">
												<input type="radio" name="sign" value="0" onClick="javascript:dealtask(this.value,this)">&nbsp;于以公开
												&nbsp;&nbsp;<input type="radio" name="sign" value="1" onClick="javascript:dealtask(this.value,this)">&nbsp;部分公开
												&nbsp;&nbsp;<input type="radio" name="sign" value="2" onClick="javascript:dealtask(this.value,this)">&nbsp;不于公开
												&nbsp;&nbsp;<input type="radio" name="sign" value="3" onClick="javascript:dealtask(this.value,this)">&nbsp;信息不存在
												&nbsp;&nbsp;<input type="radio" name="sign" value="4" onClick="javascript:dealtask(this.value,this)">&nbsp;转办
												&nbsp;&nbsp;<input type="radio" name="sign" value="7" onClick="javascript:dealtask(this.value,this)">&nbsp;非《上海市政府信息公开规定》所指政府信息											</td>
										</tr>

										<tr>
											<td height="35">
												<input type="radio" name="sign" value="8" onClick="javascript:dealtask(this.value,this)">&nbsp;延期答复
												&nbsp;&nbsp;<input type="radio" name="sign" value="9" onClick="javascript:dealtask(this.value,this)">&nbsp;第三方意见征询
												<%if(adid.equals("")||(!adid.equals("")&&!adid.equals(ddid))){%>
												&nbsp;&nbsp;<input type="radio" name="sign" value="6" onClick="javascript:dealtask(this.value,this)">&nbsp;非政府信息公开
												&nbsp;&nbsp;<input type="radio" name="sign" value="5" onClick="javascript:dealtask(this.value,this)">&nbsp;退回认领中心
												<%}%>
												&nbsp;&nbsp;<input type="radio" name="sign" value="10" onClick="javascript:dealtask(this.value,this)">&nbsp;补正材料	
												&nbsp;&nbsp;<input type="radio" name="sign" value="12" onClick="javascript:dealtask(this.value,this)">&nbsp;通过其它方式处理											</td>
										</tr>
									</table></td>
							</tr>
							<tr class="line-even" id="reason" style="display:none">
								<td colspan="2" align="center" height="30">
									<table width="98%" cellspacing="0" cellpadding="0">
										<tr height="30">
											<td colspan="2" align="left">您（单位）申请获取的政府信息<span id="asno" name="asno" style="display:none">中&nbsp;<input name="canopen" size="25" type="text">&nbsp;可以公开，有关&nbsp;<input name="whatinfo" size="25" type="text">&nbsp;的政府信息</span>：</td>
										</tr>
										<tr height="30">
											<td width="52%" align="left"><input name="noreason" type="checkbox" value="属于国家秘密">&nbsp;属于国家秘密</td>
											<td width="48%" align="left"><input name="noreason" type="checkbox" value="属于商业秘密或者公开可能导致商业秘密被泄露的">&nbsp;属于商业秘密或者公开可能导致商业秘密被泄露的</td>
										</tr>
										<tr height="30">
											<td width="52%" align="left"><input name="noreason" type="checkbox" value="属于个人隐私或者公开可能导致对个人隐私权造成不当侵害的">&nbsp;属于个人隐私或者公开可能导致对个人隐私权造成不当侵害的</td>
											<td width="48%" align="left"><input name="noreason" type="checkbox" value="属于正在调查、讨论、处理过程中的">&nbsp;属于正在调查、讨论、处理过程中的</td>
										</tr>
										<tr height="30">
											<td width="100%" align="left" colspan="2"><input name="noreason" type="checkbox" value="与行政执法有关，公开后可能会影响检查、调查、取证等执法活动或者会威胁个人生命安全的">&nbsp;与行政执法有关，公开后可能会影响检查、调查、取证等执法活动或者会威胁个人生命安全的</td>
										</tr>
										<tr height="30">
											<td width="100%" align="left" colspan="2"><input name="otherc" type="checkbox" onClick="javascript:CAble(this,'otherr');">&nbsp;有法律、法规规定免予公开的其他情形，具体为&nbsp;<input name="otherr" size="40" type="text" readonly></td>
										</tr>
										<tr height="30">
											<td colspan="2" align="left">根据《上海市政府信息公开规定》第十条第一款第&nbsp;<input name="rentry" size="4" type="text">&nbsp;项和第十二条第（二）项，对于您（单位）申请获取的政府信息，本机关不予公开。<input name="rreason" type="hidden"><input name="oreason" size="40" type="hidden"></td>
										</tr>
									</table>
							<td>							</tr>

							<tr class="line-even" id="whatgive" style="display:">
								<td colspan="2" align="center" height="30">
									<table width="98%" cellspacing="0" cellpadding="0">
										<tr height="30">
											<td align="left" width="10%">提供方式：</td>
											<td align="left"><input type="checkbox" name="gm" value="0">&nbsp;纸质&nbsp;&nbsp;<input name="gm" type="checkbox" value="1">&nbsp;电子邮件&nbsp;&nbsp;<input name="gm" type="checkbox" value="2">&nbsp;磁盘&nbsp;&nbsp;<input type="checkbox" name="othermode" onClick="javascript:CAble(this,'omode');">&nbsp;其他形式，具体为&nbsp;&nbsp;<input type="text" name="omode" readonly><input name="gmode" type="hidden"></td>
										</tr>
										<%
										
										StringBuffer onlineOpen = new StringBuffer("");
										onlineOpen.append("<select id=\"onlineopen\" name=\"onlineopen\"><option value=\"0\">--</option>");
										if(!"".equals(infoid)){
										sqlStr = "select * from tb_contentinfo where ct_id = " + infoid;
										vPage = dImpl.splitPage(sqlStr,1000,1);
										if(vPage!=null){
											for(int i=0; i<vPage.size(); i++){
												content = (Hashtable)vPage.get(i);
												onlineOpen.append("<option value="+content.get("ci_id").toString()+">"+content.get("ci_title").toString()+"</option>");
											}
										}
										}
										onlineOpen.append("</select>");
										
										%>
										<tr height="30">
											<td align="left" width="10%">网上公开：</td>
											<td align="left"><%=onlineOpen%>&nbsp;[ <a href="" onClick="javascript:addElem('div1','getConsult.jsp?ci_id='+document.all.onlineopen.value);return false;">查看</a>]&nbsp;&nbsp;&nbsp;
																				
<span id="aaaa">如果没有适合公开的内容，请 <a href="publishInfo.jsp?iid=<%=iid%>&tid=<%=tid%>&method=add" target="_blank"><font color="red"><b>新增</b></font></a> 信息公开内容</span>


</td>
										</tr>
									</table>
									</td>
							</tr>

							<tr class="line-even" id="pass" style="display:none">
								<td align="left" colspan="2" height="30">
									<table width="100%" cellspacing="0" cellpadding="0">
										<tr>
											<td valign="bottom">
												<table cellspacing="0" cellpadding="0" width="100%">
													<tr>
														<td id="chone" align="center" class="title_down" onClick="javascript:wt('chooseDept.jsp','deptlist','chone');">直接选择委办局</td>
													</tr>
												</table>											</td>
											<td width="2" class="title_mi">　</td>
											<td valign="bottom">
												<table cellspacing="0" cellpadding="0" width="100%">
													<tr>
														<td id="chtwo" class="title_down" align="center" onClick="javascript:wt('selectDept.jsp','deptlist','chtwo');">根据机构职能指派</td>
													</tr>
												</table>											</td>
											<td class="title_mi" width="60%">&nbsp;</td>
										</tr>
									</table>

									<table width="100%" class="table_main"><tr><td id="deptlist"></td></tr></table></td>
							</tr>

							<tr class="line-even" id="postpened" style="display:none">
								<td colspan="2" align="center" height="30">
									<table width="98%" cellspacing="0" cellpadding="0">
										<tr height="30">
											<td colspan="2" align="left"><font color="#FF0000"><strong>* 该处理方式尚未开通，请选择其他处理方式进行处理</strong></font></td>
										</tr>
										<tr height="30">
											<td colspan="2" align="left"><%=proposer.equals("0")?pname:ename%>：</td>
										</tr>
										<tr height="30">
											<td colspan="2" align="left">本机关于<%=applytime%>收到了您（单位）获得的申请，见收件证明。</td>
										</tr>
										<tr height="30">
											<td colspan="2" align="left">现由于 <input name="rname" size="25" type="text"> 的原因，本机关无法在<%=limittime%>前</td>
										</tr>
										<tr height="30">
											<td width="20%" align="left"><input name="conreason" type="radio" value="作出答复" >&nbsp;作出答复</td>
											<td width="80%" align="left"><input name="conreason" type="radio" value="提供政府信息">&nbsp;提供政府信息</td>
										</tr>
										<tr height="30">
											<td colspan="2" align="left">根据《上海市政府信息公开规定》第十八条第三款规定，本机关将延期至：<input name="caddress" size="30" type="text" onClick="javascript:showCal()" readonly style="cursor:hand"> 前</td>
										</tr>
										<tr height="30">
											<td align="left"><input name="conreason" type="radio" value="作出答复" >&nbsp;作出答复</td>
											<td align="left"><input name="conreason" type="radio" value="提供政府信息">&nbsp;提供政府信息</td>
										</tr>
									</table>								</td>
							</tr>

							<tr class="line-even" id="hang" style="display:none">
								<td colspan="2" align="center" height="30">
									<table width="98%" cellspacing="0" cellpadding="0">
										<tr height="30">
											<td colspan="2" align="left"><input name="rrname" size="25" type="text"/>（被征询人姓名或是单位）：</td>
										</tr>
										<tr height="30">
											<td align="left">本机关于<%=applytime%>收到<%=proposer.equals("0")?pname:ename%>根据《上海市政府信息公开规定》提出的政府信息公开信申请（详情参见《政府信息公开申请书》）。由于其申请的政府信息信息</td>
										</tr>
										<tr height="30">
											<td width="52%" align="left"><input name="conreason" type="radio" value="属于您单位商业秘密或者公开可能导致您单位商业秘密被泄露" >&nbsp;属于您单位商业秘密或者公开可能导致您单位商业秘密被泄露</td>
										</tr>
										<tr height="30">
											<td width="48%" align="left"><input name="conreason" type="radio" value="属于您个人隐私或者公开可能导致您的个人隐私权遭受不当侵害">&nbsp;属于您个人隐私或者公开可能导致您的个人隐私权遭受不当侵害</td>
										</tr>
										<tr height="30">
											<td align="left">根据《上海市政府信息公开规定》第十四条规定，特向您（单位）征询是否同意提供该政府信息的意见，并将意见邮寄至：<input name="rrcaddress" size="30" type="text" />（邮政编码：<input name="czipcode" size="10" type="text" />）</td>
										</tr>
									</table>								</td>
							</tr>
							<tr class="line-even" id="dealwith" style="display:">
								<td colspan="2" align="center" height="30">
									<table width="98%" cellspacing="0" cellpadding="0">
										<tr height="30">
											<td align="left" width="10%">备&nbsp;&nbsp;&nbsp;&nbsp;注：</td>
											<td align="left"><textarea class="text-area" name="commentinfo" cols="60" rows="4" title="" >&nbsp;</textarea></td>
										</tr>
									</table>								</td>
							</tr>
							<script>dealtask(document.all.sign[0].value,document.all.sign[0]);</script>
						</table>					</td>
				</tr>
				<%}%>
			</table>
		</td>
	</tr>

	<tr align="center" id="confirmObj" style="display:none">
		<td colspan="2"><font color="red">您的请求已经提交，操作正在进行，请稍候。</font></td>
	</tr>

	<tr class="title1" align="center" id="btnObj" style="display:">
		<td colspan="2">
			<%if(status.equals("2")&&!did.equals(dt_id)){%>
			<input type="button" class="bttn" name="" value=" 打印告知书 " onClick="javascript:printInfo('<%=iid%>');">&nbsp;
			<%}else if(did.equals(dt_id)&&!status.equals("3")&&!status.equals("5")){
			if(!status.equals("2")){
			%>
			<input id="ispnt" type="button" class="bttn" name="fprint" value="打印待办单" onClick="fnprint();">&nbsp;
			<input id="transToWord" type="button" class="bttn" name="ftransToWord" value="导出到Word" onClick="transtoword();">&nbsp;
			<%
			String fzbSql="select dt_name from tb_deptinfo where dt_id="+dt_id+"";
			String fzbName="";
			contentfzb = dImpl.getDataInfo(fzbSql);
			if(contentfzb!=null){
			fzbName=contentfzb.get("dt_name").toString();
			}
			if(fzbName.equals("法制办"))
			{%>
			<input type="button" class="bttn" name="emailtalk"  value=" Email回复 " onClick="xx();">
			<input type="hidden" name="infotitle" value="<%=infotitle1%>"/>
			<input type="hidden" name="email_id" value="1"/>
			<%}else{
			%>
			<input type="hidden" class="bttn" name="emailtalk">
			<%
			}
			}if(ttd.equals("")){
			%>
			<input type="button" class="bttn" name="hello" value=" 提交 " onClick="javascript:checkform();">
			<%
			}
			}
			if(status.equals("5")){
			%>
			<input type="button" class="bttn" name="xiao" value=" 迁回待办 " onClick="javascript:mm(<%=iid%>);">
			<%}%>
			<input type="button" class="bttn" name="world" value=" 返回 " onClick="javascript:history.back();">
			<input type="hidden"  name="oemail" value="<%=oemail%>"/>
			<input type="hidden" name="pemail" value="<%=oemail%>"/>
			<input type="hidden" name="iid" value="<%=iid%>">
			<input type="hidden" name="tid" value="<%=tid%>">
			<input type="hidden" name="infoid" value="<%=infoid%>">
			<input type="hidden" name="us_id" value="<%=us_id%>">
			<input type="hidden" name="flownum" value="<%=flownum%>">
		</td>
	</tr>
</table>
<!--    表单提交结束    -->
<%@include file="/system/app/skin/skin4/template/info_bottom.jsp"%> 
<script language="javascript">
	var w = screen.availWidth;
	var h = screen.availHeight;
	var form = document.formData;
	var args = new Object;
	function fnprint()
	{
    args["proposer"] = <%=proposer%>; //以公民或企业身份
    /**************公民信息开始***************/
    args["pname"] = "<%=pname%>"; 
    args["punit"] = "<%=punit%>"; 
    args["pcard"] = "<%=pcard%>";
    args["pcardnum"] ="<%=pcardnum%>";
    args["paddress"] = "<%=paddress%>";
    args["pzipcode"] = "<%=pzipcode%>";
    args["ptele"] = "<%=ptele%>";
    args["pemail"] = "<%=pemail%>";
    /**************公民信息结束***************/
    /**************企业信息开始***************/
    args["ename"] = "<%=ename%>";
    args["ecode"] = "<%=ecode%>";
    args["ebunissinfo"] = "<%=ebunissinfo%>";
    args["edeputy"] = "<%=edeputy%>";
    args["elinkman"] = "<%=elinkman%>";
    args["etele"] = "<%=etele%>";
    args["eemail"] = "<%=eemail%>";
    /**************企业信息结束***************/
    args["infotitle"] = "<%=infotitle%>";
    args["commentinfo"] = "<%=commentinfo%>";
    args["indexnum"] = "<%=indexnum%>";
    args["purpose"] = "<%=purpose%>";
    args["memo"] = form.commentinfo.value;
    args["ischarge"] = "<%=ischarge%>";
    args["applytime"] = "<%=applytime%>";
    args["offermode"] = "<%
	String[] b = offermode.split(",");
	String[] a = {"纸面","电子邮件","磁盘"};
	for(int i=0; i<b.length; i++){
		if(b[i]!=""){
			if(Integer.parseInt(b[i])<3) out.print(a[Integer.parseInt(b[i])]);
		}
	}
	%>";
args["gainmode"] = "<%
	String[] c = gainmode.split(",");
	String[] d = {"邮寄","快递","电子邮件","传真","自行领取/当场阅读抄录"};
	for(int i=0; i<c.length; i++){
		if(c[i]!=""){
			if(Integer.parseInt(c[i])<5) out.print(d[Integer.parseInt(c[i])]);
		}
	}
	%>";
	
if (document.all.sign[2].checked) {
args["do"] = "1";
}
else if (document.all.sign[3].checked) {
args["do"] = "2";
}
else {
args["do"] = "0";
}
var url = null;
if (<%=proposer%>==0) {   //以公民身份
	url = "printApplyInfop.jsp";
}
else {                    //以企业身份
	url = "printApplyInfoe.jsp";
}
window.showModalDialog(url,args,'dialogTop=0px;dialogLeft=0px;dialogWidth='+w+'px;dialogHeight='+h+'px;help=no;status=no;scroll=yes;resizable=yes;');
}

function transtoword()
{
	window.showModalDialog("unload.jsp?iid=<%=iid%>",args,'dialogTop=0px;dialogLeft=0px;dialogWidth='+w+'px;dialogHeight='+h+'px;help=no;status=no;scroll=yes;resizable=yes;');
}
</script>
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
                                     
