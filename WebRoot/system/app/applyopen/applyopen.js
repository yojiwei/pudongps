var http = new ActiveXObject("Microsoft.XMLHTTP");
var tt;
var bb;
function wt(o,t,b){
	try{
		eval("document.all."+t+".innerHTML='<font color=#0000CC><b>loading......</b></span>';");
		http.onreadystatechange = iv;
		//url = o;
		tt = t;
		bb = b;
		http.open("GET",o,true);
		http.send();
	}catch(e){
		//nothing
	}
}

function iv(){
	try{
		if (http.readyState==4)	{
			var str = http.responseText;
			
			while(str.indexOf("\n")!=-1||str.indexOf("\r")!=-1)
			{str = str.replace("\n","");str = str.replace("\r","");}
			//while(str.indexOf("'")!=-1) str = str.replace("'","");
			//while(str.indexOf("\"")!=-1) str = str.replace("\"","");
			//while(str.indexOf(":")!=-1) str = str.replace(":","");
			//while(str.indexOf(",")!=-1) str = str.replace(",","");
			while(str.indexOf(";")!=-1) str = str.replace(";","");
			//while(str.indexOf(" ")!=-1) str = str.replace(" ","");
			/*var a = str.split(";");
			for(i = 0; i < a.length; i++){
				var b = a[i].split(",");
				eval("document.formWSearch." + tt + ".options["+i+"] = new Option('"+b[1]+"','"+b[0]+"');");
			}*/
			eval("document.all."+tt+".innerHTML='"+str+"';");
			if(bb!=""){
				document.all.chone.className = "title_down";
				document.all.chtwo.className = "title_down";
				eval("document.all."+bb+".className='title_on';");
			}
			http.abort();
			//cs(oo,false);
		}
	}catch(e){
		eval("document.all."+tt+".innerHTML='获取信息出错......';");
		http.abort();
	}
}
function onChange(){}

function CAble(o,t){
	if(o.checked){
		eval("document.all."+t+".value = '';");
		eval("document.all."+t+".readOnly = false;");
	}else{
		eval("document.all."+t+".value = '';");
		eval("document.all."+t+".readOnly=true;");
	}
}

function checkform()
{
	var form = document.formData;
	var obj = document.all.sign;
	var tar = document.all.noreason;
	var gim = document.all.gm;
	var dept = document.all.did;
	var status = false;
	var rreason = "";
	var gmode = "";
	if(dept==undefined){
		status = false;
	}else{
		if(dept.length==undefined){
			if(dept.checked) status = true;
			else status = false;
		}else{
			for(i=0; i<dept.length; i++){
				if(dept[i].checked){
					status = true;
					break;
				}
			}
		}
	}

	if(tar!=undefined){
		if(tar.length==undefined){
			if(tar.checked) rreason = tar.value;
		}else{
			for(i=0; i<tar.length; i++){
				if(tar[i].checked){
					rreason += tar[i].value+"#";
				}
			}
		}
	}

	if(gim!=undefined){
		if(gim.length==undefined){
			if(gim.checked) gmode = gim.value;
		}else{
			for(i=0; i<gim.length; i++){
				if(gim[i].checked){
					gmode += gim[i].value+",";
				}
			}
		}
	}
	
	if(obj[0].checked||obj[1].checked){
		if(gmode==""&&!document.all.othermode.checked){
			alert("请选择信息提供方式！");
			return false;
		}else{
			document.all.gmode.value = gmode;
		}
		if(document.all.othermode.checked&&document.all.omode.value==""){
			//if(){
			alert("请填写其他信息提供方式！");
			return false;
			//}else{
				//document.all.oreason.value = document.all.otherr.value;
			//}
		}
	}
	
	if(obj[1].checked||obj[2].checked){
		if(obj[1].checked&&document.all.canopen.value==""){
			alert("请填写允许公开的内容！");
			return false;
		}
		if(obj[1].checked&&document.all.whatinfo.value==""){
			alert("请填写不允许公开内容！");
			return false;
		}
		if(rreason==""&&!document.all.otherc.checked){
			alert("请选择不公开原因！");
			return false;
		}else{
			document.all.rreason.value = rreason;
		}
		if(document.all.otherc.checked){
			if(document.all.otherr.value==""){
				alert("请填写其他情形具体内容！");
				return false;
			}else{
				document.all.oreason.value = document.all.otherr.value;
			}
		}
		if(document.all.rentry.value==""){
			alert("请填写法规依据！");
			return false;
		}
	}else{
		if(obj[4]!=undefined){
			if(obj[4].checked){
				if(!status){
					alert("请选择转办部门！");
					return false;
				}
			}
		}
	}
	if(document.all.commentinfo.value==""){
		alert("请填写备注信息！");
		document.all.commentinfo.focus();
		return false;
	}
	
	if(obj[6].checked){
		alert("该处理方式尚未开通，请选择其他处理方式进行处理");
		return false;
	}

	/*if(obj!=undefined)[
		if(obj.length!=undefined)[
			for(i=0; i<obj.length; i++){
				if(obj[i].checked&&obj[i].value=="2"){
					alert();
				}
			}
		}
	}
	*/
	//if(document.all.sign)
	form.submit();
}

function printInfo(iid){
	window.open("printApprize.jsp?iid="+iid,"","Top=0px,Left=0px,width=720,height=450,scrollbars=yes");
}

function taskInfo(tid){
	window.open("taskDetail.jsp?tid="+tid,"","Top=0px,Left=0px,width=600,height=450,scrollbars=yes");
}

function claimIt(iid){
	if(confirm("确认操作？")){
		window.location.href = "claimIt.jsp?checkdel="+iid;
		window.close();
	}
}

function gettaskInfo(){
	var obj = document.createElement("div");
	obj.
	obj.style.border = "1px solid red";
	document.formData.appendChild(obj);
	obj.innerHTML = "loading...";
}

function dealtask(o,t){
	var obj = new Array("0","1","2","3","4","5");
	try{
		t.checked = true;
		if(o==0||o==1){
			document.all.whatgive.style.display = "";
			document.all.emailtalk.style.display="";
			document.all.oemail.value=document.all.pemail.value;
			
		}else{
			document.all.whatgive.style.display = "none";
			document.all.emailtalk.style.display="none";
			document.all.oemail.value="";
		}
		
		if(o==4){
			document.all.pass.style.display = "";
			wt('chooseDept.jsp','deptlist','chone');
		}else{
			document.all.pass.style.display = "none";
			document.all.deptlist.innerHTML = "";
		}

		if(o==1||o==2){
			document.all.reason.style.display = "";
			if(o==1){
				document.all.asno.style.display = "";
				document.all.emailtalk.style.display="";
				document.all.oemail.value=document.all.pemail.value;
			}else{
				document.all.asno.style.display = "none";
				document.all.emailtalk.style.display="none";
				document.all.oemail.value="";
			}
		}else{
			document.all.reason.style.display = "none";
		}

		if(o==9){
			document.all.hang.style.display = "";
		}else{
			document.all.hang.style.display = "none";
			
		}

		if(o==8){
			document.all.postpened.style.display = "";
		}else{
			document.all.postpened.style.display = "none";
		}
		if(o==10){
			document.all.whatgive.style.display = "none";
		}
		/*for(i=0; i<obj.length; i++){
			if(obj[i]==o){
				eval("document.all.s"+obj[i]+".style.display = '';");
			}else{
				eval("document.all.s"+obj[i]+".style.display = 'none';");
			}	
		}*/
	}catch(e){
		//nothing
	}
}
function SelectAllCheck(des,name){
	var obj = eval("document.all." + name);
	if(typeof(obj)=="undefined"){
		return false;
	}else{
		if(obj.length==undefined){
			switch(des.checked){
				case false:
				obj.checked = false;
				break;
				case true:
				obj.checked = true;
				break;
				}
		}else{
			for(i=0;i<obj.length;i++){
				switch(des.checked){
					case false:
					obj[i].checked = false;
					break;
					case true:
					obj[i].checked = true;
					break;
				}
			}
		}
	}
}

function jobcheckup(t,o,c){
	var obj = document.all.checkdel;
	var status = false;
	if(obj!=undefined){
		if(obj.length==undefined){
			obj.checked?status=true:status=false;
		}else{
			for(i=0;i<obj.length;i++){
				if(obj[i].checked){
					status=true;
					break;
				}
			}
		}
	}
	if(status){
		if(confirm("您确定这样操作？")){
			var form = document.formData;
			form.action = t;
			form.target = o;
			//form.iid.value = c;
			form.submit();
		}
	}else{
		alert("请至少选择一个记录！");
	}
}

function printIt(o){
	try{
		var obj = document.getElementById(o); 
		obj.style.display = "none";
		print();
		obj.style.display = "";
	}catch(e){
		//nothing
	}
}

function searchTerm(){
	var form = document.formSearch;
	
	var obj = document.all.s_statusSTR;
	var dealmode = document.all.s_dealmodeSTR;
	
	var objSTR = "";
	var dealmodeSTR = "";

	if(obj!=undefined&&obj.length!=undefined){
		for(i=0; i<obj.length; i++){
			if(obj[i].checked) objSTR += obj[i].value + ",";;
		}
	}
	if(objSTR!="") objSTR = objSTR.substring(0,objSTR.length-1);

	if(dealmode!=undefined&&dealmode.length!=undefined){
		for(i=0; i<dealmode.length; i++){
			if(dealmode[i].checked) dealmodeSTR += dealmode[i].value + ",";;
		}
	}
	if(dealmodeSTR!="") dealmodeSTR = dealmodeSTR.substring(0,dealmodeSTR.length-1);

	form.s_status.value = objSTR;
	form.s_dealmode.value = dealmodeSTR;

	form.submit();
}

function dealOver(o,t){
	if(!o.checked){
		if(t!=undefined){
			if(t.length!=undefined){
				for(i=0; i<t.length; i++){
					t[i].checked = false;
				}
			}else{
				t.checked = false;
			}
		}
	}
}

function dealOn(o,t){
	if(o.checked){
		if(t!=undefined){
			if(t.length!=undefined){
				for(i=0; i<t.length; i++){
					t[i].checked = true;
				}
			}else{
				t.checked = true;
			}
		}
	}
}

function getOpenInfo(obj){
	try{
		//alert(obj.offsetLeft);
		if(obj.value!="0"){
			if (document.all.div1==undefined){
				getIE(obj);
				var my_line = document.createElement("div");		
				my_line.id = "div1";
				my_line.name = "div1";
				my_line.style.width = "400px";
				my_line.style.height = "90px";
				my_line.style.position = "absolute";
				my_line.style.left = mx;
				my_line.style.top = my;
				my_line.disabled = false;
				my_line.style.border = "2px solid #0066FF";
				my_line.style.background = "#F7F7F7";
				my_line.innerHTML = "<div id=div1_2 style=position:relative;width:100%;height:19px;left:0px;top:0px;background:#0066FF;font-weight:bold;color:blue;padding-top:5px;background:url('../../manage/images/subTitleBg.gif');cursor:move align=right><span onclick=Distory(document.all.div1) style=cursor:hand>关闭</span>&nbsp;</div><div id=div1_1 style=position:relative;width:100%;height:100%;left:0px;top:0px;overflow-x:scroll;overflow-y:scroll;></div><div id=div1_3 style=position:relative;width:100%;height:10px;left:0px;top:0px;background:#99CCFF;font-weight:bold;color:blue;padding-top:0px; align=right><span id=resize style=font-family:Marlett;color:white;cursor:se-resize>o</span></div>";
				//my_line.innerHTML = "";
				//my_line.innerHTML = "";
				//my_line.innerHTML = "<table class='main-table' width='100%'><tr><td><table cellspacing='0' align='center' cellpadding='0' width='98%' border='0'><tr></td>"+obj.innerHTML+"</td></tr></table></td></tr></table>";
				//my_line.innerHTML = obj.innerHTML;
				
				//obj.removeNode(true);
				//my_line.childNodes[0].style.border="1px solid #C7DFF1";
				document.body.appendChild(my_line);
			}
			wt("getConsult.jsp?ci_id="+obj.value,"div1_1","");

			status = true;
			//obj.disabled=true;
			//obj.style.visibility = "hidden";
			//seResize(document.getElementById("div1"),document.getElementById("div1_3"));
			//drag(document.getElementById("div1"),document.getElementById("div1_2"));
			drag(document.getElementById("div1"),document.getElementById("div1_2"),document.getElementById("resize"));
			//move();
			//alert(document.all.asd.innerHTML)
		}else{
			alert("请选择要查看的条目！");
		}
	}catch(e){
		alert("系统错误，或是您的系统不支持javascript，请检查相关设置后重试！");
	}
}
var i=0;
function addElem_d(ename,durl,ew,eh){
	try{
		if(eval("document.all."+ename+"==undefined")){
			getIE();
			var obj = document.createElement("div");		
			obj.id = ename;
			obj.name = ename;
			obj.style.width = ew;
			obj.style.height = eh;
			obj.style.position = "absolute";
			obj.style.zIndex = i+1;
			obj.style.left = mx;
			obj.style.top = my;
			obj.disabled = false;
			obj.style.border = "2px solid #0066FF";
			obj.style.background = "#F7F7F7";
			obj.innerHTML = "<div id="+ename+"_title style=position:relative;width:100%;height:19px;left:0px;top:0px;background:#0066FF;font-weight:bold;color:blue;padding-top:5px;background:url('../../manage/images/subTitleBg.gif');cursor:move align=right><span onclick=Distory(document.all."+ename+") style=cursor:hand>关闭</span>&nbsp;</div><div id="+ename+"_inner style=position:relative;width:100%;height:100%;left:0px;top:0px;overflow-x:scroll;overflow-y:scroll;></div><div id="+ename+"_buttom style=position:relative;width:100%;height:10px;left:0px;top:0px;background:#99CCFF;font-weight:bold;color:blue;padding-top:0px; align=right><span id="+ename+"_resize style=font-family:Marlett;color:white;cursor:se-resize>o</span></div>";
			document.body.appendChild(obj);
		}
		wt(durl,ename+"_inner","");
		status = true;
		drag(document.getElementById(ename),document.getElementById(ename+"_title"),document.getElementById(ename+"_resize"));
	}catch(e){
		alert("系统错误，或是您的系统不支持javascript，请检查相关设置后重试！");
	}
}

function addElem(ename,durl,ew,eh){
	if(ew==null || eh==null){
		addElem_d(ename,durl,'400px','90px');
	}else{
		addElem_d(ename,durl,ew,eh);
	}
}

function getIE(){
	/*var t=e.offsetTop;
	var l=e.offsetLeft;
	while(e=e.offsetParent){
		t+=e.offsetTop;
		l+=e.offsetLeft;
	}*/
	mx = document.documentElement.scrollLeft + event.clientX;
	my = document.documentElement.scrollTop + event.clientY;
}

function Distory(obj){
	try{
		obj.removeNode(true);
	}catch(e){
		alert("222");
	}
}

function GetPosition(){
	//if(status)
	//{
		x = event.clientX;
		y = event.clientY;
		//move();
	//}
}

function drag(o,t){
	try{
		var gogo = false;
		var mmx,mmt;
		t.onmouseup=function(){
			gogo = false;
		}
		t.onmousedown=function(){
			gogo = true;
			mmx = o.offsetLeft;
			mmy = o.offsetTop;

			mmmx = event.clientX;
			mmmy = event.clientY;
		}
		document.body.onmousemove=function(){
			if(gogo){
				GetPosition();
				o.style.left = document.documentElement.scrollLeft + x - ((document.documentElement.scrollLeft + mmmx) - mmx);
				o.style.top = document.documentElement.scrollTop + y - ((document.documentElement.scrollTop + mmmy)-mmy);
			}
		}
	}
	catch(e)
	{
		alert("333");
	}
}

function drag(o,t,r){
	try{
		var gogo = false;
		var ser = false;
		var obj;
		//var mmx,mmt;
		o.onmousedown = function(){
			o.style.zIndex = i+1;
			i++;
		}
		t.onmouseup = function(){
			gogo = false;
			o.className = "";
		}
		t.onmousedown = function(){
			gogo = true;
			o.className = "dragdiv";
			mmx = o.offsetLeft;
			mmy = o.offsetTop;

			mmmx = event.clientX;
			mmmy = event.clientY;

			document.body.onmousemove = function(){
				try{
					if(gogo){
						GetPosition();
						//eval("document.all."+ename+"_inner.innerHTML = x;");
						o.style.left = document.documentElement.scrollLeft + x - ((document.documentElement.scrollLeft + mmmx) - mmx);
						o.style.top = document.documentElement.scrollTop + y - ((document.documentElement.scrollTop + mmmy)-mmy);
					}
				}catch(e){
					//nothing
				}
			}
		}
		
		r.onmousedown = function(){
			ser = true;
			rrx = (o.style.width).replace("px","");
			rry = (o.style.height).replace("px","");

			rrrx = event.clientX;
			rrry = event.clientY;

			document.body.onmousemove = function(){
				try{
					if(ser){
						GetPosition();
						o.style.width = parseInt(rrx) + parseInt(x) - parseInt(rrrx);
						o.style.height = parseInt(rry) +  parseInt(y) -  parseInt(rrry);
					}
				}catch(e){
					//nothing
				}
			}

			document.onmouseup = function(){
				ser = false;
			}
		}
		
	}catch(e){
		alert("333");
	}
}

function seResize(o,t){
	try{
		var ser = false;
		//var mmx,mmy;
		document.onmouseup = function(){
			ser = false;
		}
		t.onmousedown = function(){
			ser = true;
			rrx = o.offsetLeft;
			rry = o.offsetTop;

			rrrx = event.clientX;
			rrry = event.clientY;
		}
		document.body.onmousemove = function(){
			if(ser){
				GetPosition();
				o.style.width = 400 + x - rrrx;
				o.style.height = 90 + y - rrry;
			}
		}
	}catch(e){
		alert("333");
	}
}