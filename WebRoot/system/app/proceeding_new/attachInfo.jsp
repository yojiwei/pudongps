<%@page contentType="text/html; charset=GBK"%>
<%String strTitle="下载服务--上传文件" ;%>
<%@include file="../skin/head.jsp"%>

<%
CDataCn dCn = null; //新建数据库连接对象
CDataImpl dImpl = null; //新建数据接口对象
String papaAttach_save_path = ""; //获取
String pr_id = CTools.dealString(request.getParameter("pr_id")).trim();
String DL_file_name = "";
long DL_file_size = 0;

try{
	dCn = new CDataCn(); //新建数据库连接对象
	dImpl = new CDataImpl(dCn); //新建数据接口对象
	papaAttach_save_path = dImpl.getInitParameter("papaAttach_save_path"); //获取
} catch (Exception ex) {
	System.out.println(new java.util.Date() + "--"
			+ request.getServletPath() + " : " + ex.getMessage());
} finally {
	if(dImpl != null)
		dImpl.closeStmt();
	if(dCn != null)
		dCn.closeCn();
}

if (!DL_directory_name.equals(""))
{
%>

<table width=110% align=center cellspacing=0 cellpadding=5 border=1  bordercolordark=white bordercolorlight=black>
	<tr bgcolor=#c8cfb8><td style="background-color: #DEEFFF" align=center><label id=title>&nbsp;已上传附件&nbsp;</label></td></tr>
	<tr>
		<td align=center>

<!--begin-->
			<!--内容-->
			<div style="height: 247; overflow: auto; width: 100%; border: 0px solid #336699">
<%

	java.io.File oDir=new java.io.File(paAttach_save_path+DL_directory_name);
	if(oDir.exists())
	{
		int n;
		String[] fList = new String[100];
		fList = oDir.list();
		//n=fList.length;
    for (n=0;n<fList.length;n++)
		{
                DL_file_name = fList[n];
%>
		<p align="left">文件名称：&nbsp;&nbsp;&nbsp;&nbsp;<%=DL_file_name%>&nbsp;&nbsp;<INPUT TYPE="image" SRC="/system/images/delete.gif" onclick="javascript:deleteFile('<%=DL_file_name%>')" title='删除该文件'></p>
<%
                File newFile = new File(paAttach_save_path+DL_directory_name+"\\"+DL_file_name);
                DL_file_size = newFile.length();

%>
		<p align="left">文件大小：&nbsp;&nbsp;&nbsp;&nbsp;<%=DL_file_size%> 字节</p>
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
<form name="formData" action="attachInfoResult.jsp" method="post" enctype="multipart/form-data" onsubmit="return fnCheck()">
<table width="100%">			 <tr class="line-even">
			<td align="left" width="100%" height="20" colspan=2>


		<table width="100%" align="center">
			<tr>
				<td class="row" id="TdInfo1">
					上传附件&nbsp;&nbsp;（提示：限制上传.exe、.bat、.jsp类型的文件！）
				</td>
			</tr>
<tr>
				<td class="" id="TdInfo1">
				<hr style='border-top-style: dotted; border-top-width: 1; border-bottom-style: dotted; border-bottom-width: 1' dotted; border-top-width: 1; border-bottom-style: dotted; border-bottom-width: 1 size=0 noshade color=#000000>
				附件名称：<input type='file' name='fj1' size=30 class='text-line' id='fj1'>
				<hr style='border-top-style: dotted; border-top-width: 1; border-bottom-style: dotted; border-bottom-width: 1' dotted; border-top-width: 1; border-bottom-style: dotted; border-bottom-width: 1 size=0 noshade color=#000000>

				</td>
			</tr>
		</table>
		</td>

		  </tr>
		  <input type="hidden" name="DL_directory_name"  value="<%=DL_directory_name%>">
		  <input type="hidden" name="DL_file_name"  value="<%=DL_file_name%>">
		  <input type="hidden" name="DL_file_size"  value="<%=DL_file_size%>">
		  <tr><td><input type="submit" name="submit" value="提 交" class="bttn">&nbsp;<input type="button" class="bttn" name="fsubmit" value="关 闭" onclick="javascript:window.close()"></td></tr>
         </table>

         </form>
<script LANGUAGE="javascript">
<!--
window.opener.formData.ge_attach_path.value = document.formData.DL_directory_name.value;
//window.opener.formData.DL_file_name.value = document.formData.DL_file_name.value;
//window.opener.formData.DL_file_size.value = document.formData.DL_file_size.value;
function fnCheck()
{
	if (formData.fj1.value=="")
	{
		alert("请先选择附件！");
		return false;
	}
  else
  {
    formData.action="attachInfoResult.jsp?DL_directory_name1=<%=DL_directory_name%>";
    return true;
  }
}

function deleteFile(filename)
{
  var d;
  d=confirm("确认要删除该文件吗？");
  if (d)
  {
  window.location="attachDel.jsp?DL_directory_name=<%=DL_directory_name%>&Filename="+filename;
  }
}
//-->
</script>


<%@include file="../skin/bottom.jsp"%>