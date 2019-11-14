<%@page contentType="text/html; charset=GBK"%>
<%@ include file="/website/include/import.jsp" %>
<link href="../images/Index/css.css" rel="stylesheet" type="text/css" />
<style type="text/css">
<!--
body {
	margin-left: 0px;
	margin-top: 0px;
	margin-right: 0px;
	margin-bottom: 15px;
}
body,td,th {
	font-size: 12px;
	color: #333333;
}
a:link {
	color: #333333;
	text-decoration: none;
}
a:visited {
	text-decoration: none;
	color: #333333;
}
a:hover {
	text-decoration: none;
	color: #FF0000;
}
a:active {
	text-decoration: none;
}
.STYLE2 {color: #FFFFFF;margin-right:4px}
-->
</style>
<script language="javascript">
function show(n)    
{       
     var o = document.getElementById('work').getElementsByTagName("a");    
     var c = document.getElementById('work_c').getElementsByTagName("div");    
     for(i = 0; l = o.length, i < l; o[i].className = '',c[i].style.display = 'none',i++ );    
     o[n].className = 'over';    
     c[n].style.display = 'block';       
}
function show1(n)    
{      
     var o = document.getElementById('online').getElementsByTagName("a");    
     var c = document.getElementById('online_c').getElementsByTagName("div");    
     for(i = 0; l = o.length, i < l; o[i].className = '',c[i].style.display = 'none',i++ ); 
     o[n].className = 'over';    
     c[n].style.display = 'block'; 
}
function show2(n)    
{       
     var o = document.getElementById('Feedback').getElementsByTagName("a");    
     var c = document.getElementById('Feedback_c').getElementsByTagName("div");    
     for(i = 0; l = o.length, i < l; o[i].className = '',c[i].style.display = 'none',i++ );    
     o[n].className = 'over';    
     c[n].style.display = 'block';       
}
//新增
function show2_1(n)
{       
     var o = document.getElementById('Feedback').getElementsByTagName("a");    
     var c = document.getElementById('Feedback_c').getElementsByTagName("div");    
     for(i = 0; l = o.length, i < l; o[i].className = 'a_1',c[i].style.display = 'none',i++ );    
     o[n].className = 'over';    
     c[n].style.display = 'block';   
     var ac = document.getElementById('more');
	 	 ac.style.display='';
}
function show2_2(n)
{       
     var o = document.getElementById('Feedback').getElementsByTagName("a");    
     var c = document.getElementById('Feedback_c').getElementsByTagName("div");    
     for(i = 0; l = o.length, i < l; o[i].className = '',c[i].style.display = 'none',i++ );    
     o[n].className = 'over_1';    
     c[n].style.display = 'block';   
     var ac = document.getElementById('more');
	   ac.style.display='none';  
}
//
function change(n)    
{       
     var o = document.getElementById('Main').getElementsByTagName("a");    
     var c = document.getElementById('Main_c').getElementsByTagName("div");    
     for(i = 0; l = o.length, i < l; o[i].className = '',c[i].style.display = 'none',i++ );    
     o[n].className = 'over';    
     c[n].style.display = 'block';       
}
function st(o,s){
	var v = document.createElement("input");
	v.type = "hidden";
	v.name = "cw_id";
	v.id = "cw_id";
	v.value = o;
	var f = document.createElement("form");
	f.name = "formData";
	f.action = "http://usercenter.pudong.gov.cn/website/workHall/workList.jsp?sj_dir="+s+"&pardir=workHall";
	f.method = "post";
	f.appendChild(v);
	document.body.appendChild(f);
	f.submit();
}

function getlist(o,t){
	try{
		var s,str;
		eval("document.formWSearch." + t + ".length = 0");
		eval("document.formWSearch." + t + ".options[0] = new Option('--','0');");
		switch(eval("document.formWSearch."+o+".value")){
			case "0":
				s = false;
				break;
			case "1":
				s = true;
				str = document.all.deptlist.value;
				break;
			case "2":
				s = true;
				str = document.all.sortlist.value;
				break;
			default:
				c = "1";
				break
		}
		if(s){
			var a = str.split(";");
			for(i = 0; i < a.length; i++){
				var b = a[i].split(",");
				eval("document.formWSearch." + t + ".options["+i+"] = new Option('"+b[1]+"','"+b[0]+"');");
			}
		}
	}catch(e){
		//nothing
	}
}
</script>
<body>
<%
//Update 20061231
//申明变量
CDataCn dCn = null;
CDataImpl dImpl = null;

String sj_dir = "";
String sqlStr = "";
String ct_content = "";
Vector vPage = null;
Hashtable content = null;

String pr_id = "";
String pr_name = "";
String dt_name = "";
String pr_isaccept = "";
String cw_id = "";
String sg_url = "";
String sg_name = "";
String title = "";
String sj_last_dir = "";
String tiurl ="";
String sv = "";

sj_dir=CTools.dealString(request.getParameter("sj_dir")).trim();
cw_id = CTools.dealString(request.getParameter("cw_id")).trim();//获取小类
try{
dCn = new CDataCn();
dImpl = new CDataImpl(dCn);  
%>
<table width="519" border="0" cellspacing="0" cellpadding="0">
<tr>
  <td class="z_bg_02a"><div align="right" class="STYLE2"><a href="http://usercenter.pudong.gov.cn/website/workHall/index.jsp"><font color="#FFFFFF">[进入专栏]</font></a></div></td>
</tr>
<tr>
  <td>
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
	<td valign="top">
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
	  <td height="6"></td>
	</tr>
	</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
	<td>
	<div class="work">
<div id="work">
<ul> 
<li style="margin-left:0px;"><a href="javascript://" onMouseOver="show(0)" class="over">市民办事</a></li>
<li><a href="javascript://" onMouseOver="show(1)">企业办事</a></li>
<li><a href="javascript://" onMouseOver="show(2)">特别关爱</a></li>
</ul>
</div>
<div id="work_c">
<div style="display:block;">
<table width="260">
<tr height="30">
<%
		sqlStr = "select cw_id,cw_name from tb_commonwork where uk_id = 'o1' order by cw_sequence";
		vPage = dImpl.splitPageOpt(sqlStr,9,1);
		if(vPage!=null){
			for(int i=0;i<vPage.size();i++)	{
				content = (Hashtable)vPage.get(i);
		%>
		<td><a href="<%=content.get("cw_id").toString()%>" onClick="javascript:st('<%=content.get("cw_id").toString()%>','perMore');return false;" class="three">[<%=content.get("cw_name").toString()%>]</a></td>
		<%
				if((i+1)%5==0) out.print("</tr><tr>");
			}
			out.print("<td><a href='http://usercenter.pudong.gov.cn/website/workHall/workList.jsp?sj_dir=perMore&pardir=workHall#listTitle'>[更多]</a></td>");
		}	
		%>
</tr></table>
</div>
<div> 
<table width="260">
<tr height="30">
	<%
		sqlStr = "select cw_id,cw_name from tb_commonwork where uk_id = 'o2' order by cw_sequence";
		vPage = dImpl.splitPageOpt(sqlStr,7,1);
		if(vPage!=null)
		{
			for(int i=0;i<vPage.size();i++)
			{
				content = (Hashtable)vPage.get(i);
   %>
		<td><a href="<%=content.get("cw_id").toString()%>" onClick="javascript:st('<%=content.get("cw_id").toString()%>','enMore');return false;" class="three">[<%=content.get("cw_name").toString()%>]</a></td>
		<%
				if((i+1)%4==0) out.print("</tr><tr>");
			}
			out.print("<td><a href='http://usercenter.pudong.gov.cn/website/workHall/workList.jsp?sj_dir=enMore&pardir=workHall#listTitle'>[更多]</a></td>");
		}
		%>
</tr></table>
</div>
<div> 
<table width="260">
<tr height="30">
	<%
		sqlStr = "select cw_id,cw_name from tb_commonwork where uk_id = 'o11' order by cw_sequence";
		vPage = dImpl.splitPageOpt(sqlStr,7,1);
		if(vPage!=null)
		{
			for(int i=0;i<vPage.size();i++)
			{
				content = (Hashtable)vPage.get(i);
				%>
			<td><a href="<%=content.get("cw_id").toString()%>" onClick="javascript:st('<%=content.get("cw_id").toString()%>','speMore');return false;" class="three">[<%=content.get("cw_name").toString()%>]</a></td>
		<%	
			if((i+1)%4==0) out.print("</tr><tr>");
			}
			out.print("<td><a href='http://usercenter.pudong.gov.cn/website/workHall/workList.jsp?sj_dir=speMore&pardir=workHall#listTitle'>[更多]</a></td>");
		}
		%>
</tr></table>
</div>
</div>	
</td>
</tr>
<tr>
<td>
<div class="online">
<div id="online">
<ul> 
<li><a href="javascript://" onMouseOver="show1(0)" class="over">在线受理</a></li>
<li><a href="javascript://" onMouseOver="show1(1)">表格下载</a></li>
<li><a href="http://usercenter.pudong.gov.cn/website/usercenter" onMouseOver="show1(2)">状态查询</a></li>
<!--li><div style="valign:center;margin-top:3px">&nbsp;&nbsp;&nbsp;<img src="../images/index/statusquery.gif" style="cursor:hand" onclick="window.location.href='http://usercenter.pudong.gov.cn/website/usercenter/index.jsp'"/></div></li-->
</ul>
</div>
<div id="online_c">
<!--在线受理-->
<div style="display:block">
<ul>
<%
sqlStr = "select * from (select sg_id,sg_name,sg_url from tb_suggest order by sg_sequence) where rownum<10";
vPage = dImpl.splitPageOpt(sqlStr,4,1);
if(vPage!=null)
{
for(int i=0;i<vPage.size();i++)
{
content = (Hashtable)vPage.get(i);
tiurl = content.get("sg_url").toString();
title = content.get("sg_name").toString();
if(title.indexOf("<font>")!=-1){
	title = title.length() > 18 ? title.substring(0,17) + ".." : title;
}
if(tiurl.indexOf("http://")==-1){
	tiurl = "http://usercenter.pudong.gov.cn"+tiurl;
}else{
	tiurl = tiurl;
}
%>
<li>·<a href="<%=tiurl%>" class="three"><%=title%></a></li>
<%
}
}
%>
</ul>
</div>
<!--在线受理-->
<!--表格下载-->
<iframe id=downFrm name=downFrm style="width:0px;height:0px;"></iframe>
<div>	
<ul>
<%
sqlStr = "select a.pa_name,a.pa_id from tb_proceedingattach_new a, tb_proceeding_new b where a.pr_id = b.pr_id and rownum<7 order by b.pr_edittime desc,b.pr_id desc ";
vPage = dImpl.splitPageOpt(sqlStr,4,1);
if (vPage!=null){
for( int i=0;i<vPage.size();i++){
content = (Hashtable)vPage.get(i);
title = content.get("pa_name").toString();
title = title.length() > 18 ? title.substring(0,17) + ".." : title;
%>
<li>·<A HREF="http://usercenter.pudong.gov.cn/website/workHall/Govdownload.jsp?pa_id=<%=content.get("pa_id").toString()%>" title="下载该表格" target="downFrm"><%=title%></a></li>
<%
}
}
%>
</ul>
</div>
<!--表格下载-->
<!--状态查询所用（为了不显示成白页）-->
<div>
<ul>
<%
sqlStr = "select a.pa_name,a.pa_id from tb_proceedingattach_new a, tb_proceeding_new b where a.pr_id = b.pr_id and rownum<7 order by b.pr_edittime desc,b.pr_id desc ";
vPage = dImpl.splitPageOpt(sqlStr,4,1);
if (vPage!=null){
for( int i=0;i<vPage.size();i++){
content = (Hashtable)vPage.get(i);
title = content.get("pa_name").toString();
title = title.length() > 18 ? title.substring(0,17) + ".." : title;
%>
<li>·<A HREF="http://usercenter.pudong.gov.cn/website/workHall/Govdownload.jsp?pa_id=<%=content.get("pa_id").toString()%>" title="下载该表格" target="downFrm"><%=title%></a></li>
<%
}
}
%>
</ul>	
</div>
<!--状态查询所用-->
</div>
</div>
</td>
</tr>
</table>
	</td>
	<td class="z_bg_05">&nbsp;</td>
	<td valign="top">
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
	<td height="6"></td>
	</tr>
	</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
<tr>
<td>
<form name="formWSearch" action="http://usercenter.pudong.gov.cn/website/workHall/SList.jsp" target="_blank" method="post">
	<table width="100%" height="90" border="0" cellpadding="0" cellspacing="0">
	  <tr>
		<td height="29" class="z_bg_06"><strong>办事检索</strong></td>
	  </tr>
	  <tr>
		<td><div align="center">
		  <select name="sType" style="width:111px;" onChange="javascript:getlist('sType','sValue');">
			<option value="0">请选择搜索方式</option>
			<option value="1">按办事机构</option>
			<option value="2">按分类办事</option>
		  </select>
		  <select name="sValue" style="width:111px;">
		  <option value="0">--</option>
		  </select>
<%
sqlStr="select d.dt_name as name,d.dt_id as id from tb_deptinfo d where d.dt_iswork=1 and (dt_parent_id = 1129 or d.dt_id = 35) or d.dt_parent_id in (select dt_id from tb_deptinfo where dt_name like '%功能区域%'  or dt_id = 20050 or dt_id = 20051) order by d.dt_sequence";
vPage = dImpl.splitPageOpt(sqlStr,200,1);
if(vPage!=null){
	for(int i=0;i<vPage.size();i++)	{
		content = (Hashtable)vPage.get(i);
		sv += content.get("id").toString() + "," + content.get("name").toString();
		if((i+1)!=vPage.size()) sv += ";";
	}
}
%>
<input type="hidden" name="deptlist" value="<%=sv%>">
<%
sv = "";
sqlStr = "select sw_name as name,sw_id as id from tb_sortwork order by sw_sequence";
vPage = dImpl.splitPageOpt(sqlStr,200,1);
if(vPage!=null){
	for(int i=0;i<vPage.size();i++)	{
		content = (Hashtable)vPage.get(i);
		sv += content.get("id").toString() + "," + content.get("name").toString();
		if((i+1)!=vPage.size()) sv += ";";
	}
}
%>
  <input type="hidden" name="sortlist" value="<%=sv%>">
</div></td>
</tr>
<tr>
<td height="22"><table width="224" height="22" border="0" align="center" cellpadding="0" cellspacing="0" class="s_021">
  <tr>
	<td><input name="kWord" type="text" class="s_02"  value="请输入关键字" onFocus="javascript:this.select();"/></td><input type="hidden" name="sj_dir" value="workHall">
	<td><img src="../images/Index/so1.gif" width="52" height="21" onClick="javascript:document.formWSearch.submit();"  style="cursor:hand"/></td>
  </tr>
</table>
  <table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
	  <td height="5"></td>
	</tr>
  </table></td>
</tr>
</table>
</form>
	</td>
	</tr>
	<tr>
	<td>
<div class="Feedback">
<div id="Feedback">
    <ul> 
      <li><a href="javascript://" onMouseOver="show2_1(0)" class="over">办事反馈</a></li>
      <li><a href="javascript://" onMouseOver="show2_2(1)" class="a_1">外资项目审批</a></li>
      <li style="padding-top:8px" id=more><span style="cursor:hand;" onClick="javascript:window.location.href='http://usercenter.pudong.gov.cn/website/workHall/feedbackMore.jsp';">更多&gt;&gt;</span></li>
    </ul>
</div>
<div id="Feedback_c">
<!--办事反馈-->
  <div style="display:block">
   	<ul>
	<%
		sqlStr = "select ma_sendername,ma_sendtime,ma_title from tb_message where ma_senderid=32 order by ma_sendtime desc ";
		vPage = dImpl.splitPageOpt(sqlStr,4,1);
		if(vPage!=null)
		{
			for(int i=0;i<vPage.size();i++)
			{
				content = (Hashtable)vPage.get(i);
				title = content.get("ma_title").toString();
				title = title.length() > 18 ? title.substring(0,17) + ".." : title;
	%>
		<li>·<a href="http://usercenter.pudong.gov.cn/website/usercenter/index.jsp" class="three"><%=title%></a></li>
		<%
			}
		}
		%>
    </ul>
  </div>
<!--办事反馈-->
<!--外资项目审批-->
  <div>
   	<ul>
	<%
		sqlStr = "select * from tb_wzwolinework where rownum <= 12 order by wz_id desc";
		vPage = dImpl.splitPageOpt(sqlStr,4,1);
		if(vPage!=null)
		{
			for(int i=0;i<vPage.size();i++)
			{
				content = (Hashtable)vPage.get(i);
				title = content.get("wz_subjecttname").toString();
				title = title.length() > 18 ? title.substring(0,17) + ".." : title;
	%>
		<li>·<a href="http://usercenter.pudong.gov.cn/website/workHall/contentwzw.jsp?wz_id=<%=content.get("wz_id").toString()%>" class="three"><%=title%></a></li>
		<%
			}
		}
		%>
    </ul>
  </div>
<!--外资项目审批-->
</div>
</div>
	</td>
	</tr>
	</table>
  </td>
  </tr>
</table>
<!--适应首页所做修改-->
  </td>
  </tr>
</table>
  </td>
  </tr>
</table>
<!--适应首页所做修改-->
<!--场景服务--->
<table width="519" border="0" cellpadding="0" cellspacing="0">
<tr>
  <td class="z_bg_03"><table width="100%" border="0" cellpadding="0" cellspacing="0">
	<tr>
	  <td><img src="../images/Index/fw_01.gif" width="93" height="39" /><a href="http://www.pudong.gov.cn/website/SceneService/fertility/index.htm" target="_blank"><img src="../images/Index/fw_06.gif" width="101" height="39" border="0" /></a><img src="../images/Index/fw_03.gif" width="3" height="39" /><a href="http://www.pudong.gov.cn/website/SceneService/census/index.htm" target="_blank"><img src="../images/Index/fw_05.gif" width="101" height="39" border="0" /></a><img src="../images/index/fw_03.gif" width="3" height="39" /><a href="http://www.pudong.gov.cn/website/dynamictemplate/building.htm"><img src="../images/Index/fw_04.gif" width="101" height="39" border="0" /></a><img src="../images/Index/fw_03.gif" width="3" height="39" /><a href="http://www.pudong.gov.cn/WebSite/SceneService/Marry/index.htm" target="_blank"><img src="../images/Index/fw_02.gif" width="101" height="39" border="0" /></a></td>
	</tr>
  </table>
 <!-- //适应首页所做修改
  </td>
  </tr>
</table>
-->
<!--场景服务--->
<%}
catch(Exception e){
	out.print(e.toString());
}
finally{
	dImpl.closeStmt();
	dCn.closeCn(); 
}
%>
