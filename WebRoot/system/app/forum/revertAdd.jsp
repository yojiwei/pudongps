<%@page contentType="text/html; charset=GBK"%>
<%@include file="/system/app/skin/head.jsp"%>
<%
String strPage = CTools.dealString(request.getParameter("strPage")).trim();    //当前页
String sort_id = CTools.dealString(request.getParameter("sort_id")).trim();//栏目ID
String board_id = CTools.dealString(request.getParameter("board_id")).trim();//主题ID
String post_id = CTools.dealString(request.getParameter("post_id")).trim();//话题ID
String revert_ip = request.getRemoteAddr(); //取得跟贴人IP
String revert_author="";//回复人
String revert_author_id="";//回复人ID
//调出当前用户及ID 
User user = (User)session.getAttribute("user");
if(user != null) 
{
	revert_author_id = user.getUid();
    revert_author=user.getId();
}
//若是管理人 调出当前管理人及ID 
CMySelf mySelf = (CMySelf)session.getAttribute("mySelf");
if (mySelf!=null)
{
	revert_author_id = Long.toString(mySelf.getMyID());
	revert_author = mySelf.getMyName().toString();
}
String revert_title="";//回复标题
String revert_content="";                //回复话题内容
String revert_date =new CDate().getThisday();	 //回复话题日期
String revert_show_sign ="";		//是否显示跟贴人签名 1显示   0不显示
String revert_status="";       //发布状态：0不发布、1发布
Hashtable content = null;
//
CDataCn dCn = null;
CDataImpl dImpl = null;
try{
dCn = new CDataCn();
dImpl = new CDataImpl(dCn);
%>
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
			form.revert_title.focus();
			return false;
	}
	
   if(formData.revert_content.value =="")
	{
			alert("请填写内容!");
			form.revert_content.focus();
			return false;
	}
	
	formData.submit();
}
</script>
<%@include file="/system/app/skin/skin4/template/info_top.jsp"%>
<!--    模块名称开始    -->
回复话题
<!--    模块名称结束    -->
<%@include file="/system/app/skin/skin4/template/info_funtion.jsp"%>
<!--    功能按钮开始    -->

<!--    功能按钮结束    -->
<%@include file="/system/app/skin/skin4/template/info_main.jsp"%>
<!--    表单提交开始    -->
<table width="100%" cellspacing="1" cellpadding="1" BORDER="0" >
		<form method="post" name="formData" action="revertAddResult.jsp?post_id=<%=post_id%>">
		<input type="hidden" name="strPage" value="<%=strPage%>"> 
		<input type="hidden" name="revert_author_id" value="<%=revert_author_id%>"> 
		<input type="hidden" name="revert_author" value="<%=revert_author%>">
		<input type="hidden" name="revert_ip" value="<%=revert_ip%>">
		<input type="hidden" name="sort_id" value="<%=sort_id%>">
		<input type="hidden" name="board_id" value="<%=board_id%>">
	        	<tr>
				  <td width="6%" nowrap bgcolor="#F7FBFF"><div align="right">回复内容：</div></td>
					<td width="94%" bgcolor="#F7FBFF">
					<textarea id="revert_content" name="revert_content" style="display:none;WIDTH: 100%; HEIGHT: 200px"></textarea>
				<iframe id="eWebEditor1" src="edit/eWebEditor.jsp?id=revert_content&style=standard" frameborder="0" scrolling="no" width="100%" height="350" ></iframe>
				<script type="text/javascript" for=window event=onload>
						eWebEditor1.setHTML(document.all.revert_content.value);
				</script>	
				   </td>
				</tr>	
				<tr>
					<td height="27" valign="center" bgcolor="#F7FBFF"><div align="right">发表时间：</div></td>
					<td bgcolor="#F7FBFF" align="left"><input type="text"
						name="post_date" size="20" value="<%=revert_date%>"
						readonly />
					</td>
							</tr>	
				<tr  class=outset-table>
					 <td height="22" colspan="2">
						<div id="subdiv" style="display:none">
						<div align="justify">正在提交数据...</div>
						</div>
						<div align="center">
						<input type="button" value="回复" onClick="checkform();"/>
						&nbsp; <input type="reset"  value="重写" />
						&nbsp; <input type="button"  value="返回" onClick="window.history.back();" />
						</div>
					  </td>
				</tr> 
	</form>
	</table>
<!--    表单提交结束    -->
<%@include file="/system/app/skin/skin4/template/info_bottom.jsp"%> 
<%
}
catch(Exception e){
	System.out.print(e.toString());
}
finally{
	dImpl.closeStmt();
	dCn.closeCn(); 
}
%>
<%@include file="/system/app/skin/bottom.jsp"%>
                                     
