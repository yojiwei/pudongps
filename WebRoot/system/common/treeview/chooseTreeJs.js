<!--
///////////////////////////////////////////////
//通用弹出式树选择
function chooseTree(srcElement,srcFormName)
{
    if (typeof(srcFormName) == "undefined" || srcFormName == "")
    {
       var formName = "formData";
    }else{
       var formName = srcFormName;
    }
    if (typeof(srcElement) == "undefined" || srcElement == "")
    {
       var formId = event.srcElement.name;
    }else{
       var formId = srcElement;
    }
    try
    {
      eval("var curElement = " + formName + "." + formId);
      eval("var dirIdsElement  = " + formName + "." + formId + "DirIds");
      eval("var fileIdsElement = " + formName + "." + formId + "FileIds");
    }catch(e){
      alert("您指定的参数不对！\n点击确定返回！");
      return;
    }
    var tree = new CTree();

    setTreePara(tree,curElement,dirIdsElement,fileIdsElement);
    if (tree.treeType == "") {alert("请您指定树类型！");return;}
    var r = tree.open();
    if (r)
    {
       curElement.value = r.content;
       dirIdsElement.value  = r.dirIds;
       fileIdsElement.value = r.fileIds;
       return true;
    }else{
       return false;
    }
}

function wt(o){
	try{
		var http = new ActiveXObject("Microsoft.XMLHTTP");
		var str;
		innerST("<img valign='absmiddle' src='../images/dialog/loading.gif'> 数据载入中，请稍候...");
		http.onreadystatechange = function (){
			if (http.readyState==4)	{
				str = http.responseText;
				while(str.indexOf("\n")!=-1||str.indexOf("\r")!=-1)
				{str = str.replace("\n","");str = str.replace("\r","");}
				outPut(o,str.split(","));			
				innerST("栏目信息已修改，请及时保存！[ <a href='' onclick='resSN();return false;'>还原</a> ]");
				http.abort();
			}
		};
		url="/system/common/treeview/getSubject.jsp?st="+o;
		http.open("GET",url,true);
		http.send();
	}catch(e){
		//nothing
	}
}

function resSN(){
	sid = toArray(ORIGINAL_SID,",");
	innerST("请点击添加所属栏目！");
	outPut(sid,sname);
}

function innerST(s){
	document.all.signText.innerHTML = s;
}

function outPut(i,n){
	document.all.testname.innerHTML = n.toStringFormat(true,"；");
	document.all.ModuleDirIds.value = i.join();
	document.all.Module.value = n.join();
}

function chooseTree_new(srcElement,srcFormName)
{
    if (typeof(srcFormName) == "undefined" || srcFormName == "")
    {
       var formName = "formData";
    }else{
       var formName = srcFormName;
    }
    if (typeof(srcElement) == "undefined" || srcElement == "")
    {
       var formId = event.srcElement.name;
    }else{
       var formId = srcElement;
    }
    try
    {
      eval("var curElement = " + formName + "." + formId);
      eval("var dirIdsElement  = " + formName + "." + formId + "DirIds");
      eval("var fileIdsElement = " + formName + "." + formId + "FileIds");
    }catch(e){
      alert("您指定的参数不对！\n点击确定返回！");
      return;
    }
    var tree = new CTree();

    setTreePara(tree,curElement,dirIdsElement,fileIdsElement);
    if (tree.treeType == "") {alert("请您指定树类型！");return;}
    var r = tree.open();
    if (r)
    {
		var rv2 = toArray(r.dirIds,",");
		for(var i=0; i<rv2.length; i++){
			var _sid = ","+sid.join()+",";
			if(rv2[i]!=""&&_sid.indexOf(","+rv2[i]+",")==-1){
				sid.push(rv2[i]);
			}
		}
		try{
			wt(sid);
		}catch(e){
			alert("您的浏览器不支持！\n点击确定返回！");
			return false;
		}
       return true;
    }else{
       return false;
    }
}

function deleteSN(t){
	//alert(t);
	if(confirm("确认删除？")){
		for(i=0; i<sid.length; i++){
			if(sid[i]==t) sid.remove(i);
		}
		try{
			wt(sid);
		}catch(e){
			alert("您的浏览器不支持！\n点击确定返回！");
			return false;
		}
		//outPut(sid,sname);
		//document.all.testname.innerHTML = sname.toStringFormat(true,"；");
	}
}

Array.prototype.toStringFormat = function(b,s){
	var c = "";
	if(this!="undefined"){
		if(this.length!="undefined"){
			for(i=0; i<this.length; i++){
				if(this[i]!=""){
					c = c + "<span><nobr>" + this[i];
					if(b==true) c = c + " <span style=color:red;cursor:hand onclick=\"deleteSN('"+sid[i]+"')\"><b>×</b></span>";
					c = c + s + "</nobr></span>";
				}
			}
		}else{
			if(this!=""){
				c = c + "<span>" + this;
				if(b==true) c = c + " <span style=color:red;cursor:hand onclick=\"deleteSN('"+sid[0]+"')\"><b>×</b></span>";
				c = c + s + "</span>";
			}
		}
	}
	return c;
}

Array.prototype.remove = function(dx){
	if(isNaN(dx)||dx>this.length){return false;}
	for(var i=0,n=0; i<this.length;i++){
		if(this[i]!=this[dx]){
			this[n++] = this[i];
		}
	}
	this.length-=1;
}

function toArray(s,sn){
	return s.split(sn);
}

function setTreePara(tree,curElement,dirIdsElement,fileIdsElement)
{
    tree.content = curElement.value;
    tree.initDirIds = dirIdsElement.value;
    tree.initFileIds = fileIdsElement.value;

    if (typeof(curElement.treeType) != "undefined") tree.treeType = curElement.treeType;
    if (typeof(curElement.parentId) != "undefined") tree.parentId = curElement.parentId;

    if (typeof(curElement.treeTitle) != "undefined") tree.treeTitle = curElement.treeTitle;
    if (typeof(curElement.initFileIds) != "undefined") tree.initFileIds = curElement.initFileIds;
    if (typeof(curElement.initDirIds) != "undefined") tree.initDirIds = curElement.initDirIds;
    if (typeof(curElement.filterDirIds) != "undefined") tree.filterDirIds = curElement.filterDirIds;
    if (typeof(curElement.filterFileIds) != "undefined") tree.filterFileIds = curElement.filterFileIds;

    if (typeof(curElement.isSupportFile) != "undefined") tree.isSupportFile = curElement.isSupportFile;
    if (typeof(curElement.isSupportDirSelect) != "undefined") tree.isSupportDirSelect = curElement.isSupportDirSelect;
    if (typeof(curElement.isSupportMultiSelect) != "undefined") tree.isSupportMultiSelect = curElement.isSupportMultiSelect;
    if (typeof(curElement.isSupportContentInput) != "undefined") tree.isSupportContentInput = curElement.isSupportContentInput;
}

function CTree()
{
        this.treeType  = "" ; //类型
        this.parentId = 0 ; //上级目录id

        this.content = "" ;//选择+输入的中文信息
        this.treeTitle   = "" ; //弹出窗口的标题
        this.initFileIds = "" ; //初始化目录IDs
        this.initDirIds = "" ; //初始化文件IDS
        this.filterDirIds = "" ;
        this.filterFileIds = "" ;

        this.isSupportFile    = 0 ; //是否列出数据
        this.isSupportDirSelect = 1 ; //目录下无数据时是否可选
        this.isSupportMultiSelect = 0 ;//支持多选
        this.isSupportContentInput  = 0 ; //是否支持用户手工输入
        this.open    = openTree ;
}

function openTree()
{
        var param  = "treeType="+this.treeType+ "&isSupportFile="+this.isSupportFile+"&parentId="+this.parentId+ "&filterDirIds="+this.filterDirIds+ "&filterFileIds="+this.filterFileIds;
        //alert(param)
        var retVal = window.showModalDialog( "/system/common/treeview/chooseTree.jsp?"+param,
                this, "dialogWidth=280px; dialogHeight=460px; help=no; status=no; scroll=no; resizable=yes; " );
        //window.open("/system/common/treeview/chooseTree.jsp?"+param);return;
        if ( typeof(retVal) != "undefined" ) {
                var sep1 = '\x01' ;
                var objRetVal = new Object ;
                var aL = retVal.split(sep1) ;
                //for (i in aL) {
				for(var i=0; i<aL.length; i++){
                        var aL1 = aL[i].split("=") ;
                        objRetVal[aL1[0]] = aL1[1] ;
                }
                return(objRetVal);
        }
        return false;
}

-->