<%@page contentType="text/html; charset=gbk"%>
<%@include file="/system/app/skin/import.jsp"%>
<%@page import="com.app.*"%>
<%
	String getbeginYear = CTools.dealString(
			request.getParameter("beginYear")).trim();
	String getbeginMon = CTools.dealString(
			request.getParameter("beginMon")).trim();
	String sqlStr = "";
	String bsXml=new String();
	Hashtable content = null;
	CDataCn dCn = null;
	CDataImpl dImpl = null;
	try {
		dCn = new CDataCn();
		dImpl = new CDataImpl(dCn);
		//统计数据库中数据的条数
		sqlStr = "select sum(alleinfo) as alleinfo,sum(newinfo) as newinfo,sum(serviceinfo) as serviceinfo,"
		+ "sum(columnvc) as columnvc,sum(localereceive) as localereceive,sum(consultation) as consultation,"
		+ "sum(contele) as contele,sum(applyindex) as applyindex,sum(interviewapply)+sum(faxapply)+sum(emailapply)+sum(webapply)+sum(letterapply)+sum(otherapply) as yishen,sum(interviewapply) as interviewapply,"
		+ "sum(faxapply) as faxapply,sum(emailapply) as emailapply,sum(webapply) as webapply,"
		+ "sum(letterapply) as letterapply,sum(otherapply) as otherapply,sum(aopen) as aopen,"
		+ "sum(apartopen) as apartopen,sum(noinfo)+sum(nodept)+sum(nobound)+sum(noopen1)+sum(noopen2)+sum(noopen3)+sum(noopen4)+sum(noopen5)+sum(noopen6)+sum(fgdszzfxxs)+sum(otherreason) as foujuegongkai,sum(noinfo) as noinfo,sum(nodept) as nodept,sum(nobound) as nobound,"
		+ "sum(noopen1) as noopen1,sum(noopen2) as noopen2,sum(noopen3) as noopen3,sum(noopen4) as noopen4,"
		+ "sum(noopen5) as noopen5,sum(noopen6) as noopen6,sum(fgdszzfxxs) as fgdszzfxxs,sum(otherreason) as otherreason,"
		+ "sum(adminfuy) as adminfuy,sum(adminsus) as adminsus,sum(adminshens) as adminshens,"
		+ "sum(nosadminshens) as nosadminshens,sum(zdmailcharge)+sum(zdsendcharge)+sum(zdcopychargesheet)+sum(zdcopychargedisk)+sum(zdcopychargefdisk) as zdfyzs,sum(zdmailcharge) as zdmailcharge,"
		+ "sum(zdsendcharge) as zdsendcharge,sum(zdcopychargesheet) as zdcopychargesheet,sum(zdcopychargedisk) as zdcopychargedisk,"
		+ "sum(zdcopychargefdisk) as zdcopychargefdisk,sum(searchcharge)+sum(mailcharge)+sum(sendcharge)+sum(copychargesheet)+sum(copychargedisk)+sum(copychargefdisk)+sum(othercharge) as sqfyzs,sum(searchcharge) as searchcharge,sum(mailcharge) as mailcharge,"
		+ "sum(sendcharge) as sendcharge,sum(copychargesheet) as copychargesheet,sum(copychargedisk) as copychargedisk,"
		+ "sum(copychargefdisk) as copychargefdisk,sum(othercharge) as othercharge,sum(alldayjob) as alldayjob,"
		+ "sum(parttimejob) as parttimejob,sum(dealcharge) as dealcharge,sum(dealpay) as dealpay,"
		+ "sum(allcharge) as  allcharge from iostat where reportyear = "
		+ getbeginYear + " and reportmonth = " + getbeginMon;
		//out.println(sqlStr);
		content=dImpl.getDataInfo(sqlStr);
		//开始根据返回的结果集组合xml字符串
		bsXml+="<?xml version=\"1.0\" encoding=\"gb2312\"?><shen2exchange>";
		bsXml+="<statcatalog name=\"ysqgkqktj\"><org id=\"SH00PD\"><range year=\"";
		bsXml+=getbeginYear;
		bsXml+="\" month=\"";
		bsXml+=getbeginMon;
		bsXml+="\">";
		//依申请公开信息目录树
		bsXml+="<statistics name=\"ysqgkxxmus\">"+CTools.dealNumber(content.get("applyindex").toString())+"</statistics>";
		//申请总数
		bsXml+="<statistics name=\"sqzs\">"+CTools.dealNumber(content.get("yishen").toString())+"</statistics>";
		//当面申请数
		bsXml+="<statistics name=\"dmsqs\">"+CTools.dealNumber(content.get("interviewapply").toString())+"</statistics>";
		//传真申请数
		bsXml+="<statistics name=\"czsqs\">"+CTools.dealNumber(content.get("faxapply").toString())+"</statistics>";
		//电子邮件申请数
		bsXml+="<statistics name=\"dzyjsqs\">"+CTools.dealNumber(content.get("emailapply").toString())+"</statistics>";
		//网上申请数
		bsXml+="<statistics name=\"wssqs\">"+CTools.dealNumber(content.get("webapply").toString())+"</statistics>";
		//信函申请数
		bsXml+="<statistics name=\"xhsqs\">"+CTools.dealNumber(content.get("letterapply".toLowerCase()).toString())+"</statistics>";
		//其它形式申请数
		bsXml+="<statistics name=\"qtxssqs\">"+CTools.dealNumber(content.get("otherapply").toString())+"</statistics>";
		//对申请的答复总数
		bsXml+="<statistics name=\"dsqddfzs\">"+(Integer.parseInt(CTools.dealNumber(content.get("aopen").toString()))+Integer.parseInt(CTools.dealNumber(content.get("apartopen").toString()))+Integer.parseInt(CTools.dealNumber(content.get("foujuegongkai").toString())))+"</statistics>";
		//同意公开答复数
		bsXml+="<statistics name=\"tygkdfs\">"+CTools.dealNumber(content.get("aopen").toString())+"</statistics>";
		//同意部分公开答复数
		bsXml+="<statistics name=\"tybfgkdfs\">"+CTools.dealNumber(content.get("apartopen").toString())+"</statistics>";
		//否决公开答复数
		
		bsXml+="<statistics name=\"fjgkdfzs\">"+CTools.dealNumber(content.get("foujuegongkai").toString())+"</statistics>";
		//信息不存在数
		bsXml+="<statistics name=\"xxbczs\">"+CTools.dealNumber(content.get("noinfo").toString())+"</statistics>";
		//非本部门掌握数
		bsXml+="<statistics name=\"fbbmzws\">"+CTools.dealNumber(content.get("nodept").toString())+"</statistics>";
		//申请内容不明确数
		bsXml+="<statistics name=\"sqnrbmqs\">"+CTools.dealNumber(content.get("nobound").toString())+"</statistics>";
		//免于公开范围1数
		bsXml+="<statistics name=\"mygkfw1s\">"+CTools.dealNumber(content.get("NOOPEN1".toLowerCase()).toString())+"</statistics>";
		//免于公开范围2数
		bsXml+="<statistics name=\"mygkfw2s\">"+CTools.dealNumber(content.get("NOOPEN2".toLowerCase()).toString())+"</statistics>";
		//免于公开范围3数
		bsXml+="<statistics name=\"mygkfw3s\">"+CTools.dealNumber(content.get("NOOPEN3".toLowerCase()).toString())+"</statistics>";
		//免于公开范围4数
		bsXml+="<statistics name=\"mygkfw4s\">"+CTools.dealNumber(content.get("NOOPEN4".toLowerCase()).toString())+"</statistics>";
		//免于公开范围5数
		bsXml+="<statistics name=\"mygkfw5s\">"+CTools.dealNumber(content.get("NOOPEN5".toLowerCase()).toString())+"</statistics>";
		//免于公开范围6数
		bsXml+="<statistics name=\"mygkfw6s\">"+CTools.dealNumber(content.get("NOOPEN6".toLowerCase()).toString())+"</statistics>";
		//非规定所指政府信息数
		bsXml+="<statistics name=\"fgdszzfxxs\">"+CTools.dealNumber(content.get("fgdszzfxxs").toString())+"</statistics>";
		//其他原因
		bsXml+="<statistics name=\"qtyy\">"+CTools.dealNumber(content.get("OTHERREASON".toLowerCase()).toString())+"</statistics>";

		//收费总数
		bsXml+="<statistics name=\"fyzs\">"+(Integer.parseInt(CTools.dealNumber(content.get("zdfyzs").toString()))+Integer.parseInt(CTools.dealNumber(content.get("sqfyzs").toString())))+"</statistics>";
		//主动公开收费总数
		bsXml+="<statistics name=\"zdfyzs\">"+CTools.dealNumber(content.get("zdfyzs").toString())+"</statistics>";
		//主动公开邮寄数
		bsXml+="<statistics name=\"zdyjf\">"+CTools.dealNumber(content.get("zdmailcharge").toString())+"</statistics>";
		//主动公开递送费
		bsXml+="<statistics name=\"zddsf\">"+CTools.dealNumber(content.get("zdsendcharge").toString())+"</statistics>";
		//主动公开复制数(纸张）
		bsXml+="<statistics name=\"zdfzfzz\">"+CTools.dealNumber(content.get("zdcopychargesheet").toString())+"</statistics>";
		//主动公开复制数(光盘）
		bsXml+="<statistics name=\"zdfzfgp\">"+CTools.dealNumber(content.get("zdcopychargedisk").toString())+"</statistics>";
		//主动公开复制数(软盘）
		bsXml+="<statistics name=\"zdfzfrp\">"+CTools.dealNumber(content.get("zdcopychargefdisk").toString())+"</statistics>";
		//依申请收费总数
		bsXml+="<statistics name=\"ysqfyzs\">"+CTools.dealNumber(content.get("sqfyzs").toString())+"</statistics>";
		//依申请公开检索费
		bsXml+="<statistics name=\"ysqjsf\">"+CTools.dealNumber(content.get("searchcharge").toString())+"</statistics>";
		//依申请公开邮寄数
		bsXml+="<statistics name=\"ysqyjf\">"+CTools.dealNumber(content.get("mailcharge").toString())+"</statistics>";
		//依申请公开递送费
		bsXml+="<statistics name=\"ysqdjf\">"+CTools.dealNumber(content.get("sendcharge").toString())+"</statistics>";
		//依申请公开复制数(纸张）
		bsXml+="<statistics name=\"ysqfzfzz\">"+CTools.dealNumber(content.get("copychargesheet").toString())+"</statistics>";
		//依申请公开复制数(光盘）
		bsXml+="<statistics name=\"ysqfzfgp\">"+CTools.dealNumber(content.get("copychargedisk").toString())+"</statistics>";
		//依申请公开复制数(软盘）
		bsXml+="<statistics name=\"ysqfzfrp\">"+CTools.dealNumber(content.get("copychargefdisk").toString())+"</statistics>";
		//依申请公开其他费用
		bsXml+="<statistics name=\"ysqqtsf\">"+CTools.dealNumber(content.get("othercharge").toString())+"</statistics>";
		bsXml+="</range></org></statcatalog></shen2exchange>";
	} catch (Exception e) {
		out.print(e.toString());
	} finally {
		dImpl.closeStmt();
		dCn.closeCn();
	}
%>
<html>
<body onload="bs.submit()">
	<form name="bs" action="http://31.6.130.127:8081/test/xxbs.jsp" method="post">
		<input type=hidden name="bsXml" value='<%=bsXml%>'>
		<input type=hidden name="backErrorUrl" value="http://www.pudong.gov.cn/system/app/applyopen/newxxbs.jsp?SubMenuID=12605">
		<input type=hidden name="backSuccessUrl" value="http://www.pudong.gov.cn/system/app/applyopen/newxxbs.jsp?SubMenuID=12605">
	</form>
</body>
</html>