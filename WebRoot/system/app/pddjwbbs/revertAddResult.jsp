<%@page contentType="text/html; charset=GBK"%>
<%@include file="/system/app/skin/head.jsp"%>
<%//禁止页面缓存
response.addHeader("Cache-Control", "no-cache");
response.addHeader("Expires", "Thu, 01 Jan 1970 00:00:01 GMT");
%>
<%
String strPage = CTools.dealString(request.getParameter("strPage")).trim();    //当前页
String sort_id = CTools.dealString(request.getParameter("sort_id")).trim(); //栏目ID
String board_id = CTools.dealString(request.getParameter("board_id")).trim(); //主题ID
String post_id = CTools.dealString(request.getParameter("post_id")).trim(); //话题ID
String revert_author_id = CTools.dealString(request.getParameter("revert_author_id")).trim(); //回复人ID
String revert_author = CTools.dealString(request.getParameter("revert_author")).trim();    //回复人
String revert_ip = CTools.dealString(request.getParameter("revert_ip")).trim();   //回复人IP
String revert_title = CTools.dealString(request.getParameter("revert_title")).trim();   //回复标题 
String revert_content = CTools.dealString(request.getParameter("revert_content")).trim();   //回复内容
String revert_show_sign = "1";   //是否显示签名1是0否
String revert_status ="1";				//审核状态  0未审核、1审核通过、2审核不通过 
String revert_date ="";   //回复日期
String sqlStr="";
Vector vPage=null;
Hashtable ccontent=null;
String post_revert_count="";//forum_post_pd中的跟贴数
String board_main_post_count="";////forum_board_pd中的贴数总数
java.text.DateFormat df = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	java.util.Date date = new java.util.Date();
	revert_date = df.format(date);
//System.out.println("==================="+revert_date);
String revert_length=String.valueOf(revert_content.length());//回复的长度
CDataCn dCn = null;
CDataImpl dImpl = null;
try{
dCn = new CDataCn("pddjw");
dImpl = new CDataImpl(dCn); 

dCn.beginTrans();//事务开始
//主表保存
dImpl.setTableName("forum_revert");
dImpl.setPrimaryFieldName("revert_id");
	dImpl.addNew();
    dImpl.setValue("post_id",post_id,CDataImpl.STRING);
	dImpl.setValue("revert_author_id",revert_author_id,CDataImpl.STRING);
	dImpl.setValue("revert_title",revert_title,CDataImpl.STRING);
	dImpl.setValue("revert_author",revert_author,CDataImpl.STRING);
    dImpl.setValue("revert_ip",revert_ip,CDataImpl.STRING);
	dImpl.setValue("revert_status",revert_status,CDataImpl.STRING);	dImpl.setValue("revert_show_sign",revert_show_sign,CDataImpl.STRING);
	dImpl.setValue("revert_date",revert_date,CDataImpl.DATE);
	dImpl.setValue("revert_audit_date",revert_date,CDataImpl.DATE); 
    dImpl.update();
	 dImpl.setClobValue("revert_content",revert_content);//跟贴内容

//更forum_post_pd表中的话题的跟贴数	
sqlStr = "select count(*) as total from forum_revert where post_id="+post_id;
	 vPage = dImpl.splitPage(sqlStr,request,1);
			if (vPage!=null)
			{
					for(int i=0;i<vPage.size();i++)
					{
							 ccontent = (Hashtable)vPage.get(i);
							 post_revert_count=ccontent.get("total").toString();
							
					}
			}
		
dImpl.edit("forum_post_pd","post_id",post_id);
dImpl.setValue("post_revert_count",post_revert_count,CDataImpl.STRING);//更forum_post_pd表中的话题的跟贴数
dImpl.update();
//更新forum_post_pd表中的最后回复
dImpl.edit("forum_post_pd","post_id",post_id);
dImpl.setValue("POST_REVERT",revert_author,CDataImpl.STRING);//更forum_post_pd表中的最后回复人
dImpl.setValue("POST_REVERT_DATE",revert_date,CDataImpl.DATE);//更forum_post_pd表中的最后回复时间
dImpl.update();
//更新forum_board_pd表中的最后回复
dImpl.edit("forum_board_pd","board_id",board_id);
dImpl.setValue("BOARD_LAST_POSTER",revert_author,CDataImpl.STRING);//更forum_board_pd表中的最后回复人
dImpl.setValue("BOARD_LAST_POST_DATE",revert_date,CDataImpl.DATE);//更forum_board_pd表中的最后回复时间
dImpl.update();
			
if (dCn.getLastErrString().equals(""))
{	
	dCn.commitTrans();	
	out.print("<script> alert('回复成功！');  window.location='revertList.jsp?strPage="+strPage+"&sort_id="+sort_id+"&board_id="+board_id+"&post_id="+post_id+"';</script>");
 }
else
{
dCn.rollbackTrans();
%>
<script language="javascript"  >
	alert("发生错误，回复失败！");
	window.history.go(-1);
</script>
<%
}	
}
catch(Exception e){
out.print(e.toString());
}
finally{
dImpl.closeStmt();
dCn.closeCn(); 
}
%>