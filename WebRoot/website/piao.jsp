<%//Update 20061231%>
<iframe src="javascript:false" style="position:absolute; visibility:inherit; top:0px; left:0px;z-index:-1; filter='progid:DXImageTransform.Microsoft.Alpha(style=0,opacity=0)';" border=0 frameBorder=no width=178 height=81 scrolling=no></iframe>
</DIV>
<SCRIPT language=javascript>
	var xPos2 = 500;
	var yPos2 = document.body.clientHeight;
	var step2 = 1;
	var delay2 = 30; 
	var height2 = 0;
	var Hoffset2 = 0;
	var Woffset2 = 0;
	var yon2 = 0;
	var xon2 = 0;
	var pause2 = true;
	var interval2;
	img2.style.top = yPos2;
	img2.onmouseover=function(){clearInterval(interval2)}
				img2.onmouseout=function(){interval2=setInterval("changePos2()", delay2)}
		function changePos2() {
			width = document.body.clientWidth;
			height = document.body.clientHeight;
			Hoffset2 = img2.offsetHeight;
			Woffset2 = img2.offsetWidth;
			img2.style.left = xPos2 + document.body.scrollLeft;
			img2.style.top = yPos2 + document.body.scrollTop;
			if (yon2) {
				yPos2 = yPos2 + step2;
			}
			else {
				yPos2 = yPos2 - step2;
			}
			if (yPos2 < 0) {
				yon2 = 1;
				yPos2 = 0;
			}
			if (yPos2 >= (height - Hoffset2)) {
				yon2 = 0;
				yPos2 = (height - Hoffset2);
			}
			if (xon2) {
				xPos2 = xPos2 + step2;
			}
			else {
				xPos2 = xPos2 - step2;
			}
			if (xPos2 < 0) {
				xon2 = 1;
				xPos2 = 0;
			}
			if (xPos2 >= (width - Woffset2)) {
				xon2 = 0;
				xPos2 = (width - Woffset2);
			}
		}
		function start2() {
				img2.visibility = "visible";
				interval2 = setInterval('changePos2()', delay2);
		}
		start2();
</SCRIPT>