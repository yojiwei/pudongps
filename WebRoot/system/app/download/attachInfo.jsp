<%@page contentType="text/html; charset=GBK"%>
<%String strTitle="下载服务--上传文件" ;%>
<%@include file="../skin/head.jsp"%>

<%

	//String strId="";
	//strId = CTools.dealString(request.getParameter("strId"));
        /*
	String sql="select * from tb_initparameter where ip_name='attach_save_path'" ;
	CDataCn dCn = new CDataCn(); //新建数据库连接对象
	CDataImpl dImpl = new CDataImpl(dCn); //新建数据接口对象
	Hashtable content=dImpl.getDataInfo(sql);
	String attach_save_path = content.get ("ip_value").toString();
        */

      //update20080122

CDataCn dCn=null;   //新建数据库连接对象
CDataImpl dImpl=null;  //新建数据接口对象

try {
 dCn = new CDataCn(); 
 dImpl = new CDataImpl(dCn); 
        String attach_save_path = dImpl.getInitParameter("attach_save_path"); //获取

	String DL_directory_name = request.getParameter("DL_directory_name");
	String DL_file_name = "";
	long DL_file_size = 0;
	if (DL_directory_name == null)
		DL_directory_name = "";
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

	java.io.File oDir=new java.io.File(attach_save_path+DL_directory_name);
	if(oDir.exists())
	{
		int n;
		String[] fList = new String[100];
		fList = oDir.list();
		n=fList.length;
                DL_file_name = fList[n-1];
%>
		<p align="left">文件名称：&nbsp;&nbsp;&nbsp;&nbsp;<%=DL_file_name%></p>
<%
                File newFile = new File(attach_save_path+DL_directory_name+"\\"+DL_file_name);
                DL_file_size = newFile.length();

%>
		<p align="left">文件大小：&nbsp;&nbsp;&nbsp;&nbsp;<%=DL_file_size%> 字节</p>
<%


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
<form name="formData" action="attachInfoResult.jsp" method="post" enctype="multipart/form-data">
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
window.opener.formData.DL_directory_name.value = document.formData.DL_directory_name.value;
window.opener.formData.DL_file_name.value = document.formData.DL_file_name.value;
window.opener.formData.DL_file_size.value = document.formData.DL_file_size.value;


//-->
</script>


<%@include file="../skin/bottom.jsp"%>
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