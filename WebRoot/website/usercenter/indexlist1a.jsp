<%@include file="/website/include/import.jsp"%>

<table width="100%" border="0" cellspacing="3" cellpadding="1">
                                               			<tr>
									<td>
												<!-- 开始 -->
											 <table width="100%" border="0" cellspacing="1" cellpadding="0" bgcolor="#7DAFFB">
												 <tr>
												 	<td width="3%" height="20" bgcolor="#C9DEFE"><div align="center">●</div></td>
													<td width="29%" height="20" bgcolor="#C9DEFE"><div align="center">事项名称</div></td>
													<td width="8%" height="20" bgcolor="#C9DEFE"><div align="center">当前状态</div></td>
													<td width="10%" height="20" bgcolor="#C9DEFE"><div align="center">办事部门</div></td>
													<td width="7%" height="20" bgcolor="#C9DEFE"><div align="center">状态</div></td>
													<td height="20" bgcolor="#C9DEFE" width="10%"><div align="center">收到时间</div></td>
													<td height="20" bgcolor="#C9DEFE" width="10%"><div align="center">办结时间</div></td>
													<td width="15%" height="20" bgcolor="#C9DEFE"><div align="center">时限、流程</div></td>
												 </tr>
												 <%//Update 20061231

													if(us_id!=null)
													{

															sqlStr = "select a.*,b.pr_timelimit from tb_work a,tb_proceeding b where a.us_id='"+us_id+"' and a.wo_status in('0','1','2','8') and a.pr_id=b.pr_id order by a.wo_applytime desc";

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
												 <tr bgcolor="<%if(i%2==0) out.print("#ffffff");else out.print("#EEF4FF");%>">
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
												out.print("<tr><td bgcolor='#EEF4FF' colspan=9>"+l_dImpl.getTail(request)+"</td></tr>");
                      %>
											</table>

										<!-- 结束 -->
										</td>
									 </tr>

</table>
