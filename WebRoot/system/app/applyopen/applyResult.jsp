<%@page contentType="text/html; charset=GBK"%>
<%@include file="/system/app/skin/import.jsp"%>

<%

CDataCn dCn = null;
CDataImpl dImpl = null;

try{
dCn = new CDataCn();
dImpl = new CDataImpl(dCn);

//infoopen表相关变量
String id = ""; //主键id
String infoid = ""; //申请信息id
String infotitle = ""; //申请信息标题
String proposer =""; //申请人类别：公民、企业
String pname=""; //公民姓名
String punit = ""; //工作单位
String pcard = ""; //证件名称
String pcardnum = ""; //证件号码
String paddress=""; //通信地址
String pzipcode = ""; //邮政编码
String ptele = ""; //联系电话
String ptele1 = ""; //联系电话1
String ptele2 = ""; //联系电话2
String pemail = ""; //电子邮件
String ename = "";//申请企业名称
String ecode = "";//组织结构代码
String ebunissinfo = ""; //营业执照信息
String edeputy =""; //法人代表
String elinkman=""; //联系人
String etele = ""; //联系电话
String etele1 = ""; //联系电话1
String etele2 = ""; //联系电话2
String eemail = ""; //电子邮件
String applytime = ""; //申请时间
String commentinfo=""; //所需信息内容描述
String indexnum = ""; //所需信息索取号
String purpose = ""; //所需信息用途
String ischarge = "0"; //是否减免费用
String chargeAbout = ""; //是否减免费用
String offermodeC[] = new String[4]; //所需信息提供方式
String offermode = ""; //所需信息提供方式
String gainmodeC[] = new String[5]; //获取信息方式
String gainmode = ""; //获取信息方式
//String othermode = ""; //是否接受其他信息提供方式 0不接受、1接受
String feedback = ""; //反馈意见
String status = ""; //状态：0待处理（认领中心）、1处理中、2已结束通过、3处理结束不通过
String finishtime = ""; //结束时间
String ispublish = ""; //是否公开：0公开、1不公开
String signmode = ""; // 申请类别，0网上申请、1现场申请、2E-mail申请、3信函、4电报、5传真、6其它
String dt_id = ""; //受理部门id
String did = ""; //转办部门id
String dname = ""; //部门名称
String flownum = ""; //流水号
String dealmode = ""; //予以公开
String isspot = "0"; //是否当场办理
String isrunit = "0"; //是否由当事人直接向职能单位提出申请
String applymode = ""; //处理方式，1收件，2代办，0由申请人另行申请
String limittime = ""; //办理超期时间
String olimittime = ""; //申请时办理超期时间
String memo = ""; //申请备注

//taskcenter 表相关变量
String genre = ""; //处理方式 受理、转办、认领、指定
String tc_status = "0"; //状态：0待处理（认领中心）、1处理中、2已结束通过、3处理结束不通过
String endtime = ""; //办结时间
String ts_commentinfo = ""; //备注

//rejectreason 表相关变量

//页面处理相关变量
String applyflag = ""; //0表示不办，1表示受理，2表示转办，本部门受理标记
String qword = "信息已成功保存，是否打印信息公开申请代办证明？"; //提交后系统提示问题
String pKind = "0"; //打印单据种类, 0申请代办证明、1申请收件证明
String finishnow = ""; //是否现场处理，0做书面答复、1现场予以答复
String gotuurl = "infoSearch.jsp"; //处理后的跳转路径
String OPType = CTools.dealString(request.getParameter("OPType")).trim();

infoid=CTools.dealString(request.getParameter("infoid")).trim();
infotitle=CTools.dealString(request.getParameter("infotitle")).trim();
proposer=CTools.dealString(request.getParameter("proposer")).trim().toLowerCase();
pname=CTools.dealString(request.getParameter("pname")).trim();
punit=CTools.dealString(request.getParameter("punit")).trim();
pcard=CTools.dealString(request.getParameter("pcard")).trim();
pcardnum=CTools.dealString(request.getParameter("pcardnum")).trim();
paddress=CTools.dealString(request.getParameter("paddress")).trim();
pzipcode=CTools.dealString(request.getParameter("pzipcode")).trim();
ptele=CTools.dealString(request.getParameter("ptele")).trim();
pemail=CTools.dealString(request.getParameter("pemail")).trim();
ename = CTools.dealString(request.getParameter("ename")).trim();
ecode=CTools.dealString(request.getParameter("ecode")).trim();
ebunissinfo=CTools.dealString(request.getParameter("ebunissinfo")).trim();
edeputy=CTools.dealString(request.getParameter("edeputy")).trim();
elinkman=CTools.dealString(request.getParameter("elinkman")).trim();
etele=CTools.dealString(request.getParameter("etele")).trim();
eemail=CTools.dealString(request.getParameter("eemail")).trim();
//applytime = CTools.dealString(request.getParameter("applytime")).trim();
commentinfo=CTools.dealString(request.getParameter("commentinfo")).trim();
indexnum=CTools.dealString(request.getParameter("indexnum")).trim();
purpose=CTools.dealString(request.getParameter("purpose")).trim();
ischarge=CTools.dealString(request.getParameter("ischarge")).trim();
//chargeAbout=CTools.dealString(request.getParameter("chargeAbout")).trim();
offermode=CTools.dealString(request.getParameter("offermode")).trim();
gainmode=CTools.dealString(request.getParameter("gainmode")).trim();
//othermode=CTools.dealString(request.getParameter("othermode")).trim();
//feedback = CTools.dealString(request.getParameter("feedback")).trim();
//status=CTools.dealString(request.getParameter("status")).trim();
//finishtime=CTools.dealString(request.getParameter("finishtime")).trim();
//ispublish=CTools.dealString(request.getParameter("ispublish")).trim();
did=CTools.dealString(request.getParameter("did")).trim();
signmode=CTools.dealString(request.getParameter("signmode")).trim();
limittime=CTools.dealString(request.getParameter("limittime")).trim();
memo=CTools.dealString(request.getParameter("memo")).trim();

applyflag=CTools.dealString(request.getParameter("applyflag")).trim();
finishnow=CTools.dealString(request.getParameter("finishnow")).trim();


//根据登陆用户的部门编号获取受理部门信息
CMySelf mySelf = (CMySelf)session.getAttribute("mySelf");
if (mySelf!=null){
	dt_id = Long.toString(mySelf.getDtId());
	if (!"".equals(dt_id))
	{
	  String dtSql = "select dt_name from tb_deptinfo where dt_id = " + dt_id;
	  Hashtable dtCon = dImpl.getDataInfo(dtSql);
	  if (dtCon != null)
	  {
	    dname = dtCon.get("dt_name").toString();
	  }
	}
}
//获取受理部门信息结束


//项目流水号获取 YYYY+MM+DD+24HH+3位序号+3位随机号

DateFormat df = DateFormat.getDateTimeInstance(DateFormat.DEFAULT,DateFormat.DEFAULT,Locale.CHINA);
applytime = df.format(new java.util.Date());

Calendar calendar = GregorianCalendar.getInstance();


java.text.DecimalFormat l2 = new java.text.DecimalFormat("00");
java.text.DecimalFormat l3 = new java.text.DecimalFormat("000");

flownum += Integer.toString(calendar.get(Calendar.YEAR));
flownum += l2.format(calendar.get(Calendar.MONTH)+1);
flownum += l2.format(calendar.get(Calendar.DATE));
if (calendar.get(Calendar.AM_PM) == 1)
{
  flownum += l2.format(calendar.get(Calendar.HOUR) + 12);
}
else 
{
  flownum += l2.format(calendar.get(Calendar.HOUR));
}

String countNumSql = "select count(*) as countnum from infoopen where to_date(to_char(applytime,'yyyy-mm-dd'),'yyyy-mm-dd') = to_date('"+ applytime.substring(0,applytime.indexOf(' ')) +"','YYYY-MM-DD')";
Hashtable countCon = dImpl.getDataInfo(countNumSql);
if (countCon != null)
{
  flownum +=  l3.format(Integer.parseInt(countCon.get("countnum").toString()) + 1);
}

Random rnd=new Random();   
for(int i=0;i<3;i++) {
flownum += Integer.toString((int)(rnd.nextFloat()*10));
}
//项目流水号获取结束

//判断不同处理方式

if (applyflag.equals("1")) { //受理
  did = dt_id;
  applymode = "1";
  qword = "信息已成功保存，是否打印信息公开申请收件证明？";
  pKind = "1";
  if (finishnow.equals("1")) {  //当场答复
    isspot = "1";
    genre = "当场答复";
    status = "2";
    tc_status = "2";
    dealmode = "0";
    feedback = "当场答复";
    endtime = applytime;
    ts_commentinfo = "当场答复";
    limittime = "";
    //gotuurl = "doList.jsp";
  }
else {   //书面答复
    genre = "受理";
    status = "1";
	}
}
else if (applyflag.equals("0")) { //不办
	isrunit = "1";
	applymode = "0";
	genre = "由申请人直接向信息公开责任单位提出申请";
  status = "2";
  tc_status = "2";
  dealmode = "3";
  limittime = "";
}
else { //认领中心
	applymode = "2";
	if ("".equals(did)) {
    genre = "转办";
    did = "0";
    status = "0";
    tc_status = "2";
    //gotuurl = "claimCenter.jsp";
	}
else { //代办
    genre = "转办";
    status = "1";
    //gotuurl = "doList.jsp";
	}
}



//判断不同处理方式结束

//out.println(applytime);
//开始写数据表
	dCn.beginTrans();
	dImpl.setTableName("infoopen");
	dImpl.setPrimaryFieldName("id");
	if (!OPType.equals("")) {
		if (OPType.equals("add")) {
			id = String.valueOf(dImpl.addNew());
		}
		else if (OPType.equals("edit")) {
			dImpl.edit("infoopen","id",Integer.parseInt(id));
		}
		//out.println(OPType);
		if (!"".equals(infoid)) {
		dImpl.setValue("infoid",infoid,CDataImpl.INT);
		}
		dImpl.setValue("infotitle",infotitle,CDataImpl.STRING);
		dImpl.setValue("proposer",proposer,CDataImpl.STRING);
		dImpl.setValue("pname",pname,CDataImpl.STRING);
		dImpl.setValue("punit",punit,CDataImpl.STRING);
		dImpl.setValue("pcard",pcard,CDataImpl.STRING);
		dImpl.setValue("pcardnum",pcardnum,CDataImpl.STRING);
		dImpl.setValue("paddress",paddress,CDataImpl.STRING);
		dImpl.setValue("pzipcode",pzipcode,CDataImpl.STRING);
		dImpl.setValue("ptele",ptele,CDataImpl.STRING);
		dImpl.setValue("pemail",pemail,CDataImpl.STRING);
		dImpl.setValue("ename",ename,CDataImpl.STRING);
		dImpl.setValue("ecode",ecode,CDataImpl.STRING);
		dImpl.setValue("ebunissinfo",ebunissinfo,CDataImpl.STRING);
		dImpl.setValue("edeputy",edeputy,CDataImpl.STRING);
		dImpl.setValue("elinkman",elinkman,CDataImpl.STRING);
		dImpl.setValue("etele",etele,CDataImpl.STRING);
		dImpl.setValue("eemail",eemail,CDataImpl.STRING);
		dImpl.setValue("commentinfo",commentinfo,CDataImpl.STRING);
		dImpl.setValue("indexnum",indexnum,CDataImpl.STRING);
		dImpl.setValue("purpose",purpose,CDataImpl.STRING);
		dImpl.setValue("ischarge",ischarge,CDataImpl.INT);
		dImpl.setValue("offermode",offermode,CDataImpl.STRING);
		dImpl.setValue("gainmode",gainmode,CDataImpl.STRING);
		//dImpl.setValue("othermode",othermode,CDataImpl.INT);
		dImpl.setValue("signmode",signmode,CDataImpl.INT);
		dImpl.setValue("did",dt_id,CDataImpl.INT);
		dImpl.setValue("dname",dname,CDataImpl.STRING);
		dImpl.setValue("flownum",flownum,CDataImpl.STRING);
		dImpl.setValue("status",status,CDataImpl.INT);
		dImpl.setValue("applytime",applytime,CDataImpl.DATE);
		if (!"".equals(dealmode)) {
		dImpl.setValue("dealmode",dealmode,CDataImpl.INT);
		}
		dImpl.setValue("feedback",feedback,CDataImpl.STRING);
		dImpl.setValue("isspot",isspot,CDataImpl.INT);
		dImpl.setValue("isrunit",isrunit,CDataImpl.INT);
		dImpl.setValue("applymode",applymode,CDataImpl.INT);
		if (!"".equals(limittime)) { 
		dImpl.setValue("limittime",limittime,CDataImpl.DATE);
		dImpl.setValue("olimittime",limittime,CDataImpl.DATE);
		}
		dImpl.setValue("memo",memo,CDataImpl.STRING);

		dImpl.update();
	}


	dImpl.setTableName("taskcenter");
	dImpl.setPrimaryFieldName("id");

		dImpl.addNew();
		dImpl.setValue("iid",id,CDataImpl.INT);
		dImpl.setValue("did",dt_id,CDataImpl.INT);
		dImpl.setValue("starttime",applytime,CDataImpl.DATE);
		dImpl.setValue("status","2",CDataImpl.INT);
		dImpl.setValue("isovertime","0",CDataImpl.INT);
		dImpl.setValue("genre","现场申请",CDataImpl.STRING);
		dImpl.setValue("endtime",applytime,CDataImpl.DATE);
		dImpl.update();


if (!(genre.equals("当场答复")||genre.equals("由申请人直接向信息公开责任单位提出申请"))) {
	dImpl.setTableName("taskcenter");
	dImpl.setPrimaryFieldName("id");

		dImpl.addNew();
		dImpl.setValue("iid",id,CDataImpl.INT);
		dImpl.setValue("did",did,CDataImpl.INT);
		dImpl.setValue("starttime",applytime,CDataImpl.DATE);
		dImpl.setValue("status",tc_status,CDataImpl.INT);
		dImpl.setValue("isovertime","0",CDataImpl.INT);
		dImpl.setValue("genre",genre,CDataImpl.STRING);
		if (!"".equals(endtime)) {
		dImpl.setValue("endtime",endtime,CDataImpl.DATE);
		}
		dImpl.setValue("commentinfo",ts_commentinfo,CDataImpl.STRING);
		dImpl.update();
}





	
	
	String errString = dCn.getLastErrString();
	//out.println(errString);
	if(errString.equals("")){
		//out.println("strange");
		dCn.commitTrans();
	}
	else{
		dCn.rollbackTrans();
	}
%>

<script language='javascript'>
//alert("信息已成功保存!");
if (<%=applyflag%> != "0") {
  if (confirm("<%=qword%>")) {
  	window.open("printApply.jsp?iid=<%=id%>&kind=<%=pKind%>&finishnow=<%=finishnow%>","","Top=0px,Left=0px,width=930,height=700,scrollbars=yes");
  }
}
window.location.href = "<%=gotuurl%>";
</script>
<%
}
catch(Exception e){
//e.printStackTrace();
out.print(e.toString());
}
finally{
dImpl.closeStmt();
dCn.closeCn(); 
}
%>