<%@page contentType="text/html; charset=GBK"%>
<%@include file="../../manage/head.jsp"%>
<script LANGUAGE="javascript" src="./common/common.js"></script>
<script type="text/javascript" src="editor/fckeditor.js"></script>
<script>
function deleteFile(va_id,th_id)
        {
          if(confirm("确认要删除该文件吗？"))
          {
            
            formData.action = "delattach.jsp?va_id="+va_id+"&th_id="+th_id;
			formData.submit();
          }
        }
</script>
<%
String sj_id ="-2046";
String ct_inserttime ="";
String th_title ="";
String ctContent ="";
String ctImgpath = "";
String filePath = "";	
String  sqlstr ="";
String GetTime_start = "";
String GetTimeex_start = "";

String ai_isok="";
String GetTime_end = "";
String GetTimeex_end = "";
Hashtable content =null;
String status_start = "";
String status_end = "";
String ai_start_timehx = "";
String ai_start_timeex = "";
String th_powercode = "" ;
String ai_end_timehx = "";
String ai_end_timeex = "";
String th_maxnum  ="";
String th_display = "" ;
String th_iscomment = "" ;
String th_votetype = "" ;
String th_colnum = "";
CMySelf mySelf = (CMySelf)session.getAttribute("mySelf");
String th_id = CTools.dealString(request.getParameter("th_id"));
String OPType = CTools.dealString(request.getParameter("OPType")).trim();
String ai_backurl = "";
String ai_contype = "";
String ai_deptinfo = "";
Vector vPage = null;
CDataCn dCn = null;
CDataImpl dImpl = null;
try{
dCn = new CDataCn();
dImpl = new CDataImpl(dCn);
if (OPType.equals("Edit")){
	sqlstr ="select * from tb_votetheame where th_id ="+th_id;
	content=dImpl.getDataInfo(sqlstr);
	if (content!=null){
		th_id = content.get("th_id").toString();
		//sj_id = content.get("sj_id").toString();
		ctContent = content.get("th_content").toString();
		th_title = content.get("th_title").toString();	
		ct_inserttime = content.get("th_starttime").toString();
        String th_starttime = content.get("th_starttime").toString();
		String th_stoptime = content.get("th_stoptime").toString();
		ai_isok=content.get("ai_isok").toString();
		ai_backurl = CTools.dealNull(content.get("ai_backurl"));
        ai_start_timehx=content.get("ai_start_timehx").toString();
		ai_start_timeex=content.get("ai_start_timeex").toString();
		ai_end_timehx=content.get("ai_end_timehx").toString();
		ai_end_timeex=content.get("ai_end_timeex").toString();
		th_maxnum = content.get("th_maxnum").toString();
		th_powercode = content.get("th_powercode").toString();
		th_display = content.get("th_display").toString();
		th_iscomment = content.get("th_iscomment").toString();
		th_votetype = content.get("th_votetype").toString();
		th_colnum = content.get("th_colnum").toString();
		ai_contype = CTools.dealNull(content.get("ai_contype"));
		ai_deptinfo = CTools.dealNull(content.get("ai_deptinfo"));
		//filePath = content.get("th_filepath").toString();
		//String th_filename = content.get("th_filename").toString();
		//String th_realname = content.get("th_realname").toString();
		//if(!ctImgpath.equals("")) session.setAttribute("temppath",ctImgpath);
	}
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
<meta http-equiv="pragma" content="no-cache">
<link href="../style.css" rel="stylesheet" type="text/css">
<script LANGUAGE="javascript" src="/system/common/treeview/chooseTreeJs.jsp"></script>

		<form name="formData" action="SubjectResult.jsp" method="post" enctype="multipart/form-data">
		<table class="main-table" width="100%">
		<tr class="title1" align=center>
	      	<td><%=th_title%></td>
	    </tr>
	    <tr>
	     	<td width="100%">
	     		<table width="100%"  height="1">
				 <tr class="line-even" >
			            <td width="19%" align="right">投票主题：</td>
			            <td width="81%" ><input type="text" name="ct_title" value="<%=th_title%>"  class="text-line" size="80"/><font color="#FF0000">*</font>
			            </td>
		          </tr>					 
				  
					  <input type="hidden" name="ct_inserttime" class="text-line" value="<%= ct_inserttime.equals("")?new CDate().getThisday():ct_inserttime%>">
				  <tr class="line-odd" >
					<td width="19%" align="right">开始时间：</td>
					<td width="81%" >
					  <input type="date"  name="ai_start_timehx" readonly size="15" value="<%=ai_start_timehx%>"   onclick="javascript:showCal()" style="cursor:hand"/>&nbsp;
					  <select name="ai_start_timeex" id="ai_start_timeex"><%=GetTime_start%></select>
					&nbsp;截止时间&nbsp;<input type="date" size="15" name="ai_end_timehx" onClick="javascript:showCal()" style="cursor:hand" class=text-line  readonly value="<%=ai_end_timehx%>">&nbsp;<select name="ai_end_timeex" id="ai_end_timeex"><%=GetTime_end%></select></td>
				  </tr>
                  <tr class="line-even" >
					<td width="19%" align="right">是否发布：</td>
					<td width="81%" align="left"><input type="radio" size="40" name="ai_isok" value="1" <%if(ai_isok.equals("1")) out.println("checked");%>>&nbsp;是&nbsp;&nbsp;<input type="radio" name="ai_isok" value="0" <%if(ai_isok.equals("0")||ai_isok.equals("")) out.println("checked");%>>&nbsp;否</td></tr>
					<tr class="line-odd" >
					<td width="19%" align="right">是否允许评论：</td>
					<td width="81%" align="left"><input type="radio" size="40" name="th_iscomment" value="1" <%if(th_iscomment.equals("1")) out.println("checked");%>>&nbsp;是&nbsp;&nbsp;<input type="radio" name="th_iscomment" value="0" <%if(th_iscomment.equals("0")||th_iscomment.equals("")) out.println("checked");%>>&nbsp;否</td></tr>
					<tr class="line-even" >
					<td width="19%" align="right">结果反馈URL：</td>
					<td width="81%" align="left"><input type="text" name="backUrl" value="<%=ai_backurl%>" size="80"/></td></tr>
					 <tr class="line-odd" >
					<td width="19%" align="right">主题类别：</td>
					<td width="81%" >
						<select name="th_powercode">
							<option value="">请选择类别</option>
	<%
      sqlstr = "select ty_name,ty_code from tb_votetype";
			vPage = dImpl.splitPage(sqlstr,request,100);
		  if(vPage!=null){							
			for(int i=0; i<vPage.size(); i++){
				content = (Hashtable)vPage.get(i);
				String fs_name= content.get("ty_name").toString() ;
				String fs_code = content.get("ty_code").toString() ;
				if(th_powercode.equals(fs_code)){
	 %>
	 <option value="<%=fs_code%>" selected><%=fs_name%></option>
	 <% continue;}%>
						<option value="<%=fs_code%>"><%=fs_name%></option>
						<%}}%>
						</select></td></tr>
					 <tr class="line-even" >
			            <td width="19%" align="right">显示样式：</td>
			            <td width="81%" >
						<%if("1".equals(th_display)||"".equals(th_display)){%>
             全部显示<input type="radio" name="dis" value="1" checked >
						按分类显示<input type="radio" name="dis" value="2">
						<%}else{%>
						全部显示<input type="radio" name="dis" value="1"  >
						按分类显示<input type="radio" name="dis" value="2" checked>
						<%}%>
						</td></tr>
						<tr class="line-odd" >
			            <td width="19%" align="right">类型：</td>
			            <td width="81%" >
						<%if("1".equals(th_votetype)||"".equals(th_votetype)){%>
                        投票<input type="radio" name="th_votetype" value="1" checked >
						选课<input type="radio" name="th_votetype" value="2">
						<%}else{%>
						投票<input type="radio" name="th_votetype" value="1"  >
						选课<input type="radio" name="th_votetype" value="2" checked>
						<%}%>
						</td></tr>
						<tr class="line-even" >
			            <td width="19%" align="right">前台显示列数：</td>
			            <td width="81%" >
						<%if("0".equals(th_colnum)||"".equals(th_colnum)){%>
						一列<input type="radio" name="th_colnum" value="0" checked>
            两列<input type="radio" name="th_colnum" value="1">
						三列<input type="radio" name="th_colnum" value="2">
						<%}else if("1".equals(th_colnum)){%>
						一列<input type="radio" name="th_colnum" value="0">
            两列<input type="radio" name="th_colnum" value="1" checked>
						三列<input type="radio" name="th_colnum" value="2">
						<%}else{%>
						一列<input type="radio" name="th_colnum" value="0">
						两列<input type="radio" name="th_colnum" value="1"  >
						三列<input type="radio" name="th_colnum" value="2" checked>
						<%}%>
						</td></tr>
						<tr class="line-odd" >
			            <td width="19%" align="right">操作方式：</td>
			            <td width="81%" ><input type="text" name="contype" value="<%=ai_contype%>" size="60"/>
						</td></tr>
						<tr class="line-even" >
			            <td width="19%" align="right">维护单位：</td>
			            <td width="81%" ><input type="text" name="deptinfo" value="<%=ai_deptinfo%>" size="60"/>
						</td></tr>
			       <tr class="line-odd">
				            <td align="left" height="20" colspan=2>
                <textarea id="content" name="CT_content" style="display:none;WIDTH: 100%; HEIGHT: 400px"><%=ctContent%></textarea>
		<IFRAME ID="eWebEditor1" src="/system/common/edit/eWebEditor.jsp?id=CT_content&style=standard" frameborder="0" scrolling="no" width="100%" height="400"></IFRAME>

       <script type="text/javascript" for=window event=onload>
       	eWebEditor1.setHTML(document.formData.CT_content.value);
       </script>
        <%
           String ia_id = "";
           String ia_name = "";
           String ia_path = "";
           String fileName = "";

           String sql_ia = "select va_id,va_realname,va_path,va_filename from tb_voteattach where th_id="+th_id;
           Vector vPage_ia = dImpl.splitPage(sql_ia,100,1);
           if (vPage_ia!=null)
           {
%>
<br>以下是已上传的附件：
<%
             for(int n=0;n<vPage_ia.size();n++)
             {
               Hashtable content_ia = (Hashtable)vPage_ia.get(n);
               ia_id = content_ia.get("va_id").toString();
               ia_name = content_ia.get("va_realname").toString();
               ia_path = content_ia.get("va_path").toString();
               fileName = content_ia.get("va_realname").toString();
               int imgflag = 0;
          %>
          <p align="left">文件名称：&nbsp;&nbsp;&nbsp;&nbsp;<a href="download.jsp?ia_id=<%=ia_id%>"><%if(!ia_name.equals("")) {out.println(ia_name);} else{out.println(fileName);}%></a>&nbsp;&nbsp;
          <img SRC="../images/dialog/delete.gif" onClick="javascript:deleteFile('<%=ia_id%>','<%=th_id%>');" title='删除该文件'style="cursor:hand">
          </p>
          <%
            }
           }
        %>
				 <tr class="odd">
        <td width="100%" colspan="4">
       <hr style='border-top-style: dotted; border-top-width: 1; border-bottom-style: dotted; border-bottom-width: 1' size=0 noshade color=#000000>
       §<a onClick="vbscript:AddAttach1()" style="cursor:hand">上传信息附件</a>
	     <span  id="TdInfo1">
                     <hr style='border-top-style: dotted; border-top-width: 1; border-bottom-style: dotted; border-bottom-width: 1' size=0 noshade color=#000000>
        </span>
					
					</td></tr>
			          <tr class="line-even">
				            <td align="center" height="20" colspan=2>

				            <input type="button" name="提交" class="bttn" onClick="checkform();" value="提交">
				            <input type="reset" value="重置" class="bttn" />
				            <input type="button" value="返回" class="bttn" onClick="javascript:history.go(-1);">
				            </td>
          			</tr>
					</table>
				</td>
			</tr>
		</table>
		<input type="hidden" name="infoStatus"/>		
		<INPUT type="hidden" name="th_id" value="<%=th_id%>">
		<INPUT type="hidden" name="sj_id" value="<%=sj_id%>">
		<INPUT type="hidden" name="OPType" value="<%=OPType%>">
		
		</form>

	</body>
</html>

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