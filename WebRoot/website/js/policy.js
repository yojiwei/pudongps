function readMsg(id,type)
{
	var w=450;
	var h=250;
	var url = "/website/usercenter/MessageDetail.jsp?ma_id="+id+"&OPType="+type;

	window.open(url,"查看消息","Top=0px,Left=0px,Width="+w+"px,Height="+h+"px,toolbar=no,location=no,derectories=no,status=no,menubar=no,resizable=no,scrollbars=no");
}

//检测用户信息是否输入完整
//不管是暂存还是提交，都要检查

function checkUserInfo()
{
	var form = document.formData;
	if(form.userName.value=="")
	{
			alert("用户信息需要填写完整！");
			form.userName.focus();
			return false;
	}
	if(form.tel.value=="")
	{
			alert("用户信息需要填写完整！");
			form.tel.focus();
			return false;
	}
	if(form.address.value=="")
	{
			alert("用户信息需要填写完整！");
			form.address.focus();
			return false;
	}
	if(form.zipcode.value=="")
	{
			alert("用户信息需要填写完整！");
			form.zipcode.value=="";
			return false;
	}
	return true;
}

//检测附件是否都已上传
//只在提交的时候检测

function checkAttachInfo()
{
	if(typeof(document.formData.fj1)!="undefined")
	{
		var attachs = document.formData.fj1;
		var length;
		if (typeof(attachs.length)=="undefined")
		{
			if(attachs.value=="")
			{
				alert("附件信息不完整，只可以暂存！");
				attachs.focus();
				return false;
			}
		}
		else
		{
			length = attachs.length;
			for(var i=0;i<length;i++)
			{
				if(attachs[i].value=="")
				{
					alert("附件信息不完整，只可以暂存！");
					attachs[i].focus();
					return false;
				}
			}
		}
	}
	return true;
}

//暂存的时候触发
function tempSave()
{
	if(checkUserInfo())
	{
		formData.isTemp.value="1";
		formData.action = "/website/supervise/policyResult.jsp";
		formData.submit();
	}
}
//提交的时候触发
function submitPro()
{
	if (checkUserInfo()&&checkAttachInfo())
	{
		var obj = formData.linkMan;
		if(typeof(obj)!="undefined")
		{
			if(obj.value=="")
			{
				alert("联系人不能为空！");
				obj.focus();
				return false;
			}
		}
		obj = formData.idCard;
		if (obj.value=="")
		{
			alert("信息尚未填写完整！");
			obj.focus();
			return false;
		}
		if (formData.appertain.value != "") {
			value = formData.appertain.value;
			var chineseLen = getChineseLength(value);
			if (chineseLen < 10) {
				alert("附言不能少于十个汉字！");
				formData.appertain.focus();
				return false;
			}	
		}
		document.all.button_sub.onclick="#";
		function_buttons.style.display = "none";
		function_submit.style.display = "";
		formData.isTemp.value="0";
		formData.action = "/website/supervise/policy_Result.jsp";
		formData.submit();
	}
}

//更新附件的时候触发
function openUpdate(val)
{
	var url = "/website/usercenter/ProjectUpdate.jsp?wa_id="+val;
	window.open(url,"更新附件","Top=0px,Left=0px,Width=550px,Height=300px,toolbar=no,location=no,derectories=no,status=no,menubar=no,scrollbars=yes");
}