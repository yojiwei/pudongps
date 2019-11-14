<%@page contentType="text/html; charset=GBK"%>
<%@include file="../../manage/head.jsp"%>

<script LANGUAGE="javascript" src="./common/common.js"></script>
<script type="text/javascript" src="editor/fckeditor.js"></script>

<%
String sj_id ="-2046";
String ct_inserttime ="";
String ct_title ="";
String th_id = CTools.dealString(request.getParameter("th_id"));
String ctContent ="";
String ctImgpath = "";
String filePath = "";	
String  sqlstr ="";
Hashtable content =null;
Vector vPage = null;
CMySelf mySelf = (CMySelf)session.getAttribute("mySelf");
String ct_id = CTools.dealString(request.getParameter("ct_id"));
String OPType = CTools.dealString(request.getParameter("OPType")).trim(); 
String th_powercode = CTools.dealString(request.getParameter("th_powercode")).trim();
 //out.print("th_powercode:"+th_powercode);
CDataCn dCn = null;
CDataImpl dImpl = null;
try{
dCn = new CDataCn();
dImpl = new CDataImpl(dCn);


if (OPType.equals("Edit")){
	sqlstr ="select c.*,ct_content from tb_content c,tb_contentdetail d where d.ct_id=c.ct_id and c.ct_id="+ct_id;
	content=dImpl.getDataInfo(sqlstr);
	if (content!=null){
		ct_id = content.get("ct_id").toString();
		sj_id = content.get("sj_id").toString();
		ctContent = content.get("ct_content").toString();
		ct_title = content.get("ct_title").toString();		
		ct_inserttime = content.get("ct_inserttime").toString();
		filePath = content.get("ct_filepath").toString();
		ctImgpath = content.get("ct_img_path").toString();
		if(!ctImgpath.equals("")) session.setAttribute("temppath",ctImgpath);
	}
}
%>

<html>
<head>
<link href="../style.css" rel="stylesheet" type="text/css">
</head>
<body>

<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title>上海浦东门户网站后台管理系统</title>
<style type="text/css">
<!--
@import url("/system/app/skin/skin3/images/main.css");
-->
</style>
<link href="/system/app/skin/skin3/images/style.css" rel="stylesheet" type="text/css">
<html>
<head>
<meta http-equiv="pragma" content="no-cache">
<link href="../style.css" rel="stylesheet" type="text/css">
<title></title>
<script LANGUAGE="javascript" src="/system/common/treeview/chooseTreeJs.jsp"></script>

<html>
	<head>
		<title>JSP for formData form</title>
	</head>
	<body>
		<form name="formData" action="addpersonresult.jsp" method="post" enctype="multipart/form-data"  >
		<table class="main-table" width="100%">
		<tr class="title1" align=center>
	      	<td></td>
	    </tr>
	    <tr>
	     	<td width="100%">
	     		<table width="100%"  height="1">
				 <tr class="line-even" >
			            <td width="19%" align="right">候选人：</td>
			            <td width="81%" ><input type="text" name="ct_title" value="<%=ct_title%>"  class="text-line" size="80"/><font color="#FF0000">*</font>
			            </td>
		          </tr>					 
				  <tr class="line-odd" >
					<td width="19%" align="right">录入时间：</td>
					<td width="81%" >
					  &nbsp;<%= ct_inserttime.equals("")?new CDate().getThisday():ct_inserttime%>
					  <input type="hidden" name="ct_inserttime" class="text-line" value="<%= ct_inserttime.equals("")?new CDate().getThisday():ct_inserttime%>">
					</td>
				  </tr>
				    <tr class="line-even" >
			            <td width="19%" align="right">投票分类：</td>
			            <td width="81%" >
						<select name="th_powercode1">
						<option value="">请选择类别</option>
	<%
              sqlstr = "select vd.vd_value,vd.vd_code from tb_votetypedata vd ,tb_votetype ty where ty.ty_id=vd.ty_id and ty.ty_code='"+th_powercode+"'";
						vPage = dImpl.splitPage(sqlstr,request,25);
		              if(vPage!=null){							
			for(int i=0; i<vPage.size(); i++){
				content = (Hashtable)vPage.get(i);
				String fs_name= content.get("vd_value").toString() ;
				String fs_code = content.get("vd_code").toString() ;
	 %>
						<option value="<%=fs_code%>"><%=fs_name%></option>
						<%}}%>
						</select>
			            </td>
						</tr>
                      
			       <tr class="line-even">
				            <td align="left" height="20" colspan=2>
                <textarea id="content" name="CT_content" style="display:none;WIDTH: 100%; HEIGHT: 400px"><%=ctContent%></textarea>
		<IFRAME ID="eWebEditor1" src="/system/common/edit/eWebEditor.jsp?id=CT_content&style=standard" frameborder="0" scrolling="no" width="100%" height="400"></IFRAME>

       <script type="text/javascript" for=window event=onload>
       	eWebEditor1.setHTML(document.all.CT_content.value);
       </script>
							 </td>
          			</tr>
          			<tr class="odd">
					   <td width="100%" colspan="4">
							<hr style='border-top-style: dotted; border-top-width: 1; border-bottom-style: dotted; border-bottom-width: 1' size=0 noshade color=#000000>
							§<a onclick="vbscript:AddAttach1()" style="cursor:hand">上传信息附件</a><br>以下是已上传的附件：
							<%
							 if (!filePath.equals(""))
							 {
								out.println("<hr style='border-top-style: dotted; border-top-width: 1; border-bottom-style: dotted; border-bottom-width: 1' size=0 noshade color=#000000>");
								String ia_id = "";
								String ia_name = "";
								String ia_path = "";
								String fileName = "";

								String sql_ia = "select im_id,im_name,im_path,im_filename from tb_image where ct_id="+ct_id;
								//out.println(sql_ia);
								Vector vPage_ia = dImpl.splitPage(sql_ia,100,1);
								if (vPage_ia!=null)
								{
									for(int n=0;n<vPage_ia.size();n++)
									{
										Hashtable content_ia = (Hashtable)vPage_ia.get(n);
										ia_id = content_ia.get("im_id").toString();
										ia_name = content_ia.get("im_name").toString();
										ia_path = content_ia.get("im_path").toString();
										fileName = content_ia.get("im_filename").toString();
										int imgflag = 0;
										%>
										<p align="left">文件名称：&nbsp;&nbsp;&nbsp;&nbsp;<a href="download.jsp?ia_id=<%=ia_id%>"><%if(!ia_name.equals("")) {out.println(ia_name);} else{out.println(fileName);}%></a>&nbsp;&nbsp;
										<img SRC="../images/dialog/delete.gif" onclick="javascript:deleteFile('<%=fileName%>');" title='删除该文件'style="cursor:hand">
										</p>
										<%
									}
								}
							 }
				 			%>
					   </td>
					</tr>

					<tr>
						<td class="row" id="TdInfo1" width="100%" colspan="4">
							<hr style='border-top-style: dotted; border-top-width: 1; border-bottom-style: dotted; border-bottom-width: 1' size=0 noshade color=#000000>
						</td>
					</tr>
					</tr>
			          <tr class="line-even">
				            <td align="center" height="20" colspan=2>

				            <input type="button" name="提交" class="bttn" onclick="checkform()" value="提交">
				            <input type="reset" value="重置" class="bttn" />
				            <input type="button" value="返回" class="bttn" onclick="javascript:history.go(-1);">
				            </td>
          			</tr>
					</table>
				</td>
			</tr>
		</table>
		<input type="hidden" name="infoStatus"/>
		<INPUT type="hidden" name="ctImgpath" value="<%=ctImgpath%>"/>
		<INPUT type="hidden" name="filePath" value="<%=filePath%>"/>		
		<INPUT type="hidden" name="ct_id" value="<%=ct_id%>">
		<INPUT type="hidden" name="sj_id" value="<%=sj_id%>">
		<INPUT type="hidden" name="th_id" value="<%=th_id%>">
		<INPUT type="hidden" name="OPType" value="<%=OPType%>">
		<INPUT type="hidden" name="oldth_powercode" value="<%=th_powercode%>">
		</form>

	</body>
</html>
<script language='javascript'>
	//setHtml();
	function deleteFile(fileName)
{
	if(confirm("确认要删除该文件吗？"))
	{
		var obj = formData.ctId;
		var url = "attachDel.jsp?fileName="+fileName;
		url += "&in_id="+obj.value;
		window.location = url;
	}
}
</script>
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
str1 = str1 & "<input type='file' name='file1' size=30 class='text-line' id=file' >"
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