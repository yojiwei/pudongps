<%@page contentType="text/html; charset=GBK"%>
<%@include file="/system/app/skin/head.jsp"%>
<%
/**
	*今日事务
	*update by yo 20091130
	*待处理事务（信访、投诉等）
 */
CMySelf self = (CMySelf)session.getAttribute("mySelf");
Calendar c=Calendar.getInstance();
String dt_id="";
String ur_id = "";
ur_id = String.valueOf(self.getMyID());
dt_id = String.valueOf(self.getDtId());
String strTitle = "今日事务";

//update by dongliang  2009.1.7
String sendTime = new CDate().getNowYear()+"";
String sendTime2 = (new CDate().getNowMonth()-1)+"";
if(sendTime2.length()==1)
sendTime2 = "0"+sendTime2;
sendTime = sendTime+"-"+sendTime2;

//计算前一个月yyyy-MM
Calendar co=Calendar.getInstance();
co.add(Calendar.MONTH, -1);

String noyear = co.get(Calendar.YEAR)+"";
String nomonth = (co.get(Calendar.MONTH)+1)+"";
if(nomonth.length()==1)
nomonth = "0"+nomonth;
String noday = noyear+"-"+nomonth;
//
CDataCn dCn = null;
CDataImpl dImpl = null;
CRoleAccess ado=null;
try{
dCn = new CDataCn();
dImpl = new CDataImpl(dCn);
//
ado=new CRoleAccess(dCn);
String wo_projectname ="";
String wo_id="";
String de_status="";
String de_id="";
String de_senddeptid="";
String de_signtime="";
String de_feedbacksigntime="";
String senddept="";
String co_id="";
String de_sendtime="";
String de_feedbacktime="";

String SignedCorrSize="";
int showSignedCorrSize=0;

String sqlSignedCorr = " select y.wo_projectname,x.co_id,y.wo_id,z.de_id,z.de_senddeptid,u.dt_name senddept,z.de_status,to_char(z.de_signtime,'yyyy-mm-dd hh24:mi:ss') de_signtime,to_char(z.de_feedbacksigntime,'yyyy-mm-dd hh24:mi:ss') de_feedbacksigntime  ";
sqlSignedCorr += " from tb_correspond x,tb_work y,tb_documentexchange z,tb_deptinfo u ";
sqlSignedCorr += " where z.de_receiverdeptid="+dt_id+" and x.co_status='1' and z.de_type='1' and (z.de_status='2' or z.de_status='4') and z.de_primaryid=x.co_id and x.wo_id=y.wo_id and z.de_senddeptid=u.dt_id ";
Vector vectorSignedCorr = dImpl.splitPage(sqlSignedCorr,request,20);


%>
<%@include file="/system/app/skin/skin4/template/list_listtop.jsp"%>                                                                                        
<!--    列表开始    -->
<table class="FindAreaTable1" cellspacing="1" rules="cols" border="0" id="ctl00_DataGrid_DataGrid1" style="border-width:0px;" width="100%">
			<form name="formData">
					<tr>
						<td>
							<table width="100%" border="0" cellspacing="1" cellpadding="1">
								<!--start-->
								<tr class="line-odd" width="100%" colspan="2">
									<td valign="center" width="15%" align="left"><span style="font:黑体">·待处理业务
									</span></td>
								</tr>
								<%
											ResultSet rs = null;
										  int count = 0;
										  int count1 = 0;
										  String dclywSql = "";
										  String dclywUrl = "";
										  if("34".equals(dt_id)){
											   dclywSql = "select count(*) as count from tb_work a,tb_proceeding b,tb_deptinfo c where a.wo_status = 1 and a.wo_projectname like '" + "%"+"%' and a.wo_applypeople like '"+"%"+"%' and a.pr_id = b.pr_id and b.dt_id = c.dt_id and a.wo_status=1 and c.dt_id = " + dt_id;
											   dclywUrl = "dealwork";
											}else{
												 dclywSql = "select count(*) as count from tb_work a,tb_proceeding_new b,tb_deptinfo c where a.wo_status = 1 and a.wo_projectname like '" + "%"+"%' and a.wo_applypeople like '"+"%"+"%' and a.pr_id = b.pr_id and b.dt_id = c.dt_id and a.wo_status=1 and c.dt_id = " + dt_id;
												 dclywUrl = "new_dealwork";											
											}
											
											rs = dImpl.executeQuery(dclywSql);
											if (rs.next()) count = rs.getInt("count");
											if (count != 0) {
											
								%>
								<tr class="line-even" width="100%" colspan="2">
									<td valign="center" width="15%" align="left"><span style="font:黑体">&nbsp;&nbsp;·业务办理
									</span></td>
								</tr>
								<tr class="line-odd" width="100%" colspan="2">
									<td valign="center" width="15%" align="left"><span style="font:黑体">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;·事项受理 --&gt; <a href="#" onclick="javascript:parent.parent.main_content.location.href='../../<%=dclywUrl%>/WaitList.jsp?Menu=事项受理&Module=待处理业务'">待处理业务</a>(共
								<%
								   		out.print(count + " 条)");
								%>
										</span></td>
								</tr>
								<!-----------------新事项维护start------------------------->
								<%
											}
											rs = null;
										 /*count = 0;
											String proSql = "select count(pr_id) as cunpr from tb_proceeding_new where pr_isdel is null ";	
											if(!ado.isAdmin(ur_id)){
												proSql+=" and dt_id ="+dt_id;
											}
											rs = dImpl.executeQuery(proSql);
										  if (rs.next()) count = rs.getInt("cunpr");
										  if (count != 0) {
								%>
								<tr class="line-even" width="100%" colspan="2">
									<td valign="center" width="15%" align="left"><span style="font:黑体">&nbsp;&nbsp;·注意事项
									</span></td>
								</tr>
								<tr class="line-odd" width="100%" colspan="2">
									<td valign="center" width="15%" align="left"><span style="font:黑体">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;·新事项维护 --&gt; <a href='#' onclick="javascript:parent.parent.main_content.location.href='../../proceeding_new/ProceedingList.jsp?OType=manage'">当前新事项维护的信息</a>(共
								<%
								  		out.print(count + " 条)");
								%>
										</span></td>
								</tr>
								<%
										}
										*/
								%>
								<!----------------------新事项维护end------------------------->
								<!----------------------信箱办理的相关问题start---------------------->
								<%
								//update by yaojiwei 20081028
								//若该用户没有信箱办理的权限刚不显示 
								//String isSql="SELECT ft_Name,ft_ID,count(ft_ID) coun,ft_sequence FROM tb_Function WHERE (ft_parent_id in(SELECT ft_id FROM tb_Function WHERE ft_parent_id = 0)) and ft_id in(select ft_id from tb_functionrole where tr_id in(select tr_id from tb_roleinfo where tr_userids like '%," +ur_id+ ",%')) and ft_name='信箱办理' group by ft_Name,ft_ID,ft_sequence order by ft_sequence";
								String isSql = "select count(c.cw_id) coun from tb_connwork c,tb_connproc p where c.cp_id = p.cp_id and c.cw_status in(1,2,8) and p.dt_id = "+dt_id+"";
								ResultSet MenuRs=dImpl.executeQuery(isSql);
								if(MenuRs.next()) count = MenuRs.getInt("coun");
								if(count!=0){
								%>
								<tr class="line-even" width="100%" colspan="2">
									<td valign="center" width="15%" align="left"><span style="font:黑体">&nbsp;&nbsp;·信箱办理
									</span></td>
								</tr>			
								<%
											rs = null;
											count = 0;
											count1 = 0;
											String qzxxSql = "SELECT count(decode(c.cw_status,'1','1','')) a1,count(decode(c.cw_status,'2','1','')) a2 FROM tb_connwork c,tb_deptinfo d," +
																			 "tb_connproc p WHERE (p.cp_id='o1'or p.cp_upid='o1') and c.cp_id=p.cp_id " +
																			 " and c.cw_zhuanjiao=3 and p.dt_id = " + dt_id + " and p.dt_id=d.dt_id";
											//out.println(qzxxSql);
											rs = dImpl.executeQuery(qzxxSql);
											if (rs.next()) {
											count = rs.getInt("a1");
											count1 = rs.getInt("a2");
											if(count!=0||count1!=0){
								%>	
								<tr class="line-odd" width="100%" colspan="2">
									<td valign="center" width="15%" align="left"><span style="font:黑体">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;·区长信箱 --> <a href="#" onclick="javascript:parent.parent.main_content.location.href='../../wardenmail/AppealList.jsp?cw_status=1&Menu=区长信箱&Module=待处理信件'">待处理信件</a>(共
								<%
											out.print(count + " 条)");
								%>
										</span></td>
								</tr>
								<tr class="line-odd" width="100%" colspan="2">
									<td valign="center" width="15%" align="left"><span style="font:黑体">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;·区长信箱 --> <a href="#" onclick="javascript:parent.parent.main_content.location.href='../../wardenmail/AppealList.jsp?cw_status=2&Menu=区长信箱&Module=处理中信件'">处理中信件</a>(共
								<%
											out.print(count1 + " 条)");
								%>
										</span></td>
								</tr>
								<%
								}
											}
											rs = null;
											count = 0;
											count1=0;
											String wszxSql = "select count(decode(c.cw_status,'1','1','')) a1,count(decode(c.cw_status,'2','1','')) a2 from tb_connwork c,tb_deptinfo d,tb_connproc p where " +
																			 "p.cp_upid='o7' and c.cp_id=p.cp_id and p.dt_id = " + dt_id 
																			 + " and p.dt_id=d.dt_id";
											rs = dImpl.executeQuery(wszxSql);
											if (rs.next()) {
											count = rs.getInt("a1");
											count1 = rs.getInt("a2");
											if(count!=0||count1!=0){
								%>
								<tr class="line-even" width="100%" colspan="2">
									<td valign="center" width="15%" align="left"><span style="font:黑体">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;·网上咨询 --> <a href="#" onclick="javascript:parent.parent.main_content.location.href='../../consultation/AppealList.jsp?cw_status=1&Menu=网上咨询&Module=待处理咨询'">待处理咨询</a>(共
										<%
											out.print(count + " 条)");
										%>
										</td>
								</tr>
								<tr class="line-even" width="100%" colspan="2">
									<td valign="center" width="15%" align="left"><span style="font:黑体">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;·网上咨询 --> <a href="#" onclick="javascript:parent.parent.main_content.location.href='../../consultation/AppealList.jsp?cw_status=2&Menu=网上咨询&Module=处理中咨询'">处理中咨询</a>(共
										<%
											out.print(count1 + " 条)");
										%>
										</td>
								</tr>
								
								<%
											}
											}
											rs = null;
											count = 0;
											count1=0;
											String jzldxxSql = "select count(decode(c.cw_status,'1','1','')) a1,count(decode(c.cw_status,'2','1','')) a2 from tb_connwork c,tb_deptinfo d,tb_connproc p where " +
																				 "p.cp_upid='o10000' and c.cp_id=p.cp_id and p.dt_id = " + dt_id 
																				 + " and p.dt_id=d.dt_id";
											rs = dImpl.executeQuery(jzldxxSql);
											if (rs.next()){
											count = rs.getInt("a1");
											count1 = rs.getInt("a2");
											if(count!=0||count1!=0){
								%>
								<tr class="line-odd" width="100%" colspan="2">
									<td valign="center" width="15%" align="left"><span style="font:黑体">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;·街镇领导信箱 --> <a href="#" onclick="javascript:parent.parent.main_content.location.href='../../mailtation/AppealList.jsp?cw_status=1&Menu=街镇领导信箱&Module=待处理信件'">待处理信件</a>(共
										<%
											out.print(count + " 条)");
										%>
										</td>
								</tr>
								<tr class="line-odd" width="100%" colspan="2">
									<td valign="center" width="15%" align="left"><span style="font:黑体">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;·街镇领导信箱 --> <a href="#" onclick="javascript:parent.parent.main_content.location.href='../../mailtation/AppealList.jsp?cw_status=2&Menu=街镇领导信箱&Module=处理中信件'">处理中信件</a>(共
										<%
											out.print(count1 + " 条)");
										%>
										</td>
								</tr>
								
								<%
								}
											}
											rs = null;
											count = 0;
											count1 = 0;
											String tsxxSql = "select count(decode(c.cw_status,'1','1','')) a1,count(decode(c.cw_status,'2','1','')) a2 from tb_connwork c,tb_deptinfo d,tb_connproc p where " +
																			 "c.cp_id=p.cp_id and (p.cp_id in('o4','o8','o9') or p.cp_upid='o4') and p.dt_id = " +
																			 dt_id + " and p.dt_id=d.dt_id";
											rs = dImpl.executeQuery(tsxxSql);
											if (rs.next()) {
											count = rs.getInt("a1");
											count1 = rs.getInt("a2");
											if(count!=0||count1!=0){
								%>
								<tr class="line-odd" width="100%" colspan="2">
									<td valign="center" width="15%" align="left"><span style="font:黑体">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;·投诉信箱 --> <a href="#" onclick="javascript:parent.parent.main_content.location.href='../../appeal/AppealList.jsp?cw_status=1&Menu=投诉信箱&Module=待处理投诉'">待处理投诉</a>(共
										<%
											out.print(count + " 条)");
										%>
										</td>
								</tr>
								<tr class="line-odd" width="100%" colspan="2">
									<td valign="center" width="15%" align="left"><span style="font:黑体">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;·投诉信箱 --> <a href="#" onclick="javascript:parent.parent.main_content.location.href='../../appeal/AppealList.jsp?cw_status=2&Menu=投诉信箱&Module=处理中投诉'">处理中投诉</a>(共
										<%
											out.print(count1 + " 条)");
										%>
										</td>
								</tr>
								
								<%
										}
										}
										rs = null;
										count = 0;
										count1=0;
										String xfxxSql = "select count(decode(c.cw_status,'1','1','')) a1,count(decode(c.cw_status,'2','1','')) a2 from tb_connwork c,tb_deptinfo d,tb_connproc p where " +
										 								 "(p.cp_id='o5' or p.cp_upid='o5') and c.cw_zhuanjiao=3 and c.cp_id=p.cp_id and p.dt_id = " +
										 								 dt_id + " and p.dt_id=d.dt_id";
										rs = dImpl.executeQuery(xfxxSql);
										if (rs.next()) {
											count = rs.getInt("a1");
											count1 = rs.getInt("a2");
											if(count!=0||count1!=0){
								%>
								<tr class="line-even" width="100%" colspan="2">
									<td valign="center" width="15%" align="left"><span style="font:黑体">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;·信访信箱 --> <a href="#" onclick="javascript:parent.parent.main_content.location.href='../../complaint/AppealList.jsp?cw_status=1&Menu=信访信箱&Module=待处理信访'">待处理信访</a>(共
										<%
											out.print(count + " 条)");
										%>
										</span></td>
								</tr>
								<tr class="line-even" width="100%" colspan="2">
									<td valign="center" width="15%" align="left"><span style="font:黑体">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;·信访信箱 --> <a href="#" onclick="javascript:parent.parent.main_content.location.href='../../complaint/AppealList.jsp?cw_status=2&Menu=信访信箱&Module=处理中信访'">处理中信访</a>(共
										<%
											out.print(count1 + " 条)");
										%>
										</span></td>
								</tr>
								
								<%
									}
									}
									rs = null;
									count = 0;
									count1=0;
									String blxxSql = "select count(decode(c.cw_status,'1','1','')) a1,count(decode(c.cw_status,'2','1','')) a2 from tb_connwork c,tb_deptinfo d,tb_connproc p where " +
									 								 "(p.cp_id='o13'or p.cp_upid='o13') and c.cp_id=p.cp_id and p.dt_id = " +
									 								 dt_id + " and p.dt_id=d.dt_id";
									rs = dImpl.executeQuery(blxxSql);
									if (rs.next()) {
											count = rs.getInt("a1");
											count1 = rs.getInt("a2");
											if(count!=0||count1!=0){
								%>
								<tr class="line-even" width="100%" colspan="2">
									<td valign="center" width="15%" align="left"><span style="font:黑体">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;·办理信箱 --> <a href="#"  onclick="javascript:parent.parent.main_content.location.href='../../parliament/AppealList.jsp?cw_status=1&Menu=办理件处理&Module=待处理信件'">待处理信件</a>(共
										<%
											out.print(count + " 条)");
										%>
										</span></td>
								</tr>
								<tr class="line-even" width="100%" colspan="2">
									<td valign="center" width="15%" align="left"><span style="font:黑体">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;·办理信箱 --> <a href="#"  onclick="javascript:parent.parent.main_content.location.href='../../parliament/AppealList.jsp?cw_status=2&Menu=办理件处理&Module=处理中信件'">处理中信件</a>(共
										<%
											out.print(count1 + " 条)");
										%>
										</span></td>
								</tr>
								
								<%
										}
										}
										rs = null;
										count = 0;
										count1 = 0;
										String jzSql = "select count(decode(c.cw_status,'1','1','')) a1,count(decode(c.cw_status,'2','1','')) a2 from tb_connwork c,tb_deptinfo d,tb_connproc p where " +
										 								 "(p.cp_id='o11100') and c.cp_id=p.cp_id  and p.dt_id = " +
										 								 dt_id + " and p.dt_id=d.dt_id";
										rs = dImpl.executeQuery(jzSql);
										if (rs.next()) {
											count = rs.getInt("a1");
											count1 = rs.getInt("a2");
											if(count!=0||count1!=0){
								%>
								<tr class="line-even" width="100%" colspan="2">
									<td valign="center" width="15%" align="left"><span style="font:黑体">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;·信访领导信箱 --> <a href="#" onclick="javascript:parent.parent.main_content.location.href='../../xfjzmail/AppealList.jsp?cw_status=1&Menu=办理件处理&Module=待处理信件'">待处理信件</a>(共
								<%
										out.print(count + " 条)");
								%>
										</span></td>
								</tr>
								<tr class="line-even" width="100%" colspan="2">
									<td valign="center" width="15%" align="left"><span style="font:黑体">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;·信访领导信箱 --> <a href="#" onclick="javascript:parent.parent.main_content.location.href='../../xfjzmail/AppealList.jsp?cw_status=8&Menu=办理件处理&Module=协调中信件'">协调中信件</a>(共
								<%
										out.print(count1 + " 条)");
								%>
										</span></td>
								</tr>
								
								<%
										}
										}
										rs = null;
										count = 0;
										count1 = 0;
										String rmyjSql = "select count(decode(c.cw_status,'1','1','')) a1,count(decode(c.cw_status,'2','1','')) a2 from tb_connwork c,tb_deptinfo d,tb_connproc p where " +
										 								 "(p.cp_id='o11200') and c.cp_id=p.cp_id and p.dt_id = " +
										 								 dt_id + " and p.dt_id=d.dt_id";
										rs = dImpl.executeQuery(rmyjSql);
										if (rs.next()) {
											count = rs.getInt("a1");
											count1 = rs.getInt("a2");
											if(count!=0||count1!=0){
								%>
								<tr class="line-even" width="100%" colspan="2">
									<td valign="center" width="15%" align="left"><span style="font:黑体">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;·人民意见征集 --> <a href="#" onclick="javascript:parent.parent.main_content.location.href='../../rmyjzj/AppealList.jsp?cw_status=1&Menu=办理件处理&Module=待处理信件'">待处理意见</a>(共
										<%
											out.print(count + " 条)");
										%>
										</span></td>
								</tr>
								<tr class="line-even" width="100%" colspan="2">
									<td valign="center" width="15%" align="left"><span style="font:黑体">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;·人民意见征集 --> <a href="#" onclick="javascript:parent.parent.main_content.location.href='../../rmyjzj/AppealList.jsp?cw_status=2&Menu=办理件处理&Module=处理中信件'">处理中意见</a>(共
										<%
											out.print(count1 + " 条)");
										%>
										</span></td>
								</tr>
								
								<%
											}
											}
								}
								%>
								<!-----------------------信箱办理的相关问题end--------------------------->
								<!-----------------------典型案例--------------------------->
								<%
											rs = null;
											count = 0;
											String dxalSql = "select count(*) count from tb_conncase cs where to_char(cs.cs_date,'yyyy-mm') ='"+noday+"' and cs.dt_id=" + dt_id + " order by cs.datecreated desc";
											//out.println(dxalSql);
											rs = dImpl.executeQuery(dxalSql);
											if (rs.next()) count = rs.getInt("count");
											if (count == 0) {
								%>
								<tr class="line-even" width="100%" colspan="2">
								<td valign="center" width="15%" align="left"><span style="font:黑体">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;·典型案例 --> <font color="red">您本月没有报送典型案例，请及时报送！</font>
										</span></td>
								</tr>
								<%
											}
								%>
								<!-----------------------典型案例--------------------------->
								<!-----------------------协调单相关处理start--------------------------->
								<%
									if(vectorSignedCorr!=null)
									{
								%>
								<tr class="line-odd" width="100%">
									<td valign="center" width="15%" align="left">·已签收协调单(共
								<%
									SignedCorrSize = String.valueOf(vectorSignedCorr.size());
									out.println(SignedCorrSize);
								%>
									条)</td>
								</tr>
								<%
									if(vectorSignedCorr.size()>5)
									{
										showSignedCorrSize = 5;
									}
									else
									{
										showSignedCorrSize = vectorSignedCorr.size();
									}

									for(int i=0;i<showSignedCorrSize;i++)
									{
											Hashtable content = (Hashtable)vectorSignedCorr.get(i);
											wo_projectname = content.get("wo_projectname").toString();
											senddept = content.get("senddept").toString();
											de_status = content.get("de_status").toString();
											de_signtime = content.get("de_signtime").toString();
											de_feedbacksigntime = content.get("de_feedbacksigntime").toString();
											co_id = content.get("co_id").toString();
											wo_id = content.get("wo_id").toString();
											de_id = content.get("de_id").toString();
											de_senddeptid = content.get("de_senddeptid").toString();
								%>
									<tr class="line-even" width="100%">
										<td>&nbsp;<%=i+1%>
										<%
											String optype="";
											if(de_status.equals("2"))
											{
												optype="dealwith";
											}
											else
											{
												optype="See";
											}
											%>
										<a href="#" onclick="javascript:parent.parent.main_content.location.href='/system/app/cooperate/CorrForm.jsp?OPType=<%=optype%>&co_id=<%=co_id%>'">
										<%=wo_projectname%>&nbsp;&nbsp;
										[发送部门:<%=senddept%>&nbsp;&nbsp;
										<%if(de_status.equals("2"))
										{
											out.println("发送");
										}
										else
										{
											out.println("反馈");
										}%>签收时间:
										<%
											if(de_status.equals("2"))
										{
											out.println(de_signtime);
										}
										    else
										{
												out.println(de_feedbacksigntime);
										}
										%>]
										</a>
										</td>
									</tr>
									<%
									}
									%>
										<tr class="line-odd" width="100%">
											<td valign="center" align="right" width="70%">
											<a href="#" onclick="javascript:parent.parent.main_content.location.href='/system/app/cooperate/SignedCorrList.jsp'">
											更多
											</a>
											</td>
										</tr>
								<%
								}
								%>
								<!-----------------------协调单相关处理end--------------------------->
							</table>
						</td>
					</tr>
				</form>
</table>
<!--    列表结束    -->
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