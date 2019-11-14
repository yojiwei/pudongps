<style type="text/css">
body{margin:0;padding:0;font-size:12px; background-color:#FFFFFF;}
ul{ list-style-type:none; margin:0 0 0 20px; padding:0;}
li{ white-space:nowrap; padding:0;}
.childdiv{ background:url(../../common/tree/images/dot.gif);background-repeat:repeat-y;}
span { cursor:pointer;}

</style>
<SCRIPT LANGUAGE=javascript>
<!--
window.onerror=function(){return true;}
//-->
</SCRIPT>
<script type="text/javascript">
var xmlHttp; //定义一个全局变量
var currentID=1;//设置当前选中ID，如果此ID不存在则会发生js错误

//类别显示主函数
//cid--子类别所在层id
//id --类别id
//pid--[+]和[-]图标id
//fid--类别图标id
function DivDisplay(cid,id,pid,fid)
{
	if (GetId(cid).style.display=='')	//子类别不显示时图标显示控制
	{
		GetId(cid).style.display='none';
		GetId(pid).src = '../../common/tree/images/closed.gif';
		GetId(fid).src = '../../common/tree/images/folder.gif';
	}
	else		//展开子类别时的操作
	{
		GetId(cid).style.display='';
		GetId(pid).src = '../../common/tree/images/opened.gif';
		GetId(fid).src = '../../common/tree/images/folderopen.gif';
		if (GetId(cid).innerHTML==''||GetId(cid).innerHTML=='正在提交数据...')
		{
			GetId(cid).innerHTML='';
			ShowChild(cid,id);		//调用显示子类别函数
		}
	}
}

//与上一个函数作用相同，只作用在最后一个类别
function DivDisplay2(cid,id,pid,fid)
{
	if (GetId(cid).style.display=='')
	{
		GetId(cid).style.display='none';
		GetId(pid).src = '../../common/tree/images/lastclosed.gif';
		GetId(fid).src = '../../common/tree/images/folder.gif';
	}
	else
	{
		GetId(cid).style.display='';
		GetId(pid).src = '../../common/tree/images/lastopen.gif';
		GetId(fid).src = '../../common/tree/images/folderopen.gif';
		if (GetId(cid).innerHTML==''||GetId(cid).innerHTML=='正在提交数据...')
		{
			GetId(cid).innerHTML='';
			ShowChild(cid,id);
		}
	}
}

//类别添加函数
//id--类别id
function ClassAdd(id){
if (GetId("p"+id).src.indexOf("last")>0){	//最后一个类别时的添加操作
	if (!GetId("p"+id).onclick){
		GetId("p"+id).onclick=function (){DivDisplay2("c"+id,id,"p"+id,"f"+id);};	//为[+]和[-]添加单击事件
		GetId("s"+id).ondblclick=function (){DivDisplay2("c"+id,id,"p"+id,"f"+id);};	//为显示类别文字的span添加双击事件
		GetId("p"+id).src = '../../common/tree/images/lastopen.gif';
		}
	}
else{
	if (!GetId("p"+id).onclick){	//不为最后一个类别的添加操作
		GetId("p"+id).onclick=function (){DivDisplay("c"+id,id,"p"+id,"f"+id);};
		GetId("s"+id).ondblclick=function (){DivDisplay("c"+id,id,"p"+id,"f"+id);};
		GetId("p"+id).src = '../../common/tree/images/opened.gif';
		}
	}
GetId("c"+id).style.display='';
ShowChild("c"+id,id);
}

//类别修改函数
function ClassEdit(id,classname){
GetId("s"+id).innerHTML=classname;
}

//有多个子类别的类别的删除函数
function ClassDel(id){
ShowChild("c"+id,id);
CurrentSelect(currentID,id)
BrowseRight(id);
}

//只有一个子类别的类别的删除函数
function ClassDel1(id){
if (GetId("p"+id).src.indexOf("last")>0){		//当类别是当前类别的最后一个类别时
	GetId("p"+id).style.cursor="cursor";		//设置图标的鼠标经过样式
	GetId("p"+id).onclick=function (){};		//因为只有一个子类别删除后就不再有子类别，故将图标单击事件修改为空函数
	GetId("s"+id).ondblclick=function (){};		//同上
	GetId("p"+id).src = '../../common/tree/images/lastnochild.gif';	//图标设置
	}
else{
	GetId("p"+id).style.cursor="cursor";		//非最后一个类别的删除操作
	GetId("p"+id).onclick=function (){};
	GetId("s"+id).ondblclick=function (){};
	GetId("p"+id).src = '../../common/tree/images/nofollow2.gif';		//这里的图标设置与前面不一样
	}
ShowChild("c"+id,id);
CurrentSelect(currentID,id);
BrowseRight(id);
}


//设置类别选中状态的函数
function CurrentSelect(oldid,newid){
currentID=newid;
document.getElementById("s"+oldid).style.backgroundColor="white";
document.getElementById("s"+currentID).style.backgroundColor="#C0C0E9";

}
//创建XMLHttpRequest对象
function CreateXMLHttpRequest()
{
	if (window.ActiveXObject)
	{
		xmlHttp = new ActiveXObject("Microsoft.XMLHTTP");
	}
	else
	{
		xmlHttp = new XMLHttpRequest();
	}
}

//Ajax处理函数
//id,层id
//rid,数据在表中的id
function ShowChild(cid,id)
{
	CreateXMLHttpRequest();
	if(xmlHttp)
	{
		xmlHttp.open('POST','../../common/tree/child.jsp',true);
		xmlHttp.setRequestHeader('Content-Type','application/x-www-form-urlencoded');
		var SendData = 'id='+id;
		xmlHttp.send(SendData);
		xmlHttp.onreadystatechange=function()
		{
		   if(xmlHttp.readyState==4)
		   {
			 if(xmlHttp.status==200)
			 {
				GetId(cid).innerHTML = xmlHttp.responseText;
			 }
			 else
			 {
				GetId(cid).innerHTML='出错：'+xmlHttp.statusText;
			 }
		   }
		   else
		   {
				GetId(cid).innerHTML="正在提交数据...";
			}
	  	}
		
	 }
	 else
	 {
	 	GetId(cid).innerHTML='抱歉，您的浏览器不支持XMLHttpRequest，请使用IE6以上版本！';
	 }
	 
}



//取得页面对象
//id,层id
function GetId(id)
{
	return document.getElementById(id);
} 


//取得当前节点标题
//id,层id
function GetTitle(id)
{
	return document.getElementById("s"+id).innerText;
} 
</script>