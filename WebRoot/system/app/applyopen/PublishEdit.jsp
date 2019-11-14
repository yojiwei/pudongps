<%@page contentType="text/html; charset=GBK"%>
<%@ page import="java.sql.ResultSet" %>
<%@include file="../../manage/head.jsp"%>
<script LANGUAGE="javascript" src="../infopublish/common/common.js"></script>
<script type="text/javascript" src="../infopublish/editor/fckeditor.js"></script>
<%
String ctTitle = "";
String ctKeywords = "";
String ctUrl = "";
String ctSource = "";
String ctCreateTime = new CDate().getThisday();
String ctFileFlag = "0";
String sjId = "";
String sjName = "";
String ctFocusFlag = "";
String ctInsertTime = new CDate().getThisday();
String ctBrowseNum = "";
String ctFeedbackFlag = "";
String ctContent = "";
String ctImgpath = "";
String filePath = "";
String sj_id = "";
String Module_name = "";
String tc_memo="";
String chkIDs="";
String checkStatus="0";
String tcSenderId="";
String cpCommend = "";
String ctEndTime = "";

Hashtable contentSJ = null;
Hashtable content = null;

String IN_INFOTYPE="",IN_MEDIATYPE="",IN_DESCRIPTION="",IN_CATEGORY="",IN_CATCHNUM="",IN_FILENUM="",ct_contentflag="";

CMySelf mySelf = (CMySelf)session.getAttribute("mySelf");
String urID = String.valueOf(mySelf.getMyID());
String dtID = String.valueOf(mySelf.getDtId());


//update20080122

CDataCn dCn=null;   //新建数据库连接对象
CDataImpl dImpl=null;  //新建数据接口对象

try {
 dCn = new CDataCn(); 
 dImpl = new CDataImpl(dCn); 

String iid = "";//申请表信息
iid = CTools.dealString(request.getParameter("iid"));

if(!iid.equals("")){
	String sqlStr1 = "select * from infoopen where id = " + iid;
	Hashtable content1 = dImpl.getDataInfo(sqlStr1);
	if(content1!=null){
		ctTitle = content1.get("infotitle").toString();
		ctTitle = content1.get("infotitle").toString();
		IN_DESCRIPTION = content1.get("commentinfo").toString();
	}
}
%>

<html>
<style type="text/css">
<!--
@import url("/system/app/skin/skin3/images/main.css");
-->
</style>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title>上海浦东门户网站后台管理系统</title>
<meta http-equiv="pragma" content="no-cache">
<link href="../style.css" rel="stylesheet" type="text/css">
<link href="/system/app/skin/skin3/images/style.css" rel="stylesheet" type="text/css">
</head>
<script LANGUAGE="javascript" src="/system/common/treeview/chooseTreeJs.jsp"></script>
<script language=javascript>
function checkFrm(flag){
	document.formData.returnPage.value=flag;
}
function showDiv(flag){
	var obj=document.getElementsByName('infoOpen');
	for(var i=0;i<obj.length;i++){
		obj[i].style.display=flag;
	}
}
</script>

<body  style="overflow-x:hidden;overflow-y:auto" topmargin="0" leftmargin="0">
<form name="formData" action="publishResult.jsp" method="post" enctype="multipart/form-data" >
	<table class="main-table" width="100%">
		<tr class="title1" align=center>
			<td>信息发布</td>
		</tr>
		<tr>
			<td width="100%">
				<table width="100%"  height="1">
					<tr class="line-even" >
						<td width="19%" align="right">主题：</td>
						<td width="81%" align='left'><input type="text" name="ctTitle"  class="text-line" size="40" value="<%=ctTitle%>" maxlength="100"/>&nbsp;&nbsp;特别提醒：<input type="checkbox" name="ctFocusFlag" class="text-line" value="1" <%if(ctFocusFlag.equals("1")) out.println("checked");%>/></td>
					</tr>
					<tr class="line-even" >
						<td width="19%" align="right">关键字：</td>
						<td width="81%" ><input type="text" name="ctKeywords" class="text-line" size="40" value="<%=ctKeywords%>" maxlength="100"/></td>
					</tr>

					<tr class="line-even" >
						<td width="19%" align="right">链接地址：</td>
						<td width="81%" align='left'><input type="text" name="ctUrl" class="text-line"  size="40" value="<%=ctUrl%>" maxlength="100"/></td>
					</tr>

					<tr class="line-even" >
						<td width="19%" align="right">来源：</td>
						<td width="81%" align='left'><input type="text" name="ctSource" class="text-line" size="40" value="<%=ctSource%>" maxlength="100"/></td>
					</tr>

					<tr class="line-even" >
						<td width="19%" align="right">发布时间：</td>
						<td width="81%" align='left'><input type="text" name="ctCreateTime" class="text-line" value="<%=ctCreateTime%>" readonly="true" onclick="javascript:showCal()" style="cursor:hand"/>
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;结束时间：<input type="text" name="ctEndTime" class="text-line" value="<%=ctEndTime%>" readonly="true" onclick="javascript:showCal()" style="cursor:hand"/></td>
					</tr>

					<tr class="line-even" >
						<td width="19%" align="right">发布形式：</td>
						<td width="81%" align='left'><input type="radio" name="ctFileFlag" value="0" <%if(ctFileFlag.equals("0")) out.println("checked");%>/>内容<input type="radio" name="ctFileFlag" value="1" <%if(ctFileFlag.equals("1")) out.println("checked");%>/>文件
						<html:errors name="ctFileFlag"/></td>
					</tr>

					<tr class="line-even" >
						<td width="19%" nowrap align="right">所属栏目：</td>
						<td width="81%" nowrap align='left'>
						<input type="hidden" name="sjId" class="text-line" style="cursor:hand" value="<%=sj_id%>" />
							<input type="hidden" name="sjName" class="text-line"  readonly="true" size="40" value="<%=Module_name%>" />
							<input type="text" size=40 name="Module" class="text-line" treeType="Subject" value="<%=Module_name%>" treeTitle="选择所属栏目" readonly isSupportMultiSelect="1" isSupportFile="0" onclick="chooseTree('Module');formData.Module.value=formData.Module.value.replace(/\x02/ig,',');">
							<input type=button  title="选择所属栏目" onclick="chooseTree('Module');formData.Module.value=formData.Module.value.replace(/\x02/ig,',');" class="bttn" value=选择...>
							<input type="hidden" name="ModuleDirIds" value="<%=sj_id%>">
							<input type="hidden" name="ModuleFileIds" value>
							<input type="hidden" name="ft_parent_id" value="<%=sj_id%>">
						</td>
					</tr>

					<tr class="line-even" >
						<td width="19%" align="right">录入时间：</td>
						<td width="81%" align='left'><input type="text" name="ctInsertTime" class="text-line" value="<%= ctInsertTime%>"  readonly="true" /></td>
					</tr>

					<tr class="line-even"  id=infoOpen style="display:" >
						<td width="19%" align="right">索取号：</td>
						<td width="81%" ><input type="text" class="text-line" size="40" name="IN_CATCHNUM" maxlength="150"  value="<%=IN_CATCHNUM%>" ></td>
					</tr>

					<tr class="line-even"  id=infoOpen style="display:">
						<td width="19%" align="right">文件编号：</td>
						<td width="81%" align='left'><input type="text" class="text-line" size="40" name="IN_FILENUM" maxlength="150"  value="<%=IN_FILENUM%>"></td>
					</tr>


					<tr class="line-even"  id=infoOpen style="display:">
						<td width="19%" align="right">公开类别：</td>
						<td width="81%" align='left'>
							<select name="IN_CATEGORY" class=select-a >
								<option value="1" <%=(IN_CATEGORY.equals("1"))?"selected":""%>>主动公开</option>
								<option value="2" <%=(IN_CATEGORY.equals("2"))?"selected":""%>>依申请公开</option>
							</select>
						</td>
					</tr>

					<tr class="line-even" id=infoOpen style="display:">
						<td width="19%" align="right" >内容描述：</td>
						<td width="81%" align='left'><input type="text" class="text-line" size="40" name="IN_DESCRIPTION" maxlength="150"  value="<%=IN_DESCRIPTION%>"></td>
					</tr>

					<tr class="line-even"  id=infoOpen style="display:">
						<td width="19%" align="right">载体类型：</td>
						<td width="81%">
							<select name="IN_MEDIATYPE" class=select-a >
								<option value="1" <%=(IN_MEDIATYPE.equals("1"))?"selected":""%>>纸质</option>
								<option value="2" <%=(IN_MEDIATYPE.equals("2"))?"selected":""%>>胶卷</option>
								<option value="3" <%=(IN_MEDIATYPE.equals("3"))?"selected":""%>>磁带</option>
								<option value="4" <%=(IN_MEDIATYPE.equals("4"))?"selected":""%>>磁盘</option>
								<option value="5" <%=(IN_MEDIATYPE.equals("5"))?"selected":""%>>光盘</option>
								<option value="6" <%=(IN_MEDIATYPE.equals("6"))?"selected":""%>>其他</option>
							</select>
						</td>
					</tr>

					<tr class="line-even"  id=infoOpen style="display:">
						<td width="19%" align="right">记录形式：</td>
						<td width="81%" align='left'>
							<select name="IN_INFOTYPE" class=select-a >
								<option value="1" <%=(IN_INFOTYPE.equals("1"))?"selected":""%>>文本</option>
								<option value="2" <%=(IN_INFOTYPE.equals("2"))?"selected":""%>>图表</option>
								<option value="3" <%=(IN_INFOTYPE.equals("3"))?"selected":""%>>照片</option>
								<option value="4" <%=(IN_INFOTYPE.equals("4"))?"selected":""%>>影像</option>
								<option value="5" <%=(IN_INFOTYPE.equals("5"))?"selected":""%>>其他</option>
							</select>
						</td>
					</tr>

					<tr class="line-even">
						<td align="left" height="20" colspan=2>
							<textarea id="content" name="CT_content" style="display:none;WIDTH: 100%; HEIGHT: 400px"><%=ctContent%></textarea>
							<IFRAME ID="eWebEditor1" src="/system/common/edit/eWebEditor.jsp?id=CT_content&style=standard" frameborder="0" scrolling="no" width="100%" height="400"></IFRAME>

							<script type="text/javascript" for=window event=onload>
							eWebEditor1.setHTML(document.all.CT_content.value);
							/*
							var oFCKeditor = new FCKeditor('CT_content') ;
							oFCKeditor.BasePath = "/system/app/infopublish/editor/" ;
							oFCKeditor.Height = 400;
							oFCKeditor.ToolbarSet = "Default" ;
							oFCKeditor.ReplaceTextarea();*/
							</script>
						</td>
					</tr>



					<tr class="odd">
						<td width="100%" colspan="4">
							<hr style='border-top-style: dotted; border-top-width: 1; border-bottom-style: dotted; border-bottom-width: 1' size=0 noshade color=#000000>
							§<a onclick="vbscript:AddAttach1()" style="cursor:hand">上传信息附件</a>
							<span  id="TdInfo1">
							<hr style='border-top-style: dotted; border-top-width: 1; border-bottom-style: dotted; border-bottom-width: 1' size=0 noshade color=#000000>
							</span>
						</td>
					</tr>

					<tr class="line-even">
						<td align="center" height="20" colspan=2>
							<input type="button" name="保存" class="bttn" onclick="checkFrm('1');return checkform(1)" value="保存">
							<input type="reset" value="重置" class="bttn" />
							<input type="button" name="关闭" value="关闭" class="bttn" onclick="javascript:window.close();">
						</td>
					</tr>
				</table>
			</td>
		</tr>
	</table>
<input type="hidden" name="publishStatus" />
<input type="hidden" name="infoStatus" value="1"/>
<input type="hidden" value="<%=tcSenderId%>" name="tcSenderId" />
<input type="hidden" name="checkPersonId" class="text-line" value="<%=Long.toString(mySelf.getMyID())%>"/>
<input type="hidden" value="<%=new CDate().getThisday()%>" name="tcTime" />
<input type="hidden" value="<%=chkIDs%>" name= chkIDs>
<INPUT type="hidden" name="ctImgpath" value="<%=ctImgpath%>"/>
<INPUT type="hidden" name="filePath" value="<%=filePath%>"/>
<INPUT type="hidden" name="dtId" value="<%=dtID%>"/>
<INPUT type="hidden" name="urId" value="<%=urID%>">
<input type="hidden" name="returnPage" value="" />
<INPUT type="hidden" name="tcStatus" value="0">
<INPUT type="hidden" name="orgSjId" value=",<%=sjId%>">
<input type="hidden" value="1" name="ct_contentflag" id="ct_contentflag2">
</form>
</body>
</html>
<script language="vbscript">
'新增附件
function AddAttach1()
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
str1 = str1 & "<input type='file' name='file1' size=30 class='text-line' id=file >"
str2="<input type='hidden' name='fjsm1'  size=30  class='text-line' maxlength=100 id='fjsm1'>"

str3="&nbsp;<img src='../images/dialog/delete.gif' class=hand onclick='vbscript:delthis1("+""""+div_obj.id+""""+")' id='button1' name='button1'>"
div_obj.innerHtml=str1 + str2 + str3
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
dImpl.closeStmt();
dCn.closeCn();
%>
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
