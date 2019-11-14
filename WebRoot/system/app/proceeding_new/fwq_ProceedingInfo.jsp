<%@page contentType="text/html; charset=GBK"%>
<%@include file="/system/app/skin/head.jsp"%>
<script language="javascript" src="common.js"></script>
<%
String projectId      = "";
String commonWorkId   = "";
String sortWorkId     = "";
String projectName    = "";
String departIdOut    = "";
String departId       = "";
String dt_content     = "";
String sqlStr         = "";
String pr_imgpath     = "";  //流程图片保存的相对路径
String pr_img 	      = "";  //事项说明图片保存的路径
String pr_attachpath  = "";
Vector vPage          = null;
String strTitle       = "网上办事>>新增";
String pr_timeLimit   = "";   //项目的时限
String pr_code        = "";   //项目编号
String strCWorkName   = "";   //按照用户类型排列的常用事务
String strCWorkId     = "";
String pr_url	      = "";
String pr_isaccept    = "";
String isChecked      = "";
String isDisabled     = "";
String isReadonly     = "";
String OType          = "";
String sequence		  = "";   //事项的排序字段
String pr_edittime    = "";
String pr_isdel		  = "";
String isCheck        = "";
String pr_gut         = "";
String pd_uk_id		  = "";
String pr_sourcedtid  = ""; //来源部门
String pr_cc = "";
String pr_root = "";
String pr_table = "";
String pr_gisaddress = "";//gis地图地址
String iscc = "";
String isd = "";
String  seldept="";
isd = "none";
com.app.CMySelf mySelf = (com.app.CMySelf)session.getAttribute("mySelf");
String curdt_id = String.valueOf(mySelf.getDtId());
String user_id = String.valueOf(mySelf.getMyUid());
//update by dongliang 20090106
String curpage= CTools.dealString(request.getParameter("curpage"));
//
String ga_sortId = "";//分类ID
String pr_blcx  ="";
String pr_by="";//办事依据
String pr_area = "";//办事范围
String pr_stuff="";//办事
String pr_money="";//办事费用
String pr_telephone="";//电话
String pr_tstype="";//投诉类型
String pr_sxtype="";//类型
String pr_address="";//投诉地址
String pr_tstel="";
String pr_tsemail="";//投诉email
String pr_qt="";//其它投诉 
String pr_bc = "";//不能明确办理时限的补充
Hashtable gutMap = null;
String gutid = "";
String gutvalue = "";
//新建数据连接
CDataCn dCn = null;
CDataImpl dImpl = null;
try{
dCn = new CDataCn();
dImpl = new CDataImpl(dCn);
//新建数据连接结束
projectId = CTools.dealString(request.getParameter("projectId")).trim();
OType = CTools.dealString(request.getParameter("OType")).trim();
if ((OType.equals("Edit")||mySelf.getMyUid().equals("admin"))||!projectId.equals(""))
{
	if(projectId == null)
		 projectId ="0";
	sqlStr = "select sw_id,pr_name,pr_sourcedtid,dt_idext,dt_id,pr_imgpath,pr_flowimgpath,pr_timelimit,pr_code,pr_url,";
	sqlStr += "pr_isaccept,pr_sequence,to_char(pr_edittime,'yyyy-mm-dd') pr_edittime,pr_isdel,uk_id,pr_gut,pr_cc,pr_root,pr_table,pr_by,pr_area,pr_stuff,pr_blcx,pr_money,pr_telephone,pr_tstype,pr_sxtype,pr_address,pr_tstel,pr_tsemail,pr_qt,pr_bc,pr_gisaddress from tb_proceeding_new where pr_id = '" + projectId + "'  ";
	strTitle     = "网上办事>>管理";
	Hashtable content = dImpl.getDataInfo(sqlStr);
	if (content!=null){
		sortWorkId   = content.get("sw_id").toString();
		projectName  = content.get("pr_name").toString();
		departIdOut  = content.get("dt_idext").toString();
		departId     = content.get("dt_id").toString();
		pr_by   = content.get("pr_by").toString();
		pr_area   = content.get("pr_area").toString();
		pr_stuff   = content.get("pr_stuff").toString();
		pr_blcx   = content.get("pr_blcx").toString();
		pr_money	=content.get("pr_money").toString();
		pr_telephone	=content.get("pr_telephone").toString();
		pr_tstype	=content.get("pr_tstype").toString();//投诉地址
		pr_tstel	=content.get("pr_tstel").toString();//投诉电话
		pr_tsemail	=content.get("pr_tsemail").toString();//投诉email
		pr_qt	=content.get("pr_qt").toString();//其它
		pr_bc   =content.get("pr_bc").toString();//不能明确办理时限的补充
		pr_address	=content.get("pr_address").toString();
		pr_sxtype	=content.get("pr_sxtype").toString();
		pr_imgpath   = content.get("pr_imgpath").toString();
		pr_img	     = content.get("pr_flowimgpath").toString();
		pr_timeLimit = content.get("pr_timelimit").toString();
		pr_code      = content.get("pr_code").toString();
		pr_url	     = content.get("pr_url").toString();
		pr_isaccept  = content.get("pr_isaccept").toString();
		sequence	 = content.get("pr_sequence").toString();
		pr_edittime	 = content.get("pr_edittime").toString();
		pr_isdel	 = content.get("pr_isdel").toString();
		pd_uk_id 	 = content.get("uk_id").toString();
		pr_gut		 = content.get("pr_gut").toString();
		pr_cc		 = content.get("pr_cc").toString();
		pr_root		 = content.get("pr_root").toString();
		pr_table	 = content.get("pr_table").toString();
		pr_sourcedtid= content.get("pr_sourcedtid").toString();
		pr_gisaddress = content.get("pr_gisaddress").toString();
		if (sequence.equals("")) sequence = "-10";
		if (pr_isaccept.equals("1")) isChecked = "checked";
		if (!pr_isdel.equals("1")){
			isCheck = "";
		}else{
			isCheck = "checked";
		}

		if("1".equals(pr_cc)){
			iscc = "checked";
			isd = "";
		}

	}
	sqlStr = "select distinct pa_path from tb_proceedingattach_new where pr_id = '"+ projectId+"'";
	
	content = dImpl.getDataInfo(sqlStr);
	if (content!=null){
		pr_attachpath = content.get("pa_path").toString();
	}

	String ga_sortsql = "";
	Hashtable ga_content = null;
	ga_sortsql = "select a.gw_id from tb_gasortwork a,tb_worklinksort_new b where a.gw_id=b.gw_id and b.pr_id='"+projectId+"'";

	ga_content = dImpl.getDataInfo(ga_sortsql);
	if(ga_content!=null){
		ga_sortId = ga_content.get("gw_id").toString();
	}
}
if (OType.equals("view")&&!mySelf.getMyUid().equals("admin")){
	isDisabled = "disabled";
	isReadonly = "readonly";
	strTitle     = "网上办事>>查看";
}

String dept_id = pr_sourcedtid;
String dept_name = "";
if(dept_id ==null || dept_id.equals(""))
	dept_id = curdt_id;
String sql_dt  = "select dt_name from tb_deptinfo where dt_id=" + dept_id;
Hashtable content_dt = dImpl.getDataInfo(sql_dt);

if(content_dt!=null)
{
	dept_name = content_dt.get("dt_name").toString();
}
if (!curdt_id.equals(dept_id)) dept_id = curdt_id;
if (departId.equals("")) departId = curdt_id;
%>
<script language="javascript" src="/system/include/common.js"></script>
<script language="javascript" src="/system/include/change.js"></script>
<script type="text/javascript" src="editor/fckeditor.js"></script>
<script language="javascript">
//当所选用户类型改变时,改变对应的常办事项
function ukChange()
{
	var obj = formData.userKind;
	var index = obj.selectedIndex;

	var subCWName = initCWArray(formData.strCommonWork);
	var subCWId = initCWArray(formData.strCommonId);
	clearAll(formData.commonWork1);
	if (index<subCWId.length)
	{
		var cwNames = subCWName[index].split(",");
		var cwIds   = subCWId[index].split(",");
		addItems(cwIds,cwNames,formData.commonWork1);
	}
	return false;
}

function deleteFile(fileName)
{
	if(confirm("确认要删除该文件吗？"))
	{
		var obj = formData.projectId;
		var url = "attachDel.jsp?fileName="+fileName;
		url += "&projectId="+obj.value;
		window.location = url;
	}
}

function openImgWindow(val)
{
	  var w = 400;
	  var h = 500;
	  var url = "";
	  if(val=="forFlow")
	  {
	  	url = "attachInfoImg.jsp";
	  	var pr_imgpath = document.formData.pr_imgpath.value;
	  	url = url + "?pr_imgpath="+ pr_imgpath;
	  }
	  else if(val=="forExplain")
	  {
	  	url = "ExplainInfoImg.jsp";;
	  	var pr_img = document.formData.pr_img.value;
	  	url = url+"?pr_img="+pr_img;
	  }
	  window.open( url, "upload", "Top=0px,Left="+(screen.availWidth-w-30)+"px,Width="+w+"px, Height="+h+"px,toolbar=no,location=no,derectories=no,status=no,menubar=no,scrollbars=yes" );
}

function Display(Num)
{
	var obj=eval("Info"+Num);
	var objImg=event.srcElement;

	if (typeof(obj)=="undefined") return false;
	if (obj.style.display=="none")
	{
		obj.style.display="";
		objImg.src="/system/images/topminus.gif";
	}
	else
	{
		obj.style.display="none";
		objImg.src="/system/images/topplus.gif";
	}
}

function setHtml()
{
	demo2.setHTML (formData.dt_content.value);
}

function deleteThis(val)
{
	  if(confirm("此操作将删除所有和本项目相关的办事事项，确实要删除吗？"))
	  {
		    formData.action = "ProceedingInfoDel.jsp?projectId="+val;
		    formData.submit();
	  }
}

function ChangeHtml(obj)
{
	var re = "/<"+"script.*.script"+">/ig";
	var re2 = /(src=\")(http|https|ftp):(\/\/|\\\\)(.[^\/|\\]*)(\/|\\)/ig;
	var Html2=eval(obj+".getHTML()");
	Html2 = Html2.replace(re,"");
	return Html2;
}

function ChangeOption(ObjValue, DesName)
{
	//modify by phayzy
	eval("document.all."+DesName+".length= 0");
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
}
function IsOnline(obj,ID)
{
	if(obj.checked)
	{
		eval("document.all."+ID+".style.display='';");
	}
	else
	{
		eval("document.all."+ID+".style.display='none';");
		eval("document.all.pr_url.value='';");
	}
}
</script>
<script language="vbscript">
'新增附件
function AddAttach1()
dim count_obj,tr_obj,td_obj,file_obj,form_obj,count,table_obj
dim button_obj,countview_obj
dim str1,str2

set form_obj=document.getElementById("formData")
set fj_obj=document.getElementById("TdInfo1")
if fj_obj.innertext="无附件" then
   fj_obj.innertext=""
end if

set count_obj=document.getElementById("count_obj")
if (count_obj is nothing) then
	set count_obj=document.createElement("input")
	count_obj.type="hidden"
	count_obj.id="count_obj"
	count_obj.value=1

	form_obj.appendChild(count_obj)
	count=1
	count_obj.value=1
else
	set count_obj=document.getElementById("count_obj")
	count=cint(count_obj.value)+1
	count_obj.value=count
end if

set div_obj=document.createElement("div")
div_obj.id="div_"&cstr(count)
fj_obj.appendchild(div_obj)
str1 = "<hr style='border-top-style: dotted; border-top-width: 1; border-bottom-style: dotted; border-bottom-width: 1' dotted; border-top-width: 1; border-bottom-style: dotted; border-bottom-width: 1 size=0 noshade color=#000000>"
str1 = str1 & "附件名称："
str1 = str1 & "<input type='file' name='fj1' size=30 class='text-line' id=fj1'>"
str2="<br>附件标题：<input type='text' name='fjsm1'  size=30  class='text-line' maxlength=100 id='fjsm1'>"
strChk = "<br>不需上传：<input type='checkbox' name='notUpload1' class='checkbox1'><input type='hidden' name='notUpload' value='1'>(如选择，则表示用户实际办理这个事项的时候不需要提交该文件！)"
str3="&nbsp;<img src='/system/images/delete.gif' class=hand onclick='vbscript:delthis1("+""""+div_obj.id+""""+")' id='button1' name='button1'>"
div_obj.innerHtml=str1 + str2 + str3 + strChk
end function

'删除函数
function delthis1(id)
dim child,parent
set child_t=document.getElementById(id)
if  (child_t is nothing ) then
	alert("对象为空")
else
	call DelMain1(child_t)
end if
set parent=document.getElementById("TdInfo1")
if parent.hasChildNodes() =false then
   parent.innerText="无附件"
end if
end function

function DelMain1(obj)
dim length,i,tt
set tt=document.getElementById("table_obj")
if (obj.haschildNodes) then
 length=obj.childNodes.length
 for i=(length-1) to 0 step -1
	 call DelMain1(obj.childNodes(i))
	 if obj.childNodes.length=0 then
		obj.removeNode(false)
	 end if
 next
else
obj.removeNode(false)
end if
end function
</script>
<script language="javascript">
var url = "";
function isAccept()
{
	var objCBox = document.formData.pr_isaccept;
	var objUrl = document.formData.pr_url;
	objUrl.readOnly = !objCBox.checked;
	if (!objCBox.checked)
	{
		url = objUrl.value;
		objUrl.value="";
	}
	else
	{
		objUrl.value="<%=pr_url%>";
	}
}

function deleteFile(fileName)
{
	if(confirm("确认要删除该文件吗？"))
	{
		var obj = formData.projectId;
		var url = "attachDel.jsp?fileName="+fileName;
		url += "&projectId="+obj.value;
		window.location = url;
	}
}

function openImgWindow(val)
{
	  var w = 400;
	  var h = 500;
	  var url = "";
	  if(val=="forFlow")
	  {
	  	url = "attachInfoImg.jsp";
	  	var pr_imgpath = document.formData.pr_imgpath.value;
	  	url = url + "?pr_imgpath="+ pr_imgpath;
	  }
	  else if(val=="forExplain")
	  {
	  	url = "ExplainInfoImg.jsp";
	  	var pr_img = document.formData.pr_img.value;
	  	url = url+"?pr_img="+pr_img;
	  }
	  window.open( url, "upload", "Top=0px,Left=0px,Width="+w+"px, Height="+h+"px,toolbar=no,location=no,derectories=no,status=no,menubar=no,scrollbars=yes" );
}

function Display(Num)  //是否显示事项说明
{
	var obj=eval("Info"+Num);
	var objImg=eval("document.formData.InfoImg"+Num);

	if (typeof(obj)=="undefined") return false;
	if (obj.style.display=="none")
	{
		obj.style.display="";
		objImg.src="/system/images/topminus.gif";
	}
	else
	{
		obj.style.display="none";
		objImg.src="/system/images/topplus.gif";
	}
}
function GetDatademo() //初始化Html编辑器的内容
{
	var re = "/<"+"script.*.script"+">/ig";
	var re2 = /(src=\")(http|https|ftp):(\/\/|\\\\)(.[^\/|\\]*)(\/|\\)/ig;
	var Html1=demo1.getHTML();
	Html1 = Html1.replace(re2,"src=\"/");
	Html1 = Html1.replace(re,"");
	formData.dt_content.value=Html1;
}

function confirmSelect(target,val)
{
	var obj;
	eval("obj=formData"+"."+target);
	var length = 1;
	if(typeof(obj.options.length)!="undefined") length = obj.options.length;
	for(var i=0;i<length;i++)
	{
		if(obj.options[i].value==val)
		{
			obj.selectedIndex = i;
			break;
		}
	}
	return false;
}


function checkForm()
{
	var obj ;
	var obj1;
	var i ;
	if (formData.projectName.value=="")
	{
		alert("请填写事项名称！");
		formData.projectName.focus();
		return false;
	}
	
	if (formData.commonWork2.length<=0)
	{
		alert("请选择常用办事类别！");
		return false;
	}
	
	if (formData.sortWork.value=="")
	{
		alert("请选择分类办事类别！");
		formData.sortWork.focus();
		return false;
	}

	var flage = false;   
    var radios = document.forms[0].pr_sxtype;   
    for (var i = 0; i < radios.length; i++) {   
        if (radios[i].checked == true) {   
            flage = true; 
        }   
    }   
    if (!flage) {   
        alert("请选择事项类别！");   
        return false;   
    }  
	if (formData.pr_money.value=="")
	{
		alert("请填写收费标准！");
		formData.pr_money.focus();
		return false;
	}
	if (formData.pr_address.value=="")
	{
		alert("请填写办理地点！");
		formData.pr_address.focus();
		return false;
	}
	if (formData.pr_tstype.value=="")
	{
		alert("请填写监督投诉！");
		formData.pr_tstype.focus();
		return false;
	}

	if (isNaN(formData.pr_timeLimit.value))
	{
		alert("办理时限只能写数字！");
		formData.pr_timeLimit.focus();
		return false;
	}
	
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
	getCWInfo();
	formData.action = "ProceedingInfoResult.jsp";
	formData.pr_by.value=eWebEditor1.getHTML();
	formData.pr_area.value=eWebEditor2.getHTML();
	formData.pr_stuff.value=eWebEditor3.getHTML();
	formData.pr_blcx.value=eWebEditor4.getHTML();
	formData.submit();
}

function getCWInfo()
{
	var obj1 = formData.cwList;
	var obj2 = formData.cwDesc;
	var obj3 = formData.commonWork2;
	var length = obj3.length;
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
}

function initCWArray(obj)
{
	var str = obj.value;
	var subCW = str.split(";");
	return subCW;
}

function initCommonWork()
{
	var index = formData.userKind.selectedIndex;
	var subCWName = initCWArray(formData.strCommonWork);
	var subCWId = initCWArray(formData.strCommonId);
	var cwNames = subCWName[index].split(",");
	var cwIds   = subCWId[index].split(",");
	addItems(cwIds,cwNames,formData.commonWork1);
}

function addItems(ids,names,obj)
{
	for(var i=0;i<ids.length;i++)
	{
		var obj1 = document.createElement("OPTION");
		obj1.value=ids[i];
		obj1.text=names[i];
		obj.add(obj1);
	}
}

function clearAll(obj)
{
	while(obj.length>0)
	{
		obj.remove(0);
	}
}

//当所选用户类型改变时,改变对应的常办事项
function ukChange()
{
	var obj = formData.userKind;
	var index = obj.selectedIndex;

	var subCWName = initCWArray(formData.strCommonWork);
	var subCWId = initCWArray(formData.strCommonId);
	clearAll(formData.commonWork1);
	if (index<subCWId.length)
	{
		var cwNames = subCWName[index].split(",");
		var cwIds   = subCWId[index].split(",");
		addItems(cwIds,cwNames,formData.commonWork1);
	}
	return false;
}

//通过双击一个条目来添加到已选常办事项
function field_ondblclick()
{
	if (document.formData.commonWork1.selectedIndex<0)
	{
		return false;
	}

	for (var i=0;i<document.formData.commonWork2.length;i++)
	{
		if (document.formData.commonWork2.options[i].value==document.formData.commonWork1.options[document.formData.commonWork1.selectedIndex].value)
			return false;
	}
	var i_op=document.createElement("OPTION");
	i_op.text=document.formData.commonWork1.options[document.formData.commonWork1.selectedIndex].text;
	i_op.value=document.formData.commonWork1.options[document.formData.commonWork1.selectedIndex].value;
	document.formData.commonWork2.add(i_op);
}

//从已选常办事项里面删除一个
function delSelect()
{
	var obj = formData.commonWork2;
	var index = obj.selectedIndex;
	if (index<0)
	{
		return false;
	}
	else
	{
		obj.remove(index);
	}
}

function ic(o,t){
	var v = o.checked;
	var l = eval("document.all."+t+";");
	if(v){
		for(i = 0; i < l.length; i++){
			l[i].style.display = "";
		}
	}else{
		for(i = 0; i < l.length; i++){
			l[i].style.display = "none";
		}
	}
}
function forSearch(){
	var w = 400;
	var h = 500;
    var key = formData.pr_fagui.value;
	var url = 'FGSearchResult.jsp?key='+key;
	window.open( url, "upload", "Top=0px,Left="+(screen.availWidth-w-30)+"px,Width="+w+"px, Height="+h+"px,toolbar=no,location=no,derectories=no,status=no,menubar=no,scrollbars=yes" );

}
function checkName(o,d,p){
	try{
		var http = new ActiveXObject("Microsoft.XMLHTTP");
		var str;
		http.onreadystatechange = function (){
			if (http.readyState==4)	{
				str = http.responseText;
				while(str.indexOf("\n")!=-1||str.indexOf("\r")!=-1)
				{str = str.replace("\n","");str = str.replace("\r","");}
				if(str=="true") document.all.checkTip.innerHTML = "本部门已存在有相同名称的办事事项";
				else  document.all.checkTip.innerHTML = "";
				http.abort();
			}
		};
		url="/system/app/proceeding_new/checkName.jsp?pr_id="+p+"&dt_id="+d.value+"&pr_name="+o.value;
		http.open("GET",url,true);
		http.send();
	}catch(e){
	}
}
</script>
<script language="javascript">
function onlineTable(projectId,projectName){
var porId = projectId.replace("o","");
window.open("http://31.6.130.244/SynAdminProject/(S(bmafg0552eet2uqvf1u0rzj2))/DataManage/BusinessManage/BusiModelSet.aspx?affairID="+porId+"&ProjectName="+projectName+"","选择投诉转办类型","Top=200px,Left=200px,Width=900px,Height=500px,toolbar=no,location=no,derectories=no,status=no,menubar=no,resizable=no,scrollbars=yes");
}
</script>
<style>
.topic
{
	color:#333399;
	font-weight:bold;
}

.title_on
{
	border-left:1px solid #A2A2A2;
	border-right:1px solid #A2A2A2;
	border-top:4px solid #A2A2A2;
	font-weight:bold;
	/*cursor:hand;*/
	height:26px;
	width:90px;
}
.title_down
{
	border-left:1px solid #A2A2A2;
	border-right:1px solid #A2A2A2;
	border-top:3px solid #C8C8C8;
	border-bottom:1px solid #A2A2A2;
	background-color:#A2A2A2;
	font-weight:bold;
	cursor:hand;
	color:#FFFFFF;
	height:22px;
	width:90px;
}

.title_mi
{
	border-bottom:1px solid #A2A2A2;
	background-color:white;
}

.table_main
{
	border-left:1px solid #A2A2A2;
	border-right:1px solid #A2A2A2;
	border-bottom:1px solid #A2A2A2;
}
tr
{
	height:23;
}
.mytr
{
	height:18;
}
.removableObj
{
	height:25;
	position:relative;
	border:1px solid #FFFFFF;
	cursor:move;
}
.disremovableObj
{
	height:25;
	position:relative;
	border:1px solid #99CCFF;
	cursor:move;
}
.addObj
{
	height:25;
	position:relative;
	border:1px solid #FFFFFF;
	border-bottom:2px dashed #CC3366;
	cursor:move;
}
.bstitle
{
	font-weight:bold;
	color:#000000;
	height:30px;
	padding-left:20px;
	font-size:12pt;
}
</style>
<%@include file="/system/app/skin/skin4/template/info_top.jsp"%>
<!--    模块名称开始    -->
<%=strTitle%>
<!--    模块名称结束    -->
<%@include file="/system/app/skin/skin4/template/info_funtion.jsp"%>
<!--    功能按钮开始    -->

<!--    功能按钮结束    -->
<%@include file="/system/app/skin/skin4/template/info_main.jsp"%>
<!--    表单提交开始    -->
<div id="nocount"></div>
<table class="main-table" width="100%" CELLPADDING="0" cellspacing="0">
<form name="formData" enctype="multipart/form-data" method="post">
	<tr >
		<td>
			<table width="100%" cellspacing="0" cellpadding="0">
				<tr>
					<td valign="bottom" width="90">
						<table cellspacing="0" cellpadding="0">
							<tr>
								<td id="baseinfo_bt" class="title_down" align="center" onClick="javascript:ChangeC('baseinfo');">事项维护</td>
							</tr>
						</table>
					</td>
					<td width="2" class="title_mi">　</td>
					<td valign="bottom" width="90">
						<table cellspacing="0" cellpadding="0">
							<tr>
								<td id="sheet_bt" class="title_down" align="center" onClick="javascript:ChangeC('sheet');">表格下载</td>
								</tr>
						</table>
					</td>
					<!--在线表单构建开始>
					<td width="2" class="title_mi">　</td>
					<td valign="bottom" width="90">
						<table cellspacing="0" cellpadding="0">
							<tr>
								<td id="onlinetable_bt" class="title_down" align="center" onClick="onlineTable('<%=projectId%>','<%=projectName%>')">在线表单构建</td>
								</tr>
						</table>
					</td>
					<!--在线表单构建结束-->
					<td class="title_mi">&nbsp;</td>
				</tr>
			</table>
			
			<!--事项概况-->
			<div id="baseinfo" style="display:">
			<table width="100%" class="table_main">
				<tr>
					<td>
						<table cellpadding="3" width="100%" align="center">

						<tr class="line-even" width="100%">
							<td width="100" align="right">事项名称：</td>
							<td align="left"><input <%=isReadonly%> class="text-line" name="projectName" size="50" value="<%=projectName%>" maxlength="150" onChange="javascript:checkName(this,document.all.departId,'<%=projectId%>');">&nbsp;<FONT COLOR="#FF0000">*</FONT>&nbsp;<span id="checkTip" style="COLOR:#FF0000"></span></td>
						</tr>

							<tr class="line-odd" width="100%">
									<td width="100" align="right">用户类型：</TD>
										<td align="left">
											<select name="userKind" class="select-a" onChange="ukChange()" <%=isDisabled%>>
											<%
											sqlStr = "select * from tb_userkind where uk_name in ('市民','企业','特别关爱') order by uk_sequence ";
											vPage = dImpl.splitPage(sqlStr,100,1);
											if (vPage!=null){
												for(int i=0;i<vPage.size();i++)	{
													Hashtable content = (Hashtable)vPage.get(i);
													String uk_id = content.get("uk_id").toString();
													String uk_name = content.get("uk_name").toString();
													sqlStr = "select cw_id,cw_name from tb_commonwork where uk_id='"+uk_id+"' order by cw_sequence";
													Vector cwPage = dImpl.splitPage(sqlStr,1000,1);
													if (cwPage!=null){
														for(int j=0;j<cwPage.size();j++){
															Hashtable cWork = (Hashtable)cwPage.get(j);
															strCWorkName += cWork.get("cw_name").toString() + ",";
															strCWorkId += cWork.get("cw_id").toString() + ",";
														}
													}
											strCWorkName += ";";
											strCWorkId += ";";
											%>
												<option value="<%=uk_id%>" <%=pd_uk_id.equals(uk_id) ? "selected" : ""%>><%=uk_name%></option>
											<%
												}
												strCWorkName = strCWorkName.substring(0,strCWorkName.length()-1);
												strCWorkId = strCWorkId.substring(0,strCWorkId.length()-1);
											}
											%>
											</select>										</td>
								</tr>
	<tr class="line-even" width="100%">
		<td width="100" align="right"><nobr>常用办事类别：</nobr></td>
		<td align="left" nowrap>
			<table width="" >
				<tr>
					<td>
						<select <%=isDisabled%> class="select-a" size="7" style="width:150px"  name="commonWork1" ondblclick="field_ondblclick()">
						</select>					</td>
					<td align="center">>>
					</td>
					<td>
						<select class="select-a" <%=isDisabled%> size="7" style="width:150px" name="commonWork2" ondblclick="delSelect()">
						<%
						if (!projectId.equals(""))
						{
							sqlStr = "select cw_id,cw_name from tb_commonwork where cw_id in(select cw_id from tb_commonproceed_new where pr_id='"+projectId+"')";
							vPage = dImpl.splitPage(sqlStr,1000,1);
							if (vPage!=null)
							{
								for (int i=0;i<vPage.size();i++)
								{
									Hashtable content = (Hashtable)vPage.get(i);
										%>
									<option value="<%=content.get("cw_id").toString()%>"><%=content.get("cw_name").toString()%></option>
									<%
								}
							}
						}
						%>
						</select></td>
					<td>&nbsp;<FONT COLOR="#FF0000">*</FONT></td>
				</tr>
			</table><FONT COLOR="#FF0000">（注：左边为待选类别，右边为已选类别，选中或者删除某一个类别，请鼠标双击该类别名称）</font></td>
	</tr>
	<tr class="line-odd" width="100%">
		<td width="100" align="right">分类办事类别：</td>
		<td align="left"><select class="select-a" name="sortWork" <%=isDisabled%>>
			<option value="">--</option>
			<%
			sqlStr = "select * from tb_sortwork order by sw_sequence";
			vPage = dImpl.splitPage(sqlStr,1000,1);
			if (vPage!=null)
			{
				for(int i=0;i<vPage.size();i++)
				{
					Hashtable content = (Hashtable)vPage.get(i);
					String sw_id = content.get("sw_id").toString();
					String sw_name = content.get("sw_name").toString();
					%>
					<option value="<%=sw_id%>"<%if(sortWorkId.equals(sw_id)) out.print("selected");%>><%=sw_name%></option>
					<%
				}
			}
			%>
			</select>
			<!--以下由zzq为浦东财政局分类办事做的修改-->
			<%if(user_id.equals("csr")){%>
			<input type="hidden" name="hehe" value="rini"/>
			<%
			}
			if(user_id.equals("czj")||user_id.equals("csr"))
			{
			%>
			部门事项分类：
			<select class="select-a" name="ga_sortid" <%=isDisabled%>>
			<%if(!user_id.equals("csr")){%>
				<option value="0">请选择</option>
			<%
			}
			String sqlStr_ga = "select * from tb_gasortwork where dt_id="+curdt_id+" order by gw_sequence";
			Vector vPage_ga = dImpl.splitPage(sqlStr_ga,1000,1);
			if (vPage_ga!=null)
			{
				for(int i=0;i<vPage_ga.size();i++)
				{
					Hashtable content_ga = (Hashtable)vPage_ga.get(i);
					String gw_id = content_ga.get("gw_id").toString();
					String gw_name = content_ga.get("gw_name").toString();
					%>
					<option value="<%=gw_id%>"<%if(ga_sortId.equals(gw_id)) out.print("selected");%>><%=gw_name%></option>
					<%
				}
			}
			%>
			</select><font color="red">（各部门的网上办事类别细分）</font>
			<%
			}	
			
			%>
			<!--完成-->&nbsp;<FONT COLOR="#FF0000">*</FONT></td>
	</tr>

	<tr class="line-even" width="100%" style="display:none">
		<td width="100" align="right">受理单位：</td>
		<td align="left">
			<%
			CDeptList dList=new CDeptList(dCn);
			dList.setOnchange(false);
			seldept=dList.getListByParentID(dList.LISTID,0,"0","departIdOut");
			out.print(seldept);
			%>
			<script language="javascript">
			confirmSelect("departIdOut","<%=departIdOut%>");
			if("<%=isDisabled%>"=="disabled")
			{
				formData.departIdOut.disabled = true;
			}
			</script>&nbsp;<FONT COLOR="#FF0000">*</FONT></td>
	</tr>
	<tr class="line-even" width="100%">
		<td width="100" align="right"><!-- 办理 -->维护部门：</td>
		<td align="left">
			<%
			seldept=dList.getListByParentID(dList.LISTID,0,"0","departId");
			out.print(seldept);
			%> 
			<script language="javascript">
			confirmSelect("departId","<%=departId%>");
			if("<%=user_id%>"!="admin")
			{
				formData.departId.onchange = function(){confirmSelect("departId","<%=departId%>");};
			}
			</script>&nbsp;<FONT COLOR="#FF0000">*</FONT></td>
	</tr>
	<tr class="line-odd" width="100%">
		<td width="100" align="right">事项类别：</td>
	  <td align="left"><input <%=isReadonly%> type="radio" name="pr_sxtype" value="审批类" <%=pr_sxtype.equals("审批类")?"checked":""%>/>&nbsp;审批类&nbsp;&nbsp;&nbsp;<input type="radio" <%=isReadonly%> name="pr_sxtype" value="服务类" <%=pr_sxtype.equals("服务类")?"checked":""%>/>&nbsp;服务类&nbsp;&nbsp;&nbsp;<input type="radio" <%=isReadonly%> name="pr_sxtype" value="其它类" <%=pr_sxtype.equals("其它类")?"checked":""%>/>&nbsp;其它类&nbsp;<FONT COLOR="#FF0000">*</FONT></tr>

	<tr class="line-odd" width="100%" style="display:none;">
		<td width="100" align="right">维护部门：</td>
		<td align="left">
			<input <%=isReadonly%> size="20" class="text-line" name="pr_dtname" value="<%=dept_name%>" maxlength="150">&nbsp;&nbsp;<%//=pr_edittime%>
			<input type="hidden"  name="pr_sourcedtid" value="<%=dept_id%>">&nbsp;<FONT COLOR="#FF0000">*</FONT></td>
	</tr>
	<tr class="line-even" width="100%" style="display:none">
		<td width="100" align="right">必填申请：</td>
		<td align="left">
		
			<select class="select-a" name="pr_gut" <%=isDisabled%>>
				<%
				out.println("<option value='0'>无必填选项</option>");				
				String gut_Sql = "select pp_id,pp_value from tb_passport where pp_typeid =1";
				Vector gutPage = dImpl.splitPage(gut_Sql,1000,1);
				if(gutPage!=null){
					for(int i = 0 ;i <gutPage.size();i++){
						gutMap = (Hashtable)gutPage.get(i);
						gutid = gutMap.get("pp_id").toString();
						gutvalue = gutMap.get("pp_value").toString();
						if(pr_gut.equals(gutid)){
							out.println("<option value='"+gutid+"' selected>"+gutvalue+"</option>");	
						}else{
							out.println("<option value='"+gutid+"'>"+gutvalue+"</option>");		
						}
					}
				}
				%>
	</select>	</tr>
<%if (user_id.equals("admin")) {%>
	<tr class="line-odd" width="100%">
		<td width="100" align="right">进入市民中心：</td>
	<td align="left"><input <%=isDisabled%> type="checkbox" class="checkbox1" name="pr_cc" value="1" onClick="javascript:ic(this,'cc');" <%=iscc%> >	</tr>
<%}%>
				
				
	<tr class="line-even" width="100%" style="display:none">
		<td width="100" align="right">事项编号：</td>
		<td align="left"><input <%=isReadonly%> class="text-line" name="pr_code" value="<%=pr_code%>" maxlength="50">&nbsp;<FONT COLOR="#FF0000">*</FONT></td>
	</tr>
	<tr class="line-even" width="100%">
		<td width="100" align="right">办事依据：</td>
	<td align="left">
	
	
	<textarea <%=isReadonly%> name="pr_by" value="1" <%=isCheck%> style="display:none;WIDTH: 100%; HEIGHT: 200px"><%=pr_by%></textarea>	
	<IFRAME ID="eWebEditor1" src="/system/common/edit/eWebEditor.jsp?id=pr_by&style=standard" frameborder="0" scrolling="no" width="100%" height="200"></IFRAME>	</tr>
	<tr class="line-odd" width="100%">
		<td width="100" align="right">申请范围：</td>
	<td align="left">
	<textarea <%=isReadonly%> name="pr_area" value="1" <%=isCheck%> style="display:none;WIDTH: 100%; HEIGHT: 200px"><%=pr_area%></textarea>	
	<IFRAME ID="eWebEditor2" src="/system/common/edit/eWebEditor.jsp?id=pr_area&style=standard" frameborder="0" scrolling="no" width="100%" height="200"></IFRAME>	</tr>

	<tr class="line-even" width="100%">
		<td width="100" align="right">申报材料：</td>
	<td align="left">
	<textarea <%=isReadonly%> name="pr_stuff" value="1" <%=isCheck%> style="display:none;WIDTH: 100%; HEIGHT: 200px"><%=pr_stuff%></textarea>	
	<IFRAME ID="eWebEditor3" src="/system/common/edit/eWebEditor.jsp?id=pr_stuff&style=standard" frameborder="0" scrolling="no" width="100%" height="200"></IFRAME>	</tr>

	<tr class="line-odd" width="100%">
		<td width="100" align="right">办理程序：</td>
	<td align="left">
	<textarea <%=isReadonly%>  name="pr_blcx" value="1" <%=isCheck%> style="display:none;WIDTH: 100%; HEIGHT: 200px"><%=pr_blcx%></textarea>	
	<IFRAME ID="eWebEditor4" src="/system/common/edit/eWebEditor.jsp?id=pr_blcx&style=standard" frameborder="0" scrolling="no" width="100%" height="200"></IFRAME>	</tr>
	
	<tr class="line-even" width="100%">
		<td width="100" align="right">其它：</td>
	<td align="left">
	<textarea <%=isReadonly%> class="text-line" name="pr_qt" value="1" <%=isCheck%> cols="50" rows="5"><%=pr_qt%></textarea></td>
	</tr>
	<tr class="line-odd" width="100%">
		<td width="100" align="right">收费标准：</td>
	<td align="left"><textarea <%=isReadonly%> class="text-line" name="pr_money" value="1" <%=isCheck%> cols="50" rows="5"><%=pr_money%></textarea>&nbsp;<FONT COLOR="#FF0000">*</FONT></tr>


	<tr class="line-even" width="100%">
		<td width="100" align="right">办理地点：</td>
		<td align="left">
			<textarea <%=isReadonly%> class="text-line" name="pr_address" value="1" <%=isCheck%> cols="50" rows="5"><%=pr_address%></textarea>
			&nbsp;<FONT COLOR="#FF0000">*</FONT><br><FONT COLOR="#FF0000">（注：此项填写办理地点与联系电话）</FONT></td>
	</tr>
	<input type="hidden" name="pr_telephone" value=""/>
	
	<tr class="line-even" width="100%">
		<td width="100" align="right">监督投诉：</td>
		<td align="left">
			<textarea <%=isReadonly%> class="text-line" name="pr_tstype" value="1" <%=isCheck%> cols="50" rows="5"><%=pr_tstype%></textarea>
			&nbsp;<FONT COLOR="#FF0000">*</FONT><br><FONT COLOR="#FF0000">（注：此项填写投诉地点、投诉电话与投诉信箱）</FONT></td>
	</tr>
	<input type="hidden" name="pr_tstel"/>
	<input type="hidden" name="pr_tsemail"/>
	<tr class="line-odd" width="100%">
		<td width="100" rowspan="2" align="right">办理时限：</td>
		<td align="left"><input <%=isReadonly%> size="8" class="text-line" name="pr_timeLimit" value="<%="".equals(pr_timeLimit)?"":("5201314".equals(pr_timeLimit)?"":pr_timeLimit)%>" maxlength="50">&nbsp;工作日&nbsp;<FONT  COLOR="#FF0000"> （注：项目时限如果为0，表示当场办理）</FONT>
</td>
	</tr>
	<tr class="line-odd" width="100%">
		<td align="left"><input <%=isReadonly%> size="20" class="text-line" name="pr_bc" value="<%=pr_bc%>" maxlength="200">&nbsp;<FONT  COLOR="#FF0000"> （注：若办理时限无法确定填写说明）</FONT>
</td>
	</tr>
	<tr class="line-even" width="100%">
		<td width="100" align="right">网上受理：</td>
	<td align="left"><input <%=isDisabled%> type="checkbox" class="checkbox1" name="pr_isaccept" value="1" <%=isChecked%> onClick="isAccept()">&nbsp;<font color="red">（注：如果本事项已有在线受理网站，请钩选“网上受理”，并在下方"受理网址"中填写受理网站的URL）</font></tr>
	<tr class="line-odd" width="100%">
		<td width="100" align="right">受理网址：</td>
		<td align="left">
			<input <%=isReadonly%> type="text" class="text-line" name="pr_url" size="50" value="<%=pr_url%>" maxlength="150"><br><font color="red">（注：如果已钩选“网上受理”而且不填写“受理网址”，则默认为浦东门户网站后台受理）</font></td>
	</tr>
	<!--电子地图地址-->
	<tr class="line-odd" width="100%">
		<td width="100" align="right">GIS地图地址：</td>
		<td align="left">
			<input <%=isReadonly%> type="text" class="text-line" name="pr_gisaddress" size="50" value="<%=pr_gisaddress%>" maxlength="150"><br><font color="red">（注：如果有多个地址请用英文“,”隔开）</font></td>
	</tr>
	<!--电子地图地址-->
<script language="javascript">isAccept();</script>
	<tr class="line-even" width="100%">
		<td width="100" align="right">排序：</td>
		<td align="left">
			<input <%=isReadonly%> size="8" class="text-line" name="pr_sequence" value="<%=sequence%>" maxlength="20">
			&nbsp;<FONT COLOR="#FF0000">*（注：请填入数字，数字越小，事项排序在越前面，不填写默认-10）</FONT></td>
	</tr>

	
	<tr class="line-even" width="100%" style="display:none">
		<td width="100" align="right"></td>
		<td align="left">§<a onClick="javascript:openImgWindow('forFlow')" style="cursor:hand">上传流程图</a>&nbsp;&nbsp;&nbsp;§<a onClick="javascript:openImgWindow('forExplain')" style="cursor:hand">上传事项说明图片</a>	</tr>

	<tr id="cc" class="line-even" style="display:<%=isd%>" width="100%">
		<td width="100" align="right">办理系统：</td>
	<td align="left"><input <%=isReadonly%> size="35" class="text-line" name="pr_root" value="<%=pr_root%>">	</tr>
	
	<tr id="cc" class="line-odd" style="display:<%=isd%>" width="100%">
		<td width="100" align="right">表单内容：</td>
	<td align="left"><textarea <%=isReadonly%> class="text-line" name="pr_table" value="1" <%=isCheck%> cols="50" rows="5"><%=pr_table%></textarea>	</tr>
	<tr>
		<td colspan="2" id="sumlist"></td>
	</tr>
			</table></td></tr></table>
			</div>
			<!--相关法规--->
			<div id="summarize" style="display:none">
			<table width="100%" class="table_main">
			<tr><td><table cellpadding="3" width="100%" align="center">
		<tr class="line-even" width="100%">
		<td width="100" align="right">查询法规：</td>
		<td align="left">
			<input <%=isReadonly%>  class="text-line" name="pr_fagui" value="" maxlength="20">
			&nbsp;<input type="button" name="Submit" value="查询" onClick="forSearch()"></td>
		</tr>
		<tr class="line-odd" width="100%">
			<td colspan="3" align="left">
				<span id="testname" align="left"></span>
				<input name="ctids" type="hidden">			</td>
			</tr>
		<script language="javascript">
		function a(rv){
			var aa = toArray(document.all.ctids.value,",");
			//var bb = rv.split(",");
			var bb = toArray(rv,",");
			var cc = bb;
			var isH = true;
			for(i=0;i<aa.length;i++){
				for(j=0;j<bb.length;j++){
					if(aa[i]==bb[j]){
						isH = false;
					}
				}
				if(isH) cc.push(aa[i]);
			}
			
			try{
				wt(cc.toString());
			}catch(e){
				alert("您的浏览器不支持！\n点击确定返回！");
				return false;
			}
			document.all.ctids.value = cc.toString();
		}
		
		function toArray(s,sn){
			return s.split(sn);
		}
		
		function wt(o){
			try{
				var http = new ActiveXObject("Microsoft.XMLHTTP");
				var str;
				http.onreadystatechange = function (){
					if (http.readyState==4)	{
						str = http.responseText;
						//alert(str);
						while(str.indexOf("\n")!=-1||str.indexOf("\r")!=-1)
						{str = str.replace("\n","");str = str.replace("\r","");}
						outPut(o,str.split(","));			
						http.abort();
					}
				};
				url="/system/app/proceeding_new/getTitle.jsp?st="+o;
				http.open("GET",url,true);
				http.send();
			}catch(e){
			}
		}
		
		function innerST(s){
			document.all.signText.innerHTML = s;
		}
		
		function outPut(i,n){
			document.all.testname.innerHTML = n.toStringFormat(true,"；");
		}

		function deleteSN(t){
			if(confirm("确认删除？")){
				var cc = toArray(document.all.ctids.value,",");
				for(i=0; i<cc.length; i++){
					if(cc[i]==t) cc.remove(i);
				}
				try{
					wt(cc.toString());
				}catch(e){
					alert("您的浏览器不支持！\n点击确定返回！");
					return false;
				}
				document.all.ctids.value = cc.toString();
			}
		}
		
		Array.prototype.toStringFormat = function(b,s){
			var cc = toArray(document.all.ctids.value,",");
			var c = "";
			if(this!="undefined"&cc!=""){
				if(this.length!="undefined"){
					for(i=0; i<this.length; i++){
						if(this[i]!=""){
							c = c + "<span><nobr>" + this[i];
							if(b==true) c = c + " <span style=color:red;cursor:hand onclick=\"deleteSN('"+cc[i]+"')\"><b>×</b></span>";
							c = c + s + "</nobr></span>";
						}
					}
				}else{
					if(this!=""){
						c = c + "<span>" + this;
						if(b==true) c = c + " <span style=color:red;cursor:hand onclick=\"deleteSN('"+cc[0]+"')\"><b>×</b></span>";
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
		</script>
		<%
		if((OType.equals("Edit")||mySelf.getMyUid().equals("admin"))||!projectId.equals("")){
		String seaSql="select c.ct_title,c.ct_id from tb_content c where c.ct_id in (select ct_id from tb_proceeding_content where pr_id='"+projectId+"')";
		String ct_ids="";
		Vector vectorPage = dImpl.splitPage(seaSql,100,1);
		if(vectorPage!=null)
		{
			for(int j=0;j<vectorPage.size();j++)
			{
			Hashtable contentsea = (Hashtable)vectorPage.get(j);
			ct_ids += contentsea.get("ct_id").toString() + ",";
			}
		}
		%>
		<tr class="line-odd" width="100%">
		<td width="100" align="right">
		<td align="left">
			<script>a("<%=ct_ids%>");</script></td>
		</tr>
		<%}%>
	
			</table></td></tr></table>
			</div>
			<!--办事指南-->
	
	<!--表格下载--->
	<div id="sheet" style="display:none">
	<table width="100%" class="table_main"><tr><td><table cellpadding="3" width="100%" align="center">
	
	<tr>
	   <td class="row" colspan="9">
		 <hr style='border-top-style: dotted; border-top-width: 1; border-bottom-style: dotted; border-bottom-width: 1'size=0 noshade color=#000000/>	   </td>
	</tr>
	<tr>
	   <td colspan="9" align="left">
			§<a onClick="vbscript:AddAttach1()" style="cursor:hand"><b>上传附件</b></a>§（提示：限制上传.exe、.bat、.jsp类型的文件！）<br>以下是已上传的附件：	   </td>
	</tr>
	<tr>
       <td class="row" id="TdInfo1" colspan="9" align="left"><iframe src=# id=downFrm name=downFrm style="width:0px;height:0px;"></iframe>
         <hr style='border-top-style: dotted; border-top-width: 1; border-bottom-style: dotted; border-bottom-width: 1' size=0 noshade color=#000000>
		 <%
		 if (!pr_attachpath.equals(""))
		 {
			sqlStr = "select pa_id,pa_name,pa_upload,pa_filename from tb_proceedingattach_new where pr_id='"+projectId+"'";
			vPage = dImpl.splitPage(sqlStr,100,1);
			if (vPage!=null)
			{
				for(int n=0;n<vPage.size();n++)
				{
					Hashtable content = (Hashtable)vPage.get(n);
					String fileName = content.get("pa_name").toString();
					String needUpload = content.get("pa_upload").toString();
					%>
					<p align="left">文件名称：&nbsp;&nbsp;&nbsp;&nbsp;<a target=downFrm href="download.jsp?pa_id=<%=content.get("pa_id").toString()%>"><%=fileName%></a>&nbsp;&nbsp;
					<%
					if (isDisabled.equals(""))
					{
					%>
					<img SRC="/system/images/delete.gif" onClick="javascript:deleteFile('<%=content.get("pa_filename").toString()%>');" title='删除该文件'style="cursor:hand">
					<%
					}
					%>
					</p>
					<p align="left">是否上传：&nbsp;&nbsp;&nbsp;&nbsp;<%if(needUpload.equals("1")) out.print("需要上传");else out.print("不需要上传");%></p>
					<%
				}
			}
		 }
		 %>       </td>
    </tr>
	</table></td></tr></table>
	</div>
	</td></tr>
	<tr class="outset-table" width="100%">
		<td colspan="5">
			<input <%=isDisabled%> type="button" name="btnSubmit" value="确定" onClick="checkForm()" class="bttn">&nbsp;
			<input type="reset" <%=isDisabled%> name="btnReset"  value="重写" class="bttn">&nbsp;
			<%if (!"".equals(projectId)) {%>
			<input type="button"  name="btnDel" <%=isDisabled%> value="删除" class="bttn" onClick="deleteThis('<%=projectId%>')">&nbsp;
			<%}%>
			<input type="button" name="btnReturn" value="返回" onClick="javascript:window.history.go(-1);" class="bttn">		</td>
	</tr>
	<input type="hidden" name="projectId" value="<%=projectId%>">		<!--项目id-->
	<input type="hidden" name="pr_imgpath" value="<%=pr_imgpath%>">		<!--项目流程图图片存放路径-->
	<input type="hidden" name="pr_img" value="<%=pr_img%>">			<!--事项说明图片存放路径-->
	<input type="hidden" name="pr_attachpath" value="<%=pr_attachpath%>">	<!--项目附件存放路径-->
	<input type="hidden" name="strCommonWork" value="<%=strCWorkName%>">    <!--常用事务按照用户类型分组-->
	<input type="hidden" name="strCommonId" value="<%=strCWorkId%>">
	<input type="hidden" name="cwList" value="">				<!--选择的常用事务id-->
	<input type="hidden" name="cwDesc" value="">				<!--选择的常用事务名称-->
	<input type="hidden" name="OType" value="<%=OType%>">
	<!---update by dongliang 20090106-->
	<input type="hidden" name="curpage" value="<%=curpage%>"/>
</form>
</table>
<script type="text/javascript" for=window event=onload>
	eWebEditor1.setHTML(document.all.pr_by.value);
	eWebEditor2.setHTML(document.all.pr_area.value);
	eWebEditor3.setHTML(document.all.pr_stuff.value);
	eWebEditor4.setHTML(document.all.pr_blcx.value);
	initCommonWork();
	ChangeC("baseinfo");
</script>
<!--    表单提交结束    -->
<%@include file="/system/app/skin/skin4/template/info_bottom.jsp"%> 
<%
}
catch(Exception e){
	System.out.print(e.toString());
}
finally{
	dImpl.closeStmt();
	dCn.closeCn(); 
}
%>
<%@include file="/system/app/skin/bottom.jsp"%>
                                     
