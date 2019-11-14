<%@page contentType="text/html; charset=GBK"%>
<%@include file="/system/app/skin/head.jsp"%>
<script LANGUAGE="javascript" src="/system/common/common.js"></script>
<script type="text/javascript" src="/system/app/infopublish/editor/fckeditor.js"></script>
<script language="JavaScript">
function Popup(url, window_name, window_width, window_height)
{ 
	settings="toolbar=no,location=no,directories=no,"+
	"status=no,menubar=no,scrollbars=yes,"+
	"resizable=yes,width="+window_width+",height="+window_height;
	NewWindow=window.open(url,window_name,settings); 
}

function icon(theicon) {
document.input.content.value += " "+theicon;
document.input.content.focus();
}

function checkPost(f){
	f.content.value=eWebEditor.getHTML();
	f.submit();
}

function textCounter(field, maxlimit) {
	if (field.value.length > maxlimit)
		field.value = field.value.substring(0, maxlimit);
	else
		document.input.remLen.value = maxlimit - field.value.length;
}
</script>
<%!String Note_Title,Note_Content,Board_Name,sql;%>
<%

String Board_id=request.getParameter("fid");
String Note_id=request.getParameter("noteid");
String Return_id=request.getParameter("Returnid");
String guestName = "";
int action=1;	//action=1 发贴 action=0 回帖
//
CDataCn dCn = null;
CDataImpl dImpl = null;
try{
dCn = new CDataCn();
dImpl = new CDataImpl(dCn);

Connection con=dCn.getConnection();
Statement  stmt=con.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_READ_ONLY);
ResultSet  rs=null;

if(action==1)
{
	if (Note_id!=null)
	{
		sql="Select post_content from forum_post Where post_id="+Note_id;
		rs=stmt.executeQuery(sql);
		while (rs.next())
			Note_Content=rs.getString("post_content");
	}else
		Note_Content="";
	if (Note_id!=null)
		Note_Content="[quote]"+Note_Content +"[/quote]";

	if (Return_id!=null)
	{
	  sql="Select post_title from forum_post Where post_id="+Return_id;
	  rs=stmt.executeQuery(sql);
		while (rs.next())
			Note_Title="回复："+rs.getString("post_title");
	}else
		Note_Title="";

	  sql="Select fm_name from forum_board Where fm_id="+Board_id;
	  rs=stmt.executeQuery(sql);
	  while (rs.next())
		Board_Name=rs.getString("fm_name");
%>
<%@include file="/system/app/skin/skin4/template/info_top.jsp"%>
<!--    模块名称开始    -->
&nbsp;&nbsp;<a href=board.jsp?fid=<%=Board_id%>><%=Board_Name%></a>&gt;&gt;
<%
 if (Return_id==null)
 out.println("发表新帖");
 else
 out.println("回复贴子");
%>
<!--    模块名称结束    -->
<%@include file="/system/app/skin/skin4/template/info_funtion.jsp"%>
<!--    功能按钮开始    -->

<!--    功能按钮结束    -->
<%@include file="/system/app/skin/skin4/template/info_main.jsp"%>
<!--    表单提交开始    -->
<form method="post" name="input" action="savepost.jsp" enctype="multipart/form-data">
<table width="100%" cellspacing="0" cellpadding="0" align="center">
	<tr bgcolor="#F7FBFF">
		<td colspan="2"><b>发表文章</b></td>
	</tr>
	<tr >
			  <td  height="35" bgcolor="#F7FBFF" nowrap>文章标题：</td>
			  <td height="35" bgcolor="#F7FBFF" align="left">
				<input type="text" name="title" size="45" value="<%=Note_Title%>" />
				<input type="hidden" name="fid" size="12" value="<%=Board_id%>" />
				<input type="hidden" name="returnid" size="12" value="<%=Return_id%>" />
			  </td>
	</tr>
    <%if(Return_id==null){%>
    <tr >
      <td  height="35" bgcolor="#F7FBFF" nowrap>更换所属分类：</td>
      <td height="35" bgcolor="#F7FBFF" align="left">
        <select class="select-a" name="sort_id" >                                                      
            <%             
            Vector Page = null;
            String sql = "select fm_id,fm_name from forum_board where fm_id<45 order by fm_id";
            String sort_id="";
            String sort_name="";
            CDataCn dCn_new = null;
            CDataImpl dImpl_new =null;
        		try{
           	dCn_new = new CDataCn();
           	dImpl_new = new CDataImpl(dCn_new);
           	Page = dImpl_new.splitPage(sql,request,100);
            if (Page!=null)
            {
              for(int i=0;i<Page.size();i++)
                {
                   Hashtable content = (Hashtable)Page.get(i);
                   sort_id = content.get("fm_id").toString();
                   sort_name = content.get("fm_name").toString();
                  %>
                  <option value="<%=sort_id%>" <%=sort_id.equals(Board_id) ? "selected" : ""%>><%=sort_name%>                
                  </option>
            <%
                }
            }
            }catch(Exception e){            
            	out.print(e.toString());
            }
            finally{
	            dImpl_new.closeStmt();
	            dCn_new.closeCn();
            }            
            %>
            </select>
              </td>
    </tr>
    <%}%>
	<%
	//匿名用户回帖
	CMySelf mySelf = (CMySelf)session.getAttribute("mySelf");
	if((CMySelf)session.getAttribute("mySelf")==null)
	{
	%>
	<tr >
	  <td  height="35" bgcolor="#F7FBFF" nowrap>署名：</td>
	  <td height="35" bgcolor="#F7FBFF">
		<input type="text" name="Guest_Sign" size="45" value=""/>
	  </td>
	</tr>
	<%
	}
	%>
	<tr>
		  <td  bgcolor="#F7FBFF">图标：</td>
		  <td  bgcolor="#F7FBFF" align="left">
			<input type="radio" value="FACE1" name="icon" checked><img src="IMAGES/FACE1.GIF" WIDTH="20" HEIGHT="20" alt="微笑">
			<input type="radio" name="icon" value="FACE2"><img src="IMAGES/FACE2.GIF" WIDTH="20" HEIGHT="20" alt="无聊哦">
			<input type="radio" name="icon" value="FACE3"><img src="IMAGES/FACE3.GIF" WIDTH="20" HEIGHT="20" alt="委屈">
			<input type="radio" name="icon" value="FACE4"><img src="IMAGES/FACE4.GIF" WIDTH="20" HEIGHT="20" alt="顽皮">
			<input type="radio" name="icon" value="FACE5"><img src="IMAGES/FACE5.GIF" WIDTH="20" HEIGHT="20" alt="表情扭曲">
			<input type="radio" name="icon" value="FACE6"><img src="IMAGES/FACE6.GIF" WIDTH="20" HEIGHT="20" alt="发傻">
			<input type="radio" name="icon" value="FACE7"><img src="IMAGES/FACE7.GIF" WIDTH="20" HEIGHT="20" alt="靠！I 服了 YOU">
			<input type="radio" name="icon" value="FACE8"><img src="IMAGES/FACE8.GIF" WIDTH="20" HEIGHT="20" alt="撅嘴">
			<input type="radio" name="icon" value="FACE9"><img src="IMAGES/FACE9.GIF" WIDTH="20" HEIGHT="20" alt="没事偷着乐">
			<input type="radio" name="icon" value="FACE15"><img src="IMAGES/FACE15.GIF" WIDTH="40" HEIGHT="17" alt="原创">
			<br>
			<input type="radio" value="FACE10" name="icon"><img src="IMAGES/FACE10.GIF" WIDTH="20" HEIGHT="20" alt="斜视">
			<input type="radio" name="icon" value="FACE11"><img src="IMAGES/FACE11.GIF" WIDTH="20" HEIGHT="20" alt="为难">
			<input type="radio" name="icon" value="FACE12"><img src="IMAGES/FACE12.GIF" WIDTH="20" HEIGHT="20" alt="生气！">
			<input type="radio" name="icon" value="FACE13"><img src="IMAGES/FACE13.GIF" WIDTH="20" HEIGHT="20" alt="小吃一惊">
			<input type="radio" name="icon" value="FACE14"><img src="IMAGES/FACE14.GIF" WIDTH="20" HEIGHT="20" alt="不好意思的笑">
			<input type="radio" name="icon" value="FACE17"><img src="IMAGES/FACE17.GIF" WIDTH="20" HEIGHT="20" alt="狂吼">
			<input type="radio" name="icon" value="FACE18"><img src="IMAGES/FACE18.GIF" WIDTH="20" HEIGHT="20" alt="嘻嘻">
			<input type="radio" name="icon" value="FACE19"><img src="IMAGES/FACE19.GIF" WIDTH="20" HEIGHT="20" alt="痛苦的哭了">
			<input type="radio" name="icon" value="FACE20"><img src="IMAGES/FACE20.GIF" WIDTH="20" HEIGHT="20" alt="帅呆了">
			<input type="radio" name="icon" value="FACE16"><img src="IMAGES/FACE16.GIF" WIDTH="40" HEIGHT="17" alt="转贴">
			<br/>
			<input type="radio" name="icon" value="EXELAMATION" /><img src="IMAGES/exclamation.gif" alt="感叹" />&nbsp;
			<input type="radio" name="icon" value="QUESTION" /><img src="IMAGES/QUESTION.GIF" alt="疑问" />&nbsp;
			<input type="radio" name="icon" value="THUMBUP" /><img src="IMAGES/THUMBUP.GIF" alt="赞成" />&nbsp;
			<input type="radio" name="icon" value="THUMBDOWN" />
			<img src="IMAGES/THUMBDOWN.GIF" alt="反对" /> </td>
	</tr>
	<tr>
		  <td valign="top"  bgcolor="#F7FBFF">文章内容：</td>
		  <td  bgcolor="#F7FBFF">
           <table width="100%">
			<tr>
				<td align="left">（回复字数为2000<input type="hidden" name=remLen value=2000 readonly type=text size=3 maxlength=3 style="border: 0; color: red">
					）
				</td>
				<td width="43%">&nbsp;</td>
			</tr>
			<tr>
				<td align="left" width="100%">
					<!--It's a problem-->
					<textarea  name="content" onPropertyChange_bak="textCounter(input.content, 2000)" style="display:none;WIDTH: 100%; HEIGHT: 200px"><%=Note_Content%></textarea>
					<IFRAME ID="eWebEditor" src="/system/common/edit/eWebEditor.jsp?id=content&style=standard" frameborder="0" scrolling="no" width="100%" height="400"></IFRAME>	</tr>
	
					<script type="text/javascript" for=window event=onload>
						eWebEditor.setHTML(document.all.content.value);
					  
					  /*var oFCKeditor = new FCKeditor('content') ;
					  oFCKeditor.BasePath = "/system/app/infopublish/editor/" ;
					  oFCKeditor.Height = 400;
					  oFCKeditor.ToolbarSet = "Default" ;
					  oFCKeditor.ReplaceTextarea();*/
					</script>
				</td>
			</tr>
			<tr>
				<td colspan="2" align="left">
					<hr style='border-top-style: dotted; border-top-width: 1; border-bottom-style: dotted; border-bottom-width: 1' size=0 noshade color=#000000>
					§<a onclick="vbscript:AddAttach1()" style="cursor:hand">上传信息附件</a>
					<span  id="TdInfo1">
						<hr style='border-top-style: dotted; border-top-width: 1; border-bottom-style: dotted; border-bottom-width: 1' size=0 noshade color=#000000>
					</span>
				</td>
			</tr>
			<tr class=outset-table>
				<div id="subdiv" style="display:none">正在提交数据...</div>
				<td>
					<input type="button" name="topicsubmit" value="发表" onclick="checkPost(input);"/>
					&nbsp; <input type="reset" name="previewpost" value="重写" />
					&nbsp; <input type="button" name="previewpost" value="返回" onclick="window.history.back();" />
				</td>
			</tr>
		</table>
	</td></tr></table>
	</form>
<%
	dCn.closeCn();
}
else
{
	dCn.closeCn();
}
%>
<script language="vbscript">
'新增附件
function AddAttach1()
	dim count_obj,tr_obj,td_obj,file_obj,form_obj,count,table_obj
	dim button_obj,countview_obj
	dim str1,str2

	set form_obj=document.getElementById("input")
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
	str1 = str1 & "<input type='file' name='file1' size=30 class='text-line' id=file >"
	str2="<input type='hidden' name='fjsm1'  size=30  class='text-line' maxlength=100 id='fjsm1'>"

	str3="&nbsp;<img src='../images/dialog/delete.gif' class=hand onclick='vbscript:delthis1("+""""+div_obj.id+""""+")' id='button1' name='button1'>"
	div_obj.innerHtml=str1 + str2 + str3
end function

'删除函数
function delthis1(id)
  	dim child,parent
	set child_t = document.getElementById(id)
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
                                     
