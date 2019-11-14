<%@page contentType="text/html; charset=GBK"%>
<%@include file="/system/app/skin/head.jsp"%>
<%
//禁止页面缓存
response.addHeader("Cache-Control", "no-cache");
response.addHeader("Expires", "Thu, 01 Jan 1970 00:00:01 GMT");
String sort_id =CTools.dealString(request.getParameter("sort_id")).trim();//所属列表id
String board_id =CTools.dealString(request.getParameter("board_id")).trim();//所属主题id
String board_hot_flag ="";
String board_name="";

String post_id ="";	                //话题ID
String post_title="";                //话题名称
String post_date ="";				//发起日期
String post_edit_date ="";		    //最后修改日期
String post_author ="";				//创建人
String post_author_id ="";				//作者ID
String post_ip ="";				//作者IP
String post_click_count ="";		    //点击数
String post_revert_count ="";		    //回复数
String post_show_sign ="";		//是否显示签名 1显示   0不显示
String post_sign ="";		   //是否特别关注 1特别关注   0不特别关注
String post_tiptop ="";			//是否置顶：1是、0否
String post_revert ="";		//最后回复人
String post_revert_id ="";		//最后回复人ID
String post_revert_date ="";		//最后回复人日期
String post_status ="";		    //发布状态：0未审核、1审核通过、2审核不通过  
//调出登入人信息
String us_id = "";
String us_uid = "";
String us_name="";
String ssqlStr = "";
CMySelf mySelf = (CMySelf)session.getAttribute("mySelf");
//
CDataCn dCn = null;
CDataCn newdCn = null;
CDataImpl dImpl = null;
CDataImpl newdImpl = null;
CDataImpl dImpl_dImpl = null;
try{


dCn = new CDataCn();
newdCn = new CDataCn();
dImpl = new CDataImpl(dCn); 
newdImpl = new CDataImpl(newdCn); 
dImpl_dImpl = new CDataImpl(newdCn); 

if (mySelf!=null)
{
	us_id = Long.toString(mySelf.getMyID());
}
if (!us_id.equals(""))
{
	ssqlStr = "select ui_uid ,ui_name from tb_userinfo where ui_id="+us_id;

	Hashtable ccontent = dImpl.getDataInfo(ssqlStr);
	if (ccontent!=null)
	{
	us_uid = ccontent.get("ui_uid").toString(); 
	us_name = ccontent.get("ui_name").toString();
}}
 String strSql ="select post_id,post_title,to_char(post_date,'yyyy-MM-dd') as post_date,to_char(post_edit_date,'yyyy-MM-dd') as post_edit_date,post_author,post_author_id,post_ip,post_click_count,post_revert_count,post_show_sign,post_sign,post_tiptop,post_revert,post_revert_id, to_char(post_revert_date,'yyyy-MM-dd') as post_revert_date,post_status from forum_post_pd where board_id='"+board_id+"' order by  POST_TIPTOP desc, post_revert_date desc";

Vector vPage = null;
Hashtable content = null;
Hashtable newcontent = null;
vPage = dImpl.splitPage(strSql,request,20);

String sql="select board_hot_flag from forum_board_pd where board_id="+board_id;
newcontent = newdImpl.getDataInfo(sql);
board_hot_flag = newcontent.get("board_hot_flag").toString();//是否这本期主题

%>
<script language="JavaScript">

function submitAdd(pagenum){  
  document.formrepAdd.submit();	
}	
</script>
<%@include file="/system/app/skin/skin4/template/list_top.jsp"%>
<!--    模块名称开始    -->
<a href="postList.jsp?sort_id=<%=sort_id%>">主题列表</a>>>
<a href="ForumPostList.jsp?sort_id=<%=sort_id%>&board_id=<%=board_id%>">话题列表</a>
<!--    模块名称结束    -->
<%@include file="/system/app/skin/skin4/template/list_function.jsp"%>                                                            
<!--    功能按钮开始    -->
<%if(board_hot_flag.equals("1")){%>
<img src="/system/images/new.gif" border="0" style="cursor:hand;"
onClick="submitAdd()" alt="新建话题">
新建话题
<%}%>
<img src="/system/images/goback.gif"
border="0"
onClick="window.history.back();"
title="返回" style="cursor:hand">
返回
<!--    功能按钮结束    -->
<%@include file="/system/app/skin/skin4/template/list_listtop.jsp"%>                                                                                        
<!--    列表开始    -->
<table class="FindAreaTable1" cellspacing="1" rules="cols" border="0" id="ctl00_DataGrid_DataGrid1" style="border-width:0px;">
		      <!-- 加入新建话题功能 ForumPostEdit.jsp为新建话题页面 -->
<form action="/system/app/forum/ForumPostEdit.jsp" method="post" name="formrepAdd">
	<input type="hidden" name="sort_id" value="<%=sort_id%>"> 
	<input type="hidden" name="board_id" value="<%=board_id%>"> 
	<input type="hidden" name="us_id" value="<%=us_id%>"> 
	<input type="hidden" name="us_name" value="<%=us_name%>"> 
</form>
		      <tr class="bttn">
		        <td width="28" nowrap class="outset-table"><div align="center">序号</div></td>
			    <td width="136" nowrap class="outset-table"><div align="center">话题</div></td>
			    <td width="81" nowrap class="outset-table"><div align="center">发起人</div></td>
			    <td width="101" nowrap class="outset-table"><div align="center">发表/修改日期</div></td>
				  <td width="80" nowrap class="outset-table"><div align="center">点击/跟帖/未审核</div></td>
			    <td width="80" nowrap class="outset-table"><div align="center">最后回复</div></td>
			    <td width="66" nowrap class="outset-table"><div align="center">是否关注</div></td>
				  <td width="66" nowrap class="outset-table"><div align="center">置顶/状态</div></td>
				  <td width="42" nowrap class="outset-table"><div align="center">修改</div></td>
			  </tr>
		      


		      <%
		if(vPage!=null)
		  {			
				  String num="";//未审核贴子的总数
			for(int i=0;i<vPage.size();i++)
			{
			  content = (Hashtable)vPage.get(i);			  
			  if(i % 2 == 0)  out.print("<tr class=\"line-even\">");
			  else out.print("<tr class=\"line-odd\">");			
				post_id =content.get("post_id").toString();                //话题ID
					sql="select count(*) as num from  forum_revert where revert_status='0' and post_id='"+post_id +"'";
					newcontent = newdImpl.getDataInfo(sql);
					num = newcontent.get("num").toString();     //是否这本期主题

				post_title=content.get("post_title").toString();                //话题名称
				post_date =content.get("post_date").toString();  				//发起日期
				post_edit_date =content.get("post_edit_date").toString();  		    //最后修改日期
				post_author =content.get("post_author").toString();  			//创建人
				post_author_id =content.get("post_author_id").toString();  				//作者ID
				post_ip =content.get("post_ip").toString();  			//作者IP
				post_click_count =content.get("post_click_count").toString();  		    //点击数
		if(post_click_count.equals(null)||post_click_count.equals("")||post_click_count.equals("0"))
			  {
			post_click_count ="0";	
			  }
				post_revert_count =content.get("post_revert_count").toString();  		    //回复数
	if(post_revert_count.equals(null)||post_revert_count.equals("")||post_revert_count.equals("0"))
			  {
			post_revert_count ="0";	
			  }
				post_show_sign =content.get("post_show_sign").toString();  		//是否显示签名 1显示   0不显示
				post_sign =content.get("post_sign").toString();  		   //是否特别关注 1特别关注   0不特别关注
				post_tiptop =content.get("post_tiptop").toString();  			//是否置顶：1是、0否
				post_revert =content.get("post_revert").toString();  		//最后回复人
				post_revert_id =content.get("post_revert_id").toString();  		//最后回复人ID
				post_revert_date =content.get("post_revert_date").toString();  		//最后回复人日期
				
				if(post_revert.equals("匿名"))
				{ 
				String sql_sql="select us_uid from tb_user where us_id = '"+post_revert_id+"'";
				Hashtable content_content = dImpl_dImpl.getDataInfo(sql_sql);
				if (content_content!=null)post_revert = content_content.get("us_uid").toString()+"*";
				}
				
				post_status =content.get("post_status").toString();  		    //状态：0未审核、1审核通过、2审核不通过
				
			 
		%>
		      <td align=center><div align="center"><%=i+1%></div></td>
			  <td style="word-wrap:break-word;word-break:break-all;">
		        <div align="left"> <a
				href="revertList.jsp?sort_id=<%=sort_id%>&board_id=<%=board_id%>&post_id=<%=post_id%>"><%=post_title%></a></div></td>
			  <td align=left style="word-wrap:break-word;word-break:break-all;"><div align="left"><%=post_author%><br>
			  IP：<%=post_ip%></div></td>
			    <td align=left style="word-wrap:break-word;word-break:break-all;"><div align="left"><%=post_date%><br>
		          <%=post_edit_date%></div></td>
			<td align=center><div align="center"><%=post_click_count%>/<%=post_revert_count%>/<a
				href="revertList.jsp?sort_id=<%=sort_id%>&board_id=<%=board_id%>&post_id=<%=post_id%>"><%=num%></a></div></td>
<td align=left style="word-wrap:break-word;word-break:break-all;"><div align="left"><%=post_revert%><br>
  <%=post_revert_date%></div></td>

			  <td align=center><div align="center"><%=post_sign.equals("1")? "关注" : "暂不关注"%></div></td>

			    <td align=center><div align="center"><%=post_tiptop.equals("1")? "置顶" : "不置顶"%>/<%=post_status.equals("1")? "发布" : "不发布"%></div></td>
			 
  <td align=center><div align="center">
  <a href='ForumPostrework.jsp?sort_id=<%=sort_id%>&board_id=<%=board_id%>&post_id=<%=post_id%>'><img src='images/modi.gif' width="16" height="16" border='0' title='修改'></a></div></td>
			  </tr>
		      <%
    }
  }
  else
  {
    out.println("<tr><td colspan=20>没有记录！</td></tr>");
  }
%>
              
</table>
<!--    列表结束    -->
<%@include file="/system/app/skin/skin4/template/list_bottom.jsp"%> 
<%
}
catch(Exception e){
	System.out.print(e.toString());
}
finally{
	newdImpl.closeStmt();
	dImpl_dImpl.closeStmt();
	dImpl.closeStmt();
	dCn.closeCn(); 
}
%>
<%@include file="/system/app/skin/bottom.jsp"%>