<!--
//定义变量
var html = "";
var i ;

////////////////////////////////////////////////////
//定义图形变量
var img_plus_first = "/system/common/treeview/images/img_plus_first.gif" //第一个节点
var img_minus_first = "/system/common/treeview/images/img_minus_first.gif";

var img_plus = "/system/common/treeview/images/plus.gif" ;//图形＋
var img_plus_end = "/system/common/treeview/images/img_plus_end.gif"; //未展开的最后一个节点

var img_minus = "/system/common/treeview/images/minus.gif" ;//图形－
var img_node = "/system/common/treeview/images/node.gif" ;//图形|-
var img_end = "/system/common/treeview/images/end.gif" ;//图形|_
var img_minus_end = "/system/common/treeview/images/img_minus_end.gif" //有子节点，最后一个节点
var img_null = "/system/common/treeview/images/null.gif";


var img_back = "/system/common/treeview/images/back.gif" ;//背景图形|(一条线）
var img_hide = "" ; //打开时的图片
var img_hide = "" ; //并合时的图片
var show_imgs = new Array() ;
var hide_imgs = new Array() ;
var node_select = "#C0C0C0" ; //选中节点要显示的背景色
var node_no_select = "#ffffff" ; //未选中节点要显示的背景色

var img_show = "/system/common/treeview/images/img_show.gif"; //目录
var img_hide = "/system/common/treeview/images/img_hide.gif"; //目录
var img_file_hide = new Array();
img_file_hide[0] = "/system/common/treeview/images/img_file_0.gif"; //文件
img_file_hide[1] = "/system/common/treeview/images/img_file_1.gif"; //文件
img_file_hide[2] = "/system/common/treeview/images/img_file_2.gif"; //文件
img_file_hide[3] = "/system/common/treeview/images/img_file_3.gif"; //文件
img_file_hide[4] = "/system/common/treeview/images/img_file_4.gif"; //文件

//var img_file_hide = "/system/common/treeview/images/img_file_hide.gif"; //文件

var img_hide_first = "/system/common/treeview/images/img_hide_first.gif";
var img_show_first = "/system/common/treeview/images/img_hide_first.gif";

var img_selected = "/system/common/treeview/images/choossed.gif"; //选定的图

///////////////////////////////////////////////////
//
var se = "" ; //排序数
var curlen = 0; //上一节点sequence的长度
var prelen = 0; //本节点sequence的长度
var menu_id = "" ; //子节点TR的ID
var img_id = "" ; //本节点的IMG的ID
//var target = " target=_blank " ;
var target = "" ;
var history_id = "" ;

var init_nodeFlag = "";
var isSupportMultiSelect = 0; //支持多选
var isSupportDirSelect = 1; //目录选择
var isSupportAutoSelect = 0; //支持自动选择子节点和父节点

var initDirIds = ""; //初如化目录IDS
var initFileIds = "";//初如化文件IDS
var waitString = "正在打开...";
var aNodeObj = new Object; //nodeObj["xx"].status: "undefined":未打开过 1:打开状态 0 : 关闭状态

var curNode = new aNode(); //加号对象
var oldNode = new aNode();

var curTxtNode = new aTxtNode();
var oldTxtNode = new aTxtNode();
var selectedDirIds = new Object();
var selectedFileIds = new Object();

function init()
{
        var num = 1;
        var nodeFlag = "1";
        var nodes = xmlDoc.XMLDocument.documentElement.selectNodes("item1");
        if (nodes)
        {
                                //初始化ＩＤｓ
                                if (initDirIds != "")
                                {
                                        var aIds = initDirIds.split(",");
                                        for (var i=0;i<aIds.length;i++)
                                        {
                                                //alert(aIds[i])
                                                selectedDirIds[aIds[i]] = 1;
                                        }
                                }
                                if (initFileIds != "")
                                {
                                        var aIds = initFileIds.split(",");
                                        for (var i=0;i<aIds.length;i++)
                                        {
                                                selectedFileIds[aIds[i]] = 1;
                                        }
                                }
                html += '      <table style="position:block;"  border=0 cellspacing=0 cellpadding=0 >'+"\r\n" ;
                for(var i=0;i<nodes.length;i++)
                {
                        var isFirst = (i==0)? true : false;
                        var isLast  = (i==nodes.length-1)? true : false;
                        html += getHTML(nodes(i),nodeFlag,num++,isLast,isFirst);
                }
                html +="</table>" ;
        }
        TreeRoot.outerHTML =  html;
        autoTurnit_node();
        initFirstNode();
}

//默认点击第一个节点
function initFirstNode()
{
   var firstNode = findNode("item1");
   if (firstNode)
   {
      var id = firstNode.getAttribute("id");
      turnit("1_1",id);
   }
}

//在单选时，若原有选定，则将为它初始一个对象
function autoTurnit_node()
{
try
{
   if (!isSupportMultiSelect)
   {
     if (init_nodeFlag != "")
     {
        if (initDirIds != ""){ isFile = 0;id=initDirIds;}
        if (initFileIds != ""){ isFile = 1;id = initFileIds;}
        turnit_node(init_nodeFlag,id,isFile);
        turnit_node(init_nodeFlag,id,isFile);
     }
     init_nodeFlag = "";
     //alert(init_nodeFlag)
   }
}catch(e)
{
//alert("err");
}
}

function getSelectedDirIds()
{
                var ids = "" ;
                for(key in selectedDirIds)
                {
                        if (selectedDirIds[key] == 1)
                        {
                                ids += "," + key;
                        }
                }
                if (ids != "")
                {
                        ids = ids.substring(1);
                }
                return ids;
}
function getSelectedFileIds()
{
                var ids = "" ;
                for(key in selectedFileIds)
                {
                        if (selectedFileIds[key] == 1)
                        {
                                ids += "," + key;
                        }
                }
                if (ids != "")
                {
                        ids = ids.substring(1);
                }
                return ids;
}
function getSelectedID()
{
                //alert(oldTxtNode);
                if (!curTxtNode.isEmpty())
                {
                        var id = curTxtNode.XMLNode.getAttribute("id");
                        return id;
                }
                return "";
}
function setSupportMultiSelect(t)
{
    isSupportMultiSelect = t;
}
function setInitDirIds(ids)
{
        initDirIds = ids;
}
function setInitFileIds(ids)
{
        initFileIds = ids;
}
function setSupportDirSelect(t)
{
        isSupportDirSelect = t;
}

function setSupportContentInput(t)
{
        document.all.demoDIV.style.display=(t=="true")?"":"none";
}

function setSupportAutoSelect(t)
{
        isSupportAutoSelect = t;
}
function clearTree()
{
        if (!curTxtNode.isEmpty())
        {
                curTxtNode.clear();
        }
        if (!oldTxtNode.isEmpty())
        {
                oldTxtNode.clear();
        }
        if (!isSupportMultiSelect)
        {
          initDirIds = "";
          initFileIds = "";
          for(key in selectedFileIds) selectedFileIds[key] = "";
          for(key in selectedDirIds) selectedDirIds[key] = "";
        }
        if (isSupportMultiSelect)
        {
            var nodes = xmlDoc.XMLDocument.documentElement.selectNodes("item1");
            if (nodes)
            {
                        for(var i=0;i<nodes.length;i++)
                        {
                                var nodeFlag = "1_"+(i+1);
                                eval("var obj = node" + nodeFlag);
                                curTxtNode = new aTxtNode();
                                curTxtNode.nodeFlag = nodeFlag;
                                curTxtNode.XMLNode = nodes(i);
                                curTxtNode.HTMLNode = obj;
                                curTxtNode.clear();
                                setSubNodesSelect(nodes(i),nodeFlag,false);
                        }
                }
	           ////////////////////////////////////
	          for(key in selectedDirIds) selectedDirIds[key] = "";
			  ///////////////////////////////////
        }
}
//
//node: xml的节点
//level: 第几层的表示法 例：第１层 1, 第１层下的第２层 1_2
//num: 第n层的第几个
//第１层下的第２层的第３个节点：完整的表示：　“menu1_2_3”
//相应的小图标的表示： “img1_2_3”
//上面的节点，他的未展开的节点的表示：　“menu1_2_3wait”

function getHTML(node,nodeFlag,num,isLast,isFirst)
{
        ///////////////////////////////////////////////////////
        //定义本节点TR
        var s = "";
        var imgHtml = "";
        var nodeFlag = nodeFlag+"_"+num;
        var menu_id = "menu"+nodeFlag;
        var img_id  = "img"+nodeFlag;
        var wait_id = "wait"+nodeFlag;
        var title_id = "title"+nodeFlag;
        var id      = node.getAttribute("id");
        var url     = node.getAttribute("url");
        var isFile  = node.getAttribute("isFile");
        var fileType = node.getAttribute("fileType"); //文件类型
        var hasChild = node.hasChildNodes();
        if (fileType == null) fileType = 0;

        //alert(isFile)
        url = url?url:"#";

                //如果是文件
                if(isFile == "1")
                {
                        var _action = "";
                        var _action2 = 'onclick=turnit_node("'+nodeFlag+'",'+ id + ',1)';
                        var tmpIds = "," + initFileIds + ",";
                }else{
                        var _action = 'style="cursor:hand" onmouseup=turnit("' + nodeFlag + '",' + id + ') ';
                        if (!isSupportDirSelect || isSupportDirSelect == 0) //不支持目录选择
                        {
                            var _action2 = 'onclick=turnit("' + nodeFlag + '",' + id + ') ';
                        }else{
                            var _action2 = 'onclick=turnit_node("'+nodeFlag+'",'+ id + ',0)';
                        }
                        var tmpIds = "," + initDirIds + ",";
                }

                //处理目录ＩＤｓ初始化
                if (tmpIds.indexOf(","+id+",") != -1) //默认选定
                {
                        imgHtml = '<img id="nodeImg'+nodeFlag + '" src=' + img_selected + ' valign=baseline align=absbottom border=0>';
                        node.setAttribute("initImg","yes");
                        init_nodeFlag = nodeFlag;
                }

        var title   = '<span id=txt'+nodeFlag+' >'+node.getAttribute("value")+'</span>'+ imgHtml;

        if (isFirst)
        {
                var img_plus_temp = img_plus_first;
                var img_hide_temp = img_hide_first;

        }else{
                                //如果是文件
                                if(isFile == "1")
                                {
                                        var img_plus_temp = img_node;
                                        var img_hide_temp = img_file_hide[fileType];

                                }else{
                                        var img_plus_temp = img_plus;
                                        var img_hide_temp = img_hide;
                                        if (!hasChild) img_plus_temp = img_node;
                                }
        }
        if (isLast)
        {
                var back_img = "";
                                //如果是文件
                                if(isFile == "1")
                                {
                                        var img_plus_temp = img_end;
                                }else{
                                        var img_plus_temp = img_plus_end;
                                        if (!hasChild) img_plus_temp = img_end;
                                }
        }else{
                var	back_img = "background=\"/system/common/treeview/images/back.gif\"";
        }

        aNodeObj[nodeFlag] = new aNodeInfo();
        aNodeObj[nodeFlag].img_hide = img_hide_temp;
        aNodeObj[nodeFlag].img_plus = img_plus_temp;

        //alert(back_img)
        var img_title = "<img id="+title_id+" border=0 src='"+img_hide_temp+"' width=16 height=16>" ;

        s += '<tr id="'+menu_id+'">'+"\r\n" ;
        if (!hasChild) _action = "";
        if (isFirst)
        {
                s += '  <td width="2%"  '+ _action + '  >'+"\r\n" ;
        }else{
                s += '  <td width="2%"  '+ _action + back_img + ' >'+"\r\n" ;
        }
        s += '    <img id="'+img_id+'" border="0" src="'+img_plus_temp+'"  >' ;
        s += '  </td>'+"\r\n" ;

        s += '  <td nowrap style="cursor:hand;" id="node' + nodeFlag + '"' + _action2 + '>'+img_title+"&nbsp;"+title ;
        s += '  </td>'+"\r\n" ;
        s += '</tr>'+"\r\n" ;


        //////////////////////////////////////////////////////
        //定义子节点TR头
        s += '<tr id="'+wait_id+"\" style=\"Display:'none'\">"+"\r\n" ;
        s += '  <td '+back_img+' ></td>'+"\r\n" ;
        s += '  <td valign=middle nowrap>'+waitString+"</td>"+"\r\n" ;
        s += '</tr>';
        return s ;
}

function turnit_node(nodeFlag,id,isFile)
{
       // alert(nodeFlag)
        var node = locateNode(nodeFlag,id,isFile);
        if (node)
        {
                        eval("var obj = node" + nodeFlag);
                        if(oldTxtNode.XMLNode == null) //第一次点击
                        {
                                if(!isSupportMultiSelect)
                                {
                                  clearTree();
                                }
                                curTxtNode.HTMLNode = obj;
                                curTxtNode.XMLNode = node;
                                curTxtNode.nodeFlag = nodeFlag;
                                //alert(nodeFlag);
                                //alert(curTxtNode)
                                curTxtNode.setColor();
                                oldTxtNode = curTxtNode;
                        }else{
                                oldTxtNode = curTxtNode;
                                if(oldTxtNode.nodeFlag == nodeFlag) //判断选中的是不是自已
                                {
                                }else{
                                        oldTxtNode.setColor();
                                        curTxtNode = new aTxtNode();


                                        curTxtNode.nodeFlag = nodeFlag;
                                        curTxtNode.XMLNode = node;
                                        curTxtNode.HTMLNode = obj;
                                        curTxtNode.setColor();
                                        //alert(oldTxtNode.nodeFlag)
                                        //alert(curTxtNode.nodeFlag)

                                }
                        }
                        if (curTxtNode.isSelected()) //原来是选定的
                        {
                                curTxtNode.unSelect();
                                var curSelected = false;
                        }else{
                                curTxtNode.select();
                                var curSelected = true;
                        }
                        if (isSupportMultiSelect) //多选
                        {
                                //处理子节点和父节点
                                if (isSupportAutoSelect)
                                {
                                        //处理子节点
                                        setSubNodesSelect(node,nodeFlag,curSelected);
                                        if (curSelected) setParentNodeSelect(node,nodeFlag);
                                }
                        }else{ //单选
                                if (oldTxtNode != curTxtNode)
                                {
                                        oldTxtNode.unSelect();
                                }
                        }
                        title_click(id,node.getAttribute("value"),node,curSelected);
        }
}
function setParentNodeSelect(node,nodeFlag)
{
        var aNode = node.parentNode;
        if (aNode)
        {
                if (aNode.tagName != "root")
                {
                        //alert(nodeFlag)
                        var l  = nodeFlag.lastIndexOf("_");
                        var id = aNode.getAttribute("id");
                        tmpNodeFlag = nodeFlag.substring(0,l);
                        eval("var obj = node" + tmpNodeFlag);
                        var tmpTxtNode = new aTxtNode();
                        tmpTxtNode.XMLNode = aNode;
                        tmpTxtNode.HTMLNode = obj;
                        tmpTxtNode.nodeFlag = tmpNodeFlag;
                        if (selectedDirIds[id] == 1)
                        {
                                var curSelected = true;
                        }else{
                                var curSelected = false;
                        }
                        if (!curSelected) tmpTxtNode.select();
                        setParentNodeSelect(aNode,tmpNodeFlag);
                }
        }

}
function setSubNodesSelect(node,nodeFlag,t)
{
        var nodes = node.childNodes;
        var tmpNodeFlag = "";
        for (var i=0;i<nodes.length;i++)
        {
                tmpNodeFlag = nodeFlag + "_" + (i+1);
                var id = nodes(i).getAttribute("id");
                var obj = getInitHTMLNode(tmpNodeFlag);

                if (obj != null) //打开过
                {
                        var tmpTxtNode = new aTxtNode();
                        tmpTxtNode.XMLNode = nodes(i);
                        tmpTxtNode.HTMLNode = obj;
                        tmpTxtNode.nodeFlag = tmpNodeFlag;
                        //alert(tmpNodeFlag)
                        if (tmpTxtNode.isFile())
                        {
                                if (selectedFileIds[id] == 1)
                                {
                                        var curSelected = true;
                                }else{
                                        var curSelected = false;
                                }
                        }else{
                                if (selectedDirIds[id] == 1)
                                {
                                        var curSelected = true;
                                }else{
                                        var curSelected = false;
                                }
                        }

                        if (t) //当前要选择
                        {
                                if (!curSelected) tmpTxtNode.select();
                        }else{
                                if (curSelected) tmpTxtNode.unSelect();
                        }
                }else{
                        if (nodes(i).getAttribute("isFile") == "1") //是文件
                        {
                                var tmpIds = "," + initFileIds + ",";
                                if (tmpIds.indexOf(","+id+",") == -1) //没有被选择
                                {
                                        var curSelected = true;
                                }else{
                                        var curSelected = false;
                                }
                                if (t) //当前要选择
                                {
                                        if(curSelected) initFileIds += "," + id;
                                        selectedFileIds[id] = 1
                                }else{
                                        if(!curSelected){
                                                initFileIds = clearOneId(initFileIds,id);
                                        }
                                        selectedFileIds[id] = 0
                                }
                        }else{
                                var tmpIds = "," + initDirIds + ",";
                                if (tmpIds.indexOf(","+id+",") == -1) //没有被选择
                                {
                                        var curSelected = true;
                                }else{
                                        var curSelected = false;
                                }
                                if (t) //当前要选择
                                {
                                        if(curSelected) initDirIds += "," + id;
                                        selectedDirIds[id] = 1
                                }else{
                                        if(!curSelected)
                                        {
                                                initDirIds = clearOneId(initDirIds,id);
                                        }
                                        selectedDirIds[id] = 0;
                                }
                        }
                }
                setSubNodesSelect(nodes(i),tmpNodeFlag,t);
        }
}
function clearOneId(ids,id)
{
        if (ids == "" || id == "" ) return "";
        eval("var re = /,"+id+",/;") ;
        ids = "," + ids + ",";
        ids = ids.replace(re,",");
        if (ids == ",")
        {
                return "";
        }else{
                //alert(ids);
                //alert(ids.substring(1));
                if (ids.substring(1,1) == ",") ids = ids.substring(2);
                if (ids.substring(ids.length,1) == ",") ids.substring(1,ids.length-1);
                //alert(ids.length)
        }
}
function getInitHTMLNode(nodeFlag)
{
        try
        {
                eval("var obj = node" + nodeFlag);
                return obj;
        }catch(e){
                return null;
        }
}
function turnit(nodeFlag,id,isSecondLevel)
{
        eval("var wait_id = wait"+nodeFlag);
        eval("var menu_id = menu"+nodeFlag);
        eval("var img_id  = img"+nodeFlag);
        eval("var title_id = title"+nodeFlag);

        //if (typeof(nodeObj[nodeFlag]) == "undefined")
        //alert(aNodeObj[nodeFlag].status)
        if(aNodeObj[nodeFlag].status == "undefined") //未初始化
        {
                initNode(nodeFlag,id,0);
                if(curNode.html == "")
                {
                }else{
                        wait_id.cells(1).innerHTML = curNode.html;
                        wait_id.style.display = "";
                        //nodeObj[nodeFlag] = 1;
                        aNodeObj[nodeFlag].status = 1;
                }
                var img = curNode.img();
                img_id.src = img;
                title_id.src = img_show;
                aNodeObj[nodeFlag].img_minus = img;
                aNodeObj[nodeFlag].img_show = img_show;
        }else{
                if (aNodeObj[nodeFlag].status == 1) //关闭
                {
                        wait_id.style.display = "none";
                        img_id.src = aNodeObj[nodeFlag].img_plus;
                        title_id.src = aNodeObj[nodeFlag].img_hide;
                        aNodeObj[nodeFlag].status = 0;

                }else{ //打开
                        wait_id.style.display = "";
                        aNodeObj[nodeFlag].status = 1;
                        img_id.src = aNodeObj[nodeFlag].img_minus;
                        title_id.src = aNodeObj[nodeFlag].img_show;
                }
        }
        autoTurnit_node();
       // if (typeof(isSecondLevel) == "undefined") turnItSecondLevel(nodeFlag,id,1);
        return;
}

function turnItSecondLevel(nodeFlag,id)
{
   var node = locateNode(nodeFlag,id);
   if(node)
   {
     if(node.hasChildNodes())
     {
        nodes = node.childNodes;
alert(nodes.length)
        for(var i=0;i<nodes.length;i++)
        {
           var aNode = nodes(i);
           var aNodeFlag = nodeFlag + "_" + (i+1);
           var id = aNode.getAttribute("id");
alert(aNodeFlag)
           turnit(aNodeFlag,id,1);
        }
     }
   }
}
function initNode(nodeFlag,id,isFile)
{
        var node = locateNode(nodeFlag,id,isFile);
        if (node){
                oldNode = curNode;
                curNode.clear();
                curNode.node = node;
                var num = 1;
                if (node.hasChildNodes())
                {
                        nodes = node.childNodes;
                        var s = '      <table border="0" width="100%" cellpadding="0" cellspacing="">'+"\r\n" ;
                        for(var i=0;i<nodes.length;i++)
                        {
                                var isLast  = (i==nodes.length-1)? true : false;
                                s += getHTML(nodes(i),nodeFlag,num++,isLast);
                        }
                        s +="</table>" ;
                        curNode.html = s;
                }
        }else{
                //alert("NULL")
        }
}
function locateNode(nodeFlag,id,isFile)
{
        var levels = nodeFlag.split("_");
        var level  = levels.length;
        var nodeName = "";
        var _x = "";
        for (var i=1;i<level;i++)
        {
                t = i>1 ? "/" : "";
                nodeName += t+"item"+i;
        }
        if (isFile == 1)
        {
            _x = " and @isFile=\"1\"";
        }else{
            _x = " and @isFile=\"0\"";
	}
        var xpath = nodeName+"[@id=\""+id+"\""+_x+"]";
        return findNode(xpath);
}
function findNode(xpath)
{
        //var node = xmlDoc.XMLDocument.documentElement.selectSingleNode("item1/item2[@id=\"9996\"]")
        var node = xmlDoc.XMLDocument.documentElement.selectSingleNode(xpath);
        return(node);
}
function aNodeInfo()
{
        this.status = "undefined";
        this.img_hide = "";
        this.img_show = "";
        this.img_plus = ""; //未展开的小图标
        this.img_minus = ""; //已展开的小图标
}
function aNode()
{
        this.html = "";
        this.isLastNode = getLastNode;
        this.isFirstNode = getFirstNode;
        this.node = null;
        this.img = getNodeImg;
        this.clear = clearaNode;
}
function aTxtNode()
{
                this.selectedColor = '#C0C0C0';
                this.status = 0; //默认未选定
                this.setColor = setColor;
                this.select = txtNodeSelected;
                this.unSelect = txtNodeNonSelected;
                this.isSelected = isTxtNodeSelected;
                this.isEmpty = isTxtNodeEmpty;
                this.isFile  = isTxtNodeFile;
		this.clear   = txtNodeClear;
                this.XMLNode = null;
                this.HTMLNode = null;
                this.nodeFlag = "";
}
function txtNodeClear()
{
                this.status = 1;
                this.setColor();
                this.status = 0;
                if (this.isSelected) this.unSelect();
                this.nodeFlag = "";
                this.XMLNode = null;
                this.HTMLNode = null;
}
function isTxtNodeSelected()
{
        if (this.XMLNode.getAttribute("initImg") == null)
        {
                return false;
        }else{
                return true;
        }
}
function isTxtNodeFile()
{
        var t = this.XMLNode.getAttribute("isFile");
        if (t == null) return false;
        if (t == "1") return true;
        else return false;
}
function isTxtNodeEmpty()
{
        return this.nodeFlag == "" ? 1 : 0;
}
function setColor()
{
                if (this.status == 0) //未选定
                {
                        var color = this.selectedColor;
                        this.status = 1;
                }else{
                        var color = '' ;
                        this.status = 0;
                }
                //alert(this.nodeFlag)
                eval("txt"+this.nodeFlag+".style.background = '" + color +"'");
}
function txtNodeSelected()
{
                var imgHtml = '<img id="nodeImg'+this.nodeFlag + '" src=' + img_selected + ' valign=baseline align=absbottom border=0>';
                this.HTMLNode.innerHTML += imgHtml ;
                this.XMLNode.setAttribute("initImg","yes");
                var id = this.XMLNode.getAttribute("id");
                if (!this.isFile())
                {
                        selectedDirIds[id] = 1;
                }else{
                        selectedFileIds[id] = 1;
                }
                //alert("txtNodeSelected");
}
function txtNodeNonSelected()
{
                //为了防止未选定的时候再次选择
                try
                {
                        eval("var img = nodeImg"+this.nodeFlag);
                        img.outerHTML = "";
                        this.XMLNode.removeAttribute("initImg");
                        var id = this.XMLNode.getAttribute("id");
                        if (!this.isFile())
                        {
                                selectedDirIds[id] = 0;
                        }else{
                                selectedFileIds[id] = 0;
                        }
                }catch(e){
                        //alert(this.HTMLNode.outerHTML);
                }
                //alert("txtNodeNonSelected");
}

function clearaNode()
{
        curNode.html = ""
        curNode.node = null;
}
function getNodeImg()
{
        var node = curNode.node;
        var img = "";
        if (node) //
        {
                if (curNode.isLastNode())
                {
                        //alert(curNode.html)
                        if (curNode.html == "") //有子节点，不是最后一个节点
                        {
                                img = img_end;
                        }else{
                                img = img_minus_end;
                        }
                }else{
                        if (curNode.html == "") //无子节点，不是最后一个节点
                        {
                                img = img_node;
                        }else{
                                img = img_minus;
                        }
                }
                if (curNode.isFirstNode()) //是第一个节点
                {
                        if (curNode.html == "") //无子节点，不是最后一个节点
                        {
                                img = img_null;
                        }else{
                                img = img_minus_first;
                        }
                }
                return img;
        }else{
                return img_node;
        }
}
function getLastNode()
{
        var node = curNode.node;

        if(node)
        {
                var lastNode = node.parentNode.lastChild;

                if (lastNode)
                {
                        if (node.getAttribute("id") == lastNode.getAttribute("id"))
                        {
                                return true;
                        }else{
                                return false;
                        }
                }else{ //第一层
                        return false;
                }
        }else{
                return false;
        }
}
function getFirstNode()
{
        if(curNode.node)
        {
                var firstNode = findNode("item1");
                if (firstNode)
                {
                        var node = curNode.node;
                        if (node.getAttribute("id") == firstNode.getAttribute("id"))
                        {
                                return true;
                        }else{
                                return false;
                        }
                }else{
                        return false;
                }
        }else{
                return false;
        }
}
-->