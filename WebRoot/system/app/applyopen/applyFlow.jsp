<%@page contentType="text/html; charset=GBK"%>
<div style="position:relative;height:80px;">
	<div style="position:absolute; left:10px; top:10px; width:97%; height:60px; z-index:1; overflow-x: scroll; overflow-y: hidden;"> 
		<div class="divtwo"><div class="divinner">开始</div></div>
<%
sqlStr = "select t.id,t.genre,to_char(t.starttime,'yyyy-mm-dd hh:mi:ss') starttime,to_char(t.endtime,'yyyy-mm-dd hh:mi:ss') endtime,t.status,t.commentinfo,d.dt_name from taskcenter t,tb_deptinfo d where t.did = d.dt_id(+) and t.iid = " + iid + " order by t.starttime,t.id";
//out.println(status);
vPage = dImpl.splitPage(sqlStr,request,150);
String ddname = "";

if(vPage!=null){
	String divclass = "";
	for(int i=0; i<vPage.size(); i++){
		content = (Hashtable)vPage.get(i);
		
		switch(Integer.parseInt(content.get("status").toString())){
			case 0://待处理
				divclass = "divone";
				break;
			case 2://已处理
				divclass = "divtwo";
				break;
			case 3://已挂起
				divclass = "divfour";
				break;
			default:
				divclass = "divone";
				break;
		}

		ddname = content.get("dt_name").toString();
		if(ddname.equals("")){
			ddname = "认领中心";
		}else{
			if(ddname.length()>6) ddname = ddname.substring(0,5) + "..";
		}
%>
		<div class="divthree"><div class="divtext"><%=content.get("genre").toString()%></div><div class="divarrow"><font color=#0066FF size="4">g</font></div></div>
		<div class="<%=divclass%>" onclick="javascript:addElem('div2','taskDetail.jsp?tid=<%=content.get("id").toString()%>','450px','150px');"><div class="divinner"><%=ddname%></div></div>
			<!-- <div style="border:1px solid red;width:50px;float:left;clear:right;"><%//=content.get("endtime").toString()%></div> -->
<%
}
}
if(status.equals("2")){//如果已经板结，输出结束节点
%>
		<div class="divthree"><div class="divtext">结束</div><div class="divarrow"><font color=#0066FF size="4">g</font></div></div>
		<div class="divtwo"><div class="divinner">结束</div></div>
			<!-- <div style="border:1px solid red;width:50px;float:left;clear:right;"><%//=content.get("endtime").toString()%></div> -->
<%}%>
<div style="float:left;clear:right;width:86px;"><div style="float:left;clear:right;width:86px;"></div></div>
</div></div>