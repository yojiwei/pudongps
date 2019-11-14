<%@page contentType="text/html; charset=GBK"%>
<%@include file="/website/include/import.jsp"%>
<title>更新文件</title>
<%
String path              = "";
String fileName          = "";
String DL_directory_name = "";
String sqlStr            = "";
String pr_id             = "";
String wo_id             = "";
String wa_id             = "";
boolean successDel       = false;

wa_id = CTools.dealString(request.getParameter("wa_id")).trim();//附件id

//Update 20061231
CDataCn dCn = null;
CDataImpl dImpl = null;
try{
dCn = new CDataCn();
dImpl = new CDataImpl(dCn); 

path = dImpl.getInitParameter("workattach_save_path"); //获得附件的目录
sqlStr = "select a.wa_filename,a.wa_path,b.wo_id,b.pr_id from tb_workattach a,tb_work b where a.wa_id='"+wa_id+"' and a.wo_id = b.wo_id";
Hashtable content = dImpl.getDataInfo(sqlStr);
if (content!=null)
{
	DL_directory_name = content.get("wa_path").toString(); //获得该文件所在的文件夹
	fileName = content.get("wa_filename").toString();      //获得文件名
	pr_id = content.get("pr_id").toString();
	wo_id = content.get("wo_id").toString();
}
%>
<link rel="stylesheet" href="/website/include/main.css" type="text/css">
<table width=100% align=center cellspacing=0 cellpadding=5 border=1  bordercolordark=white bordercolorlight=black>
<form name="formData" method="post" enctype="multipart/form-data">
	<tr bgcolor=#c8cfb8>
		<td style="background-color: #DEEFFF" align=left colspan="2">
			<label id=title>&nbsp;更新文件&nbsp;</label>
		</td>
	</tr>
	<tr>
		<td align=left colspan="2">
			<div style="height: 50; overflow: auto; width: 100%; border: 0px solid #336699">
			<%=fileName%></div>
		</td>
	</tr>
	<tr>
		<td align="left" width="15%">更新文件:</td>
		<td align="left"><input type="file" name="fileUpdate" class="text-line"></td>
	</tr>
	<tr>
		<td colspan="2" align="center">
			<input type="button" class="bttn" name="btnSubmit" value="提交" onclick="checkFile()">&nbsp;
			<input type="button" class="bttn" name="btnClose" value="关闭" onclick="javascript:window.close();">
		</td>
	</tr>
<input type="hidden" name="pr_id" value="<%=pr_id%>">
<input type="hidden" name="wo_id" value="<%=wo_id%>">
<input type="hidden" name="wa_id" value="<%=wa_id%>">
<input type="hidden" name="wa_path" value="<%=DL_directory_name%>">
<input type="hidden" name="initPath" value="<%=path%>">
<input type="hidden" name="fileName" value="<%=fileName%>">
</form>
</table>
<script language="javascript">
function checkFile()
{
	var obj = formData.fileUpdate;
	if(obj.value=="")
	{
		alert("没有选择更新文件!");
		obj.focus();
		return false;
	}
	formData.action = "ProjectUpdateResult.jsp";
	formData.submit();
}
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
