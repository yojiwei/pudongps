<%@ page contentType="text/html; charset=GBK" %>
<%@ page import="com.component.database.*" %>
<%@ page import="java.util.*" %>
<%@ page import="com.util.CTools" %>
<%@include file="/system/app/skin/head.jsp"%>
<link href="../style.css" rel="stylesheet" type="text/css">
<%
  String sqlLog = "";
  String title = "ftp上传日志";
	String fileid = "";
	String filename = "";
  String filepath = "";
  String filedate = "";
  String filetable = "";
  String fileparentid = "";
  String filecount = "";
	
	CDataCn dCn = null;
	CDataImpl dImpl = null;
	Vector vpage = null;
	Hashtable content = null;
	try{
		dCn = new CDataCn();
		dImpl = new CDataImpl(dCn);
  	sqlLog ="select ft_id,ft_path,ft_filename,ft_date,ft_issuccess,ft_parentable,ft_parentid,ft_count from tb_ftplog where ft_isupload =1 order by ft_id desc";
%>

<table class="main-table" width="100%">
<tr>
 <td width="100%">
   <div align="center">
	<table border="0" width="100%" cellspacing="0" cellpadding="0">
		<tr>
			<td>
				<table border="0" width="100%" cellspacing="0" cellpadding="0">
					<tr class="bttn">
					   <td width="100%">
					   <table width="100%">
						 <tr>
							<td id="TitleTd" width="100%" align="left"><%=title%></td>
							<td valign="top" align="right" nowrap>
								<img src="/system/images/dialog/split.gif" align="middle" border="0">
								<img src="/system/images/dialog/return.gif" border="0" onclick="javascirpt:history.go(-1);" title="返回" style="cursor:hand" align="absmiddle" id="image3" name="image3" WIDTH="14" HEIGHT="14">
								<img src="/system/images/dialog/split.gif" align="middle" border="0">
							</td>
						  </tr>
						</table>
					   </td>
					</tr>
				</table>
		   </td>
		</tr>
        <tr>
          <td width="100%" valign="top">
			<!--内容-->
        <table border="0" width="100%" cellpadding="3" height="44">
          <tr class="bttn">
				    <td width="4%" height="1" class="outset-table">序号</td>
				    <td width="9%" height="1" class="outset-table">上传的文件名</td>
				    <td width="45%" height="1" class="outset-table">上传的文件路径</td>
				    <td width="8%" height="1" class="outset-table">上传的时间</td>
				    <td width="8%" height="1" class="outset-table">关联的表</td>
				    <td width="9%" height="1" class="outset-table">关联的事项ID</td>
				    <td width="8%" height="1" class="outset-table">上传的次数</td>
				    <td width="9%" height="1" class="outset-table">是否上传成功</td>
				</tr>
<form name="formData" method="post">
<%
  	vpage = dImpl.splitPage(sqlLog,request,200);
	  if (vpage != null)
	  {
	    for(int j=0;j<vpage.size();j++)
	    {
	      content = (Hashtable)vpage.get(j);
	      fileid = CTools.dealNull(content.get("ft_id"));
	      filename = CTools.dealNull(content.get("ft_filename"));
	      filepath = CTools.dealNull(content.get("ft_path"));
	      filedate = CTools.dealNull(content.get("ft_date"));
	      filetable = CTools.dealNull(content.get("ft_parentable"));
	      fileparentid= CTools.dealNull(content.get("ft_parentid"));
	      filecount = CTools.dealNull(content.get("ft_count"));
%>
	<tr>
		<td><%=j+1%></td>
		<td><%=filename%></td>
		<td><%=filepath%></td>
		<td><%=filedate%></td>
		<td><%=filetable%></td>
		<td><%=fileparentid%></td>
		<td><%=filecount%></td>
		<td><a href="ftpUpload.jsp?ft_id=<%=fileid%>">再次上传</a></td>
	</tr>
<%
	    }
		out.print("<tr><td colspan=\"8\">"+dImpl.getTail(request)+"</td></tr>");
	  }else{
	      out.print("<tr><td colspan=\"8\" align=\"center\">没有记录！</td></tr>");
	  }
%>
</form>
</table>
	<!--内容-->
    </td>
 </tr>
 </table>
</div>
 </td>
</tr>
</table>
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
<%@include file="/system/app/skin/bottom.jsp"%>