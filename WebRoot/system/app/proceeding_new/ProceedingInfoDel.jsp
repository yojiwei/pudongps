<%@page contentType="text/html; charset=GBK"%>
<%@include file="../skin/import.jsp"%>
<%@page import="java.util.*,com.webservise.NewProceedingService"%>
<%
String projectId = ""; //事项ID
String curpage= ""; //返回页面
String pa_id = ""; //事项表格ID
String pa_path = ""; //事项表格路径
String pa_filename = ""; //事项表格名称
String path = ""; //事项表格附件物理路径
String sm_nowtime = CDate.getNowTime();//当前详细时间
String us_uid = "";//后台操作用户名
String log_levn = "网上办事";//日志类型
String log_description = "";//日志描述
String issuccess = "";//是否操作成功
CDataCn dCn = null;
CDataImpl dImpl = null;
Hashtable delContent = null;
com.service.log.LogservicePd logservicepd = new com.service.log.LogservicePd();
com.app.CMySelf mySelf = (com.app.CMySelf)session.getAttribute("mySelf");
if(mySelf!=null){
	us_uid = mySelf.getMyUid();
}

projectId = CTools.dealString(request.getParameter("projectId")).trim();
try{

if (!projectId.equals(""))
{
		dCn = new CDataCn();
		dImpl = new CDataImpl(dCn);
		curpage= CTools.dealString(request.getParameter("curpage"));
		path = dImpl.getInitParameter("proceeding_path");

		//调用机器人删除机器人数据库办事事项
		/*NewProceedingService nps = new NewProceedingService();
		nps.proceeding("delete",projectId);*/
		
		//--

		dCn.beginTrans();
		//删除办事事项中的事项
		dImpl.delete("tb_proceeding_new","pr_id",projectId);
		//删除物理机上面的附件
		/*String delfileSql = "select pa_id,pa_path,pa_filename from tb_proceedingattach_new where pr_id = '"+projectId+"'";
		Vector vDel = dImpl.splitPageOpt(delfileSql,20,1);
		if(vDel!=null)
		{
			for(int i=0;i<vDel.size();i++)
			{
				delContent = (Hashtable)vDel.get(i);
				pa_id = CTools.dealNull(delContent.get("pa_id"));
				pa_path = CTools.dealNull(delContent.get("pa_path"));
				pa_filename = CTools.dealNull(delContent.get("pa_filename"));
				
				//out.println(path+pa_path+"\\\\"+pa_filename);
				//if(true)return;
				
				File file = new File(path+pa_path+"\\\\"+pa_filename);
				if(file.exists() && file.isFile()) {
					if(file.delete()) {
						log_description = sm_nowtime+us_uid+"后台用户删除事项"+projectId+"附件"+pa_filename+"成功！";
						issuccess = "成功";
					} else {
						log_description = sm_nowtime+us_uid+"后台用户删除事项"+projectId+"附件"+pa_filename+"失败！";
						issuccess = "失败";
					}
				}
			}
		}
		logservicepd.writeLog(log_levn,log_description,issuccess,us_uid);
		*/
		//删除办事事项表格中的数据
		dImpl.delete("tb_proceedingattach_new","pr_id",projectId);
		
		dCn.commitTrans();

		dImpl.closeStmt();
		dCn.closeCn();
}else{
	out.print("<script>alert(\"请选择需要删除的事项!\");</script>");
}
}catch(Exception ex){
	out.print(ex.toString());
}
%>
<script>
	window.location.href="ProceedingList.jsp?OType=manage&myname=wssb&strPage=<%=curpage%>";
</script>
