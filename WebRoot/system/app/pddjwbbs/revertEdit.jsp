<%@page contentType="text/html; charset=GBK"%>
<%@include file="/system/app/skin/head.jsp"%>

<script LANGUAGE="javascript" src="../common/common.js"></script>
<script type="text/javascript" src="../infopublish/editor/fckeditor.js"></script>
<html>
<head>
<link rel='stylesheet' type='text/css' href='inc/FORUM.CSS'>
<META NAME="keywords" CONTENT=" 论坛  java forum jsp forum">
<META NAME="description" CONTENT=" 论坛  java forum jsp forum">
<style type="text/css">
<!--
.STYLE2 {
	color: #FF0000;
	font-size: 10pt;
}
-->
</style>
</head>
<%
String strPage = CTools.dealString(request.getParameter("strPage")).trim();    //当前页

String sort_id = CTools.dealString(request.getParameter("sort_id")).trim();//栏目ID
String board_id = CTools.dealString(request.getParameter("board_id")).trim(); //主题ID
String post_id = CTools.dealString(request.getParameter("post_id")).trim();//话题ID
String revert_id = CTools.dealString(request.getParameter("revert_id")).trim(); //跟贴ID
String revert_status=CTools.dealString(request.getParameter("revert_status")).trim();//状态
String revert_audit_id="";//审核人ID 
String revert_audit="";//审核人
//调出当前用户及ID 
User user = (User)session.getAttribute("user");
if(user != null) 
{
	revert_audit_id = user.getUid();
    revert_audit=user.getId();
}

//若是管理人 调出当前管理人及ID 
CMySelf mySelf = (CMySelf)session.getAttribute("mySelf");
if (mySelf!=null)
{
	revert_audit_id = Long.toString(mySelf.getMyID());
	revert_audit = mySelf.getMyUid().toString();	
}
String revert_title="";
String revert_content="";                //回复话题内容
Vector vPage = null;
Hashtable content = null;
CDataCn dCn = null;
CDataImpl dImpl = null;
try{
dCn = new CDataCn("pddjw");
dImpl = new CDataImpl(dCn); 
String strSql ="select revert_title,revert_content from forum_revert where revert_id="+revert_id;
//vPage = dImpl.splitPage(strSql,request,10);
content = dImpl.getDataInfo(strSql);
revert_title=content.get("revert_title").toString();     //话题标题 
revert_content=content.get("revert_content").toString();     //话题内容
%>
<body>
<script language="javascript">
function checkform()
{
	formData.revert_content.value=eWebEditor1.getHTML();
	if(typeof("eWebEditor1")=="undefined")
	{
			alert("编辑框内容未载入完全，请稍后提交!");
			return false;
	}    
	  
	   if(formData.revert_title.value =="")
	{      
			alert("请填写标题!");
			formData.revert_title.focus();
			return false;
	}
	  
   if(formData.revert_content.value =="")
	{      
			alert("请填写内容!");
			formData.revert_content.focus();
			return false;
	}
	
	formData.submit();
}
</script>

      <table width="100%" cellspacing="1" cellpadding="1" >
	    <form method="post" name="formData" action="revertEditResult.jsp?strPage=<%=strPage%>&post_id=<%=post_id%>&revert_id=<%=revert_id%>">

			<input type="hidden" name="sort_id" value="<%=sort_id%>"> 
			<input type="hidden" name="board_id" value="<%=board_id%>">
			<input type="hidden" name="revert_audit" value="<%=revert_audit%>"> 
			<input type="hidden" name="revert_audit_id" value="<%=revert_audit_id%>"> 
 <tr bgcolor="#F7FBFF">
				 <td colspan="2" ><div align="center"><strong>编辑跟贴</strong></div></td>
		 </tr>
	        	<tr><td width="6%" nowrap bgcolor="#F7FBFF"><div align="right">回复标题：</div></td>
					<td align="left" width="94%" bgcolor="#F7FBFF"><input type="text" name="revert_title" value="<%=revert_title%>" size="30"  maxlength="100"></td></tr>

	        	<tr>
				  <td width="6%" nowrap bgcolor="#F7FBFF"><div align="right">跟贴内容：</div></td>
					<td width="94%" bgcolor="#F7FBFF">
					<textarea id="revert_content" name="revert_content" style="display:none;WIDTH: 100%; HEIGHT: 200px"><%=revert_content%></textarea>
						<IFRAME ID="eWebEditor1" src="edit/eWebEditor.jsp?id=revert_content&style=standard" frameborder="0" scrolling="no" width="100%" height="350"></IFRAME>
		     <script type="text/javascript" for=window event=onload>
						eWebEditor1.setHTML(document.all.revert_content.value);
						/*
						var oFCKeditor = new FCKeditor('CT_content') ;
						oFCKeditor.BasePath = "/system/app/infopublish/editor/" ;
						oFCKeditor.Height = 400;
						oFCKeditor.ToolbarSet = "Default" ;
						oFCKeditor.ReplaceTextarea();*/
				</script>	         </td></tr>
			<tr>

				  <td bgcolor="#F7FBFF" nowrap><div align="right">审核：</div></td>
					<td height="32" bgcolor="#F7FBFF" align="left"><INPUT
						NAME="revert_status" TYPE="radio" value="1" checked >
					审核通过 &nbsp;&nbsp;					
					<INPUT TYPE="radio" NAME="revert_status"
						value="2"  >
				  审核不通过</td>
				</tr>		
	<tr>
	 <td colspan="2">
		<div id="subdiv" style="display:none">
	  <div align="justify">正在提交数据...</div>
	  </div>
		<div align="center">
		  <input type="button"  value="修改" onClick="checkform();"/>
		  &nbsp; 
		  <input type="reset"  value="重置" />
		  &nbsp; 
		  <input type="button"  value="返回" onClick="window.history.back();"/>		
	    </div></td>
	</tr> 
	</form></table> 
</body>


<%@include file="/system/app/skin/bottom.jsp"%>
<%	
}
catch(Exception e){
//e.printStackTrace();
out.print(e.toString());
}
finally{

dImpl.closeStmt();
dCn.closeCn(); }
%>
</html>