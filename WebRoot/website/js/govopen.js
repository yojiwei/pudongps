function save(){	
	if(typeof(sForm.getid) != "undefined"){
		if (sForm.in_project.value==""){
			alert("使用检索功能，检索具体的依申请公开类别");
		}
		else{
			var form = document.sForm;
			if(window.confirm('确认要提交吗？')){
				form.action = "OpenReply.jsp?io_id=<%=io_id%>";
				form.submit();	
			}
		}
	}
	else{
		alert("该业务必须是注册用户才能办理");
		window.location.href("../../website/login/Login.jsp?oPage="+window.location.href);
	}
}

function fnsearch(){
	var sear = sForm.search.value;
	if(sForm.search.value=="" || sForm.search.value == "输入检索关键字")	{
		alert("请输入检索关键字！");
	}
	else{
		window.open("search.jsp?search=" + sear,"依申请公开搜索","Top=0px,Left=0px,height=400,width=520,scrollbars=yes");
	}
}

function changeto(highlightcolor){
	source=event.srcElement
	if (source.tagName=="TR"||source.tagName=="TABLE")	{
		return false;
	}
	while(source.tagName!="TR"){
		source=source.parentElement;
	}
	if (source.style.backgroundColor!=highlightcolor&&source.id!="ignore"){
		source.style.backgroundColor=highlightcolor;
	}
}

function changeback(originalcolor){
	if (event.fromElement.contains(event.toElement)||source.contains(event.toElement)||source.id=="ignore"){
		return false;
	}
	if (event.toElement!=source){
		source.style.backgroundColor=originalcolor;
	}
}