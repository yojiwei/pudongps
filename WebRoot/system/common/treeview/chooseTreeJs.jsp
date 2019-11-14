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
                for (i in aL) {
                        var aL1 = aL[i].split("=") ;
                        objRetVal[aL1[0]] = aL1[1] ;
                }
                return(objRetVal);
        }
        return false;
}

-->