<%@page contentType="text/html; charset=GBK"%>
<%@include file="/system/app/skin/head.jsp"%>
<script LANGUAGE="javascript" src="../common/common.js"></script>
<script type="text/javascript" src="../infopublish/editor/fckeditor.js"></script>
<%
String sort_id =CTools.dealString(request.getParameter("sort_id")).trim();//所属栏目id
String board_id =CTools.dealString(request.getParameter("board_id")).trim();//所属主题id
String post_id =CTools.dealString(request.getParameter("post_id")).trim();//所属话题id
String post_title = "";//话题名称
String post_content = "";//话题内容
String post_edit_date ="";	 // 修改日期
java.text.DateFormat df = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
java.util.Date date = new java.util.Date();
post_edit_date = df.format(date);
String post_show_sign ="";		//是否显示签名 1显示   0不显示
String post_sign ="";		   //是否特别关注 1特别关注   0不特别关注
String post_tiptop ="";			//是否置顶：1是、0否
String post_status="";       //发布状态：0不发布、1发布
String strSql="";
Vector vPage = null;
Hashtable content = null;
//
CDataCn dCn = null;
CDataImpl dImpl = null;
try{
dCn = new CDataCn("pddjw");
dImpl = new CDataImpl(dCn);

strSql="select post_sign,post_tiptop,post_status,post_title,post_content from forum_post_pd where post_id="+post_id;
vPage = dImpl.splitPage(strSql,request,10);
if(vPage!=null)
		  {
			for(int i=0;i<vPage.size();i++)
			{
			content = (Hashtable)vPage.get(i);	
			post_title =content.get("post_title").toString();             //话题标题
			post_content=content.get("post_content").toString();         //话题内容
			post_sign =content.get("post_sign").toString();             //是否特别关注 1特别关注   0不特别关注
			post_tiptop=content.get("post_tiptop").toString();         //是否置顶：1是、0否
			post_status =content.get("post_status").toString();       //发布状态：0不发布、1发布
			}
		  }
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
			alert("请填写话题标题!");
			formData.post_title.focus();
			return false;
	}if(formData.post_content.value =="")
	{
			alert("请填写内容!");
			formData.post_content.focus();
			return false;
	}
	formData.action = "ForumPostreworkResult.jsp";
	formData.submit();
}

function deleteThis(post_id,sort_id)
{
	  if(confirm("确实要删除吗？\n将会删除该话题下的所有帖子!\n请谨慎操作!"))
	  {
			formData.action = "ForumPostreworkdel.jsp?post_id="+post_id+"&sort_id="+sort_id;
			formData.submit();
	  }
}
</script>
<%@include file="/system/app/skin/skin4/template/info_top.jsp"%>
<!--    模块名称开始    -->
<strong>    修改话题</strong>
<!--    模块名称结束    -->
<%@include file="/system/app/skin/skin4/template/info_funtion.jsp"%>
<!--    功能按钮开始    -->

<!--    功能按钮结束    -->
<%@include file="/system/app/skin/skin4/template/info_main.jsp"%>
<!--    表单提交开始    -->
	<form method="post" name="formData" >
    <input type="hidden" name="sort_id" value="<%=sort_id%>">
    <input type="hidden" name="post_id" value="<%=post_id%>">
	<input type="hidden" name="board_id" value="<%=board_id%>">
	<table  cellspacing="1" cellpadding="1" border="0" width="100%">
				<tr>
					<td width="11%" height="35" nowrap bgcolor="#F7FBFF"><div align="right">话题名称：</div></td>
					<td width="89%" height="35" align="left" bgcolor="#F7FBFF">
						<input name="post_title" type="text" value="<%=post_title%>" size="30"  maxlength="100"></td>
				</tr>
				<tr>
					<td width="11%" height="45" nowrap bgcolor="#F7FBFF">
						<div align="right">话题内容：</div></td>
					<td width="89%">
						<textarea id="post_content" name="post_content" style="display:none;WIDTH: 100%; HEIGHT: 200px"><%=post_content%></textarea>
						<IFRAME ID="eWebEditor1" src="edit/eWebEditor.jsp?id=post_content&style=standard" frameborder="0" scrolling="no" width="100%" height="200"></IFRAME>
					   <script type="text/javascript" for=window event=onload>
						eWebEditor1.setHTML(document.all.post_content.value);
						</script>	
								
					</td>
				</tr>
				<tr>
					<td height="35" bgcolor="#F7FBFF" nowrap><div align="right">特别关注：</div></td>
					<td height="35" bgcolor="#F7FBFF" align="left"><INPUT
						NAME="post_sign" TYPE="radio" value="1" <%="1".equals(post_sign)?"checked true":""%>>
					关注					&nbsp;&nbsp;
					<INPUT TYPE="radio" NAME="post_sign"
						value="0" <%="1".equals(post_sign)?"":"checked true"%>>
					不关注</td>
				</tr>
				<tr>
					<td height="35" bgcolor="#F7FBFF" nowrap><div align="right">是否置顶：</div></td>
					<td height="35" bgcolor="#F7FBFF" align="left"><INPUT
						NAME="post_tiptop" TYPE="radio" value="1" <%="1".equals(post_tiptop)?"checked true":""%>>
					置顶					&nbsp;&nbsp;
					<INPUT TYPE="radio" NAME="post_tiptop"
						value="0" <%="1".equals(post_tiptop)?"":"checked true"%>>
					不置顶</td>
				</tr>
					<tr>

					<td height="35" bgcolor="#F7FBFF" nowrap><div align="right">发布状态：</div></td>
					<td height="35" bgcolor="#F7FBFF" align="left"><INPUT
						NAME="post_status" TYPE="radio" value="1" <%="1".equals(post_status)?"checked true":""%>>
					发布&nbsp; &nbsp;
					<INPUT TYPE="radio" NAME="post_status"
						value="0"  <%="1".equals(post_status)?"":"checked true"%>> 
					不发布</td>
				</tr>
				
				<tr>
					<td valign="top" bgcolor="#F7FBFF"><div align="right">修改时间：</div></td>
					<td bgcolor="#F7FBFF" align="left"><input type="text"
						name="post_edit_date" size="20" value="<%=post_edit_date%>"
						readonly /></td>
		       </tr>
			   <tr class=outset-table>
					<td colspan='2'>
					<div id="subdiv" style="display:none">正在提交数据...</div>
					<input type="button" name="topicsubmit" value="修改" onClick="checkform();"/>
					&nbsp; <input type="reset" name="previewpost" value="删除"  onClick="deleteThis(<%=post_id%>,<%=sort_id%>);"/>
					&nbsp; <input type="button" name="previewpost" value="返回" onClick="window.history.back();" />
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
                                     
