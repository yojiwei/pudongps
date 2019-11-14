//得到字符串中的中文长度
function getChineseLength(value){
	var totalLen = 0;
	value = cTrim(value,0);
    re=/[\u4E00-\u9FA5]/g;  
	if(re.test(value))
		totalLen = value.match(re).length;
	else  
		totalLen = 0;
	return totalLen;
}

//sInputString 为输入字符串，iType为类型，分别为 0 - 去除前后空格; 1 - 去前导空格; 2 - 去尾部空格
function cTrim(sInputString,iType){
	var sTmpStr = ' ';
	var i = -1;
	if(iType == 0 || iType == 1){
		while(sTmpStr == ' '){
			++i;
			sTmpStr = sInputString.substr(i,1);
		}
		sInputString = sInputString.substring(i);
	}
	if(iType == 0 || iType == 2){
		sTmpStr = ' ';
		i = sInputString.length;
		while(sTmpStr == ' '){
			--i;
			sTmpStr = sInputString.substr(i,1);
		}
		sInputString = sInputString.substring(0,i+1);
	}
	return sInputString;
}

function checkForm(formName,pType)
{
	//alert(formName);
	//alert(eval(formName + ".length"));
	//alert(pType);
	//alert(pType == "multiple");

	var sType;
	var oName;
	

	if(typeof(pType)=="undefined" || pType.equals == "")
	{
		sType = "standard";
	}
	else
	{
		sType = pType.toLowerCase();
	}

	//alert(sType);
	//alert(formName);
	oName = eval("document.all." + formName);
	//获取集合长度
	for(k=0;k<oName.length;k++)
	{
		//判断当前表单项的类型
		//alert(oName[k].field_type);
		//alert(oName[k].type)
		if(typeof(oName[k].field_type)!="undefined"&&oName[k].field_type!="")
		{
			switch(oName[k].field_type){
				//如果是邮件地址
				case "email":
					if(checkEmail(oName[k].value)==false)
					{
						alert(oName[k].field_name + "填入的不是正确email");
						if(sType == "standard")		//如果是标准的表单，返回焦点
						{
							oName[k].focus();
						}
						return false;
					}
					else
					{
						break;
					}
				//如果是日期类型
				case "date":
					if(isDate(oName[k].value)==false)
					{
						alert(oName[k].field_name + "填入的不是正确的日期！");
						if(sType == "standard")		//如果是标准的表单，返回焦点
						{
							oName[k].focus();
						}
						return false;
					}
					else
					{
						break;
					}
				//如果是整数类型
				case "int":
					if(checkInt(oName[k].value)==false)
					{
						alert(oName[k].field_name + "填入的不是整数");
						if(sType == "standard")		//如果是标准的表单，返回焦点
						{
							oName[k].focus();
						}
						return false;
					}
					else
					{
						break;
					}
				//如果是数字类型
				case "numeric":
					if(checkNumeric(oName[k].value)==false)
					{
						alert(oName[k].field_name + "填入的不是数字类型");
						if(sType == "standard")		//如果是标准的表单，返回焦点
						{
							oName[k].focus();
						}
						return false;
					}
			}
		}
		
		//判断当前表单项是否必填
		if(typeof(oName[k].allow_null)!="undefined"&&oName[k].allow_null=="false")
		{
			if(oName[k].value=="")
			{
				alert(oName[k].field_name + "不能为空");
				if(sType == "standard")		//如果是标准的表单，返回焦点
				{
					oName[k].focus();
				}
				return false;
			}
		}
	}
	
	//alert(myform.length);
	return true;
}

//判断是否是日期值
//日期值格式：YYYY-M-D
//日期范围：1800-1-1到2100-12-31
function isDate(DateStr)
{
	var tmpChar;
	var tmpInt;
	var index;
	var iYear;
	var iMonth;
	
	DateStr=trim(DateStr);
	if(DateStr.length==0) return true;
	
	index=0;
	tmpInt=0;
	for(i=0;i<DateStr.length;i++)
	{
		tmpChar=DateStr.substr(i,1);
		if(tmpChar=="-")
		{
			if(index==0)
			{
				if((tmpInt>2100)|(tmpInt<1800)) return false;
				iYear=tmpInt;
			}
			if(index==1)
			{
				if((tmpInt>12)|(tmpInt<1)) return false;
				iMonth=tmpInt;
			}
			index=index+1;
			tmpInt=0;
		}
		else
		{
			if((tmpChar<'0')|(tmpChar>'9')) return false;
			tmpInt=tmpInt*10 + parseInt(tmpChar,10);
		}
	}
	
	if(!index==2) return false;

	switch (iMonth)
	{
		case 1:
			if((tmpInt<1)|(tmpInt>31)) return false;
			break;
		case 3:
			if((tmpInt<1)|(tmpInt>31)) return false;
			break;
		case 5:
			if((tmpInt<1)|(tmpInt>31)) return false;
			break;
		case 7:
			if((tmpInt<1)|(tmpInt>31)) return false;
			break;
		case 8:
			if((tmpInt<1)|(tmpInt>31)) return false;
			break;
		case 10:
			if((tmpInt<1)|(tmpInt>31)) return false;
			break;
		case 12:
			if((tmpInt<1)|(tmpInt>31)) return false;
			break;
		case 4:
			if((tmpInt<1)|(tmpInt>30)) return false;
			break;
		case 6:
			if((tmpInt<1)|(tmpInt>30)) return false;
			break;
		case 9:
			if((tmpInt<1)|(tmpInt>30)) return false;
			break;
		case 11:
			if((tmpInt<1)|(tmpInt>30)) return false;
			break;
		case 2:
			if((iYear%4)==0) //闰年
				if((tmpInt<1)|(tmpInt>29)) return false;
			else
				if((tmpInt<1)|(tmpInt>28)) return false;
			break;
		default:
			return false;
	}
	return true;
}
//去除左右空格
function trim(Str)
{
	var tmpStr;
	tmpStr=Str;
	
	while((tmpStr.length>0)&&(tmpStr.substr(0,1)==' '))
		tmpStr=tmpStr.substr(1,tmpStr.length-1);
		
	while((tmpStr.length>0)&&(tmpStr.substr(tmpStr.length-1,1)==' '))
		tmpStr=tmpStr.substr(0,tmpStr.length-1);
	
	return tmpStr;
}

//判断是否是整数
function checkInt(str)
{
	for (var i = 0; i < str.length; i++)
	{
		isNumber = 0;
		for (var j=0; j<10; j++) if ("" + j == str.charAt(i)) isNumber = 1;
		
		if (isNumber == 0) {
			return false;
		}
	}
	return true;
}

//判断是否是数字类型
function checkNumeric(numch)
{
	nr1=numch;
	flg=0;//计数
	str="";
	spc=""
	arw="";
	for (var i=0;i<nr1.length;i++)
	{
		cmp="0123456789."
		tst=nr1.substring(i,i+1)
	if (cmp.indexOf(tst)<0)
		{
			flg++;
			str+=" "+tst;
			spc+=tst;
			arw+="^";
		}
	else{arw+="_";}
	}
	if (flg!=0)
	{
		if (spc.indexOf(" ")>-1) 
		{
		str+="和空格";
		}
		return false;
	}
}
//判断是否是email
function checkEmail(email)
{
	var filter=/^.+@.+\..{2,3}$/;
	if(email!="")
	{
		if (filter.test(email)) 
			{
				return true;
			}
		else
			{
				return false;
			}
	}
	return true;
}