<%@page contentType="text/html; charset=GBK"%>
<%@include file="/system/app/skin/head.jsp"%>
<%
String sort_id = CTools.dealString(request.getParameter("sort_id")).trim(); //栏目ID
String post_id = CTools.dealString(request.getParameter("post_id")).trim(); //话题ID
String board_id = CTools.dealString(request.getParameter("board_id")).trim(); //话题所在主题ID

String post_title = CTools.dealString(request.getParameter("post_title")).trim();    //话题名称
String post_content = CTools.dealString(request.getParameter("post_content")).trim();   //话题内容

String post_sign = CTools.dealString(request.getParameter("post_sign")).trim();//是否特别关注 1特别关注   0不特别关注
String post_tiptop = CTools.dealString(request.getParameter("post_tiptop")).trim();  //是否置顶：1是、0否
String post_status = CTools.dealString(request.getParameter("post_status")).trim(); //发布状态：0不发布、1发布

String post_edit_date = CTools.dealString(request.getParameter("post_edit_date")).trim();//最后修改话题时间



CDataCn dCn = null;
CDataImpl dImpl = null;
try{
dCn = new CDataCn();
dImpl = new CDataImpl(dCn);
dCn.beginTrans();//事务开始
//主表保存


dImpl.edit("forum_post_pd","post_id",post_id);
		dImpl.setValue("post_title",post_title,CDataImpl.STRING); //话题名称
		dImpl.setValue("post_sign",post_sign,CDataImpl.STRING);//是否特别关注 1特别关注   0不特别关注
		dImpl.setValue("post_tiptop",post_tiptop,CDataImpl.STRING);//是否置顶：1是、0否
		dImpl.setValue("post_status",post_status,CDataImpl.STRING);//发布状态：0不发布、1发布
		dImpl.setValue("post_edit_date",post_edit_date,CDataImpl.DATE);//最后修改话题时间
		dImpl.update();
 dImpl.setClobValue("post_content",post_content);//话题内容
if (dCn.getLastErrString().equals(""))
{	
	dCn.commitTrans();	
out.print("<script> alert('修改话题成功！');  window.location='ForumPostList.jsp?sort_id="+sort_id+"&board_id="+board_id+"';</script>");

}
else
{
dCn.rollbackTrans();
%>
<script language="javascript"  >
	alert("发生错误，修改失败！");
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