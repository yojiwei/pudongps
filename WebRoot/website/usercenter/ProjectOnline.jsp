<%@ page contentType="text/html; charset=GBK"%>
<%@include file="/website/include/head_zw_user.jsp"%>
<script language="vbscript">
function AddAttach1()'新增附件
	dim count_obj,tr_obj,td_obj,file_obj,form_obj,count,table_obj
	dim button_obj,countview_obj
	dim str1,str2

	set form_obj=document.getElementById("formData")
	set fj_obj=document.getElementById("TdInfo1")
	if fj_obj.innertext="无附件" then
	   fj_obj.innertext=""
	end if

	set count_obj=document.getElementById("count_obj")
	if (count_obj is nothing) then
		set count_obj=document.createElement("input")
		count_obj.type="hidden"
		count_obj.id="count_obj"
		count_obj.value=1
	
		form_obj.appendChild(count_obj)
		count=1
		count_obj.value=1
	else
		set count_obj=document.getElementById("count_obj")
		count=cint(count_obj.value)+1
		count_obj.value=count
	end if

	set div_obj=document.createElement("div")
	div_obj.id="div_"&cstr(count)
	fj_obj.appendchild(div_obj)
	str1 = "<hr style='border-top-style: dotted; border-top-width: 1; border-bottom-style: dotted; border-bottom-width: 1' dotted; border-top-width: 1; border-bottom-style: dotted; border-bottom-width: 1 size=0 noshade color=#000000>"
	str1 = str1 & "附件名称："
	str1 = str1 & "<input type='file' name='fj2' size=30 class='text-line' id=fj1'>"
	str2="<br>附件说明：<input type='text' name='fjsm1'  size=30  class='text-line' maxlength=100 id='fjsm1'>"
	str3="&nbsp;<img src='/system/images/delete.gif' class=hand onclick='vbscript:delthis1("+""""+div_obj.id+""""+")' id='button1' name='button1'>"
	div_obj.innerHtml = str1 + str2 + str3
end function

'删除函数
function delthis1(id)
	dim child,parent
	set child_t=document.getElementById(id)
	if  (child_t is nothing ) then
		alert("对象为空")
	else
		call DelMain1(child_t)
	end if
	set parent=document.getElementById("TdInfo1")
	if parent.hasChildNodes() =false then
	   parent.innerText="无附件"
	end if
end function

function DelMain1(obj)
	dim length,i,tt
	set tt=document.getElementById("table_obj")
	if (obj.haschildNodes) then
		length=obj.childNodes.length
		for i=(length-1) to 0 step -1
			call DelMain1(obj.childNodes(i))
			if obj.childNodes.length=0 then
				obj.removeNode(false)
			end if
		next
	else
		obj.removeNode(false)
	end if
end function
</script>
<%
String wo_opinion = "";
String us_id = "";
String prjName = "";
String isReadOnly = "";
String wo_status = "";
String dtIdExt = ""; //对外显示的受理部门
String userName = "";//用户姓名或者企业名称 
String tel = "";//电话
String address = "";//地址
String zipcode = "";//邮政编码
String idCard = "";//身份证号码或者工商注册号
String linkMan = "";//只对企业用户,联系人 
String workName = "";//项目名称
String appertain = "";//申请人附言
String l_wo_id = "";//事项id
String sqlStr = ""; //查询的sql语句
String userKindId = "";//用户类型id
String userKindName = "";//用户类型名称
String wo_attach_path = "";//事项附件的存放地址(绝对地址)
String l_pd_projectId = CTools.dealString(request.getParameter("pr_id")).trim(); //常用办事的id
l_wo_id = CTools.dealString(request.getParameter("wo_id")).trim();
//取得当前用户的信息
User user = (User)session.getAttribute("user");
if (user!=null)
{
	us_id = user.getId();
}
//Update 20061231
CDataCn dCn = new CDataCn();
CDataImpl dImpl = new CDataImpl(dCn);

if (!us_id.equals(""))
{
	sqlStr = "select * from tb_user where us_id='"+us_id+"'";
	Hashtable l_content = dImpl.getDataInfo(sqlStr);
	if (l_content!=null)
	{
		userName = l_content.get("us_name").toString();
		tel = l_content.get("us_tel").toString();
		address = l_content.get("us_address").toString();
		zipcode = l_content.get("us_zip").toString();
		idCard = l_content.get("us_idcardnumber").toString();
	}
}

//查看或者修改项目信息时，取得项目申请人的基本信息
if(!l_wo_id.equals(""))
{
	sqlStr = "select wo_applypeople, wo_idcard,wo_contactpeople,wo_appertain,wo_projectname,wo_tel,wo_address,wo_status,wo_postcode,wo_opinion from tb_work where wo_id='"+l_wo_id+"' and us_id='"+us_id+"'";
	
	Hashtable l_content = dImpl.getDataInfo(sqlStr);
	if(l_content!=null)
	{
		userName = l_content.get("wo_applypeople").toString();
		tel = l_content.get("wo_tel").toString();
		address = l_content.get("wo_address").toString();
		zipcode = l_content.get("wo_postcode").toString();
		idCard = l_content.get("wo_idcard").toString();
		linkMan = l_content.get("wo_contactpeople").toString();
		wo_status = l_content.get("wo_status").toString();
		appertain = l_content.get("wo_appertain").toString();
		wo_opinion = l_content.get("wo_opinion").toString();
		prjName = l_content.get("wo_projectname").toString();
	}
}
if(!l_pd_projectId.equals(""))
{
	sqlStr = "select a.pr_name,b.dt_name from tb_proceeding a,tb_deptinfo b where a.pr_id='"+l_pd_projectId+"' and a.dt_idext=b.dt_id";
	Hashtable l_content = dImpl.getDataInfo(sqlStr);
	if(l_content!=null)
	{
		workName = l_content.get("pr_name").toString();
		dtIdExt = l_content.get("dt_name").toString();
	}
}


userKindId = "o1";
userKindName = "市民";
if (!l_wo_id.equals(""))
{
	sqlStr = "select distinct a.wa_path from tb_workattach a,tb_work b where a.wo_id = '"+ l_wo_id +"' and a.wo_id=b.wo_id and b.us_id='"+us_id+"'";
	Hashtable l_content = dImpl.getDataInfo(sqlStr);
	if(l_content!=null)
	{
		wo_attach_path = l_content.get("wa_path").toString();
	}
}
if (!(wo_status.equals("0")||wo_status.equals("")))
{
	isReadOnly = "readonly";
}
%>
<table width="760" border="0" align="center" cellpadding="0" cellspacing="0">
<form name="formData" method="post" enctype="multipart/form-data">
  <tr>
    <td valign="top">
		<table width="98%" border="0" align="center" cellpadding="0" cellspacing="0">
			<tr>
				<td height="17"> </td>
			</tr>
			<tr>
			  <td>
				<a href="<%=_WEBSTART%>/website/index.jsp"><font color="#ACACAC">首页</font></a><font color="#ACACAC"> >></font> <a href="/website/usercenter/List.jsp"><font color="#ACACAC">办事大厅</font></a> <font color="#ACACAC">>></font> <a href="/website/usercenter/ProjectDetail.jsp?pr_id=<%=l_pd_projectId%>"><font color="#ACACAC"><%=workName%></font></a><font color="#ACACAC"> >> </font><a href="/website/usercenter/ProjectOnline.jsp?pr_id=<%=l_pd_projectId%>"><font color="#ACACAC">在线申请</FONT></a>
			  </td>
			</tr>
			
			<tr>
			  <td valign="top">
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
				  <tr>
					<td width="185" valign="top"><%@include file="/website/include/WorkLeft.jsp"%></td>
					<td background="/website/images/left7.gif"><img src="/website/images/left7.gif" width="2" height="3"></td>
					<td valign="top">
						<table width="98%" border="0" align="center" cellpadding="0" cellspacing="0" bordercolor="#FFFFFF">
							<tr> 
								<td height="30"><img src="/website/images/new3.gif" width="543" height="21"></td>
							</tr>
							<%
							
							%>
							<tr>
								<td bordercolor="#D1D5BC" bgcolor="#F3F6ED" height="36">
									<div align="center">
										<strong><font color="#00722F"><%=workName%></font></strong>
									</div>
								</td>
							</tr>
							<tr>
								<td  background="/website/images/new12.gif" height="4"><img src="/website/images/new12.gif"></td>
							</tr>
							<tr>
								<td  background="/website/images/new12.gif">&nbsp;&nbsp;&nbsp;
									<font color="#00722F">姓名</font> 
									<input type="text" name="userName" size="10" class="text-line" <%=isReadOnly%> value="<%=userName%>">&nbsp; 
									<font color="#00722F">联系人</font>      
									<input type="text" name="linkMan" size="10" class="text-line" <%=isReadOnly%> value="<%=linkMan%>">&nbsp; 
									<font color="#00722F">电话</font>      
									<input type="text" name="tel" size="10" class="text-line" <%=isReadOnly%> value="<%=tel%>">&nbsp; 
									<font color="#00722F">邮编</font>      
									<input type="text" name="zipcode" size="10" class="text-line" <%=isReadOnly%> value="<%=zipcode%>">     
									<br><br>
									<font color="#00722F">&nbsp;&nbsp;&nbsp; 地址</font>
									<input type="text" name="address" size="64" class="text-line" <%=isReadOnly%> value="<%=address%>">&nbsp;&nbsp;
									<br><br>
									<font color="#00722F">&nbsp;&nbsp;&nbsp; 身份证号码</font> 
									<input type="text" name="idCard" size="40" class="text-line" <%=isReadOnly%> value="<%=idCard%>">&nbsp;&nbsp; 
									<font color="#00722F">（或企业注册号码      
									
									）</font>
									     
									<input type="hidden" name="workName" size="40" class="text-line"  value="<%=workName%>">&nbsp; 
									   
									<input type="hidden" name="dtIdExt" size="10" class="text-line"  value="<%=dtIdExt%>">     
								</td>
							</tr>
							<tr>
								<td height="2"  background="/website/images/new12.gif"> </td>
							</tr>
							<tr>
								<td height="2"><img src="/website/images/new15.gif" width="519" height="2"></td>
							</tr>
							<tr>
								<td background="/website/images/new14.gif" align="center">
									<table width="91%" height="60" border="0" cellpadding="0" cellspacing="0">
										<tr>
											<td colspan="9" height="2"> </td>
										</tr>
										<tr>
											<td colspan="9" align="left" valign="top">
												<font color="#00722F">上传材料</font>
											</td>
										</tr>
									<%
									sqlStr = "select pa_name,pa_id from tb_proceedingattach where pr_id='"+l_pd_projectId+"' and pa_upload='1'";
									Vector l_vPage = dImpl.splitPage(sqlStr,request,40);
									if(l_vPage!=null)
									{
										for(int i=0;i<l_vPage.size();i++)
										{
											Hashtable l_content = (Hashtable)l_vPage.get(i);
											String l_Name = l_content.get("pa_name").toString();
											String pa_id = l_content.get("pa_id").toString();
											%>
											<tr>
											<td>
												<font color="#5E5E60"><%=(i+1)%>.<input type="hidden" name="fjFlag" value="<%=l_content.get("pa_id").toString()%>">
												<a href="/website/include/download.jsp?pa_id=<%=pa_id%>" title="下载该文件"><%=l_Name%></a>
												</font>
											</td>
											<%
											if(!l_wo_id.equals(""))
											{
												sqlStr = "select a.wa_id,a.wa_filename,a.pa_name,a.pa_id from tb_workAttach a,tb_work b where a.pa_name='"+l_Name+"' and a.wo_id='"+l_wo_id+"' and a.wo_id=b.wo_id and b.us_id='"+us_id+"'";
												
												Hashtable l_content_wa = dImpl.getDataInfo(sqlStr);
												if(l_content_wa!=null)
												{
												%>
													<td><a href="/website/include/downloadWA.jsp?wa_id=<%=l_content_wa.get("wa_id").toString()%>"  title="查看已上传的文件"><%=l_content_wa.get("wa_filename").toString()%></a></td><td>
													<%
													if ((wo_status.equals("0")||wo_status.equals("")||wo_status.equals("2")))
													{
														%>
														<span style="cursor:hand" onclick="openUpdate('<%=l_content_wa.get("wa_id").toString()%>')">
														<font color="#5E5E60">更新</font></span></td>
														<%
													}
												}
												else
												{
												%>
													<td colspan="2" align="left">
														<input type="file" name="fj1" class="text-line">
														<input type="hidden" name="pa_name" value="<%=l_content.get("pa_name").toString()%>">
														<input type="hidden" name="pa_id" value="<%=l_content.get("pa_id").toString()%>">
													</td>
												<%
												}
											}
											else
											{
												%>
													<td colspan="2" align="left">
														<input type="file" name="fj1" class="text-line">
														<input type="hidden" name="pa_name" value="<%=l_content.get("pa_name").toString()%>">
														<input type="hidden" name="pa_id" value="<%=l_content.get("pa_id").toString()%>">
													</td>
												<%
											}
											%>
											</tr>
											<%
										}
									}
									else
									{
										%>
										<tr>
											<td colspan="9" align="left" valign="top">
												<font color="#00722F">&nbsp;&nbsp;&nbsp;&nbsp;没有规定上传的材料</font>
											</td>
										</tr>
										<%
									}
									%>
										<tr>
											<td id="TdInfo1" colspan="9">
											<!--在此添加上传非项目相关附件的网页代码-->
												<font color="#00722F">上传非必要材料</font>
												<%if ((wo_status.equals("0")||wo_status.equals("")||wo_status.equals("2")))
												{
												%>
												(<span onclick="AddAttach1()" style="cursor:hand"><font color="#00722F"><u>点击这里</u></font></span>)<br>
												<%
												}
												sqlStr = "select wa_id,pa_name,wa_filename from tb_workattach where wo_id='"+l_wo_id+"' and pa_id='-1'";
												l_vPage = dImpl.splitPage(sqlStr,20,1);
												if (l_vPage!=null)
												{
													for (int i=0;i<l_vPage.size();i++)
													{
														Hashtable l_content_wa = (Hashtable)l_vPage.get(i);
														%>
														<a href="/website/include/downloadWA.jsp?wa_id=<%=l_content_wa.get("wa_id").toString()%>"  title="查看已上传的文件"><%=l_content_wa.get("pa_name").toString()%></a>
														<%
														if ((wo_status.equals("0")||wo_status.equals("")||wo_status.equals("2")))
														{
															%>
															<img src="/system/images/delete.gif" style="cursor:hand" onclick="del('<%=l_content_wa.get("wa_id").toString()%>')">
															<%
														}
													}
												}
												else if (!( (wo_status.equals("0")) || (wo_status.equals("")) ))//不是暂存和新申请
												{
													out.print("<tr>");
													out.print("<td colspan=9 align=left vaign=top>");
													out.print("<font color='#00722F'>&nbsp;&nbsp;&nbsp;&nbsp;没有上传材料</font>");
													out.print("</td>");
													out.print("</tr>");
												}
												%>
											</td>
										</tr>
									</table>
								</td>
							</tr>
							<tr>
								<td height="2"><img src="/website/images/new15.gif" width="519" height="2"></td>
							</tr>
							<tr>
								<td height="120" background="/website/images/new16.gif"><font color="#00722F">&nbsp;&nbsp;&nbsp;&nbsp;附言</font><br>
									&nbsp;&nbsp;&nbsp;&nbsp;<textarea <%=isReadOnly%> cols="60" rows="6" name="appertain" class="text-area"><%=appertain%></textarea>
								</td>
							</tr>
							<tr>
								<td height="2"><img src="/website/images/new15.gif" width="519" height="2"></td>
							</tr>
							<%
							if (!((wo_status.equals("0")||wo_status.equals(""))))
							{
							%>
							<tr>
								<td background="/website/images/new14.gif"><font color="#00722F">&nbsp;&nbsp;&nbsp;&nbsp;审批意见</font><br>
									&nbsp;&nbsp;&nbsp;&nbsp;<textarea readonly name="wo_opinion" cols="60" rows="6" class="text-area"><%=wo_opinion%></textarea>
								</td>
							</tr>
							<tr>
								<td height="2"><img src="/website/images/new15.gif" width="519" height="2"></td>
							</tr>
							<tr>
								<td height="120" background="/website/images/new16.gif" valign="top">&nbsp;&nbsp;&nbsp;&nbsp;<font color="#00722F">相关消息</font>&nbsp;&nbsp;&nbsp;&nbsp;<span onclick="sendMsg();" style="cursor:hand"><font color="#00722F">[发消息]</font></span><br>
									<%
									sqlStr = "select ma_id,ma_title,ma_sendtime,to_char(ma_sendtime,'yyyy-mm-dd') sendtime,ma_senderdesc from tb_message where ma_relatedType='1' and ma_primaryid='"+l_wo_id+"' order by ma_sendtime desc";
									l_vPage = dImpl.splitPage(sqlStr,100,1);
									if (l_vPage!=null)
									{
										for (int i=0;i<l_vPage.size();i++)
										{
											Hashtable l_content = (Hashtable)l_vPage.get(i);
											String msgTitle = l_content.get("ma_title").toString();
											String msgId = l_content.get("ma_id").toString();
											String msgSendTime = l_content.get("sendtime").toString();
											String msgSender = l_content.get("ma_senderdesc").toString();
											%>
											 &nbsp;&nbsp;&nbsp;&nbsp;<%=(i+1)%>.<a href="#" onclick="readMsg('<%=msgId%>','Read')"><%=msgTitle%></a>&nbsp;<%=msgSendTime%>&nbsp;<%=msgSender%><br>
											<%
										}
									}
									else
									{
										out.print("&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;没有消息");
									}
									%>
								</td>
							</tr>
							<%
							}
							else//暂存或者刚刚填写
							{
							%>
							<tr>
								<td height="40" background="/website/images/new16.gif">
									<div align="right">
										<img src="/website/images/new18.gif" width="52" height="17" style="cursor:hand" onclick="submitPro()">&nbsp;&nbsp;&nbsp;
										<img src="/website/images/new19.gif" width="52" height="17" style="cursor:hand" onclick="history.back(-1);">&nbsp;&nbsp;&nbsp;&nbsp;
									</div>
								</td>
							</tr>
							<%
							}	
							%>
						</table>
					</td>
				  </tr>
				</table></td>
			</tr>
      </table></td>
  </tr>
  <input type="hidden" name="pr_id" value="<%=l_pd_projectId%>">
  <input type="hidden" name="wo_id" value="<%=l_wo_id%>">
  <input type="hidden" name="wo_attach_path" value="<%=wo_attach_path%>">
  <input type="hidden" name="isTemp" value=>
  </form>
</table>
<script language="javascript">
function del(attach)
{
	if(confirm("确实要删除该文件吗？"))
	{
		var w=1;
		var h=1; 
		var url = "DelAttach.jsp?attach="+attach;
		window.open(url,"","Top=0px,Left=0px,Width="+w+"px,Height="+h+"px,toolbar=no,location=no,derectories=no,status=no,menubar=no,resizable=yes,scrollbars=no");
	}
}
function sendMsg()
{
	var w=450;
	var h=270; 
	var url = "SendMessage.jsp?pr_id=<%=l_pd_projectId%>&wo_id=<%=l_wo_id%>";
	window.open(url,"发送消息","Top=0px,Left=0px,Width="+w+"px,Height="+h+"px,toolbar=no,location=no,derectories=no,status=no,menubar=no,resizable=no,scrollbars=no");
}

function readMsg(id,type)
{
	var w=450;
	var h=250;
	var url = "MessageDetail.jsp?ma_id="+id+"&OPType="+type;

	window.open(url,"查看消息","Top=0px,Left=0px,Width="+w+"px,Height="+h+"px,toolbar=no,location=no,derectories=no,status=no,menubar=no,resizable=no,scrollbars=no");
}
	
//检测用户信息是否输入完整

function checkUserInfo()
{
	var form = document.formData;
	if(form.userName.value=="")
	{
		alert("用户信息需要填写完整！");
		form.userName.focus();
		return false;
	}
	if(form.tel.value=="")
	{
		alert("用户信息需要填写完整！");
		form.tel.focus();
		return false;
	}
	if(form.address.value=="")
	{
		alert("用户信息需要填写完整！");
		form.address.focus();
		return false;
	}
	if(form.zipcode.value=="")
	{
		alert("用户信息需要填写完整！");
		form.zipcode.value=="";
		return false;
	}
	return true;
}

//检测附件是否都已上传

function checkAttachInfo()
{
	//检测必须上传的附件
	if(typeof(document.formData.fj1)!="undefined")
	{
		var attachs = document.formData.fj1;
		var length;
		if (typeof(attachs.length)=="undefined")
		{
			if(attachs.value=="")
			{
				alert("附件信息不完整！");
				attachs.focus();
				return false;
			}
		}
		else
		{
			length = attachs.length;
			for (var i=0;i<length;i++)
			{
				if(attachs[i].value=="")
				{
					alert("附件信息不完整！");
					attachs[i].focus();
					return false;
				}
			}
		}
	}
	//检测非相关文件的上传
	if (typeof(document.formData.fj2)!="undefined")
	{
		var attachs = document.formData.fj2;
		var attachDesc = document.formData.fjsm1;
		var length;
		if (typeof(attachs.length)=="undefined")
		{
			if (attachs.value!="")
			{
				if (attachDesc.value=="")
				{
					alert("附件说明不能为空！");
					attachDesc.focus();
					return false;
				}
			}
		}
		else
		{
			length = attachs.length;
			for (var i=0;i<length;i++)
			{
				if (attachs[i].value!="")
				{
					if (attachDesc[i].value=="")
					{
						alert("附件说明不能为空！");
						attachDesc[i].focus();
						return false;
					}
				}	
			}
		}
	}
	return true;
}

//提交的时候触发
function submitPro()
{
	if (checkUserInfo()&&checkAttachInfo())
	{
		var obj = formData.linkMan;
		if(typeof(obj)!="undefined")
		{
			if(obj.value=="")
			{
				alert("联系人不能为空！");
				obj.focus();
				return false;
			}
		}
		obj = formData.idCard;
		if (obj.value=="")
		{
			alert("信息尚未填写完整！");
			obj.focus();
			return false;
		}
		formData.isTemp.value="0";
		formData.action = "ProjectResult.jsp";
		formData.submit();
	}
}

//更新附件的时候触发
function openUpdate(val)
{
	var url = "ProjectUpdate.jsp?wa_id="+val;
	window.open(url,"更新附件","Top=0px,Left=0px,Width=550px,Height=300px,toolbar=no,location=no,derectories=no,status=no,menubar=no,scrollbars=yes");
}
</script>
<%
dImpl.closeStmt();
dCn.closeCn(); 
%>
<%@include file="/website/include/bottom_user.jsp"%>
