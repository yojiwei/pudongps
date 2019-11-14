<%@page contentType="text/html; charset=GBK"%>
<%@include file="/system/app/skin/head.jsp"%>
<script LANGUAGE="javascript" src="./common/common.js"></script>
<%
//禁止页面缓存
response.addHeader("Cache-Control", "no-cache");
response.addHeader("Expires", "Thu, 01 Jan 1970 00:00:01 GMT");

String board_id = "";               //主题ID
String sort_id ="";	                //所属分类ID
String sort_name="";                //所属分类名称
String board_name ="";				//主题名称
String board_comment ="";		    //主题说明
String board_create_date ="";		//创建日期
String board_master_id ="";		    //部位单位ID
String board_master_name ="";		//所属部位单位
String us_uid = "";

String board_post_count ="";		//总话题数量
String board_main_post_count ="";	//总帖子数量
String board_last_poster ="";		//最后发表人
String board_last_post_date="";		//最后发表日期
String board_sequence ="";		    //排序
String board_publish_flag="";       //发布状态：0不发布、1发布
String board_pic="";                //主题图片
String board_hot_flag="";//本期主题
//调出登入人信息 
String us_id = "";
String ssqlStr = "";
CMySelf mySelf = (CMySelf)session.getAttribute("mySelf");
//
CDataCn dCn = null;
CDataImpl dImpl = null;
try{
dCn = new CDataCn();
dImpl = new CDataImpl(dCn);

if (mySelf!=null)
{
	us_id = Long.toString(mySelf.getMyID());
}
//调出当前用户及所属部门ID 
if (!us_id.equals(""))
{
	ssqlStr = "select ui_uid,dt_id from tb_userinfo where ui_id="+us_id;

	Hashtable ccontent = dImpl.getDataInfo(ssqlStr);
	if (ccontent!=null)
	{
		us_uid = ccontent.get("ui_uid").toString();
		board_master_id= ccontent.get("dt_id").toString();
	}

}

String strSql="";
String strSql_sort="";
Vector vPage=null;
Hashtable content=null; 

Vector vPage_sort=null;
Hashtable content_sort=null; 

Vector newvPage=null;
Hashtable newcontent=null; 

Vector vPageCount=null;
Hashtable contentCount=null;
%>
<script language="JavaScript">
function submitAdd(pagenum){  
document.formrepAdd.submit();	
}
</script>
<%@include file="/system/app/skin/skin4/template/list_top.jsp"%>
<!--    模块名称开始    -->
<a href="postList.jsp">主题列表</a>
<!--    模块名称结束    -->
<%@include file="/system/app/skin/skin4/template/list_function.jsp"%>                                                            
<!--    功能按钮开始    -->
<img  src="/system/images/new.gif" border="0" onClick="window.location='sortEdit.jsp?OPType=add'" <%=us_uid.equals("administrator") ? "" : "style='display:none'"%>  title="新增栏目" style="cursor:hand" >
新增栏目
<img src="/system/images/new.gif" border="0" style="cursor:hand;" onClick="submitAdd()" alt="新建主题"  <%=us_uid.equals("administrator") ? "" : "style='display:none'"%>>
新建主题
<img src="/system/images/goback.gif" border="0" onClick="window.history.back();" title="返回" style="cursor:hand">
返回
<!--    功能按钮结束    -->
<%@include file="/system/app/skin/skin4/template/list_listtop.jsp"%>                                                                                        
<!--    列表开始    -->
<table class="FindAreaTable1" cellspacing="1" rules="cols" border="0" id="ctl00_DataGrid_DataGrid1" style="border-width:0px;">
	<tr>
		<td width="100%"><div align="center">
			<table class="content-table" width="100%">
	<!-- 加入新建主题功能 postEdit.jsp为新建主题页面 -->
				<form action="/system/app/forum/postEdit.jsp?type_post=Add&us_id=<%=us_id%>" method="post" name="formrepAdd">
				<input type="hidden" name="us_uid" value="<%=us_uid%>">
				<input type="hidden" name="us_uid" value="<%=us_id%>">
				</form>
			</table></div>
		</td>
	</tr>
</table>

<table width="100%">
	<tr class="bttn">
		<td width="10%" nowrap class="outset-table"><div align="center">论坛分类</div></td>
		<td>
			<table width="100%">
				<tr class="bttn">
					<td width="5%" nowrap class="outset-table"><div align="center">序号</div></td>
					<td width="15%" nowrap class="outset-table"><div align="center">主题</div></td>
					<td width="15%" nowrap class="outset-table"><div align="center">所属部门</div></td>
					<td width="10%" nowrap class="outset-table"><div align="center">创建日期</div></td>
					<td width="15%" nowrap class="outset-table"><div align="center">话题/总帖数</div></td>
					<td width="10%" nowrap class="outset-table"><div align="center">本期主题</div></td>
					<td width="10%" nowrap class="outset-table"><div align="center">状态</div></td>
					<td width="10%" <%=us_uid.equals("administrator") ? "" : "style='display:none'"%> nowrap class="outset-table" ><div align="center">修改</div></td>
				</tr>
			</table>
		</td>
	<tr>
	<%
	strSql_sort="select sort_id,sort_name from forum_sort order by sort_sequence,SORT_ID ";
	vPage_sort = dImpl.splitPage(strSql_sort,request,50);
	if(vPage_sort!=null){
	for(int h=0;h<vPage_sort.size();h++){
		content_sort = (Hashtable)vPage_sort.get(h);			  
		sort_id = content_sort.get("sort_id").toString();  	//栏目ID	
		sort_name = content_sort.get("sort_name").toString();  	//栏目名称	
	%>
	<tr class="line-odd">
		<td align="center" ><b><%if("administrator".equals(us_uid)){%><a href ="sortEdit.jsp?OPType=edit&sort_id=<%=sort_id%>"><%=sort_name%></a><%}else{%><%=sort_name%><%}%></b></td>
		<td>
			<table width="100%">
				<tr>
				<%
				if("administrator".equals(us_uid)){
					strSql ="select board_hot_flag,board_id,sort_id,board_name,board_comment,to_char(board_create_date,'yyyy-MM-dd') as create_date,board_master_id,board_master_name,board_post_count,board_main_post_count,board_last_poster,to_char(board_last_post_date,'yyyy-MM-dd') as last_date,board_sequence,board_publish_flag ,board_pic from forum_board_pd where sort_id='"+sort_id+"'  order by  board_create_date desc";
				}else{
					strSql ="select board_hot_flag,board_id,sort_id,board_name,board_comment,to_char(board_create_date,'yyyy-MM-dd') as create_date,board_master_id,board_master_name,board_post_count,board_main_post_count,board_last_poster,to_char(board_last_post_date,'yyyy-MM-dd') as last_date,board_sequence,board_publish_flag ,board_pic from forum_board_pd where sort_id='"+sort_id+"' and board_id in(select board_id from forum_deptmanage_pd where dt_id='"+board_master_id+"') order by board_create_date desc";
				}
				vPage = dImpl.splitPage(strSql,request,20);

				if(vPage!=null){
				for(int i=0;i<vPage.size();i++){
					String new_board_master_name ="";		//new所属部位单位
					content = (Hashtable)vPage.get(i);			  
					if(i % 2 == 0)  out.print("<tr class=\"line-even\">");
					else out.print("<tr class=\"line-odd\">");			
					board_id=content.get("board_id").toString();//主题id  

					String ssql="select * from forum_deptmanage_pd where board_id="+board_id;
					newvPage = dImpl.splitPage(ssql,request,20);

					if(newvPage!=null){ 
						for(int j=0;j<newvPage.size();j++){
							newcontent=(Hashtable)newvPage.get(j);
							new_board_master_name = newcontent.get("dt_name").toString()+" "+new_board_master_name;
						}
					}
					String sql="select sum(post_revert_count) as total from forum_post_pd where board_id="+board_id;
					vPageCount = dImpl.splitPage(sql,request,1);
					contentCount = (Hashtable)vPageCount.get(0);	
					String Count=contentCount.get("total").toString();

					if(Count.equals(null)||Count.equals("")||Count.equals("0")){
						Count ="0";	
					}

				   //更新此BOARD_ID中的总话题数
					dImpl.edit("forum_board_pd","board_id",board_id);
					dImpl.setValue("board_main_post_count",Count,CDataImpl.STRING);//更forum_post_pd表中的话题的跟贴数
					dImpl.update();

					board_name = content.get("board_name").toString();  	//主题名称			  
					board_comment = content.get("board_comment").toString();//主题说明			  
					board_master_name = content.get("board_master_name").toString(); //部位单位
					board_create_date = content.get("create_date").toString();	//创建日期
					board_post_count = content.get("board_post_count").toString();	//总话题数量
					if(board_post_count.equals(null)||board_post_count.equals("")||board_post_count.equals("0")){
						board_post_count ="0";	
					}
					board_main_post_count = Count;//总帖子数量
					board_hot_flag = content.get("board_hot_flag").toString(); //本题主题：1是  0不是
					board_publish_flag = content.get("board_publish_flag").toString(); //发布状态：0不发布、1发布
				%>
					<td width="5%" align=center><div align="center"><%=i+1%></div></td>
					<td width="15%" style="word-wrap:break-word;word-break:break-all;"><div align="center"><a href="ForumPostList.jsp?sort_id=<%=sort_id%>&board_id=<%=board_id%>"><%=board_name%></a></div></td>
					<td width="15%" align=center><div align="center"><%=new_board_master_name%></div></td>
					<td width="10%" align=center><div align="center"><%=board_create_date%></div></td>
					<td width="15%" align=center><div align="center"><%=board_post_count%>/<%=board_main_post_count%></div></td>
					<td width="10%" align="center" style="word-wrap:break-word;word-break:break-all;"><div align="center"><%if(board_hot_flag.equals("1")){%><font color = "red" >是</font><%}else{%>否<%}%></div></td>
					<td width="10%" align=center><div align="center"><%="1".equals(board_publish_flag)?"发布":"不发布"%></div></td>
					<td width="10%" align=center <%=us_uid.equals("administrator") ? "" : "style='display:none'"%>><div align="center"><img style="cursor:hand;" src='images/modi.gif' onclick="window.location='rework.jsp?sort_id=<%=sort_id%>&board_id=<%=board_id%>&us_uid=<%=us_uid%>&board_master_id=<%=board_master_id%>'"  width="16" height="16" border='0' title='修改' <%=us_uid.equals("administrator") ? "" : "disabled"%>></div></td>
				<%
					}
				}else{
					out.println("<tr><td colspan=20>该栏目下没有主题！</td></tr>");
				}
				%>
				</tr>
			</table>
		</td>
	</tr>
	<tr>
		<td colspan="2" height="1" bgcolor="#666666"></td>
	</tr>
<%
		}
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
	dImpl.closeStmt();
	dCn.closeCn(); 
}
%>
<%@include file="/system/app/skin/bottom.jsp"%>