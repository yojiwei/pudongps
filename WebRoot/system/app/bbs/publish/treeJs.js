<!--
//定义变量
var html = "";
var i ;

////////////////////////////////////////////////////
//定义图形变量
var img_plus_first = "../../common/treeview/images/img_plus_first.gif" //第一个节点
var img_minus_first = "../../common/treeview/images/img_minus_first.gif";

var img_plus = "../../common/treeview/images/plus.gif" ;//图形＋
var img_plus_end = "../../common/treeview/images/img_plus_end.gif"; //未展开的最后一个节点

var img_minus = "../../common/treeview/images/minus.gif" ;//图形－
var img_node = "../../common/treeview/images/node.gif" ;//图形|-
var img_end = "../../common/treeview/images/end.gif" ;//图形|_
var img_minus_end = "../../common/treeview/images/img_minus_end.gif" //有子节点，最后一个节点
var img_null = "../../common/treeview/images/null.gif";


var img_back = "../../common/treeview/images/back.gif" ;//背景图形|(一条线）
var img_hide = "" ; //打开时的图片
var img_hide = "" ; //并合时的图片
var show_imgs = new Array() ;
var hide_imgs = new Array() ;
var node_select = "#C0C0C0" ; //选中节点要显示的背景色
var node_no_select = "#ffffff" ; //未选中节点要显示的背景色

var img_show = "../../common/treeview/images/img_show.gif";
var img_hide = "../../common/treeview/images/img_hide.gif";
var img_hide_first = "../../common/treeview/images/img_hide_first.gif";

var img_selected = "../../common/treeview/images/choossed.gif"; //选定的图

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

var isSupportMultiSelected = false; //支持多选
var initIds = ""; //初如化IDS
var waitString = "正在打开...";
var aNodeObj = new Object; //nodeObj["xx"].status: "undefined":未打开过 1:打开状态 0 : 关闭状态

var	curNode = new aNode(); //加号对象
var oldNode = new aNode();

var curTxtNode = new aTxtNode();
var oldTxtNode = new aTxtNode();
var selectedDirIds = new Object();


function init()
{
        var num = 1;
        var nodeFlag = "1";


        var nodes = xmlDoc.XMLDocument.documentElement.selectNodes("item1");
        if (nodes)
        {
                                //初始化ＩＤｓ
                                if (initIds != "")
                                {
                                        var aIds = initIds.split(",");
                                        for (var i=0;i<aIds.length;i++)
                                        {
                                                selectedDirIds[aIds[i]] = 1;
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
}

function getSelectedIds()
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
function setSupportMultiSelected(t)
{
    isSupportMultiSelected = t;
}
function setInitIds(ids)
{
        initIds = ids;
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
        url = url?url:"#";

                //仅处理目录ＩＤｓ初始化
                var tmpIds = "," + initIds + ",";
                if (tmpIds.indexOf(","+id+",") != -1) //默认选定
                {
                        imgHtml = '<img id="nodeImg'+nodeFlag + '" src=' + img_selected + ' valign=baseline align=absbottom border=0>';
                        node.setAttribute("initImg","yes");
                }

        var title   = '<span id=txt'+nodeFlag+' >'+node.getAttribute("value")+'</span>'+ imgHtml;

        if (isFirst)
        {
                var img_plus_temp = img_plus_first;
                var img_hide_temp = img_hide_first;

        }else{
                var img_plus_temp = img_plus;
                var img_hide_temp = img_hide;
        }
        if (isLast)
        {
                var back_img = "";
                var img_plus_temp = img_plus_end;
        }else{
                var	back_img = "background=\"../../common/treeview/images/back.gif\"";
        }

        aNodeObj[nodeFlag] = new aNodeInfo();
        aNodeObj[nodeFlag].img_hide = img_hide_temp;
        aNodeObj[nodeFlag].img_plus = img_plus_temp;

        //alert(back_img)
        var img_title = "<img id="+title_id+" border=0 src='"+img_hide_temp+"' width=16 height=16>" ;

        s += '<tr id="'+menu_id+'">'+"\r\n" ;
        if (isFirst)
        {
                s += '  <td width="2%" style="cursor:hand" onmouseup=turnit("'+nodeFlag+'",'+id+')  >'+"\r\n" ;
        }else{
                s += '  <td width="2%" style="cursor:hand" onmouseup=turnit("'+nodeFlag+'",'+id+')  '+back_img+' >'+"\r\n" ;
        }
        s += '    <img id="'+img_id+'" border="0" src="'+img_plus_temp+'">' ;
        s += '  </td>'+"\r\n" ;
        s += '  <td nowrap style="cursor:hand;" id="node' + nodeFlag + '" onclick=turnit_node("'+nodeFlag+'",'+id+')>'+img_title+"&nbsp;"+title ;
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

function turnit_node(nodeFlag,id)
{
        var node = locateNode(nodeFlag,id);
        if (node)
        {
            eval("var obj = node" + nodeFlag);
            if(oldTxtNode.XMLNode == null) //第一次点击
            {
                    curTxtNode.HTMLNode = obj;
                    curTxtNode.XMLNode = node;
                    curTxtNode.nodeFlag = nodeFlag;
                    //alert(nodeFlag);
                    //alert(curTxtNode)
                    curTxtNode.setColor();
                    if (curTxtNode.isSelected()) //原来是选定的
                    {
                            curTxtNode.unSelect();
                    }else{
                            curTxtNode.select();
                    }

                     oldTxtNode = curTxtNode;
            }else{
                    /*
                    1.判断选中的是不是自已 old = cur　
                    2.不是：cur.clear(),cur.nodeFlag = nodeFlag, cur.selected(),old.setColor()
                       是 ：cur.NonSelected()
                    3.是不是多选
                    　不是：old.NonSelected()
                    　 是 ：不操作
                    4.    　
                    */
                    oldTxtNode = curTxtNode;
                    if(oldTxtNode.nodeFlag == nodeFlag) //判断选中的是不是自已
                    {
                            if (curTxtNode.isSelected()) //原来是选定的
                            {
                                    curTxtNode.unSelect();
                            }else{
                                    curTxtNode.select();
                            }
                    }
                    else{
                            oldTxtNode.setColor();
                            curTxtNode = new aTxtNode();


                            curTxtNode.nodeFlag = nodeFlag;
                            curTxtNode.XMLNode = node;
                            curTxtNode.HTMLNode = obj;
                            curTxtNode.setColor();
                            //alert(oldTxtNode.nodeFlag)
                            //alert(curTxtNode.nodeFlag)


                            if(curTxtNode.isSelected()) //现在的是选定的
                            {
                                    curTxtNode.unSelect();
                            }else{
                                    curTxtNode.select();
                            }
                    }

                    if (isSupportMultiSelected) //多选
                    {
                            ;
                    }
                    else{ //单选

                            if (oldTxtNode != curTxtNode)
                            {
                                    oldTxtNode.unSelect();
                            }
                    }
            }
            title_click(id,node.getAttribute("name"),node);
        }
}
function turnit(nodeFlag,id)
{
        eval("var wait_id = wait"+nodeFlag);
        eval("var menu_id = menu"+nodeFlag);
        eval("var img_id  = img"+nodeFlag);
        eval("var title_id = title"+nodeFlag);

        //if (typeof(nodeObj[nodeFlag]) == "undefined")
        //alert(aNodeObj[nodeFlag].status)
        if(aNodeObj[nodeFlag].status == "undefined") //未初始化
        {
                initNode(nodeFlag,id);
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
        return;
}
function initNode(nodeFlag,id)
{
        var node = locateNode(nodeFlag,id);
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
                alert("NULL")
        }
}
function locateNode(nodeFlag,id)
{
        var levels = nodeFlag.split("_");
        var level  = levels.length;
        var nodeName = "";
        for (var i=1;i<level;i++)
        {
                t = i>1 ? "/" : "";
                nodeName += t+"item"+i;
        }
        var xpath = nodeName+"[@id=\""+id+"\"]";
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
                this.XMLNode = null;
                this.HTMLNode = null;
                this.nodeFlag = "";
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
                var imgHtml = '<img id="nodeImg'+curTxtNode.nodeFlag + '" src=' + img_selected + ' valign=baseline align=absbottom border=0>';
                this.HTMLNode.innerHTML += imgHtml ;
                this.XMLNode.setAttribute("initImg","yes");
                var id = this.XMLNode.getAttribute("id");
                selectedDirIds[id] = 1;
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
                        selectedDirIds[id] = 0;
                }catch(e){
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
