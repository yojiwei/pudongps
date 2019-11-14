<%@page contentType="text/html; charset=GBK"%>
<%@ include file="/system/app/skin/import.jsp"%>
<%
//by ph 2007-3-3  信息公开一体化
String endtime = "";
String starttime = "";

String did = "";
String dname = "";
String commentinfo = "";
String status = "";
String statusSTR = "";
String genre = "";

String sqlStr = "";
String strTitle = "";

String tid = "";

CDataCn dCn = null;
CDataImpl dImpl = null;

Hashtable content = null;

try{
dCn = new CDataCn();
dImpl = new CDataImpl(dCn);
SimpleDateFormat df = new SimpleDateFormat("yyyy#MM$dd%");
tid = CTools.dealString(request.getParameter("tid")).trim();
//strTitle = "信息公开一体化 > 待处理任务";
sqlStr = "select t.id,t.did,to_char(t.starttime,'yyyy-mm-dd hh24:mi:ss') starttime,to_char(t.endtime,'yyyy-mm-dd hh24:mi:ss') endtime,t.commentinfo,t.status,t.genre,d.dt_name from taskcenter t,tb_deptinfo d where t.did = d.dt_id(+) and t.id = " + tid;
content = dImpl.getDataInfo(sqlStr);
if(content!=null){
	did = content.get("did").toString();
	dname = content.get("dt_name").toString();
	starttime = content.get("starttime").toString();
	endtime = content.get("endtime").toString();
	commentinfo = content.get("commentinfo").toString();
	status = content.get("status").toString();
	genre = content.get("genre").toString();
	
	if(!status.equals("")){
		switch(Integer.parseInt(status)){
			case 0:
			statusSTR = "待处理";	
			break;
			case 2:
			statusSTR = "已完成";	
			break;
			case 3:
			statusSTR = "征询中";	
			break;
		}
	}
%>
<table width="96%" align="center">
	<tr>
		<td width="100%">
			<table width="100%" class="content-table" height="1">
				<tr class="line-odd" >
					<td width="20%" align="center"><b>处理部门</b></td>
					<td width="30%" align="left"><%=dname%></td>
					<td width="20%" align="center"><b>任务开始日期</b></td>
					<td width="30%" align="left"><%=starttime%></td>
				</tr>
				<tr class="line-even" >
					<td align="center"><b>处理状态</b></td>
					<td align="left"><%=statusSTR%></td>
					<td align="center"><b>任务结束日期</b></td>
					<td align="left"><%=endtime.equals("")?"--":endtime%></td>
				</tr>
				<tr class="line-odd" >
					<td align="center"><b>备注</b></td>
					<td colspan="3" align="left"><%=commentinfo.equals("")?"--":commentinfo%></td>
				</tr>
			</table>
		</td>
	</tr>
</table>
<%
}else{
	out.println("获取数据错误！");
}
}catch(Exception e){
	out.print(e.toString());
}finally{
	dImpl.closeStmt();
	dCn.closeCn(); 
}
%>