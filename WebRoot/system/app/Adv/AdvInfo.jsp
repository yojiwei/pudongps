<%@page contentType="text/html; charset=GBK"%>
<%@include file="/system/manage/head.jsp"%>
<%@include file="/system/app/skin/skin3/headold.jsp"%>
<%@include file="/system/app/islogin.jsp"%>
<link href="/system/app/skin/skin3/images/style.css" rel="stylesheet" type="text/css">
<!--开始-->
<script LANGUAGE="javascript">
function showCal(obj)
{
	if (!obj) var obj = event.srcElement;
	var obDate;
	if ( obj.value == "" ) {
		obDate = new Date();
	} else {
		var obList = obj.value.split( "-" );
		obDate = new Date( obList[0], obList[1]-1, obList[2] );
	}

	var retVal = showModalDialog( "../../common/calendar/calendar.htm", obDate,"dialogWidth=206px; dialogHeight=206px; help=no; scroll=no; status=no; " );

	if (typeof(retVal) != "undefined" ) {
		var year = retVal.getFullYear();
		var month = retVal.getMonth()+1;
		var day = retVal.getDate();
		obj.value =year + "-" + month + "-" + day;
	}
}


function checkform(rd)
{
	var form = document.formData ;
	if(form.ai_name.value=="")
	{
		alert("请填写图片链接名称！");
		form.ai_name.focus();
		return false;
	}
	if(form.ai_type.value=="")
	{
		alert("请选择图片链接类型！");
		form.ai_type.focus();
		return false;
	}
	if(form.ai_position.value=="")
	{
		alert("请选择图片链接位置！");
		form.ai_position.focus();
		return false;
	}

	if(form.ai_islink.value=="2")
	{
		if(form.ai_urllink.value=="")
		{
			alert("请正确填写远程链接地址！");
			form.ai_urllink.focus();
			return false;
		}
	}

	if(form.file_name=="")
	{
		if(form.ai_file.value=="")
		{
			alert("请选择文件！");
			form.ai_file.focus();
			return false;
		}
	}

	//if(form.ws_buildarea.value =="")
	//{
	//	alert("请填写建筑面积!");
	//	form.ws_buildarea.focus();
	//	return false;
	//}
	//else
	//{
	//	if(isNaN(form.ws_buildarea.value))
	//	{
	//		alert("建筑面积请填写数字！");
	//		form.ws_buildarea.focus();
	//		return false;
	//	}
	//}
	//if(form.ws_hire.value =="")
	//{
	//	alert("请填写租金!");
	//	form.ws_hire.focus();
	//	return false;
	//}
	//else
	//{
	//	if(isNaN(form.ws_hire.value))
	//	{
	//		alert("租金请填写数字！");
	//		form.ws_hire.focus();
	//		return false;
	//	}
	//}
	form.action = "AdvResult.jsp?rd="+rd;
	form.submit();
}

function delinfo()
{
	var form = document.formData;
	var con;
	con=confirm("真的要删除吗？");
	if (con)
	{
		form.action = "Repositorydel.jsp";
		form.submit();
	}
}

function selectitem()
{

	var w = 500;
	var h = 500;
	var url = "selectItem.jsp";
	window.open( url, "upload", "Width="+w+"px, Height="+h+"px,toolbar=no,location=no,derectories=no,status=no,menubar=no,scrollbars=yes" );
}

function delfile()
{
	var form = document.formData1;
	var con;
	con=confirm("真的要删除吗？");
	if (con)
	{
		form.action = "FileDel.jsp";
		form.submit();
	}
}

function isLink(Value)
{
	if(Value=="0")
	{
		document.all.htmlEc.style.display="none";
		demo.setHTML("");
		document.all.ai_urllink.style.display="none";
		document.all.ai_urllink.value="";
	}
	if(Value=="1")
	{
		document.all.htmlEc.style.display="";
		document.all.ai_urllink.style.display="none";
		document.all.ai_urllink.value="";
	}
	if(Value=="2")
	{
		document.all.htmlEc.style.display="none";
		demo.setHTML("");
		document.all.ai_urllink.style.display="";
	}
}

function CanTime(obj)
{
	if(obj.value!="")
	{
		document.all.ai_start_timeex.disabled=false;
		document.all.ai_end_timeex.disabled=false;
	}
	else
	{
		document.all.ai_start_timeex.disabled=true;
		document.all.ai_end_timeex.disabled=true;
	}
}
</script>

<!-- 程序开始 -->
<%
CDataCn dCn = new CDataCn(); //新建数据库连接对象
CDataImpl dImpl = new CDataImpl(dCn); //新建数据接口对象

String Isactivity = "";
String Isactivity1 = "";
String sql="";
String OPType="";//操作方式 Add是添加 Edit是修改
String tstrSelect = "";
String pstrSelect = "";

String ai_id = "";
String ai_name = "";
String ai_type = "";
String ai_position = "";
String ai_memo = "";
String ai_islink = "";
String ai_script = "";
String ai_date = "";
String ai_isok = "";
String ai_filename = "";
String ai_filepath = "";
String ai_urllink = "";
String ai_content = "";
//String ai_start_time = "";
//String ai_end_time = "";

String ai_start_timehx = "";
String ai_start_timeex = "";

String ai_end_timehx = "";
String ai_end_timeex = "";

String ai_pri = "";

String GetTime_start = "";
String GetTimeex_start = "";

String GetTime_end = "";
String GetTimeex_end = "";

String status_start = "";
String status_end = "";

//GetTime = "<option value='00:00'>00:00</option><option value='00:30'>00:30</option><option value='01:00'>01:00</option><option value='01:30'>01:30</option><option value='02:00'>02:00</option><option value='02:30'>02:30</option><option value='03:00'>03:00</option><option value='03:30'>03:30</option><option value='04:00'>04:00</option>";
//Calendar cal = Calendar.getInstance();
//int month=cal.get(cal.MONTH)+1;
//ai_date=(cal.get(cal.YEAR) + "-" + month +"-"+ cal.get(cal.DAY_OF_MONTH)).toString();//发布时间;

/*得到上一个页面传过来的参数  开始*/
ai_id=CTools.dealString(request.getParameter("ai_id")).trim();
OPType=CTools.dealString(request.getParameter("OPType")).trim();//如果是编辑情况

if (OPType.equals("Edit")||OPType.equals("Check"))
{
	Isactivity = " class='text-line'";
	sql="select ai_name,ai_type,to_char(ai_date,'yyyy-mm-dd') ai_date,ai_position,ai_memo,ai_islink,ai_filename,ai_isok,ai_filepath,ai_script,ai_urllink,ai_content,ai_start_timehx,ai_start_timeex,ai_end_timehx,ai_end_timeex,ai_pri from tb_advinfo where ai_id=" + ai_id;
	//out.println(sql);
	Hashtable content=dImpl.getDataInfo(sql);
	if(content != null)
	{
		ai_name=content.get("ai_name").toString();
		ai_type=content.get("ai_type").toString();
		ai_date=content.get("ai_date").toString();
		ai_position=content.get("ai_position").toString();
		ai_memo=content.get("ai_memo").toString();
		ai_islink=content.get("ai_islink").toString();
		ai_script=content.get("ai_script").toString();
		ai_isok=content.get("ai_isok").toString();
		ai_filename=content.get("ai_filename").toString();
		ai_filepath=content.get("ai_filepath").toString();
		ai_urllink=content.get("ai_urllink").toString();
		ai_content=content.get("ai_content").toString();
		
		ai_start_timehx=content.get("ai_start_timehx").toString();
		ai_start_timeex=content.get("ai_start_timeex").toString();
		ai_end_timehx=content.get("ai_end_timehx").toString();
		ai_end_timeex=content.get("ai_end_timeex").toString();
		
		ai_pri=content.get("ai_pri").toString();
	}
}
else
{
	Isactivity = "class='text-line'";
}

if(OPType.equals("Check"))
{
	Isactivity = Isactivity + " readonly";
	Isactivity1 = " disabled";
}

String tsql = "select at_id,at_name from tb_advtype ";
Vector tvectorPage = dImpl.splitPage(tsql,1000,1);
if(tvectorPage!=null)
{
	tstrSelect = tstrSelect + "<select name=\"ai_type\">";
	tstrSelect = tstrSelect + "<option value=\"0\">－－请选择类型－－</option>";
	for(int j=0;j<tvectorPage.size();j++)
	{
		Hashtable tcontent = (Hashtable)tvectorPage.get(j);
		String at_id = tcontent.get("at_id").toString();
		String at_name = tcontent.get("at_name").toString();
		tstrSelect = tstrSelect + "<option value="+at_id;
		if(at_id.equals(ai_type))
		{
			tstrSelect = tstrSelect + " selected";
		}
		tstrSelect = tstrSelect + ">" + at_name + "</option>";
	}
	tstrSelect = tstrSelect + "</select>";
}

	com.app.CMySelf ms = new com.app.CMySelf();
	ms = (com.app.CMySelf)session.getAttribute("mySelf");
	long myId = ms.getMyID();
	String userId = ms.getMyUid();
	
	
String psql = "";
if (!userId.equals("administrator")) 
	psql = "select ap_name,ap_id from tb_advposition where ur_id like '%" + myId + "%' order by ap_id";
else
	psql = "select ap_name,ap_id from tb_advposition order by ap_id";
		
Vector pvectorPage = dImpl.splitPage(psql,1000,1);
if(pvectorPage!=null)
{
	pstrSelect = pstrSelect + "<select name=\"ai_position\">";
	pstrSelect = pstrSelect + "<option value=\"0\">－－请选择位置－－</option>";
	for(int j=0;j<pvectorPage.size();j++)
	{
		Hashtable pcontent = (Hashtable)pvectorPage.get(j);
		String ap_id = pcontent.get("ap_id").toString();
		String ap_name = pcontent.get("ap_name").toString();
		pstrSelect = pstrSelect + "<option value="+ap_id;
		if(ap_id.equals(ai_position))
		{
			pstrSelect = pstrSelect + " selected";
		}
		pstrSelect = pstrSelect + ">" + ap_name + "</option>";
	}
	pstrSelect = pstrSelect + "</select>";
}

if(ai_start_timehx.equals("1900-01-01"))
{
	ai_start_timehx = "";
}

if(ai_end_timehx.equals("2999-12-30"))
{
	ai_end_timehx = "";
}

for(int i = 0;i<48;i++)
{
	switch(String.valueOf(i/2).length())
	{
		case 1 :
		GetTimeex_start = "0" + i/2;
		GetTimeex_end = "0" + i/2;
		break;
		case 2:
		GetTimeex_start = String.valueOf(i/2);
		GetTimeex_end = String.valueOf(i/2);
		break;
	}
	GetTimeex_start += ":";
	GetTimeex_end += ":";
	if(i%2 == 0)
	{
		GetTimeex_start += "00";
		GetTimeex_end += "00";
	}
	else
	{
		GetTimeex_start += "30";
		GetTimeex_end += "30";
	}
	
	if(GetTimeex_start.equals(ai_start_timeex))
	{
		status_start = "selected";
	}
	else
	{
		status_start = "";
	}

	if(GetTimeex_end.equals(ai_end_timeex))
	{
		status_end = "selected";
	}
	else
	{
		status_end = "";
	}

	GetTime_start += "<option value='" + GetTimeex_start + "' " + status_start + ">" + GetTimeex_start + "</option>";
	GetTime_end += "<option value='" + GetTimeex_end + "' " + status_end + ">" + GetTimeex_end + "</option>";
}
%>

<!--程序结束-->
<!--HTML主体开始-->
<table class="main-table" width="100%" align="center">
<form name="formData" method="post" enctype="multipart/form-data">

	<tr class="title1" align=center>
		<td background="../../skin/skin1/images/background-_15a.gif">图片链接信息表</td>
	</tr>
	<tr>
		<td width="100%">
			<table width="100%" class="content-table" height="1">
				<tr class="line-odd" >
					<td width="15%" align="right">图片链接名称</td>
					<td width="35%" colspan="3" align="left"><input type="text" size="50" name="ai_name" maxlength="150" value="<%=ai_name%>" <%=Isactivity%>>
					</td>
				</tr>

				<tr class="line-even" >
					<td width="15%" align="right">图片链接位置</td>
					<td width="35%" align="left"><%=pstrSelect%></td>
					<td width="15%" align="right">图片链接类型</td>
					<td width="35%" align="left"><%=tstrSelect%></td>
				</tr>

				<tr class="line-odd" >
					<td width="15%" align="right">图片链接有效期</td>
					<td width="85%" colspan="3" align="left"><input type="date" size="15" name="ai_start_timehx" onclick="javascript:showCal()" style="cursor:hand" class=text-line  readonly value="<%=ai_start_timehx%>">&nbsp;<select name="ai_start_timeex" id="ai_start_timeex"><%=GetTime_start%></select>&nbsp;<b>到</b>&nbsp;<input type="date" size="15" name="ai_end_timehx" onclick="javascript:showCal()" style="cursor:hand" class=text-line  readonly value="<%=ai_end_timehx%>">&nbsp;<select name="ai_end_timeex" id="ai_end_timeex"><%=GetTime_end%></select></td>
				</tr>

				<tr class="line-even" >
					<td width="15%" align="right">备注</td>
					<td width="85%" colspan="3" align="left"><textarea name="ai_memo" cols="78" rows="7" <%=Isactivity%>><%=ai_memo%></textarea>
				</tr>
				
				<tr class="line-odd">
					<td align="right">是否添加链接</td>
					<td colspan="3" align="left">
						<select name="ai_islink" onchange="javascript:isLink(this.value);">
							<%if(ai_islink.equals("0")||ai_islink.equals("")){%>
							<option value="0" selected>-------</option>
							<!-- <option value="1">添加本地信息</option> -->
							<option value="2">添加远程链接</option>
							<%}if(ai_islink.equals("1")){%>
							<option value="0">-------</option>
							<!-- <option value="1" selected>添加本地信息</option> -->
							<option value="2">添加远程链接</option>
							<%}if(ai_islink.equals("2")){%>
							<option value="0">-------</option>
							<!-- <option value="1">添加本地信息</option> -->
							<option value="2" selected>添加远程链接</option>
							<%}%>
						</select>
						&nbsp;&nbsp;&nbsp;&nbsp;<input name="ai_urllink" class="text-line" type="text" style="display:<%if(!ai_islink.equals("2")) out.println("none");%>" size="50" value="<%=ai_urllink%>"></td>
				</tr>

				<tr id="htmlEc" class="line-odd" style="display:none">
					<td colspan="4">
						<iframe id="demo" style="HEIGHT: 400px; TOP: 5px; WIDTH: 100%" src="/system/common/editor/editor.htm"></iframe>
						<input type="hidden" id="ai_content" name="ai_content" value="<%=CTools.htmlEncode(ai_content)%>">
					</td>
				</tr>

				<tr class="line-even" >
					<td width="15%" align="right">脚本</td>
					<td width="85%" colspan="3" align="left"><textarea name="ai_script" cols="78" rows="7" <%=Isactivity%>><%=ai_script%></textarea>
				</tr>

				<tr class="line-odd" >
					<td width="15%" align="right">上传图片链接文件</td>
					<td width="85%" colspan="3" align="left">
					<%
					if(ai_filename.equals(""))
					{
						out.println("<input type=\"file\" name=\"ai_file\" size=\"40\">");
					}
					else
					{
						out.println("&nbsp;<a href=\"\">"+ai_filename+"</a>&nbsp;&nbsp;<img src=\"../../images/delete.gif\" onclick=\"javascript:delfile();\" style=\"cursor:hand\" alt=\"删除文件\">");
					}
					%>
					</td>
				</tr>

				<tr class="line-even" >
					<td width="15%" align="right">是否发布</td>
					<td width="35%" align="left"><input type="radio" size="40" name="ai_isok" value="1" <%if(ai_isok.equals("1")) out.println("checked");%>>&nbsp;是&nbsp;&nbsp;<input type="radio" name="ai_isok" value="0" <%if(ai_isok.equals("0")||ai_isok.equals("")) out.println("checked");%>>&nbsp;否</td>
					<td width="15%" align="right">加权数值</td>
					<td width="35%" align="left"><select name="ai_pri">
						<%
						for(int i=0;i<11;i++)
						{
							if(ai_pri.equals(String.valueOf(i)))
							{
								out.println("<option value='" + i + "' selected>" + i + "</option>");
							}
							else
							{
								out.println("<option value='" + i + "'>" + i + "</option>");
							}
						}
						%></select>
					</td>
				</tr>

				<!-- <tr class="line-even" >
					<td width="15%" align="center">图片链接点击量</td>
					<td width="35%"></td>
					<td width="15%" align="center">循环周期</td>
					<td width="35%">&nbsp;&nbsp;<span><font color="#A2A2A2">没有安排</font></span>&nbsp;&nbsp;&nbsp;&nbsp;<input type="button" value="设定" onclick=""><input name="ai_cycclass" type="hidden"><input name="ai_cyccontent" type="hidden"></td>
				</tr> -->

				<tr height="30" class="line-odd">
					<td colspan="4" align="middle">
					<%
					if(OPType.equals("Addnew"))
					{
					%>
						<input type="button" class="bttn" name="fsubmit" value="保存并继续发布" onclick="javascript:checkform(1)">&nbsp;
						<input type="button" class="bttn" name="fsubmit" value="保存并返回列表" onclick="javascript:checkform(0)">&nbsp;
						<input type="reset" class="bttn" name="reset" value="重 写">&nbsp;
						<input type="button" class="bttn" name="back" value="返 回" onclick="javascript:history.back();">
					<%
					}
					else if(OPType.equals("Edit"))
					{
					%>
						<input type="button" class="bttn" name="fsubmit" value="保存并继续发布" onclick="javascript:checkform(1)">&nbsp;
						<input type="button" class="bttn" name="fsubmit" value="保存并返回列表" onclick="javascript:checkform(0)">&nbsp;
						<input type="button" class="bttn" name="del" value="删 除" onclick="javascript:if(confirm('真的要删除吗？')){self.location='advInfoDel.jsp?ai_id=<%=ai_id%>';}">&nbsp;
						<input type="reset" class="bttn" name="reset" value="重 写">&nbsp;
						<input type="button" class="bttn" name="back" value="返 回" onclick="javascript:history.back();">
					<%
					}
					else if(OPType.equals("Check"))
					{
					%>
						<input type="button" class="bttn" name="back" value="返 回" onclick="javascript:history.back();">
					<%}%>
					</td>
				</tr>
				<INPUT TYPE="hidden" name="ai_id" value="<%=ai_id%>">
				<INPUT TYPE="hidden" name="OPType" value="<%=OPType%>">
				<INPUT TYPE="hidden" name="file_name" value="<%=ai_filename%>">
				<INPUT TYPE="hidden" name="ai_filepath" value="<%=ai_filepath%>">
			</table>
		</td>
	</tr>

</form>
<form name="formData1" method="post" >
<INPUT TYPE="hidden" name="ai_id1" value="<%=ai_id%>">
<INPUT TYPE="hidden" name="OPType1" value="<%=OPType%>">
<INPUT TYPE="hidden" name="ai_filename1" value="<%=ai_filename%>">
<INPUT TYPE="hidden" name="ai_filepath1" value="<%=ai_filepath%>">
</form>
</table>
<!-- 主体结束 -->
<%
//关闭连接
dImpl.closeStmt();
dCn.closeCn();
%>
<%@include file="../skin/bottom.jsp"%>
