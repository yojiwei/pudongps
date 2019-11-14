<%@ page contentType="text/html; charset=GBK" %>
<%String strTitle="新闻发布" ;%>
<%@include file="/system/app/skin/import.jsp"%>
<link rel="stylesheet" href="/system/app/skin/skin1/css/style.css" type="text/css">
<%
String tr_id=""; //角色id
String subjectIds = "";
long id;
tr_id = "1";

%>
<script LANGUAGE="javascript" src="NewtreeJs11.jsp"></script>
<SCRIPT LANGUAGE=javascript>
<!--
var args = parent.dialogArguments;	//获取对话框传递过来的参数
function on_choose()
{
	var sep = "";
	var sep1 = '\x01' ;
	var sep2 = ";";
	var demoStr = formData.demoContent.value;

	if (formData.userIds.value == ",") formData.userIds.value = "";
	if (formData.deptIds.value == ",") formData.deptIds.value = "";
	s1  = "userIds="+formData.userIds.value ;
	s2  = "formData.deptIds="+formData.deptIds.value ;

	if (demoStr != "" )
	{
		if (demoStr.substring((demoStr.length)-1,demoStr.length) != sep2) sep = sep2;
	}
	if (formData.demoType.checked)
	{
		s3 = "content="+formData.demoContent.value + sep + formData.content.value;
	}else{
		s3 = "content="+formData.content.value+formData.demoContent.value+sep;
	}

	var strPowerID=args["AuthorityCheck"];
	var strPowername = args["AuthorityName"];
	//alert(strPowername);
    //strPowerID = "," + strPowerID
    var returnValue1="";
    //alert(strPowerID);
	//alert(formData.content.value);
	//alert(formData.deptIds.value);
	
		//alert(strPowerID);
	//alert(formData.deptIds.value);
	//alert(formData.content.value);
	sValue = formData.deptIds.value; //sjid的值
	sname = formData.content.value;
	j=0
   
	
	
    returnValue=sValue + sep2 + sname;
	//alert(returnValue);
	window.close() ;
}
function on_clear()
{
	formData.deptIds.value = "" ;
	formData.userIds.value = "" ;
	formData.content.value = "" ;
	formData.demoContent.value = "" ;
}

//-->
</SCRIPT>
<%//update20080122
CDataCn dCn=null;   //新建数据库连接对象
CDataImpl dImpl=null;  //新建数据接口对象

  CRoleInfo  jdo = null;
  //CSubjectXML tree = new CSubjectXML(dCn);
  try {
 dCn = new CDataCn(); 
 dImpl = new CDataImpl(dCn); 
  
 jdo = new CRoleInfo(dCn);
  id = java.lang.Long.parseLong(tr_id); //角色的ID
  subjectIds = jdo.getSubjects(id); //获取模块的ID列表
  //out.println(subjectIds);
%>
  <xml id=xmlDoc>
</xml>
<%
String ownerFlag="0";
String bootId=CTools.dealString(request.getParameter("bootid"));
String Kind="1";
String noDept="false";
String deptTableName="tb_subject";
String userTableName="userlist";
//ImgPath = Application("_root") & "/images/other/"
%>
<table class="main-table" width="100%">
  <tr>
   <td>
  <table width="100%">
    <tr>
      <td width="100%" align="left" colspan="2">
                <table width="100%" cellspacing="0"> 
                        <tr class="title1">
                                <td id="TitleTd" width="100%" align="center" height="25"><img src="./images/dialog/split.gif" align="middle" border="0">
																选择栏目
                                <img src="./images/dialog/split.gif" align="middle" border="0"></td>

                         </tr>
						 <tr>
                                  <td width='100%' height='100%' valign='top'>

				            <%
	                       // ''''''''''''''取出根节点 ''''''''''''''''''''''''''''
						   String  ImgPath="./images/fileImg/";
						   String  sql="";
                           sql="select * from " + deptTableName + "  where sj_id=" + bootId ; 
	                       //out.println(sql);
						   String   sj_name="";
						   String   sj_id="";
	                       Vector vectorPage = dImpl.splitPage(sql,100,1);
						   //out.println(sql);
	                       Hashtable datarow = (Hashtable)vectorPage.get(0);
         			       sj_name=datarow.get("sj_name").toString();
						   sj_id=datarow.get("sj_id").toString();
						   if(vectorPage!=null)
                    		{
							out.println("<table border='0' width='100%' cellpadding='0' cellspacing='0'>");
							out.println("<tr>");
							out.println("<td width='3%' align='Left'>");
							out.println("<img id='img" + sj_id + "' border='0' src='" + ImgPath + "endplus.gif' style='display:none;' >");
							out.println("</td>");
							out.println("<td width='97%'><img  id='node_img" + sj_id + "' border=0 src='" + ImgPath + "top.gif' width=15 height=15 >&nbsp;<a class='tree_title' style='cursor:hand' onclick=turnit_node(" + sj_id + ",1,0)><span id='node_color" + sj_id + "' >" + sj_name + "</span></a><div  value='1' id='newtree" + sj_id +"' ><div></td>");
							out.println("</tr>");
							out.println("</table>");
							}
	                     %>

                           </td>
					   </tr>

                </table>
      </td>
    </tr>

   <tr>
     <td width="100%">
                <span id=TreeRoot></span>
         </td>
   </tr>
	 <!--
   <tr class="title1">
      <td width="100%" align="center" colspan="2">
          <input type="button" class="bttn" value="选定栏目" onclick="on_choose()">

                  <input type="button" class="bttn" value="返回" onclick="javascript:top.window.close();">
      </td>
   </tr>
	 -->
</table>
</td>
</tr>
</table>
<form name="formData" method="post" action="roleSubjectResult.jsp">
<input type="hidden" name="subjectIds" value="<%=subjectIds%>">
<input type="hidden" name="tr_id" value="<%=tr_id%>">
<input type="hidden" name="action" value="">
<input type="checkbox" id="demoType" value="1" class="check1" style="display:none">
<input type="hidden" name="deptIds" id="deptIds" value="">
<input type="hidden" name="userIds" value="">
<input type="hidden" name="multi"   value="0">
<input type="hidden" name="isDemo"  value="">
<input type=hidden id="list_id" value="0">
<textarea class="text-area" type="text" id="content" style="width:100%;height:50;display:none" readonly></textarea>
<textarea class="text-area" type="text" id="demoContent" style="width:100%;height:20;display:none"></textarea>
</form>

<script LANGUAGE=JavaScript>
var deptTableName='<%=deptTableName%>';
var userTableName='<%=userTableName%>';
var ImgPath='<%=ImgPath%>';
var Kind='<%=Kind%>';
var userId;
var ownerFlag='<%=ownerFlag%>';
var noDept='<%=noDept%>';
var i ;
var img_hide = '' ;
var img_hide = '' ;
var show_imgs = '<%=ImgPath%>showdir.gif' ;
var hide_imgs = '<%=ImgPath%>hidedir.gif' ;
var history_id = '' ;
var history_out_id = '' ;
var history_menu ;
var history_img ;
var history_menu_id = '';
var img_plus  = '<%=ImgPath%>plus.gif' ;
var img_minus = '<%=ImgPath%>minus.gif' ;
var img_endplus = '<%=ImgPath%>endplus.gif' ;
var img_endminus = '<%=ImgPath%>endminus.gif' ;
var mNodeSelectColor    = '#C0C0C0' ;
var mNodeNoSelectColor = '';
var is_only_node = 1 ;
var history_obj ;
var history_out_obj ;
var noNode;
var strPowerID=args["AuthorityCheck"];
//////////////////////////////////////////////////
//var args = dialogArguments ;
//title.innerHTML = args.title ;
//userIds.value  = args.userIds ;
//deptIds.value  = args.subjectIds ;
//multi.value = args.multi      ;
//content.value =args.content;
//list_id.value =deptIds.value;

formData.deptIds.value = "," + args["NowSelectId"];
//alert(formData.deptIds.value);
formData.content.value = args["NowSelectValue"];

function set_usr_variable(me)
{
    is_only_node = me ;
}
function turnit(s, i, id, counts,isEnd)
{
    eval("(typeof(document.all."+s+") == 'undefined') ? e = 1 : e = 0");
    if (e==0){
         eval("(typeof(document.all."+i+") == 'undefined') ? e = 1 : e = 0");
    }
    if (e==0){
        eval("var ss = document.all."+s);
        eval("var ii = document.all."+i);
    }else{
        alert("没有可选择的项,请您返回!")
        return;
    }
    if (counts > 0)
    {
        if (ss.style.display=='none')
        {
            ss.style.display = '';
            if (!isEnd) ii.src = img_minus
            else ii.src = img_endminus ;
            node = 'node_img'+id+'.src' ;
            eval(node+' = show_imgs');
        }else{
            ss.style.display = 'none';
            if (!isEnd) ii.src = img_plus
            else ii.src = img_endplus ;
            node = 'node_img'+id+'.src' ;
            eval(node+' = hide_imgs');
        }
        if (is_only_node == 1)
        {
            if (counts == 9999)
            {
                if (history_menu)
                {
                    if(history_menu.id != ss.id )
                    {
                        history_menu.style.display = 'none' ;
                        history_img.src = img_plus ;
                        node = 'node_img'+history_menu_id+'.src' ;
                        eval(node+' = hide_imgs') ;
                    }
                }
                history_menu = ss ;
                history_img = ii ;
                history_menu_id = id ;
            }
        }
    }
    return;
}

function turnit_node(list_id, id, user_id,disable)
{
    if (id == 1){
        if (show_imgs != '')
        {
            eval('node_img'+list_id+'.src = show_imgs') ;
        }
        eval('var obj=node_color'+list_id);
    }
	else{
        eval('var obj=node_user_color'+user_id);
    }
    obj.style.background = mNodeSelectColor ;
    history_out_obj = history_obj ;
    if (! history_obj)
    {
        history_obj = obj ;
    }
	else
		{
        if (history_obj != obj)
        {
            if (id == 1) {
                var re = /user/gi;

                if (history_obj.id.search(re) == -1) eval('node_img'+history_id+'.src =hide_imgs')
                history_obj.style.background = mNodeNoSelectColor ;
            }else{
                history_obj.style.background = mNodeNoSelectColor ;
            }
            history_obj = obj ;
        }
    }
    history_out_id = history_id ;
    if (id == 1) {
       history_id = list_id ;
    }else{
       history_id = user_id ;
    }
	if(disable!="disabled"){
		title_click(list_id,id,user_id) ;
	}    
    return;
}




/////////////////子树
////////////////每一个节点包含：
////////////////value=1未打开;value=0已经打开;value=2已打开但display='none'
////////////////<div id="newTree"+id>加入子树的位置


creatChildNode("<%=sj_id%>");

/////////////////子树
////////////////每一个节点包含：
////////////////value=1未打开;value=0已经打开;value=2已打开但display='none'
////////////////<div id="newTree"+id>加入子树的位置


function creatChildNode(upperid)
{

    var objxml,objhttp;
	var xmlStr = "";
 	objxml=new ActiveXObject("Microsoft.XMLDOM");

 	var str = "<childTree><deptTableName>"+deptTableName+"</deptTableName><userTableName>"+userTableName+"</userTableName><upperid>"+upperid+ "</upperid><kind>"+Kind+ "</kind><userId>"+userId+ "</userId><ownerFlag>"+ownerFlag+ "</ownerFlag></childTree>";

 	objxml.loadXML(str);

	if (objxml.parseError.errorCode!=0)
		{
			alert("系统出错[XML文档不能解析]");
			return;
		}
	try
		{
			strA = "upperid=" + upperid + "&tabName=" + deptTableName;
			var objhttp=new ActiveXObject("Microsoft.XMLHTTP");
			objhttp.Open("post","CreatChildTree11.jsp",false);
			objhttp.setRequestHeader("Content-Length",strA.length);
			objhttp.setRequestHeader("CONTENT-TYPE","application/x-www-form-urlencoded");
			objhttp.Send(strA);
			xmlStr = objhttp.responsetext;
			xmlStr = xmlStr.substring(xmlStr.indexOf("<childTree>"),xmlStr.length-1);
			xmlStr = "<?xml version='1.0' encoding='gb2312'?>" + xmlStr;
			//document.write("<textarea>" + xmlStr + "</textarea>");
			objxml.loadXML(xmlStr);
	  	}
	 catch(e)
		{
			alert("不支持xmlhttp控件!");
			return false;
		}

	 /////////////如果既没有部门也没有用户，则改变图标

	 if (objxml.documentElement.selectSingleNode('name').text=="")
     {
          var node=ImgPath+"node.gif";
          eval("img"+upperid+".src=node");
          return;
     }

	///////创建子树

	CreatTree(upperid,objxml.documentElement.selectSingleNode('name').text,objxml.documentElement.selectSingleNode('id').text,"","",objxml.documentElement.selectSingleNode('nonode').text);
 }

function CreatTree(upperid,names,ids,username,userid,nonode)
 {

	  var newimgplus=ImgPath+"endplus.gif";
	  var newimgminus=ImgPath+"endminus.gif";
	  if (eval("img"+upperid+".src").search("endminus.gif")>0)
	  {
	      eval("img"+upperid+".src=newimgplus");
	  }
	  else
	  {
	      eval("img"+upperid+".src=newimgminus");
	  }

      if(eval("newtree"+upperid+".value")==0) ///////子树已经打开，则合并返回
		{
		   eval("newtree"+upperid+".style.display='none'");
		   eval("newtree"+upperid+".value=2");
		   //var newimg=ImgPath+"endplus.gif";
		   //eval("img"+upperid+".src=newimg");
    	   return false;

		}

	 else

		{
		   if(eval("newtree"+upperid+".value")==2)
		      {
				 if(eval("newtree"+upperid+".style.display")=='')     ///////////子树
				    eval("newtree"+upperid+".style.display='none'");
				 else
                                   {
				                    eval("newtree"+upperid+".style.display=''");
                                  }
				 return false;
		      }
		}


     var i,nameArray,idArray,usernameArray,useridArray,temp,usertemp,nonodeArray;

      temp="";
      if(names!="")/////////列出部门
		 {
			 	 nameArray=names.split("；");
				 idArray  =ids.split("；");
				 nonodeArray  =nonode.split("；");
				 for(i=nameArray.length-1;i>=0;i--)
				{
					if(temp=="")
					  {
					       if((i==(nameArray.length-1))&&username=="")///////////如果是最后一个节点
					        {
						 		temp=creatDeptTree(idArray[i],nameArray[i],0,nonodeArray[i]);
							 }
							 else  ///////////如果是中间节点
							 {
							 	temp=creatDeptTree(idArray[i],nameArray[i],1,nonodeArray[i]);

							 }
					  }
				   else
					  {
						  if((i==(nameArray.length-1))&&username=="")	 ///////////如果是最后一个节点
							 {
							    temp=creatDeptTree(idArray[i],nameArray[i],0,nonodeArray[i])+temp;
							 }
						  else    ///////////如果是中间节点
						     {
						        temp=creatDeptTree(idArray[i],nameArray[i],1,nonodeArray[i])+temp;
						     }
					  }
				 }

		}

	  usertemp=""
	  if(username!="")///////////////////列出用户
		{
			 	 usernameArray=username.split("；");
				 useridArray  =userid.split("；");

				 for(i=usernameArray.length-1;i>=0;i--)
				{
					if(usertemp=="")
					  {
							if(i==usernameArray.length-1)  ///////////如果是最后一个节点
							    {
							      usertemp=creatUserTree(upperid,useridArray[i],usernameArray[i],0);
							    }
							else                           ///////////如果是中间节点
							   {
							      usertemp=creatUserTree(upperid,useridArray[i],usernameArray[i],1);
							    }

					  }
				 else
					  {
							if(i==usernameArray.length-1)   ///////////如果是最后一个节点
							    {
							       usertemp=creatUserTree(upperid,useridArray[i],usernameArray[i],0) + usertemp;
							    }
							else       ///////////如果是中间节点
							   {
							       usertemp=creatUserTree(upperid,useridArray[i],usernameArray[i],1) + usertemp;
							    }

					  }
				 }

		}


	 temp="<table cellSpacing='0' cellPadding='0' width='100%' border='0'>"+temp+usertemp+"</table>";
     eval("newtree"+upperid+".innerHTML=temp");

     eval("newtree"+upperid+".value=0");/////改变值表示已经打开
     var newimg=ImgPath+"endminus.gif";
     eval("img"+upperid+".src=newimg");

    ///////////初始化
    if(names!="")     initChildTreeIds(ids,"node_color",1);
    if(username!="")  initChildTreeIds(userid,"node_user_color",2);


 }

 ///////////////////创建主表树
 function creatDeptTree(deptId,deptName,type,nonode)
 {
    var temp;
	
	//alert(strPowerID)
	if(strPowerID.indexOf(","+ deptId +",")==-1){
		disable = "";
	}else{
		disable = "";
	}
    
	if(type==0)////////最后一个节点
    {
		temp="<tr><td width='3%'  align='Left' valign='top' style='cursor:hand'  onmouseup=creatChildNode(" + deptId + ")>";
		if (nonode=="true")
		{
		   temp=temp+"<img  id='img"+ deptId +"'  border='0' src='" + ImgPath + "end.gif'></td>";
		}
		else
		{
		   temp=temp+"<img  id='img"+ deptId +"'  border='0' src='" + ImgPath + "endplus.gif'></td>";
		}
		temp=temp+"<td width='97%'  height='26'><img id='node_img"+ deptId +"' border=0 src='" + ImgPath + "hidedir.gif' width=15 height=15 >&nbsp;<a class='tree_title'  "+ disable +"  style='cursor:hand' "
		if (noDept=="True")
		{
		   temp=temp + " onmouseup=creatChildNode(" + deptId + ")> "
		}
		else
		{
		   temp=temp + " onclick=turnit_node("+deptId+",1,0,'" + disable + "')> "
		}
		temp=temp + " <span id='node_color"+ deptId +"' >" + deptName + "</span></a><div style='display:' value='1' id='newtree"+ deptId + "'></div></td></tr>";
 	}
	else  ///////////中间节点
	{
   	    temp="<tr><td width='3%'  align='Left' valign='top' style='cursor:hand' background='"+ImgPath +"back.gif' onmouseup=creatChildNode(" + deptId + ")>";
		if (nonode=="true")
		{
		   temp=temp+"<img  id='img"+ deptId +"'  border='0' src='" + ImgPath + "node.gif'></td>";
		}
		else
		{
		   temp=temp+"<img  id='img"+ deptId +"'  border='0' src='" + ImgPath + "plus.gif'></td>";
		}
		temp=temp + "<td width='97%'  height='26'><img id='node_img"+ deptId +"' border=0 src='" + ImgPath + "hidedir.gif' width=15 height=15 >&nbsp;<a " +  disable  + " class='tree_title' style='cursor:hand' "
		if (noDept=="True")
		{
		   temp=temp + " onmouseup=creatChildNode(" + deptId + ")> "
		}
		else
		{
		   temp=temp + " onclick=turnit_node("+deptId+",1,0,'" + disable + "')> "
		}
		temp=temp + " <span id='node_color"+ deptId +"' >" + deptName + "</span></a><div style='display:' value='1' id='newtree"+ deptId + "'></div></td></tr>";
 	}
 	return temp;
 }

  ///////////////////创建从表树
 function creatUserTree(deptId,userId,userName,type)
 {
    var temp;

	if(strPowerID.indexOf(","+ deptId +",")==-1){
		disable = "";
	}else{
		disable = "";
	}
    
	if(type==0)////////最后一个节点
    {
		temp="<tr><td width='3%'>";
	    temp=temp+"<img id='user_img"+ userId +"' border='0' src='" + ImgPath + "end.gif'></td>";
	    temp=temp+"<td width='97%'  height='18'><img src='" + ImgPath + "file.gif' width=20 height=18 border=0> <a class='tree_title' style='cursor:hand' " + disable + " onclick=turnit_node(" + deptId + ",2," + userId + ",'" + disable + "')><span id='node_user_color" + userId + "'>" + userName + "</span></a></td></tr>";

 	}
	else  ///////////中间节点
	{
   	    temp="<tr><td width='3%'>";
	    temp=temp+"<img id='user_img"+ userId +"' border='0' src='" + ImgPath + "node.gif'></td>";
	    temp=temp+"<td width='97%'  height='18'><img src='" + ImgPath + "file.gif' width=20 height=18 border=0> <a class='tree_title' style='cursor:hand' " + disable + " onclick=turnit_node(" + deptId + ",2," + userId + ",'" + disable + "')><span id='node_user_color" + userId + "'>" + userName + "</span></a></td></tr>";

 	}
 	return temp;
 }


 //////////////初始化子树节点
 function initChildTreeIds(ids,o,kind)
{


    var aIds = ids.split("；");

	for (var i=0;i<aIds.length;i++) {

      if (aIds[i] != "") {
			try
			{
				//eval("history_obj="+o+aIds[i]);
				//history_id = aIds[i];
				if (kind == 1) {
				    if (formData.multi.value == "0" ) // 单选
				    {
				       if(formData.deptIds.value.search(aIds[i])>=0)
					   {
						   eval("history_obj="+o+aIds[i]);
					       history_id = aIds[i];
						   title_click(aIds[i],kind,0,-1,-1); //部门
					   }
					}
					else
					{

                      if(formData.deptIds.value.search(","+aIds[i]+",")>=0)
					   {
					   eval("history_obj="+o+aIds[i]);
				       history_id = aIds[i];
					   title_click(aIds[i],kind,0,-1,-1); //部门
					   }
					}
				}else{
				    if (formData.multi.value == "0" ) // 单选
				   {
				       if(formData.userIds.value.search(aIds[i])>=0)
					   {
					   eval("history_obj="+o+aIds[i]);
				       history_id = aIds[i];
					   title_click(0,kind,aIds[i],-1,-1); //用户
				      }
				    }
				    else
				    {
				       if(formData.userIds.value.search(","+aIds[i]+",")>=0)
					   {
					   eval("history_obj="+o+aIds[i]);
				       history_id = aIds[i];
					   title_click(0,kind,aIds[i],-1,-1); //用户
				       }
				    }

				}

			}
			catch (e){};
		}
	}
}


function title_click(list_id,id,user_id,isNeeded,isParentClick)
{
	var img ;
	var aNode = history_obj ;
	var initImg = 0 ;
	var node_color_img = "node_color_img_"+id+"_" ;
	var node_title = aNode.innerHTML ;
	var sp1 = ',';
	if (id == 1) { //目录
		list_id = list_id ;
		var chooseIds = formData.deptIds ;
	}else{
		list_id = user_id ;
		var chooseIds = userIds ;
	}
	eval("if (typeof("+node_color_img+list_id+") == 'undefined' ) initImg = 1 ;  ") ;
	if (initImg == 1) //没有定义
	{
		img = 0 ; //要新增
		if (isNeeded == 0) img = 3; //不作处理
	}else{
		eval("var aNodeImg = "+node_color_img+list_id);
		if (aNodeImg.style.display == "") //原先选定的
		{
			img = 2 // 现在不选定

			if (isNeeded == 1) img = 3; //对已选定，现不作处理
		}else{
			img = 1  // 现在要选定
			if (isNeeded == 0) img = 3; //不作处理
		}
	}

	//if (isNeeded == 1) img = 3; //对已选定，现不作处理
	if (img != 3)
	{
		if (img == 0) //已选定,定义
		{
			eval("imgHtml = '<img id="+node_color_img+list_id+" src=" + ImgPath +"choossed.gif valign=baseline align=absbottom border=0>' ;");
			aNode.insertAdjacentHTML("AfterEnd",imgHtml);
		}else{
			if (img == 1) // 选定
			{
				eval(node_color_img+list_id+".style.display = '' ;");
			}else{
				eval(node_color_img+list_id+".style.display = 'none' ;");
			}
		}

		var chooseValue = document.all("content");
		
		//alert(chooseValue.value);

			eval("var re = ',' + "+list_id+" +',';") ;
			//eval("var re = ,"+list_id+",;") ;
			//alert(re);
			chooseIds.value = "," + chooseIds.value; //默认给第一个加一个逗号

			var t = chooseIds.value.search(re) ;
			//var t = chooseIds.value.search(re) ;

			if (formData.multi.value == "0" ) // 单选
		{
			if (history_out_id != "" && history_out_id != list_id)
			{
				try
				{
					eval(node_color_img+history_out_id+".style.display = 'none' ;");
				}
				catch(e){}
			}
		
			chooseValue.value = node_title;
			
			chooseIds.value = list_id;
		}else{
			eval("var re = /,"+list_id+",/;") ;
			var t = chooseIds.value.search(re) ;
			if (img == 0 || img == 1) //要添加
			{
				if (t == -1) //还没选定
				{
					if (chooseIds.value.search(","+list_id+",")=="-1")
					   {
					     chooseValue.value += node_title+sp1 ;
					   }
					if (chooseIds.value == "") {
						chooseIds.value   = ","+list_id+"," ;
					}else{
						chooseIds.value   += list_id+"," ;
					}
				}else{
					if (chooseIds.value.search(","+list_id+",")=="-1")
					{
					   chooseValue.value += node_title+sp1 ;
					}
				}
			}else{
				if (t != -1) //要删除该字符
				{
					chooseIds.value   = chooseIds.value.replace(re,",");
					eval("var re = /"+node_title+sp1+"/ ;");
					chooseValue.value = chooseValue.value.replace(re,"");
				}
			}
		}

	}

	if (isGoGo != 1 ) return;
	if (!(isNeeded == -1 && isParentClick == -1))
	{
		//处理父节点
		if (typeof(isNeeded) == "undefined" && typeof(isParentClick) == "undefined" && img != 2) //不是第一次调用,并且是要选定的
		{
			OnParentMenuClick(list_id);
		}

		//处理子节点
		if (typeof(isNeeded) == "undefined") //第一次，不在OnSubMenuClick循环中
		{
			if (img != 2) isNeeded = 1; //现在都要选定
			else isNeeded = 0; //现在都不选定
		}
		if (typeof(isParentClick) == "undefined") //只在OnSubMenuClick循环中调用
			OnSubMenuClick(list_id,isNeeded);

		history_obj = aNode;
	}
	return;
}


</script>


<%
  jdo.closeStmt();
  dImpl.closeStmt();
  dCn.closeCn() ;
%>

<!-- 主体结束 -->
<%


} catch (Exception ex) {
	System.out.println(new java.util.Date() + "--"
			+ request.getServletPath() + " : " + ex.getMessage());
} finally {
	if(dImpl != null)
	dImpl.closeStmt();
	if(dCn != null)
	dCn.closeCn();
	if(jdo != null)
	jdo.closeStmt();
}

%>

