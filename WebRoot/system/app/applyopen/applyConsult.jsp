<%@page contentType="text/html; charset=GBK"%><table width="100%">
<%
sqlStr = "select id,did,dname,rname,to_char(starttime,'yyyy-mm-dd hh24:mi:ss') starttime,status from consult where iid = " + iid +  " order by starttime desc";
vPage = dImpl.splitPage(sqlStr,100,1);
if(vPage!=null){
	String cid = "";
	String cdname = "";
	String crname = "";
	String cstarttime = "";
	String cstatus = "";
	String cstatusSTR = "";
	String cfinishSTR = "";
	for(int i=0; i<vPage.size(); i++){
		content = (Hashtable)vPage.get(i);
		cid = content.get("id").toString();
		cdname = content.get("dname").toString();
		crname = content.get("rname").toString();
		cstarttime = content.get("starttime").toString();
		cstatus = content.get("status").toString();
		if(!cstatus.equals("")){
			switch(Integer.parseInt(cstatus)){
				case 0://待处理
					cstatusSTR = "待处理";
					break;
				case 2://已处理
					cstatusSTR = "已完成";
					cfinishSTR = "<font color=\"red\"><b>√</b><font>";
					break;
				default:
					cstatusSTR = "待处理";
					break;
			}
		}
%>
	<tr class="line-even">
		<td align="center" width="3%"><%=i+1%></td>
		<td align="center" width="3%"><%=cfinishSTR%></td>
		<td align="left" width="49%">向<%=crname%>发送第三方意见征询单</td>
		<td align="left" width="15%"><%=cdname%></td>
		<td align="center" width="15%"><%=cstarttime%></td>
		<td align="center" width="10%"><%=cstatusSTR%></td>
		<td align="center" width="5%"><a href="consultInfo.jsp?cid=<%=cid%>" target=""><img src="/system/images/modi.gif" border="0"></a></td>
	</tr>
<%}}else{%>
	<tr class="line-even"><td align="left">&nbsp;没有征询记录</td></tr>
<%}%>
</table>