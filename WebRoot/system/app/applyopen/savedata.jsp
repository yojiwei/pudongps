<%@page contentType="text/html; charset=GBK"%>
<%@include file="/system/app/skin/head.jsp"%>
<!--
*author :may
*date 2007-03-08
*method:将数据录入数据库中
!-->
<%
	CMySelf mySelf = (CMySelf) session.getAttribute("mySelf");
	String dt_id = "";
	String dt_name = "";
	String uiid = "";
	String uiname = "";
	if (mySelf != null) {
		dt_id = String.valueOf(mySelf.getDtId());
		uiname = String.valueOf(mySelf.getMyName());
		uiid = String.valueOf(mySelf.getMyID());
	}

//update20080122

CDataCn dCn=null;   //新建数据库连接对象
CDataImpl dImpl=null;  //新建数据接口对象

try {
 dCn = new CDataCn(); 
 dImpl = new CDataImpl(dCn); 
	java.util.Date ai_date = new java.util.Date();

	String REPORTYEAR = "";
	String REPORTMONTH = "";
	REPORTYEAR = CTools.dealNumber(request.getParameter("beginYear"))
			.trim();
	REPORTMONTH = CTools.dealNumber(request.getParameter("beginMon"))
			.trim();

	//判断数据不能重复提交	
	String checkSql = "select id from iostat where did=" + dt_id
			+ " and reportyear = " + REPORTYEAR + " and reportmonth = "
			+ REPORTMONTH;
	//out.println(checkSql);
	ResultSet rs = dImpl.executeQuery(checkSql);
	if (rs.next()) {
		out.println("<script>alert('本部门" + REPORTMONTH
		+ "月的信息已经报送完毕!不能重复报送!');history.go(-1);</script>");
		return;
	}

	String ID = "";
	String DID = dt_id;
	String DNAME = dt_name;
	String DATE = "";
	String ALLEINFO = "";
	String NEWINFO = "";
	String SERVICEINFO = "";
	String COLUMNVC = "";
	String LOCALERECEIVE = "";
	String CONSULTATION = "";
	String CONTELE = "";
	String APPLYINDEX = "";
	String INTERVIEWAPPLY = "";
	String FAXAPPLY = "";
	String EMAILAPPLY = "";
	String WEBAPPLY = "";
	String LETTERAPPLY = "";
	String OTHERAPPLY = "";
	String AOPEN = "";
	String APARTOPEN = "";
	String NOINFO = "";
	String NODEPT = "";
	String NOBOUND = "";
	String NOOPEN1 = "";
	String NOOPEN2 = "";
	String NOOPEN3 = "";
	String NOOPEN4 = "";
	String NOOPEN5 = "";
	String NOOPEN6 = "";
	//新增加字段/////////////////
	String FGDSZZFXXS="";
	//////////////////////////////
	//String OTHERREASON = "";                 //其它原因
	String ADMINFUY = "";
	String ADMINSUS = "";
	String ADMINSHENS = "";
	String NOSADMINSHENS = "";
	//新增加字段/////////////////
	String ZDMAILCHARGE = "";
	String ZDSENDCHARGE = "";
	String ZDCOPYCHARGESHEET = "";
	String ZDCOPYCHARGEDISK = "";
	String ZDCOPYCHARGEFDISK = "";
	//////////////////////////////
	String SEARCHCHARGE = "";
	String MAILCHARGE = "";
	String SENDCHARGE = "";
	String COPYCHARGESHEET = "";
	String COPYCHARGEDISK = "";
	String COPYCHARGEFDISK = "";
	//String OTHERCHARGE = "";               //依申请其他收费
	String CFSQS = "";                       //重复申请
	String ALLDAYJOB = "";
	String PARTTIMEJOB = "";
	String DEALCHARGE = "";
	String DEALPAY = "";
	String ALLCHARGE = "";
	String FXSM = "";
	String GONGWENINFO = "";
	String NATIONALSECRET = "";
	String foujuegongkai = "";
	String ZHUDONGTOTALSINFO = "";

	ID = CTools.dealNull(request.getParameter("ID")).trim();
	DNAME = CTools.dealNull(request.getParameter("DNAME")).trim();
	DATE = CTools.dealNull(request.getParameter("DATE")).trim();
	ALLEINFO = CTools.dealNull(request.getParameter("ALLEINFO")).trim();
	ZHUDONGTOTALSINFO = CTools.dealNull(request.getParameter("ZHUDONGTOTALSINFO")).trim();
	NEWINFO = CTools.dealNull(request.getParameter("NEWINFO")).trim();
	SERVICEINFO = CTools.dealNull(request.getParameter("SERVICEINFO"))
			.trim();
	COLUMNVC = CTools.dealString(request.getParameter("COLUMNVC"))
			.trim();
	LOCALERECEIVE = CTools.dealString(
			request.getParameter("LOCALERECEIVE")).trim();
	FXSM = CTools.dealString(request.getParameter("FXSM")).trim();
	NATIONALSECRET = CTools.dealString(request.getParameter("NATIONALSECRET")).trim();
	foujuegongkai = CTools.dealString(request.getParameter("foujuegongkai")).trim();
	GONGWENINFO = CTools.dealString(request.getParameter("GONGWENINFO")).trim();
	CONSULTATION = CTools.dealString(
			request.getParameter("CONSULTATION")).trim();
	CONTELE = CTools.dealString(request.getParameter("CONTELE")).trim();
	APPLYINDEX = CTools.dealString(request.getParameter("APPLYINDEX"))
			.trim();
	INTERVIEWAPPLY = CTools.dealString(
			request.getParameter("INTERVIEWAPPLY")).trim();
	FAXAPPLY = CTools.dealString(request.getParameter("FAXAPPLY"))
			.trim();
	EMAILAPPLY = CTools.dealString(request.getParameter("EMAILAPPLY"))
			.trim();
	WEBAPPLY = CTools.dealString(request.getParameter("WEBAPPLY"))
			.trim();
	LETTERAPPLY = CTools
			.dealString(request.getParameter("LETTERAPPLY")).trim();
	OTHERAPPLY = CTools.dealNull(request.getParameter("OTHERAPPLY"))
			.trim();
	AOPEN = CTools.dealNumber(request.getParameter("AOPEN")).trim();
	APARTOPEN = CTools.dealNull(request.getParameter("APARTOPEN"))
			.trim();
	NOINFO = CTools.dealNull(request.getParameter("NOINFO")).trim();
	NODEPT = CTools.dealNumber(request.getParameter("NODEPT")).trim();
	NOBOUND = CTools.dealNumber(request.getParameter("NOBOUND")).trim();
	NOOPEN1 = CTools.dealNull(request.getParameter("NOOPEN1")).trim();
	NOOPEN2 = CTools.dealNull(request.getParameter("NOOPEN2")).trim();
	NOOPEN3 = CTools.dealNull(request.getParameter("NOOPEN3")).trim();
	NOOPEN4 = CTools.dealString(request.getParameter("NOOPEN4")).trim();
	NOOPEN5 = CTools.dealString(request.getParameter("NOOPEN5")).trim();
	NOOPEN6 = CTools.dealString(request.getParameter("NOOPEN6")).trim();
	//新增加字段
	FGDSZZFXXS = CTools.dealString(request.getParameter("FGDSZZFXXS")).trim();
	
	//OTHERREASON = CTools
	//		.dealString(request.getParameter("OTHERREASON")).trim();   //其它原因
	
	CFSQS = CTools
			.dealString(request.getParameter("CFSQS")).trim();          //重复申请
			
	ADMINFUY = CTools.dealString(request.getParameter("ADMINFUY"))
			.trim();

	ADMINSUS = CTools.dealString(request.getParameter("ADMINSUS"))
			.trim();
	ADMINSHENS = CTools.dealString(request.getParameter("ADMINSHENS"))
			.trim();
	NOSADMINSHENS = CTools.dealString(
			request.getParameter("NOSADMINSHENS")).trim();
	ZDMAILCHARGE = CTools.dealString(request.getParameter("ZDMAILCHARGE"))
			.trim();
	ZDSENDCHARGE = CTools.dealNull(request.getParameter("ZDSENDCHARGE"))
			.trim();
	ZDCOPYCHARGESHEET = CTools.dealNumber(
			request.getParameter("ZDCOPYCHARGESHEET")).trim();
	ZDCOPYCHARGEDISK = CTools.dealNull(
			request.getParameter("ZDCOPYCHARGEDISK")).trim();
	ZDCOPYCHARGEFDISK = CTools.dealNull(
			request.getParameter("ZDCOPYCHARGEFDISK")).trim();
	SEARCHCHARGE = CTools.dealString(
			request.getParameter("SEARCHCHARGE")).trim();
	MAILCHARGE = CTools.dealString(request.getParameter("MAILCHARGE"))
			.trim();
	SENDCHARGE = CTools.dealNull(request.getParameter("SENDCHARGE"))
			.trim();
	COPYCHARGESHEET = CTools.dealNumber(
			request.getParameter("COPYCHARGESHEET")).trim();
	COPYCHARGEDISK = CTools.dealNull(
			request.getParameter("COPYCHARGEDISK")).trim();
	COPYCHARGEFDISK = CTools.dealNull(
			request.getParameter("COPYCHARGEFDISK")).trim();


	//OTHERCHARGE = CTools
	//		.dealNumber(request.getParameter("OTHERCHARGE")).trim();  依申请公开其它费用
if(!REPORTMONTH.equals("6")&&!REPORTMONTH.equals("12"))
	{
	ALLDAYJOB = CTools.dealNumber(request.getParameter("ALLDAYJOB1"))
			.trim();
	PARTTIMEJOB = CTools.dealNull(request.getParameter("PARTTIMEJOB1"))
			.trim();
	DEALCHARGE = CTools.dealNull(request.getParameter("DEALCHARGE1"))
			.trim();
	DEALPAY = CTools.dealNull(request.getParameter("DEALPAY1")).trim();
	ALLCHARGE = CTools.dealString(request.getParameter("ALLCHARGE1"))
			.trim();
	}
else{
	ALLDAYJOB = CTools.dealNumber(request.getParameter("ALLDAYJOB"))
			.trim();
	PARTTIMEJOB = CTools.dealNull(request.getParameter("PARTTIMEJOB"))
			.trim();
	DEALCHARGE = CTools.dealNull(request.getParameter("DEALCHARGE"))
			.trim();
	DEALPAY = CTools.dealNull(request.getParameter("DEALPAY")).trim();
	ALLCHARGE = CTools.dealString(request.getParameter("ALLCHARGE"))
			.trim();
	}
	dCn.beginTrans();

	dImpl.setTableName("IOSTAT");
	dImpl.setPrimaryFieldName("ID");
	dImpl.addNew();

	dImpl.setValue("DID", DID, CDataImpl.STRING);
	dImpl.setValue("DNAME", DNAME, CDataImpl.STRING);
	dImpl.setValue("REPORTDATE", ai_date.toLocaleString(),
			CDataImpl.DATE);
	dImpl.setValue("REPORTYEAR", REPORTYEAR, CDataImpl.STRING);
	dImpl.setValue("REPORTMONTH ", REPORTMONTH, CDataImpl.STRING);
	dImpl.setValue("ALLEINFO", ALLEINFO, CDataImpl.STRING);
	dImpl.setValue("ZHUDONGTOTALSINFO", ZHUDONGTOTALSINFO, CDataImpl.STRING);
	dImpl.setValue("NEWINFO", NEWINFO, CDataImpl.STRING);
	dImpl.setValue("SERVICEINFO", SERVICEINFO, CDataImpl.STRING);

	dImpl.setValue("COLUMNVC", COLUMNVC, CDataImpl.STRING);
	dImpl.setValue("LOCALERECEIVE", LOCALERECEIVE, CDataImpl.STRING);
	dImpl.setValue("CONSULTATION", CONSULTATION, CDataImpl.STRING);
	dImpl.setValue("CONTELE", CONTELE, CDataImpl.STRING);
	dImpl.setValue("APPLYINDEX", APPLYINDEX, CDataImpl.STRING);
	dImpl.setValue("INTERVIEWAPPLY", INTERVIEWAPPLY, CDataImpl.STRING);

	dImpl.setValue("FAXAPPLY", FAXAPPLY, CDataImpl.STRING);
	dImpl.setValue("EMAILAPPLY", EMAILAPPLY, CDataImpl.STRING);
	dImpl.setValue("WEBAPPLY", WEBAPPLY, CDataImpl.STRING);
	dImpl.setValue("LETTERAPPLY", LETTERAPPLY, CDataImpl.STRING);
	dImpl.setValue("OTHERAPPLY", OTHERAPPLY, CDataImpl.STRING);
	dImpl.setValue("AOPEN", AOPEN, CDataImpl.STRING);
	dImpl.setValue("APARTOPEN", APARTOPEN, CDataImpl.STRING);
	dImpl.setValue("NOINFO", NOINFO, CDataImpl.STRING);
	dImpl.setValue("NODEPT", NODEPT, CDataImpl.STRING);
	dImpl.setValue("NOBOUND", NOBOUND, CDataImpl.STRING);
	dImpl.setValue("NOOPEN1", NOOPEN1, CDataImpl.STRING);
	dImpl.setValue("NOOPEN2", NOOPEN2, CDataImpl.STRING);
	dImpl.setValue("NOOPEN3", NOOPEN3, CDataImpl.STRING);
	dImpl.setValue("NOOPEN4", NOOPEN4, CDataImpl.STRING);
	dImpl.setValue("NOOPEN5", NOOPEN5, CDataImpl.STRING);
	dImpl.setValue("NOOPEN6", NOOPEN6, CDataImpl.STRING);
	//新增加字段
	dImpl.setValue("FGDSZZFXXS", FGDSZZFXXS, CDataImpl.STRING);
	
	//dImpl.setValue("OTHERREASON", OTHERREASON, CDataImpl.STRING);    //其它原因
	dImpl.setValue("CFSQS", CFSQS, CDataImpl.STRING);                  //重复申请数
	
	dImpl.setValue("ADMINFUY", ADMINFUY, CDataImpl.STRING);
	dImpl.setValue("ADMINSUS", ADMINSUS, CDataImpl.STRING);
	dImpl.setValue("ADMINSHENS", ADMINSHENS, CDataImpl.STRING);
	dImpl.setValue("NOSADMINSHENS", NOSADMINSHENS, CDataImpl.STRING);
	//新增加字段
	dImpl.setValue("ZDMAILCHARGE", ZDMAILCHARGE, CDataImpl.STRING);
	dImpl.setValue("ZDSENDCHARGE", ZDSENDCHARGE, CDataImpl.STRING);
	dImpl.setValue("ZDCOPYCHARGESHEET", ZDCOPYCHARGESHEET,CDataImpl.STRING);
	dImpl.setValue("ZDCOPYCHARGEDISK", ZDCOPYCHARGEDISK, CDataImpl.STRING);
	dImpl.setValue("ZDCOPYCHARGEFDISK", ZDCOPYCHARGEFDISK,CDataImpl.STRING);
	/////////////////////////
	dImpl.setValue("SEARCHCHARGE", SEARCHCHARGE, CDataImpl.STRING);
	dImpl.setValue("MAILCHARGE", MAILCHARGE, CDataImpl.STRING);
	dImpl.setValue("SENDCHARGE", SENDCHARGE, CDataImpl.STRING);
	dImpl.setValue("COPYCHARGESHEET", COPYCHARGESHEET,CDataImpl.STRING);
	dImpl.setValue("COPYCHARGEDISK", COPYCHARGEDISK, CDataImpl.STRING);
	dImpl.setValue("COPYCHARGEFDISK", COPYCHARGEFDISK,CDataImpl.STRING);
	dImpl.setValue("ALLDAYJOB", ALLDAYJOB, CDataImpl.STRING);
	dImpl.setValue("PARTTIMEJOB", PARTTIMEJOB, CDataImpl.STRING);
	dImpl.setValue("DEALCHARGE", DEALCHARGE, CDataImpl.STRING);
	dImpl.setValue("DEALPAY", DEALPAY, CDataImpl.STRING);
	dImpl.setValue("ALLCHARGE", ALLCHARGE, CDataImpl.STRING);
	dImpl.setValue("uiid", uiid, CDataImpl.STRING);
	dImpl.setValue("uiname", uiname, CDataImpl.STRING);
	dImpl.setValue("FXSM", FXSM, CDataImpl.STRING);
	dImpl.setValue("GONGWENINFO", GONGWENINFO, CDataImpl.STRING);
	dImpl.setValue("NATIONALSECRET", NATIONALSECRET, CDataImpl.STRING);
	dImpl.setValue("foujuegongkai", foujuegongkai, CDataImpl.STRING);
	
	dImpl.update();

	if (dCn.getLastErrString().equals("")) {
		dCn.commitTrans();
%>
<script language="javascript">
		alert("操作已成功！");
		window.location="xixs.jsp";
	</script>
<%
		} else {
		dCn.rollbackTrans();
%>
<script language="javascript">
		alert("发生错误，录入失败！");
		window.history.go(-1);
	</script>
<%
	}


} catch (Exception ex) {
	System.out.println(new java.util.Date() + "--"
			+ request.getServletPath() + " : " + ex.getMessage());
} finally {
	if(dImpl != null)
	dImpl.closeStmt();
	if(dCn != null)
	dCn.closeCn();
}
	//response.sendRedirect("workshoplist.jsp");
%>
