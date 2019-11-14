<%@page contentType="text/html; charset=GBK"%>
<%
String infotitle = ""; //申请信息标题
String infoid = ""; //申请信息id
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
String ischarge = ""; //是否减免费用
String chargeAbout = ""; //是否减免费用
String offermodeC[] = new String[4]; //所需信息提供方式
String offermode = ""; //所需信息提供方式
String gainmodeC[] = new String[5]; //获取信息方式
String gainmode = ""; //获取信息方式
String othermode = ""; //是否接受其他信息提供方式 0不接受、1接受
String dealmode = "";//处理方式：0予以公开、1部分公开、2不于公开、3信息不存在
String dealmodeSTR = "";
String flownum = "";//受理流水号
String feedback = ""; //反馈意见
String status = ""; //状态：0待处理、1处理中、2已结束、3挂起
String statusSTR = "";
String finishtime = ""; //结束时间
String ispublish = ""; //是否公开：0公开、1不公开
String limittime = ""; //办理期限
String us_id = ""; //注册用户ID

sqlStr = "select infotitle,infoid,proposer,pname,punit,pcard,pcardnum,paddress,pzipcode,ptele,pemail,ename,ecode,ebunissinfo,edeputy,elinkman,etele,eemail,commentinfo,indexnum,purpose,ischarge,offermode,gainmode,othermode,feedback,dealmode,status,finishtime,ispublish,to_char(applytime,'yyyy#mm$dd%') applytime,flownum,to_char(limittime,'yyyy#mm$dd%') limittime,us_id from infoopen where id = " + iid;
//out.println(sqlStr);
//if(true)return;
content = dImpl.getDataInfo(sqlStr);
if(content!=null){
	infotitle = content.get("infotitle").toString();
	infotitle = infotitle.replaceAll("&","&amp;");
	infotitle = infotitle.replaceAll("<","&lt;");
	infotitle = infotitle.replaceAll(">","&gt;");
	infotitle = infotitle.replaceAll("\"","&quot;");


	infoid = content.get("infoid").toString();
	proposer = content.get("proposer").toString();

	pname = content.get("pname").toString();
	pname = pname.replaceAll("&","&amp;");
	pname = pname.replaceAll("<","&lt;");
	pname = pname.replaceAll(">","&gt;");
	pname = pname.replaceAll("\"","&quot;");

	punit = content.get("punit").toString();
	punit = punit.replaceAll("&","&amp;");
	punit = punit.replaceAll("<","&lt;");
	punit = punit.replaceAll(">","&gt;");
	punit = punit.replaceAll("\"","&quot;");

	pcard = content.get("pcard").toString();
	pcard = pcard.replaceAll("&","&amp;");
	pcard = pcard.replaceAll("<","&lt;");
	pcard = pcard.replaceAll(">","&gt;");
	pcard = pcard.replaceAll("\"","&quot;");

	pcardnum = content.get("pcardnum").toString();

	paddress = content.get("paddress").toString();
	paddress = paddress.replaceAll("&","&amp;");
	paddress = paddress.replaceAll("<","&lt;");
	paddress = paddress.replaceAll(">","&gt;");
	paddress = paddress.replaceAll("\"","&quot;");

	pzipcode = content.get("pzipcode").toString();
	ptele = content.get("ptele").toString();
	//ptele1 = content.get("proposer").toString();
	//ptele2 = content.get("proposer").toString();
	pemail = content.get("pemail").toString();
	pemail = pemail.replaceAll("&","&amp;");
	pemail = pemail.replaceAll("<","&lt;");
	pemail = pemail.replaceAll(">","&gt;");
	pemail = pemail.replaceAll("\"","&quot;");

	ename = content.get("ename").toString();
	ename = ename.replaceAll("&","&amp;");
	ename = ename.replaceAll("<","&lt;");
	ename = ename.replaceAll(">","&gt;");
	ename = ename.replaceAll("\"","&quot;");

	ecode = content.get("ecode").toString();
	ecode = ecode.replaceAll("&","&amp;");
	ecode = ecode.replaceAll("<","&lt;");
	ecode = ecode.replaceAll(">","&gt;");
	ecode = ecode.replaceAll("\"","&quot;");

	ebunissinfo = content.get("ebunissinfo").toString();
	ebunissinfo = ebunissinfo.replaceAll("&","&amp;");
	ebunissinfo = ebunissinfo.replaceAll("<","&lt;");
	ebunissinfo = ebunissinfo.replaceAll(">","&gt;");
	ebunissinfo = ebunissinfo.replaceAll("\"","&quot;");

	edeputy = content.get("edeputy").toString();
	edeputy = edeputy.replaceAll("&","&amp;");
	edeputy = edeputy.replaceAll("<","&lt;");
	edeputy = edeputy.replaceAll(">","&gt;");
	edeputy = edeputy.replaceAll("\"","&quot;");

	elinkman = content.get("elinkman").toString();
	elinkman = elinkman.replaceAll("&","&amp;");
	elinkman = elinkman.replaceAll("<","&lt;");
	elinkman = elinkman.replaceAll(">","&gt;");
	elinkman = elinkman.replaceAll("\"","&quot;");

	etele = content.get("etele").toString();
	//etele1 = content.get("proposer").toString();
	//etele2 = content.get("proposer").toString();
	eemail = content.get("eemail").toString();
	eemail = eemail.replaceAll("&","&amp;");
	eemail = eemail.replaceAll("<","&lt;");
	eemail = eemail.replaceAll(">","&gt;");
	eemail = eemail.replaceAll("\"","&quot;");

	applytime = CTools.replace(CTools.replace(CTools.replace(content.get("applytime").toString(),"#","年"),"$","月"),"%","日");
	commentinfo = content.get("commentinfo").toString();
	commentinfo = commentinfo.replaceAll("&","&amp;");
	commentinfo = commentinfo.replaceAll("<","&lt;");
	commentinfo = commentinfo.replaceAll(">","&gt;");
	commentinfo = commentinfo.replaceAll("\"","&quot;");

	indexnum = content.get("indexnum").toString();
	purpose = content.get("purpose").toString();
	purpose = purpose.replaceAll("&","&amp;");
	purpose = purpose.replaceAll("<","&lt;");
	purpose = purpose.replaceAll(">","&gt;");
	purpose = purpose.replaceAll("\"","&quot;");

	ischarge = content.get("ischarge").toString();
	//chargeAbout = content.get("chargeAbout").toString();
	offermode = content.get("offermode").toString();
	gainmode = content.get("gainmode").toString();
	othermode = content.get("othermode").toString();
	feedback = content.get("feedback").toString();
	dealmode = content.get("dealmode").toString();
	flownum = content.get("flownum").toString();
	status = content.get("status").toString();
	finishtime = content.get("finishtime").toString();
	ispublish = content.get("ispublish").toString();
	limittime = CTools.replace(CTools.replace(CTools.replace(content.get("limittime").toString(),"#","年"),"$","月"),"%","日");
	us_id = content.get("us_id").toString();
	if(!status.equals("")){
		switch(Integer.parseInt(status)){
			case 0:
			statusSTR = "认领中心";	
			break;
			case 1:
			statusSTR = "处理中";	
			break;
			case 2:
			statusSTR = "已完成";	
			break;
			case 3:
			statusSTR = "征询中";	
			break;
		}
	}
	if(!dealmode.equals("")){
		switch(Integer.parseInt(dealmode)){
			case 0:
			dealmodeSTR = "予以公开";	
			break;
			case 1:
			dealmodeSTR = "部分公开";	
			break;
			case 2:
			dealmodeSTR = "不于公开";	
			break;
			case 3:
			dealmodeSTR = "信息不存在";	
			break;
			case 6:
			dealmodeSTR = "不于公开";	
			break;
			case 7:
			dealmodeSTR = "不于公开";	
			break;
			case 10:
			dealmodeSTR = "补正材料";	
			break;
		}
	}
%>
<table width="98%" align="cenner">
	<tr>
		<td align="left" width="25%">流水号：<%=flownum%></td>
		<td align="left" width="25%">办理期限：<%=limittime%></td>
		<td align="left" width="25%">办理状态：<%=statusSTR%></td>
		<td align="left" width="25%"></td>
	</tr>
</table>
<table width="98%" align="center" bgcolor="#000000" cellspacing="1" cellpadding="3">
<%
	if(proposer.equals("0")){
%>
	<tr class="line-even">
		<td width="5%" rowspan="5" align="center">公民</td>
		<td width="15%" align="center">申请人姓名</td>
		<td width="33%" align="left"><%=pname%></td>
		<td width="15%" align="center">工作单位</td>
		<td width="32%" colspan="2" align="left"><%=punit%></td>
	</tr>

	<tr class="line-even">
		<td align="center">证件名称</td>
		<td align="left"><%=pcard%></td>
		<td align="center">证件号码</td>
		<td colspan="2" align="left"><%=pcardnum%></td>
	</tr>

	<tr class="line-even" >
		<td align="center">通信地址</td>
		<td align="left"><%=paddress%></td>
		<td align="center">邮政编码</td>
		<td align="left"><%=pzipcode%></td>
	</tr>

	<tr class="line-even" style="display:">
		<td align="center">联系电话</td>
		<td colspan="4" align="left"><%=ptele%></td>
	</tr>

	<tr class="line-even" style="display:">
		<td align="center">邮件地址</td>
		<td colspan="4" align="left"><%=pemail%></td>
	</tr>
<%
	}else if(proposer.equals("1")){		
%>
	<tr class="line-even">
		<td width="5%" rowspan="5" align="center">法人<br />/<br />其他组织</td>
		<td width="15%" align="center">企业名称</td>
		<td width="33%" align="left"><%=ename%></td>
		<td width="15%" align="center">组织机构代码</td>
		<td width="32%" colspan="2" align="left"><%=ecode%></td>
	</tr>

	<tr class="line-even">
		<td align="center">营业执照信息</td>
		<td colspan="4" align="left"><%=ebunissinfo%></td>
	</tr>

	<tr class="line-even">
		<td align="center">法人代表</td>
		<td align="left"><%=edeputy%></td>
		<td align="center">联系人姓名</td>
		<td colspan="2" align="left"><%=elinkman%></td>
	</tr>

	<tr class="line-even">
		<td align="center">联系人电话</td>
		<td colspan="4" align="left"><%=etele%></td>
	</tr>

	<tr class="line-even">
		<td align="center">联系人邮箱</td>
		<td colspan="4" align="left"><%=eemail%></td>
	</tr>
<%
	}		
%>
	<tr class="line-even">
		<td colspan="2" align="center">申请时间</td>
		<td colspan="4" align="left"><%=applytime%></td>
	</tr>


	<tr class="line-even">
		<td colspan="2" align="center">信息名称</td>
		<td colspan="4" align="left"><%=infotitle%></td>
	</tr>

	<tr class="line-even">
		<td colspan="2" align="center">所需信息内容描述</td>
		<td colspan="4" align="left"><%=commentinfo%></td>
	</tr>

	<tr class="line-even">
		<td colspan="2" align="center">所需信息的索取号</td>
		<td colspan="4" align="left"><%=indexnum%></td>
	</tr>

	<tr class="line-even">
		<td colspan="2" align="center">所需信息的用途</td>
		<td colspan="4" align="left"><%=purpose%></td>
	</tr>

	<tr class="line-even">
		<td colspan="2" align="center">是否申请减免费用</td>
		<td align="left" colspan="4"><%=ischarge.equals("0")?"否":"是"%></td>
		<!-- <td align="left">申请减免费用请提供相关证明</td>
		<td align="left" colspan="2"><input name="chargeAbout" type="text" size="24" /></td> -->
	</tr>

	<tr class="line-even">
		<td colspan="2" align="center">所需信息指定提供方式</td>
		<td colspan="4" align="left"><%
		String[] b = offermode.split(",");
		String[] a = {"纸面","电子邮件","磁盘"};
		for(int i=0; i<b.length; i++){
			//out.println(a[i]);
			if(b[i]!=""){
				if(Integer.parseInt(b[i])<3) out.println(a[Integer.parseInt(b[i])] + ",");
			}
		}
		%></td>
	</tr>

	<tr class="line-even">
		<td colspan="2" align="center">获取信息的方式</td>
		<input type="hidden" name="gainmode" value="">
		<td colspan="4" align="left"><%
		String[] c = gainmode.split(",");
		String[] d = {"邮寄","快递","电子邮件","传真","自行领取/当场阅读抄录"};
		for(int i=0; i<c.length; i++){
			//out.println(a[i]);
			if(c[i]!=""){
				if(Integer.parseInt(c[i])<5) out.println(d[Integer.parseInt(c[i])] + ",");
			}
		}
		%></td>
	</tr>
	<%if(othermode.equals("1")){%>
	<tr class="line-even">
		<td colspan="6" align="center">若本机关无法按照指定方式提供所需信息，也可接受其他方式</td>
	</tr>
	<%}%>
	<tr class="line-even">
		<td colspan="2" align="center">是否注册用户</td>
		<td colspan="4" align="left"><%if (!"".equals(us_id)) out.println("是"); else out.println("否");%></td>
	</tr>
	<!--update by yao 20090330--->
	<iframe id=downFrm name=downFrm  style="width:0px;height:0px;"></iframe>
	<tr class="line-even">
		<td colspan="2" align="center">是否有上传附件</td>
		<td colspan="4" align="left">
		<%
		sqlStr = "select at_id,at_filename from tb_applyopenattach where ap_id="+iid+"";
		vPage = dImpl.splitPage(sqlStr,20,1);
		if (vPage!=null){
			for( int i=0;i<vPage.size();i++){
				content = (Hashtable)vPage.get(i);
		%>
			<A HREF="applydown.jsp?at_id=<%=content.get("at_id").toString()%>" target="_blank" title="下载该文件"><%=CTools.dealNull(content.get("at_filename"))%></a>
		<%
		}}else{out.print("没有附件");}
		%></td>
	</tr>
</table><br>
<%
}else{
	out.println("读取申请表错误！");
}
%>