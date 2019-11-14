<%@ page contentType="text/html; charset=GBK"%>
<%@include file="/website/include/head_zw_user.jsp"%>
<!--单点登录测试-->
<%@include file="/website/cas/cas.jsp"%>
<!--单点登录测试-->
<style type="text/css">

body {
	margin-left: 0px;
	margin-top: 0px;
	margin-right: 0px;
	margin-bottom: 0px;
}
.A_all{
	border:1px solid #333333;
}
.A_right{
	border-right-width: 1px;
	border-right-style: solid;
	border-right-color: #333333;
}
.A_bottom{
	border-bottom-width: 1px;
	border-bottom-style: solid;
	border-bottom-color: #333333;
	padding:10px;
}
.A_rightB{
	border-right-width: 1px;
	border-bottom-width: 1px;
	border-right-style: solid;
	border-bottom-style: solid;
	border-right-color: #333333;
	border-bottom-color: #333333;
}
.B_1{
	font-weight:bold;
	color:#CC0000;
}
.B_2{
	font-weight:bold;
	color:#003399;
}
.STYLE2 {border-right-width: 1px; border-bottom-width: 1px; border-right-style: solid; border-bottom-style: solid; border-right-color: #333333; border-bottom-color: #333333; font-weight: bold;padding:10px; }
.STYLE3 {border-right-width: 1px; border-right-style: solid; border-right-color: #333333; font-weight: bold; }
body,td,th {
	font-size: 12px;
}
-->
</style>
<%
String l_pd_projectId = "";  //局部变量,项目id
String l_pd_projectName = "";//局部变量,项目名称
String l_pd_projectCode = "";//局部变量,项目编号
String l_pd_detail = "";     //局部变量,项目说明
String l_pd_sqlStr = "";     //局部变量,sql语句
String pr_isaccept = "";
String pr_url = "";
String dt_name = "";
String pr_edittime = "";
String dt_id = "";

l_pd_projectId = CTools.dealString(request.getParameter("pr_id")).trim();
l_pd_sqlStr = "select a.pr_name,a.pr_code,a.dt_content,a.pr_isaccept,a.pr_url,to_char(a.pr_edittime,'yyyy-mm-dd') pr_edittime,b.dt_name,b.dt_id from tb_proceeding a,tb_deptinfo b where a.dt_idext=b.dt_id and a.pr_id='"+l_pd_projectId+"'";

//申明变量
//Update 20061231
CDataCn dCn = null;
CDataImpl dImpl = null;


String sj_dir = "";
String sqlStr = "";
String ct_content = "";
Vector vPage = null;
Hashtable content = null;
String newPrid = "";
//特殊处理
if("o1213".equals(l_pd_projectId))
	newPrid = "o434";
else if("o1211".equals(l_pd_projectId))
	newPrid = "o427";

try{
dCn = new CDataCn();
dImpl = new CDataImpl(dCn); 
//申明变量结束


Hashtable l_pd_content = dImpl.getDataInfo(l_pd_sqlStr);
if (l_pd_content!=null)
{
	l_pd_projectName = l_pd_content.get("pr_name").toString();
	l_pd_projectCode = l_pd_content.get("pr_code").toString();
	l_pd_detail      = l_pd_content.get("dt_content").toString();
	pr_isaccept      = l_pd_content.get("pr_isaccept").toString();
	pr_url           = l_pd_content.get("pr_url").toString();
	dt_name          = l_pd_content.get("dt_name").toString();
	dt_id          = l_pd_content.get("dt_id").toString();
	pr_edittime      = l_pd_content.get("pr_edittime").toString();
} 

%>
<script language="javascript">
function openWin(id)
{
	var url = "LawContent.jsp?id="+id;
	window.open(url,"法律法规","Width=600px,Height=400px,toolbar=no,location=no,derectories=no,status=no,menubar=no,scrollbars=yes");
}
</script>
<table width="760" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td valign="top">
		<table width="98%" border="0" align="center" cellpadding="0" cellspacing="0">
			<tr>
				<td height="17"> </td>
			</tr>
			<tr>
			  <td valign="top">
				<a href="<%=_WEBSTART%>/website/index.jsp"><font color="#ACACAC">首页</font></a><font color="#ACACAC"> >></font> <a href="/website/usercenter/List.jsp"><font color="#ACACAC">办事大厅</font></a> <font color="#ACACAC">>></font> <a href="/website/usercenter/ProjectDetail.jsp?pr_id=<%=l_pd_projectId%>"><font color="#ACACAC"><%=l_pd_projectName%></font></a></font>
			  </td>
			</tr>
			<tr>
			  <td valign="top">
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
				  <tr>
					<td width="185" valign="top"><%@include file="/website/include/WorkLeft.jsp"%></td>
					
					<td valign="top">
					<table width="96%" border="0" align="center" cellpadding="0" cellspacing="0">
						<tr> 
				                	<td height="30"><img src="/website/images/new3.gif" width="543" height="21"></td>
				                </tr>
						<tr>
						  <td height="30">
							<div align="center"><strong><font color="#037132"><%=l_pd_projectName%>[项目编号:(<%=l_pd_projectCode%>)]</font></strong></div>
						  </td>
						</tr>
						<tr>
							<td align="center">
								<div align="center">
									<a href="#" onclick="javascript:window.open('ProjectDown.jsp?pr_id=<%=newPrid%>', '表格下载', 'Top=0px,Left=0px,Width=550px,Height=300px,toolbar=no,location=no,derectories=no,status=no,menubar=no,scrollbars=yes')">表格下载</a>
									
									<%
								User checkLogin = (User)session.getAttribute("user");
								String qry_prid = l_pd_projectId;
								String messageStr = "";
								ArrayList prList = new ArrayList();
								String userIdStr = "";
								if(checkLogin!=null){
									Hashtable usermap =new Hashtable();
									String fer="0";
									userIdStr = checkLogin.getId();
									Hashtable prTable = null;
									String tempPrId = "";
									String userSqlStr = "select pr_id from tb_user_proc where us_id = '"+ userIdStr +"'";
									Vector prVec = dImpl.splitPage(userSqlStr,10,1);
									if(prVec != null){
										for (int prCnt = 0; prCnt < prVec.size(); prCnt++){
											prTable = (Hashtable)prVec.get(prCnt);
											tempPrId = prTable.get("pr_id") == null ? "" : 		prTable.get("pr_id").toString();
											prList.add(tempPrId);
										}
									}
									if(prList.contains("o12131") && !"o1211".equals(l_pd_projectId)){
										messageStr = "（贵单位只能申办本单位聘请的外籍员工的工作签证）"; 
										qry_prid = "o12131";
									}
									 if(l_pd_projectId.equals("o1211")){
											fer="1";
									}else if(l_pd_projectId.equals("o1213")){
											fer="1";
										}
										else{
										fer="0";
										}
										
									if(fer.equals("1")){
									String usersql = "select up_id from tb_user_proc where us_id='"+checkLogin.getId()+"' and pr_id='"+qry_prid+"' and dt_id="+dt_id+"";
									//out.print(usersql);
									 usermap = dImpl.getDataInfo(usersql);
									}
	

								if(usermap!=null){
//新的tb_proceeding_new操作是否有网上受理网址
String onlineSql="select pr_isaccept,pr_url from tb_proceeding_new where pr_id = '"+newPrid+"'";
Hashtable onlineContent = dImpl.getDataInfo(onlineSql);
if(onlineContent!=null){
pr_isaccept = CTools.dealNull(onlineContent.get("pr_isaccept"));
pr_url = CTools.dealNull(onlineContent.get("pr_url"));
									if (pr_isaccept.equals("1"))
									{
										if (pr_url.equals(""))
										{
											%>
											| <a href="ProjectOnline.jsp?pr_id=<%=l_pd_projectId%>&asd=<%=CBase64.getEncodeString(checkLogin.getUid())%>&rfv=<%=CBase64.getEncodeString(checkLogin.getPwd())%>">在线申请<font color="#ff0000"><%=messageStr%></font></a>
											<%
										}
										else
										{
											Hashtable owContent = dImpl.getDataInfo("select owt1_id from tb_onlineworkxmltype where pr_id='" + qry_prid + "'");
											String owt1_id = "";
											if(owContent != null){
												owt1_id = owContent.get("owt1_id").toString();
												if(pr_url.indexOf("?") == -1){
												%>
												| <a href="<%=pr_url%>?pr_id=<%=l_pd_projectId%>&pr_name=<%=l_pd_projectName%>&owt1_id=<%=owt1_id%>&asd=<%=CBase64.getEncodeString(checkLogin.getUid())%>&rfv=<%=CBase64.getEncodeString(checkLogin.getPwd())%>">在线申请<font color="#ff0000"><%=messageStr%></font></a>
												<%
												}
												else {
												%>
												| <a href="<%=pr_url%>&pr_id=<%=l_pd_projectId%>&pr_name=<%=l_pd_projectName%>&owt1_id=<%=owt1_id%>&asd=<%=CBase64.getEncodeString(checkLogin.getUid())%>&rfv=<%=CBase64.getEncodeString(checkLogin.getPwd())%>">在线申请<font color="#ff0000"><%=messageStr%></font></a>
												
												
												
												<%
									
												}
											}
											else {
												%>
												| <a href="<%=pr_url%>?pr_id=<%=l_pd_projectId%>&pr_name=<%=l_pd_projectName%>&asd=<%=CBase64.getEncodeString(checkLogin.getUid())%>&rfv=<%=CBase64.getEncodeString(checkLogin.getPwd())%>">在线申请<font color="#ff0000"><%=messageStr%></font></a>
												<%
											}
										}
									}
}
//
									 }else{
										out.println("| <FONT  COLOR='#FF0000'>您没有申请该事项，请联系'"+dt_name+"'相关人员！</FONT>");
									 
									 }
								}else{
						out.println("| <A HREF='/website/login/Login.jsp'><FONT COLOR='#FF0000'>在线申请(请点击登陆后申请办事)</FONT></A>");
								}
									%>
								</div>
							</td>
						</tr>
						<tr>
						  <td>
						  	<table width="98%" border="1" align="center" cellpadding="0" cellspacing="0" bordercolor="#FFFFFF">
						  		<tr>
						  			<td bordercolor="#D1D5BE" bgcolor="#F3F6ED">
									<!--begin-->
									<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
									<tr><td height="5"></td></tr>
									<tr>
									<td>			
						  		<!--//update by yanker 20090401 修改以显示新的事项说明-->
						  			<%
						  			
						  			String prSql = "select p.*,to_char(pr_edittime,'yyyy-mm-dd') as pr_edittime_ from tb_proceeding_new p where p.pr_id = '"+ newPrid +"'";
						  			String projectName = ""; //办事项目
						  			String pr_by = ""; //办事依据
						  			String pr_area = ""; //申请范围
						  			String pr_stuff = "";  //申报材料
						  			String pr_blcx = "";  //办理程序
						  			String pr_money = "";  //收费标准
						  			String pr_timeLimit = ""; //办理时限
						  			String pr_bc = ""; //
						  			String pr_address = "";  //办理地点
						  			String pr_tstype = "";  //监督投诉
						  			Hashtable prTable = null;
						  			prTable = dImpl.getDataInfo(prSql);
						  			if(prTable != null){
						  					pr_by   = CTools.dealNull(prTable.get("pr_by"));
											pr_area   = CTools.dealNull(prTable.get("pr_area"));
											pr_stuff   = CTools.dealNull(prTable.get("pr_stuff"));
											pr_blcx   = CTools.dealNull(prTable.get("pr_blcx"));
											pr_money = CTools.dealNull(prTable.get("pr_money"));
											pr_timeLimit = CTools.dealNull(prTable.get("pr_timelimit"));
											projectName  = CTools.dealNull(prTable.get("pr_name"));
											pr_address = CTools.dealNull(prTable.get("pr_address"));
											pr_tstype = CTools.dealNull(prTable.get("pr_tstype"));
						  			}
						  			%>
						  			<table width="90%" align="center" cellpadding="0" cellspacing="0" class="A_all">
										<tr>
											<td height="25" bgcolor="#F3F3F3" class="STYLE2"><div align="center"><nobr>办事项目</nobr><br /></div></td>
											<td height="25" bgcolor="#FFFFFF" class="A_bottom"><%=projectName%>&nbsp;</td>
										</tr>
										<tr>
											<td height="25" bgcolor="#F3F3F3" class="STYLE2"><div align="center">办事依据<br /></div></td>
											<td height="25" bgcolor="#FFFFFF" class="A_bottom"><%=pr_by%>&nbsp;</td>
										</tr>
										  <tr>
											<td height="25" bgcolor="#F3F3F3" class="STYLE2"><div align="center">申请范围<br />
											</div></td>
											<td height="25" bgcolor="#FFFFFF" class="A_bottom"><%=pr_area%>&nbsp;</td>
										  </tr>
										  <tr>
											<td height="25" bgcolor="#F3F3F3" class="STYLE2"><div align="center">申报材料<br />
											</div></td>
											<td height="25" bgcolor="#FFFFFF" class="A_bottom"><%=pr_stuff%>&nbsp;</td>
										  </tr>
										  <tr>
											<td height="25" bgcolor="#F3F3F3" class="STYLE2"><div align="center">办理程序<br />
											</div></td>
											<td height="25" bgcolor="#FFFFFF" class="A_bottom"><%=pr_blcx%>&nbsp;</td>
										  </tr>
										  <tr>
											<td height="25" bgcolor="#F3F3F3" class="STYLE2"><div align="center">收费标准<br />
											</div></td>
											<td height="25" bgcolor="#FFFFFF" class="A_bottom"><%=pr_money%>&nbsp;</td>
										  </tr>
										  <tr>
											<td height="25" bgcolor="#F3F3F3" class="STYLE2"><div align="center">办理时限</div></td>
											<td height="25" bgcolor="#FFFFFF" class="A_bottom"><%//if(pr_timeLimit.equals("0")||pr_timeLimit.equals("")){out.println("当场办理");}else{out.println(pr_timeLimit+"个工作日");}%>
											<%if(pr_timeLimit.equals("0")||pr_timeLimit.equals("")){out.println("当场办理");}else{ if(pr_timeLimit.equals("5201314")){out.println(pr_bc);}else{out.println(pr_timeLimit+"个工作日");}}%>&nbsp;</td>
										  </tr>
										  <tr>
											<td height="25" bgcolor="#F3F3F3" class="A_rightB"><div align="center"><strong>办理地点<br>(咨询电话)</strong></div></td>
											<td height="25" bgcolor="#FFFFFF" class="A_bottom"><%=pr_address%>&nbsp;</td>
										  </tr>
										  <tr>
											<td height="25" bgcolor="#F3F3F3" class="A_rightB"><div align="center"><strong>监督投诉</strong></div></td>
											<td height="25" bgcolor="#FFFFFF" class="A_bottom"><%=pr_tstype%>&nbsp;</td>
										  </tr>
										  <tr>
											<td height="25" bgcolor="#F3F3F3" class="A_rightB"><div align="center">信息来源：</div></td>
											<td height="25" bgcolor="#FFFFFF" class="A_bottom"><%=dt_name%>&nbsp;</td>
										  </tr>
										  <tr>
											<td height="25" bgcolor="#F3F3F3" class="A_rightB"><div align="center">更新日期：</div></td>
											<td height="25" bgcolor="#FFFFFF" class="A_bottom"><%=pr_edittime%>&nbsp;</td>
										  </tr>
									</table>
									</td></tr>
									<tr><td height="5"></td></tr>
									</table>
									<!--end-->
						  			</td>
						  		</tr>
						  	</table>
						  </td>
						</tr>
					  </table></td>
				  </tr>
				</table></td>
			</tr>
      </table></td>
  </tr>
</table>

<%@include file="/website/include/bottom_user.jsp"%>
<%}
catch(Exception e){
//e.printStackTrace();
out.print(e.toString());
}
finally{
dImpl.closeStmt();
dCn.closeCn(); 
}
%>