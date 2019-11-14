<%@page contentType="text/html; charset=GBK"%>
<%@include file="/system/app/skin/head.jsp"%>
<%//禁止页面缓存
response.addHeader("Cache-Control", "no-cache");
response.addHeader("Expires", "Thu, 01 Jan 1970 00:00:01 GMT");
%>
<%
String post_author_id = CTools.dealString(request.getParameter("post_author_id")).trim(); 
String post_author = CTools.dealString(request.getParameter("post_author")).trim(); 
String post_ip = CTools.dealString(request.getParameter("post_ip")).trim(); 
String board_id = CTools.dealString(request.getParameter("board_id")).trim(); //话题所在主题ID
String sort_id = CTools.dealString(request.getParameter("sort_id")).trim(); 

String post_title = CTools.dealString(request.getParameter("post_title")).trim();    //话题名称
String post_content = CTools.dealString(request.getParameter("post_content")).trim();   //话题内容

String post_show_sign =  "1";//是否显示签名 1显示   0不显示
String post_sign = CTools.dealString(request.getParameter("post_sign")).trim();//是否特别关注 1特别关注   0不特别关注
String post_tiptop = CTools.dealString(request.getParameter("post_tiptop")).trim();  //是否置顶：1是、0否
String post_status = CTools.dealString(request.getParameter("post_status")).trim(); //发布状态：0不发布、1发布

String post_date = "";//发起话题时间
	java.text.DateFormat df = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	java.util.Date date = new java.util.Date();
	post_date = df.format(date);

String board_post_count="";//在forum_board_pd表中的话题数
//out.print(post_title);
//if(true)return;

CDataCn dCn = null;
CDataImpl dImpl = null;
try{
dCn = new CDataCn("pddjw");
dImpl = new CDataImpl(dCn); 
Vector vPage = null;
			String ssqlStr = "select count(*) as total from forum_post_pd where board_id="+board_id;
			vPage = dImpl.splitPage(ssqlStr,request,1);

			if (vPage!=null)
			{
					for(int i=0;i<vPage.size();i++)
					{
							Hashtable ccontent = (Hashtable)vPage.get(i);
							 board_post_count = ccontent.get("total").toString();
					}
			}		
if(board_post_count.equals(null)||board_post_count.equals(""))
			  {
			board_post_count = "1";	
			  }
			else{
			board_post_count = String.valueOf(Integer.parseInt(board_post_count)+1);	
			}
dCn.beginTrans();//事务开始
//主表保存
dImpl.setTableName("forum_post_pd");
dImpl.setPrimaryFieldName("post_id");

		dImpl.addNew();
		dImpl.setValue("board_id",board_id,CDataImpl.STRING);//话题所在主题ID
		dImpl.setValue("post_title",post_title,CDataImpl.STRING); //话题名称
	
		dImpl.setValue("post_author_id",post_author_id,CDataImpl.STRING);//发起人ID
		dImpl.setValue("post_author",post_author,CDataImpl.STRING);//发起人名
		dImpl.setValue("post_ip",post_ip,CDataImpl.STRING);//发起人IP
		dImpl.setValue("post_show_sign",post_show_sign,CDataImpl.STRING);//是否显示签名 1显示   0不显示
		dImpl.setValue("post_sign",post_sign,CDataImpl.STRING);//是否特别关注 1特别关注   0不特别关注
		dImpl.setValue("post_tiptop",post_tiptop,CDataImpl.STRING);//是否置顶：1是、0否

		dImpl.setValue("post_status",post_status,CDataImpl.STRING);//发布状态：0不发布、1发布
		dImpl.setValue("post_date",post_date,CDataImpl.DATE);//发起话题时间

		dImpl.setValue("post_click_count","1",CDataImpl.STRING);//发起人ID
		dImpl.setValue("post_revert_count","0",CDataImpl.STRING);//发起人名

		dImpl.setValue("POST_REVERT",post_author,CDataImpl.STRING);//更forum_post_pd表中的最后回复人
		dImpl.setValue("POST_REVERT_DATE",post_date,CDataImpl.DATE);//更forum_post_pd表中的最后回复时间
		dImpl.update();
		 dImpl.setClobValue("post_content",post_content);//话题内容
dImpl.edit("forum_board_pd","board_id",board_id);
dImpl.setValue("board_post_count",board_post_count,CDataImpl.STRING);//更forum_board_pd表中的新话题数
dImpl.update();


//更新forum_board_pd表中的最后回复
dImpl.edit("forum_board_pd","board_id",board_id);
dImpl.setValue("BOARD_LAST_POSTER",post_author,CDataImpl.STRING);//更forum_board_pd表中的最后回复人
dImpl.setValue("BOARD_LAST_POST_DATE",post_date,CDataImpl.DATE);//更forum_board_pd表中的最后回复时间
dImpl.update();

if (dCn.getLastErrString().equals(""))
{	
	dCn.commitTrans();	
	out.print("<script> alert('发起话题成功！');  window.location='ForumPostList.jsp?board_id="+board_id+"&sort_id="+sort_id+"';</script>");
   


}
else
{
dCn.rollbackTrans();
%>
<script language="javascript"  >
	alert("发生错误，录入失败！");
	window.history.go(-1);
</script>
<%
}	
}
catch(Exception e){
//e.printStackTrace();
out.print(e.toString());
}
finally{
dImpl.closeStmt();
dCn.closeCn(); 
}
%>