/*********************************************************************************
*    FUNCTION:        isInt
*    PARAMETER:        theStr    AS String 
*    RETURNS:        TRUE if the passed parameter is an integer, otherwise FALSE
*    CALLS:            isDigit
**********************************************************************************/
function isInt (theStr) {
    var flag = true;

    if (isEmpty(theStr)) { flag=false; }
    else
    {    for (var i=0; i<theStr.length; i++) {
            if (isDigit(theStr.substring(i,i+1)) == false) {
                flag = false; break;
            }
        }
    }
    return(flag);
}
/*********************************************************************************
*    FUNCTION:        isBetween
*    PARAMETERS:        val        AS any value
*                    lo        AS Lower limit to check
*                    hi        AS Higher limit to check
*    CALLS:            NOTHING
*    RETURNS:        TRUE if val is between lo and hi both inclusive, otherwise false.
**********************************************************************************/
function isBetween (val, lo, hi) {
    if ((val < lo) || (val > hi)) { return(false); }
    else { return(true); }
}

/*********************************************************************************
*    FUNCTION:        isDate checks a valid date
*    PARAMETERS:        theStr        AS String
*    CALLS:            isBetween, isInt
*    RETURNS:        TRUE if theStr is a valid date otherwise false.
**********************************************************************************/
function isDate (theStr) {
    var the1st = theStr.indexOf('-');
    var the2nd = theStr.lastIndexOf('-');
    
    if (the1st == the2nd) { return(false); }
    else {
        var y = theStr.substring(0,the1st);
        var m = theStr.substring(the1st+1,the2nd);
        var d = theStr.substring(the2nd+1,theStr.length);
        var maxDays = 31;
        
        if (isInt(m)==false || isInt(d)==false || isInt(y)==false) {
            return(false); }
        else if (y.length < 4) { return(false); }
        else if (!isBetween (m, 1, 12)) { return(false); }
        else if (m==4 || m==6 || m==9 || m==11) maxDays = 30;
        else if (m==2) {
            if (y % 4 > 0) maxDays = 28;
            else if (y % 100 == 0 && y % 400 > 0) maxDays = 28;
               else maxDays = 29;
        }
        if (isBetween(d, 1, maxDays) == false) { return(false); }
        else { return(true); }
    }
}
/*********************************************************************************
*    FUNCTION:        isEuDate checks a valid date in British format
*    PARAMETERS:        theStr        AS String
*    CALLS:            isBetween, isInt
*    RETURNS:        TRUE if theStr is a valid date otherwise false.
**********************************************************************************/
function isEuDate (theStr) {
    if (isBetween(theStr.length, 8, 10) == false) { return(false); }
    else {
        var the1st = theStr.indexOf('/');
        var the2nd = theStr.lastIndexOf('/');
        
        if (the1st == the2nd) { return(false); }
        else {
            var m = theStr.substring(the1st+1,the2nd);
            var d = theStr.substring(0,the1st);
            var y = theStr.substring(the2nd+1,theStr.length);
            var maxDays = 31;

            if (isInt(m)==false || isInt(d)==false || isInt(y)==false) {
                return(false); }
            else if (y.length < 4) { return(false); }
            else if (isBetween (m, 1, 12) == false) { return(false); }
            else if (m==4 || m==6 || m==9 || m==11) maxDays = 30;
            else if (m==2) {
                if (y % 4 > 0) maxDays = 28;
                else if (y % 100 == 0 && y % 400 > 0) maxDays = 28;
                else maxDays = 29;
            }
            
            if (isBetween(d, 1, maxDays) == false) { return(false); }
            else { return(true); }
        }
    }
    
}
/********************************************************************************
*   FUNCTION:       Compare Date! Which is the latest!
*   PARAMETERS:     lessDate,moreDate AS String
*   CALLS:          isDate,isBetween
*   RETURNS:        TRUE if lessDate<moreDate
*********************************************************************************/
function isComdate (lessDate , moreDate)
{
    if (!isDate(lessDate)) { return(false);}
    if (!isDate(moreDate)) { return(false);}
    var less1st = lessDate.indexOf('-');
    var less2nd = lessDate.lastIndexOf('-');
    var more1st = moreDate.indexOf('-');
    var more2nd = moreDate.lastIndexOf('-');
    var lessy = lessDate.substring(0,less1st);
    var lessm = lessDate.substring(less1st+1,less2nd);
    var lessd = lessDate.substring(less2nd+1,lessDate.length);
    var morey = moreDate.substring(0,more1st);
    var morem = moreDate.substring(more1st+1,more2nd);
    var mored = moreDate.substring(more2nd+1,moreDate.length);
    var Date1 = new Date(lessy,lessm,lessd); 
    var Date2 = new Date(morey,morem,mored); 
    if (Date1>Date2) { return(false);}
     return(true); 
        
}

/*********************************************************************************
*    FUNCTION    isEmpty checks if the parameter is empty or null
*    PARAMETER    str        AS String
**********************************************************************************/
function isEmpty (str) {
    if ((str==null)||(str.length==0)) return true;
    else return(false);
}

/*********************************************************************************
*    FUNCTION:        isReal
*    PARAMETER:    heStr    AS String 
                        decLen    AS Integer (how many digits after period)
*    RETURNS:        TRUE if theStr is a float, otherwise FALSE
*    CALLS:            isInt
**********************************************************************************/
function isReal (theStr, decLen) {
    var dot1st = theStr.indexOf('.');
    var dot2nd = theStr.lastIndexOf('.');
    var OK = true;
    
    if (isEmpty(theStr)) return false;

    if (dot1st == -1) {
        if (!isInt(theStr)) return(false);
        else return(true);
    }
    
    else if (dot1st != dot2nd) return (false);
    else if (dot1st==0) return (false);
    else {
        var intPart = theStr.substring(0, dot1st);
        var decPart = theStr.substring(dot2nd+1);

        if (decPart.length > decLen) return(false);
        else if (!isInt(intPart) || !isInt(decPart)) return (false);
        else if (isEmpty(decPart)) return (false);
        else return(true);
    }
}

/*********************************************************************************
*    FUNCTION:        isEmail
*    PARAMETER:        String (Email Address)
*    RETURNS:        TRUE if the String is a valid Email address
*                    FALSE if the passed string is not a valid Email Address
*    EMAIL FORMAT:    AnyName@EmailServer e.g; webmaster@hotmail.com
*                    @ sign can appear only once in the email address.
*********************************************************************************/
function isEmail (theStr) {
    var atIndex = theStr.indexOf('@');
    var dotIndex = theStr.indexOf('.', atIndex);
    var flag = true;
    theSub = theStr.substring(0, dotIndex+1)

    if ((atIndex < 1)||(atIndex != theStr.lastIndexOf('@'))||(dotIndex < atIndex + 2)||(theStr.length <= theSub.length)) 
    {    return(false); }
    else { return(true); }
}
/*********************************************************************************
*    FUNCTION:        newWindow
*    PARAMETERS:        doc         ->    Document to open in the new window
                    hite     ->    Height of the new window
                    wide     ->    Width of the new window
                    bars    ->    1-Scroll bars = YES 0-Scroll Bars = NO
                    resize     ->    1-Resizable = YES 0-Resizable = NO
*    CALLS:            NONE
*    RETURNS:        New window instance
**********************************************************************************/
function newWindow (doc, hite, wide, bars, resize) {
    var winNew="_blank";
    var opt="toolbar=0,location=0,directories=0,status=0,menubar=0,";
    opt+=("scrollbars="+bars+",");
    opt+=("resizable="+resize+",");
    opt+=("width="+wide+",");
    opt+=("height="+hite);
    winHandle=window.open(doc,winNew,opt);
    return;
}
/*********************************************************************************
*    FUNCTION:        DecimalFormat
*    PARAMETERS:        paramValue -> Field value
*    CALLS:                NONE
*    RETURNS:        Formated string
**********************************************************************************/
function DecimalFormat (paramValue) {
    var intPart = parseInt(paramValue);
    var decPart =parseFloat(paramValue) - intPart;

    str = "";
    if ((decPart == 0) || (decPart == null)) str += (intPart + ".00");
    else str += (intPart + decPart);
    
    return (str);
}


/*********************************************************************************
*    EO_JSLib.js
*   javascript正则表达式检验
**********************************************************************************/


//校验是否全由数字组成
function isDigit(s)
{
    var patrn=/^[0-9]{1,20}$/;
    if (!patrn.exec(s)) return false
    return true
}

//校验登录名：只能输入5-20个以字母开头、可带数字、“_”、“.”的字串
function isRegisterUserName(s)
{
    var patrn=/^[a-zA-Z]{1}([a-zA-Z0-9]|[._]){4,19}$/;
    if (!patrn.exec(s)) return false
    return true
}

//校验用户姓名：只能输入1-30个以字母开头的字串
function isTrueName(s)
{
    var patrn=/^[a-zA-Z]{1,30}$/;
    if (!patrn.exec(s)) return false
    return true
}

//校验密码：只能输入6-20个字母、数字、下划线
function isPasswd(s)
{
    var patrn=/^(\w){6,20}$/;
    if (!patrn.exec(s)) return false
    return true
}

//校验普通电话、传真号码：可以“+”开头，除数字外，可含有“-”
function isTel(s)
{
    //var patrn=/^[+]{0,1}(\d){1,3}[ ]?([-]?(\d){1,12})+$/;
    var patrn=/^[+]{0,1}(\d){1,3}[ ]?([-]?((\d)|[ ]){1,12})+$/;
    if (!patrn.exec(s)) return false
    return true
}

//校验手机号码：必须以数字开头，除数字外，可含有“-”
function isMobil(s)
{
    var patrn=/^[+]{0,1}(\d){1,3}[ ]?([-]?((\d)|[ ]){1,12})+$/;
    if (!patrn.exec(s)) return false
    return true
}

//校验邮政编码
function isPostalCode(s)
{
    //var patrn=/^[a-zA-Z0-9]{3,12}$/;
    var patrn=/^[a-zA-Z0-9 ]{3,12}$/;
    if (!patrn.exec(s)) return false
    return true
}

//校验搜索关键字
function isSearch(s)
{
    //var patrn=/^[^`~!@#$%^&*()+=|\\\][\]\{\}:;\'\,.<>/?]{1}[^`~!@$%^&()+=|\\\][\]\{\}:;\'\,.<>?]{0,19}$/;
    //if (!patrn.exec(s)) return false
    return true
}

function isIP(s)  //by zergling
{
    var patrn=/^[0-9.]{1,20}$/;
    if (!patrn.exec(s)) return false
    return true
}

function need_input(sForm)//通用文本域校验 by l_dragon
{

    for(i=0;i<sForm.length;i++)
    {  
   
    if(sForm[i].tagName.toUpperCase()=="INPUT" &&sForm[i].type.toUpperCase()=="TEXT" && (sForm[i].title!=""))
    
         if(sForm[i].value=="")//
         {
         sWarn=sForm[i].title+"不能为空!";
         alert(sWarn);
         sForm[i].focus();
         return false;
        }
   }
return true;
}

//登陆时记住当前页面url，便于将来返回该页面
function loginToPage()
{
	var formObj = document.getElementById("formData");
	if(typeof(formObj)=="undefined")
	{
		formObj = document.createElement("formData");
		document.appendChild(formObj);
	}
	var inputObj = document.getElementById("_url");
	if(typeof(inputObj)=="undefined")
	{
		inputObj = document.createElement("input");
		inputObj.id = "_url";
		inputObj.type = "hidden";
		var url = window.location.href;
		inputObj.value = url;
		formObj.appendChild(inputObj);
	}
	else
	{
		var url = window.location.href;
		inputObj.value = url;
	}
	var obj = formData._url;
	alert(obj.value);
}



function showCal(obj)
{
 if (!obj) var obj = event.srcElement;
 var obDate;
 if ( obj.value == "" ) {
   obDate = new Date();
 } else {
   var obList = obj.value.split( "-" );
   obDate = new Date( obList[0], obList[1]-1, obList[2] );
 }

 var retVal = showModalDialog( "/system/common/calendar/calendar.htm", obDate,
							   "dialogWidth=206px; dialogHeight=206px; help=no; scroll=no; status=no; " );

 if ( typeof(retVal) != "undefined" ) {
   var year = retVal.getFullYear();
   var month = retVal.getMonth()+1;
   var day = retVal.getDate();
   obj.value =year + "-" + month + "-" + day;
 }
}