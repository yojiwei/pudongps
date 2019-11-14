//<SCRIPT LANGUAGE=javascript>
<!--
///2003-12-30
var isGoGo = 0;

//采用递归算法
function OnSubMenuClick(list_id,isNeeded)
{
	//alert(list_id)
	try
	{
		eval("var subMenu = menu" + list_id);
		var o = subMenu.childNodes[1]

		//alert(o.childNodes[0].outerHTML)
		var o1 = o.childNodes[0]//.childNodes[0];
		for (var i=0;i<o1.rows.length;i++)
		{
			var r = o1.rows[i];
			var id = r.getAttribute("id");
			if (id == "")
			{
				var c = r.cells[0].childNodes[0];
				var imgID = c.getAttribute("id");
				var id = imgID.substr(3);
				eval("history_obj="+"node_color"+id);
				history_id = id;				
				title_click(id,1,0,isNeeded);
			}
		}
		return;
		
	}
	catch(e){return;}
}

//在循环中查找出所有的id=menu的父节点
function OnParentMenuClick(list_id)
{
	eval("var o = node_img"+list_id);
	var o = o.parentNode; 
	while(o)
	{
		try
		{
			var id = o.getAttribute("id");
			//alert(o.nodeName)
			if (id != "")
			{
				//alert(id.substring(0,4).toLowerCase())
				if (o.nodeName == "TR" && id.substring(0,4).toLowerCase() == "menu")
				{
					var id = id.substr(4);
					eval("history_obj="+"node_color"+id);
				    history_id = id;				
				    title_click(id,1,0,1,1);
				}
			}

			var o = o.parentNode;
		}
		catch(e){break;}
	}
}

function init(t)
{
	isGoGo = t;

	if (deptIds.value != "") initIds(deptIds.value,"node_color",1);
	if (userIds.value != "") initIds(userIds.value,"node_user_color",2);
	
	//if(names!="")     initChildTreeIds(ids,"node_color",1);
    //if(username!="")  initChildTreeIds(userid,"node_user_color",2);
	//setDemoContent();
         
}

//kind:类型 1:部门 2:用户 
function initIds(ids,o,kind)
{
	//alert("init:"+ids);
	var aIds = ids.split(",");
	for (var i=0;i<aIds.length;i++) { 
		if (aIds[i] != "") { 
			try 
			{ 
				eval("history_obj="+o+aIds[i]);
				history_id = aIds[i];
				if (kind == 1) {
					title_click(aIds[i],kind,0,-1,-1); //部门
				}else{
					title_click(0,kind,aIds[i],-1,-1); //用户
				}
				
			}
			catch (e){};
		}
	}
}

function setDemoContent()
{

	try
	{
		if (typeof(isDemo) != "undefined")
		{
			if (isDemo.value == "1" && demoContent.value !="") 
			{
				eval("var re = /"+content.value+"/;") ;
				demoContent.value = demoContent.value.replace(re,"");
				
			}
		}
	}
	catch(e){};
}
//-->
//</SCRIPT>
