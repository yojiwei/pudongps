<%@ page contentType="text/html; charset=GBK"%>
<%@ include file="/website/include/import.jsp"%>
<%@page import="com.website.*"%>
<%@ page pageEncoding="GBK"%>
<%

User checkLogin = (User)session.getAttribute("user");
if(checkLogin==null||!checkLogin.isLogin())
{
      out.println("<script>");
    out.println(" window.open('/website/login/Login.jsp');");
      out.println("</script>");
	  return;
}

String wo_id = "";
String wo_status = "";
String pr_name = "";
String pr_id = "";
String pr_url = "";
String us_id = "";
String us_uid = "";
String sqlStr = "";
String sqlStr1 = "";
String sqlStr2 = "";
String sqlStr3 = "";
String sqlStr4 = "";
String path = "";
String imgPath = "";
String status = "";
String deptName = "";//部门名
String beginTime = "";//收到时间
String endTime = ""; //办结时间
String timeLimit = "";
String isOverTime = "";
String sendDept = "";
Vector vPage = null;
Hashtable content = new Hashtable();

String us_pwdN = CTools.dealString(request.getParameter("asd"));
String us_uidN = CTools.dealString(request.getParameter("rfv"));

//Update 20061231
CDataCn dCn = null;
CDataImpl dImpl = null;
try{
dCn = new CDataCn();
dImpl = new CDataImpl(dCn); 
CDataImpl l_dImpl = new CDataImpl(dCn);
CDataImpl m_dImpl = new CDataImpl(dCn);
CDataImpl n_dImpl = new CDataImpl(dCn);
CDataImpl k_dImpl = new CDataImpl(dCn);
CDataImpl l_dImpl_1 = new CDataImpl(dCn);
path = l_dImpl.getInitParameter("images_save_path");
User user = (User)session.getAttribute("user");
if(user != null) {
	us_uid = user.getUid();  
	us_id = user.getId();
}else{
	user = new User(dCn);//
	if(user.loginWSB(CBase64.getDecodeString(us_uidN),CBase64.getDecodeString(us_pwdN),"o27")){
		session.setAttribute("user",user);
		us_uid = user.getUid();  
		us_id = user.getId();
	}
}
String url = "";
//String url = _WEBSTART + "/website/userLogin.jsp?id=" + us_uid;
%>
<link href="images/newWebMain.css" rel="stylesheet" type="text/css" />
<link href="images/main.css" rel="stylesheet" type="text/css" />

<body topmargin="0" leftmargin="0"  bgcolor="transparent" cellspacing="0" cellpadding="0">

<table width="100%" border="0" cellspacing="0" cellpadding="0">
             
              <tr>
                <td height="4" align="left" valign="top"><img src="images/usercenterNEW_line03.gif" width="515" height="1" /></td>
              </tr>
              <tr>
                <td align="left" valign="top">
				
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
                  <tr>
                    <td width="22" height="30" align="left" valign="top"><img src="images/usercenterNEW_icon16.gif" width="17" height="17" vspace="4" /></td>
                    <td width="250" align="left" valign="middle" class="f14"><font color="#AD0000"><strong>已办事项</strong></font></td>
                    <!--查询文件导入 -->
                 <%@include file="/website/usercenter/search.jsp"%>
              <tr>
                <td valign="top"><table width="100%" border="0" cellspacing="0" cellpadding="0">
                  <tr>
                    <td valign="bottom"><!--<table width="100%" border="0" cellspacing="0" cellpadding="0">
                      <tr>
                        <td width="5"></td>
                        <td align="left" valign="top"><font color="#072997"><font color="#666666">选择：</font><a href="#"><font color="#072997">全部</font></a> - <a href="#"><font color="#072997">无</font></a> - <a href="#"><font color="#072997">已读</font></a> - <a href="#"><font color="#072997">未读</font></a></font></td>
                      </tr>
                    </table>--></td>
                  </tr>
                  <tr>
                    <td valign="top"><table width="100%" border="0" cellspacing="1" cellpadding="0">
                      <tr>
                        <td height="1" colspan="25" bgcolor="#ACC2E9"></td>
                        </tr>
                      <tr bgcolor="#F3F4F6">
                     <!--   <td width="5%" height="20" align="center" valign="bottom" bgcolor="#F3F4F6"><input type="checkbox" name="checkbox" value="checkbox" /></td>
                        
                        <td width="5%" align="center" valign="bottom"><img src="images/usercenterNEW_icon17.gif" width="14" height="10" vspace="4" /></td>
                       -->
                        <td width="21%" align="center" valign="bottom">事项名称</td>
                       
                        <td width="9%" align="center" valign="bottom">当前状态</td>
                       
                        <td width="13%" align="center" valign="bottom">办事部门</td>
                       
                        <td width="9%" align="center" valign="bottom">状&nbsp;&nbsp;态</td>
                      
                        <td width="12%" align="center" valign="bottom" bgcolor="#F3F4F6">收到时间</td>
						 
                        <td width="12%" align="center" valign="bottom" bgcolor="#F3F4F6">办结时间</td>
						
                        <td width="15%" align="center" valign="bottom" bgcolor="#F3F4F6">时&nbsp;&nbsp;限</td>
                      </tr>
                      <tr>
                        <td height="1" colspan="25" bgcolor="#ACC2E9"></td>
                      </tr>
                    </table></td>
                  </tr>
                  <tr>
                    <td valign="top"><table width="100%" border="0" cellspacing="0" cellpadding="0">

	 <%
													if(!us_id.equals(null))
													{


														sqlStr = "select a.*,b.pr_timelimit, b.pr_url from tb_work a,tb_proceeding b where a.us_id='"+us_id+"' and a.wo_status in('3','4') and a.pr_id=b.pr_id order by a.wo_applytime desc";
														
														//add by yanker 用于剥离外事办数据库-------start-------------20080918-------------
														CDataCn dCnWsb = new CDataCn("wsb");
														CDataImpl dImplWsb = new CDataImpl(dCnWsb);
														//add by yanker 用于剥离外事办数据库-------end---------------20080918-------------

														Vector l_vPage = l_dImpl.splitPage(sqlStr,request,6);
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
																pr_url = l_content.get("pr_url").toString();
																wo_status = l_content.get("wo_status").toString();
																
																Hashtable owIdHashtable = dImplWsb.getDataInfo("SELECT OW_ID FROM TB_ONLINEWORK WHERE WO_ID = '"+ wo_id+"'");
																
																String ow_id = "";
																if(owIdHashtable != null)
																	ow_id = owIdHashtable.get("ow_id").toString();
																 %>

                      <tr>
                     <!--   <td width="5%" height="22" align="center" valign="middle"><input type="checkbox" name="checkbox2" value="checkbox" /></td>
						
                        <td width="5%" align="center" valign="middle"><img src="images/usercenterNEW_icon17.gif" width="14" height="12" /></td>
                      -->
                        <td width="21%" align="center" valign="middle">
						<%
															if(pr_url.equals("")){
														%>
														  <a title="<%=pr_name%>" href="/website/workHall/apply.jsp?pr_id=<%=pr_id%>&ow_id=<%=ow_id%>&wo_status=<%=wo_status%>&wo_id=<%=wo_id%>&asd=<%=CBase64.getEncodeString(us_uid)%>&rfv=<%=CBase64.getEncodeString(user.getPwd())%>"  target="_blank"><%if(pr_name.length()>8) out.print("&nbsp;"+pr_name.substring(0,8)+"...");else out.print("&nbsp;"+pr_name);%></a></td>
														<%
															} else {
																Hashtable owContent = l_dImpl.getDataInfo("select owt1_id from tb_onlineworkxmltype where pr_id='" + pr_id + "'");
																String owt1_id = "";
																if(owContent != null){
																	owt1_id = owContent.get("owt1_id").toString();
																}
																if(pr_url.indexOf("?") == -1){
														%>
														  <a title="<%=pr_name%>" href="<%=pr_url%>?pr_id=<%=pr_id%>&ow_id=<%=ow_id%>&wo_status=<%=wo_status%>&wo_id=<%=wo_id%>&owt1_id=<%=owt1_id%>&asd=<%=CBase64.getEncodeString(us_uid)%>&rfv=<%=CBase64.getEncodeString(user.getPwd())%>" target="_blank"><%if(pr_name.length()>16) out.print("&nbsp;"+pr_name.substring(0,16)+"...");else out.print("&nbsp;"+pr_name);%></a></td>
														<%
																} else {
														%>
														  <a title="<%=pr_name%>" href="<%=pr_url%>&pr_id=<%=pr_id%>&ow_id=<%=ow_id%>&wo_status=<%=wo_status%>&wo_id=<%=wo_id%>&owt1_id=<%=owt1_id%>&asd=<%=CBase64.getEncodeString(us_uid)%>&rfv=<%=CBase64.getEncodeString(user.getPwd())%>" target="_blank"><%if(pr_name.length()>16) out.print("&nbsp;"+pr_name.substring(0,16)+"...");else out.print("&nbsp;"+pr_name);%></a></td>
														<%
																}
															}
														%>
						 
                        <td width="9%" align="center" valign="middle"><%
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
														%></td>
						<td width="46%" colspan="4">
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
                       
                        <td width="15%" align="center" valign="middle"><font color="red"><%=timeLimit%></font>个工作日<br>
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
															</div></td>
                      </tr>
                      <tr>
                        <td height="3" colspan="20" background="images/usercenterNEW_line04.gif"></td>
                        </tr>


                 
                  				 <%
                      		}
                      	}
			else
															{
																out.print("<tr class='line-even'><td valign='top' colspan='20'><font color='#FF0000'>&nbsp;&nbsp;没有符合条件的内容！</font></td></tr>");
															}
                      }
												out.print("<tr><td bgcolor='#FFFFFF' colspan=20>"+l_dImpl.getTail(request)+"</td></tr>");
                      %>
											</table>

										<!-- 结束 -->
									
				

</td></tr>
                </table></td>
              </tr>

            </table>

</body>
<%
l_dImpl_1.closeStmt();
n_dImpl.closeStmt();
m_dImpl.closeStmt();
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