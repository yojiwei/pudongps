<%@page contentType="text/html; charset=GBK"%>
<%@page import="com.util.*" %>
<%@page import="com.component.database.*" %>
<title>上传事项说明图片</title>
<%String strTitle="新闻发布--上传文件" ;%>
<%@include file="/system/app/skin/pophead.jsp"%>

<%
//update20080122

CDataCn dCn=null;   //新建数据库连接对象
CDataImpl dImpl=null;  //新建数据接口对象

try {
 dCn = new CDataCn(); 
 dImpl = new CDataImpl(dCn); 
String images_save_path = dImpl.getInitParameter("images_save_path"); //获取
String images_http_path = dImpl.getInitParameter("images_http_path"); //获取
String pr_img = request.getParameter("pr_img");
String DL_file_name = "";
long CT_file_size = 0;
if (pr_img == null)
pr_img = "";
if (!pr_img.equals(""))
{
%>
<table width=100% align=center cellspacing=0 cellpadding=5 border=1  bordercolordark=white bordercolorlight=black>
	<tr bgcolor=#c8cfb8><td style="background-color: #DEEFFF" align=center>
	<label id=title>&nbsp;上传图片&nbsp;</label>
	<tr>
		<td align=center>

<!--begin-->
			<!--内容-->
			<div style="height: 247; overflow: auto; width: 100%; border: 0px solid #336699">
<%

java.io.File oDir=new java.io.File(images_save_path+pr_img);
if(oDir.exists())
{
	int n;
	String HttpPath = images_http_path+pr_img;
	String[] fList = new String[100];
	fList = oDir.list();
	for (n=0;n<fList.length;n++)
	{
%>
	<p align="left"><img src="<%=HttpPath+"/"+fList[n]%>"  border="0">&nbsp;&nbsp;<INPUT TYPE="image" SRC="/system/images/delete.gif" onclick="javascript:deleteFile('<%=fList[n]%>')" title='删除该图片'></p>
<%
	}

}
%>
		</div>
			<!--内容-->
<!--end-->
</td>
<tr bgcolor=#c8cfb8 ><td style="background-color: #DEEFFF" align=center>
		<td>
</td></tr>
  </table>
<%

	}
%>
<form name="formData" action="ExplainInfoImgResult.jsp" method="post" enctype="multipart/form-data" onsubmit="return fnCheck()">
<table>			 
	<tr class="line-even">
		<td align="left" width="100%" height="20" colspan=2>
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
			str1="<hr style='border-top-style: dotted; border-top-width: 1; border-bottom-style: dotted; border-bottom-width: 1' dotted; border-top-width: 1; border-bottom-style: dotted; border-bottom-width: 1 size=0 noshade color=#000000>图片名称：<input type='file' name='fj1"&count&"' size=30 class='text-line' id=fj1'"&count&"'>"
			'str2="<br>附件标题：<input type='text' name='fjsm1"&count&"'  size=30  class='text-line' maxlength=100 id='fjsm1"&count&"'>"
			str3="&nbsp;<img src='/system/images/delete.gif' class=hand onclick='vbscript:delthis1("+""""+div_obj.id+""""+")' id='button'1 name='button'1>"
			div_obj.innerHtml=str1 + str3
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

		<table width="100%" align="center">
			<tr>
				<td class="row" id="TdInfo1">
					§<a HREF="vbscript:AddAttach1()">新增图片</a>§&nbsp;&nbsp;（提示：点击“新增图片”多次，可以增加多个附件！）
				</td>
			</tr>
            <tr>
				<td class="row" id="TdInfo1">
					<hr style='border-top-style: dotted; border-top-width: 1; border-bottom-style: dotted; border-bottom-width: 1' dotted; border-top-width: 1; border-bottom-style: dotted; border-bottom-width: 1 size=0 noshade color=#000000>
				</td>
			</tr>
		</table>
		</td>
	</tr>
	<input type="hidden" name="pr_img"  value="<%=pr_img%>">
	<tr>
		<td>
			<input type="submit" name="submit" value="提 交" class="bttn">&nbsp;
			<input type="button" class="bttn" name="fsubmit" value="关 闭" onclick="javascript:window.close()">
		</td>
    </tr>
</table>

</form>
<script LANGUAGE="javascript">
<!--
window.opener.formData.pr_img.value = document.formData.pr_img.value;

function fnCheck()
{
    formData.action="ExplainInfoImgResult.jsp?pr_img=<%=pr_img%>";
    return true;

}
function deleteFile(filename)
{
  var d;
  d=confirm("确认要删除该图片吗？");
  if (d)
  {
  <%
  String change_pr_img = pr_img.replaceAll("-","");
  %>

  window.location="ExplainInfoImgDel.jsp?pr_img=<%=change_pr_img%>&Filename="+filename;
  }
}
//-->
</script>


<%@include file="/system/app/skin/popbottom.jsp"%>


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