<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="../skin/pophead.jsp"%>
<%@page import="com.component.database.*"%>
<%@page import="com.app.*"%>
<%

CMySelf self = (CMySelf)session.getAttribute("mySelf");
String dt_id="";
dt_id = String.valueOf(self.getDtId());

String overtitle="";
String overtitle1="";
String optype="";
String pr_id="";
String wo_id="";
String wo_projectname="";
String wo_status="";
String wo_sparehour="";
String wo_contactpeople="";
String wo_isovertime="";
String wo_applypeople="";
String wo_tel="";
String wo_postcode="";
String wo_applytime="";
String wo_finishtime="";
String wo_address="";
String co_id="";
String de_sparehour="";
String send="";
String receive="";
wo_id = CTools.dealString(request.getParameter("wo_id")).trim();

//update20080122

CDataCn dCn=null;   //新建数据库连接对象
CDataImpl dImpl=null;  //新建数据接口对象

try {
 dCn = new CDataCn(); 
 dImpl = new CDataImpl(dCn); 


String sqlPro = " select pr_id,wo_projectname,wo_status,wo_address,wo_sparehour,wo_isovertime,wo_contactpeople,wo_applypeople,wo_tel,wo_postcode,to_char(wo_applytime,'yyyy-mm-dd hh24:mi:ss') wo_applytime,to_char(wo_finishtime,'yyyy-mm-dd hh24:mi:ss') wo_finishtime ";
sqlPro += " from tb_work where wo_id='"+wo_id+"' ";

String sqlCorr = " select z.de_isovertime,z.de_sparehour,z.de_status,u.dt_name senddept,v.dt_name receivedept,x.wo_id,x.wo_projectname,s.ui_name,to_char(z.de_sendtime,'yyyy-mm-dd hh24:mi:ss') de_sendtime,to_char(z.de_signtime,'yyyy-mm-dd hh24:mi:ss') de_signtime,to_char(z.de_feedbacktime,'yyyy-mm-dd hh24:mi:ss') de_feedbacktime,to_char(z.de_feedbacksigntime,'yyyy-mm-dd hh24:mi:ss') de_feedbacksigntime,s.ui_name, ";
sqlCorr += " y.co_id,z.de_id,z.de_senddeptid from tb_work x,tb_correspond y,tb_documentexchange z,tb_deptinfo u,tb_deptinfo v,tb_userinfo s ";
sqlCorr += " where x.wo_id='"+wo_id+"' and x.wo_id=y.wo_id and y.co_id=z.de_primaryid and z.de_senddeptid=u.dt_id and z.de_receiverdeptid=v.dt_id and z.de_type='1' and z.de_senderid=s.ui_id ";

//out.println(sqlCorr);out.close();
String sqlUrgent= " select x.wo_id,y.ur_dtname,y.ur_id,y.ur_content,u.dt_name senddept,z.de_sparehour,z.de_isovertime,z.de_status,z.de_id,z.de_senddeptid,v.dt_name receivedept,to_char(z.de_sendtime,'yyyy-mm-dd hh24:mi:ss') de_sendtime,to_char(z.de_signtime,'yyyy-mm-dd hh24:mi:ss') de_signtime ";
sqlUrgent += " from tb_work x,tb_urgent y,tb_documentexchange z,tb_deptinfo u,tb_deptinfo v ";
sqlUrgent += " where x.wo_id='"+wo_id+"' and x.wo_id=y.ur_foreignid and y.ur_type='2' and y.ur_id=z.de_primaryid and z.de_type='2' and z.de_senddeptid=u.dt_id and z.de_receiverdeptid=v.dt_id ";
sqlUrgent += " order by de_signtime desc,de_sendtime desc ";
//out.println(sqlUrgent); out.close();
String sqlSupervise = " select y.wo_id,x.sv_dtname,x.sv_id,x.sv_content,z.de_sparehour,z.de_status,z.de_isovertime,z.de_id,u.dt_name senddept,v.dt_name receivedept,z.de_senddeptid,to_char(z.de_sendtime,'yyyy-mm-dd hh24:mi:ss') de_sendtime,to_char(z.de_signtime,'yyyy-mm-dd hh24:mi:ss') de_signtime,to_char(z.de_feedbacktime,'yyyy-mm-dd hh24:mi:ss') de_feedbacktime,to_char(z.de_feedbacksigntime,'yyyy-mm-dd hh24:mi:ss') de_feedbacksigntime ";
sqlSupervise += " from tb_supervise x,tb_work y,tb_documentexchange z,tb_deptinfo u,tb_deptinfo v ";
sqlSupervise += " where y.wo_id='"+wo_id+"' and x.sv_foreignid=y.wo_id and x.sv_id=z.de_primaryid and z.de_type='4' and x.sv_type='4'and z.de_senddeptid=u.dt_id and z.de_receiverdeptid=v.dt_id ";
//out.println(sqlSupervise);out.close();


Hashtable content = dImpl.getDataInfo(sqlPro);
wo_projectname=content.get("wo_projectname").toString();
wo_status=content.get("wo_status").toString();
wo_sparehour=content.get("wo_sparehour").toString();
wo_contactpeople=content.get("wo_contactpeople").toString();
wo_isovertime=content.get("wo_isovertime").toString();
wo_applypeople=content.get("wo_applypeople").toString();
wo_tel=content.get("wo_tel").toString();
wo_postcode=content.get("wo_postcode").toString();
wo_applytime=content.get("wo_applytime").toString();
wo_finishtime=content.get("wo_finishtime").toString();
wo_address=content.get("wo_address").toString();

%>
<table width="100%" class="main-table">
<form name="formData">
<tr>
<td width="100%">
<table class="title1" width="100%">
   <tr width="100%">
		<td width="100%" colspan="13" align="center">
		<font size=2><b>项目监控中心</b></font>
		</td>
		<td valign="top" align="right" nowrap>
			<img src="/system/images/split.gif" align="middle" border="0">
			<img border="0" align="middle" src="/system/images/menu_refresh.gif" class="hand" title="页面刷新" onclick="location.reload();" WIDTH="16" HEIGHT="16">
			<img src="/system/images/split.gif" align="middle" border="0">
			<img src="/system/images/dialog/return.gif" border="0" onclick="history.go(-1)" title="返回" style="cursor:hand" align="absmiddle" id="image3" name="image3" WIDTH="14" HEIGHT="14">
			<img src="/system/images/split.gif" align="middle" border="0">
			<img border="0" align="middle" src="/system/images/dialog/close.gif" class="hand" title="窗口关闭" onclick="window.close();" WIDTH="16" HEIGHT="16">
			<img src="/system/images/split.gif" align="middle" border="0">
		</td>
   </tr>
</table>

<table class="content-table" width="100%" cellspacing="0">
		<tr class="line-odd" width="100%">
			<td width="100%"  align="left" colspan="13">
			<a onclick="javascript:Display(1)" style="cursor:hand"><img border="0" src="/system/images/topminus.gif" WIDTH="16" HEIGHT="16" id="InfoImg1"></a>
			项目基本情况
			&nbsp;&nbsp;
			</td>


					<!--<td width="10%" align="left" style="cursor:hand" onclick="openwindow(2)">
					<font color="blue">催办</font></td>
					<td width="30%" colspan="10" align="left" style="cursor:hand">
					<font color="blue">督办</font></td>-->
	  </tr>

		<tr class="line-even" id="Info1" style="display:''">
                <td align="left" height="20">
                  <table cellspacing="1" border="0" bgcolor="#ffffff" width="100%">
					   <tr class="line-even">
							<td align="right" width="18%">项目名称：</td>
							<td><%=wo_projectname%></td>
					   </tr>
					   <tr class="line-odd">
							<td align="right" width="18%">申请人：</td>
							<td> <%=wo_applypeople%></td>
					   </tr>
						<tr class="line-even">
							<td align="right" width="18%">联系人：</td>
							<td><%=wo_contactpeople%></td>
					   </tr>
					   <tr class="line-odd">
							<td align="right" width="18%">电话：</td>
							<td><%=wo_tel%></td>
					   </tr>
						<tr class="line-even">
							<td align="right" width="18%">地址：</td>
							<td><%=wo_address%></td>
					   </tr>
					   <tr class="line-odd">
							<td align="right" width="18%">邮政编码：</td>
							<td><%=wo_postcode%></td>
					   </tr>
					   <tr class="line-even">
							<td align="right" width="18%">申请时间：</td>
							<td><%=wo_applytime%></td>
					   </tr>
					   <tr class="line-odd">
							<td align="right" width="18%">结束时间：</td>
							<td><%=wo_finishtime%></td>
					   </tr>
					   <tr class="line-even">
							<td align="right" width="18%">状态：</td>
							<td><%
							if(wo_status.equals("0"))
							{
								out.println("暂存");
							}
							if(wo_status.equals("1"))
							{
								out.println("进行中");
							}
							if(wo_status.equals("2"))
							{
								out.println("待补件");
							}
							if(wo_status.equals("3"))
							{
								out.println("已通过");
							}
							if(wo_status.equals("4"))
							{
								out.println("未通过");
							}
							if(wo_status.equals("8"))
							{
								out.println("协同中");
							}

							%></td>
					   </tr>
					   <tr class="line-odd">
							<td align="right" width="18%">剩余小时：</td>
							<td><%=wo_sparehour%></td>
					   </tr>
					   <tr class="line-even">
							<td align="right" width="18%">是否超时：</td>
							<td><%
							if(wo_isovertime.equals("1"))
							{
								out.println("超时");
							}
							if(wo_isovertime.equals("0"))
							{
								out.println("未超时");
							}

							%></td>
					   </tr>
					   <tr class="line-even">
							<td align="left" colspan="2" width="18%" onclick="openwork()" style="cursor:hand">>>>查看项目详细信息</td>
					   </tr>
				   </table>
				   </td>
				   </tr>
				 <tr class="line-odd" width="100%">
                 <td width="100%" align="left" colspan="13">
                        <a onclick="javascript:Display(2)" style="cursor:hand"><img border="0" src="/system/images/topminus.gif" WIDTH="16" HEIGHT="16" id="InfoImg2"></a>
                    协调单情况</td>
	             </tr>
				 <tr class="line-even" id="Info2" style="display:">
                <td align="left" height="20" colspan="13">
                  <table cellspacing="1" border="0" bgcolor="#ffffff" width="100%">
				<tr class="bttn">
				<td width="2%" class="outset-table" align="center"><div title="红色表示超时,绿色表示不超时,黄色表示即将超时">●</div></td>
				<td width="8%" class="outset-table" align="center">状态</td>
				<td width="10%" class="outset-table" align="center">发送部门</td>
				<td width="10%" class="outset-table" align="center">接收部门</td>
				<td width="10%" class="outset-table" align="center">发送人</td>
				<td width="10%" class="outset-table" align="center">发送时间</td>
				<td width="10%" class="outset-table" align="center">签收时间</td>
				<td width="10%" class="outset-table" align="center">反馈时间</td>
				<td width="10%" class="outset-table" align="center">反馈签收时间</td>
				<td width="10%" class="outset-table" align="center">协调单查看</td>
				</tr>
				<%
			Vector vectorCorr=dImpl.splitPage(sqlCorr,request,20);
			if(vectorCorr!=null)
			{
				for(int i=0;i<vectorCorr.size();i++)
				{
					Hashtable contCorr = (Hashtable)vectorCorr.get(i);
					String senddept=contCorr.get("senddept").toString();
					String receivedept=contCorr.get("receivedept").toString();
					de_sparehour = contCorr.get("de_sparehour").toString();
					if(i%2==0) out.println("<tr class=\"line-even\">");
					else out.print("<tr class=\"line-odd\">");
			%>
			 <td align="center">
			 <%
			if(contCorr.get("de_isovertime").toString().equals("")||contCorr.get("de_isovertime").toString().equals("0"))
			{
				overtitle = "未超时,还剩"+de_sparehour+"小时";

			%>
				<div align="center" title=<%=overtitle%>><font color="green">●</font></div>
			<%
			}
			else if(!de_sparehour.equals(""))
			{
					overtitle="已超时"+de_sparehour.substring(1,de_sparehour.length())+"小时";
			%>
				<div align="center" title=<%=overtitle%>><font color="red">●</font></div>
			<%
				}
			else 	{
				overtitle="已超时";

			%>
				<div align="center" title=<%=overtitle%>><font color="red">●</font></div>
				<%}%>
			</td>
			 <td align="center">
			 <%
				if(contCorr.get("de_status").toString().equals("1"))
				{
				out.println("发送");
				send=senddept;
				receive=receivedept;
				}
				else if(contCorr.get("de_status").toString().equals("2"))
				{
					out.println("发送签收");
					send=senddept;
					receive=receivedept;
				}
				else if(contCorr.get("de_status").toString().equals("4"))
				{
					out.println("反馈发送");
					send=receivedept;
					receive=senddept;
				}
				else
					{
					out.println("反馈签收");
					send=receivedept;
					receive=senddept;
					}
				%>
			 </td>
		     <td align="center"><%=send%></td>
			<td align="center"><%=receive%></td>
		     <td align="center"><%=contCorr.get("ui_name").toString()%></td>
			 <td align="center">
			<%=contCorr.get("de_sendtime").toString()%>
			 </td>
			 <td align="center">
			<%=contCorr.get("de_signtime").toString()%>
			 </td>
			 <td align="center">
			<%=contCorr.get("de_feedbacktime").toString()%>
			 </td>
			 <td align="center">
			 <%=contCorr.get("de_feedbacksigntime").toString()%>
			</td>
			<td onclick="openwindows(1,'<%=contCorr.get("co_id")%>','See');" align="center" style="cursor:hand">查看</td>
			</tr>

			<%
				co_id = contCorr.get("co_id").toString();
				String sqlCorrUrgent= " select x.ur_foreignid,x.ur_dtname,x.ur_content,x.ur_id,u.dt_name senddept,y.de_sparehour,y.de_status,y.de_isovertime,y.de_id,y.de_senddeptid,v.dt_name receivedept,to_char(y.de_sendtime,'yyyy-mm-dd hh24:mi:ss') de_sendtime,to_char(y.de_signtime,'yyyy-mm-dd hh24:mi:ss') de_signtime ";
				sqlCorrUrgent += " from tb_urgent x,tb_documentexchange y,tb_correspond z,tb_deptinfo u,tb_deptinfo v ";
				sqlCorrUrgent += " where x.ur_foreignid=z.co_id and x.ur_id=y.de_primaryid and z.co_id='"+co_id+"' and x.ur_type='3' and y.de_senddeptid=u.dt_id and y.de_receiverdeptid=v.dt_id and y.de_type='3' ";
				//out.println(sqlCorrUrgent);out.close();
				Vector vectorCorrUrgent=dImpl.splitPage(sqlCorrUrgent,1000,1);
				if(vectorCorrUrgent!=null)
				{
					if(i%2==0) out.println("<tr class=\"line-even\">");
					else out.print("<tr class=\"line-odd\">");
			%>
					<td width="100%" align="left" colspan="13">
                        <a onclick="javascript:Display(<%=i+5%>)" style="cursor:hand">
						<img border="0" src="/system/images/topplus.gif" WIDTH="16" HEIGHT="16" id="InfoImg<%=i+5%>">
						</a>
						协调单催办情况
					</td>
				</tr>
				<tr class="line-even" id='Info<%=i+5%>' style='display:none'>
			            <td align="left" height="20" colspan="13">
						<table cellspacing="1" border="0" bgcolor="#ffffff" width="100%">
							<tr class="bttn">
								<td width="2%" class="outset-table" align="center"><div title="红色表示超时,绿色表示不超时,黄色表示即将超时">●</div></td>
								<td width="8%" class="outset-table" align="center">状态</td>
								<td width="10%" class="outset-table" align="center">催办对象</td>
								<td width="20%" class="outset-table" align="center">催办内容</td>
								<td width="10%" class="outset-table" align="center">发送部门</td>
								<td width="10%" class="outset-table" align="center">接收部门</td>
								<td width="10%" class="outset-table" align="center">催办时间</td>
								<td width="10%" class="outset-table" align="center">签收时间</td>
								<td width="10%" class="outset-table" align="center">催办单查看</td>
							</tr>
							<%

								for(int j=0;j<vectorCorrUrgent.size();j++)
								{
									Hashtable contCorrUrgent = (Hashtable)vectorCorrUrgent.get(j);
									de_sparehour=contCorrUrgent.get("de_sparehour").toString();
									if(i%2==0) out.println("<tr class=\"line-even\">");
									else out.print("<tr class=\"line-odd\">");
							%>
							 <td align="center">
							 <%
								if(!contCorrUrgent.get("de_isovertime").toString().equals(""))
									{
										overtitle="未超时,还剩"+de_sparehour+"小时";
										out.println("<center><span style=color:green title='"+overtitle+"'>●</span></center>");
									}
								else if(!de_sparehour.equals(""))
									{
										overtitle="已超时"+de_sparehour.substring(1,de_sparehour.length())+"小时";
										out.println("<center><span style=color:red title='"+overtitle+"'>●</span></center>");
									}
									else
									{
										overtitle="已超时";
										out.println("<center><span style=color:red title='"+overtitle+"'>●</span></center>");
									}
							%>
							</td>
							<td align="center">
							  <%
								if(contCorrUrgent.get("de_status").toString().equals("1"))
									{
										out.println("发送");
									}
									else
									{
										out.println("签收");
									}
							%>
							</td>
					 		     <td align="center"><%=contCorrUrgent.get("ur_dtname").toString()%></td>
 								 <td align="center"><%=contCorrUrgent.get("ur_content").toString()%></td>
							     <td align="center"><%=contCorrUrgent.get("senddept").toString()%></td>
								 <td align="center"><%=contCorrUrgent.get("receivedept").toString()%></td>
							     <td align="center"><%=contCorrUrgent.get("de_sendtime").toString()%></td>
							     <td align="center"><%=contCorrUrgent.get("de_signtime").toString()%></td>
								 <td onclick="openwindows(2,'<%=contCorrUrgent.get("ur_id").toString()%>','View');" align="center" style="cursor:hand">查看</td>
								 </tr>

							<%
								}

								%>
						</table>
						</td>
				</tr>
			  <%
				}

				co_id = contCorr.get("co_id").toString();
				String sqlCorrSV= " select x.sv_foreignid,x.sv_dtname,x.sv_content,x.sv_id,u.dt_name senddept,y.de_status,y.de_isovertime,y.de_id,y.de_senddeptid,v.dt_name receivedept,to_char(y.de_sendtime,'yyyy-mm-dd hh24:mi:ss') de_sendtime,to_char(y.de_signtime,'yyyy-mm-dd hh24:mi:ss') de_signtime,to_char(y.de_feedbacktime,'yyyy-mm-dd hh24:mi:ss') de_feedbacktime,to_char(y.de_feedbacksigntime,'yyyy-mm-dd hh24:mi:ss') de_feedbacksigntime ";
				sqlCorrSV += " from tb_supervise x,tb_documentexchange y,tb_correspond z,tb_deptinfo u,tb_deptinfo v ";
				sqlCorrSV += " where x.sv_foreignid=z.co_id and z.co_id='"+co_id+"' and x.sv_type='5' and y.de_senddeptid=u.dt_id and y.de_receiverdeptid=v.dt_id and y.de_type='5' and y.de_primaryid=x.sv_id ";
				//out.println(sqlCorrSV);
				Vector vectorCorrSV=dImpl.splitPage(sqlCorrSV,request,20);
				if(vectorCorrSV!=null)
				{
					if(i%2==0) out.println("<tr class=\"line-even\">");
					else out.print("<tr class=\"line-odd\">");
			%>
					<td width="100%" align="left" colspan="13">
                        <a onclick="javascript:Display(<%=i+100%>)" style="cursor:hand">
						<img border="0" src="/system/images/topplus.gif" WIDTH="16" HEIGHT="16" id="InfoImg<%=i+100%>">
						</a>
						协调单督办情况
					</td>
				</tr>

				<tr class="line-odd" id='Info<%=i+100%>' style='display:none'>
			            <td align="left" height="20" colspan="13">
						<table cellspacing="1" border="0" bgcolor="#ffffff" width="100%">
							<tr class="bttn">
								<td width="2%" class="outset-table" align="center"><div title="红色表示超时,绿色表示不超时,黄色表示即将超时">●</div></td>
								<td width="8%" class="outset-table" align="center">状态</td>
								<td width="10%" class="outset-table" align="center">督办对象</td>
								<td width="10%" class="outset-table" align="center">督办内容</td>
								<td width="10%" class="outset-table" align="center">发送部门</td>
								<td width="10%" class="outset-table" align="center">接收部门</td>
								<td width="10%" class="outset-table" align="center">督办时间</td>
								<td width="10%" class="outset-table" align="center">签收时间</td>
								<td width="10%" class="outset-table" align="center">反馈时间</td>
								<td width="10%" class="outset-table" align="center">反馈签收时间</td>
								<td width="10%" class="outset-table" align="center">督办单查看</td>
							</tr>
							<%
								for(int k=0;k<vectorCorrSV.size();k++)
								{
									Hashtable contCorrSV = (Hashtable)vectorCorrSV.get(k);
									if(i%2==0) out.println("<tr class=\"line-even\">");
									else out.print("<tr class=\"line-odd\">");
							%>
							<td align="center">
								<%
								if(contCorrSV.get("de_isovertime").toString().equals("1"))
									{
										out.println("<center><span style=color:red>●</span></center>");
									}
									else
									{
										out.println("<center><span style=color:green>●</span></center>");
									}
							%>
							</td>
							  <td align="center">
							  <%
								if(contCorrSV.get("de_status").toString().equals("1"))
									{
										out.println("发送");
									}

									if(contCorrSV.get("de_status").toString().equals("2"))
									{
										out.println("签收");
									}
									if(contCorrSV.get("de_status").toString().equals("4"))
									{
										out.println("反馈发送");
									}
									if(contCorrSV.get("de_status").toString().equals("5"))
									{
										out.println("反馈签收");
									}
							%>
							</td>
					 		     <td align="center"><%=contCorrSV.get("sv_dtname").toString()%><%=contCorrSV.get("sv_id").toString()%></td>
 								 <td align="center"><%=contCorrSV.get("sv_content").toString()%></td>
							     <td align="center"><%=contCorrSV.get("senddept").toString()%></td>
								 <td align="center"><%=contCorrSV.get("receivedept").toString()%></td>
							     <td align="center"><%=contCorrSV.get("de_sendtime").toString()%></td>
							     <td align="center"><%=contCorrSV.get("de_signtime").toString()%></td>
								<td align="center"><%=contCorrSV.get("de_feedbacktime").toString()%></td>
								<td align="center"><%=contCorrSV.get("de_feedbacksigntime").toString()%></td>
								 <td onclick="openwindows(3,'<%=contCorrSV.get("sv_id")%>','View');" align="center" style="cursor:hand">查看</td>
								 </tr>

							<%
								}

								%>
					</table>
					</td>
				</tr>
			  <%
				}

			}

		}
				 else
				{
				out.println("<tr><td colspan=10>没有记录！</td></tr>");
				}

				%>
			</table>
		</td>
	</tr>


				<tr class="line-odd">
                 <td width="100%" align="left" colspan="13">
                        <a onclick="javascript:Display(3)" style="cursor:hand">
						<img border="0" src="/system/images/topplus.gif" WIDTH="16" HEIGHT="16" id="InfoImg3"></a>
                    项目催办情况</td>
	             </tr>
				<tr class="line-even" id="Info3" style="display:none">
                <td align="left" height="20" colspan="13">
                  <table cellspacing="1" border="0" bgcolor="#ffffff" width="100%">
				<tr class="bttn">
				<td width="2%" class="outset-table" align="center"><div title="红色表示超时,绿色表示不超时,黄色表示即将超时">●</div></td>
				<td width="8%" class="outset-table" align="center">状态</td>
				<td width="10%" class="outset-table" align="center">催办对象</td>
				<td width="20%" class="outset-table" align="center">催办内容</td>
				<td width="10%" class="outset-table" align="center">发送部门</td>
				<td width="10%" class="outset-table" align="center">接收部门</td>
				<td width="10%" class="outset-table" align="center">催办时间</td>
				<td width="10%" class="outset-table" align="center">签收时间</td>
				<td width="5%" class="outset-table" align="center">查看</td>
				</tr>
				<%
			Vector vectorUrgent=dImpl.splitPage(sqlUrgent,request,20);

			if(vectorUrgent!=null)
			{
				for(int i=0;i<vectorUrgent.size();i++)
				{
					Hashtable contUrgent = (Hashtable)vectorUrgent.get(i);
					de_sparehour = contUrgent.get("de_sparehour").toString();
					if(i%2==0) out.println("<tr class=\"line-even\">");
					else out.print("<tr class=\"line-odd\">");
			%>
			<td align="center">
			 <%
			if(!contUrgent.get("de_isovertime").toString().equals("1"))
				{
					overtitle="未超时,还剩"+de_sparehour+"小时";
			%>
				<div align="center" title=<%=overtitle%>><font color="green">●</font></div>
			<%
			}
			else if(!de_sparehour.equals(""))
			{
					overtitle="已超时"+de_sparehour.substring(1,de_sparehour.length())+"小时";
			%>
				<div align="center" title=<%=overtitle%>><font color="red">●</font></div>
			<%
			}
			else
					{
				overtitle="已超时";
			%>
				<div align="center" title=<%=overtitle%>><font color="red">●</font></div>
				<%}%>
			</td>
			 <td align="center">
			 <%
				if(contUrgent.get("de_status").toString().equals("1"))
					{
					out.println("发送");
					}
					else
					{
						out.println("签收");
					}
			%></td>
		     <td align="center"><%=contUrgent.get("ur_dtname").toString()%></td>
 		     <td align="center"><%=contUrgent.get("ur_content").toString()%></td>
		     <td align="center"><%=contUrgent.get("senddept").toString()%></td>
			 <td align="center"><%=contUrgent.get("receivedept").toString()%></td>
		     <td align="center"><%=contUrgent.get("de_sendtime").toString()%></td>
		     <td align="center"><%=contUrgent.get("de_signtime").toString()%></td>
			<td onclick="openwindows(4,'<%=contUrgent.get("ur_id")%>','View');" align="center" style="cursor:hand">查看</td>
			</tr>
			<%
				}
			}
			else
			{
		    out.println("<tr><td colspan=10>没有记录！</td></tr>");
			}
			%>
			</table>
			</td>
			</tr>
			 <tr class="line-odd" width="100%">
                 <td width="100%" align="left" colspan="13">
                        <a onclick="javascript:Display(4)" style="cursor:hand"><img border="0" src="/system/images/topplus.gif" WIDTH="16" HEIGHT="16" id="InfoImg4"></a>
                    项目督办情况</td>
	         </tr>
			<tr class="line-even" id="Info4" style="display:none">
             <td align="left" height="20" colspan="13">
             <table cellspacing="1" border="0" bgcolor="#ffffff" width="100%">
				<tr class="bttn">
				<td width="2%" class="outset-table" align="center"><div title="红色表示超时,绿色表示不超时,黄色表示即将超时">●</div></td>
				<td width="8%" class="outset-table" align="center">状态</td>
				<td width="10%" class="outset-table" align="center">被督办部门</td>
				<td width="15%" class="outset-table" align="center">督办内容</td>
				<td width="10%" class="outset-table" align="center">发送部门</td>
				<td width="10%" class="outset-table" align="center">接收部门</td>
				<td width="10%" class="outset-table" align="center">催办时间</td>
				<td width="10%" class="outset-table" align="center">签收时间</td>
				<td width="8%" class="outset-table" align="center">反馈时间</td>
				<td width="12%" class="outset-table" align="center">反馈签收时间</td>
				<td width="5%" class="outset-table" align="center">查看</td>
				</tr>
				<%
			Vector vectorSupervise=dImpl.splitPage(sqlSupervise,request,20);
			if(vectorSupervise!=null)
			{
				for(int i=0;i<vectorSupervise.size();i++)
				{
					Hashtable contSupervise = (Hashtable)vectorSupervise.get(i);
					de_sparehour=contSupervise.get("de_sparehour").toString();
					if(i%2==0) out.println("<tr class=\"line-even\">");
					else out.print("<tr class=\"line-odd\">");
			%>
			 <td align="center">
			 <%
				if(!contSupervise.get("de_isovertime").toString().equals("1"))
					{
					overtitle="未超时,还剩"+de_sparehour+"小时";
			%>
				<div align="center" title="<%=overtitle%>"><font color="green">●</font></div>
			<%
					}
				else if(!de_sparehour.equals(""))
					{
					overtitle="已超时"+de_sparehour.substring(1,de_sparehour.length())+"小时";
			%>
				<div align="center" title=<%=overtitle%>><font color="red">●</font></div>
			<%
						}
			%>
			</td>
			<td align="center">
			<%
			if(contSupervise.get("de_status").toString().equals("1"))
									{
										out.println("发送");
									}
			if(contSupervise.get("de_status").toString().equals("2"))
									{
										out.println("签收");
									}
			if(contSupervise.get("de_status").toString().equals("4"))
									{
										out.println("反馈发送");
									}
			if(contSupervise.get("de_status").toString().equals("5"))
									{
										out.println("反馈签收");
									}
			%>
			</td>
			<td align="center"><%=contSupervise.get("sv_dtname").toString()%></td>
 		     <td align="center"><%=contSupervise.get("sv_content").toString()%></td>
		     <td align="center"><%=contSupervise.get("senddept").toString()%></td>
			<td align="center"><%=contSupervise.get("receivedept").toString()%></td>
		     <td align="center"><%=contSupervise.get("de_sendtime").toString()%></td>
		     <td align="center"><%=contSupervise.get("de_signtime").toString()%></td>
 		     <td align="center"><%=contSupervise.get("de_feedbacktime").toString()%></td>
			  <td align="center"><%=contSupervise.get("de_feedbacksigntime").toString()%></td>
			<td onclick="openwindows(5,'<%=contSupervise.get("sv_id")%>','View');" align="center" style="cursor:hand">查看</td>
			</tr>
			<%
				}
			 }
			 else
			{
		    out.println("<tr><td colspan=10>没有记录！</td></tr>");
			  }
			%>
         </table>
         </td>
         </tr>
	</table>
</td>
</tr>
</form>
</table>
<script>
 function Display(Num)
  {
        var obj=eval("Info"+Num);
        var objImg=eval("document.formData.InfoImg"+Num);

        if (typeof(obj)=="undefined") return false;
        if (obj.style.display=="none")
        {
                obj.style.display="";
                objImg.src="/system/images/topminus.gif";
        }
        else
        {
                obj.style.display="none";
                objImg.src="/system/images/topplus.gif";
        }
  }

function openwork()
{
	var w=750;
	var h=420;
	var url="/system/app/new_dealwork/WorkDetail.jsp?wo_id=<%=wo_id%>";
	window.open(url,"项目详细信息","top=100px,left=100px,width="+w+",height="+h+",toolbar=no,location=no,derectories=no,status=no,menubar=no,resizable=yes,scrollbars=yes");

}
  function openwindows(operate,x,optype)
  {

	if(operate==1)
	  {
		var w=750;
		var h=420;
		var url="/system/app/cooperate/CorrForm.jsp?OPType="+optype+"&co_id="+x;
	  }
	  if(operate==2)
	  {
		var w=450;
		var h=250;
		var url="/system/app/supervise/UrgentCoList.jsp?OPType="+optype+"&ur_id="+x;
	  }
	if(operate==3)
	  {
		var w=600;
		var h=300;
		var url="/system/app/supervise/FeedbackCoInfo.jsp?OPType="+optype+"&sv_id="+x;
	  }

	if(operate==4)
	  {
		var w=450;
		var h=250;
		var url="/system/app/supervise/Urgentlist.jsp?OPType="+optype+"&ur_id="+x;
	  }
	if(operate==5)
	  {
		var w=600;
		var h=300;
		var url="/system/app/supervise/FeedbackInfo.jsp?OPType="+optype+"&sv_id="+x;
	  }
		window.open(url,"需补件理由","top=100px,left=100px,width="+w+",height="+h+",toolbar=no,location=no,derectories=no,status=no,menubar=no,resizable=yes,scrollbars=no");
  }
</script>
<%
dImpl.closeStmt();
dCn.closeCn();

} catch (Exception ex) {
	System.out.println(new java.util.Date() + "--"
			+ request.getServletPath() + " : " + ex.getMessage());
} finally {
	if(dImpl != null)
	dImpl.closeStmt();
	if(dCn != null)
	dCn.closeCn();
}
%>
<%@include file="../skin/popbottom.jsp"%>
