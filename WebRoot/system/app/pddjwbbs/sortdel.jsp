<%@page contentType="text/html; charset=GBK"%>
<%@include file="/system/app/skin/head.jsp"%>
<%

String sort_id = CTools.dealString(request.getParameter("sort_id")).trim();//栏目ID
String board_id = "";//主题ID

String deleteSql="";
String post_id = "";
String sqlStr = "select board_id from forum_board_pd where sort_id='"+sort_id+"'";
Vector vPage = null;
Vector vPage2 = null;
CDataCn dCn = null;
CDataImpl dImpl = null;
CDataImpl dImpl2 = null;
try{
dCn = new CDataCn("pddjw");
dImpl = new CDataImpl(dCn); 
dImpl2 = new CDataImpl(dCn); 
dCn.beginTrans();//事务开始
//下面把forum_post_pd和forum_revert表中的记录完全删掉
vPage = dImpl.splitPage(sqlStr,request,50000);
if(vPage!=null)
	{
     for(int i=0;i<vPage.size();i++)
					{
						 Hashtable ccontent = (Hashtable)vPage.get(i);							
						 board_id = ccontent.get("board_id").toString();
									//以下是删除forum_revert中的数据 
									String s_sqlStr="select post_id from forum_post_pd where board_id='"+board_id+"'";
									 vPage2 = dImpl2.splitPage(s_sqlStr,request,500000);
									if(vPage2!=null)
									{	
										  for(int j=0;j<vPage2.size();j++)
										{
											 Hashtable c_content = (Hashtable)vPage2.get(j);							
											 post_id = c_content.get("post_id").toString();
								
											 String   d_deleteSql="delete from forum_revert where post_id='"+post_id+"'";
										 dImpl.executeUpdate(d_deleteSql);								 
										 
											}
									}
						 deleteSql="delete from forum_post_pd where board_id='"+board_id+"'";
						 dImpl.executeUpdate(deleteSql); 		  
					}
   }


deleteSql="delete from forum_sort where sort_id='"+sort_id+"'";
dImpl.executeUpdate(deleteSql);

deleteSql="delete from forum_board_pd where sort_id='"+sort_id+"'";
dImpl.executeUpdate(deleteSql);


if (dCn.getLastErrString().equals(""))
{	
	dCn.commitTrans();	
   out.print("<script> alert('删除成功！');  window.location='postList.jsp?';</script>");

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