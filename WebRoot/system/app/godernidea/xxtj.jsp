<%@page contentType="text/html; charset=GBK"%>
<%@include file="/system/app/skin/head.jsp"%>
<!--
author:may
method:统计查询
date:2007-03-09
-->
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

	String sqlStr = "";
	String strTitle = "";
	String getbeginYear = CTools.dealString(
			request.getParameter("beginYear")).trim();
	String getbeginMon = CTools.dealString(
			request.getParameter("beginMon")).trim();

	String dt_id = CTools.dealString(request.getParameter("dt_id"))
			.trim();

	CDataCn dCn = null;
	CDataImpl dImpl = null;

	Vector vPage = null;
	Hashtable content = null;
	ResultSet rs = null;
	ResultSetMetaData rsmd = null;

	try {
		dCn = new CDataCn();
		dImpl = new CDataImpl(dCn);
		//统计数据库中数据的条数
		sqlStr = "select sum(alleinfo) as alleinfo,sum(newinfo) as newinfo,sum(serviceinfo) as serviceinfo,"
		+ "sum(columnvc) as columnvc,sum(localereceive) as localereceive,sum(consultation) as consultation,"
		+ "sum(contele) as contele,sum(applyindex) as applyindex,sum(interviewapply) as interviewapply,"
		+ "sum(faxapply) as faxapply,sum(emailapply) as emailapply,sum(webapply) as webapply,"
		+ "sum(letterapply) as letterapply,sum(otherapply) as otherapply,sum(aopen) as aopen,"
		+ "sum(apartopen) as apartopen,sum(noinfo) as noinfo,sum(nodept) as nodept,sum(nobound) as nobound,"
		+ "sum(noopen1) as noopen1,sum(noopen2) as noopen2,sum(noopen3) as noopen3,sum(noopen4) as noopen4,"
		+ "sum(noopen5) as noopen5,sum(noopen6) as noopen6,sum(fgdszzfxxs) as fgdszzfxxs,sum(otherreason) as otherreason,"
		+ "sum(adminfuy) as adminfuy,sum(adminsus) as adminsus,sum(adminshens) as adminshens,"
		+ "sum(nosadminshens) as nosadminshens,sum(zdmailcharge) as zdmailcharge,"
		+ "sum(zdsendcharge) as zdsendcharge,sum(zdcopychargesheet) as zdcopychargesheet,sum(zdcopychargedisk) as zdcopychargedisk,"
		+ "sum(zdcopychargefdisk) as zdcopychargefdisk,sum(searchcharge) as searchcharge,sum(mailcharge) as mailcharge,"
		+ "sum(sendcharge) as sendcharge,sum(copychargesheet) as copychargesheet,sum(copychargedisk) as copychargedisk,"
		+ "sum(copychargefdisk) as copychargefdisk,sum(othercharge) as othercharge,sum(alldayjob) as alldayjob,"
		+ "sum(parttimejob) as parttimejob,sum(dealcharge) as dealcharge,sum(dealpay) as dealpay,"
		+ "sum(allcharge) as  allcharge from iostat where reportyear = "
		+ getbeginYear + " and reportmonth = " + getbeginMon;
		if (!dt_id.equals(""))
			sqlStr += " and did = " + dt_id;
		//out.println(sqlStr);
		rs = dImpl.executeQuery(sqlStr);
		if (rs.next())
			rsmd = rs.getMetaData();
%>
<form name="formData" action="xqcx.jsp" method="post">
	<table class="main-table" width="100%">
		<tr>
			<td width="100%">
				<table class="content-table" width="100%">
					<tr class="title1">
						<td colspan="8" align="center">
							<table WIDTH="100%" BORDER="0" CELLSPACING="1" CELLPADDING="1">
								<tr>
									<td valign="center" align="left">
										<%=strTitle%>
									</td>
									<td valign="center" align="right" nowrap>
										<img src="../../images/split.gif" align="middle" border="0"
											WIDTH="5" HEIGHT="8">
										<img src="../../images/goback.gif" border="0"
											onclick="javascript:history.back();" title="返回"
											style="cursor:hand" align="absmiddle">
										<img src="../../images/split.gif" align="middle" border="0"
											WIDTH="5" HEIGHT="8">
									</td>
								</tr>
							</table>
						</td>
					</tr>
					<tr class="title1">
						<td colspan="8" align="center">
							<table WIDTH="100%" BORDER="0" CELLSPACING="1" CELLPADDING="1">
								<tr>
									<td align="center" colspan=15>
										<b>
								<tr class="bttn">
									<td width="15%" align="left">
										查询日期
										<%=getbeginYear%>
										&nbsp;年
										<%=getbeginMon%>
										&nbsp;月
										<input name="beginYear" type="hidden"
											value="<%=getbeginYear%>">
										<input type="hidden" name="beginMon" value="<%=getbeginMon%>">
									</td>
								</tr>

								</b>
								</td>
								</tr>

							</table>
						</td>
					</tr>
					<tr class="bttn">
						<td width="40%" class="outset-table">
							指标名称
						</td>
						<td width="10%" class="outset-table">
							计算单位
						</td>
						<td width="10%" class="outset-table">
							代码
						</td>
						<td width="10%" class="outset-table">
							本月累计
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
							<div id="all" align="center"></div>
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
					</tr>
					<tr class="bttn">
						<td align="left">
							&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;新增的行政规范性文件数
						</td>
						<td align="center">
							条
						</td>
						<td align="center">
							03
						</td>
						<td align="center">
							<div id="NEWINFO" align="center"></div>
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
							04
						</td>
						<td align="center">
							<div id="SERVICEINFO" align="center"></div>
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
							05
						</td>
						<td align="center">
							<div id="COLUMNVC" align="center"></div>
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
							06
						</td>
						<td align="center">
							<div id="LOCALERECEIVE" align="center"></div>
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
							07
						</td>
						<td align="center">
							<div id="CONSULTATION" align="center"></div>
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
							08
						</td>
						<td align="center">
							<div id="CONTELE" align="center"></div>
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
							09
						</td>
						<td align="center">
							<div id="APPLYINDEX" align="center"></div>
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
							10
						</td>
						<td align="center">
							<div id="yishen" align="center"></div>
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
							11
						</td>
						<td align="center">
							<div id="INTERVIEWAPPLY" align="center"></div>
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
							12
						</td>
						<td align="center">
							<div id="FAXAPPLY" align="center"></div>
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
							13
						</td>
						<td align="center">
							<div id="EMAILAPPLY" align="center"></div>
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
							14
						</td>
						<td align="center">
							<div id="WEBAPPLY" align="center"></div>
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
							15
						</td>
						<td align="center">
							<div id="LETTERAPPLY" align="center"></div>
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
							16
						</td>
						<td align="center">
							<div id="OTHERAPPLY" align="center"></div>
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
							17
						</td>
						<td align="center">
							<div id="shenzong" align="center"></div>
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
							18
						</td>
						<td align="center">
							<div id="AOPEN" align="center"></div>
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
							19
						</td>
						<td align="center">
							<div id="APARTOPEN" align="center"></div>
						</td>
					</tr>
					<tr class="bttn">
						<td align="left">
							&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;3.否决公开答复数
						</td>
						<td align="center">
							条
						</td>
						<td align="center">
							20
						</td>
						<td align="center">
							<div id="foujuegongkai" align="center"></div>
						</td>
					</tr>
					<tr class="bttn">
						<td align="left">
							&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;其中：（1）“信息不存在”数
						</td>
						<td align="center">
							条
						</td>
						<td align="center">
							21
						</td>
						<td align="center">
							<div id="NOINFO" align="center"></div>
						</td>
					</tr>
					<tr class="bttn">
						<td align="left">
							&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;（2）“非本部门掌握”数
						</td>
						<td align="center">
							条
						</td>
						<td align="center">
							22
						</td>
						<td align="center">
							<div id="NODEPT" align="center"></div>
						</td>
					</tr>
					<tr class="bttn">
						<td align="left">
							&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;（3）”申请内容不明确“数
						</td>
						<td align="center">
							条
						</td>
						<td align="center">
							23
						</td>
						<td align="center">
							<div id="NOBOUND" align="center"></div>
						</td>
					</tr>
					<tr class="bttn">
						<td align="left">
							&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;（4）“免于公开范围1”数
						</td>
						<td align="center">
							条
						</td>
						<td align="center">
							24
						</td>
						<td align="center">
							<div id="NOOPEN1" align="center"></div>
						</td>
					</tr>
					<tr class="bttn">
						<td align="left">
							&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;（5）“免于公开范围2”数
						</td>
						<td align="center">
							条
						</td>
						<td align="center">
							25
						</td>
						<td align="center">
							<div id="NOOPEN2" align="center"></div>
						</td>
					</tr>
					<tr class="bttn">
						<td align="left">
							&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;（6）“免于公开范围3”数
						</td>
						<td align="center">
							条
						</td>
						<td align="center">
							26
						</td>
						<td align="center">
							<div id="NOOPEN3" align="center"></div>
						</td>
					</tr>
					<tr class="bttn">
						<td align="left">
							&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;（7）“免于公开范围4”数
						</td>
						<td align="center">
							条
						</td>
						<td align="center">
							27
						</td>
						<td align="center">
							<div id="NOOPEN4" align="center"></div>
						</td>
					</tr>
					<tr class="bttn">
						<td align="left">
							&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;（8）“免于公开范围5”数
						</td>
						<td align="center">
							条
						</td>
						<td align="center">
							28
						</td>
						<td align="center">
							<div id="NOOPEN5" align="center"></div>
						</td>
					</tr>
					<tr class="bttn">
						<td align="left">
							&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;（9）“免于公开范围6”数
						</td>
						<td align="center">
							条
						</td>
						<td align="center">
							29
						</td>
						<td align="center">
							<div id="NOOPEN6" align="center"></div>
						</td>
					</tr>
					<tr class="bttn">
						<td align="left">
							&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;（10）非<<规定>>所指政府信息数
						</td>
						<td align="center">
							条
						</td>
						<td align="center">
							30
						</td>
						<td align="center">
							<div id="FGDSZZFXXS" align="center"></div>
						</td>
					</tr>
					<tr class="bttn">
						<td align="left">
							&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;（11）其他原因
						</td>
						<td align="center">
							条
						</td>
						<td align="center">
							31
						</td>
						<td align="center">
							<div id="OTHERREASON" align="center"></div>
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
							32
						</td>
						<td align="center">
							<div id="ADMINFUY" align="center"></div>
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
							33
						</td>
						<td align="center">
							<div id="ADMINSUS" align="center"></div>
						</td>
					</tr>
					<tr class="bttn">
						<td align="left">
							行政身申议数
						</td>
						<td align="center">
							件
						</td>
						<td align="center">
							34
						</td>
						<td align="center">
							<div id="ADMINSHENS" align="center"></div>
						</td>
					</tr>
					<tr class="bttn">
						<td align="left">
							&nbsp;&nbsp;&nbsp;其中：对本部门首次处理不满意的行政申诉数
						</td>
						<td align="center">
							件
						</td>
						<td align="center">
							35*
						</td>
						<td align="center">
							<div id="NOSADMINSHENS" align="center"></div>
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
							36
						</td>
						<td align="center">
							<div id="allfyzs" align="center"></div>
						</td>
					</tr>
				<tr class="bttn">
						<td align="left">
							&nbsp;&nbsp;&nbsp;其中：主动公开收费总数
						</td>
						<td align="center">
							元
						</td>
						<td align="center">
							37
						</td>
						<td align="center">
						<div id="zdfyzs" align="center"></div>
						</td>
					</tr>
					<tr class="bttn">
						<td align="left">
							&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;1.主动公开邮寄费
						</td>
						<td align="center">
							元
						</td>
						<td align="center">
							38
						</td>
						<td align="center">
							<div id="ZDMAILCHARGE" align="center"></div>
						</td>
					</tr>
					<tr class="bttn">
						<td align="left">
							&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;2.主动公开递送费
						</td>
						<td align="center">
							元
						</td>
						<td align="center">
							39
						</td>
						<td align="center">
							<div id="ZDSENDCHARGE" align="center"></div>
						</td>
					</tr>
					<tr class="bttn">
						<td align="left">
							&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;3.主动公开复制费（纸张）
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
					</tr>
					<tr class="bttn">
						<td align="left">
							&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;4.主动公开复制费（光盘）
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
					</tr>
					<tr class="bttn">
						<td align="left">
							&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;5.主动公开复制费（软盘）
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
					</tr>
					<tr class="bttn">
						<td align="left">
							&nbsp;&nbsp;&nbsp;其中：依申请公开收费总数
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
					</tr>
					<tr class="bttn">
						<td align="left">
							&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;1.依申请检索费
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
					</tr>
					<tr class="bttn">
						<td align="left">
							&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;2.依申请邮寄费
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
					</tr>
					<tr class="bttn">
						<td align="left">
							&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;3.依申请递送费
						</td>
						<td align="center">
							元
						</td>
						<td align="center">
							46
						</td>
						<td align="center">
							<div id="SENDCHARGE" align="center"></div>
						</td>
					</tr>
					<tr class="bttn">
						<td align="left">
							&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;4.依申请复制费（纸张）
						</td>
						<td align="center">
							元
						</td>
						<td align="center">
							47
						</td>
						<td align="center">
							<div id="COPYCHARGESHEET" align="center"></div>
						</td>
					</tr>
					<tr class="bttn">
						<td align="left">
							&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;5.依申请复制费（光盘）
						</td>
						<td align="center">
							元
						</td>
						<td align="center">
							48
						</td>
						<td align="center">
							<div id="COPYCHARGEDISK" align="center"></div>
						</td>
					</tr>
					<tr class="bttn">
						<td align="left">
							&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;6.依申请复制费（软盘）
						</td>
						<td align="center">
							元
						</td>
						<td align="center">
							49
						</td>
						<td align="center">
							<div id="COPYCHARGEFDISK" align="center"></div>
						</td>
					</tr>
					<tr class="bttn">
						<td align="left">
							&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;7.依申请其他收费
						</td>
						<td align="center">
							元
						</td>
						<td align="center">
							50
						</td>
						<td align="center">
							<div id="OTHERCHARGE" align="center"></div>
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
							51**
						</td>
						<td align="center">
							<div id="renyuanshu" align="center"></div>
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
							52**
						</td>
						<td align="center">
							<div id="ALLDAYJOB" align="center"></div>
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
							53**
						</td>
						<td align="center">
							<div id="PARTTIMEJOB" align="center"></div>
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
							54**
						</td>
						<td align="center">
							<div id="DEALCHARGE" align="center"></div>
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
							55**
						</td>
						<td align="center">
							<div id="DEALPAY" align="center"></div>
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
							48**
						</td>
						<td align="center">
							<div id="ALLCHARGE" align="center"></div>
						</td>
					</tr>
					<tr class="title1" align="center">
						<td colspan="4">
							<input type="submit" class="bttn" value="报送详情" />
							<input type="button" class="bttn" name="back" value="返 回"
								onclick="history.back();">
						</td>
					</tr>
				</table>

			</td>
		</tr>
	</table>
	<%
			int all = 0; //主动信息公开
			int yishen = 0; //申请总次数 
			int shenzong = 0; //对申请的答复总数
			int foujuegongkai = 0; //否决公开答复数
			int renyuanshu = 0; //政府信息公开指定专职人员数
			int zdfyzs=0;//主动费用总数
			int sqfyzs=0;//申请费用总数
			String columnName = "";
			int cloumnVal = 0;
			//得到数据库中的列数	
			for (int i = 1; i < rsmd.getColumnCount() + 1; i++) {
				columnName = rsmd.getColumnName(i).toUpperCase();
				//判断是否为空，如果是空就默认值为0
				cloumnVal = Integer.parseInt(rs.getString(rsmd
				.getColumnName(i)) == null ? "0" : rs
				.getString(rsmd.getColumnName(i)));
				//判断字段名称是否相同，如果相同就累加
				if (columnName.equals("ALLEINFO")
				|| columnName.equals("NEWINFO")) {
			all += cloumnVal;
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
				|| columnName.equals("APARTOPEN")) {
			shenzong += cloumnVal;
				}
				if (columnName.equals("NOINFO")
				|| columnName.equals("NODEPT")
				|| columnName.equals("NOBOUND")
				|| columnName.equals("NOOPEN1")
				|| columnName.equals("NOOPEN2")
				|| columnName.equals("NOOPEN3")
				|| columnName.equals("NOOPEN4")
				|| columnName.equals("NOOPEN5")
				|| columnName.equals("NOOPEN6")
				|| columnName.equals("FGDSZZFXXS")
				|| columnName.equals("OTHERREASON")) {
			foujuegongkai += cloumnVal;
				}
				if (columnName.equals("SEARCHCHARGE")
				|| columnName.equals("MAILCHARGE")
				|| columnName.equals("SENDCHARGE")
				|| columnName.equals("COPYCHARGESHEET")
				|| columnName.equals("COPYCHARGEDISK")
				|| columnName.equals("COPYCHARGEFDISK")
				|| columnName.equals("OTHERCHARGE")) {
			sqfyzs += cloumnVal;
				}
				if (columnName.equals("ZDMAILCHARGE")
				|| columnName.equals("ZDSENDCHARGE")
				|| columnName.equals("ZDCOPYCHARGESHEET")
				|| columnName.equals("ZDCOPYCHARGEDISK")
				|| columnName.equals("ZDCOPYCHARGEFDISK")) {
			zdfyzs += cloumnVal;
				}
				if (columnName.equals("ALLDAYJOB")
				|| columnName.equals("PARTTIMEJOB")) {
			renyuanshu += cloumnVal;
				}
				out.print("<script language='javascript'>todo('"
				+ columnName + "','" + cloumnVal + "')</script>");
			}

			out.print("<script language='javascript'>todo('ALL','" + all
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
			rs.close();
		} catch (Exception e) {
			out.print(e.toString());
		} finally {
			dImpl.closeStmt();
			dCn.closeCn();
		}
	%>
	<%@include file="/system/app/skin/bottom.jsp"%>