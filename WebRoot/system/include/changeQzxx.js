function ChangeC(layerid)
{
	var objid = layerid+"_bt";
	AllChange(objid);
	ShowLayer(layerid);
	//obj.className="title_on";
}

function AllChange(layerid)
{
	var obj=new Array("qzxx_bt","xffk_bt","xfcx_bt");
	for(i = 0;i<obj.length;i++)
	{
		if(obj[i]==layerid)
		{
			eval(obj[i]+".className='title_on';");
		}
		else
		{
			eval(obj[i]+".className='title_down';");
		}	
	}
}

function ShowLayer(layerid)
{
	var layerobj=new Array("qzxx","xffk","xfcx");
	for(i=0;i<layerobj.length;i++)
	{
		if(layerobj[i]==layerid)
		{
			eval("document.all."+layerid+".style.display='';");
		}
		else
		{
			eval("document.all."+layerobj[i]+".style.display='none';");
		}
	}
}

function ChangeOption(ObjValue, DesName)
{
	Eval("document.all."+DesName+".length= 0");
	//Add NEW OPTIONS

	var t = eval("document.all." + DesName + "_items.value")
	var tt = t.split(";");
	j = 0;
	for(i=0;i<tt.length;i++)
	{
		var kk = tt[i].split(",");
		

		if(kk[0]==ObjValue)
		{
			eval("document.all." + DesName + ".options[j]= new Option(kk[2], kk[1])");
			j++;
		}

	}
}//function

function AddItem(ObjName, DesName, CatName)
{
  //GET OBJECT ID AND DESTINATION OBJECT
  ObjID    = GetObjID(ObjName);
  DesObjID = GetObjID(DesName);
  CatObjID = GetObjID(CatName);

  if ( ObjID != -1 && DesObjID != -1 && CatObjID != -1 )
  {   hasNum = overalert(DesObjID);
      if (hasNum == 5)
         window.alert("最多选五项。");
      else
      {  //GET SELECTED ITEM NUMBER
         SelNum = 0;
         for (var j=0; j<eval("document.all." + ObjName + ".length"); j++)
         {   if (eval("document.all." + ObjName + ".options[j].selected"))
             SelNum ++;
         }
         if ((SelNum + hasNum) > 5)
            window.alert("最多选五项。");
         else
         {  jj       = eval("document.all."+CatName+".selectedIndex");
            CatValue = trimPrefixIndent(eval("document.all."+CatName+".options[jj].text"));
            CatCode  = eval("document.all."+CatName+".options[jj].value");
            i        = eval("document.all." + ObjName +".options.length");
            j        = eval("document.all."+DesName+".options.length");
            for (h=0; h<i; h++)
            {   if (eval("document.all." + ObjName +".options[h].selected") )
                {  Code = eval("document.all." + ObjName +".options[h].value");
                   Text = trimPrefixIndent(eval("document.all." + ObjName +".options[h].text"));
                   j    = eval("document.all."+DesName+".options.length");

                   HasSelected = false;
                   for (k=0; k<j; k++ )
                   if (eval("document.all."+DesName+".options[k].value == Code"))
                   {  HasSelected = true;
                      break;
                   }
                   if (HasSelected == false)
                   {  Location = GetLocation(DesObjID, CatValue);
					  if (Location == -1 )
                      {  eval("document.all."+DesName+".options[j] =  new Option(\"---\"+CatValue+\"---\",CatCode)");
                         eval("document.all."+DesName+".options[j+1] = new Option(Text, Code)");
                      }
                      else
                      {  InsertItem(DesObjID, Location+1);
                         eval("document.all."+DesName+".options[Location+1] = new Option(Text, Code)");
                      }
                   }
                   else
                       window.alert("此项已选择。");
                }
            }
         }//else
      }//else
      //CLEAR SELECTION
      for (i=0; i<eval("document.all."+ObjName+".length"); i++)
          eval("document.all."+ObjName+".options[i].selected = false");

  }//if
}//end of function

function IsSelected(Name, Value)
{
	for (var cc=0; cc < eval("document.all." + Name + ".length"); cc++ )
	{
		if (eval("document.all." + Name + ".options[cc].value == Value"))
		return true;
	}
	return false;
}

function HasTotal(Name)
{
		for (var cc=0; cc<eval("document.all." + Name + ".length"); cc++ )
		{
			if(eval("document.all." + Name + ".options[cc].selected"))
			{
				if(eval("document.all." + Name + ".options[cc].value == \"0000\""))
				{
					return true;
				}
			}
		}
		return false;
}

function AppendItem(ObjName, DesName)
{
     if ( IsSelected(DesName, "0000") )
        window.alert("已包含");
     else
     {  if ( HasTotal(ObjName) )
        {  eval("document.all." + DesName + ".length = 0");
           eval("document.all." + ObjName + ".options[0]= new Option(\"---不限---\", \"0000\")");

        }
        else
        {  if (eval("document.all." + DesName + ".length == 5"))
              window.alert("最多选五项。");
           else
           {  //GET SELECTED ITEM NUMBER
              SelNum = 0;
              for (var j=0; j<eval("document.all."+ObjName+".length"); j++)
              {   if ( eval("document.all." + ObjName + ".options[j].selected"))
                  SelNum ++;
              }
              if ((SelNum + eval("document.all." + DesName + ".length")) > 5)
                 window.alert("最多选五项。");
              else
              {  //add
                 for (j=0; j<eval("document.all." + ObjName + ".length"); j++)
                 {   if (eval("document.all." + ObjName + ".options[j].selected"))
                     {  //GET VALUE
                        dd = eval("document.all." + ObjName + ".options[j].value");
                        //if (!IsSelected(DesObjID, dd))
						if (!IsSelected(DesName, dd))
                        {  //GET LENGTH
                           DesLen = eval("document.all." + DesName + ".length");
                           // NEW OPTION
                           eval("document.all." + DesName + ".options[DesLen]= new Option(trimPrefixIndent(document.all." + ObjName + ".options[j].text), document.all." + ObjName + ".options[j].value)");
                        }
                        else
                           window.alert("此选项已选择。");

                     }
                 }
              }
           }
        }
     }
     //CLEAR
     for (j=0; j<eval("document.all." + ObjName + ".length"); j++)
          eval("document.all." + ObjName + ".options[j].selected = false");
  //}
}

function RemoveItem(ObjName)
{
		var  check_index = new Array();
		for(i=eval("document.all." + ObjName + ".length-1"); i>=0; i--)
		{
			if (eval("document.all." + ObjName + ".options[i].selected"))
			{
				check_index[i] = true;
				eval("document.all." + ObjName + ".options[i].selected = false");
			}
			else
			{
				check_index[i] = false;
			}
		}
		for(i=eval("document.all." + ObjName + ".length-1"); i>=0; i--)
		{
			if(check_index[i])
			eval("document.all." + ObjName + ".options[i] = null")
		}
	//}
}

function CheckForm_selvalue()
{
	SelectAll("aa_trade");
	SelectAll("aa_function");
	SelectAll("aa_address");
	SelectAll("aa_enterprisekind");
	return true;
}

function SelectAll(ObjName)
{
	if (ObjName != "")
	{
		eval("document.all."+ObjName+".value==\"\"");
		var ObjValue = "";;
		for (i=0; i<eval("document.all." + ObjName + "_ag.length"); i++)
		{
			eval("document.all." + ObjName + "_ag.options[i].selected = true");
			ObjValue += eval("document.all." + ObjName + "_ag.options[i].value") + ",";
		}
		eval("document.all."+ObjName+".value=\"" + ObjValue + "\"");
	}
}

function ShowDetail(Ui_id,Parameter,Value,Sort)
{
	window.location.href="PersonInfo.jsp?ui_id=" + Ui_id + "&" + Parameter + "=" + Value + "&sort=" + Sort;
}

function ShowInfo(ObjName)
{
	var ObjAll = new Array("edu","train","language","itskill","proex");
	for(i=0;i<ObjAll.length;i++)
	{
		eval("document.all." + ObjAll[i] + ".style.display=\"none\"");
	}
	if(ObjName!="")
	{
		eval("document.all." + ObjName + ".style.display=\"block\"");
	}
}

function Deldirectory(sm_id,projectid,sort)
{
	if(confirm("您确定要删除该信息？"))
	{
		window.location.href="DirectoryDel.jsp?sm_id=" + sm_id + "&pr_id=" + projectid + "&sort=" + sort;
	}
}

function Deldirectory_1(sm_id,projectid,sort)
{
	if(confirm("您确定要删除该信息？"))
	{
		window.close();
		opener.window.location.href="DirectoryDel.jsp?sm_id=" + sm_id + "&pr_id=" + projectid + "&sort=" + sort;
	}
}

function Editdirectory(sm_id,projectid,sort)
{
	window.open("DirectoryEdit.jsp?sm_id=" + sm_id + "&pr_id=" + projectid + "&sort=" + sort,"123","Top=100px,Left=200px,Width=800px, Height=380px,toolbar=no,location=no,derectories=no,status=no,menubar=no,scrollbars=no");
}

function AddHear()
{
	try
	{
		var content = document.all.modle.innerHTML;
		var tr_line = document.createElement("div");
		var obj = document.getElementById("hearwindow")
		tr_line.innerHTML = content;
		obj.appendChild(tr_line);
		//alert(document.all.asd.innerHTML)
	}
	catch(e)
	{
		alert("系统错误，或是您的系统不支持javascript，请检查相关设置后重试！");
	}
}

function DeleteHear(obj)
{
	try
	{
		var PP = obj.parentNode.parentNode.parentNode;
		PP.removeNode(true);
	}
	catch(e)
	{
		alert("系统错误，或是您的系统不支持javascript，请检查相关设置后重试！");
	}
}

function CheckCheck()
{
	try
	{
		var obj = document.all.check_hw;
		if(obj!=undefined)
		{
			if(obj.length==undefined)
			{
				Changecc(obj);
			}
			else
			{
				for(i=0;i<obj.length;i++)
				{
					if(obj[i].checked)
					{
						Changecc(obj[i]);
					}
				}
			}
		}
		else
		{}
	}
	catch(e)
	{}
	//alert(obj.length);
}

function AllCheckNull()
{
	try
	{
		var obj = document.all.check_hw;
		if(obj!=undefined)
		{
			if(obj.length==undefined)
			{
				ChageStyle(obj,"1")
			}
			else
			{
				for(i=0;i<obj.length;i++)
				{
					ChageStyle(obj[i],"1")
				}
			}
		}
		else
		{}
	}
	catch(e)
	{
		alert("系统错误，或是您的浏览器不支持javascript,请检查相关设置后重试！");
	}
}

function ChageStyle(obj,status)
{
	try
	{
		var cc = obj.parentNode.parentNode;
		switch(status)
		{
			case "0":
				cc.childNodes[1].style.color="#000000";
				cc.childNodes[0].childNodes[0].checked = true;
				break;
			case "1":
				cc.childNodes[1].style.color="#9A9A9A";
				cc.childNodes[0].childNodes[0].checked = false;
				break;
			default:
				break;
		}
	}
	catch(e)
	{
		alert("系统错误，或是您的浏览器不支持javascript,请检查相关设置后重试！");
	}
}

function Changecc(obj)
{
	try
	{
		if(obj.checked)
		{
			ChageStyle(obj,"0");
		}
		else
		{
			ChageStyle(obj,"1");
		}
	}
	catch(e)
	{
		alert("系统错误，或是您的浏览器不支持javascript,请检查相关设置后重试！");
	}
}

function ChangeHear(DID)
{
	try
	{
		CheckCheck();
		var obj = document.all.hearwindow_list;
		if(obj!=undefined)
		{
			if(obj.length==undefined)
			{
				if(obj!=undefined)
				{
					if(obj.value==DID)
					{
						obj.style.display="";
					}
				}
			}
			else
			{
				for(i=0;i<obj.length;i++)
				{
					obj[i].style.display="none";
					if(obj[i].value==DID)
					{
						obj[i].style.display="";
					}
				}
			}
		}
		else
		{
			alert("您还没有维护 [ 受理窗口 ] 信息，这样会导致您无法完成办事事项的输入工作！\n\n请先在 [ 导航] > [ 个人设置 ] > [ 部门信息维护 ] 中添加！");
		}
	}
	catch(e)
	{
		alert("系统错误，或是您的浏览器不支持javascript,请检查相关设置后重试！");
	}
}

function onChange()
{
	AllCheckNull();
	ChangeHear(document.all.departId.value);
}

function EditDC()
{
	if (formData.sm_name.value=="")
	{
		alert("标题不能为空！");
		formData.sm_name.focus();
		return false;
	}
	GetDatademo123();
	formData.method = "post";
	formData.action = "DirectoryEditResult.jsp";
	formData.submit();
}

function checkForm()
{
	try
	{
		var obj ;
		var obj1;
		if (formData.projectName.value=="")
		{
			alert("[ 概述 ] 事项名称 不能为空！");
			ChangeC("summarize");
			formData.projectName.focus();
			return false;
		}

		var check_hw = document.all.check_hw;
		var status = false;
		if(check_hw!=undefined)
		{
			if(check_hw.length!=undefined)
			{
				for(j=0;j<check_hw.length;j++)
				{
					if(check_hw[j].checked)
					{
						status = true;
					}
				}
			}
			else
			{
				if(check_hw.checked)
				{
					status = true;
				}
			}
		}
		if(!status)
		{
			alert("请选择 [ 概述 ] 受理窗口！\n\n如果没有选项，请先在 [ 导航] > [ 个人设置 ] > [ 部门信息维护 ] 中添加！");
			ChangeC("summarize");
			return false;
		}
		
		if (formData.pr_worktime.value=="")
		{
			alert("[ 概述 ] 受理时间 不能为空！");
			ChangeC("summarize");
			formData.pr_worktime.focus();
			return false;
		}
		
		if(!formData.extempore.checked)
		{
			if (formData.pr_timeLimit.value=="")
			{
				alert("[ 概述 ] 受理时限 不能为空！");
				ChangeC("summarize");
				formData.pr_timeLimit.focus();
				return false;
			}
			else
			{
				if(isNaN(formData.pr_timeLimit.value))
				{
					alert("[ 概述 ] 受理时限 请填写数字！");
					ChangeC("summarize");
					formData.pr_timeLimit.focus();
					return false;
				}
			}
		}
		/*if (formData.dept.value=="")
		{
			alert("办理部门不能为空！");
			formData.dept.focus();
			return false;
		}*/
		/*if(!formData.pr_prokind[0].checked&&!formData.pr_prokind[1].checked)
		{
			alert("请选择事项类别！");
			formData.pr_prokind[0].focus();
			return;
		}
		if (formData.pr_timeLimit.value!="")
		{
			if (isNaN(formData.pr_timeLimit.value.replace(/^[\s]+|[\s]+$/,"")))
			{
				alert("项目时限必须为数字！");
				formData.pr_timeLimit.value="";
				formData.pr_timeLimit.focus();
				return false;
			}
		}*/
		if (formData.commonWork.length<=0)
		{
			alert("[ 基本信息维护 ] 生命周期不能为空！");
			ChangeC("qzxx");
			return false;
		}
		if (formData.ckk_name.length<=0)
		{
			alert("[ 基本信息维护 ]办事类别不能为空！");
			ChangeC("qzxx");
			return false;
		}
		/*if (formData.sortWork.selectedIndex==0)
		{
			alert("请选择分类导航！");
			return false;
		}
		if(typeof(formData.ga_sortid)!="undefined")
		{
			if (formData.ga_sortid.selectedIndex==0)
			{
				alert("请选择部门事项分类！");
				formData.ga_sortid.focus();
				return false;
			}
		}*/
		/*if (formData.pe_tel.value=="")
		{
			alert("咨询电话不能为空！");
			formData.pe_tel.focus();
			return false;
		}*/
		
		obj = formData.fj1;
		obj1 = formData.fjsm1;//附件说明的文本输入框
		var obj2 = formData.notUpload1;
		var obj3 = formData.notUpload;
		var length;
		if(typeof(obj)!="undefined")
		{
			if(typeof(obj.length)=="undefined")//只上传了一个附件
			{
				if(obj.value!="")
				{
					if(obj1.value=="")
					{
						alert("附件说明不能为空！");
						obj1.focus();
						return false;
					}
					else
					{
						if (obj2.checked)
							obj3.value = "0";
					}
				}
			}
			else
			{
				length = obj.length;
				for(var i=0;i<length;i++)
				{
					if(obj[i].value!="")
					{
						if(obj1[i].value=="")
						{
							alert("附件说明不能为空！");
							obj1[i].focus();
							return false;
						}
						else
						{
							if (obj2[i].checked)
								obj3.value = "0";
						}
					}
				}
			}
		}
		if(!GetSumData())
		{
			ChangeC("directory");
			return false;	
		}
		//GetDatademo();
		getCWInfo();
		//if(formData.dt_content.value.length>25000)
		//{
		//	alert("你输入办事指南内容字节数超过25k，请确认输入内容是否正确\n\n请不要直接从word文档中粘贴文件！！！\n\n请把你的word文档粘贴到记事本中去除格式后，再粘贴到办事指南文本框中");
		//	return;
		//}
		
		/*if(formData.pr_summarize.value.length>10000)
		{
			alert("你输入常见问题内容字节数超过10k，请确认输入内容是否正确\n\n请不要直接从word文档中粘贴文件！！！\n\n请把你的word文档粘贴到记事本中去除格式后，再粘贴到常见问题文本框中");
			return;
		}
		if(formData.pr_notice.value.length>10000)
		{
			alert("你输入办事须知内容字节数超过10k，请确认输入内容是否正确\n\n请不要直接从word文档中粘贴文件！！！\n\n请把你的word文档粘贴到记事本中去除格式后，再粘贴到办事须知文本框中");
			return;
		}*/
		btnObj.style.display="none";
		confirmObj.style.display="";
		formData.action = "ProceedingInfoResult.jsp";
		formData.submit();
	}
	catch(e)
	{
		alert("系统错误，或是您的浏览器不支持javascript,请检查相关设置后重试！");
	}
}

function GetSumData()
{
	var status = true;
	var obj = document.getElementById("sumlist");
	var _obj = obj.childNodes;
	for(i=0;i<_obj.length;i++)
	{
		var oc_demo = _obj[i].getElementsByTagName("iframe");
		var oc_text = _obj[i].getElementsByTagName("textarea");
		var oc_input = _obj[i].getElementsByTagName("input");
		//alert(oc_input.length);
		//alert(oc_text.length);
		if(oc_input.length==oc_demo.length==oc_text.length)
		{
			for(j=0;j<oc_demo.length;j++)
			{
				//alert(oc_demo.length);
				//alert(oc_demo[j].id);
				var demoname = oc_demo[j].id
				if(oc_input[j].value==""&&(ChangeHtml(demoname)==""||ChangeHtml(demoname)=="<DIV></DIV>"))
				{
					//alert("请输入办事指南条目标题！");
					//return false;
					//status = true;
				}
				else
				{
					if(oc_input[j].value==""&&(ChangeHtml(demoname)!=""&&ChangeHtml(demoname)!="<DIV></DIV>"))
					{
						alert("请输入第 "+eval(i+1)+" 条办事指南条目标题！");
						status = false;
					}
					else if(oc_input[j].value!=""&&(ChangeHtml(demoname)==""||ChangeHtml(demoname)=="<DIV></DIV>"))
					{
						alert("请输入第 "+eval(i+1)+" 条办事指南条目内容！");
						status = false;
					}
					else
					{
						oc_text[j].value = ChangeHtml(demoname);
						//status = true;
					}
				}
			}
		}
	}
	return status;
}

function getCWInfo()
{
	var obj1 = formData.cwList;
	var obj2 = formData.cwDesc;
	var obj3 = formData.commonWork;

	var obj5 = formData.ckkname;
	var obj6 = formData.ckk_name;

	var length = obj3.length;
	var length_1 = obj6.length;

	var strList = "";
	var strDesc = "";

	for (var i=0;i<length;i++)
	{
		strList += obj3.options[i].value + ",";
		strDesc += obj3.options[i].text + ",";
	}
	if (strList!="")
	{
		obj1.value = strList.substring(0,strList.length-1);
		obj2.value = strDesc.substring(0,strDesc.length-1);
	}

	strList = "";
	strDesc = "";

	for (var i=0;i<length_1;i++)
	{
		//strList += obj6.options[i].value + ",";
		strDesc += obj6.options[i].value + "," + obj6.options[i].text + ";";
	}
	if (strDesc!="")
	{
		//obj4.value = strList.substring(0,strList.length-1);
		obj5.value = strDesc.substring(0,strDesc.length-1);
	}
}
var x;
var xx;
var y;
var yy;
var status = false;
var mx;
var my;
function CreatDiv(obj)
{
	try
	{
		//alert(obj.offsetLeft);
		getIE(obj);
		var my_line = document.createElement("div");		
		my_line.id = "div1";
		my_line.name = "div1";
		my_line.style.width = obj.childNodes[0].width;
		my_line.style.position = "absolute";
		my_line.style.left = mx;
		my_line.style.top = my;
		my_line.disabled=true;
		//my_line.style.border="1px solid #6699FF";
		//my_line.style.background="#F7F7F7";
		//my_line.innerHTML = "<table class='main-table' width='100%'><tr><td><table cellspacing='0' align='center' cellpadding='0' width='98%' border='0'><tr></td>"+obj.innerHTML+"</td></tr></table></td></tr></table>";
		my_line.innerHTML = obj.innerHTML;
		//obj.removeNode(true);
		my_line.childNodes[0].style.border="1px solid #C7DFF1";
		document.body.appendChild(my_line);
		xx = event.clientX
		yy = event.clientY
		status = true;
		//obj.disabled=true;
		obj.style.visibility = "hidden";
		drag(document.getElementById("div1"),obj);
		//move();
		//alert(document.all.asd.innerHTML)
	}
	catch(e)
	{
		alert("系统错误，或是您的系统不支持javascript，请检查相关设置后重试！");
	}
}
function getIE(e)
{
	var t=e.offsetTop;
	var l=e.offsetLeft;
	while(e=e.offsetParent)
	{
		t+=e.offsetTop;
		l+=e.offsetLeft;
	}
	mx = l;
	my = t;
//alert("top="+t+"/nleft="+l);
}

function Distory(obj)
{
	try
	{
		obj.removeNode(true);
	}
	catch(e)
	{
		alert("222");
	}
}
function GetPosition()
{
	if(status)
	{
		x = event.clientX;
		y = event.clientY;
		//move();
	}
}

function drag(o,obj)
{
	try
	{
		document.body.onmouseup=function()
		{
			try
			{
				Distory(o);
				//obj.disabled=false;
				obj.style.visibility = "visible"
				status = false;
			}
			catch(e)
			{
				alert("111");
			}
		}
		document.body.onmousemove=function()
		{
			GetPosition();
			div1.style.left = document.body.scrollLeft + x - xx + mx;
			div1.style.top = document.body.scrollTop + y - (yy - my);
		}
	}
	catch(e)
	{
		alert("333");
	}
}

var beginMoving=false;
var sourceObj=null;
var objectObj=null;
var objectObj2=null;
var position = new Array(new Array(),new Array());
function down(obj)
{
	try
	{
		objposition();
		obj.style.zIndex = 1;
		//obj.style.border = "1px solid red";
		obj.className = "disremovableObj";
		obj.mouseDownY = event.clientY;
		obj.mouseDownX = event.clientX;
		beginMoving = true;
		obj.setCapture();
		sourceObj = obj;
		objectObj = null;
	}
	catch(e)
	{
		alert("111");
	}
}

function move(obj)
{
    try
	{
		if(!beginMoving) return false;
		obj.style.top = (event.clientY-obj.mouseDownY);
		obj.style.left = (event.clientX-obj.mouseDownX);
		for(i=0;i<position.length;i++)
		{
			//alert(position[1][i] +">"+ event.clientY);
			//position[0][i].disabled=false;
			if(event.clientY < position[1][i])
			{	
				changeobj(i);
			}
		}
	}
	catch(e)
	{
		alert("222");
	}
}

function changeobj(obj)
{
	//position[0][obj-1].className="addObj";
	//change(position[0][obj],position[0][obj-1]);
}

function change(obj,_obj)
{
	_obj.insertAdjacentElement("beforeBegin",obj);
	objposition();
}

function up(obj)
{
	if(!beginMoving) return false;
	obj.releaseCapture();
	obj.style.top=0;
	obj.style.left=0;
	obj.style.zIndex=0;
	obj.className = "removableObj";
	beginMoving=false;
	window.setTimeout("swapFun()",20);
}
function swapFun()
{
	if(sourceObj!=null && objectObj!=null) objectObj.insertAdjacentElement("beforeBegin",sourceObj);
	//else if(sourceObj!=null && objectObj2!=null) objectObj2.insertAdjacentElement("beforeEnd",sourceObj);//不同td之间移动
	sourceObj=null;
	objectObj=null;
	objectObj2=null;
}

function over(obj)
{
	objectObj2=obj;
}

function overFun(obj)
{
	if(obj==sourceObj) return false;
	objectObj=obj;
}

function objposition()
{
	var sobj = document.all.svalue;
	for(i=0;i<sobj.length;i++)
	{
		position[0][i] = sobj[i];
		position[1][i] = sobj[i].offsetTop;
		//alert(sobj[i].offsetTop);
	}
}
/*function move_1(obj)
{
	try
	{
		if(status)
		{
			document.body.onmouseup=function()
			{
				try
				{
					
					if(status&&obj!=undefined)
					{
						//obj.style.visibility = "visible"
						obj.style.position = "";
						obj.parentNode.innerHTML = "<div onmousedown=\"pp(this);\" style=\"cursor:move;\">"+obj.innerHTML+"</div>";
						Distory(obj);
						//obj.style.left = mx;
						//obj.style.top = my;
						obj.disabled=false;
						status = false;
					}
				}
				catch(e)
				{
					alert("111");
				}
			}
			document.body.onmousemove=function()
			{
				GetPosition();
				obj.style.left = document.body.scrollLeft + x - xx + mx;
				obj.style.top = document.body.scrollTop + y - (yy - my);
			}
		}
	}
	catch(e)
	{
		alert("333");
	}
}*/

function Limit(target,target2,obj)
{
	if(obj.checked)
	{
		eval("document.all."+target+".value='';");
		eval("document.all."+target+".className='text-line_1';");
		eval("document.all."+target+".disabled = true;");
		eval("document.all.pr_timeLimittext.style.color = '#9A9A9A';");

		eval("document.all."+target2+".value='';");
		eval("document.all."+target2+".className='text-line_1';");
		eval("document.all."+target2+".disabled = true;");
		eval("document.all.pr_dotimetext.style.color = '#9A9A9A';");
		eval("document.all.extemporetext.style.color = '#000000';");
	}
	else
	{
		eval("document.all."+target+".className='text-line';");
		eval("document.all."+target+".disabled = false;");
		eval("document.all.pr_timeLimittext.style.color = '#000000';");

		eval("document.all."+target2+".className='text-line';");
		eval("document.all."+target2+".disabled = false;");
		eval("document.all.pr_dotimetext.style.color = '#000000';");

		eval("document.all.extemporetext.style.color = '#9A9A9A';");
	}
}

function AddLimit(status,target,obj)
{
	try
	{
		if(status==""||status=="0") obj.checked = true;	
		//Limit(target,obj);
	}
	catch(e)
	{}
}