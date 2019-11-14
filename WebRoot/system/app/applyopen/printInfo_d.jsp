<table class="printtable">
	<tr>
		<td class="printtitle">上海市浦东新区政府信息不存在告知书</td>
	</tr>
	<tr>
		<td class="printlineone">沪浦信息公开（<%=finishyear%>）第<%=flownum%>号-不存告</td>
	</tr>
	<tr>
		<td class="printlinethree"><%=proposer.equals("0")?pname:ename%>：</td>
	</tr>
	<tr>
		<td class="printlinetwo">本机关于 <%=CTools.replace(CTools.replace(CTools.replace(applytime,"#","年"),"$","月"),"%","日")%> 收到了您（单位）获得的申请，具体见《收件证明》沪浦信息公开（<%=applyyear%>）第<%=flownum%>号-收件。</td>
	</tr>

	<tr>
		<td class="printlinetwo">经查，您（单位）申请获取的政府信息不存在。本机关根据《上海市政府信息公开规定》第十二条第（四）项的规定，特此告知。</td>
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