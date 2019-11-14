function Validate(){
    this.number = /^\d+$/;
    this.integer = /^[-\+]?\d+$/;
    this.double = /^[-\+]?\d+(\.\d+)?$/;
    this.phone = /^((\(\d{3}\))|(\d{3}\-))?(\(0\d{2,3}\)|0\d{2,3}-)?[1-9]\d{6,7}$/;
// （前三位为数字带括号|三位数字-）最多有一个  （0 数字两到三个|0 数字两到三个-）最多现一次 
//     1-9为开头 数字六到七位         这是一个完整的固定电话号码验证          // --
    this.mobile = /^((\(\d{3}\))|(\d{3}\-))?13\d{9}$/;
    this.email = /^\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*$/;  // \w 为数字、字母、下划线         --
    this.qq = /^[1-9]\d{4,8}$/;
    this.idCard = /^\d{15}(\d{2}[A-Za-z0-9])?$/;
    this.english = /^[A-Za-z]+$/;
    this.chinese = /^[\u0391-\uFFE5]+$/;  //汉字在U码中的取值范围 --
    this.date = /^\d{4}-[01]\d{1}-([0-2]\d{1}|31)$/;
    this.url=/^http:\/\/[A-Za-z0-9]+\.[A-Za-z0-9]+[\/=\?%\-&_~`@[\]\':+!]*([^<>\"\"])*$/;
}
Validate.prototype.test=function(reg,str){
    if(reg.test(str)){
        return true;
    }
    return false;
}

Validate.prototype.isEmpty=function(str){
    if(str=="" || str==null){
        return true;
    }
    return false;
}

Validate.prototype.isNumber=function(str){
    return this.test(this.number,str);
}

Validate.prototype.isInteger=function(str){
    return this.test(this.integer,str);
}

Validate.prototype.isDouble=function(str){
    return this.test(this.double,str);
}

Validate.prototype.isPhone=function(str){
    return this.test(this.phone,str);
}

Validate.prototype.isMobile=function(str){
    return this.test(this.mobile,str);
}

Validate.prototype.isEmail=function(str){
    return this.test(this.email,str);
}

Validate.prototype.isQQ=function(str){
    return this.test(this.qq,str);
}

Validate.prototype.isIdCard=function(str){
    return this.test(this.idCard,str);
}

Validate.prototype.isEnglish=function(str){
    return this.test(this.englist,str);
}

Validate.prototype.isChinese=function(str){
    return this.test(this.chinese,str);
}

Validate.prototype.isDate=function(str){
    return this.test(this.date,str);
}

Validate.prototype.isUrl=function(str){
    return this.test(this.url,str);
}