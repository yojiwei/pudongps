<%@page contentType="text/html; charset=GBK"%>
<%@ include file="/website/include/import.jsp" %>
<%
	//Update 20061231
	String strDo = request.getParameter("startButton") != null ? request.getParameter("startButton") : "";
	if ("between".equals(strDo)) {
		System.out.println("******************between*******************");
		System.out.println("-------------start by hh-------------");
		System.out.println("*************************************");
		String start = request.getParameter("startDate") != null ? request.getParameter("startDate") : "";
		String end = request.getParameter("endDate") != null ? request.getParameter("endDate") : "";
		String rootDate = request.getParameter("rootDate") != null ? request.getParameter("rootDate") : "";
		String execDate = request.getParameter("rootDate") != null ? request.getParameter("execDate") : "";
		SessionXml01.VectorXML(execDate,start,end,rootDate);
		System.out.println("*************************************");
		System.out.println("=============end for hh==============");
		System.out.println("*****************between********************");
		out.println("<center>between操作已成功！</center>");
	}
	else if ("old".equals(strDo)) {
		String start = request.getParameter("startDate") != null ? request.getParameter("startDate") : "";
		String end = request.getParameter("endDate") != null ? request.getParameter("endDate") : "";
		String rootDate = request.getParameter("rootDate") != null ? request.getParameter("rootDate") : "";
		String execDate = request.getParameter("rootDate") != null ? request.getParameter("execDate") : "";
		out.println("start : " + start);
		out.println("end : " + end);
		out.println("rootDate : " + rootDate);
		out.println("execDate : " + execDate);
		
		System.out.println("*****************old********************");
		System.out.println("-------------start by hh-------------");
		System.out.println("*************************************");
		SessionXmlwsbs.VectorXML(execDate,start,end,rootDate,"");
		System.out.println("*************************************");
		System.out.println("=============end for hh==============");
		System.out.println("******************old*******************");
		out.println("<center>old操作已成功！</center>");
	}
%>
<form name="formData" method="post" action="autoSetXml.jsp">
<center><input type=hidden name=startButton value="start">
<br><br><br>
大于日期：<input type=text name=startDate value="2006-01-01">
<br>小于日期：<input type=text name=endDate value="2006-12-31">
<br>固定时间：<input type=text name=rootDate value="">
<br>生成日期：<input type=text name=execDate value="<%=CDate.getThisday()%>">
<div id=div1><input id=in1 type=button name=buton value="CLICK ME OLD" onClick="do_Action('old')">&nbsp;&nbsp;
<input id=in1 type=button name=buton value="CLICK ME NEW" onClick="do_Action('between')"></div>
<div id=div2 style="display:none">操作正在进行，请稍后。。。。。。</div2>
</center>
</form>
<%/********************
	if (!"".equals(strDo)) {
%>
		<script language="javascript">
			document.all.div2.style.display = "none";
			document.all.div1.style.display = "";
			formData.submit();
		</script>
<%
	}*******************/
%>
<script language="javascript">
	function do_Action(obj) {
		formData.startButton.value = obj;
		if (formData.execDate.value == "") {
			alert("生成日期不能为空！");
			formData.execDate.focus();
			return false;
		}
		if (confirm("确定需要下面的操作吗？您的操作可能影响整个浦东新区的自动报送情况！")) {
			//alert("确定！");
			document.all.div1.style.display = "none";
			document.all.div2.style.display = "";
			formData.submit();
		}
	}	
</script>
