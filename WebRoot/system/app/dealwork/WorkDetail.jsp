<%@ page contentType="text/html; charset=GBK" %>
<%@include file="/system/app/skin/pophead.jsp"%>
<%
String OPType = "";
String isReadOnly = "";
String idDisabled = "";
String wo_id = "";
String us_id = "";
String pr_id = "";
String pa_name = "";
String sqlStr = "";
String applyName = "";
String projectName = "";
String linkman = "";
String tel = "";
String address = "";
String idCard = "";
String zipcode = "";
String deptName = "";
String fileName = "";
String path = "";
String filePath = "";
String appertain = "";
String opinion = "";
String status = "";
String strTitle = "项目详细信息";
String projectId = "";

//update20080122

CDataCn dCn=null;   //新建数据库连接对象
CDataImpl dImpl=null;  //新建数据接口对象

try {
 dCn = new CDataCn(); 
 dImpl = new CDataImpl(dCn); 


wo_id = CTools.dealString(request.getParameter("wo_id")).trim();
projectId = CTools.dealString(request.getParameter("pr_id")).trim();
OPType = CTools.dealString(request.getParameter("OPType")).trim();
if (!projectId.equals(""))
{
	strTitle = "后台受理";
	sqlStr = "select pr_name from tb_proceeding where pr_id='"+projectId+"'";
	Hashtable content = dImpl.getDataInfo(sqlStr);
	if (content!=null)
	{
		projectName = content.get("pr_name").toString();
	}
}

if (!wo_id.equals(""))
{
	isReadOnly = "readonly";
	sqlStr = "select a.wo_status,a.us_id,a.pr_id,a.wo_opinion,a.wo_projectname,a.wo_contactpeople,a.wo_tel,a.wo_address,a.wo_idcard,a.wo_postcode,a.wo_applypeople,a.wo_appertain,c.dt_name";
	sqlStr += " from tb_work a,tb_proceeding b,tb_deptinfo c ";
	sqlStr += "where a.wo_id='"+wo_id+"' and a.pr_id=b.pr_id and b.dt_id=c.dt_id";
	
	path = dImpl.getInitParameter("workattach_http_path");
	Hashtable content = dImpl.getDataInfo(sqlStr);
	if (content!=null)
	{
		applyName = content.get("wo_applypeople").toString();
		projectName = content.get("wo_projectname").toString();
		linkman = content.get("wo_contactpeople").toString();
		tel = content.get("wo_tel").toString();
		address = content.get("wo_address").toString();
		idCard = content.get("wo_idcard").toString();
		zipcode = content.get("wo_postcode").toString();
		deptName = content.get("dt_name").toString();
		appertain = content.get("wo_appertain").toString();
		opinion = content.get("wo_opinion").toString();
		pr_id = content.get("pr_id").toString();
		us_id = content.get("us_id").toString();
		status = content.get("wo_status").toString();
	}
}

%>
<script language="javascript">
function submitForm()
{
	var form = document.formReceive;
	var str1 = "userName,linkMan,tel,address,zipcode,idCard";
	var str2 = "申请人姓名,联系人,电话,地址,邮编,身份证号码（或企业注册号）";
	var arr1 = str1.split(",");
	var arr2 = str2.split(",");
	for (var i=0;i<arr1.length;i++)
	{
		var obj = eval("form."+arr1[i]);
		if (obj.value=="")
		{
			alert(arr2[i]+"不能为空！");
			obj.focus();
			return false;
		}
	}
	var obj = form.file1;
	if (typeof(obj)!="undefined")
	{
		if (typeof(obj.length)=="undefined") 
		{
			if(obj.value=="")
			{
				alert("没有选择上传文件！");
				obj.focus();
				return false();
			}
		}
		else
		{
			var length = obj.length;
			for(var i=0;i<length;i++)
			{
				if(obj[i].value=="")
				{
					alert("没有选择上传文件！");
					obj[i].focus();
					return false;
				}
			}
		}
	}
	form.action = "ProjectResult.jsp";
	form.submit();
}

function openAddMaterial(val)
{
	var w=550;
	var h=300;
	var url = "AddMaterial.jsp?wo_id="+val;
	window.open(url,"需补件理由","Top=0px,Left=0px,Width="+w+"px,Height="+h+"px,toolbar=no,location=no,derectories=no,status=no,menubar=no,resizable=no,scrollbars=no");
}
function display()
{
	var obj = message;
	if(obj.style.display=="")
	{
		obj.style.display="none";
		formData.msgImg.src="/system/images/topplus.gif";
	}
	else
	{
		obj.style.display="";
		formData.msgImg.src="/system/images/topminus.gif";
	}
}
function showMsgDetail(ma_id)
{
	var w=450;
	var h=250;
	var url = "MessageDetail.jsp?ma_id="+ma_id;
	window.open(url,"已发消息","Top=0px,Left=0px,Width="+w+"px,Height="+h+"px,toolbar=no,location=no,derectories=no,status=no,menubar=no,resizable=no,scrollbars=no");
}
function sendMsg(wo_id)
{
	var w=450;
	var h=250;
	var url = "MessageDetail.jsp?wo_id="+wo_id;
	window.open(url,"给用户发消息","Top=0px,Left=0px,Width="+w+"px,Height="+h+"px,toolbar=no,location=no,derectories=no,status=no,menubar=no,resizable=yes,scrollbars=yes");
}

function checkForm(val)
{
	var obj = formData.dealType;
	obj.value = val;
	if (val!=0)
	{
		if (formData.wo_opinion.value=="")
		{
			alert("审批意见不能为空！");
			formData.wo_opinion.focus();
			return false;
		}
	}
	formData.action = "WorkResult.jsp";
	formData.submit();
}
function openCorrForm(wo_id,pr_id)
{
	var w=750;
	var h=450;
	var url="../cooperate/CorrForm.jsp?OPType=Corr&wo_id="+wo_id+"&pr_id="+pr_id;
	window.open(url,"在线协调单","top=150px,left=150px,width="+w+",height="+h+",toolbar=no,location=no,derectories=no,status=no,menubar=no,resizable=no,scrollbars=no");
}
</script>
<table class="main-table" width="100%" align="center">
<form name="formReceive" method="post" enctype="multipart/form-data">
	<tr class="title1" >
		<td colspan="9"><font size=2><%=strTitle%></td>
	</tr>
	<tr>
		<td colspan="9">
			<table width="100%" border="0" cellspacing="1" cellpadding="0" bgcolor="#E3E3E3">
				<tr>
					<td height="25" bgcolor="#FFFFFF" align=center colspan="2"><font size="3"><%=projectName%></font><input type="hidden" name="projectName" value="<%=projectName%>"></td>
				</tr>
				<tr>
					<td height="25" bgcolor="#FFFFFF"  colspan="2">
					&nbsp;&nbsp;&nbsp;&nbsp;
						姓名：<input class="text-line" name="userName" value="<%=applyName%>" <%=isReadOnly%>>
					&nbsp;&nbsp;
						联系人：<input class="text-line" name="linkMan" value="<%=linkman%>" <%=isReadOnly%>>
					&nbsp;&nbsp;
						电话：<input class="text-line" name="tel" value="<%=tel%>" <%=isReadOnly%>>
					</td>
				</tr>
				<tr>
					<td height="25" bgcolor="#FFFFFF" colspan="2">
					&nbsp;&nbsp;&nbsp;&nbsp;
						地址：<input class="text-line" name="address" value="<%=address%>" <%=isReadOnly%>>
					&nbsp;&nbsp;&nbsp;&nbsp;
						邮编：<input class="text-line" name="zipcode" value="<%=zipcode%>" <%=isReadOnly%>>
					</td>
				</tr>
				<tr>
					<td height="25" bgcolor="#FFFFFF" colspan="2">
					&nbsp;&nbsp;&nbsp;&nbsp;
						身份证号码（或企业注册号）：<input class="text-line" name="idCard" size="40" value="<%=idCard%>" <%=isReadOnly%>>
					</td>
				</tr>
				<tr>
					<td height="25" bgcolor="#FFFFFF" colspan="2">
					&nbsp;&nbsp;&nbsp;&nbsp;
						递交材料
					</td>
				</tr>
				<tr>
					<td height="25" bgcolor="#FFFFFF" colspan="2">
					
						<%
						if(!wo_id.equals(""))//业务办理
						{
							sqlStr = "select a.wa_id,a.wa_filename,a.pa_name from tb_workattach a ";
							sqlStr += "where a.wo_id='"+wo_id+"'";
							
							Vector vPage = dImpl.splitPage(sqlStr,100,1);
							if (vPage!=null)
							{
								for (int i=0;i<vPage.size();i++)
								{
									Hashtable content = (Hashtable)vPage.get(i);
									fileName = content.get("wa_filename").toString();
									//filePath = content.get("wa_path").toString();
									pa_name = content.get("pa_name").toString();
									%>
									&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
									<%=(i+1)%>.&nbsp;&nbsp;<a href="/website/include/downloadWA.jsp?wa_id=<%=content.get("wa_id").toString()%>"><%=pa_name%></a><br>
									<%
								}
							}
						}
						else if (!projectId.equals(""))//后台受理
						{
							sqlStr = "select pa_id,pa_name from tb_proceedingattach where pr_id='"+projectId+"' and pa_upload='1'";
							Vector vPage = dImpl.splitPage(sqlStr,100,1);
							if (vPage!=null)
							{
							%>
							<table border="0" cellspacing="0" width="100%">
							<%
								for( int i=0;i<vPage.size();i++)
								{
									Hashtable content = (Hashtable)vPage.get(i);
									fileName = content.get("pa_name").toString();
									String pa_id = content.get("pa_id").toString();
									%>
									<tr>
									<td width="5%">&nbsp;</td>
									<td align="left"><%=(i+1)%>.<a title="下载该文件" href="/website/include/download.jsp?pa_id=<%=pa_id%>"><%=fileName%></a></td>
									<td align="left"><input type="hidden" name="pa_id" value="<%=pa_id%>"><input type="hidden" name="pa_name" value="<%=fileName%>"><input name="file1" type="file" class="text-line"></td>
									</tr>
									<%
								}
							%>
							</table>
							<%
							}
						}
						%>
					</td>
				</tr>
				<tr>
					<td height="25" bgcolor="#FFFFFF" valign="middle" align="right">
						附言：
					</td>
					<td height="25" bgcolor="#FFFFFF" valign="middle" align="left">
						<textarea class="text-line" cols="60" name="appertain" rows="7" <%=isReadOnly%>><%=appertain%></textarea>
					</td>
				</tr>
			</table>
		</td>
	</tr>
	<input type="hidden" name="projectId" value="<%=projectId%>">
	</form>
	<form name="formData" method="post" action="WorkResult.jsp">
	<%
	if (!wo_id.equals(""))
	{
	%>
	<tr class="line-odd">
		<td align="left" width="10%" colspan="9">&nbsp;&nbsp;&nbsp;&nbsp;审批意见：</td>
	</tr>
	<tr class="line-even">
		<td align="left">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<textarea cols="60" rows="7" name="wo_opinion" readonly <%if(OPType.equals("View")) out.print("readonly");%>><%=opinion%></textarea></td>
	</tr>
	<tr class="line-odd">
		<td colspan="9" align="left"><img border="0" src="/system/images/topplus.gif" WIDTH="16" HEIGHT="16" id="msgImg" style="cursor:hand" onclick="display()"><span onclick="display()" style="cursor:hand">&nbsp;查看已发送消息</span></td>
	</tr>
	<tr  id="message" style="display:none">
	  <td colspan="9" align="left">
		<table border=0 cellspacing="1" width="100%">
		<tr class="line-even">
		<td width="10%" align="right">已发消息：</td>
		<td align="left">
			<div>
				<% //显示针对该项目的消息
				if (!wo_id.equals(""))
				{
					sqlStr = "select ma_id from tb_message where ma_primaryid='"+wo_id+"' and ma_relatedtype='1'";
					
					Vector vPage  = dImpl.splitPage(sqlStr,500,1);
					if(vPage!=null)
					{
						for(int i=0;i<vPage.size();i++)
						{
							Hashtable l_content = (Hashtable)vPage.get(i);
							String msgId = l_content.get("ma_id").toString();
							CMessage msg = new CMessage(dImpl,msgId);
							%>
							<a href="#" onclick="showMsgDetail('<%=msgId%>')"><%=msg.getValue(CMessage.msgTitle)%></a>&nbsp;<%=msg.getValue(CMessage.msgSendTime)%>&nbsp;<%=msg.getValue(CMessage.msgSenderDesc)%><br>
							<%
						}
					}
				}
				%>
				</div>
		</td>
		</tr>
		</table></td>
	</tr>
	
	<!--<tr class="title1">
		<td colspan="9" align="center">
			<input type="button" class="bttn" value="暂存" <%if(!status.equals("1")) out.print("disabled");%> onclick="checkForm(0)">&nbsp;
			<input type="button" class="bttn" value="通过" <%if(!status.equals("1")) out.print("disabled");%> onclick="checkForm(3)">&nbsp;
			<input type="button" class="bttn" value="不通过" <%if(!status.equals("1")) out.print("disabled");%> onclick="checkForm(4)">&nbsp;
			<input type="button" class="bttn" value="发消息" <%if(status.equals("3")||status.equals("4")) out.print("disabled");%> onclick="sendMsg('<%=wo_id%>');">&nbsp;
			<input type="button" class="bttn" value="需补件" <%if(status.equals("3")||status.equals("4")) out.print("disabled");%> onclick="openAddMaterial('<%=wo_id%>');">&nbsp;
			<input type="button" class="bttn" value="请求协调" <%if(status.equals("3")||status.equals("4")) out.print("disabled");%> onclick="openCorrForm('<%=wo_id%>','<%=pr_id%>');">&nbsp;
			<input type="button" class="bttn" value="返回" onclick="javascript:window.history.go(-1);">&nbsp;
		</td>
	</tr>
	<input type="hidden" value="<%=wo_id%>" name="wo_id">
	<input type="hidden" value="" name="dealType">
	<%
	}
	else if (!projectId.equals(""))
	{
	%>
	<tr class="title1">
		<td colspan="9" align="center">
			<input type="button" class="bttn" value="提交"  onclick="submitForm()">&nbsp;
			<input type="reset" class="bttn" value="重写">&nbsp;
			<input type="button" class="bttn" value="返回" onclick="javascript:window.history.go(-1);">&nbsp;
		</td>
	</tr>
	<%
	}
	%>-->
</form>
</table>
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
<%@include file="/system/app/skin/popbottom.jsp"%>