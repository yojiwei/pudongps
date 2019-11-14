<%@page contentType="text/html; charset=GBK"%>
<%@include file="/system/app/skin/import.jsp"%>
<%@page import="com.app.CMySelf,com.service.log.LogservicePd" %>
<%
	String sendTime = CDate.getNowTime();
	String senderDtId = "";
	String senderUid = "";
  String ct_id_all = "";//审核的列表
	String id = "";
	String smsSql = "";
	String sm_con = "";
	String sm_sj_id = "";
	
	CDataCn dCn = null; //新建数据库连接对象
  CDataImpl dImpl = null; //新建数据接口对象
	CMySelf mySelf = null;
	Hashtable content = null;
	Vector vPage = null;
	try{
	dCn = new CDataCn(); //新建数据库连接对象
  dImpl = new CDataImpl(dCn); //新建数据接口对象
	
	mySelf = (CMySelf)session.getAttribute("mySelf");
	ct_id_all = CTools.dealString(request.getParameter("ct_id")).trim();
	id = CTools.dealString(request.getParameter("id")).trim(); //id=1 批处理审核不通过、id=null 批处理审核通过
	String [] ct_id = ct_id_all.split(",");
	if(mySelf!=null&&mySelf.isLogin())
	{
		 senderDtId = Long.toString(mySelf.getDtId());
		 senderUid = String.valueOf(mySelf.getMyUid());
	}
	
	//添加发送列表
	 for(int j = 0;j < ct_id.length;j++) {
		 if(!"".equals(id))
		 {
			 dImpl.edit("tb_sms","sm_id",ct_id[j]);
			 dImpl.setValue("sm_flag","2",CDataImpl.INT);
			 dImpl.setValue("sm_check","3",CDataImpl.INT);//审核不通过
			 dImpl.update();
		 }else{
			 dImpl.edit("tb_sms","sm_id",ct_id[j]);
			 dImpl.setValue("sm_flag","3",CDataImpl.INT);
			 dImpl.setValue("sm_check","2",CDataImpl.INT);//审核通过
			 dImpl.setValue("sm_sendtime",CDate.getNowTime(),CDataImpl.DATE);//审核通过时间
			 dImpl.update();
			 
			smsSql="select distinct u.ut_tel,s.sm_sj_id,s.sm_con from tb_usertake u,tb_sms s,subscibesetting j where u.ut_id=j.userid and j.subjectid=s.sm_sj_id and s.sm_id="+ct_id[j]+"";
			vPage = dImpl.splitPage(smsSql, 1200, 1);
			if(vPage!=null){
				String sm_tels = "";
				for(int i=0;i<vPage.size();i++){
					content = (Hashtable)vPage.get(i);
					sm_tels += CTools.dealNull(content.get("ut_tel"))+",";
					
					
					if((i+1)%100==0 || (i+1) == vPage.size()){
					
						sm_con = CTools.dealNull(content.get("sm_con"));
						sm_sj_id = CTools.dealNull(content.get("sm_sj_id"));
						
						if(sm_tels.endsWith(",")){
								sm_tels = sm_tels.substring(0,sm_tels.length()-1);
						}
						dImpl.addNew("tb_sms","sm_id");
						dImpl.setValue("sm_tel", sm_tels, CDataImpl.STRING);//用户手机号码串
						dImpl.setValue("sm_con", sm_con, CDataImpl.STRING);//发送内容手机验证码手机短信
						dImpl.setValue("sm_flag", "3", CDataImpl.INT);//发送与否的标志1已发送2没有发送3正在发送
						dImpl.setValue("sm_flagtoo","10", CDataImpl.INT);//发送的优先级别1发送验证码10发送短信内容
						dImpl.setValue("sm_check","2",CDataImpl.INT);//2审核通过的标志
						dImpl.setValue("sm_sj_id",sm_sj_id,CDataImpl.STRING);//所属栏目ID
						dImpl.setValue("sm_dtid", senderDtId, CDataImpl.STRING);//部门ID
						dImpl.setValue("sm_sendtime",CDate.getNowTime(),CDataImpl.DATE);//发布的时间
						dImpl.update();
						
						sm_tels = "";
					}
				}
			}
	  }
 }	
	 //调用.net写日志开始
		LogservicePd logservicepd = new LogservicePd();
		SimpleDateFormat logdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String log_levn = "短信审核";
		String log_description = "管理员"+senderUid+"在"+logdf.format(new java.util.Date())+"通过了："+sm_con+"的审核";
		String log_issuccess = "成功";
		logservicepd.writeLog(log_levn,log_description,log_issuccess,senderUid);
	//调用.net写日志结束
	
 }catch(Exception ex){
 			System.out.println(new java.util.Date() + "--"
			+ request.getServletPath() + " : " + ex.getMessage());
 }finally{
 		dImpl.closeStmt();
		dCn.closeCn();
 }
out.print("<script>alert('批处理操作成功！');</script>");
%>
<script>window.location.href="message.jsp";</script>