<%@page contentType="text/html; charset=GBK"%>
<%@include file="/system/app/skin/head.jsp"%>
<%@page import="com.util.*"%>
<%@page import="java.util.*"%>
<%@page import="vote.*"%>

<%
//update20080122

CDataCn dCn=null;   //新建数据库连接对象
CDataImpl dImpl=null;  //新建数据接口对象

try {
 dCn = new CDataCn(); 
 dImpl = new CDataImpl(dCn); 
String upperid = "";
String strTitle = "";//抬头标题
//修改用的信息
String vt_id = "";
String vt_name = "";
String vt_upperid = "";
String vt_type = "";
String vt_sequence = "0";
String vt_desc = "";
String vt_parameter = "";
String OType = "";
String treeid = "";

String vde_img="";//IM_ID
String vde_starttime = "";//开始时间
String vde_finishtime= "";//结束时间
String vde_type = "";//是否为问卷
String vde_sort= "";//结束时间
String Typepp="";


SimpleDateFormat s=new SimpleDateFormat("yyyy-MM-dd");
treeid = CTools.dealString(request.getParameter("treeid")).trim();
OType = CTools.dealString(request.getParameter("OType")).trim();
upperid = CTools.dealString(request.getParameter("upperid")).trim();
vt_id = CTools.dealString(request.getParameter("editid")).trim();
Typepp = CTools.dealString(request.getParameter("Typepp")).trim();
if(OType.equals(""))OType = "Add";
if(upperid.equals(""))
	upperid = "0";

if(OType.equals("Add"))
	strTitle = "[新增]";
else if(OType.equals("Edit"))
	strTitle = "[修改]";

String vde_status="";

vde_status = CTools.dealString(request.getParameter("vde_status")).trim();

String tempupperid = upperid;
while(!tempupperid.equals("0"))//得到根节点的id
{
	String sqlStr = "select * from tb_votediy where vt_id= " + tempupperid+"";
	Hashtable content=dImpl.getDataInfo(sqlStr);
	if(!content.get("vt_name").toString().equals(""))
		strTitle = "<a href='list.jsp?upperid="+content.get("vt_id").toString()+"&uppername="+content.get("vt_name").toString()+"'>" + content.get("vt_name").toString() + "</a> - " + strTitle;
	if(content.get("vt_name").toString().equals(""))
		strTitle = "[<a href='list.jsp?upperid="+content.get("vt_id").toString()+"&uppername="+content.get("vt_name").toString()+"'>空</a>] - " + strTitle;
	tempupperid = content.get("vt_upperid").toString();
}
strTitle = "<a href=list.jsp?upperid=0&vde_status="+vde_status+">投票列表</a> - " + strTitle;

String sqlStr = "select * from tb_votediy where vt_upperid = "+upperid+" order by vt_sequence";
Vector vPage = dImpl.splitPage(sqlStr,request,10000);
%>
<form method='post' name='formData'>
 <table class="main-table" width="100%">
 <tr>
  <td width="100%">
       <table class="content-table" width="100%">
                <tr class="title1">
                        <td colspan="8" align="center">
                                <table WIDTH="100%" BORDER="0" CELLSPACING="1" CELLPADDING="1">
                                        <tr>
                                                <td valign="center"><%=strTitle%></td>
                                                <td valign="center" align="right" nowrap>


                                                        <img src="../../../images/split.gif" align="middle" border="0" WIDTH="5" HEIGHT="8">
                                                        <img src="../../../images/goback.gif" border="0" onclick="javascript:history.back();" title="返回" style="cursor:hand" align="absmiddle">

                                                        <img src="../../../images/split.gif" align="middle" border="0" WIDTH="5" HEIGHT="8">
                                                </td>
                                        </tr>
                                </table>
                        </td>
                </tr>

<%
if(OType.equals("Edit"))
{
	String sqlStr_editid="";
	if(Typepp.equals("2")){
	sqlStr_editid="select * from tb_votediy where vt_id="+vt_id+"";
	}
	else{
	 sqlStr_editid = "select * from tb_votediy,tb_votediyext where tb_votediy.vt_id=tb_votediyext.vt_id AND tb_votediy.vt_id="+vt_id+"";
	}
	Hashtable content_editid=dImpl.getDataInfo(sqlStr_editid);
	vt_name = content_editid.get("vt_name").toString();
	vt_upperid = content_editid.get("vt_upperid").toString();
	vt_type = content_editid.get("vt_type").toString();
	vt_sequence = content_editid.get("vt_sequence").toString();
	vt_desc = content_editid.get("vt_desc").toString();
	vt_parameter = content_editid.get("vt_parameter").toString();
	if(!Typepp.equals("2")){
	vde_starttime = s.format(content_editid.get("vde_starttime"));
	vde_finishtime= s.format(content_editid.get("vde_finishtime"));
        vde_type=CTools.dealNull(content_editid.get("vde_type"),"0");
	vde_sort=CTools.dealNull(content_editid.get("vt_sort"),"0");
	vde_img=content_editid.get("vde_flowimgpath").toString();
	}
}

out.print("<tr class='line-even'>");
out.print("<td align='right' width='16%'>题目：</td>");
out.print("<td align='left'><input type='text' name='vt_name' size='80' value='"+vt_name+"' class='text-line'></td>");
out.print("</tr>");
if(!upperid.equals("0"))//不是根节点
{
	out.print("<tr class='line-odd'>");
	out.print("<td align='right'>上级栏目：</td>");
	out.print("<td align='left'>");
	String tempupperid_showvote = upperid;
	String tempid_showvote = "";//根节点的id
	String tempid_showvotename = "";//根节点的name
	while(!tempupperid_showvote.equals("0"))//得到根节点的id和name
	{
		String sqlStr_showvote = "select * from tb_votediy where vt_id= " + tempupperid_showvote +"";
		Hashtable content_showvote=dImpl.getDataInfo(sqlStr_showvote);
		tempid_showvote = content_showvote.get("vt_id").toString();
		tempid_showvotename = content_showvote.get("vt_name").toString();
		tempupperid_showvote = content_showvote.get("vt_upperid").toString();
	}
	if(!tempid_showvote.equals(""))
	{
		out.print("<select name='vt_upperid' class='select-a'>");
		if(upperid.equals(tempid_showvote)) out.print("<option value='"+tempid_showvote+"' selected>"+tempid_showvotename+"</option>");
		else out.print("<option value='"+tempid_showvote+"'>"+tempid_showvotename+"</option>");//显示根节点
		Vote vote = new Vote();
		vote.getVoteTitle(tempid_showvote);//得到投票树，写入Vector中
		Vector votetitle = vote.RetuenVectorVoteTitle();//得到投票树
		if(votetitle!=null)
		{
			for(int i=0 ; i<votetitle.size() ; i++)
			{
				VoteStruct votestruct = new VoteStruct();
				votestruct = (VoteStruct) votetitle.get(i);
				if(OType.equals("Edit"))//如果是修改，不显示正在修改的节点和其下的节点
				{
					String tempupperid_showvote_sub = String.valueOf(votestruct.getId());
					while(!tempupperid_showvote_sub.equals(vt_id) && !tempupperid_showvote_sub.equals("0"))
					{
						String sqlStr_showvote_sub = "select * from tb_votediy where vt_id= " + tempupperid_showvote_sub +"";
						Hashtable content_showvote_sub=dImpl.getDataInfo(sqlStr_showvote_sub);
						tempupperid_showvote_sub = content_showvote_sub.get("vt_upperid").toString();
					}
					if(tempupperid_showvote_sub.equals("0"))
					{
						if(votestruct.getId() == Integer.parseInt(upperid))
							out.print("<option value='"+votestruct.getId()+"' selected>");
						else
							out.print("<option value='"+votestruct.getId()+"'>");
						for(int j=0 ; j<votestruct.getLevel() ; j++)
							out.print("&nbsp;");
						out.print(votestruct.getName());
						out.print("</option>");
					}
				}
				if(OType.equals("Add"))//如果是添加，显示全部
				{
					if(votestruct.getId() == Integer.parseInt(upperid))
						out.print("<option value='"+votestruct.getId()+"' selected>");
					else
						out.print("<option value='"+votestruct.getId()+"'>");
					for(int j=0 ; j<votestruct.getLevel() ; j++)
						out.print("&nbsp;");
					out.print(votestruct.getName());
					out.print("</option>");
				}
			}
		}
		out.print("</select>");
	}
	out.print("</td>");
	out.print("</tr>");
}
if(!upperid.equals("0"))
{
	out.print("<tr class='line-odd'>");
	out.print("<td align='right'>类型：</td>");
	out.print("<td align='left'>");
	out.print("<select name='vt_type' class='select-a' onchange=\"javascript:typechang1(this.value)\">");
	if(vt_type.equals("title")) out.print("<option value='title' selected>标题</option>"); else out.print("<option value='title'>标题</option>");
	if(vt_type.equals("checkbox")) out.print("<option value='checkbox' selected>复选框</option>"); else out.print("<option value='checkbox'>复选框</option>");
	if(vt_type.equals("radio")) out.print("<option value='radio' selected>单选框</option>"); else out.print("<option value='radio'>单选框</option>");
	if(vt_type.equals("text")) out.print("<option value='text' selected>文本框</option>"); else out.print("<option value='text'>文本框</option>");
	if(vt_type.equals("textarea")) out.print("<option value='textarea' selected>文本区</option>"); else out.print("<option value='textarea'>文本区</option>");
	out.print("</select>");
	out.print("</td>");
	out.print("</tr>");
	if(vt_type.equals("text"))
	{
		String vt_parameter_1 = "";
		String vt_parameter_2 = "";
		String temp[]  = vt_parameter.split(",");
		for(int n=0 ; n<temp.length ; n++)
		{
			if(n==0)
				vt_parameter_1 = temp[0];
			if(n==1)
				vt_parameter_2 = temp[1];
		}
		out.print("<tr class='line-odd' id='type1' style='display:'>");
		out.print("<td align='right'>参数：</td>");
		out.print("<td align='left'>");
		out.print("宽度<input type='text' name='vt_parameter_text_1' size='3' value='"+vt_parameter_1+"' class='text-line'> ");
		out.print("最大字符数<input type='text' name='vt_parameter_text_2' size='3' value='"+vt_parameter_2+"' class='text-line'> ");
		out.print("</td>");
		out.print("</tr>");
	}
	else
	{
		out.print("<tr class='line-odd' id='type1' style='display:none'>");
		out.print("<td align='right'>参数：</td>");
		out.print("<td align='left'>");
		out.print("宽度<input type='text' name='vt_parameter_text_1' size='3' value='' class='text-line'> ");
		out.print("最大字符数<input type='text' name='vt_parameter_text_2' size='3' value='' class='text-line'> ");
		out.print("</td>");
		out.print("</tr>");
	}

	if(vt_type.equals("textarea"))
	{
		String vt_parameter_1 = "";
		String vt_parameter_2 = "";
		String temp[]  = vt_parameter.split(",");
		for(int n=0 ; n<temp.length ; n++)
		{
			if(n==0)
				vt_parameter_1 = temp[0];
			if(n==1)
				vt_parameter_2 = temp[1];
		}
		out.print("<tr class='line-odd' id='type2' style='display:'>");
		out.print("<td align='right'>参数：</td>");
		out.print("<td align='left'>");
		out.print("宽度<input type='text' name='vt_parameter_textarea_1' size='3' value='"+vt_parameter_1+"' class='text-line'> ");
		out.print("行数<input type='text' name='vt_parameter_textarea_2' size='3' value='"+vt_parameter_2+"' class='text-line'> ");
		out.print("</td>");
		out.print("</tr>");
	}
	else
	{
		out.print("<tr class='line-odd' id='type2' style='display:none'>");
		out.print("<td align='right'>参数：</td>");
		out.print("<td align='left'>");
		out.print("宽度<input type='text' name='vt_parameter_textarea_1' size='3' value='' class='text-line'> ");
		out.print("行数<input type='text' name='vt_parameter_textarea_2' size='3' value='' class='text-line'> ");
		out.print("</td>");
		out.print("</tr>");
	}
}
else
{
	out.print("<input type='hidden' name='vt_type' value='title'>");
}
out.print("<tr class='line-odd'>");
out.print("<td align='right'>排序：</td>");
out.print("<td align='left'><input type='text' name='vt_sequence' size='3' value='"+vt_sequence+"' class='text-line'></td>");
out.print("</tr>");
if(upperid.equals("0"))//根节点
{
	%>
	<tr class="line-odd">
		<td align='right' width='16%'>发布时间</td><td align='left'><input type="text" name="vde_starttime"  value="<%=vde_starttime%>" onclick="javascript:showCal()" class=text-line style="cursor:hand" readonly ></td>
	  </tr>
	<tr class="line-odd">
		<td align='right' width='16%'>结束时间</td><td align='left'><input type="text" name="vde_finishtime"  value="<%=vde_finishtime%>" onclick="javascript:showCal()" class=text-line style="cursor:hand" readonly ></td>
	  </tr>
	  <tr class="line-odd">
		<td align='right' width='16%'>是否为问卷</td><td align='left'>
		<select name="vde_type" class=text-line >
		<option value="0"	<%if(vde_type.equals("0"))out.print("selected");%>>否</option>
		<option value="1"	<%if(vde_type.equals("1"))out.print("selected");%>>是</option>
		</select>

		</td>
   </tr>
   <tr class="line-odd">
		<td align='right' width='16%'>链接网址</td><td align='left'>
		<input type="text" name="link" size="50">
		</td>
   </tr>
   <tr class="line-odd">
         <td align='right' width='16%'>问卷类型</td><td align='left'>
         <select name="vde_sort" class=text-line >
         <option value="0"	<%if(vde_sort.equals("0"))out.print("selected");%>>网上评议</option>
         <option value="1"	<%if(vde_sort.equals("1"))out.print("selected");%>>网上调查</option>
		 <option value="2"	<%if(vde_sort.equals("2"))out.print("selected");%>>市民中心</option>
         </select>

         </td>
	  </tr>
	<tr class="line-odd">
		<td align="center" height="1" colspan="2">投票简介</td>
	</tr>

	<tr class="line-even">
		<td align="left" height="20" colspan=2> <iframe id="desc" style="HEIGHT: 400px; TOP: 5px; WIDTH: 100%" src="/system/common/editor/editor.htm"></iframe>
		  <textarea id="vt_desc" name="vt_desc" style="display:none"><%=vt_desc%></textarea>
		</td>
	</tr>
		</tr>
			<tr>
	   <td colspan="9" id='imgfas'>
	<input type='hidden' name='vde_img'value='<%=vde_img%>'>
		§<a onclick="javaScript:openImgWindow()" style="cursor:hand">上传图片</a>§（提示：限制上传.exe、.bat、.jsp类型的文件！）<br>
	   </td>
	</tr>
	<%
}
%>


<tr class="title1" width="100%" id="btnObj" style="display:">
<td colspan='2' algin='center'>
<input type='hidden' name='vt_id' value='<%=vt_id%>'>
<%if(upperid.equals("0")){%><input type='hidden' name='vt_upperid' value='0'><%}%>


<input type='hidden' name='OType' value='<%=OType%>'>
<input type='hidden' name='treeid' value='<%=treeid%>'>
<%if ("".equals(upperid) || "0".equals(upperid)) {%>
	<input type="button" name="btnSubmit" value="确定" onclick="checkForm(<%=vde_status%>)" class="bttn">&nbsp;
<%}else{%>
	<input type="button" name="btnSubmit" value="确定" onclick="chkTitle(<%=vde_status%>)" class="bttn">&nbsp;<%}
if(OType.equals("Edit")) { %>
<%
	if(!Typepp.equals("2")){ 
		if(vde_status.equals("0")){ 	
			%>
	<input type=button name="btnType" value="发布" onclick="checkFtype(0)" class=bttn>&nbsp;<% 	}
	   else if(vde_status.equals("1")){     
	%>
	<input type=button name="btnType" value="暂存" onclick="checkFtype(1)" class=bttn>&nbsp;
<%}
	} 	%><input type='hidden' name='vde_status'value='<%=vde_status%>'><input type='hidden' name='type' value='<%=vt_type%>'><input type='hidden' name='a' value='0'><%
	if(!Typepp.equals("2")){%>
<input type="button" name="btnDel"  value="删除" class="bttn" onclick="deleteThis(<%=vde_status%>)">&nbsp;
<%
}
}
%>
<input type="button" name="btnReturn" value="返回" onclick="javascript:window.history.go(-1);" class="bttn">
</td></tr>
	<tr width="100%" id="confirmObj" style="display:none">
		<td colspan="2">
			<font color="red">您的请求已提交，正在执行操作，请稍候。</font>
		</td>
	</tr>
<%
dImpl.closeStmt();
dCn.closeCn();
%>
<script language="javascript">

// function openImgWindow(){
//		fjTble.style.display="block";
//		imgfas.style.display="none";
//		document.all.value="1";
// }
//  function openImgWindow1(){
//		fjTble.style.display="none";
//		imgfas.style.display="block";
//		document.all.value="0";
// }




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

	var retVal = showModalDialog( "../../../common/calendar/calendar.htm", obDate,
		"dialogWidth=206px; dialogHeight=206px; help=no; scroll=no; status=no; " );

	if ( typeof(retVal) != "undefined" ) {
		var year = retVal.getFullYear();
		var month = retVal.getMonth()+1;
		var day = retVal.getDate();
		obj.value =year + "-" + month + "-" + day;
	}
}









function openImgWindow()
{
	  var w = 400;
	  var h = 500;
	  var url = "";
	  url = "ExplainInfoImg.jsp";
	  var vde_img = document.formData.vde_img.value;
	  url = url+"?vde_img="+vde_img+"&vde_pp=a";
	  window.open( url, "upload", "Top=0px,Left=0px,Width="+w+"px, Height="+h+"px,toolbar=no,location=no,derectories=no,status=no,menubar=no,scrollbars=yes" );
}




//判断必填项
function chkText() {
	if (formData.vt_name.value == "") {
		alert("请输入题目！");
		formData.vt_name.focus();
		return false;
	}
	if (formData.vde_starttime.value == "") {
		alert("请输入发布时间！");
		formData.vde_starttime.focus();
		return false;
	}
	if (formData.vde_finishtime.value == "") {
		alert("请输入结束时间！");
		formData.vde_finishtime.focus();
		return false;
	}
	return true;
}



//内容判断
function chkTitle(vde_status) {
	if (formData.vt_name.value == "") {
		alert("请输入题目！");
		formData.vt_name.focus();
		return false;
	}
	btnObj.style.display="none";
	confirmObj.style.display="";
	formData.action = "result.jsp?vde_status="+vde_status;
	formData.submit();
}

function deleteThis(val1)
{
	  if(confirm("确实要删除吗？"))
	  {
			formData.action = "state.jsp?del=1&vde_status="+val1;
			formData.submit();
	  }
}
function checkForm(vde_status)
{
	if (chkText() == false) return false;
	<%if(upperid.equals("0")) out.print("GetDatadesc();");%>
	btnObj.style.display="none";
	confirmObj.style.display="";
	formData.action = "result.jsp?vde_status="+vde_status;
	formData.submit();
}
function checkFtype(a){
	if (chkText() == false) return false;
	btnObj.style.display="none";
	confirmObj.style.display="";
	formData.action = "state.jsp?state="+a+"&del=0";
	formData.submit();
}

function typechang1(obj1)
{
	if(obj1=="title")
	{
		document.all.type1.style.display="none";
		document.all.type2.style.display="none";
	}
	if(obj1=="checkbox")
	{
		document.all.type1.style.display="none";
		document.all.type2.style.display="none";
	}
	if(obj1=="radio")
	{
		document.all.type1.style.display="none";
		document.all.type2.style.display="none";
	}
	if(obj1=="text")
	{
		document.all.type1.style.display="block";
		document.all.type2.style.display="none";
	}
	if(obj1=="textarea")
	{
		document.all.type1.style.display="none";
		document.all.type2.style.display="block";
	}
}
</script>
<%if(upperid.equals("0")){%>
<script language="javascript">
function setHtml()
{
  desc.setHTML(formData.vt_desc.value);
}
function GetDatadesc()
{
	var re = "/<"+"script.*.script"+">/ig";
	var re2 = /(src=\")(http|https|ftp):(\/\/|\\\\)(.[^\/|\\]*)(\/|\\)/ig;
	var reHttp = /(href=\")(http|https|ftp):(\/\/|\\\\)(<%//=WEBSITE_ADDRESS%>)(\/|\\)/ig; //去掉链接地址
	var Html=desc.getHTML();
	Html = Html.replace(re,"");
	Html = Html.replace(re2,"src=\"/");
	Html = Html.replace(reHttp,"href=\"\/");
	formData.vt_desc.value=Html;
}
</script>
<script language="javascript" for=window event=onload>
setHtml();
</script>
<%}%>
</table>
  </td>
</tr>
</table>
</form>
</html>

<%@include file="/system/app/skin/bottom.jsp"%>
<%


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
