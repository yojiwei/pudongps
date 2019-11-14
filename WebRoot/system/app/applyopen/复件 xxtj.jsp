<%@page contentType="text/html; charset=GBK"%>
<%@include file="/system/app/skin/head.jsp"%>
<script language="javascript">
function todo(id,val) {
	var obj;
	obj = document.getElementById(id);
	obj.innerHTML = val;
}
</script>
<%
	//by ph 2007-3-3  信息统计 
	String ID = "";
	String ename = "";
	String infoid = "";
	String infotitle = "";
	String applytime = "";
	String genre = "";
	String status = "";
	String method=CTools.dealString(request.getParameter("look"));
	String sqlStr = "";
	String sqlStrYear = "";
	String strTitle = "浦东新区政府信息公开月报";
	String getbeginYear = CTools.dealString(
			request.getParameter("beginYear")).trim();
	String getbeginMon = CTools.dealString(
			request.getParameter("beginMon")).trim();

	String dt_id = CTools.dealString(request.getParameter("dt_id")).trim();
	String dt_name = "";
	String dt_ids = "";
	String FXSM = "";

	CDataCn dCn = null;
	CDataImpl dImpl = null;

	Vector vPage = null;
	Hashtable content = null;
	ResultSet rs = null;
	ResultSetMetaData rsmd = null;
	ResultSet rsYear = null;
	ResultSetMetaData rsmdYear = null;

	try {
		dCn = new CDataCn();
		dImpl = new CDataImpl(dCn);

		if (!"".equals(dt_id)) {
			String dtSql = "select dt_name from tb_deptinfo where dt_id = '"+ dt_id +"'";
			Hashtable dtContent = dImpl.getDataInfo(dtSql);
			if (dtContent != null) {
				dt_name = dtContent.get("dt_name").toString();
			}
		}
	else {
			String dtSql = "select dt_id from tb_deptinfo where dt_name = '公安分局' or dt_name = '税务局' or dt_name = '质监局' or dt_name = '食品药品监管局' or dt_name = '工商分局'";
			Vector dtList = dImpl.splitPage(dtSql,20,1);
			if (dtList != null) {
				for (int j=0;j<dtList.size();j++) {
					Hashtable dtContent = (Hashtable)dtList.get(j);
					dt_ids += dtContent.get("dt_id").toString();
					if (j+1<dtList.size()) {
						dt_ids += ",";
					}
				}
			}
		}
//<!--  分析说明  -->
		sqlStr = "select fxsm from iostat where reportyear = "
		+ getbeginYear + " and uiid in (select ui_id from tb_userinfo where dt_id = " + dt_id + ") and reportmonth <= " + getbeginMon;
		//out.println(sqlStr);
		content = dImpl.getDataInfo(sqlStr);
		if(content!=null) FXSM = content.get("fxsm").toString();
//<!--  结束   -->
		
		//统计数据库中数据的条数
		sqlStr = "select sum(GONGWENINFO) as GONGWENINFO,sum(ZHUDONGTOTALSINFO) as ZHUDONGTOTALSINFO,sum(alleinfo) as alleinfo,sum(newinfo) as newinfo,sum(serviceinfo) as serviceinfo,"
		+ "sum(columnvc) as columnvc,sum(localereceive) as localereceive,sum(consultation) as consultation,"
		+ "sum(contele) as contele,sum(applyindex) as applyindex,sum(NATIONALSECRET) as NATIONALSECRET,sum(interviewapply) as interviewapply,"
		+ "sum(faxapply) as faxapply,sum(emailapply) as emailapply,sum(webapply) as webapply,"
		+ "sum(letterapply) as letterapply,sum(otherapply) as otherapply,sum(aopen) as aopen,"
		+ "sum(apartopen) as apartopen,sum(noinfo) as noinfo,sum(nodept) as nodept,sum(nobound) as nobound,"
		+ "sum(noopen1) as noopen1,sum(noopen2) as noopen2,sum(noopen3) as noopen3,sum(noopen4) as noopen4,"
		+ "sum(noopen5) as noopen5,sum(noopen6) as noopen6,sum(fgdszzfxxs) as fgdszzfxxs,"
		+ "sum(adminfuy) as adminfuy,sum(adminsus) as adminsus,sum(adminshens) as adminshens,"
		+ "sum(zdmailcharge) as zdmailcharge,"
		+ "sum(zdcopychargesheet) as zdcopychargesheet,sum(zdcopychargedisk) as zdcopychargedisk,"
		+ "sum(zdcopychargefdisk) as zdcopychargefdisk,sum(searchcharge) as searchcharge,sum(mailcharge) as mailcharge,"
		+ "sum(copychargesheet) as copychargesheet,sum(copychargedisk) as copychargedisk,"
		+ "sum(copychargefdisk) as copychargefdisk,sum(cfsqs) as cfsqs,sum(alldayjob) as alldayjob,"
		+ "sum(parttimejob) as parttimejob,sum(dealcharge) as dealcharge,sum(dealpay) as dealpay,"
		+ "sum(allcharge) as  allcharge from iostat where reportyear = "
		+ getbeginYear + " and reportmonth = " + getbeginMon;
		

		sqlStrYear = "select sum(alleinfo) as alleinfoyear,sum(ZHUDONGTOTALSINFO) as ZHUDONGTOTALSINFOyear,sum(GONGWENINFO) as GONGWENINFOyear,sum(newinfo) as newinfoyear,sum(serviceinfo) as serviceinfoyear,"
		+ "sum(columnvc) as columnvcyear,sum(localereceive) as localereceiveyear,sum(consultation) as consultationyear,"
		+ "sum(contele) as conteleyear,sum(applyindex) as applyindexyear,sum(NATIONALSECRET) as NATIONALSECRETyear,sum(interviewapply) as interviewapplyyear,"
		+ "sum(faxapply) as faxapplyyear,sum(emailapply) as emailapplyyear,sum(webapply) as webapplyyear,"
		+ "sum(letterapply) as letterapplyyear,sum(otherapply) as otherapplyyear,sum(aopen) as aopenyear,"
		+ "sum(apartopen) as apartopenyear,sum(noinfo) as noinfoyear,sum(nodept) as nodeptyear,sum(nobound) as noboundyear,"
		+ "sum(noopen1) as noopen1year,sum(noopen2) as noopen2year,sum(noopen3) as noopen3year,sum(noopen4) as noopen4year,"
		+ "sum(noopen5) as noopen5year,sum(noopen6) as noopen6year,sum(fgdszzfxxs) as fgdszzfxxsyear,"
		+ "sum(adminfuy) as adminfuyyear,sum(adminsus) as adminsusyear,sum(adminshens) as adminshensyear,"
		+ "sum(zdmailcharge) as zdmailchargeyear,"
		+ "sum(zdcopychargesheet) as zdcopychargesheetyear,sum(zdcopychargedisk) as zdcopychargediskyear,"
		+ "sum(zdcopychargefdisk) as zdcopychargefdiskyear,sum(searchcharge) as searchchargeyear,sum(mailcharge) as mailchargeyear,"
		+ "sum(copychargesheet) as copychargesheetyear,sum(copychargedisk) as copychargediskyear,"
		+ "sum(copychargefdisk) as copychargefdiskyear,sum(cfsqs) as cfsqsyear,"
		+ "sum(dealcharge) as dealchargeyear,sum(dealpay) as dealpayyear,"
		+ "sum(allcharge) as  allchargeyear from iostat where reportyear = "
		+ getbeginYear + " and reportmonth <= " + getbeginMon;
		
		if (!"".equals(dt_id)) {
			sqlStr += " and uiid in (select ui_id from tb_userinfo where dt_id = " + dt_id + ") and did = " + dt_id;
			sqlStrYear  += " and uiid in (select ui_id from tb_userinfo where dt_id = " + dt_id + ") and did = " + dt_id; 
		}else {
			sqlStr += " and uiid not in (select ui_id from tb_userinfo where dt_id in (" + dt_ids + ")) and did not in (" + dt_ids + ")";
			sqlStrYear  += " and uiid not in (select ui_id from tb_userinfo where dt_id in (" + dt_ids + ")) and did not in (" + dt_ids + ")";
		}
		
%>
<%@include file="/system/app/skin/skin4/template/list_top.jsp"%>
<!--    模块名称开始    -->
<%=strTitle%>
<!--    模块名称结束    -->
<%@include file="/system/app/skin/skin4/template/list_function.jsp"%>                                                            
<!--    功能按钮开始    -->
<img src="../../images/goback.gif" border="0"onclick="javascript:history.back();" title="返回"
style="cursor:hand" align="absmiddle">
返回
<!--    功能按钮结束    -->
<%@include file="/system/app/skin/skin4/template/list_listtop.jsp"%>                                                                                        
<!--    列表开始    -->
<form name="formData" action="xqcx.jsp" method="post">
<table class="FindAreaTable1" cellspacing="1" rules="cols" border="0" id="ctl00_DataGrid_DataGrid1" style="border-width:0px;">
					<tr>
						<td colspan="5" align="center">
							<table WIDTH="100%" BORDER="0" CELLSPACING="0" CELLPADDING="2">
								<tr class="bttn">
									<td width="15%" align="center" class="outset-table">
										<%=getbeginYear%>
										年
										<%=getbeginMon%>
										月　<%=dt_name%>
										<input name="beginYear" type="hidden"
											value="<%=getbeginYear%>">
										<input type="hidden" name="beginMon" value="<%=getbeginMon%>">
									</td>
								</tr>
							</table>
						</td>
					</tr>
					<tr class="bttn">
						<td width="40%" class="outset-table">
							指标名称
						</td>
						<td width="15%" class="outset-table">
							计算单位
						</td>
						<td width="15%" class="outset-table">
							代码
						</td>
						<td width="15%" class="outset-table">
							本月累计
						</td>
						<td width="15%" class="outset-table">
							年度累计
						</td>
					</tr>

					<tr class="bttn">

						<td align="left">
							主动信息公开
						</td>
						<td align="center">
							条
						</td>
						<td align="center">
							01
						</td>
						<td>
							<div id="ZHUDONGTOTALSINFO" align="center"></div>
						</td>
						<td>
							<div id="ZHUDONGTOTALSINFO1year" align="center"></div>
						</td>
					</tr>

					<tr class="bttn">
						<td align="left">
							&nbsp;&nbsp;&nbsp;其中：全文电子化的主动公开信息数
						</td>
						<td align="center">
							条
						</td>
						<td align="center">
							02
						</td>
						<td align="center">
							<div id="ALLEINFO" align="center"></div>
						</td>
						<td align="center">
							<div id="ALLEINFOyear" align="center"></div>
						</td>
					</tr>
					<tr class="bttn">

						<td align="left">
							&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;公文类信息数
						</td>
						<td align="center">
							条
						</td>
						<td align="center">
							03
						</td>
						<td align="center">
							<div id="GONGWENINFO" align="center"></div>
						</td>
						<td>
							<div id="GONGWENINFOyear" align="center"></div>
						</td>
					</tr>
					<tr class="bttn">
						<td align="left">	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;其中：新增的行政规范性文件数
						</td>
						<td align="center">
							条
						</td>
						<td align="center">
							04
						</td>
						<td align="center">
							<div id="NEWINFO" align="center"></div>
						</td>
						<td align="center">
							<div id="NEWINFOyear" align="center"></div>
						</td>
					</tr>
					<tr class="bttn">
						<td align="left">
							提供服务类信息数
						</td>
						<td align="center">
							条
						</td>
						<td align="center">
							05
						</td>
						<td align="center">
							<div id="SERVICEINFO" align="center"></div>
						</td>
						<td align="center">
							<div id="SERVICEINFOyear" align="center"></div>
						</td>
					</tr>
					<tr class="bttn">
						<td align="left">
							网站专栏页面访问量
						</td>
						<td align="center">
							人次
						</td>
						<td align="center">
							06
						</td>
						<td align="center">
							<div id="COLUMNVC" align="center"></div>
						</td>
						<td align="center">
							<div id="COLUMNVCyear" align="center"></div>
						</td>
					</tr>
					<tr class="bttn">
						<td align="left">
							现场接待人数
						</td>
						<td align="center">
							人次
						</td>
						<td align="center">
							07
						</td>
						<td align="center">
							<div id="LOCALERECEIVE" align="center"></div>
						</td>
						<td align="center">
							<div id="LOCALERECEIVEyear" align="center"></div>
						</td>
					</tr>
					<tr class="bttn">
						<td align="left">
							网上咨询数
						</td>
						<td align="center">
							人次
						</td>
						<td align="center">
							08
						</td>
						<td align="center">
							<div id="CONSULTATION" align="center"></div>
						</td>
						<td align="center">
							<div id="CONSULTATIONyear" align="center"></div>
						</td>
					</tr>
					<tr class="bttn">
						<td align="left">
							咨询电话接听数
						</td>
						<td align="center">
							人次
						</td>
						<td align="center">
							09
						</td>
						<td align="center">
							<div id="CONTELE" align="center"></div>
						</td>
						<td align="center">
							<div id="CONTELEyear" align="center"></div>
						</td>
					</tr>
					<tr class="bttn">
						<td align="left">
							依申请公开信息目录数
						</td>
						<td align="center">
							条
						</td>
						<td align="center">
							10
						</td>
						<td align="center">
							<div id="APPLYINDEX" align="center"></div>
						</td>
						<td align="center">
							<div id="APPLYINDEXyear" align="center"></div>
						</td>
					</tr>
					
					<tr class="bttn">
						<td align="left">
							属于国家秘密的公文类信息数
						</td>
						<td align="center">
							条
						</td>
						<td align="center">
							11
						</td>
						<td align="center">
							<div id="NATIONALSECRET" align="center"></div>
						</td>
												<td align="center">
							<div id="NATIONALSECRETyear" align="center"></div>
						</td>
					</tr>

					<tr class="bttn">
						<td align="left">
							申请总次数
						</td>
						<td align="center">
							条
						</td>
						<td align="center">
							12
						</td>
						<td align="center">
							<div id="yishen" align="center"></div>
						</td>
						<td align="center">
							<div id="yishenyear" align="center"></div>
						</td>
					</tr>
					<tr class="bttn">
						<td align="left">
							&nbsp;&nbsp;&nbsp;其中：1.当面申请数
						</td>
						<td align="center">
							条
						</td>
						<td align="center">
							13
						</td>
						<td align="center">
							<div id="INTERVIEWAPPLY" align="center"></div>
						</td>
						<td align="center">
							<div id="INTERVIEWAPPLYyear" align="center"></div>
						</td>
					</tr>
					<tr class="bttn">
						<td align="left">
							&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;2.传真申请数
						</td>
						<td align="center">
							条
						</td>
						<td align="center">
							14
						</td>
						<td align="center">
							<div id="FAXAPPLY" align="center"></div>
						</td>
						<td align="center">
							<div id="FAXAPPLYyear" align="center"></div>
						</td>
					</tr>
					<tr class="bttn">
						<td align="left">
							&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;3.电子邮件申请数
						</td>
						<td align="center">
							条
						</td>
						<td align="center">
							15
						</td>
						<td align="center">
							<div id="EMAILAPPLY" align="center"></div>
						</td>
						<td align="center">
							<div id="EMAILAPPLYyear" align="center"></div>
						</td>
					</tr>
					<tr class="bttn">
						<td align="left">
							&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;4.网上申请数
						</td>
						<td align="center">
							条
						</td>
						<td align="center">
							16
						</td>
						<td align="center">
							<div id="WEBAPPLY" align="center"></div>
						</td>
						<td align="center">
							<div id="WEBAPPLYyear" align="center"></div>
						</td>
					</tr>
					<tr class="bttn">
						<td align="left">
							&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;5.信函申请数
						</td>
						<td align="center">
							条
						</td>
						<td align="center">
							17
						</td>
						<td align="center">
							<div id="LETTERAPPLY" align="center"></div>
						</td>
						<td align="center">
							<div id="LETTERAPPLYyear" align="center"></div>
						</td>
					</tr>
					<tr class="bttn">
						<td align="left">
							&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;6.其它形式申请数
						</td>
						<td align="center">
							条
						</td>
						<td align="center">
							18
						</td>
						<td align="center">
							<div id="OTHERAPPLY" align="center"></div>
						</td>
						<td align="center">
							<div id="OTHERAPPLYyear" align="center"></div>
						</td>
					</tr>
					<tr class="bttn">
						<td align="left">
							对申请的答复总数
						</td>
						<td align="center">
							条
						</td>
						<td align="center">
							19
						</td>
						<td align="center">
							<div id="shenzong" align="center"></div>
						</td>
						<td align="center">
							<div id="shenzongyear" align="center"></div>
						</td>
					</tr>
					<tr class="bttn">
						<td align="left">
							&nbsp;&nbsp;&nbsp;其中：1.同意公开答复数
						</td>
						<td align="center">
							条
						</td>
						<td align="center">
							20
						</td>
						<td align="center">
							<div id="AOPEN" align="center"></div>
						</td>
						<td align="center">
							<div id="AOPENyear" align="center"></div>
						</td>
					</tr>
					<tr class="bttn">
						<td align="left">
							&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;2.同意部分公开答复数
						</td>
						<td align="center">
							条
						</td>
						<td align="center">
							21
						</td>
						<td align="center">
							<div id="APARTOPEN" align="center"></div>
						</td>
						<td align="center">
							<div id="APARTOPENyear" align="center"></div>
						</td>
					</tr>
					<tr class="bttn">
						<td align="left">
							&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;3.非《规定》所指政府信息数
						</td>
						<td align="center">
							条
						</td>
						<td align="center">
							22
						</td>
						<td align="center">
							<div id="FGDSZZFXXS" align="center"></div>
						</td>
						<td align="center">
							<div id="FGDSZZFXXSyear" align="center"></div>
						</td>
					</tr>
					<tr class="bttn">
						<td align="left">
							&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;4.信息不存在数
						</td>
						<td align="center">
							条
						</td>
						<td align="center">
							23
						</td>
						<td align="center">
							<div id="NOINFO" align="center"></div>
						</td>
						<td align="center">
							<div id="NOINFOyear" align="center"></div>
						</td>
					</tr>
					<tr class="bttn">
						<td align="left">
							&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;5.非本机关职权范围数
						</td>
						<td align="center">
							条
						</td>
						<td align="center">
							24
						</td>
						<td align="center">
							<div id="NODEPT" align="center"></div>
						</td>
						<td align="center">
							<div id="NODEPTyear" align="center"></div>
						</td>
					</tr>
					<tr class="bttn">
						<td align="left">
							&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;6.申请内容不明确数
						</td>
						<td align="center">
							条
						</td>
						<td align="center">
							25
						</td>
						<td align="center">
							<div id="NOBOUND" align="center"></div>
						</td>
						<td align="center">
							<div id="NOBOUNDyear" align="center"></div>
						</td>
					</tr>
					<tr class="bttn">
						<td align="left">
							&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;7.重复申请数
						</td>
						<td align="center">
							条
						</td>
						<td align="center">
							26
						</td>
						<td align="center">
							<div id="CFSQS" align="center"></div>
						</td>
						<td align="center">
							<div id="CFSQSyear" align="center"></div>
						</td>
					</tr>
					<tr class="bttn">
						<td align="left">
							&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;8.不予公开答复总数
						</td>
						<td align="center">
							条
						</td>
						<td align="center">
							27
						</td>
						<td align="center">
							<div id="foujuegongkai" align="center"></div>
						</td>
						<td align="center">
							<div id="foujuegongkaiyear" align="center"></div>
						</td>
					</tr>
					<tr class="bttn">
						<td align="left">	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;（1）“国家秘密”数
						</td>
						<td align="center">
							条
						</td>
						<td align="center">
							28
						</td>
						<td align="center">
							<div id="NOOPEN1" align="center"></div>
						</td>
						<td align="center">
							<div id="NOOPEN1year" align="center"></div>
						</td>
					</tr>
					<tr class="bttn">
						<td align="left">	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;（2）“商业秘密”数
						</td>
						<td align="center">
							条
						</td>
						<td align="center">
							29
						</td>
						<td align="center">
							<div id="NOOPEN2" align="center"></div>
						</td>
						<td align="center">
							<div id="NOOPEN2year" align="center"></div>
						</td>
					</tr>
					<tr class="bttn">
						<td align="left">	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;（3）“个人隐私”数
						</td>
						<td align="center">
							条
						</td>
						<td align="center">
							30
						</td>
						<td align="center">
							<div id="NOOPEN3" align="center"></div>
						</td>
						<td align="center">
							<div id="NOOPEN3year" align="center"></div>
						</td>
					</tr>
					<tr class="bttn">
						<td align="left">	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;（4）“过程中信息且影响安全稳定”数
						</td>
						<td align="center">
							条
						</td>
						<td align="center">
							31
						</td>
						<td align="center">
							<div id="NOOPEN4" align="center"></div>
						</td>
						<td align="center">
							<div id="NOOPEN4year" align="center"></div>
						</td>
					</tr>
					<tr class="bttn">
						<td align="left">	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;（5）“危及安全和稳定”数
						</td>
						<td align="center">
							条
						</td>
						<td align="center">
							32
						</td>
						<td align="center">
							<div id="NOOPEN5" align="center"></div>
						</td>
						<td align="center">
							<div id="NOOPEN5year" align="center"></div>
						</td>
					</tr>
					<tr class="bttn">
						<td align="left">	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;（6）“法律法规规定的其他情形”数
						</td>
						<td align="center">
							条
						</td>
						<td align="center">
							33
						</td>
						<td align="center">
							<div id="NOOPEN6" align="center"></div>
						</td>
						<td align="center">
							<div id="NOOPEN6year" align="center"></div>
						</td>
					</tr>
					<tr class="bttn">
						<td align="left">
							行政复议数
						</td>
						<td align="center">
							件
						</td>
						<td align="center">
							34
						</td>
						<td align="center">
							<div id="ADMINFUY" align="center"></div>
						</td>
						<td align="center">
							<div id="ADMINFUYyear" align="center"></div>
						</td>
					</tr>
					<tr class="bttn">
						<td align="left">
							行政诉讼数
						</td>
						<td align="center">
							件
						</td>
						<td align="center">
							35
						</td>
						<td align="center">
							<div id="ADMINSUS" align="center"></div>
						</td>
						<td align="center">
							<div id="ADMINSUSyear" align="center"></div>
						</td>
					</tr>
					<tr class="bttn">
						<td align="left">
							行政申诉数
						</td>
						<td align="center">
							件
						</td>
						<td align="center">
							36
						</td>
						<td align="center">
							<div id="ADMINSHENS" align="center"></div>
						</td>
						<td align="center">
							<div id="ADMINSHENSyear" align="center"></div>
						</td>
					</tr>
					<tr class="bttn">
						<td align="left">
							收取费用总数数
						</td>
						<td align="center">
							元
						</td>
						<td align="center">
							37
						</td>
						<td align="center">
							<div id="allfyzs" align="center"></div>
						</td>
						<td align="center">
							<div id="allfyzsyear" align="center"></div>
						</td>
					</tr>
					<tr class="bttn">
						<td align="left">
							&nbsp;&nbsp;&nbsp;主动公开信息收费总数
						</td>
						<td align="center">
							元
						</td>
						<td align="center">
							38
						</td>
						<td align="center">
							<div id="zdfyzs" align="center"></div>
						</td>
						<td align="center">
							<div id="zdfyzsyear" align="center"></div>
						</td>
					</tr>
					<tr class="bttn">
						<td align="left">
							&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;其中：1.邮寄费
						</td>
						<td align="center">
							元
						</td>
						<td align="center">
							39
						</td>
						<td align="center">
							<div id="ZDMAILCHARGE" align="center"></div>
						</td>
						<td align="center">
							<div id="ZDMAILCHARGEyear" align="center"></div>
						</td>
					</tr>
					<tr class="bttn">
						<td align="left">	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;2.复制费（纸张）
						</td>
						<td align="center">
							元
						</td>
						<td align="center">
							40
						</td>
						<td align="center">
							<div id="ZDCOPYCHARGESHEET" align="center"></div>
						</td>
						<td align="center">
							<div id="ZDCOPYCHARGESHEETyear" align="center"></div>
						</td>
					</tr>
					<tr class="bttn">
						<td align="left">	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;3.复制费（光盘）
						</td>
						<td align="center">
							元
						</td>
						<td align="center">
							41
						</td>
						<td align="center">
							<div id="ZDCOPYCHARGEDISK" align="center"></div>
						</td>
						<td align="center">
							<div id="ZDCOPYCHARGEDISKyear" align="center"></div>
						</td>
					</tr>
					<tr class="bttn">
						<td align="left">	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;4.复制费（软盘）
						</td>
						<td align="center">
							元
						</td>
						<td align="center">
							42
						</td>
						<td align="center">
							<div id="ZDCOPYCHARGEFDISK" align="center"></div>
						</td>
						<td align="center">
							<div id="ZDCOPYCHARGEFDISKyear" align="center"></div>
						</td>
					</tr>
					<tr class="bttn">
						<td align="left">
							&nbsp;&nbsp;&nbsp;依申请提供信息收取费用
						</td>
						<td align="center">
							元
						</td>
						<td align="center">
							43
						</td>
						<td align="center">
							<div id="sqfyzs" align="center"></div>
						</td>
						<td align="center">
							<div id="sqfyzsyear" align="center"></div>
						</td>
					</tr>
					<tr class="bttn">
						<td align="left">
							&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;其中：1.检索费
						</td>
						<td align="center">
							元
						</td>
						<td align="center">
							44
						</td>
						<td align="center">
							<div id="SEARCHCHARGE" align="center"></div>
						</td>
						<td align="center">
							<div id="SEARCHCHARGEyear" align="center"></div>
						</td>
					</tr>
					<tr class="bttn">
						<td align="left">	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;2.邮寄费
						</td>
						<td align="center">
							元
						</td>
						<td align="center">
							45
						</td>
						<td align="center">
							<div id="MAILCHARGE" align="center"></div>
						</td>
						<td align="center">
							<div id="MAILCHARGEyear" align="center"></div>
						</td>
					</tr>
					<tr class="bttn">
						<td align="left">	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;3.复制费（纸张）
						</td>
						<td align="center">
							元
						</td>
						<td align="center">
							46
						</td>
						<td align="center">
							<div id="COPYCHARGESHEET" align="center"></div>
						</td>
						<td align="center">
							<div id="COPYCHARGESHEETyear" align="center"></div>
						</td>
					</tr>
					<tr class="bttn">
						<td align="left">	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;4.复制费（光盘）
						</td>
						<td align="center">
							元
						</td>
						<td align="center">
							47
						</td>
						<td align="center">
							<div id="COPYCHARGEDISK" align="center"></div>
						</td>
						<td align="center">
							<div id="COPYCHARGEDISKyear" align="center"></div>
						</td>
					</tr>
					<tr class="bttn">
						<td align="left">	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;5.复制费（软盘）
						</td>
						<td align="center">
							元
						</td>
						<td align="center">
							48
						</td>
						<td align="center">
							<div id="COPYCHARGEFDISK" align="center"></div>
						</td>
						<td align="center">
							<div id="COPYCHARGEFDISKyear" align="center"></div>
						</td>
					</tr>
					<tr class="bttn">
						<td align="left">
							政府信息公开指定专职人员数
						</td>
						<td align="center">
							人
						</td>
						<td align="center">
							49**
						</td>
						<td align="center">
							<div id="renyuanshu" align="center"></div>
						</td>
						<td align="center">
							<div id="renyuanshuyear" align="center"></div>
						</td>
					</tr>
					<tr class="bttn">
						<td align="left">
							&nbsp;&nbsp;&nbsp;其中：1.全职人员
						</td>
						<td align="center">
							人
						</td>
						<td align="center">
							50**
						</td>
						<td align="center">
							<div id="ALLDAYJOB" align="center"></div>
						</td>
						<td align="center">
							<div id="ALLDAYJOByear" align="center"></div>
						</td>
					</tr>
					<tr class="bttn">
						<td align="left">
							&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;2.兼职人员
						</td>
						<td align="center">
							人
						</td>
						<td align="center">
							51**
						</td>
						<td align="center">
							<div id="PARTTIMEJOB" align="center"></div>
						</td>
						<td align="center">
							<div id="PARTTIMEJOByear" align="center"></div>
						</td>
					</tr>
					<tr class="bttn">
						<td align="left">
							处理政府信息公开的专项经费
						</td>
						<td align="center">
							万元
						</td>
						<td align="center">
							52**
						</td>
						<td align="center">
							<div id="DEALCHARGE" align="center"></div>
						</td>
						<td align="center">
							<div id="DEALCHARGEyear" align="center"></div>
						</td>
					</tr>
					<tr class="bttn">
						<td align="left">
							处理政府信息公开的实际支出
						</td>
						<td align="center">
							万元
						</td>
						<td align="center">
							53**
						</td>
						<td align="center">
							<div id="DEALPAY" align="center"></div>
						</td>
						<td align="center">
							<div id="DEALPAYyear" align="center"></div>
						</td>
					</tr>
					<tr class="bttn">
						<td align="left">
							与诉讼有关的总费用
						</td>
						<td align="center">
							万元
						</td>
						<td align="center">
							54**
						</td>
						<td align="center">
							<div id="ALLCHARGE" align="center"></div>
						</td>
						<td align="center">
							<div id="ALLCHARGEyear" align="center"></div>
						</td>
					</tr>
					<tr class="bttn">
						<td align="left" colspan='5'>
							标记：**为半年度统计指标，其它为月度统计指标。
						</td>
					</tr>
					<tr class="bttn">
						<td  colspan='5' align="left">
							<div>分析说明：</div><textarea name="FXSM" rows="5" id="FXSM" cols="95" ><%=FXSM%></textarea>
						</td>
					</tr>
					<tr class="title1" align="center">
						<td colspan="5">
						<%
						//在此判断用户是从哪个页面进入统计查询页面的 如果是市信息公开报送页面进入就要更换按钮
						if(method.equals("")){
						%>
							<input type="submit" class="bttn" value="报送详情" />
						<%}else{%>
							<input type="button" class="bttn" value="信息上报" onclick="formData.action='xxsendS.jsp?beginYear=<%=getbeginYear%>&beginMon=<%=getbeginYear%>';formData.submit()"/>
							<%}%>
							<input type="button" class="bttn" name="back" value="返 回"
								onclick="history.back();">
						</td>
					</tr>
	</table>
	<%		int all = 0; //主动信息公开
			int yishen = 0; //申请总次数 
			int shenzong = 0; //对申请的答复总数
			int foujuegongkai = 0; //否决公开答复数
			int renyuanshu = 0; //政府信息公开指定专职人员数
			int zdfyzs=0;//主动费用总数
			int sqfyzs=0;//申请费用总数
			String columnName = "";
			int GONGWENINFO = 0;//公开类信息数
			int ZHUDONGTOTALSINFO = 0; //主动信息公开
			int cloumnVal = 0;
			int i = 1;
			
			
		rs = dImpl.executeQuery(sqlStr);
		while(rs.next()){
		rsmd = rs.getMetaData();
			//得到数据库中的列数	
			for (i = 1; i < rsmd.getColumnCount() + 1; i++) {
				columnName = rsmd.getColumnName(i).toUpperCase();
				//判断是否为空，如果是空就默认值为0
				cloumnVal = Integer.parseInt(rs.getString(rsmd
				.getColumnName(i)) == null ? "0" : rs
				.getString(rsmd.getColumnName(i)));
				//判断字段名称是否相同，如果相同就累加
				if (columnName.equals("ZHUDONGTOTALSINFO")){
			ZHUDONGTOTALSINFO += cloumnVal;
				}
				if (columnName.equals("GONGWENINFO")){
			GONGWENINFO += cloumnVal;
				}
				if (columnName.equals("INTERVIEWAPPLY")
				|| columnName.equals("FAXAPPLY")
				|| columnName.equals("EMAILAPPLY")
				|| columnName.equals("WEBAPPLY")
				|| columnName.equals("LETTERAPPLY")
				|| columnName.equals("OTHERAPPLY")) {
			yishen += cloumnVal;
				}
				if (columnName.equals("AOPEN")
				|| columnName.equals("APARTOPEN")
				|| columnName.equals("FGDSZZFXXS")
				|| columnName.equals("NOINFO")
				|| columnName.equals("NODEPT")
				|| columnName.equals("NOBOUND")
				|| columnName.equals("CFSQS")) {
			shenzong += cloumnVal;
				}
				//update by yo
				if (columnName.equals("NOOPEN1")
				|| columnName.equals("NOOPEN2")
				|| columnName.equals("NOOPEN3")
				|| columnName.equals("NOOPEN4")
				|| columnName.equals("NOOPEN5")
				|| columnName.equals("NOOPEN6")) {
			foujuegongkai+= cloumnVal;
				}
				if (columnName.equals("SEARCHCHARGE")
				|| columnName.equals("MAILCHARGE")
				|| columnName.equals("COPYCHARGESHEET")
				|| columnName.equals("COPYCHARGEDISK")
				|| columnName.equals("COPYCHARGEFDISK")) {
			sqfyzs += cloumnVal;
				}
				if (columnName.equals("ZDMAILCHARGE")
				|| columnName.equals("ZDCOPYCHARGESHEET")
				|| columnName.equals("ZDCOPYCHARGEDISK")
				|| columnName.equals("ZDCOPYCHARGEFDISK")) {
			zdfyzs += cloumnVal;
				}
				if (columnName.equals("ALLDAYJOB")
				|| columnName.equals("PARTTIMEJOB")) {
			renyuanshu += cloumnVal;
			//System.out.println(renyuanshu);
				}
				if (columnName.equals("ALLDAYJOB")) {
			out.print("<script language='javascript'>todo('ALLDAYJOByear','"
			+ cloumnVal + "')</script>");
				}
				if (columnName.equals("PARTTIMEJOB")) {
			out.print("<script language='javascript'>todo('PARTTIMEJOByear','"
			+ cloumnVal + "')</script>");
				}
				out.print("<script language='javascript'>todo('"
				+ columnName + "','" + cloumnVal + "')</script>");
			}
			shenzong += foujuegongkai;

			out.print("<script language='javascript'>todo('ZHUDONGTOTALSINFO','" + ZHUDONGTOTALSINFO
			+ "')</script>");
			out.print("<script language='javascript'>todo('yishen','"
			+ yishen + "')</script>");
			out.print("<script language='javascript'>todo('shenzong','"
			+ shenzong + "')</script>");
			out
			.print("<script language='javascript'>todo('foujuegongkai','"
					+ foujuegongkai + "')</script>");
			out
			.print("<script language='javascript'>todo('allfyzs','"
					+ (sqfyzs+zdfyzs) + "')</script>");
			out.print("<script language='javascript'>todo('sqfyzs','"
			+ sqfyzs + "')</script>");
			out.print("<script language='javascript'>todo('zdfyzs','"
			+ zdfyzs + "')</script>");
			out.print("<script language='javascript'>todo('renyuanshu','"
			+ renyuanshu + "')</script>");
			out.print("<script language='javascript'>todo('renyuanshuyear','"
			+ renyuanshu + "')</script>");
			}
			rs.close();
			
			
		rsYear = dImpl.executeQuery(sqlStrYear);
		while (rsYear.next()){
		rsmdYear = rsYear.getMetaData();

			
			all = 0; //主动信息公开
			yishen = 0; //申请总次数 
			shenzong = 0; //对申请的答复总数
			foujuegongkai = 0; //否决公开答复数
			//renyuanshu = 0; //政府信息公开指定专职人员数
			zdfyzs=0;//主动费用总数
			sqfyzs=0;//申请费用总数
			columnName = "";
			cloumnVal = 0;
			GONGWENINFO = 0;//公开类信息数
			ZHUDONGTOTALSINFO = 0; //主动信息公开
			for (i = 1; i < rsmdYear.getColumnCount() + 1; i++) {
				columnName = rsmdYear.getColumnName(i).toUpperCase();
				//判断是否为空，如果是空就默认值为0
				cloumnVal = Integer.parseInt(rsYear.getString(rsmdYear
				.getColumnName(i)) == null ? "0" : rsYear
				.getString(rsmdYear.getColumnName(i)));
				//判断字段名称是否相同，如果相同就累加
				if (columnName.equals("ZHUDONGTOTALSINFOYEAR")){
			ZHUDONGTOTALSINFO += cloumnVal;
				}
				if (columnName.equals("GONGWENINFOYEAR")){
			GONGWENINFO += cloumnVal;
				}
				if (columnName.equals("INTERVIEWAPPLYYEAR")
				|| columnName.equals("FAXAPPLYYEAR")
				|| columnName.equals("EMAILAPPLYYEAR")
				|| columnName.equals("WEBAPPLYYEAR")
				|| columnName.equals("LETTERAPPLYYEAR")
				|| columnName.equals("OTHERAPPLYYEAR")) {
			yishen += cloumnVal;
				}
				if (columnName.equals("AOPENYEAR")
				|| columnName.equals("APARTOPENYEAR")
				|| columnName.equals("FGDSZZFXXSYEAR")
				|| columnName.equals("NOINFOYEAR")
				|| columnName.equals("NODEPTYEAR")
				|| columnName.equals("NOBOUNDYEAR")
				|| columnName.equals("CFSQSYEAR")) {
			shenzong += cloumnVal;
				}
				if (columnName.equals("NOOPEN1YEAR")
				|| columnName.equals("NOOPEN2YEAR")
				|| columnName.equals("NOOPEN3YEAR")
				|| columnName.equals("NOOPEN4YEAR")
				|| columnName.equals("NOOPEN5YEAR")
				|| columnName.equals("NOOPEN6YEAR")) {
			foujuegongkai += cloumnVal;
				}
				if (columnName.equals("SEARCHCHARGEYEAR")
				|| columnName.equals("MAILCHARGEYEAR")
				|| columnName.equals("COPYCHARGESHEETYEAR")
				|| columnName.equals("COPYCHARGEDISKYEAR")
				|| columnName.equals("COPYCHARGEFDISKYEAR")) {
			sqfyzs += cloumnVal;
				}
				if (columnName.equals("ZDMAILCHARGEYEAR")
				|| columnName.equals("ZDCOPYCHARGESHEETYEAR")
				|| columnName.equals("ZDCOPYCHARGEDISKYEAR")
				|| columnName.equals("ZDCOPYCHARGEFDISKYEAR")) {
			zdfyzs += cloumnVal;
				}
				out.print("<script language='javascript'>todo('"
				+ columnName + "','" + cloumnVal + "')</script>");
			}
			shenzong += foujuegongkai;

			out.print("<script language='javascript'>todo('ZHUDONGTOTALSINFO1year','" + ZHUDONGTOTALSINFO
			+ "')</script>");
			out.print("<script language='javascript'>todo('GONGWENINFOyear','" + GONGWENINFO
			+ "')</script>");
			out.print("<script language='javascript'>todo('yishenyear','"
			+ yishen + "')</script>");
			out.print("<script language='javascript'>todo('shenzongyear','"
			+ shenzong + "')</script>");
			out
			.print("<script language='javascript'>todo('foujuegongkaiyear','"
					+ foujuegongkai + "')</script>");
			out
			.print("<script language='javascript'>todo('allfyzsyear','"
					+ (sqfyzs+zdfyzs) + "')</script>");
			out.print("<script language='javascript'>todo('sqfyzsyear','"
			+ sqfyzs + "')</script>");
			out.print("<script language='javascript'>todo('zdfyzsyear','"
			+ zdfyzs + "')</script>");
			
			}
		rsYear.close();
%>
<!--    列表结束    -->
<%@include file="/system/app/skin/skin4/template/list_bottom.jsp"%> 
<%
}
catch(Exception e){
	System.out.print(e.toString());
}
finally{
	dImpl.closeStmt();
	dCn.closeCn(); 
}
%>
<%@include file="/system/app/skin/bottom.jsp"%>