function dovalidate(formData)//通用文本域校验
{
	if(formData.cw_mail.value!="")
	{
		if(isEmail(formData.cw_mail.value)==false)
		{
			alert("邮件格式不对!");
			formData.cw_mail.focus();
			return false;
		}
	}
	else
	{
		if(!confirm("请确认没有E-mail地址？\n\n这样您将不能获得电子邮件反馈！！！"))
		{
			return false;
		}
	}
	if (formData.cw_tel.value == "" && formData.cw_mail.value == "")  {
		alert("联系电话和电子邮件必须有一项填写！");	
		formData.cw_tel.focus();
		return false;
	}
	if(formData.strSubject.value=="")
	{
		alert("主题不能为空！");
		formData.strSubject.focus();
		return false;
	}
	if(formData.strContent.value=="")
	{
		alert(" 投诉内容不能为空！");
		formData.strContent.focus();
		return false;
	}
	if (formData.strContent.value != "") {
		value = formData.strContent.value;
		var chineseLen = getChineseLength(value);
		if (chineseLen < 10) {
			alert("投诉内容不能少于十个汉字！");
			formData.strContent.focus();
			return false;
		}
	}
	 if	 (formData.rand.value =="")
	{
	alert("请填写4位图片验证码！");
	formData.rand.focus();
	return false;
	}
	document.all.button_sub.onclick = "#";
	function_buttons.style.display = "none";
	function_submit.style.display = "";
	fnDisable();
	formData.submit();
}

/*--------------------------------------------------------------------------------------------*/

function fnDisable()
{
 try{
  document.all.function_buttons.innerHTML = "<center><b>系统正在处理中，请您稍后...</b></center>";
 }catch(e){

 };
}

function cn()
{
	alert("请选择！");
	return false;
}