<%@ page contentType="text/html; charset=GBK" %>
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

function setTreePara(tree,curElement,dirIdsElement,fileIdsElement)
{
    tree.content = curElement.value;
    if(dirIdsElement) tree.initDirIds = dirIdsElement.value;
    if(fileIdsElement) tree.initFileIds = fileIdsElement.value;

    if (typeof(curElement.treeType) != "undefined") tree.treeType = curElement.treeType;
    if (typeof(curElement.treeFunctionType) != "undefined") tree.treeFunctionType = curElement.treeFunctionType;
    if (typeof(curElement.treeParaValue) != "undefined") tree.treeParaValue = curElement.treeParaValue;
    if (typeof(curElement.treeAccessType) != "undefined") tree.treeAccessType = curElement.treeAccessType;
    if (typeof(curElement.treeModuleType) != "undefined") tree.treeModuleType = curElement.treeModuleType;
    if (typeof(curElement.treeOwner) != "undefined") tree.treeOwner = curElement.treeOwner;

    if (typeof(curElement.treefilter) != "undefined") tree.treefilter = curElement.treefilter;
    if (typeof(curElement.treeTitle) != "undefined") tree.treeTitle = curElement.treeTitle;
    if (typeof(curElement.initFileIds) != "undefined") tree.initFileIds = curElement.initFileIds;
    if (typeof(curElement.initDirIds) != "undefined") tree.initDirIds = curElement.initDirIds;
    if (typeof(curElement.filterDirIds) != "undefined") tree.filterDirIds = curElement.filterDirIds;
    if (typeof(curElement.filterFileIds) != "undefined") tree.filterFileIds = curElement.filterFileIds;

    if (typeof(curElement.isSupportFile) != "undefined") tree.isSupportFile = curElement.isSupportFile;
    if (typeof(curElement.isSupportDirSelect) != "undefined") tree.isSupportDirSelect = curElement.isSupportDirSelect;
    if (typeof(curElement.isSupportMultiSelect) != "undefined") tree.isSupportMultiSelect = curElement.isSupportMultiSelect;
    if (typeof(curElement.isSupportContentInput) != "undefined") tree.isSupportContentInput = curElement.isSupportContentInput;
    if (typeof(curElement.isSupportAccess) != "undefined") tree.isSupportAccess = curElement.isSupportAccess;
}

function CTree()
{
        this.treeType  = "Dept" ; //类型
        this.treeFunctionType  = "byParentID" ; //"byParentID","byCurID","byInfo"
        this.treeParaValue = "0" ; //参数值

        /**
         * CManager: ORGACCESS = 0; MODULEACCESS = 1; ROLEACCESS = 2;METAACCESS = 3;
         * CLoginUser: MANAGE = 1; AUDIT  = 2;EDIT   = 3;BROWSER= 4;
         */
        this.treeAccessType = "0";
        this.treeModuleType = ""; //模块类型
        this.treeOwner = ""; //树的拥有者


        this.content = "" ;//选择+输入的中文信息
        this.treeTitle   = "" ; //弹出窗口的标题
        this.initFileIds = "" ; //初始化目录IDs
        this.initDirIds = "" ; //初始化文件IDS
        this.filterDirIds = "" ;
        this.filterFileIds = "" ;
        this.treefilter="";

        this.isSupportFile    = 0 ; //是否列出数据
        this.isSupportDirSelect = 0 ; //目录下无数据时是否可选
        this.isSupportMultiSelect = 0 ;//支持多选
        this.isSupportContentInput  = 0 ; //是否支持用户手工输入
        this.isSupportAccess = 1; //1:支持权限判断 0:不支持权限判断
        this.open    = openTree ;
}

function openTree()
{
        var param  = "treeType="+this.treeType+ "&isSupportFile="+this.isSupportFile+"&filterDirIds="+this.filterDirIds+ "&filterFileIds="+this.filterFileIds;
        param += "&treeFunctionType="+this.treeFunctionType+"&treeParaValue="+this.treeParaValue+"&treeAccessType="+this.treeAccessType+"&treeModuleType="+this.treeModuleType
        param += "&treeOwner=" + this.treeOwner;
        param += "&isSupportAccess=" + this.isSupportAccess;
        param += "&isSupportContentInput=" + this.isSupportContentInput;
        param += "&treefilter=" + this.treefilter;
        //param += "&isSupportMultiSelect=" + this.isSupportMultiSelect;
        //alert(param)
        var retVal = window.showModalDialog( "publish/chooseTree.jsp?"+param,
                this, "dialogWidth=280px; dialogHeight=460px; help=no; status=no; scroll=no; resizable=yes; " );
        //window.open("chooseTree.jsp?"+param);return;
        if ( typeof(retVal) != "undefined" ) {
                var sep1 = ';' ;
                var objRetVal = new Object ;
                var aL = retVal.split(sep1) ;
                for (i in aL) {
                        var aL1 = aL[i].split("=") ;
                        objRetVal[aL1[0]] = aL1[1] ;
                }
                return(objRetVal);
        }
        return false;
}

-->
