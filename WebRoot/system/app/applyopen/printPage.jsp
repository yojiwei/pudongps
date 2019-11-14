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
//author yy
String ID = "";
String ename = "";
String infoid = "";
String infotitle = "";
String applytime = "";
String genre = "";
String status = "";
String sqlStr = "";
String sqlStrYear = "";
//年份
java.util.Date ai_date = new java.util.Date();
java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyy-MM");
int yea = Integer.parseInt(sdf.format(ai_date).substring(0, 4));
int beginYear = 0;
//月份
int yuf = Integer.parseInt(sdf.format(ai_date).substring(5, 7));
int beginMe = 0;
					
String getbeginYear = CTools.dealString(request.getParameter("reportyear")).trim();
String getbeginMon = CTools.dealString(request.getParameter("reportmonth")).trim();
getbeginYear=getbeginYear.equals("")?yea+"":getbeginYear;
getbeginMon=getbeginMon.equals("")?yuf-1+"":getbeginMon;

String dt_id = CTools.dealString(request.getParameter("dt_id")).trim();
String dt_id_l="";
String dt_name = "";
String dt_ids = "";
CDataCn dCn = null;
CDataImpl dImpl = null;

Vector vPage = null;
Hashtable content = null;
ResultSet rs = null;
ResultSetMetaData rsmd = null;
ResultSet rsYear = null;
ResultSetMetaData rsmdYear = null;

int ALLEINFO_=0;
int NEWINFO_=0;
int ZHUDONGTOTALSINFO_=0;
int GONGWENINFO_=0;
int SERVICEINFO_=0;
int INTERVIEWAPPLY_=0;
int FAXAPPLY_=0;
int EMAILAPPLY_=0;
int WEBAPPLY_=0;
int LETTERAPPLY_=0;
int OTHERAPPLY_=0;
int yishen_=0;
int AOPEN_=0;
int APARTOPEN_=0;
int shenzong_=0;
int NOOPEN1_=0;
int NOOPEN2_=0;
int NOOPEN3_=0;
int NOOPEN4_=0;
int NOOPEN5_=0;
int NOOPEN6_=0;
int foujuegongkai_=0;
int SEARCHCHARGE_=0;
int MAILCHARGE_=0;
int COPYCHARGESHEET_=0;
int COPYCHARGEDISK_=0;
int COPYCHARGEFDISK_=0;
int sqfyzs_=0;
int ZDMAILCHARGE_=0;
int ZDCOPYCHARGESHEET_=0;
int ZDCOPYCHARGEDISK_=0;
int ZDCOPYCHARGEFDISK_=0;
int zdfyzs_=0;
int ALLDAYJOB_=0;
int PARTTIMEJOB_=0;
int renyuanshu_=0;
int COLUMNVC_=0;
int LOCALERECEIVE_=0;
int CONSULTATION_=0;
int CONTELE_=0;
int APPLYINDEX_=0;
int NATIONALSECRET_=0;
int FGDSZZFXXS_=0;
int NOINFO_=0;
int NODEPT_=0;
int NOBOUND_=0;
int CFSQS_=0;
int ADMINFUY_=0;
int ADMINSUS_=0;
int ADMINSHENS_=0;
int allfyzs_=0;
int DEALCHARGE_=0;
int DEALPAY_=0;
int ALLCHARGE_=0;
try {
	dCn = new CDataCn();
	dImpl = new CDataImpl(dCn);
	
	
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
	
%>
<script>
function fmprint()
{
	window.print();
	window.close();
}
 </script>
<%@include file="/system/app/skin/skin4/template/list_top.jsp"%>
<!--    模块名称开始    -->
浦东新区政府信息公开<%=getbeginMon%>月报
<!--    模块名称结束    -->
<%@include file="/system/app/skin/skin4/template/list_function.jsp"%>                                                            
<!--    功能按钮开始    -->
  
<!--    功能按钮结束    -->
<%@include file="/system/app/skin/skin4/template/list_listtop.jsp"%>                                                                                        
<!--    列表开始    -->
<TABLE cellSpacing=0 class="main-table" cellPadding=0 width="100%" border=0>
  <TBODY>
    <TD vAlign=center align=left >
<!--查询-->
<form name="formData" action="bbtj_history.jsp" method="post" xxx-onsubmit="merger()">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr class="bttn">
		<td width="51%" align="left">
		<input class="bttn" value="打印" type="button"  id="button6" name="button6" onclick="fmprint()">
		</td>
	</tr>
	</table>
	</form>
	<!--查询结束-->
	</TD></TR>
  <TR class="bttn">
    <TD align=middle>
      <TABLE  cellSpacing=1 cellPadding=0 width="100%" 
      border=0>
        <TBODY>
        <TR >
          <TD>
            <TABLE  borderColor=#ffffff cellSpacing=0 
            cellPadding=1 width="100%" border=1>
              <TBODY>
              <TR class=tr_header height=20>
                <TD width=200 rowSpan=3>单位名称</TD>
                <TD colSpan=4>主动公<BR>开信息</TD>
                <TD width=20 rowSpan=3>提供服务类信息数</TD>
                <TD width=20 rowSpan=3>网站专栏页面访问量</TD>
                <TD width=20 rowSpan=3>现场接待人数</TD>
                <TD width=20 rowSpan=3>网上咨询数</TD>
                <TD width=20 rowSpan=3>咨询电话接听数</TD>
                <TD width=20 rowSpan=3>依申请公开信息目录数</TD>
				<TD width=20 rowSpan=3>属于国家秘密的公文类信息数</TD>
                <TD colSpan=7 height=30>申请</TD>
                <TD colSpan=15 height=30>对申请的答复</TD>
                <TD width=20 rowSpan=3>行政复议数</TD>
                <TD width=20 rowSpan=3>行政诉讼数</TD>
				<TD width=20 rowSpan=3>行政申诉数</TD>
                <TD colSpan=12>收取费用</TD>
                <TD colSpan=3>政府信息公开指定专职人员</TD>
                <TD width=20 rowSpan=3>政府信息公开的专项费</TD>
                <TD width=20 rowSpan=3>处理政府信息公开的实际支出</TD>
                <TD width=20 rowSpan=3>与诉讼有关的总费用</TD>
			  </TR>
              <TR class=tr_header height=20>
                <TD align=middle width=20 rowSpan=2>主动公开信息数</TD>
                <TD align=middle width=30 rowSpan=2>全文电子化的主动公开信息数</TD>
				<TD align=middle width=30 rowSpan=2>公文类信息数</TD>
                <TD align=middle width=30 rowSpan=2>新增的行政规范性文件数</TD>
                <TD vAlign=center align=middle width=20 rowSpan=2>申请总数</TD>
                <TD vAlign=center align=middle width=20 rowSpan=2>当面申请数</TD>
                <TD vAlign=center align=middle width=20 rowSpan=2>传真申请数</TD>
                <TD vAlign=center align=middle width=20 rowSpan=2>电子邮件申请数</TD>
                <TD vAlign=center align=middle width=20 rowSpan=2>网上申请数</TD>
                <TD vAlign=center align=middle width=20 rowSpan=2>信函申请数</TD>
                <TD vAlign=center align=middle width=20 rowSpan=2>其他形式申请数</TD>
                <TD vAlign=center align=middle width=20 rowSpan=2>对申请的答复总数</TD>
                <TD vAlign=center align=middle width=20 rowSpan=2>同意公开答复数</TD>
                <TD vAlign=center align=middle width=20 rowSpan=2>同意部分公开答复数</TD>
				
				<TD vAlign=center align=middle width=10 rowSpan=2>非《规定》所指政府信息数</TD>
                <TD vAlign=center align=middle width=20 rowSpan=2>信息不存在数</TD>
                <TD vAlign=center align=middle width=20 rowSpan=2>非本部门掌握数</TD>
                <TD vAlign=center align=middle width=20 rowSpan=2>申请内容不明确数</TD>
				<TD vAlign=center align=middle width=20 rowSpan=2>重复申请数</TD>
				
                <TD vAlign=center align=middle colSpan=7 height=30>不予公开答复总数</TD>

                
                <TD vAlign=center align=middle width=10 rowSpan=2>收取费用总数</TD>
                <TD vAlign=center align=middle colSpan=5>主动公开信息收取费用</TD>
                <TD vAlign=center align=middle colSpan=6>依申请提供信息收取费用</TD>
                <TD align=middle width=30 rowSpan=2>政府信息公开指定专职人员数</TD>
                <TD align=middle width=20 rowSpan=2>全职人员</TD>
                <TD align=middle width=20 rowSpan=2>兼职人员</TD></TR>
              <TR class=tr_header height=20>
                <TD vAlign=center align=middle width=10>不予公开答复总数</TD>
                <TD vAlign=center align=middle width=20>国家秘密数</TD>
                <TD vAlign=center align=middle width=20>商业秘密数</TD>
                <TD vAlign=center align=middle width=20>个人隐私数</TD>
                <TD vAlign=center align=middle width=20>过程中信息且影响安全稳定数</TD>
                <TD vAlign=center align=middle width=20>危及安全和稳定数</TD>
                <TD vAlign=center align=middle width=20>法律法规规定的其他情形数</TD>
                <TD vAlign=center align=middle width=5>主动公开收取费用</TD>
                <TD vAlign=center align=middle width=5>邮寄费</TD>
                <TD vAlign=center align=middle width=10>复制费(纸张)</TD>
                <TD vAlign=center align=middle width=10>复制费(光盘)</TD>
                <TD vAlign=center align=middle width=10>复制费(软盘)</TD>
                <TD vAlign=center align=middle width=10>依申请提供信息收取费用</TD>
                <TD vAlign=center align=middle width=10>检索费</TD>
                <TD vAlign=center align=middle width=20>邮寄费</TD>
                <TD vAlign=center align=middle width=20>复制费(纸张)</TD>
                <TD vAlign=center align=middle width=20>复制费(光盘)</TD>
                <TD align=middle vAlign=center>复制费(软盘)</TD>
                </TR>
<%
	//统计数据库中数据的条数
		sqlStr = "select d.dt_name as DTNAME,sum(alleinfo) as alleinfo,sum(ZHUDONGTOTALSINFO) as ZHUDONGTOTALSINFO,sum(GONGWENINFO) as GONGWENINFO,sum(newinfo) as newinfo,sum(serviceinfo) as serviceinfo,"
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
		+ "sum(allcharge) as  allcharge from iostat i,tb_deptinfo d where reportyear = "
		+ getbeginYear + " and reportmonth = " + getbeginMon;
		
		if (!"".equals(dt_id)) {
			sqlStr += " and i.did = d.dt_id(+) and i.did = " + dt_id;
		}else{
			sqlStr += " and i.did = d.dt_id(+) and i.did not in (" + dt_ids + ")";
		}
		sqlStr+="group by dt_name";	
		int yishen = 0; //申请总次数 
		int shenzong = 0; //对申请的答复总数
		int foujuegongkai = 0; //否决公开答复数
		int renyuanshu = 0; //政府信息公开指定专职人员数
		int zdfyzs=0;//主动费用总数
		int sqfyzs=0;//申请费用总数
		String columnName = "";
		String dtName = "";
		int cloumnVal = 0;	
		int u=0;
		rs = dImpl.executeQuery(sqlStr);
		while (rs.next()&&rs!=null){
		rsmd = rs.getMetaData();
		
//It's my starting......	
%>				
				<TR height=20 >
                <TD><div id="DTNAME<%=u%>" align="center"></div></TD>
				<TD><div id="ZHUDONGTOTALSINFO<%=u%>" align="center"></div></TD>
                <TD><div id="ALLEINFO<%=u%>" align="center"></div></TD>
				<TD><div id="GONGWENINFO<%=u%>" align="center"></div></TD>
                <TD><div id="NEWINFO<%=u%>" align="center"></div></TD>

                <TD><div id="SERVICEINFO<%=u%>" align="center"></div></TD>
                <TD><div id="COLUMNVC<%=u%>" align="center"></div></TD>
                <TD><div id="LOCALERECEIVE<%=u%>" align="center"></div></TD>
                <TD><div id="CONSULTATION<%=u%>" align="center"></div></TD>
                <TD><div id="CONTELE<%=u%>" align="center"></div></TD>
                <TD><div id="APPLYINDEX<%=u%>" align="center"></div></TD>
				<TD><div id="NATIONALSECRET<%=u%>" align="center"></div></TD>
                <TD><div id="yishen<%=u%>" align="center"></div></TD>
                <TD><div id="INTERVIEWAPPLY<%=u%>" align="center"></div></TD>
                <TD><div id="FAXAPPLY<%=u%>" align="center"></div></TD>
                <TD><div id="EMAILAPPLY<%=u%>" align="center"></div></TD>
                <TD><div id="WEBAPPLY<%=u%>" align="center"></div></TD>
                <TD><div id="LETTERAPPLY<%=u%>" align="center"></div></TD>
                <TD><div id="OTHERAPPLY<%=u%>" align="center"></div></TD>
                <TD><div id="shenzong<%=u%>" align="center"></div></TD>
                <TD><div id="AOPEN<%=u%>" align="center"></div></TD>
                <TD><div id="APARTOPEN<%=u%>" align="center"></div></TD>
				<TD><div id="FGDSZZFXXS<%=u%>" align="center"></div></TD>
				<TD><div id="NOINFO<%=u%>" align="center"></div></TD>
				<TD><div id="NODEPT<%=u%>" align="center"></div></TD>
				<TD><div id="NOBOUND<%=u%>" align="center"></div></TD>
				<TD><div id="CFSQS<%=u%>" align="center"></div></TD>

                <TD><div id="foujuegongkai<%=u%>" align="center"></div></TD>
                <TD><div id="NOOPEN1<%=u%>" align="center"></div></TD>
                <TD><div id="NOOPEN2<%=u%>" align="center"></div></TD>
                <TD><div id="NOOPEN3<%=u%>" align="center"></div></TD>
                <TD><div id="NOOPEN4<%=u%>" align="center"></div></TD>
                <TD><div id="NOOPEN5<%=u%>" align="center"></div></TD>
                <TD><div id="NOOPEN6<%=u%>" align="center"></div></TD>
                <TD><div id="ADMINFUY<%=u%>" align="center"></div></TD>
                <TD><div id="ADMINSUS<%=u%>" align="center"></div></TD>
                <TD><div id="ADMINSHENS<%=u%>" align="center"></div></TD>
                <TD><div id="allfyzs<%=u%>" align="center"></div></TD>
                <TD><div id="zdfyzs<%=u%>" align="center"></div></TD>
                <TD><div id="ZDMAILCHARGE<%=u%>" align="center"></div></TD>
                <TD><div id="ZDCOPYCHARGESHEET<%=u%>" align="center"></div></TD>
                <TD><div id="ZDCOPYCHARGEDISK<%=u%>" align="center"></div></TD>
                <TD><div id="ZDCOPYCHARGEFDISK<%=u%>" align="center"></div></TD>
                <TD><div id="sqfyzs<%=u%>" align="center"></div></TD>
                <TD><div id="SEARCHCHARGE<%=u%>" align="center"></div></TD>
                <TD><div id="MAILCHARGE<%=u%>" align="center"></div></TD>
                <TD><div id="COPYCHARGESHEET<%=u%>" align="center"></div></TD>
                <TD><div id="COPYCHARGEDISK<%=u%>" align="center"></div></TD>
                <TD><div id="COPYCHARGEFDISK<%=u%>" align="center"></div></TD>
                <TD><div id="renyuanshu<%=u%>" align="center"></div></TD>
                <TD><div id="ALLDAYJOB<%=u%>" align="center"></div></TD>
                <TD><div id="PARTTIMEJOB<%=u%>" align="center"></div></TD>
                <TD><div id="DEALCHARGE<%=u%>" align="center"></div></TD>
                <TD><div id="DEALPAY<%=u%>" align="center"></div></TD>
                <TD><div id="ALLCHARGE<%=u%>" align="center"></div></TD>
				</TR>
<%

//for循环开始	
			for (int i=1; i < rsmd.getColumnCount() + 1; i++) {
				columnName = rsmd.getColumnName(i).toUpperCase();

				//判断是否为空，如果是空就默认值为0
				if(rs.getString(rsmd.getColumnName(i)) == null)
				{
					cloumnVal=0;
				}else{
					if(java.lang.Character.isDigit(rs.getString(rsmd.getColumnName(i)).charAt(0)))
					{
						cloumnVal = Integer.parseInt(rs.getString(rsmd.getColumnName(i)));
						
					}else{
						dtName = rs.getString(rsmd.getColumnName(i));
					}
					//System.out.println(dtName+"第"+i+"个名"+columnName+"------------------第"+i+"个值"+cloumnVal);
				}
				
				
				//判断字段名称是否相同，如果相同就累加
				if ((columnName+""+u).equals("INTERVIEWAPPLY"+u+"")
				|| (columnName+""+u).equals("FAXAPPLY"+u+"")
				|| (columnName+""+u).equals("EMAILAPPLY"+u+"")
				|| (columnName+""+u).equals("WEBAPPLY"+u+"")
				|| (columnName+""+u).equals("LETTERAPPLY"+u+"")
				|| (columnName+""+u).equals("OTHERAPPLY"+u+"")) {
			yishen += cloumnVal;
				}
				
				if ((columnName+""+u).equals("AOPEN"+u+"")
					||(columnName+""+u).equals("APARTOPEN"+u+"")
					||(columnName+""+u).equals("FGDSZZFXXS"+u+"")
					||(columnName+""+u).equals("NOINFO"+u+"")
					||(columnName+""+u).equals("NODEPT"+u+"")
					||(columnName+""+u).equals("NOBOUND"+u+"")
					||(columnName+""+u).equals("CFSQS"+u+"")) {
			shenzong += cloumnVal;
				}
				
				if ((columnName+""+u).equals("NOOPEN1"+u+"")
					||(columnName+""+u).equals("NOOPEN2"+u+"")
					||(columnName+""+u).equals("NOOPEN3"+u+"")
					||(columnName+""+u).equals("NOOPEN4"+u+"")
					||(columnName+""+u).equals("NOOPEN5"+u+"")
					||(columnName+""+u).equals("NOOPEN6"+u+"")) {
			foujuegongkai += cloumnVal;
				}
				
				if ((columnName+""+u).equals("SEARCHCHARGE"+u+"")
				|| (columnName+""+u).equals("MAILCHARGE"+u+"")
				|| (columnName+""+u).equals("COPYCHARGESHEET"+u+"")
				|| (columnName+""+u).equals("COPYCHARGEDISK"+u+"")
				|| (columnName+""+u).equals("COPYCHARGEFDISK"+u+"")) {
			sqfyzs += cloumnVal;
				}
				
				
				if ((columnName+""+u).equals("ZDMAILCHARGE"+u+"")
				|| (columnName+""+u).equals("ZDCOPYCHARGESHEET"+u+"")
				|| (columnName+""+u).equals("ZDCOPYCHARGEDISK"+u+"")
				|| (columnName+""+u).equals("ZDCOPYCHARGEFDISK"+u+"")) {
			zdfyzs += cloumnVal;
				}
				
				if ((columnName+""+u).equals("ALLDAYJOB"+u+"")
				|| (columnName+""+u).equals("PARTTIMEJOB"+u+"")) {
			renyuanshu += cloumnVal;
				}
			
			out.print("<script language='javascript'>todo('"
			+ (columnName+""+u)+ "','" + cloumnVal + "')</script>");
			
//最后一行的计算开始
if ((columnName+""+u).equals("ZHUDONGTOTALSINFO"+u+"")) ZHUDONGTOTALSINFO_+=cloumnVal;
if ((columnName+""+u).equals("ALLEINFO"+u+"")) ALLEINFO_+=cloumnVal;
if ((columnName+""+u).equals("GONGWENINFO"+u+"")) GONGWENINFO_+=cloumnVal;
if ((columnName+""+u).equals("NEWINFO"+u+"")) NEWINFO_+=cloumnVal;


if ((columnName+""+u).equals("SERVICEINFO"+u+"")) SERVICEINFO_+=cloumnVal;
if ((columnName+""+u).equals("COLUMNVC"+u+"")) COLUMNVC_+=cloumnVal;
if ((columnName+""+u).equals("LOCALERECEIVE"+u+"")) LOCALERECEIVE_+=cloumnVal; 
if ((columnName+""+u).equals("CONSULTATION"+u+"")) CONSULTATION_+=cloumnVal; 
if ((columnName+""+u).equals("CONTELE"+u+"")) CONTELE_+=cloumnVal; 
if ((columnName+""+u).equals("APPLYINDEX"+u+"")) APPLYINDEX_+=cloumnVal;
if ((columnName+""+u).equals("NATIONALSECRET"+u+"")) NATIONALSECRET_+=cloumnVal;
 
//if (columnName.equals("yishen")) yishen_+=yishen;
if ((columnName+""+u).equals("INTERVIEWAPPLY"+u+"")) INTERVIEWAPPLY_+=cloumnVal;
if ((columnName+""+u).equals("FAXAPPLY"+u+"")) FAXAPPLY_+=cloumnVal;
if ((columnName+""+u).equals("EMAILAPPLY"+u+"")) EMAILAPPLY_+=cloumnVal;
if ((columnName+""+u).equals("WEBAPPLY"+u+"")) WEBAPPLY_+=cloumnVal;
if ((columnName+""+u).equals("LETTERAPPLY"+u+"")) LETTERAPPLY_+=cloumnVal;
if (columnName.equals("OTHERAPPLY"+u+"")) OTHERAPPLY_+=cloumnVal;

//if (columnName.equals("shenzong")) shenzong_+=shenzong;
if ((columnName+""+u).equals("AOPEN"+u+"")) AOPEN_+=cloumnVal;
if ((columnName+""+u).equals("APARTOPEN"+u+"")) APARTOPEN_+=cloumnVal;

if (columnName.equals("foujuegongkai")) foujuegongkai_+=foujuegongkai;
if ((columnName+""+u).equals("FGDSZZFXXS"+u+"")) FGDSZZFXXS_+=cloumnVal;
if ((columnName+""+u).equals("NOINFO"+u+"")) NOINFO_+=cloumnVal;
if ((columnName+""+u).equals("NODEPT"+u+"")) NODEPT_+=cloumnVal;
if ((columnName+""+u).equals("NOBOUND"+u+"")) NOBOUND_+=cloumnVal;
if ((columnName+""+u).equals("CFSQS"+u+"")) CFSQS_+=cloumnVal;
if ((columnName+""+u).equals("NOOPEN1"+u+"")) NOOPEN1_+=cloumnVal;
if ((columnName+""+u).equals("NOOPEN2"+u+"")) NOOPEN2_+=cloumnVal;
if ((columnName+""+u).equals("NOOPEN3"+u+"")) NOOPEN3_+=cloumnVal;
if ((columnName+""+u).equals("NOOPEN4"+u+"")) NOOPEN4_+=cloumnVal;
if ((columnName+""+u).equals("NOOPEN5"+u+"")) NOOPEN5_+=cloumnVal;
if ((columnName+""+u).equals("NOOPEN6"+u+"")) NOOPEN6_+=cloumnVal;
if ((columnName+""+u).equals("ADMINFUY"+u+"")) ADMINFUY_+=cloumnVal;
if ((columnName+""+u).equals("ADMINSUS"+u+"")) ADMINSUS_+=cloumnVal;
if ((columnName+""+u).equals("ADMINSHENS"+u+"")) ADMINSHENS_+=cloumnVal;
//if (columnName.equals("allfyzs")) allfyzs_+=sqfyzs+zdfyzs;
//if (columnName.equals("zdfyzs")) zdfyzs_+=zdfyzs;
if ((columnName+""+u).equals("ZDMAILCHARGE"+u+"")) ZDMAILCHARGE_+=cloumnVal;
if ((columnName+""+u).equals("ZDCOPYCHARGESHEET"+u+"")) ZDCOPYCHARGESHEET_+=cloumnVal;
if ((columnName+""+u).equals("ZDCOPYCHARGEDISK"+u+"")) ZDCOPYCHARGEDISK_+=cloumnVal;
if ((columnName+""+u).equals("ZDCOPYCHARGEFDISK"+u+"")) ZDCOPYCHARGEFDISK_+=cloumnVal;


//if (columnName.equals("sqfyzs")) sqfyzs_+=sqfyzs;
if ((columnName+""+u).equals("SEARCHCHARGE"+u+"")) SEARCHCHARGE_+=cloumnVal;
if ((columnName+""+u).equals("MAILCHARGE"+u+"")) MAILCHARGE_+=cloumnVal;
if ((columnName+""+u).equals("COPYCHARGESHEET"+u+"")) COPYCHARGESHEET_+=cloumnVal;
if ((columnName+""+u).equals("COPYCHARGEDISK"+u+"")) COPYCHARGEDISK_+=cloumnVal;
if ((columnName+""+u).equals("COPYCHARGEFDISK"+u+"")) COPYCHARGEFDISK_+=cloumnVal;

//if (columnName.equals("renyuanshu")) renyuanshu_+=renyuanshu;
if ((columnName+""+u).equals("ALLDAYJOB"+u+"")) ALLDAYJOB_+=cloumnVal;
if ((columnName+""+u).equals("PARTTIMEJOB"+u+"")) PARTTIMEJOB_+=cloumnVal;

if ((columnName+""+u).equals("DEALCHARGE"+u+"")) DEALCHARGE_+=cloumnVal;
if ((columnName+""+u).equals("DEALPAY"+u+"")) DEALPAY_+=cloumnVal;
if ((columnName+""+u).equals("ALLCHARGE"+u+"")) ALLCHARGE_+=cloumnVal;

//最后一行的计算结束
			}
//for循环结束
			yishen_+=yishen;//申请总数
			shenzong += foujuegongkai;
			shenzong_+=shenzong;//对申请的答复总数
			foujuegongkai_+=foujuegongkai;//不予公开答复总数
			
			zdfyzs_+=zdfyzs;//主动公开收取费用
			sqfyzs_+=sqfyzs;//依申请提供信息收取费用
			allfyzs_+=sqfyzs+zdfyzs;//收取费用总数
			renyuanshu_+=renyuanshu;//政府信息公开指定专职人员数
			
			out.print("<script language='javascript'>todo('DTNAME"+u+"','" + dtName + "')</script>");
			out.print("<script language='javascript'>todo('ZHUDONGTOTALSINFO"+u+"','" + ZHUDONGTOTALSINFO_
			+ "')</script>");
			out.print("<script language='javascript'>todo('yishen"+u+"','"
			+ yishen + "')</script>");
			out.print("<script language='javascript'>todo('shenzong"+u+"','"
			+ shenzong + "')</script>");
			out
			.print("<script language='javascript'>todo('foujuegongkai"+u+"','"
					+ foujuegongkai + "')</script>");
			out
			.print("<script language='javascript'>todo('allfyzs"+u+"','"
					+ (sqfyzs+zdfyzs) + "')</script>");
			out.print("<script language='javascript'>todo('sqfyzs"+u+"','"
			+ sqfyzs + "')</script>");
			out.print("<script language='javascript'>todo('zdfyzs"+u+"','"
			+ zdfyzs + "')</script>");
			out.print("<script language='javascript'>todo('renyuanshu"+u+"','"
			+ renyuanshu + "')</script>");
				
				//各个总数清零
				shenzong = 0;
				yishen = 0;
				foujuegongkai = 0;
				ZHUDONGTOTALSINFO_ = 0;
				zdfyzs = 0;
				sqfyzs = 0;
			u++;
			}
			rs.close();
			
			//}else{
			//out.println("<tr><td colspan=9>没有记录！</td></tr>");
			//}

%>              
              
              <TR height=20>
                <TD>小计</TD>
                <TD><%=ZHUDONGTOTALSINFO_%></TD>
                <TD><%=ALLEINFO_%></TD>
				<TD><%=GONGWENINFO_%></TD>
                <TD><%=NEWINFO_%></TD>
				
				<TD><%=SERVICEINFO_%></TD>
                <TD><%=COLUMNVC_%></TD>
                <TD><%=LOCALERECEIVE_%></TD>
                <TD><%=CONSULTATION_%></TD>
                <TD><%=CONTELE_%></TD>
                <TD><%=APPLYINDEX_%></TD>
				<TD><%=NATIONALSECRET_%></TD>
				
				<TD><%=yishen_%></TD>
                <TD><%=INTERVIEWAPPLY_%></TD>
                <TD><%=FAXAPPLY_%></TD>
                <TD><%=EMAILAPPLY_%></TD>
                <TD><%=WEBAPPLY_%></TD>
                <TD><%=LETTERAPPLY_%></TD>
                <TD><%=OTHERAPPLY_%></TD>
				
                <TD><%=shenzong_%></TD>
                <TD><%=AOPEN_%></TD>
                <TD><%=APARTOPEN_%></TD>
				<TD><%=FGDSZZFXXS_%></TD>
                <TD><%=NOINFO_%></TD>
                <TD><%=NODEPT_%></TD>
                <TD><%=NOBOUND_%></TD>
                <TD><%=CFSQS_%></TD>
				<TD><%=foujuegongkai_%></TD>
                <TD><%=NOOPEN1_%></TD>
                <TD><%=NOOPEN2_%></TD>
                <TD><%=NOOPEN3_%></TD>
                <TD><%=NOOPEN4_%></TD>
                <TD><%=NOOPEN5_%></TD>
                <TD><%=NOOPEN6_%></TD>
				
				<TD><%=ADMINFUY_%></TD>
                <TD><%=ADMINSUS_%></TD>
                <TD><%=ADMINSHENS_%></TD>
				<TD><%=allfyzs_%></TD>
				
				<TD><%=zdfyzs_%></TD>
				<TD><%=ZDMAILCHARGE_%></TD>
                <TD><%=ZDCOPYCHARGESHEET_%></TD>
                <TD><%=ZDCOPYCHARGEDISK_%></TD>
                <TD><%=ZDCOPYCHARGEFDISK_%></TD>
				
				<TD><%=sqfyzs_%></TD>
                <TD><%=SEARCHCHARGE_%></TD>
                <TD><%=MAILCHARGE_%></TD>
                <TD><%=COPYCHARGESHEET_%></TD>
                <TD><%=COPYCHARGEDISK_%></TD>
                <TD><%=COPYCHARGEFDISK_%></TD>
                
                
                <TD><%=renyuanshu_%></TD>
                <TD><%=ALLDAYJOB_%></TD>
                <TD><%=PARTTIMEJOB_%></TD>
                
				<TD><%=DEALCHARGE_%></TD>
                <TD><%=DEALPAY_%></TD>
                <TD><%=ALLCHARGE_%></TD>
				</TR>
				
				
</TBODY></TABLE></TD></TR></TBODY></TABLE></TD></TR></TBODY></TABLE>
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