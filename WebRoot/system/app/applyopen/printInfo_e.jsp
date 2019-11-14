<table class="printtable">
	<tr>
		<td class="printtitle">上海市浦东新区非政府信息公开申请告知书</td>
	</tr>
	<tr>
		<td class="printlineone">沪浦信息公开（<%=finishyear%>）第<%=flownum%>号-非申告</td>
	</tr>
	<tr>
		<td class="printlinethree"><%=proposer.equals("0")?pname:ename%>：</td>
	</tr>
	<tr>
		<td class="printlinetwo">您（单位）于<%=CTools.replace(CTools.replace(CTools.replace(applytime,"#","年"),"$","月"),"%","日")%> 提交的有关<%=infotitle%>的材料已经收到，见《收件证明》沪浦信息公开（<%=applyyear%>）第<%=flownum%>号-收件。</td>
	</tr>

	<tr>
		<td class="printlinetwo">经查，您（单位）提交的材料不符合《上海市政府信息公开规定》第十一条规定的政府信息公开的申请要求，本机关不再按照《上海市政府信息公开规定》做出答复。</td>
	</tr>

	<tr>
		<td class="printlineone">特此告知。</td>
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