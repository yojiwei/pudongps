<%@page contentType="text/html; charset=GBK"%>
<%@include file="/system/manage/head.jsp"%>
<%@include file="/system/app/skin/skin3/headold.jsp"%>
<%@include file="/system/app/islogin.jsp"%>
<script LANGUAGE="javascript" src="./common/common.js"></script>
<script LANGUAGE="javascript" src="/system/common/treeview/chooseTreeJs.jsp"></script>
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
	if(form.ap_name.value=="")
	{
		alert("请填写名称！");
		form.ap_name.focus();
		return false;
	}
	if(form.ap_code.value=="")
	{
		alert("请填写代码！");
		form.ap_code.focus();
		return false;
	}
	if(form.ap_form.value=="0")
	{
		alert("请选择图片链接形式！");
		form.ap_form.focus();
		return false;
	}
	if(form.ap_width.value=="")
	{
		alert("请填写图片链接宽度！");
		form.ap_width.focus();
		return false;
	}
	else
	{
		if(isNaN(form.ap_width.value))
		{
			alert("图片链接宽度请填写数字！");
			form.ap_width.focus();
			return false;
		}
	}
	if(form.ap_height.value=="")
	{
		alert("请填写图片链接高度！");
		form.ap_height.focus();
		return false;
	}
	else
	{
		if(isNaN(form.ap_height.value))
		{
			alert("图片链接高度请填写数字！");
			form.ap_height.focus();
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
	form.action = "PositionResult.jsp?rd="+rd;
	form.submit();
}

function delinfo(id)
{
	var form = document.formData;
	var con;
	con=confirm("真的要删除吗？");
	if (con)
	{
		form.action = "Repositorydel.jsp?ap_id="+id;
		form.submit();
	}
}

function Isdisplay(value)
{
	var obj = document.all.mytr
	for(i=0;i<obj.length;i++)
	{
		if(value=="0")
		{
			obj[i].style.display = "none";
		}
		else
		{
			obj[i].style.display = "block";
		}
	}
}

function delfile()
{
	var form = document.formData1;
	var con;
	con=confirm("真的要删除吗？");
	if (con)
	{
		form.action = "PFileDel.jsp";
		form.submit();
	}
}
</script>

<!-- 程序开始 -->
<%
CDataCn dCn = new CDataCn(); //新建数据库连接对象
CDataImpl dImpl = new CDataImpl(dCn); //新建数据接口对象

String Isactivity = "";
String tstrSelect = "";
String fstrSelect = "";
String sql="";
String OPType="";//操作方式 Add是添加 Edit是修改

String ap_id = "";
String ap_name = "";
String ap_code = "";
String ap_width = "";
String ap_height = "";
String ap_memo = "";
String ap_type = "";
String ap_form = "";
String ap_display = "";
String ap_filepath = "";
String ap_filename = "";
String trdis = "";

String sj_id = "";
String sjName1 = "";

String ur_id = "";

//String Module_name = "";
//Calendar cal = Calendar.getInstance();
//int month=cal.get(cal.MONTH)+1;
//ai_date=(cal.get(cal.YEAR) + "-" + month +"-"+ cal.get(cal.DAY_OF_MONTH)).toString();//发布时间;

/*得到上一个页面传过来的参数  开始*/
sj_id = CTools.dealNumber(request.getParameter("sj_id")).trim();
sjName1 = CTools.dealString(request.getParameter("sjName1"));

ap_id=CTools.dealString(request.getParameter("ap_id")).trim();
OPType=CTools.dealString(request.getParameter("OPType")).trim();//如果是编辑情况

if (OPType.equals("Edit")||OPType.equals("Check"))
{
	Isactivity = " class='text-line'";
	sql="select * from tb_advposition where ap_id=" + ap_id;
	//out.println(sql);
	Hashtable content=dImpl.getDataInfo(sql);
	if(content != null)
	{
		ap_name=content.get("ap_name").toString();
		ap_code=content.get("ap_code").toString();
		ap_width=content.get("ap_width").toString();
		ap_height=content.get("ap_height").toString();
		ap_type=content.get("ap_type").toString();
		ap_form=content.get("ap_form").toString();
		ap_display=content.get("ap_display").toString();
		ap_memo=content.get("ap_memo").toString();
		ap_filename=content.get("ap_filename").toString();
		ap_filepath=content.get("ap_filepath").toString();
		ur_id = content.get("ur_id").toString();
		//Module_name=content.get("sj_name").toString();
		//Module_name=CTools.dealNull(content.get("sj_name"));
	}
}
else
{
	Isactivity = "class='text-line'";
}

if(OPType.equals("Check"))
{
	Isactivity = Isactivity + " readonly";
}
String tsql = "select at_id,at_name from tb_advtype";
Vector tvectorPage = dImpl.splitPage(tsql,1000,1);
if(tvectorPage!=null)
{
	tstrSelect = tstrSelect + "<select name=\"ap_type\">";
	tstrSelect = tstrSelect + "<option value=\"0\">－－请选择类型－－</option>";
	for(int j=0;j<tvectorPage.size();j++)
	{
		Hashtable tcontent = (Hashtable)tvectorPage.get(j);
		String at_id = tcontent.get("at_id").toString();
		String at_name = tcontent.get("at_name").toString();
		tstrSelect = tstrSelect + "<option value="+at_id;
		if(at_id.equals(ap_type))
		{
			tstrSelect = tstrSelect + " selected";
		}
		tstrSelect = tstrSelect + ">" + at_name + "</option>";
	}
	tstrSelect = tstrSelect + "</select>";
}

String fsql = "select af_id,af_name from tb_advform";
Vector fvectorPage = dImpl.splitPage(fsql,1000,1);
if(fvectorPage!=null)
{
	fstrSelect = fstrSelect + "<select name=\"ap_form\">";
	fstrSelect = fstrSelect + "<option value=\"0\">－－请选择形式－－</option>";
	for(int j=0;j<fvectorPage.size();j++)
	{
		Hashtable fcontent = (Hashtable)fvectorPage.get(j);
		String af_id = fcontent.get("af_id").toString();
		String af_name = fcontent.get("af_name").toString();
		fstrSelect = fstrSelect + "<option value="+af_id;
		if(af_id.equals(ap_form))
		{
			fstrSelect = fstrSelect + " selected";
		}
		fstrSelect = fstrSelect + ">" + af_name + "</option>";
	}
	fstrSelect = fstrSelect + "</select>";
}

if(ap_display.equals("0")||ap_display.equals(""))
{
	trdis = "none";
}

	 String ui_name = "";
	 if (!"".equals(ur_id)) {
		 String strSql = "select ui_name from tb_userinfo where ui_id in (" + ur_id + ")";
		 Vector vPage = dImpl.splitPageOpt(strSql,1000,1);
		 Hashtable ht = null;
		 if (vPage != null) {
		 	for (int i = 0;i < vPage.size();i++) {
		 		ht = (Hashtable)vPage.get(i);
		 		ui_name += ht.get("ui_name").toString() + ",";
		 	}
			//ui_name = ui_name.substring(0,ui_name.length()-1);
		 }
	 }
%>

<!--程序结束-->
<!--HTML主体开始-->
<table class="main-table" width="100%" align="center">
<form name="formData" method="post" enctype="multipart/form-data">
	
	<tr class="title1" align=center>
		<td background="../../skin/skin1/images/background-_15a.gif">图片链接位置信息表</td>
	</tr>
	<tr>
		<td width="100%">
			<table width="100%" class="content-table" height="1">
				<tr class="line-even" >
					<td width="15%" align="right">名称</td>
					<td width="35%" colspan="3" align="left"><input type="text" size="50" name="ap_name" maxlength="150" value="<%=ap_name%>" <%=Isactivity%>>
					</td>
				</tr>
				<tr class="line-odd" >
					<td width="15%" align="right">代码</td>
					<td width="35%" align="left"><input type="text" size="20" name="ap_code" maxlength="150" value="<%=ap_code%>" <%=Isactivity%>>
					<td width="15%" align="right">图片链接形式</td>
					<td width="35%" align="left"><%=fstrSelect%><td>
					</td>
				</tr>

				<tr class="line-even" >
					<td width="15%" align="right">图片链接宽度</td>
					<td width="35%" align="left"><input type="text" size="20" name="ap_width" maxlength="150" value="<%=ap_width%>" <%=Isactivity%>></td>
					<td width="15%" align="right">图片链接高度</td>
					<td width="35%" align="left"><input type="text" size="20" name="ap_height" maxlength="150" value="<%=ap_height%>" <%=Isactivity%>></td>
				</tr>

				<tr class="line-odd" >
					<td width="15%" align="right">备注</td>
					<td width="85%" colspan="3" align="left"><textarea name="ap_memo" cols="78" rows="7" <%=Isactivity%>><%=ap_memo%></textarea></td>
				</tr>

				<tr class="line-even" >
					<td width="15%" align="right">是否为默认显示</td>
					<td width="85%" colspan="3" align="left"><input type="radio" name="ap_display" value="0" <%if(ap_display.equals("0")||ap_display.equals("")) out.println("checked");%> onclick="javascript:Isdisplay(this.value);">&nbsp;否&nbsp;&nbsp;<input type="radio" name="ap_display" value="1" onclick="javascript:Isdisplay(this.value);" <%if(ap_display.equals("1")) out.println("checked");%>>&nbsp;是</td>
				</tr>

				<tr class="line-odd" id="mytr" style="display:<%=trdis%>">
					<td width="15%" align="right">默认图片链接类型</td>
					<td width="85%" colspan="3" align="left"><%=tstrSelect%><td>
				</tr>
				
				<tr class="line-even" id="mytr" style="display:<%=trdis%>">
					<td width="15%" align="right">上传默认文件</td>
					<td width="85%" colspan="3" align="left">
					<%
					if(ap_filename.equals(""))
					{
						out.println("<input type=\"file\" name=\"ap_file\" size=\"40\">");
					}
					else
					{
						out.println("&nbsp;<a href=\"#\">"+ap_filename+"</a>&nbsp;&nbsp;<img src=\"../../images/delete.gif\" onclick=\"javascript:delfile();\" style=\"cursor:hand\" alt=\"删除文件\">");
					}
					%>
					</td>
				</tr>
			    <tr class="line-odd">
			        <td align="right">选择维护用户：</td>
			        <td align="left">
			        	<input type="text" onclick="chooseTree('user');" name="user" value="<%=ui_name%>" treeType="Dept" treeTitle="选择维护用户" isSupportMultiSelect="1" isSupportFile="1" isSupportDirSelect="0"> 
						<input type=button title="选择维护用户" onclick="chooseTree('user');" class="bttn" value=选择...>
						<input type="hidden" name="userDirIds" value>
						<input type="hidden" name="userFileIds" value="<%=ur_id%>">
			        </td>
		        </tr>

				<tr height="30" class="line-even">
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
						<input type="button" class="bttn" name="del" value="删 除" onclick="javascript:delinfo(<%=ap_id%>);">&nbsp;
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
				<INPUT TYPE="hidden" name="ap_id" value="<%=ap_id%>">
				<INPUT TYPE="hidden" name="OPType" value="<%=OPType%>">
				<INPUT TYPE="hidden" name="file_name" value="<%=ap_filename%>">
				<INPUT TYPE="hidden" name="ap_filepath" value="<%=ap_filepath%>">
			</table>
		</td>
	</tr>

</form>
<form name="formData1" method="post" >
<INPUT TYPE="hidden" name="ap_id1" value="<%=ap_id%>">
<INPUT TYPE="hidden" name="OPType1" value="<%=OPType%>">
<INPUT TYPE="hidden" name="ap_filename1" value="<%=ap_filename%>">
<INPUT TYPE="hidden" name="ap_filepath1" value="<%=ap_filepath%>">
</form>
</table>
<!-- 主体结束 -->
<%
//关闭连接
dImpl.closeStmt();
dCn.closeCn();
%>
<%@include file="../skin/bottom.jsp"%>

