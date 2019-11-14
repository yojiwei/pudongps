<%@page contentType="text/html; charset=GBK"%>
<%@include file="/system/app/skin/head.jsp"%>
<%
String sort_id = CTools.dealString(request.getParameter("sort_id")).trim();//栏目ID
String post_id = CTools.dealString(request.getParameter("post_id")).trim();//话题ID
String board_id ="";//主题ID
String deleteSql="";
Vector vPage = null;
String sqlStr = "select board_id from forum_post_pd where post_id='"+post_id+"'";
String board_post_count="";//board_id下的话题数量
CDataCn dCn = null;
CDataImpl dImpl = null;
try{
dCn = new CDataCn();
dImpl = new CDataImpl(dCn); 


vPage = dImpl.splitPage(sqlStr,request,1);
if(vPage!=null)
	{
     for(int i=0;i<vPage.size();i++)
					{
							Hashtable ccontent = (Hashtable)vPage.get(i);							
							 board_id = ccontent.get("board_id").toString();
					}
}
//board_id下的话题数量
sqlStr="select count(*) as total from forum_post_pd where board_id="+board_id;
vPage = dImpl.splitPage(sqlStr,request,1);
if(vPage!=null)
	{
     for(int i=0;i<vPage.size();i++)
					{
							Hashtable ccontent = (Hashtable)vPage.get(i);							
							 board_post_count = ccontent.get("total").toString();
					}
}

if(board_post_count.equals(null)||board_post_count.equals("")||board_post_count.equals("0"))
			  {
			board_post_count ="0";	
			  }
			else{
			board_post_count = String.valueOf(Integer.parseInt(board_post_count)-1);	
			    }

dCn.beginTrans();//事务开始
//主表保存
dImpl.edit("forum_board_pd","board_id",board_id);
dImpl.setValue("board_post_count",board_post_count,CDataImpl.STRING);//更forum_board_pd表中的主题的总贴数
dImpl.update();

deleteSql="delete from forum_post_pd where post_id='"+post_id+"'";
dImpl.executeUpdate(deleteSql);

deleteSql="delete from forum_revert where post_id='"+post_id+"'";
dImpl.executeUpdate(deleteSql);

if (dCn.getLastErrString().equals(""))
{	
	dCn.commitTrans();	
   out.print("<script> alert('删除成功！');  window.location='ForumPostList.jsp?sort_id="+sort_id+"&board_id="+board_id+"';</script>");

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