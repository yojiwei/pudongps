<%@page contentType="text/html; charset=GBK"%>
<%@include file="/system/app/skin/import.jsp"%>
<link href="/system/app/applyopen/print.css" rel="stylesheet" type="text/css">
<script language="javascript" src="applyopen.js"></script>
<%
//by ph 2007-3-3  信息公开一体化
String pname = "";
String ename = "";
String infoid = "";
String infotitle = "";
String applytime = "";
String signmode = ""; //0网上申请、1现场申请、2E-mail申请
String signname = "";

String flownum = "";
String proposer = "";
String offermode = "";
String offermodeSTR = "";
String dname = "";

String aanswertime = "";

String sqlStr = "";
//String strTitle = "";

String iid = "";
String kind = ""; //打印单据标记
String finishnow = ""; //是否现场处理，0作书面答复、1现场予以答复

CDataCn dCn = null;
CDataImpl dImpl = null;

Hashtable content = null;

try{
dCn = new CDataCn();
dImpl = new CDataImpl(dCn);
SimpleDateFormat df = new SimpleDateFormat("yyyy#MM$dd%");

Calendar cal = Calendar.getInstance();
cal.add(Calendar.DAY_OF_MONTH,2);



iid = CTools.dealString(request.getParameter("iid")).trim();
kind = CTools.dealString(request.getParameter("kind")).trim();



if ("".equals("kind")) {
  kind = "0";
}
finishnow=CTools.dealString(request.getParameter("finishnow")).trim();
//strTitle = "信息公开一体化 > 打印回执单";
sqlStr = "select id,infotitle,flownum,proposer,pname,ename,to_char(applytime,'yyyy#mm$dd%') applytime,offermode,dname,signmode from infoopen where id = " + iid;
content = dImpl.getDataInfo(sqlStr);
if(content!=null){
	infotitle = content.get("infotitle").toString();
	flownum = content.get("flownum").toString();
	proposer = content.get("proposer").toString();
	pname = content.get("pname").toString();
	ename = content.get("ename").toString();
	signmode = content.get("signmode").toString();
	if (signmode.equals("0")) {
	  signname = "网上";
	}
	if (signmode.equals("1")) {
	  signname = "当面";
	}
	else if (signmode.equals("2")) {
	  signname = "电子邮件";
	}
	else if (signmode.equals("3")) {
	  signname = "信函";
	}
	else if (signmode.equals("4")) {
	  signname = "电报";
	}
	else if (signmode.equals("5")) {
	  signname = "传真";
	}
	else {
	  signname = "其它";
	}
	applytime = CTools.replace(CTools.replace(CTools.replace(content.get("applytime").toString(),"#","年"),"$","月"),"%","日");

	offermode = content.get("offermode").toString();
	dname = content.get("dname").toString();

	String[] b = offermode.split(",");
	String[] a = {"纸面","电子邮件","磁盘"};
	for(int i=0; i<b.length; i++){
		//out.println(a[i]);
		if(b[i]!=""){
			if(Integer.parseInt(b[i])<3) offermodeSTR += a[Integer.parseInt(b[i])] + "、";
		}
	}
	if (!"".equals(offermodeSTR)) {
	  offermodeSTR = offermodeSTR.substring(0,offermodeSTR.length()-1);
	}
}
sqlStr = "select to_char(olimittime,'yyyy#mm$dd%') aanswertime from infoopen where id = " + iid;
content = dImpl.getDataInfo(sqlStr);
if(content!=null){
  aanswertime = CTools.replace(CTools.replace(CTools.replace(content.get("aanswertime").toString(),"#","年"),"$","月"),"%","日");
}
%>
<table width="94%" cellpadding="4">
	<tr>
		<td height="30"></td>
	</tr>
	<%if (kind.equals("0")) {%>
	<tr>
		<td class="printtitle">上海市浦东新区政府信息公开申请代办证明</td>
	</tr>
	<tr>
		<td class="printlineone">浦信息公开（2007）第<%=flownum%>号——代办</td>
	</tr>
	<tr>
		<td class="printlinethree"><%=proposer.equals("0")?pname:ename%>：</td>
	</tr>
	<tr>
		<td class="printlinetwo">本机关于 <%=applytime%> 收到了您（单位）通过“<%=signname%>”方式提出的政府信息公开申请，申请获得“<%=infotitle%>”信息，该信息不属于本单位的掌握范围。<br>　　因您（单位）的委托，本单位将代办该信息公开申请，并于<%=CTools.replace(CTools.replace(CTools.replace(df.format(cal.getTime()),"#","年"),"$","月"),"%","日")%>前将您（单位）的申请移送相关信息公开责任单位。<br>　　本证明是接收申请材料的凭证，信息公开申请由该信息公开责任单位负责处理。<br>　　特此告知。<br><br><br></td>
	</tr>
  <%} else {%>
	<tr>
		<td class="printtitle">上海市浦东新区政府信息公开申请收件证明</td>
	</tr>
	<tr>
		<td class="printlineone">浦信息公开（2007）第<%=flownum%>号——收件</td>
	</tr>
	<tr>
		<td class="printlinethree"><%=proposer.equals("0")?pname:ename%>：</td>
	</tr>
	<tr>
		<td class="printlinetwo">本机关于 <%=applytime%> 收到了您（单位）通过“<%=signname%>”方式提出的政府信息公开申请，申请获得“<%=infotitle%>”信息。<br>　　特此告知。</td>
		<!--td class="printlinetwo">　　本机关于 <%=applytime%> 收到了您（单位）通过“<%=signname%>”提出的政府信息公开申请，申请获得“<%=infotitle%>”信息。<br>　　经审查，您（单位）的申请行为符合《上海市政府信息公开规定》第十一条的规定，本单位予以受理。<br>　　根据《上海市政府信息公开规定》第十八条，对你（单位）的申请，将：<%if (finishnow.equals("1")) out.println("当场予以答复"); else out.println("于"+ aanswertime +"前作出书面答复");%>。<br>　　特此告知。</td-->
	</tr>
  <%}%>
	<tr>
		<td class="printlineone"><%=dname%></td>
	</tr>

	<tr>
		<td class="printlineone"><%=CTools.replace(CTools.replace(CTools.replace(df.format(new java.util.Date()),"#","年"),"$","月"),"%","日")%></td>
	</tr>
	
	<tr id="pb">
		<td align="center"><input type="button" class="bttn" name="" value=" 打 印 " onclick="javascript:printIt('pb');">&nbsp;<input type="button" class="bttn" name="" value=" 关闭窗口 " onclick="javascript:window.close();"></td>
	</tr>
	<tr>
		<td height="30"></td>
	</tr>
</table>
<%
}catch(Exception e){
	out.print(e.toString());
}finally{
	dImpl.closeStmt();
	dCn.closeCn(); 
}
%>
<%@include file="/system/app/skin/bottom.jsp"%>