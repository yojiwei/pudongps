<%@page contentType="text/html; charset=GBK"%>
<%@include file="/system/app/skin/head.jsp"%>
<script language="javascript">
function todoo(id,val) {
	var obj;
	obj = document.getElementById(id);
	obj.innerText = val;
}
function todooo(id,val) {
	var obj;
	obj = document.getElementById(id);
	obj.value = val;
}
function checkMonth(){
    dayObj=new Date();  
	if(dayObj.getDate()>5)
	alert("根据新区信息公开办规定，信息公开报表必须在每月5日之前上报!");
}
</script>
<%
	Calendar ca = Calendar.getInstance();
	int day = ca.get(Calendar.DAY_OF_MONTH);
	if(day>5){
	out.println("<script>alert(\"根据新区信息公开办规定，信息公开报表必须在每月5日之前上报!\");</script>");
	//window.location.href='xixs.jsp';
	//return;
	}
	//author:may	
	//method:信息统计
	//date: 2007-03-09  
	String ID = "";
	String ename = "";
	String infoid = "";
	String infotitle = "";
	String applytime = "";
	String genre = "";
	String status = "";
	String sqlStr = "";
	String strTitle = "浦东新区政府信息公开月报";
	String FXSM = "";//分析说明
	boolean isread=false;
	CDataCn dCn = null;
	CDataImpl dImpl = null;
	CMySelf self = (CMySelf)session.getAttribute("mySelf");
	String dt_id="";
	dt_id = String.valueOf(self.getDtId());
	Vector vPage = null;
	Hashtable content = null;
	//update by dongliang
	String getbeginYear = CTools.dealString(
			request.getParameter("beginYear")).trim();
	String getbeginMon = CTools.dealString(
			request.getParameter("beginMon")).trim();
	//
	ResultSet rs = null;
	ResultSetMetaData rsmd = null;
	try {

		dCn = new CDataCn();
		dImpl = new CDataImpl(dCn);
%>
<script language="javascript">
function SelectAllCheck(des,name){
	var obj = eval("document.ZHUDONGTOTALSINFO1." + name);
	if(typeof(obj)=="undefined"){
		return false;
	}else{
		if(obj.length==undefined){
			switch(des.checked){
				case false:
				obj.checked = false;
				break;
				case true:
				obj.checked = true;
				break;
				}
		}else{
			for(i=0;i<obj.length;i++){
				switch(des.checked){
					case false:
					obj[i].checked = false;
					break;
					case true:
					obj[i].checked = true;
					break;
				}
			}
		}
	}
}

function jobcheckup(t,o,c){
	var obj = document.ZHUDONGTOTALSINFO1.checkdel;
	var status = false;
	if(obj!=undefined){
		if(obj.length==undefined){
			obj.checked?status=true:status=false;
		}else{
			for(i=0;i<obj.length;i++){
				if(obj[i].checked){
					status=true;
					break;
				}
			}
		}
	}
	if(status){
		if(confirm("您确定这样操作？")){
			var form = document.formData;
			form.action = t;
			form.target = o;
			form.submit();
		}
	}else{
		alert("请至少选择一个记录！");
	}
}
/**
*author :may
*date 2007-03-08
*method:来检查输入的内容
**/
function todo() {
	var obj = document.getElementsByTagName("input");
	if(obj!=undefined){
		if(obj.length==undefined){
		
		}else{
			for(i=0; i<obj.length; i++){
				if(obj[i].an!=undefined){
					if (obj[i].value == "") {
						alert("请输入"+obj[i].an+"!");
						obj[i].focus();
						return false;
					}else {	
						if (checkNum(obj[i].value)) {
							alert("请输入数字！");
							obj[i].focus();
							return false;
						}
					}
				}
			}
		}
	}
	var int0 = parseInt(formData.ZHUDONGTOTALSINFO.value);
    var int1 = parseInt(formData.GONGWENINFO.value);
	var int2 = parseInt(formData.ALLEINFO.value);
	var int3 = parseInt(formData.NEWINFO.value);
	//var int10 = parseInt(formData.foujuegongkai.value);
	var int4 = parseInt(formData.NOOPEN1.value);
	var int5 = parseInt(formData.NOOPEN2.value);
	var int6 = parseInt(formData.NOOPEN3.value);
	var int7 = parseInt(formData.NOOPEN4.value);
	var int8 = parseInt(formData.NOOPEN5.value);
	var int9 = parseInt(formData.NOOPEN6.value);
	var intsum1 = int1+int2;
	var intsum2 = int4+int5+int6+int7+int8+int9;
	if (int0<intsum1)
		{
			alert("请注意！主动信息公开数不能小于全文电子化的主动公开信息数和公文类信息数之和");
			return false;
		}
	if (int1<int3)
		{
			alert("请注意！公文类信息数不能小于新增的行政规范性文件数");
			return false;
		} 
	if (formData.FXSM.value.replace(/^\s+|\s+$/g,"")=="")
    	{
    		alert("请填写分析说明！");
    		formData.FXSM.focus();
    		return false;
  		}
	formData.submit();
}


function checkNum(obj) {
	if (isNaN(obj))
		return true;
	else
		return false;
}

</script>
<%@include file="/system/app/skin/skin4/template/list_top.jsp"%>
<!--    模块名称开始    -->
<%=strTitle%>
<!--    模块名称结束    -->
<%@include file="/system/app/skin/skin4/template/list_function.jsp"%>                                                            
<!--    功能按钮开始    -->
<img src="../../images/goback.gif" border="0"onclick="javascript:history.back();" title="返回"
style="cursor:hand" align="absmiddle">返回
<!--    功能按钮结束    -->
<%@include file="/system/app/skin/skin4/template/list_listtop.jsp"%>                                                                                        
<!--    列表开始    -->
<form name="formData" action="savedata.jsp" method="post">
	<table table class="FindAreaTable1" cellspacing="1" rules="cols" border="0" id="ctl00_DataGrid_DataGrid1" style="border-width:0px;">
	<%//id="ctl00_DataGrid_DataGrid1"%>
					<tr>
						<td colspan="5" align="center">
							<table WIDTH="100%" BORDER="0" CELLSPACING="0" CELLPADDING="2">
								<tr class="bttn">
									<td width="15%" 	
							align="center" class="outset-table">信息公开报表必须在每月5日之前上报
							
							，从08年8月开始正式实行，逾期不接受补报，年终将对漏报单位进行通报处理！</td>
								</tr>
							</table>
						</td>
					</tr>
					<tr>
						<td colspan="5" align="center">
							<table WIDTH="100%" BORDER="0" CELLSPACING="0" CELLPADDING="2">
								<tr class="bttn">
									<td width="15%" align="center" class="outset-table">
							<%
							Calendar c=Calendar.getInstance();
							if(c.get(Calendar.DAY_OF_MONTH)<11){
								c.add(Calendar.MONTH, -1);
								//out.println("报送的是"+c.get(Calendar.MONTH));
								}
							Calendar c1=Calendar.getInstance();
							%>
							
							<%=c.get(Calendar.YEAR)%> 年 <%=(c.get(Calendar.MONTH)+1)%>月
									</td>
								</tr>
							</table>
						</td>
					</tr>
					<input type="hidden" name="beginYear" value="<%=c.get(Calendar.YEAR)%>">
					<input type="hidden" name="beginMon" value="<%=(c.get(Calendar.MONTH)+1)%>">
<%		
		sqlStr="select * from iostat where uiid in (select ui_id from tb_userinfo where dt_id="+dt_id+") and reportyear="+c.get(Calendar.YEAR)+" and  reportmonth="+(c.get(Calendar.MONTH)+1)+" and rownum<2";
		if(dImpl.getDataInfo(sqlStr)!=null){
			isread=true;
		}
//<!--  分析说明  -->
		sqlStr = "select fxsm from iostat where reportyear = "
		+ c.get(Calendar.YEAR)+" and reportmonth="+ (c.get(Calendar.MONTH)+1)+" and uiid in (select ui_id from tb_userinfo where dt_id="+dt_id+") order by id desc";
		content = dImpl.getDataInfo(sqlStr);
		if(content!=null) FXSM = content.get("fxsm").toString();
//<!--  结束   -->
		//查询年度总计数
		//统计数据库中数据的条数
		sqlStr = "select sum(ZHUDONGTOTALSINFO) as ZHUDONGTOTALSINFO,sum(alleinfo) as alleinfo,sum(GONGWENINFO) as GONGWENINFO,sum(newinfo) as newinfo,sum(serviceinfo) as serviceinfo,"
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
		+ "sum(copychargefdisk) as copychargefdisk,sum(cfsqs) as cfsqs from iostat where reportyear = "
		+ c.get(Calendar.YEAR)+" and uiid in (select ui_id from tb_userinfo where dt_id="+dt_id+") order by id desc";
		rs = dImpl.executeQuery(sqlStr);
		if (rs.next())
			rsmd = rs.getMetaData();



%>
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
							本年累计
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
						<td align="center">
							<input type="text" name="ZHUDONGTOTALSINFO" an="主动信息公开" size="10" <%=isread?"readOnly":""%> />
						</td>
						<td>
							<div id="ZHUDONGTOTALSINFO1"  align="center"></div>
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
							<input type="text" name="ALLEINFO" an="全文电子化的主动公开信息数" 
							size="10" <%=isread?"readOnly":""%> />
						</td>
						<td align="center">
							<div id="ALLEINFO1" align="center"></div>
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
							<input type="text" name="GONGWENINFO" an="公文类信息数"
							size="10" <%=isread?"readOnly":""%> />
						</td>
						<td>
							<div id="GONGWENINFO1" align="center"></div>
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
							<input type="text" name="NEWINFO" an="新增的行政规范性文件数" size="10" <%=isread?"readOnly":""%>>
						</td>
						<td align="center">
							<div id="NEWINFO1" align="center"></div>
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
							<input type="text" name="SERVICEINFO" an="提供服务类信息数" size="10" <%=isread?"readOnly":""%>>
						</td>
						<td align="center">
							<div id="SERVICEINFO1" align="center"></div>
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
							<input type="text" name="COLUMNVC" an="网站专栏页面访问量" size="10" <%=isread?"readOnly":""%>>
						</td>
												<td align="center">
							<div id="COLUMNVC1" align="center"></div>
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
							<input type="text" name="LOCALERECEIVE" an="现场接待人数" size="10" <%=isread?"readOnly":""%>/>
						</td>
												<td align="center">
							<div id="LOCALERECEIVE1" align="center"></div>
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
							<input type="text" name="CONSULTATION" an="网上咨询数" size="10" <%=isread?"readOnly":""%>>
						</td>
												<td align="center">
							<div id="CONSULTATION1" align="center"></div>
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
							<input type="text" name="CONTELE" an="咨询电话接听数" size="10" <%=isread?"readOnly":""%>>
						</td>
												<td align="center">
							<div id="CONTELE1" align="center"></div>
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
							<input type="text" name="APPLYINDEX" an="依申请公开信息目录数" size="10" <%=isread?"readOnly":""%>>
						</td>
												<td align="center">
							<div id="APPLYINDEX1" align="center"></div>
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
							<input type="text" name="NATIONALSECRET" an="属于国家秘密的公文类信息数" size="10" <%=isread?"readOnly":""%>>
						</td>
												<td align="center">
							<div id="NATIONALSECRET1" align="center"></div>
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
							13
						</td>
						<td align="center">
							<input type="text" name="INTERVIEWAPPLY" an="当面申请数" size="10" <%=isread?"readOnly":""%>>
						</td>
												<td align="center">
							<div id="INTERVIEWAPPLY1" align="center"></div>
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
							<input type="text" name="FAXAPPLY" an="传真申请数" size="10" <%=isread?"readOnly":""%>>
						</td>
												<td align="center">
							<div id="FAXAPPLY1" align="center"></div>
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
							<input type="text" name="EMAILAPPLY" an="电子邮件申请数" size="10" <%=isread?"readOnly":""%>>
						</td>
												<td align="center">
							<div id="EMAILAPPLY1" align="center"></div>
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
							<input type="text" name="WEBAPPLY" an="网上申请数" size="10" <%=isread?"readOnly":""%>>
						</td>
												<td align="center">
							<div id="WEBAPPLY1" align="center"></div>
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
							<input type="text" name="LETTERAPPLY" an="信函申请数" size="10" <%=isread?"readOnly":""%>>
						</td>
												<td align="center">
							<div id="LETTERAPPLY1" align="center"></div>
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
							<input type="text" name="OTHERAPPLY" an="其它形式申请数" size="10" <%=isread?"readOnly":""%>>
						</td>
												<td align="center">
							<div id="OTHERAPPLY1" align="center"></div>
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
							20
						</td>
						<td align="center">
							<input type="text" name="AOPEN" an="同意公开答复数" size="10" <%=isread?"readOnly":""%>>
						</td>
												<td align="center">
							<div id="AOPEN1" align="center"></div>
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
							<input type="text" name="APARTOPEN" an="同意部分公开答复数" size="10" <%=isread?"readOnly":""%>>
						</td>
												<td align="center">
							<div id="APARTOPEN1" align="center"></div>
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
							<input type="text" name="FGDSZZFXXS" an="'非<<规定>>所指政府信息'数" size="10" <%=isread?"readOnly":""%>>
						</td>
												<td align="center">
							<div id="FGDSZZFXXS1" align="center"></div>
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
							<input type="text" name="NOINFO" an="'信息不存在'数" size="10" <%=isread?"readOnly":""%>>
						</td>
												<td align="center">
							<div id="NOINFO1" align="center"></div>
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
							<input type="text" name="NODEPT" an="'非本机关职权范围'数" size="10" <%=isread?"readOnly":""%>>
						</td>
												<td align="center">
							<div id="NODEPT1" align="center"></div>
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
							<input type="text" name="NOBOUND" an="'申请内容不明确'数" size="10" <%=isread?"readOnly":""%>>
						</td>
												<td align="center">
							<div id="NOBOUND1" align="center"></div>
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
							<input type="text" name="CFSQS" an="'重复申请'数" size="10" <%=isread?"readOnly":""%>>
						</td>
												<td align="center">
							<div id="CFSQS1"  align="center"></div>
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
							<!--input type="text" name="foujuegongkai" an="不予公开答复总数" size="10" <%=isread?"readOnly":""%>-->
						</td>
												<td align="center">
							<div id="foujuegongkai1" align="center"></div>
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
							<input type="text" name="NOOPEN1" an="'国家秘密'数" size="10" <%=isread?"readOnly":""%>>
						</td>
																		<td align="center">
							<div id="NOOPEN11" align="center"></div>
						</td>
					</tr>
					<tr class="bttn">
						<td align="left">
							&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;（2）“商业秘密”数
						</td>
						<td align="center">
							条
						</td>
						<td align="center">
							29
						</td>
						<td align="center">
							<input type="text" name="NOOPEN2" an="'商业秘密'数" size="10" <%=isread?"readOnly":""%>>
						</td>
												<td align="center">
							<div id="NOOPEN21" align="center"></div>
						</td>
					</tr>
					<tr class="bttn">
						<td align="left">
							&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;（3）“个人隐私”数
						</td>
						<td align="center">
							条
						</td>
						<td align="center">
							30
						</td>
						<td align="center">
							<input type="text" name="NOOPEN3" an="'个人隐私'数" size="10" <%=isread?"readOnly":""%>>
						</td>
						<td align="center">
							<div id="NOOPEN31" align="center"></div>
						</td>
					</tr>
					<tr class="bttn">
						<td align="left">
							&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;（4）“过程中信息且影响安全稳定”数
						</td>
						<td align="center">
							条
						</td>
						<td align="center">
							31
						</td>
						<td align="center">
							<input type="text" name="NOOPEN4" an="'过程中信息且影响安全稳定'数" size="10" <%=isread?"readOnly":""%>>
						</td>
						<td align="center">
							<div id="NOOPEN41" align="center"></div>
						</td>
					</tr>
					<tr class="bttn">
						<td align="left">
							&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;（5）“危及安全和稳定”数
						</td>
						<td align="center">
							条
						</td>
						<td align="center">
							32
						</td>
						<td align="center">
							<input type="text" name="NOOPEN5" an="'危及安全和稳定'数" size="10" <%=isread?"readOnly":""%>>
						</td>
						<td align="center">
							<div id="NOOPEN51" align="center"></div>
						</td>
					</tr>
					<tr class="bttn">
						<td align="left">
							&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;（6）“法律法规规定的其他情形”数
						</td>
						<td align="center">
							条
						</td>
						<td align="center">
							33
						</td>
						<td align="center">
							<input type="text" name="NOOPEN6" an="'法律法规规定的其他情形'数" size="10" <%=isread?"readOnly":""%>>
						</td>
						<td align="center">
							<div id="NOOPEN61" align="center"></div>
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
							<input type="text" name="ADMINFUY" an="行政复议数" size="10" <%=isread?"readOnly":""%>>
						</td>
						<td align="center">
							<div id="ADMINFUY1" align="center"></div>
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
							<input type="text" name="ADMINSUS" an="行政诉讼数" size="10" <%=isread?"readOnly":""%>>
						</td>
						<td align="center">
							<div id="ADMINSUS1" align="center"></div>
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
							<input type="text" name="ADMINSHENS" an="行政申诉数" size="10" <%=isread?"readOnly":""%>>
						</td>
						<td align="center">
							<div id="ADMINSHENS1" align="center"></div>
						</td>
					</tr>
					
					<tr class="bttn">
						<td align="left">
							收取费用总额
						</td>
						<td align="center">
							元
						</td>
						<td align="center">
							37
						</td>
						<td align="center">

						</td>
						<td align="center">
							<div id="allfyzs" align="center"></div>
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
						</td>
						<td align="center">
						<div id="zdfyzs" align="center"></div>
						</td>
					</tr>
					<tr class="bttn">
						<td align="left">	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;其中：1.邮寄费
						</td>
						<td align="center">
							元
						</td>
						<td align="center">
							39
						</td>
						<td align="center">
							<input type="text" name="ZDMAILCHARGE" an="邮寄费" size="10" <%=isread?"readOnly":""%>>
						</td>
						<td align="center">
							<div id="ZDMAILCHARGE1" align="center"></div>
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
							<input type="text" name="ZDCOPYCHARGESHEET" an="复制费（纸张）)" size="10" <%=isread?"readOnly":""%>>
						</td>
						<td align="center">
							<div id="ZDCOPYCHARGESHEET1" align="center"></div>
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
							<input type="text" name="ZDCOPYCHARGEDISK" an="复制费（光盘）)" size="10" <%=isread?"readOnly":""%>>
						</td>
						<td align="center">
							<div id="ZDCOPYCHARGEDISK1" align="center"></div>
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
							<input type="text" name="ZDCOPYCHARGEFDISK" an="复制费（软盘）" size="10" <%=isread?"readOnly":""%>>
						</td>
						<td align="center">
							<div id="ZDCOPYCHARGEFDISK1" align="center"></div>
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
						</td>
						<td align="center">
						<div id="sqfyzs" align="center"></div>
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
							<input type="text" name="SEARCHCHARGE" an="检索费" size="10" <%=isread?"readOnly":""%>>
						</td>
						<td align="center">
							<div id="SEARCHCHARGE1" align="center"></div>
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
							<input type="text" name="MAILCHARGE" an="邮寄费" size="10" <%=isread?"readOnly":""%>>
						</td>
						<td align="center">
							<div id="MAILCHARGE1" align="center"></div>
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
							<input type="text" name="COPYCHARGESHEET" an="复制费（纸张）" size="10" <%=isread?"readOnly":""%>>
						</td>
						<td align="center">
							<div id="COPYCHARGESHEET1" align="center"></div>
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
							<input type="text" name="COPYCHARGEDISK" an="复制费（光盘）)" size="10" <%=isread?"readOnly":""%>>
						</td>
						<td align="center">
							<div id="COPYCHARGEDISK1" align="center"></div>
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
							<input type="text" name="COPYCHARGEFDISK" an="复制费（软盘）" size="10" <%=isread?"readOnly":""%>>
						</td>
						<td align="center">
							<div id="COPYCHARGEFDISK1" align="center"></div>
						</td>
					</tr>
					<%
						int month = c.get(Calendar.MONTH)+1;
					%>

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

						</td>
						<td align="center">
							<div id="renyuanshu" align="center"></div>
						</td>
					</tr>
					<!---：**为半年度统计指标--->
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
						<%
							if(month!=6&&month!=12){
						%>
						<td align="center">
							<input type="text" name="ALLDAYJOB1" an="全职人员数" size="10" readOnly >
						</td>
						<td align="center">
							<div id="ALLDAYJOB" align="center"></div>
						</td>
						<%
							}
						else{
						%>
						<td align="center">
							<input type="text" name="ALLDAYJOB" an="全职人员数" size="10" <%=isread?"readOnly":""%>>
						</td>
						<td align="center">
							<div id="ALLDAYJOB1" align="center"></div>
						</td>
						<%
							}
						%>
						
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
						<%
							if(month!=6&&month!=12){
						%>
						<td align="center">
							<input type="text" name="PARTTIMEJOB1" an="兼职人员数" size="10" readOnly>
						</td>
						<td align="center">
							<div id="PARTTIMEJOB" align="center"></div>
						</td>
						<%
							}
						else{
						%>
						<td align="center">
							<input type="text" name="PARTTIMEJOB" an="兼职人员数" size="10" <%=isread?"readOnly":""%>>
						</td>
						<td align="center">
							<div id="PARTTIMEJOB1" align="center"></div>
						</td>
						<%
							}
						%>
						
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
						<%
							if(month!=6&&month!=12){
						%>
						<td align="center">
							<input type="text" name="DEALCHARGE1" an="处理政府信息公开的专项经费" size="10" readOnly>
						</td>
						<td align="center">
							<div id="DEALCHARGE" align="center"></div>
						</td>
						<%
							}
						else{
						%>
						<td align="center">
							<input type="text" name="DEALCHARGE" an="处理政府信息公开的专项经费" size="10" <%=isread?"readOnly":""%>>
						</td>
						<td align="center">
							<div id="DEALCHARGE1" align="center"></div>
						</td>
						<%
							}
						%>
						
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
						<%
							if(month!=6&&month!=12){
						%>
						<td align="center">
							<input type="text" name="DEALPAY1" an="处理政府信息公开的实际支出" size="10" readOnly>
						</td>
						<td align="center">
							<div id="DEALPAY" align="center"></div>
						</td>
						<%
							}
						else{
						%>
						<td align="center">
							<input type="text" name="DEALPAY" an="处理政府信息公开的实际支出" size="10" <%=isread?"readOnly":""%>>
						</td>
						<td align="center">
							<div id="DEALPAY1" align="center"></div>
						</td>
						<%
							}
						%>
						
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
						<%
							if(month!=6&&month!=12){
						%>
						<td align="center">
							<input type="text" name="ALLCHARGE1" an="与诉讼有关的总费用" size="10" readOnly>
						</td>
						<td align="center">
							<div id="ALLCHARGE" align="center"></div>
						</td>
						<%
							}
						else{
						%>
						<td align="center">
							<input type="text" name="ALLCHARGE" an="与诉讼有关的总费用" size="10" <%=isread?"readOnly":""%>>
						</td>
						<td align="center">
							<div id="ALLCHARGE1" align="center"></div>
						</td>
						<%
							}
						%>
					</tr>
					<!---：**为半年度统计指标--->
					<tr class="bttn">
						<td align="left" colspan='5'>
							标记：**为半年度统计指标，其它为月度统计指标。
						</td>
					</tr>
					<tr class="bttn">
						<td  colspan='5' align="left">
							<div>分析说明：</div><textarea name="FXSM" rows="5" id="FXSM" cols="95"  <%=isread?"readOnly":""%>><%=FXSM%></textarea>
						</td>
					</tr>
				</table>

			</td>
		</tr>
		<tr>
			<td colspan="8" align="center">
				<table WIDTH="100%" BORDER="0" CELLSPACING="0" CELLPADDING="2">
					<tr class="bttn" >
					  <td width="15%" align="left" class="outset-table" colspan="2"> (描述本月政府信息公开工作的总体情况，并对申请情况等有关指标作同比分析，对其中发生明显变化的指标进行具体分析。请重点对公众关注点以及答复处理等方面出现问题作出说明，对其中难以判断是否属于免予公开的案例进行举例说明，并对本部门首次处理不满意的申诉案件作相应的跟踪记录，可针对有关问题提出应对策略和建议。) </td>
					</tr>
				</table>
			</td>
		</tr>
		
		<tr class="title1">
			<td colspan="8" align="center">
				<table WIDTH="100%" BORDER="0" CELLSPACING="1" CELLPADDING="1">
					<tr>
						<td align="center" colspan=15>
						
							<b><%if(!isread){%>
							<input type=button name=btn value=提交 onClick="todo()" />
							<%}else{%>
							<input type=button name=btn value=返回 onClick="javascript:history.go(-1)" />
							<%}%>
							</b>
							
						</td>
					</tr>
	</table>
					
<%
			int ZHUDONGTOTALSINFO1 = 0; //主动信息公开
			int yishen = 0; //申请总次数 
			int shenzong = 0; //对申请的答复总数
			int foujuegongkai1 = 0; //否决公开答复数
			int renyuanshu = 0; //政府信息公开指定专职人员数
			int zdfyzs=0;//主动费用总数
			int sqfyzs=0;//申请费用总数
			int GONGWENINFO1 = 0;
			int FGDSZZFXXS1 = 0;
			int NOINFO1 = 0;
			int NODEPT1 = 0;
			int NOBOUND1 = 0;
			int CFSQS1 = 0;
			int ALLDAYJOB1 = 0;
			int PARTTIMEJOB1 = 0;
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
				if (columnName.equals("ZHUDONGTOTALSINFO")){
			ZHUDONGTOTALSINFO1 += cloumnVal;
				}
				if (columnName.equals("GONGWENINFO")){
			GONGWENINFO1 += cloumnVal;
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
				if (columnName.equals("NOOPEN1")
				|| columnName.equals("NOOPEN2")
				|| columnName.equals("NOOPEN3")
				|| columnName.equals("NOOPEN4")
				|| columnName.equals("NOOPEN5")
				|| columnName.equals("NOOPEN6")) {
			foujuegongkai1 += cloumnVal;
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
				}
				
				
				
				out.print("<script language='javascript'>todoo('"
				+ (columnName+"1") + "','" + cloumnVal + "')</script>");
			}
			shenzong += foujuegongkai1;
			out.print("<script language='javascript'>todoo('yishen','"
			+ yishen + "')</script>");
			out.print("<script language='javascript'>todoo('shenzong','"
			+ shenzong + "')</script>");
			out.print("<script language='javascript'>todoo('foujuegongkai1','"
			+ foujuegongkai1 + "')</script>");
			out
			.print("<script language='javascript'>todoo('allfyzs','"
					+ (sqfyzs+zdfyzs) + "')</script>");
			out.print("<script language='javascript'>todoo('sqfyzs','"
			+ sqfyzs + "')</script>");
			out.print("<script language='javascript'>todoo('zdfyzs','"
			+ zdfyzs + "')</script>");
			out.print("<script language='javascript'>todoo('renyuanshu','"
			+ renyuanshu + "')</script>");
			rs.close();
		if(isread){
			//设置本月已经提交的数据
		//out.print("<script language='javascript'>todoo('ZHUDONGTOTALSINFO','" + ZHUDONGTOTALSINFO1
			//+ "')</script>");
		//out.print("<script language='javascript'>todoo('GONGWENINFO','" + GONGWENINFO1
			//+ "')</script>");
		sqlStr = "select sum(ZHUDONGTOTALSINFO) as ZHUDONGTOTALSINFO,sum(GONGWENINFO) as GONGWENINFO,sum(alleinfo) as alleinfo,sum(newinfo) as newinfo,sum(serviceinfo) as serviceinfo,"
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
		+ "sum(copychargefdisk) as copychargefdisk,sum(cfsqs) as cfsqs ,sum(ALLDAYJOB) as ALLDAYJOB,sum(PARTTIMEJOB) as PARTTIMEJOB,"
		+ "sum(dealcharge) as dealcharge,sum(dealpay) as dealpay,"
		+ "sum(allcharge) as  allcharge from iostat where reportyear = "
		+ c.get(Calendar.YEAR)+" and reportmonth="+ (c.get(Calendar.MONTH)+1)+" and uiid in (select ui_id from tb_userinfo where dt_id="+dt_id+") order by id desc";
		rs = dImpl.executeQuery(sqlStr);
		if (rs.next())
			rsmd = rs.getMetaData();
		for (int i = 1; i < rsmd.getColumnCount() + 1; i++) {
				columnName = rsmd.getColumnName(i).toUpperCase();
				//判断是否为空，如果是空就默认值为0
				cloumnVal = Integer.parseInt(rs.getString(rsmd
				.getColumnName(i)) == null ? "0" : rs
				.getString(rsmd.getColumnName(i)));
				out.print("<script language='javascript'>todooo('"
				+ (columnName) + "','" + cloumnVal + "')</script>");
		}
		rs.close();
		}
//edit by Louis 070907 for 人员数单独处理
		if(c.get(Calendar.MONTH)+1==12&&!isread){
			String alldayjob_tot = "0";
			String parttimejob_tot = "0";
			String DEALCHARGE_tot = "0";//处理政府信息公开的专项经费
			String DEALPAY_tot = "0";//处理政府信息公开的实际支出
			String ALLCHARGE_tot = "0";//与诉讼有关的总费用
			out.print("<script language='javascript'>todoo('ALLDAYJOB1','" + alldayjob_tot + "')</script>");
			out.print("<script language='javascript'>todoo('PARTTIMEJOB1','" + parttimejob_tot + "')</script>");
			out.print("<script language='javascript'>todoo('DEALCHARGE1','" + DEALCHARGE_tot + "')</script>");
			out.print("<script language='javascript'>todoo('DEALPAY1','" + DEALPAY_tot + "')</script>");
			out.print("<script language='javascript'>todoo('ALLCHARGE1','" + ALLCHARGE_tot + "')</script>");
			out.print("<script language='javascript'>todoo('renyuanshu','" + (Integer.parseInt(alldayjob_tot) + Integer.parseInt(parttimejob_tot)) + "')</script>");
		}	
		else{
		String sqlWhere = "";
		if(!isread){
			sqlWhere = "and reportyear = "
		+ c.get(Calendar.YEAR)+" and reportmonth="+ (c.get(Calendar.MONTH))+"";
		}
		else{
			sqlWhere = "and reportyear = "
		+ c.get(Calendar.YEAR)+" and reportmonth="+ (c.get(Calendar.MONTH)+1)+"";
		}
		sqlStr = "select alldayjob,parttimejob,DEALCHARGE,DEALPAY,ALLCHARGE from iostat where uiid in (select ui_id from tb_userinfo where dt_id="+dt_id+") "+sqlWhere+" ";
		//sqlStr = "select alldayjob,parttimejob,DEALCHARGE,DEALPAY,ALLCHARGE from iostat where uiid in (select ui_id from tb_userinfo where dt_id="+dt_id+") order by id desc";
			content = dImpl.getDataInfo(sqlStr);
			if (content != null) {
				String alldayjob_tot = content.get("alldayjob")!= null ? content.get("alldayjob").toString():"0";
				String parttimejob_tot = content.get("parttimejob").toString();
				String DEALCHARGE_tot = content.get("dealcharge").toString();//处理政府信息公开的专项经费
				String DEALPAY_tot = content.get("dealpay").toString();//处理政府信息公开的实际支出
				String ALLCHARGE_tot = content.get("allcharge").toString();//与诉讼有关的总费用
				out.print("<script language='javascript'>todoo('ALLDAYJOB1','" + alldayjob_tot + "')</script>");
				out.print("<script language='javascript'>todoo('PARTTIMEJOB1','" + parttimejob_tot + "')</script>");
				out.print("<script language='javascript'>todoo('DEALCHARGE1','" + DEALCHARGE_tot + "')</script>");
				out.print("<script language='javascript'>todoo('DEALPAY1','" + DEALPAY_tot + "')</script>");
				out.print("<script language='javascript'>todoo('ALLCHARGE1','" + ALLCHARGE_tot + "')</script>");
				out.print("<script language='javascript'>todoo('renyuanshu','" + (Integer.parseInt(alldayjob_tot) + Integer.parseInt(parttimejob_tot)) + "')</script>");
			}
			else{
				String alldayjob_tot = "0";
				String parttimejob_tot = "0";
				String DEALCHARGE_tot = "0";//处理政府信息公开的专项经费
				String DEALPAY_tot = "0";//处理政府信息公开的实际支出
				String ALLCHARGE_tot = "0";//与诉讼有关的总费用
				out.print("<script language='javascript'>todoo('ALLDAYJOB1','" + alldayjob_tot + "')</script>");
				out.print("<script language='javascript'>todoo('PARTTIMEJOB1','" + parttimejob_tot + "')</script>");
				out.print("<script language='javascript'>todoo('DEALCHARGE1','" + DEALCHARGE_tot + "')</script>");
				out.print("<script language='javascript'>todoo('DEALPAY1','" + DEALPAY_tot + "')</script>");
				out.print("<script language='javascript'>todoo('ALLCHARGE1','" + ALLCHARGE_tot + "')</script>");
				out.print("<script language='javascript'>todoo('renyuanshu','" + (Integer.parseInt(alldayjob_tot) + Integer.parseInt(parttimejob_tot)) + "')</script>");
			}
		}

//edit end		
		
%>
<!--    列表结束    -->
<!--%@include file="/system/app/skin/skin4/template/list_bottom.jsp"%--> 
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