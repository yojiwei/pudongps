<%@page contentType="text/html; charset=GBK"%>
<%@include file="../skin/head.jsp"%>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-bean" prefix="bean"%> 
<%@ taglib uri="http://jakarta.apache.org/struts/tags-html" prefix="html"%>
<script LANGUAGE="javascript" src="./common/common.js"></script>

<%
	CMySelf mySelf = (CMySelf)session.getAttribute("mySelf");

	//mySelf.setSJRole();
	
%>
<html> 
	<head>
		<title>JSP for PublishForm form</title>
	</head>
	<body>
		<html:form action="/publish/PublishSubmit.do" enctype="multipart/form-data">
		<table class="main-table" width="100%">
		<tr class="title1" align=center>
	      	<td>信息发布</td>
	    </tr>
	    <tr>
	     	<td width="100%">
	     		<table width="100%" class="content-table" height="1">
					 <tr class="line-even" >
			            <td width="19%" align="right">主题：</td>
			            <td width="81%" ><html:text property="ctTitle"  styleClass="text-line" size="80"/><html:errors property="ctTitle"/>
			            </td>
			          </tr>	
			       
			          <tr class="line-even" >
			            <td width="19%" align="right">关键字：</td>
			            <td width="81%" ><html:text property="ctKeywords" styleClass="text-line" size="80"/><html:errors property="ctKeywords"/>
			            </td>
			          </tr>
			          <tr class="line-even" >
			            <td width="19%" align="right">链接地址：</td>
			            <td width="81%" ><html:text property="ctUrl" styleClass="text-line"  size="80" value="http://"/><html:errors property="ctUrl"/>
			            </td>
			          </tr>
			           <tr class="line-even" >
			            <td width="19%" align="right">来源：</td>
			            <td width="81%" ><html:text property="ctSource" styleClass="text-line" size="80"/><html:errors property="ctSource"/>
			            </td>
			          </tr>
			          <tr class="line-even" >
			            <td width="19%" align="right">排序：</td>
			            <td width="81%" ><html:text property="ctSequence" styleClass="text-line" value="1000"/><html:errors property="ctSequence"/>
			            </td>
			          </tr>
			          <tr class="line-even" >
			            <td width="19%" align="right">发布时间：</td>
			            <td width="81%" ><html:text property="ctCreateTime" styleClass="text-line" readonly="true" onclick="javascript:showCal()" style="cursor:hand"/><html:errors property="ctCreateTime"/>
			            </td>
			          </tr>
			          <tr class="line-even" >
			            <td width="19%" align="right">发布形式：</td>
			            <td width="81%" ><html:radio property="ctFileFlag" value="0" />内容<html:radio property="ctFileFlag" value="1" />文件
			            <html:errors property="ctFileFlag"/>
			            </td>
			          </tr>
			          <tr class="line-even" >
			            <td width="19%" align="right">所属栏目：</td>
			            <td width="81%" >			            
			            <html:hidden property="sjId" styleClass="text-line" style="cursor:hand" />
			            <html:text property="sjName" styleClass="text-line" style="cursor:hand" onclick="javascript:fnSelectSJ(0)" readonly="true" size="80" />
			            <html:hidden property="authoIds" value="<%=mySelf.getSjIds()%>" />
			            <html:hidden property="authoNames" value="<%=mySelf.getSjNames()%>" />
			            </td>
			          </tr>
			           <tr class="line-even" >
			            <td width="19%" align="right">特别提醒：</td>
			            <td width="81%" ><html:checkbox property="ctFocusFlag" styleClass="text-line" value="1" /><html:errors property="ctFocusFlag"/>
			            </td>
			          </tr>
			           <tr class="line-even" >
			            <td width="19%" align="right">录入时间：</td>
			          
			            <td width="81%" ><html:text property="ctInsertTime" styleClass="text-line" value="<%= new CDate().getThisday()%>"  readonly="true" /><html:errors property="ctInsertTime"/>
			            </td>
			          </tr>
			          <tr class="line-even" >
			            <td width="19%" align="right">浏览人次：</td>
			            <td width="81%" ><html:text property="ctBrowseNum" styleClass="text-line" /><html:errors property="ctBrowseNum"/>
			            </td>
			          </tr>
			           <tr class="line-even" >
			            <td width="19%" align="right">信息反馈：</td>
			            <td width="81%" ><html:checkbox property="ctFeedbackFlag" value="1" /><html:errors property="ctFeedbackFlag"/>
			            </td>
			          </tr>
			          <tr class="line-even">
				            <td align="left" height="20" colspan=2> <iframe id="demo" style="HEIGHT: 400px; TOP: 5px; WIDTH: 100%" src="/system/common/editor/editor.htm"></iframe>
				              <html:text property="ctContent"/><html:errors property="ctContent"/>
				             
							  <script LANGUAGE="javascript">
						<!--
							function GetDatademo()
							{
								var re = "/<"+"script.*.script"+">/ig";
								//var re2 = /(http|https|ftp):(\/\/|\\\\)((\w)+){1,}:*[0-9]*(\/|\\){1}/ig;
				        var re2 = /(src=\")(http|https|ftp):(\/\/|\\\\)(.[^\/|\\]*)(\/|\\)/ig;
								var Html=demo.getHTML();
								Html = Html.replace(re,"");
								Html = Html.replace(re2,"src=\"/");
								PublishForm.ctContent.value=Html;
				        //alert(Html);
							}
				
						//-->
						</script> </td>
          			</tr>
          			<tr class="odd">
					   <td width="100%" colspan="4">
							<hr style='border-top-style: dotted; border-top-width: 1; border-bottom-style: dotted; border-bottom-width: 1' size=0 noshade color=#000000>
							§<a onclick="vbscript:AddAttach1()" style="cursor:hand">上传信息附件</a>§（提示：选择附件后请点击＂上传附件＂按钮）<a href="#" onclick="javascript:window.open('explainFil.jsp', 'placard', 'Top=320px,Left=500px,Width=500,Height=150,toolbar=no,location=no,derectories=no,status=no,menubar=no,resizable=yes,scrollbars=yes')">【上传附件说明】</a><br>　　　　　　　　　以下是已上传的附件：<input type="button" class="imgBtn" name="fsubmit" value="上传附件" onclick="javascript:checkform(3,1)">
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
				            
				            <html:button property="提交" styleClass="bttn" onclick="return checkform(1)" value="提交"></html:button>
				            <html:cancel value="重置" styleClass="bttn" />
				            </td>
          			</tr>
					</table>
				</td>
			</tr>
		</table>
		<html:text property="infoStauts" />
		<html:hidden property="dtId" value="<%=Long.toString(mySelf.getDtId())%>"/>
		</html:form>
		
	</body>
</html>
<script language="vbscript">
		'新增附件
function AddAttach1()
dim count_obj,tr_obj,td_obj,file_obj,form_obj,count,table_obj
dim button_obj,countview_obj
dim str1,str2

set form_obj=document.getElementById("PublishForm")
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