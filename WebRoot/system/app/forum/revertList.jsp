<%@page contentType="text/html; charset=GBK"%>
<%@include file="/system/app/skin/head.jsp"%>
<%
//禁止页面缓存
response.addHeader("Cache-Control", "no-cache");
response.addHeader("Expires", "Thu, 01 Jan 1970 00:00:01 GMT");
String strPage = CTools.dealString(request.getParameter("strPage")).trim();    //当前页
String sort_id=CTools.dealString(request.getParameter("sort_id")).trim();//所属列表id
String board_id=CTools.dealString(request.getParameter("board_id")).trim();//所属主题id
String post_id=CTools.dealString(request.getParameter("post_id")).trim();//所属话题id
String post_click_count="0";//话题的点击数

String post_title="";                //话题名称
String post_content="";                //话题内容
String post_date ="";				//发起日期
String post_edit_date ="";		    //最后修改日期
String post_author ="";				//创建人
String post_author_id ="";				//作者ID
String post_ip ="";				//作者IP
String post_revert_count ="";		    //回复数
String post_show_sign ="";		//是否显示签名 1显示   0不显示
String post_sign ="";		   //是否特别关注 1特别关注   0不特别关注
String post_tiptop ="";			//是否置顶：1是、0否
String post_revert ="";		//最后回复人
String post_revert_id ="";		//最后回复人ID
String post_revert_date ="";		//最后回复人日期

String revert_title="";                //回复标题
String revert_content="";                //回复内容
String revert_author_id ="";				//回复人ID
String revert_author ="";				//回复人
String revert_ip ="";		    //回复人IP
String revert_date ="";				//回复日期
String revert_show_sign ="";				//显示签名1是0否
String revert_status ="";				//审核状态  0未审核、1审核通过、2审核不通过 
String revert_audit ="";		    //审核人
String revert_audit_date ="";		    //审核日期
String revert_id ="";		//贴子ID

String strSql ="select post_ip,post_show_sign,post_click_count,post_title,post_content, post_author,to_char(post_date,'yyyy-MM-dd HH24:mi:ss') post_date,to_char(post_edit_date,'yyyy-MM-dd HH24:mi:ss') post_edit_date from forum_post_pd where post_id="+post_id;
Vector vPage = null;
Hashtable content = null;
Hashtable content_user = null;
//
CDataCn dCn = null;
CDataImpl dImpl = null;
CDataImpl newdImpl = null;
try{
dCn = new CDataCn();
dImpl = new CDataImpl(dCn);
newdImpl = new CDataImpl(dCn);

 content = dImpl.getDataInfo(strSql);
              post_click_count=content.get("post_click_count").toString();     //话题名称
			  post_title=content.get("post_title").toString();     //话题名称
			  post_content=content.get("post_content").toString();     //话题名称
			  post_date=content.get("post_date").toString();     //话题发起时间
			  post_edit_date=content.get("post_edit_date").toString();     //话题最后修改时间
			  post_author=content.get("post_author").toString();     //话题发起作者
			  post_ip=content.get("post_ip").toString();//发起人IP
			  post_show_sign=content.get("post_show_sign").toString();//显示签名1是0否
	 if(post_click_count.equals(null)||post_click_count.equals(""))
		  {
		post_click_count = String.valueOf(1);	
		  }
		else{
		post_click_count = String.valueOf(Integer.parseInt(post_click_count)+1);	
			}
 
dImpl.edit("forum_post_pd","post_id",post_id);
dImpl.setValue("post_click_count",post_click_count,CDataImpl.STRING);//更forum_post_pd表中的话题的关注数
dImpl.update();
%>
<%@include file="/system/app/skin/skin4/template/list_top.jsp"%>
<!--    模块名称开始    -->
<a href="postList.jsp?sort_id=<%=sort_id%>">主题列表</a> >>
<a href="ForumPostList.jsp?sort_id=<%=sort_id%>&board_id=<%=board_id%>">话题列表</a> >> <a href="revertList.jsp?sort_id=<%=sort_id%>&board_id=<%=board_id%>&post_id=<%=post_id%>">浏览帖子</a>
<!--    模块名称结束    -->
<%@include file="/system/app/skin/skin4/template/list_function.jsp"%>                                                            
<!--    功能按钮开始    -->
<a href="revertAdd.jsp?strPage=<%=strPage%>&sort_id=<%=sort_id%>&board_id=<%=board_id%>&post_id=<%=post_id%>"><img src="images/REPLY.GIF" width="80" valign="center" border="0"></a>
<!--    功能按钮结束    -->
<%@include file="/system/app/skin/skin4/template/list_listtop.jsp"%>                                                                                        
<!--    列表开始    -->
<table class="FindAreaTable1" cellspacing="1" rules="cols" border="0" id="ctl00_DataGrid_DataGrid1" style="border-width:0px;">
			<tr>
				<td>
				<table cellspacing="1" cellpadding="6" border="0" width="100%" >
				<tr>
				<td width="85" height="28"><div align="center">发起人</div></td>
				<td colspan="2">标题: <%=post_title%> </td>
				</tr>
				<tr>
				<td rowspan="2" valign="top" bgcolor="#F7FBFF"><div align="center" ><%="1".equals(post_show_sign)? post_author :"不显示签名"%></div><p align="center" >
	IP:<%="1".equals(post_show_sign)?post_ip :"不显示IP"%></td>
				<td width="395" >发表于:<%=post_date%>&nbsp; &nbsp;<%if(!post_edit_date.equals("")){%>最后修改:<%=post_edit_date%><%}%></td>
				<td width="192" ><div align="right"></div></td>
				</tr>
				<tr>
				<td colspan="2"><div align="justify"><%=post_content%>&nbsp;</div></td>
				</tr>
			</table>
			</td>
			</tr>
			<tr>
				<td>

<!--以下是调出用户的跟贴内容-->
<table width="100%" BORDER="0" class="main-table">
	
<%
strSql ="select revert_id,revert_title,revert_content,revert_author_id,revert_author,revert_ip,revert_show_sign,revert_status,revert_audit,to_char(revert_date,'yyyy-MM-dd HH24:mi:ss') revert_date,to_char(revert_audit_date,'yyyy-MM-dd') revert_audit_date from forum_revert where post_id='"+post_id +"' order by revert_date desc ";

vPage = newdImpl.splitPage(strSql,request,10);
if(vPage==null)out.print("暂无人跟贴");
if(vPage!=null)
		  {
			for(int i=0;i<vPage.size();i++)
			{ 					  
			  content = (Hashtable)vPage.get(i);	
			  revert_id=content.get("revert_id").toString();     //话题的ID
			  revert_title=content.get("revert_title").toString();     //话题的标题
			  revert_content=content.get("revert_content").toString();     //回复话题的内容
			   revert_author_id=content.get("revert_author_id").toString();     //回复人ID
			  revert_author=content.get("revert_author").toString();     //回复人
			  if(revert_author.equals("匿名")){
			  String sqlStr_user = "select us_uid from tb_user where us_id = '"+revert_author_id+"'";
			  content_user = dImpl.getDataInfo(sqlStr_user);
			  revert_author=content_user.get("us_uid").toString()+"*";      //回复人
			  }
			  revert_ip=content.get("revert_ip").toString();     //回复人IP
			  revert_date=content.get("revert_date").toString();     //回复时间
			  revert_show_sign=content.get("revert_show_sign").toString();     //是否显示签名 1 显示 0 不显示
		     revert_status=content.get("revert_status").toString();     //状态：0未审核、1审核通过、2审核不通过AUDITss			 
			 if(revert_status==null || revert_status=="")revert_status="0";
			  revert_audit=content.get("revert_audit").toString();     //审核人
		      revert_audit_date=content.get("revert_audit_date").toString();     //审核时间
		      
		%>
<tr><td>
<table width="100%" height="108" border="0"   cellpadding="6" cellspacing="1">

  <tr bgcolor="#e9e9e9">
    <td width="96" height="28"><div align="center">回复</div></td>
    <td colspan="4">标题: <%=revert_title%> </td>
  </tr>
  <tr>
    <td rowspan="2" valign="top" bgcolor="#F7FBFF"><div align="center" class="STYLE1"><%=revert_author%></div><p align="center" class="STYLE1">
	IP:<%=revert_ip%></td>
    <td width="168" bgcolor="#F7FBFF">回复日期:<font color="red"><%=revert_date%></font></td>
    <td width="74" bgcolor="#F7FBFF">状态：<font color="red"><%
		if("1".equals(revert_status))out.print("通过");
	else if("2".equals(revert_status))out.print("不通过");
	else out.print("未审核");
	%></font></td>
    <td width="128" bgcolor="#F7FBFF">审核日期：<font color="red"><%=revert_audit_date%></font></td>
    <form name="passform" method="post" action="pass.jsp?strPage=<%=newdImpl.getPageNo()%>&sort_id=<%=sort_id%>&board_id=<%=board_id%>&post_id=<%=post_id%>&revert_id=<%=revert_id%>" >
    <td width="199" bgcolor="#F7FBFF"><div align="left">修改: <%if("2".equals(revert_status) || "0".equals(revert_status)){%><input name="passresult" type="submit" value="通过"  style="cursor:hand"><%} if("1".equals(revert_status) || "0".equals(revert_status)){%> <input name="passresult" type="submit" value="不通过"  style="cursor:hand"><%}%>&nbsp; 
    <a href='revertEdit.jsp?strPage=<%=newdImpl.getPageNo()%>&sort_id=<%=sort_id%>&board_id=<%=board_id%>&post_id=<%=post_id%>&revert_id=<%=revert_id%>&revert_status=<%=revert_status%>'><img src='images/modi.gif' width="16" height="16" border='0' title='编辑'></a>&nbsp;&nbsp;
	<a href='delRevert.jsp?strPage=<%=newdImpl.getPageNo()%>&sort_id=<%=sort_id%>&board_id=<%=board_id%>&post_id=<%=post_id%>&revert_id=<%=revert_id%>'><img src='images/DELETE.GIF' width="16" height="16" border='0' title='删除'></a></div></td></form>
  </tr>
  <tr>
    <td colspan="4" bgcolor="#F7FBFF" style="word-wrap:break-word;word-break:break-all;"><div align="justify"><%=revert_content%>&nbsp;</div></td>
  </tr>
</table>
    </td>
	</tr>
		
<%
			 }
		  }
%>
</table>
    </td>
	</tr>

</table>
<!--    列表结束    -->
<%@include file="/system/app/skin/skin4/template/list_bottom.jsp"%> 
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