<%@page contentType="text/html; charset=GBK"%>
<%@include file="/system/app/skin/head.jsp"%>
<script LANGUAGE="javascript" src="../common/common.js"></script>
<script type="text/javascript" src="../infopublish/editor/fckeditor.js"></script>
<%
String post_author_id = CTools.dealString(request.getParameter("us_id")).trim();//管理者ID
String post_author = CTools.dealString(request.getParameter("us_name")).trim();//管理者
String post_ip = request.getRemoteAddr(); //取得管理者IP
String board_id =CTools.dealString(request.getParameter("board_id")).trim();//所属主题id
String sort_id =CTools.dealString(request.getParameter("sort_id")).trim();//所属栏目id
String post_title="";                //话题名称
String post_content="";                //话题内容
String post_date =new CDate().getThisday();	 //发起日期
String post_show_sign ="";		//是否显示签名 1显示   0不显示
String post_sign ="";		   //是否特别关注 1特别关注   0不特别关注
String post_tiptop ="";			//是否置顶：1是、0否
String post_status="";       //发布状态：0不发布、1发布
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
	formData.post_content.value=eWebEditor1.getHTML();
	//alert (typeof("eWebEditor1"));
	if(typeof("eWebEditor1")=="undefined")
	{
			alert("编辑框内容未载入完全，请稍后提交!");
			return false;
	}    
	  
	if(formData.post_title.value =="")
	{
			alert("请填写话题名称!");
			formData.post_title.focus();
			return false;
	}	
	if(formData.post_content.value =="")
	{
			alert("请填写内容!");
			formData.post_content.focus();
			return false;
	}
	
	formData.submit();
}
</script>
<%@include file="/system/app/skin/skin4/template/info_top.jsp"%>
<!--    模块名称开始    -->
<strong>新建话题</strong>
<!--    模块名称结束    -->
<%@include file="/system/app/skin/skin4/template/info_funtion.jsp"%>
<!--    功能按钮开始    -->

<!--    功能按钮结束    -->
<%@include file="/system/app/skin/skin4/template/info_main.jsp"%>
<!--    表单提交开始    -->
	<form method="post" name="formData" action="ForumPostResult.jsp?board_id=<%=board_id%>">
	<table  cellspacing="1" cellpadding="1" border="0" width="100%">
	<input type="hidden" name="sort_id" value="<%=sort_id%>"> 
	<input type="hidden" name="post_author_id" value="<%=post_author_id%>"> 
	<input type="hidden" name="post_author" value="<%=post_author%>">
    <input type="hidden" name="post_ip" value="<%=post_ip%>">
				<tr>
					<td width="11%" height="35" nowrap bgcolor="#F7FBFF"><div align="right">话题名称：</div></td>
					<td width="89%" height="35" align="left" bgcolor="#F7FBFF"><input
					name="post_title" type="text" value="" size="30"  maxlength="100"></td>
				</tr>
				<tr>
				  <td width="11%" height="45" nowrap bgcolor="#F7FBFF"><div align="right">话题内容：</div></td>
					<td  width="89%">
						<textarea id="post_content" name="post_content" style="display:none;WIDTH: 100%; HEIGHT: 200px"></textarea>
						<IFRAME ID="eWebEditor1" src="edit/eWebEditor.jsp?id=post_content&style=standard" frameborder="0" scrolling="no" width="100%" height="200"></IFRAME>
					    <script type="text/javascript" for=window event=onload>
						eWebEditor1.setHTML(document.all.post_content.value);
					</script>							
					</td>
				</tr>
				<tr>
				<tr>
					<td height="35" bgcolor="#F7FBFF" nowrap><div align="right">特别关注：</div></td>
					<td height="35" bgcolor="#F7FBFF" align="left"><INPUT
						NAME="post_sign" TYPE="radio" value="1"  >
					关注					&nbsp;&nbsp;
					<INPUT TYPE="radio" NAME="post_sign"
						value="0" checked>
					不关注</td>
				</tr>
				<tr>

					<td height="35" bgcolor="#F7FBFF" nowrap><div align="right">是否置顶：</div></td>
					<td height="35" bgcolor="#F7FBFF" align="left"><INPUT
						NAME="post_tiptop" TYPE="radio" value="1" >
					置顶					&nbsp;&nbsp;
					<INPUT TYPE="radio" NAME="post_tiptop"
						value="0" checked>
					不置顶</td>
				</tr>
				<tr>
					<td height="35" bgcolor="#F7FBFF" nowrap><div align="right">发布状态：</div></td>
					<td height="35" bgcolor="#F7FBFF" align="left"><INPUT
						NAME="post_status" TYPE="radio" value="1" checked true>
					发布&nbsp; &nbsp;
					<INPUT TYPE="radio" NAME="post_status"
						value="0"> 
					不发布</td>
				</tr>
				<tr>
					<td height="27" valign="top" bgcolor="#F7FBFF"><div align="right">发表时间：</div></td>
					<td bgcolor="#F7FBFF" align="left"><input type="text"
						name="post_date" size="20" value="<%=post_date%>"
						readonly />
					</td>
				</tr>
				<tr class=outset-table>
					<td colspan='2'>
						<div id="subdiv" style="display:none">正在提交数据...</div>
						<input type="button" value="提交" onClick="checkform();"/>
						&nbsp; <input type="reset" value="重写" />
						&nbsp; <input type="button" value="返回" onClick="window.history.back();" />
					</td>
				</tr>
	</table>
	</form>	
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
                                     
