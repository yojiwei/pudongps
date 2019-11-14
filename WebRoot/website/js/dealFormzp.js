  //判定是否以空作为组成内容,是返回fasle,否则返回true
	function chkKong(obj) {
		if (obj.length == 0) return false;
		var bool = 0;
		for (var i = 0;i < obj.length;i++) {
			if (obj.substring(i,i+1) == " ") {
				bool = 1;
			}
			else {
				bool = 0;
				return true;
				break;
			}
		}
		if (bool == 1) {
			//alert("不能以空作为内容！");
			return false;
		}
	}
 /*
   Function: validateForm(aForm)
   功能：验证表单
   参数：aForm 表单对象
  */
 function validateForm(aForm){
     //if(aForm.name.value == ""){
	 if(!isFilled(aForm.name) || chkKong(aForm.name.value) == false){  
	    alert("姓名不能为空!");
		aForm.name.focus();
		return false;
	 }
	 
	 
	 //if(aForm.email.value != ""){//check the format
	 if(!isFilled(aForm.email) || chkKong(aForm.email.value) == false){
	    if(!confirm("请确认没有E-mail地址？\n\n这样您将不能获得电子邮件反馈！！！")){
	       aForm.email.focus();
  		   return false;
		}	
	 }else{
	    //if(isEmail(aForm.email.value) == false){
	    if(!isEmail(aForm.email)){
		   alert("邮件地址格式不正确！");
		   aForm.email.focus();
		   return false;
		}
	 }
	 
	 //if(aForm.subject.value == ""){
	 if(!isFilled(aForm.subject) || chkKong(aForm.subject.value) == false){
        alert("邮件主题不能为空！");
		aForm.subject.focus();
		return false;	 
	 }
	 
	 //if(aForm.content.value == ""){
	 if(!isFilled(aForm.content) || chkKong(aForm.content.value) == false){  
	    alert("内容不能为空！");
		aForm.content.focus();
		return false;
	 }
	 
	 if(typeof aForm.rand != "undefined") {
		 if	(aForm.rand.value =="")
		 {
		 alert("请填写4位图片验证码！");
		 aForm.rand.focus();
		 return false;
		 }
	 }
	 document.all.button_sub.onclick = "#";
	 wait();
	 
	 aForm.submit();
	   
 }//function validateForm
 
	function wait(){
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

 