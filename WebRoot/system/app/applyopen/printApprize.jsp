<%@page contentType="text/html; charset=GBK"%>
<%@include file="/system/app/skin/import.jsp"%>
<%@include file="/system/app/islogin.jsp"%>
<link href="/system/app/applyopen/print.css" rel="stylesheet" type="text/css">
<script language="javascript" src="applyopen.js"></script>
<%
//by ph 2007-3-3  信息公开一体化
String pname = "";
String ename = "";
String infoid = "";
String infotitle = "";
String applytime = "";
String applytime_get = "";
String finishtime = "";
String applyyear = "";
String finishyear = "";

String fdname = "";

String flownum = "";
String proposer = "";
String dealmode = "";
String offermode = "";
String offermodeSTR = "";

String omode = "";
String gmode = "";
String gmodeSTR = "";

String genre = "";
String status = "";

String rreason = "";
String oreason = "";
String rentry = "";
String whatinfo = "";
String canopen = "";

String payaddress = "";

String sqlStr = "";
String strTitle = "";

String iid = "";

CDataCn dCn = null;
CDataImpl dImpl = null;

Hashtable content = null;

try{
dCn = new CDataCn();
dImpl = new CDataImpl(dCn);
SimpleDateFormat df = new SimpleDateFormat("yyyy#MM$dd%");
iid = CTools.dealString(request.getParameter("iid")).trim();
strTitle = "信息公开一体化 > 待处理任务";
sqlStr = "select i.id,i.flownum,i.proposer,i.pname,i.ename,to_char(i.applytime,'yyyy#mm$dd%') applytime,to_char(i.applytime,'yyyy/mm/dd') applytime_get,to_char(i.finishtime,'yyyy/mm/dd') finishtime,i.offermode,i.dealmode,i.fdname,i.infoid,i.infotitle,r.rreason,r.oreason,r.whatinfo,r.rentry,r.canopen,r.gmode,r.omode from infoopen i,rejectreason r where i.id = r.iid(+) and i.status = 2 and i.id = " + iid;
//out.println(sqlStr);
content = dImpl.getDataInfo(sqlStr);
if(content!=null){
	flownum = content.get("flownum").toString();
	proposer = content.get("proposer").toString();
	pname = content.get("pname").toString();
	ename = content.get("ename").toString();
	applytime = content.get("applytime").toString();
	applytime_get = content.get("applytime_get").toString();
	finishtime = content.get("finishtime").toString();
	dealmode = content.get("dealmode").toString();
	offermode = content.get("offermode").toString();

	infoid = content.get("infoid").toString();
	infotitle = content.get("infotitle").toString();

	fdname = content.get("fdname").toString();

	omode = content.get("omode").toString();
	gmode = content.get("gmode").toString();

	rreason = content.get("rreason").toString();
	oreason = content.get("oreason").toString();
	whatinfo = content.get("whatinfo").toString();
	rentry = content.get("rentry").toString();
	canopen = content.get("canopen").toString();

	String[] b = gmode.split(",");
	String[] a = {"纸面","电子邮件","磁盘"};
	for(int i=0; i<b.length; i++){
		//out.println(a[i]);
		if(b[i]!=""){
			if(Integer.parseInt(b[i])<3) gmodeSTR += a[Integer.parseInt(b[i])] + "、";
		}
	}
	if(!omode.equals("")) gmodeSTR += omode + ",";
	if(!gmodeSTR.equals("")) gmodeSTR = gmodeSTR.substring(0,gmodeSTR.length()-1);

	if(!finishtime.equals("")){
		java.util.Date dt = new java.util.Date(finishtime);
		finishyear = String.valueOf(dt.getYear()+1900);
	}

	if(!applytime_get.equals("")){
		java.util.Date dt2 = new java.util.Date(applytime_get);
		applyyear = String.valueOf(dt2.getYear()+1900);
	}
	
	/*String[] b = offermode.split(",");
	String[] a = {"纸面","电子邮件","光盘","磁盘"};
	for(int i=0; i<b.length; i++){
		//out.println(a[i]);
		if(b[i]!=""){
			if(Integer.parseInt(b[i])<4) offermodeSTR += a[Integer.parseInt(b[i])] + "、";
		}
	}
	if(!offermodeSTR.equals("")) offermodeSTR = offermodeSTR.substring(0,offermodeSTR.length()-1);
	*/
	String sqlStrD = "select dt_payaddress from (select d.dt_payaddress from taskcenter t,tb_deptinfo d where t.did = d.dt_id) where rownum = 1";
	Hashtable contentD = dImpl.getDataInfo(sqlStrD);
	if(contentD!=null) payaddress = contentD.get("dt_payaddress").toString();


	switch(Integer.parseInt(dealmode)){
		case 0://予以公开
%>
<%@include file="printInfo_a.jsp"%>
<%
		break;
		case 1://部分公开
%>
<%@include file="printInfo_b.jsp"%>
<%
		break;
		case 2://不于公开
%>
<%@include file="printInfo_c.jsp"%>
<%
		break;
		case 3://信息不存在
%>
<%@include file="printInfo_d.jsp"%>
<%
		break;
		case 6://非政府信息公开
%>
<%@include file="printInfo_e.jsp"%>
<%
		break;
		case 7://非《上海市政府信息公开规定》所指政府信息
%>
<%@include file="printInfo_g.jsp"%>
<%
		break;
		default:
%>
<%@include file="printInfo_a.jsp"%>
<%
		break;
	}
%>
	<div id="pb"><!-- <input type="button" class="bttn" name="" value=" 网上公开 " onclick="javascript:checkform();">&nbsp; --><input type="button" class="bttn" name="" value=" 打印告知书 " onclick="javascript:printIt('pb');">&nbsp;<input type="button" value=" 关闭窗口 " onclick="javascript:window.close();"></div>
<%
}else{
	out.println("获取数据错误！");
}
}catch(Exception e){
	out.print(e.toString());
}finally{
	dImpl.closeStmt();
	dCn.closeCn(); 
}
%>