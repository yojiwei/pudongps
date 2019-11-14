<table class="printtable">
	<tr>
		<td class="printtitle">上海市浦东新区政府信息公开告知书</td>
	</tr>
	<tr>
		<td class="printlineone">沪浦信息公开（<%=finishyear%>）第<%=flownum%>号-公告</td>
	</tr>
	<tr>
		<td class="printlinethree"><%=proposer.equals("0")?pname:ename%>：</td>
	</tr>
	<tr>
		<td class="printlinetwo">本机关于 <%=CTools.replace(CTools.replace(CTools.replace(applytime,"#","年"),"$","月"),"%","日")%> 收到了您（单位）获得的申请，具体见《收件证明》沪浦信息公开（<%=applyyear%>）第<%=flownum%>号-收件。</td>
	</tr>
	<tr>
		<td class="printlinetwo">经查，您（单位）申请获取的政府信息属于可公开的政府信息范畴，根据《上海市政府信息公开规定》第十二条第（一）项的规定，本机关将通过以下形式提供该政府信息：<%=gmodeSTR%>，根据《上海市政府信息公开规定》第二十七条的规定，本机关将向您（单位）收取实际发生的检索/复制/邮寄/递送费用。请在收到本告知书后，到<%=payaddress%>办理缴费等具体手续。本机关将根据《上海市政府信息公开规定》第十八条第二款的规定，在您（单位）办妥手续后10个工作日内向您（单位）提供该政府信息。</td>
	</tr>

	<tr>
		<td class="printlinetwo">特此告知。</td>
	</tr>

	<!-- <tr>
		<td class="printlineone">（机关印章）</td>
	</tr> -->

	<tr>
		<td class="printlineone"><%=fdname%></td>
	</tr>

	<tr>
		<td class="printlineone"><%=CTools.replace(CTools.replace(CTools.replace(df.format(new java.util.Date()),"#","年"),"$","月"),"%","日")%></td>
	</tr>
</table>