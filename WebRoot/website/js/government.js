function gd(id,o){
	try{
		var tar = new Array("enterpw","persw","invest","splv");
		var obj = o;
		for(i = 0; i < tar.length; i++)		{
			eval("document.all."+tar[i]+".style.display='none';");
			eval("document.all."+tar[i]+"_b.className='f15_out';");
			if(tar[i]==id) {o.className = "f15_on";eval("document.all."+tar[i]+".style.display='';");}
		}
	}catch(e){
		//nothing
	}
}



function st(o,s){
	var v = document.createElement("input");
	v.type = "hidden";
	v.name = "cw_id";
	v.id = "cw_id";
	v.value = o;
	var f = document.createElement("form");
	f.name = "formData";
	//f.action = window.location.href;
	f.action = "/website/workHall/workList.jsp?sj_dir="+s+"&pardir=workHall#　";
	f.method = "post";
	f.appendChild(v);
	document.body.appendChild(f);
	f.submit();
	//window.location.href = "/website/workHall/workList.jsp";
}
var http = new ActiveXObject("Microsoft.XMLHTTP");
var oo;
function wt(o,t){
	try{
	var s,c;
	eval("document.formWSearch." + t + ".length = 0");
	eval("document.formWSearch." + t + ".options[0] = new Option('--','0');");
	switch(eval("document.formWSearch."+o+".value")){
		case "0":
			s = false;
			break;
		case "1":
			s = true;
			c = "1";
			break;
		case "2":
			s = true;
			c = "2";
			break;
		default:
			c = "1";
			break
	}
	//o.disabled = true;
	//eval("document.all."+t+".disabled = true;");
	if(s){
		oo = o+","+t;tt = t;cs(oo,true);
		http.onreadystatechange = iv;
		url="/website/workHall/getList.jsp?st="+c;
		http.open("GET",url,true);
		http.send();}
	}catch(e){
		//nothing
	}
}

function iv(){
	if (http.readyState==4)	{
		var str = http.responseText;
		while(str.indexOf("\n")!=-1||str.indexOf("\r")!=-1)
		{str = str.replace("\n","");str = str.replace("\r","");}
		var a = str.split(";");
		for(i = 0; i < a.length; i++){
			var b = a[i].split(",");
			eval("document.formWSearch." + tt + ".options["+i+"] = new Option('"+b[1]+"','"+b[0]+"');");
		}
		http.abort();
		cs(oo,false);
	}
}

function cs(t,s)
{
	var a = t.split(",");
	if(a.length==1) eval("document.formWSearch."+a+".disabled="+s);
	else
		for(i=0;i<a.length;i++){
			eval("document.formWSearch."+a[i]+".disabled="+s);
		}
}

function del(attach)
{
	if(confirm("确实要删除该文件吗？"))
	{
		var w=1;
		var h=1; 
		var url = "DelAttach.jsp?attach="+attach;
		window.open(url,"","Top=0px,Left=0px,Width="+w+"px,Height="+h+"px,toolbar=no,location=no,derectories=no,status=no,menubar=no,resizable=yes,scrollbars=no");
	}
}
function sendMsg(l_pd_projectId,l_wo_id)
{
	var w=450;
	var h=270; 
	var url = "SendMessage.jsp?pr_id="+l_pd_projectId+"&wo_id="+l_wo_id;
	window.open(url,"发送消息","Top=0px,Left=0px,Width="+w+"px,Height="+h+"px,toolbar=no,location=no,derectories=no,status=no,menubar=no,resizable=no,scrollbars=no");
}

function readMsg(id,type)
{
	var w=450;
	var h=250;
	var url = "MessageDetail.jsp?ma_id="+id+"&OPType="+type;

	window.open(url,"查看消息","Top=0px,Left=0px,Width="+w+"px,Height="+h+"px,toolbar=no,location=no,derectories=no,status=no,menubar=no,resizable=no,scrollbars=no");
}
	
//检测用户信息是否输入完整
function checkUserInfo(){
	var form = document.formData;
	if(form.userName.value==""){
		alert("用户信息需要填写完整！");
		form.userName.focus();
		return false;
	}
	if(form.tel.value==""){
		alert("用户信息需要填写完整！");
		form.tel.focus();
		return false;
	}
	if(form.address.value==""){
		alert("用户信息需要填写完整！");
		form.address.focus();
		return false;
	}
	if(form.zipcode.value==""){
		alert("用户信息需要填写完整！");
		form.zipcode.value=="";
		return false;
	}
	return true;
}

//检测附件是否都已上传

function checkAttachInfo(){
	//检测必须上传的附件
	if(typeof(document.formData.fj1)!="undefined"){
		var attachs = document.formData.fj1;
		var length;
		if (typeof(attachs.length)=="undefined"){
			if(attachs.value==""){
				alert("附件信息不完整！");
				attachs.focus();
				return false;
			}
		}
		else{
			length = attachs.length;
			for (var i=0;i<length;i++){
				if(attachs[i].value==""){
					alert("附件信息不完整！");
					attachs[i].focus();
					return false;
				}
			}
		}
	}
	//检测非相关文件的上传
	if (typeof(document.formData.fj2)!="undefined"){
		var attachs = document.formData.fj2;
		var attachDesc = document.formData.fjsm1;
		var length;
		if (typeof(attachs.length)=="undefined"){
			if (attachs.value!=""){
				if (attachDesc.value==""){
					alert("附件说明不能为空！");
					attachDesc.focus();
					return false;
				}
			}
		}
		else{
			length = attachs.length;
			for (var i=0;i<length;i++){
				if (attachs[i].value!=""){
					if (attachDesc[i].value==""){
						alert("附件说明不能为空！");
						attachDesc[i].focus();
						return false;
					}
				}	
			}
		}
	}
	return true;
}

//提交的时候触发
function submitPro(){
	if (checkUserInfo()&&checkAttachInfo()){
		var obj = formData.linkMan;
		if(typeof(obj)!="undefined"){
			if(obj.value==""){
				alert("联系人不能为空！");
				obj.focus();
				return false;
			}
		}
		obj = formData.idCard;
		if (obj.value==""){
			alert("信息尚未填写完整！");
			obj.focus();
			return false;
		}
		formData.isTemp.value="0";
		formData.action = "applyResult.jsp";
		formData.submit();
	}
}

//更新附件的时候触发
function openUpdate(val){
	var url = "ProjectUpdate.jsp?wa_id="+val;
	window.open(url,"更新附件","Top=0px,Left=0px,Width=550px,Height=300px,toolbar=no,location=no,derectories=no,status=no,menubar=no,scrollbars=yes");
}