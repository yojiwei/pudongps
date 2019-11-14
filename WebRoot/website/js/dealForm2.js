 /*
   Function: validateForm(aForm)
   功能：验证表单
   参数：aForm 表单对象
  */
   
 function validateForm(aForm){
     
     if(!isFilled(aForm.name)){
	    alert("姓名不能为空!");
		aForm.name.focus();
		return false;
	 }	 
	
	 if(!isFilled(aForm.company)){
	    alert("工作单位不能为空！");
		aForm.company.focus();
		return false;
	 }
	 
	 if(!isFilled(aForm.tel)){
	    alert("电话不能为空！");
		aForm.tel.focus();
		return false;
	 }
	 
	 if(isFilled(aForm.email)){
	    if(!isEmail(aForm.email)){//存在邮件地址，验证其合法性
		  alert("邮件地址格式不正确！");
		  aForm.email.focus();
		  return false;
		}
	 }else{
	    if(!confirm("请确认没有E-mail地址？\n\n这样您将不能获得电子邮件反馈！！！")){
	        aForm.email.focus();
			return false;
		}
	 }
	 
	 if(!isFilled(aForm.subject)){
        alert("邮件主题不能为空！");
		aForm.subject.focus();
		return false;	 
	 }
	 
	 if(!isFilled(aForm.content)){
	    alert("投诉内容不能为空！");
		aForm.content.focus();
		return false;
	 }
	 
	 if(!isFilled(aForm.LeaderEmail)){
        alert("请选择收信人!")
        aForm.LeaderEmail.focus();
        return;
     }
	 
	 wait();

	 aForm.submit();
	   
 }//function validateForm
 
	function wait(){//替换<div>中的内容
	  try{
	    document.all.function_buttons.innerHTML = "<center><b>系统正在处理中，请你稍后...</b></center>";  
	  }catch(e){
	  
	  };  
	}
	
	function isEmail(elm){//验证邮件地址是否合法
	   if(elm.value.indexOf("@")!= -1 && 
	      elm.value.indexOf(".")!= -1 ){
	      return true
	   }else{
	      return false;
	   }
	}
	
	function isFilled(elm){//验证是否为空
	   if(elm.value == "" || elm.value == null){
	     return false;
	   }else{
	     return true;
	   }
	}


 
 