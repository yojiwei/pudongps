<%@ page contentType="text/html; charset=GBK"%>
<%@include file="/website/include/head.jsp"%>
<%@page import="com.website.*"%>
<%//Update 20061231

User checkLogin = (User)session.getAttribute("user");
if(checkLogin==null||!checkLogin.isLogin())
{
      out.println("<script>");
      out.println("window.location.href='/website/login/Login.jsp';");
      out.println("</script>");

}

String wo_id = "";
String pr_name = "";
String pr_id = "";
String us_id = "";
String sqlStr = "";
String sqlStr1 = "";
String sqlStr2 = "";
String path = "";
String imgPath = "";
String status = "";
String deptName = "";//部门名
String beginTime = "";//收到时间
String endTime = ""; //办结时间
String PType = "";
String timeLimit = "";
String isOverTime = "";
String sendDept = "";

PType = CTools.dealString(request.getParameter("PType")).trim();
CDataCn dCn = null;
CDataImpl dImpl = null;
try{
dCn = new CDataCn();
dImpl = new CDataImpl(dCn); 
CDataImpl l_dImpl = new CDataImpl(dCn);
CDataImpl m_dImpl = new CDataImpl(dCn);
CDataImpl l_dImpl_1 = new CDataImpl(dCn);
path = l_dImpl.getInitParameter("images_save_path");
User user = (User)session.getAttribute("user");
%>
<table width="100%" border="0" align="center" cellpadding="0" cellspacing="8">
  <tr>
    <td>
		<table width="100%" border="1" cellpadding="0" cellspacing="0" bordercolor="#FFFFFF">
        	<tr>
          		<td bordercolor="#C7C7C7">
					<table width="100%" border="0" align="center" cellpadding="0" cellspacing="8">
			          <tr>
			            <td colspan="2"><img src="/website/images/center_1.gif" width="577" height="29"></td>
			          </tr>
			          <tr>
			            <td width="80%" valign="top"> <table width="100%" border="1" cellpadding="0" cellspacing="0" bordercolor="#FFFFFF">
			                <tr>
			                  <td bordercolor="#B49F66"> 
			                  	<table width="100%" border="0" cellspacing="0" cellpadding="0">
			                      <tr bgcolor="#B49F66">
			                        <td height="18" colspan="2"> <div align="right"><font color="#FFFFFF">
									<%
									CDate nowDay = new CDate();
									out.print(nowDay.getNowYear()+"年"+nowDay.getNowMonth()+"月"+nowDay.getNowDay()+"日");
									out.print("&nbsp;");
									switch(java.util.Calendar.getInstance().get(Calendar.DAY_OF_WEEK))
									{
										case java.util.Calendar.SUNDAY:out.print("星期日");break;
										case java.util.Calendar.MONDAY:out.print("星期一");break;
										case java.util.Calendar.TUESDAY:out.print("星期二");break;
										case java.util.Calendar.WEDNESDAY:out.print("星期三");break;
										case java.util.Calendar.THURSDAY:out.print("星期四");break;
										case java.util.Calendar.FRIDAY:out.print("星期五");break;
										case java.util.Calendar.SATURDAY:out.print("星期六");break;
									}
									%>	                        
                        			</font></div></td>
                      			</tr>
		                      <tr>
		                        <td width="135" rowspan="3" background="/website/images/center_3.gif">
		                          <div align="center">
		                            <%if(user!=null) out.print(user.getUserName()+"，");%>
		                            <font color="#513D00">您好<br>
		                            上海浦东欢迎您！</font></div></td>
		                        <td height="20" bgcolor="#FBF4EE"><div align="center"><font color="#513D00">信息反馈</font></div></td>
		                      </tr>
		                      <tr>
		                        <td height="1" bgcolor="#B49F66"><img src="/website/images/center_2.gif" width="1" height="1"></td>
		                      </tr>
		                      <tr>
		                        <td height="60" bgcolor="#FBF4EE" valign="top">
		                        	<table cellspacing="3" border="0" width="100%">
                          <!--此处放置显示消息的代码-->
                          <%
									if (user!=null)
									{
										us_id = user.getId();
										sqlStr1 = "select a.ma_id,b.wo_projectname from tb_message a,tb_work b where a.ma_isnew='1' and a.ma_receiverId='"+us_id+"' and a.ma_relatedtype='1' and a.ma_primaryid=b.wo_id order by a.ma_sendtime desc";
						                                sqlStr2 = "select a.ma_id,b.cw_subject,c.cp_name from tb_message a,tb_connwork b,tb_connproc c where a.ma_isnew='1' and a.ma_receiverId='"+us_id+"' and a.ma_relatedtype='1' and a.ma_primaryid=b.cw_id and b.cp_id=c.cp_id order by a.ma_sendtime desc";
										Vector l_vPage = l_dImpl.splitPage(sqlStr1,100,1);
										Vector m_vPage = m_dImpl.splitPage(sqlStr2,100,1);
                                                                                //out.println(sqlStr1+"  "+sqlStr2);
										if (l_vPage!=null)
										{
											for (int i=0;i<l_vPage.size();i++)
											{
												Hashtable l_content = (Hashtable)l_vPage.get(i);
												String ma_id = l_content.get("ma_id").toString();
												CMessage msg = new CMessage(l_dImpl,ma_id);
												%> 
												<tr><td>&nbsp;<a href="javascript:readMsg('<%=ma_id%>','Read');" title="<%=l_content.get("wo_projectname").toString()%>"><%=msg.getValue(CMessage.msgTitle)%></a>&nbsp;<%=msg.getValue(CMessage.msgSendTime)%>&nbsp;<%=msg.getValue(CMessage.msgSenderDesc)%></td></tr> <%
											}
										}
						                                //else
						                                  if (m_vPage!=null)
						                                {
						                                        for (int j=0;j<m_vPage.size();j++)
						                                        {
						                                                Hashtable m_content = (Hashtable)m_vPage.get(j);
						                                                String ma_id = m_content.get("ma_id").toString();
						                                                CMessage msg = new CMessage(m_dImpl,ma_id);
						                                                %> 
						                                                <tr><td>&nbsp;<a href="javascript:readMsg('<%=ma_id%>','Read');" title="<%=m_content.get("cw_subject").toString()%>"><%=msg.getValue(CMessage.msgTitle)%></a>&nbsp;<%=m_content.get("cp_name").toString()%>&nbsp;<%=msg.getValue(CMessage.msgSendTime)%>&nbsp;<%=msg.getValue(CMessage.msgSenderDesc)%></td></tr> <%
						                                        }
										}
										if (l_vPage==null&&m_vPage==null)
										{
											out.print("<tr><td>&nbsp;没有消息！</td></tr>");
										}
									}
									%>
									</table>
								</td>
		                      </tr>
		                    </table>
						</td>
                	</tr>
              	</table>
			</td>
            <td>
				<table width="90%" border="0" align="center" cellpadding="0" cellspacing="4">
					<tr>
	                  <td width="22"><img src="/website/images/center_4.gif" width="22" height="16"></td>
	                  <td><a href="/website/login/Logout.jsp">用户注销</a></td>
	                </tr>
	                <tr>
	                  <td width="22"><img src="/website/images/center_4.gif" width="22" height="16"></td>
	                  <td><a href="/website/usermanage/Modify.jsp">用户信息维护</a></td>
	                </tr>
	                <!--<tr>
	                  <td width="22"><img src="/website/images/center_5.gif" width="22" height="20"></td>
	                  <td>个性化设置</td>
	                </tr>-->
	                <tr>
	                  <td colspan="2"><a href="/website/consultation/AppealInfo.jsp"><img src="/website/images/center_6.gif" width="96" height="18" border="0"></a></td>
	                </tr>
	                <tr>
	                  <td colspan="2"><a href="/website/connection/SuperviseMain.jsp?PType=doing"><img src="/website/images/center_7.gif" width="96" height="18" border="0"></a></td>
	                </tr>
              </table>
			</td>
          </tr>
		  <tr>
			<td colspan="2">
				<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
					<tr>
						<td width="1" rowspan="12" bgcolor="#B49F66"><img src="../user_center/center_2.gif" width="1" height="1"></td>
						<td height="4" colspan="15" bgcolor="#B49F66"><img src="../user_center/center_8.gif" width="1" height="4"></td>
						<td width="1" rowspan="12" bgcolor="#B49F66"><img src="../user_center/center_2.gif" width="1" height="1"></td>
					</tr>
					<tr>
						<td valign="top">
							<table width="100%" border="0" cellspacing="3" cellpadding="1">
								<tr>
									<td>
									 <table width="100%" border="0" cellspacing="0" cellpadding="0">
										<tr>
											<td width="15%" bordercolor="#B49F66" <%if(PType.equals("doing")||PType.equals("")) out.print("bgcolor='#B49F66'");%>><%if(PType.equals("doing")||PType.equals("")){%><div align="center">在办事项</div><%}else{%><div align="center"><a href="index.jsp?PType=doing">在办事项</a></div><%}%></td>
											<td width="15%" bordercolor="#B49F66" <%if(PType.equals("done")) out.print("bgcolor='#B49F66'");%>><%if(PType.equals("done")){%><div align="center">已办事项</div><%}else{%><div align="center"><a href="index.jsp?PType=done">已办事项</a></div><%}%></td>
											<td width="55%" colspan="5">&nbsp;</td>
										</tr>
									 </table>
									</td>
								</tr>
								<tr>
									<td>
												<!-- 开始 -->
											 <table width="100%" border="0" cellspacing="1" cellpadding="0" bgcolor="#B49F66">
												 <tr>
												 	<td width="3%" height="20" bgcolor="#F2E5D4"><div align="center">●</div></td>
													<td width="29%" height="20" bgcolor="#F2E5D4"><div align="center">事项名称</div></td>
													<td width="8%" height="20" bgcolor="#F2E5D4"><div align="center">当前状态</div></td>
													<td width="10%" height="20" bgcolor="#F2E5D4"><div align="center">办事部门</div></td>
													<td width="7%" height="20" bgcolor="#F2E5D4"><div align="center">状态</div></td>
													<td height="20" bgcolor="#F2E5D4" width="10%"><div align="center">收到时间</div></td>
													<td height="20" bgcolor="#F2E5D4" width="10%"><div align="center">办结时间</div></td>
													<td width="15%" height="20" bgcolor="#F2E5D4"><div align="center">时限、流程</div></td>
												 </tr>
												 <%
													if(us_id!=null)
													{
														if (PType.equals("doing")||PType.equals(""))
														{
															sqlStr = "select a.*,b.pr_timelimit from tb_work a,tb_proceeding b where a.us_id='"+us_id+"' and a.wo_status in('0','1','2','8') and a.pr_id=b.pr_id order by a.wo_applytime desc";
														}
														else
														{
															sqlStr = "select a.*,b.pr_timelimit from tb_work a,tb_proceeding b where a.us_id='"+us_id+"' and a.wo_status in('3','4') and a.pr_id=b.pr_id order by a.wo_applytime desc";
														}
														Vector l_vPage = l_dImpl.splitPage(sqlStr,request,5);
														if (l_vPage!=null)
														{
															for(int i=0;i<l_vPage.size();i++)
															{
																Hashtable l_content = (Hashtable)l_vPage.get(i);
																isOverTime = l_content.get("wo_isovertime").toString();
																pr_id = l_content.get("pr_id").toString();
																wo_id = l_content.get("wo_id").toString();
																timeLimit = l_content.get("pr_timelimit").toString();
																pr_name = l_content.get("wo_projectname").toString();
																 %>
												 <tr bgcolor="<%if(i%2==0) out.print("#ffffff");else out.print("#FBF4EE");%>">
												 		<td align="center"><div title="<%if(!isOverTime.equals("1")) out.print("未超时");else out.print("已超时");%>"><font color="<%if(!isOverTime.equals("1")) out.print("green"); else out.print("red");%>">●</font></div></td>
														<td align="left"><a title="<%=pr_name%>" href="ProjectOnline.jsp?pr_id=<%=pr_id%>&wo_id=<%=wo_id%>"><%if(pr_name.length()>16) out.print("&nbsp;"+pr_name.substring(0,16)+"...");else out.print("&nbsp;"+pr_name);%></a></td>
														<td align="center">
														<%
														switch(Integer.parseInt(l_content.get("wo_status").toString()))
														{
															case 0: status = "暂存";break;
															case 1: status = "进行中";break;
															case 2: status = "待补件";break;
															case 3: status = "已通过";break;
															case 4: status = "未通过";break;
															case 8: status = "协调中";break;
														}
														out.print(status);
														%>
													</td>
													<td colspan="4">
														<!---->
														<table width="100%" align="center">
															<tr>
																<td align="left" colspan="4"><b>主办部门</b></td>
															</tr>
														<%
														//搜索主办部门信息
														sqlStr = "select b.dt_name,to_char(a.wo_applytime,'yyyy-mm-dd hh24:mi:ss') wo_applytime,to_char(a.wo_finishtime,'yyyy-mm-dd hh24:mi:ss') wo_finishtime ";
														sqlStr += "from tb_work a,tb_deptinfo b,tb_proceeding c ";
														sqlStr += "where a.wo_id='"+wo_id+"' and a.pr_id=c.pr_id and c.dt_idext=b.dt_id";

														l_content = l_dImpl_1.getDataInfo(sqlStr);
														if (l_content!=null)
														{
															deptName = l_content.get("dt_name").toString();
															beginTime = l_content.get("wo_applytime").toString();
															endTime = l_content.get("wo_finishtime").toString();
															beginTime = CFormatDate.getMonthDay(beginTime);
															endTime = CFormatDate.getMonthDay(endTime);

														%>
															<tr width="100%">
																<td align="center" width="30%"><%=deptName%></td>
																<td align="left" width="25%"><%=status%></td>
																<td align="left" width="25%"><%if(beginTime.equals("")) out.print("&nbsp;");else out.print(beginTime);%></td>
																<td align="left" width="20%"><%if(endTime.equals("")) out.print("&nbsp;");else out.print(endTime);%></td>
															</tr>
														<%
														}
														sqlStr = "select a.co_status,b.dt_name recDept,d.dt_name sendDept, c.de_sendtime,c.de_feedbacktime ";
														sqlStr += "from tb_correspond a,tb_deptinfo b,tb_documentexchange c ,tb_deptinfo d ";
														sqlStr += "where a.wo_id='"+wo_id+"' and a.co_id=c.de_primaryid and c.de_receiverdeptid=b.dt_id and c.de_senddeptid=d.dt_id and c.de_type='1'";
														//out.print(sqlStr);out.close();
														Vector l_vPage1 = l_dImpl_1.splitPage(sqlStr,20,1);
														if (l_vPage1!=null)
														{
															%>
															<tr>
																<td colspan="4" align="left"><b>协办部门</b></td>
															</tr>
															<%
															for (int j=0;j<l_vPage1.size();j++)
															{
																l_content = (Hashtable)l_vPage1.get(j);
																deptName = l_content.get("recdept").toString();
																sendDept = l_content.get("senddept").toString();
																beginTime = l_content.get("de_sendtime").toString();
																endTime = l_content.get("de_feedbacktime").toString();
																status = l_content.get("co_status").toString();

																switch(Integer.parseInt(status))
																{
																	case 1: status = "进行中";break;
																	case 2: status = "待补件";break;
																	case 3: status = "已通过";break;
																	case 4: status = "未通过";break;
																}

																beginTime = CFormatDate.getMonthDay(beginTime);
																endTime = CFormatDate.getMonthDay(endTime);
																%>
																<tr width="100%">
																	<td align="center" width="25%"><%if(status.equals("已通过")||status.equals("未通过")) out.print(sendDept);else out.print(deptName);%></td>
																	<td align="left" width="25%"><%=status%></td>
																	<td align="left" width="25%"><%if(beginTime.equals("")) out.print("&nbsp;");else out.print(beginTime);%></td>
																	<td align="left" width="25%"><%if(endTime.equals("")) out.print("&nbsp;");else out.print(endTime);%></td>
																</tr>
																<%
															}
														}
														%>
														</table>
														<!---->
													</td>
													<td width="120" align="center">
													时限(<font color="red"><%=timeLimit%></font>个工作日)<br>
															<div align="center">
															<%
															sqlStr = "select pr_imgpath from tb_proceeding where pr_id='"+pr_id+"'";

															l_content = l_dImpl_1.getDataInfo(sqlStr);

															if(l_content!=null)
															{
																imgPath = l_content.get("pr_imgpath").toString();
																if (!imgPath.equals("")) //如果有图片，则显示
																{
																	java.io.File imgDir = new java.io.File(path+imgPath);
																	if(imgDir.exists())
																	{
																		String[] fList = imgDir.list();
																		if(fList.length>0)
																		{
																			String imgName = fList[0];
																			out.print("<img src="+l_dImpl.getInitParameter("images_http_path")+imgPath+"//"+imgName+">");
																		}
																	}
																}
															}

															%>
															</div>
													</td>
												 </tr>
												 <%
                      		}
                      	}
			else
															{
																out.print("<tr class='line-even'><td colspan='9'>没有符合条件的项目！</td></tr> ");
															}
                      }
												out.print("<tr><td bgcolor='#FBF4EE' colspan=9>"+l_dImpl.getTail(request)+"</td></tr>");
                      %>
											</table>

										<!-- 结束 -->
										</td>
									 </tr>
									</table>
								</td>
							 </tr>
							 <tr>
								<td height="4" colspan="15" bgcolor="#B49F66"><img src="../user_center/center_8.gif" width="1" height="4"></td>
							 </tr>
							</table>
					</td>
				</tr>
    </table>
		</td>
	</tr>
</table>
</td>
	</tr>
</table>
	<script language="javascript">
function readMsg(id,type)
{
        var w=450;
        var h=250;
        var url = "MessageDetail.jsp?ma_id="+id+"&OPType="+type;

        window.open(url,"查看消息","Top=0px,Left=0px,Width="+w+"px,Height="+h+"px,toolbar=no,location=no,derectories=no,status=no,menubar=no,resizable=no,scrollbars=no");
}
</script>

<%
l_dImpl_1.closeStmt();
l_dImpl.closeStmt();
}
catch(Exception e){
//e.printStackTrace();
out.print(e.toString());
}
finally{
dImpl.closeStmt();
dCn.closeCn(); 
}
%>
<%@include file="/website/include/bottom.jsp"%>