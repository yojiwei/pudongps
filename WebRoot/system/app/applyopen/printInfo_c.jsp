<table class="printtable">
	<tr>
		<td class="printtitle">上海市浦东新区政府信息不予公开告知书</td>
	</tr>
	<tr>
		<td class="printlineone">沪浦信息公开（<%=finishyear%>）第<%=flownum%>号-不告</td>
	</tr>
	<tr>
		<td class="printlinethree"><%=proposer.equals("0")?pname:ename%>：</td>
	</tr>
	<tr>
		<td class="printlinetwo">本机关于 <%=CTools.replace(CTools.replace(CTools.replace(applytime,"#","年"),"$","月"),"%","日")%> 收到了您（单位）获得的申请，具体见《收件证明》沪浦信息公开（<%=applyyear%>）第<%=flownum%>号-收件。</td>
	</tr>

	<tr>
		<td class="printlinetwo">另查，您（单位）申请获取的政府信息中，有关<%=whatinfo%>的政府信息：</td>
	</tr>
	<%
	if(!rreason.equals("")){
		String[] c = rreason.split("#");
		for(int i=0; i<c.length; i++){
			if(!c[i].equals("")){
	%>
	<tr>
		<td class="printlinetwo"><%=c[i]%>。</td>
	</tr>
	<%
			}
		}
	}
	if(!oreason.equals("")){
	%>
	<tr>
		<td class="printlinetwo">有法律、法规规定免予公开的其他情形，具体为<%=oreason%>。</td>
	</tr>
	<%}%>

	<tr>
		<td class="printlinetwo">根据《上海市政府信息公开规定》第十条第一款第<%=rentry%>项和第十二条第（二）项的规定，本机关对该部分信息不予公开。</td>
	</tr>

	<tr>
		<td class="printlinetwo">如对本决定不服，可以在收到本决定之日起60日内申请行政复议或者在3个月内向人民法院提起行政诉讼。</td>
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