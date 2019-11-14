<%@page contentType="text/html; charset=GBK"%>
<%@include file="/system/app/skin/head.jsp"%>
<%

String sort_id = CTools.dealString(request.getParameter("sort_id")).trim();//栏目ID
String board_id = CTools.dealString(request.getParameter("board_id")).trim();//主题ID
String deleteSql="";
String post_id = "";

String sqlStr = "select post_id from forum_post_pd where board_id='"+board_id+"'";
Vector vPage = null;

CDataCn dCn = null;
CDataImpl dImpl = null;
try{
dCn = new CDataCn();
dImpl = new CDataImpl(dCn); 
//在forum_post_pd中一个board_id对应多个post_id
vPage = dImpl.splitPage(sqlStr,request,1);
if(vPage!=null)
	{
     for(int i=0;i<vPage.size();i++)
					{
							Hashtable ccontent = (Hashtable)vPage.get(i);							
							 post_id = ccontent.get("post_id").toString();
							 deleteSql="delete from forum_revert where post_id='"+post_id+"'";
							 dImpl.executeUpdate(deleteSql);
					}
}

dCn.beginTrans();//事务开始
//主表保存

deleteSql="delete from forum_board_pd where board_id='"+board_id+"'";
dImpl.executeUpdate(deleteSql);

deleteSql="delete from forum_post_pd where board_id='"+board_id+"'";
dImpl.executeUpdate(deleteSql);




if (dCn.getLastErrString().equals(""))
{	
	dCn.commitTrans();	
   out.print("<script> alert('删除成功！');  window.location='postList.jsp?sort_id="+sort_id+"';</script>");

}
else
{
dCn.rollbackTrans();
%>
<script language="javascript"  >
	alert("发生错误，录入失败！");
	//window.history.go(-1);
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