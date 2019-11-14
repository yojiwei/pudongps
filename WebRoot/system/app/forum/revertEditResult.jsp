<%@page contentType="text/html; charset=GBK"%>
<%@include file="/system/app/skin/head.jsp"%>
<%
String strPage = CTools.dealString(request.getParameter("strPage")).trim();    //当前页
String sort_id = CTools.dealString(request.getParameter("sort_id")).trim(); //栏目ID
String board_id = CTools.dealString(request.getParameter("board_id")).trim(); //主题ID
String revert_id = CTools.dealString(request.getParameter("revert_id")).trim(); //跟贴ID
String post_id = CTools.dealString(request.getParameter("post_id")).trim(); //话题ID
String revert_audit_id = CTools.dealString(request.getParameter("revert_audit_id")).trim(); //回复人ID
String revert_audit = CTools.dealString(request.getParameter("revert_audit")).trim();    //回复人
String revert_title = CTools.dealString(request.getParameter("revert_title")).trim();   //回复标题
String revert_content = CTools.dealString(request.getParameter("revert_content")).trim();   //回复内容
String revert_status = CTools.dealString(request.getParameter("revert_status")).trim();    //审核状态
String revert_audit_date = "";//审核时间 
	java.text.DateFormat df = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	java.util.Date date = new java.util.Date();
	revert_audit_date = df.format(date);

String sqlStr="";
Vector vPage=null;
Hashtable ccontent=null;
CDataCn dCn = null;
CDataImpl dImpl = null;
try{
dCn = new CDataCn();
dImpl = new CDataImpl(dCn); 

dCn.beginTrans();//事务开始
//主表保存

dImpl.edit("forum_revert","revert_id",revert_id);
    dImpl.setValue("revert_audit_id",revert_audit_id,CDataImpl.STRING);
	dImpl.setValue("revert_audit",revert_audit,CDataImpl.STRING);
	dImpl.setValue("revert_title",revert_title,CDataImpl.STRING);
    dImpl.setValue("revert_status",revert_status,CDataImpl.STRING);
	dImpl.setValue("revert_audit_date",revert_audit_date,CDataImpl.DATE);
    dImpl.update();
	 dImpl.setClobValue("revert_content",revert_content);//跟贴内容		
if (dCn.getLastErrString().equals(""))
{	
	dCn.commitTrans();	
	out.print("<script> alert('修改成功！');  window.location='revertList.jsp?strPage="+strPage+"&sort_id="+sort_id+"&board_id="+board_id+"&post_id="+post_id+"';</script>");
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
out.print(e.toString());
}
finally{
dImpl.closeStmt();
dCn.closeCn(); 
}
%>