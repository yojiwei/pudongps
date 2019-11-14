<%@page contentType="text/html; charset=GBK"%>
<%@include file="../../manage/head.jsp"%>

<!-- ³ÌÐò¿ªÊ¼ -->
<body topmargin="0" leftmargin="0">
<div onmouseover="showCorr()" onmousemove="showCorr()" onclick="javascript:show();">
<TABLE WIDTH=1538 BORDER=0 CELLPADDING=0 CELLSPACING=0>
  <tr>
    <td><img src="department.jpg" width="452" height="452" alt=""></td>
  </tr>
</table>
</div>
</body>

<script language="javascript">
function showCorr(){
	var theEvent = event.type;
	 var mouseX = event.clientX + document.body.scrollLeft;
	 var mouseY = event.clientY + document.body.scrollTop;

	 window.status="(X:" + mouseX + ", Y:" + mouseY + ")";
}

function show()
{
	var theEvent = event.type;
	var mouseX = event.clientX + document.body.scrollLeft;
	var mouseY = event.clientY + document.body.scrollTop;
	opener.document.all.mp_x.value = mouseX;
	opener.document.all.mp_y.value = mouseY;
	window.close();
	//alert(mouseX+"+"+mouseY);
}
</script>
