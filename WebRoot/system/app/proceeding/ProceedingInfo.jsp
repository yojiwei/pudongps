<%@page contentType="text/html; charset=GBK"%>
<%@include file="../skin/head.jsp"%>
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
strChk = "<br>不需上传：<input type='checkbox' name='notUpload1' class='checkbox1'><input type='hidden' name='notUpload' value='1'>"
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
		objUrl.value=url;
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
	//var Html2=demo2.getHTML();

	Html1 = Html1.replace(re,"");
	//Html2 = Html2.replace(re,"");

	formData.dt_content.value=Html1;
}

function setHtml()
{
	demo1.setHTML (formData.dt_content.value);
	//demo2.setHTML (formData.ge_flow.value);
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

function deleteThis(val)
{
  if(confirm("此操作将删除所有和本项目相关的办事事项，确实要删除吗？"))
  {
    formData.action = "ProceedingInfoDel.jsp?projectId="+val;
    formData.submit();
  }
}

function checkForm()
{
	var obj ;
	var obj1;
	if (formData.commonWork2.length<=0)
	{
		alert("常用办事类别不能为空！");
		return false;
	}
	if (formData.projectName.value=="")
	{
		alert("项目名称不能为空！");
		formData.projectName.focus();
		return false;
	}
	if (formData.pr_code.value=="")
	{
		alert("项目编号不能为空！");
		formData.pr_code.focus();
		return false;
	}
	if (isNaN(formData.pr_timeLimit.value))
	{
		alert("项目时限只能写数字！");
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
	GetDatademo();
	getCWInfo();
	formData.action = "ProceedingInfoResult.jsp";
	//formData.method = "post";
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
</script>

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
String isChecked      = "checked";
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
String iscc = "";
String isd = "";
isd = "none";

//update20080122

CDataCn dCn=null;   //新建数据库连接对象
CDataImpl dImpl=null;  //新建数据接口对象

try {
 dCn = new CDataCn(); 
 dImpl = new CDataImpl(dCn); 

com.app.CMySelf mySelf = (com.app.CMySelf)session.getAttribute("mySelf");
//zzq
String curdt_id = String.valueOf(mySelf.getDtId());
String user_id = String.valueOf(mySelf.getMyUid());
String ga_sortId = "";//分类ID
//
projectId = CTools.dealString(request.getParameter("projectId")).trim();
OType = CTools.dealString(request.getParameter("OType")).trim();
if ((OType.equals("Edit")||mySelf.getMyUid().equals("admin"))||!projectId.equals(""))
{
	if(projectId == null)
		 projectId ="0";
	sqlStr = "select sw_id,pr_name,pr_sourcedtid,dt_idext,dt_id,dt_content,pr_imgpath,pr_flowimgpath,pr_timelimit,pr_code,pr_url,";
	sqlStr += "pr_isaccept,pr_sequence,to_char(pr_edittime,'yyyy-mm-dd') pr_edittime,pr_isdel,uk_id,pr_gut,pr_cc," +
			  "pr_root,pr_table from tb_proceeding where pr_id = '" + projectId + "'  ";
	
	strTitle     = "网上办事>>管理";
	Hashtable content = dImpl.getDataInfo(sqlStr);
	if (content!=null)
	{
		sortWorkId   = content.get("sw_id").toString();
		projectName  = content.get("pr_name").toString();
		departIdOut  = content.get("dt_idext").toString();
		departId     = content.get("dt_id").toString();
		dt_content   = content.get("dt_content").toString();
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
		
		if (sequence.equals("")) sequence = "100";
		if (!pr_isaccept.equals("1")) isChecked = "";
		if (!pr_isdel.equals("1"))
		{
			isCheck = "";
		}
		else
		{
			isCheck = "checked";
		}

		if("1".equals(pr_cc)){
			iscc = "checked";
			isd = "";
		}

	}
	sqlStr = "select distinct pa_path from tb_proceedingattach where pr_id = '"+ projectId+"'";
	
	content = dImpl.getDataInfo(sqlStr);
	if (content!=null)
	{
		pr_attachpath = content.get("pa_path").toString();
	}
	//以下由zhangzq修改，为浦东财政的网上办事事项分类
	String ga_sortsql = "";
	Hashtable ga_content = null;
	ga_sortsql = "select a.gw_id from tb_gasortwork a,tb_worklinksort b where a.gw_id=b.gw_id and b.pr_id='"+projectId+"'";
	//System.out.println("**************"+ga_sortsql);
	ga_content = dImpl.getDataInfo(ga_sortsql);
	if(ga_content!=null)
	{
		ga_sortId = ga_content.get("gw_id").toString();
	}
	//
}
if (OType.equals("view")&&!mySelf.getMyUid().equals("admin"))
{
	isDisabled = "disabled";
	isReadonly = "readonly";
	strTitle     = "网上办事>>查看";
}

String dept_id = pr_sourcedtid;
String dept_name = "";
if(dept_id ==null || dept_id.equals(""))
	dept_id = curdt_id;
	//dept_id = "0";
String sql_dt  = "select dt_name from tb_deptinfo where dt_id=" + dept_id;
//System.out.println("*****111******"+dept_id+"<<<"+sql_dt);
Hashtable content_dt = dImpl.getDataInfo(sql_dt);

if(content_dt!=null)
{
	dept_name = content_dt.get("dt_name").toString();
}
if (!curdt_id.equals(dept_id)) dept_id = curdt_id;
%>

<script language="javascript" src="/system/include/common.js"></script>
<table class="main-table" width="100%">
<form name="formData" enctype="multipart/form-data" method="post">
	<tr class="title1" width="100%">
		<td colspan="2" align="center"><%=strTitle%></td>
	</tr>
	<tr class="line-odd" width="100%">
		<td width="20%" align="right">用户类型：</TD>
		<td align="left">
			<select name="userKind" class="select-a" onchange="ukChange()" <%=isDisabled%>>
				<%
				sqlStr = "select * from tb_userkind order by uk_sequence";
				vPage = dImpl.splitPage(sqlStr,100,1);
				if (vPage!=null)
				{
					for(int i=0;i<vPage.size();i++)
					{
						Hashtable content = (Hashtable)vPage.get(i);
						String uk_id = content.get("uk_id").toString();
						String uk_name = content.get("uk_name").toString();
						sqlStr = "select cw_id,cw_name from tb_commonwork where uk_id='"+uk_id+"' order by cw_sequence";
						Vector cwPage = dImpl.splitPage(sqlStr,1000,1);
						if (cwPage!=null)
						{
							for(int j=0;j<cwPage.size();j++)
							{
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
			</select>
		</td>
	</tr>
	<tr class="line-even" width="100%">
		<td width="20%" align="right">常用办事类别：</td>
		<td align="left" nowrap>
			<table width="60%" >
				<tr>
					<td>
						<select <%=isDisabled%> class="select-a" size="7" style="width:150px"  name="commonWork1" ondblclick="field_ondblclick()">

						</select>
					</td>
					<td>
						<input <%=isDisabled%> type="button" class="bttn" name="btnDel" onclick="clearAll(formData.commonWork2)" value="重选"><br>
					</td>
					<td>
						<select class="select-a" <%=isDisabled%> size="7" style="width:150px" name="commonWork2" ondblclick="delSelect()">
						<%
						if (!projectId.equals(""))
						{
							sqlStr = "select cw_id,cw_name from tb_commonwork where cw_id in(select cw_id from tb_commonproceed where pr_id='"+projectId+"')";
							//System.out.println("*******333********"+sqlStr);
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
						</select>
					</td>
					<td><FONT COLOR="#FF0000">*</FONT></td>
				</tr>
			</table>
		</td>
	</tr>
	<tr class="line-odd" width="100%">
		<td width="20%" align="right">分类办事类别：</td>
		<td align="left"><select class="select-a" name="sortWork" <%=isDisabled%>>
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
			sqlStr = "select d.dt_id from tb_deptinfo d,(select dt_id from tb_gasortwork group by dt_id) s where d.dt_id = s.dt_id and d.dt_id = "+ curdt_id;
			Hashtable contentDt_id = dImpl.getDataInfo(sqlStr);
			if (contentDt_id != null)
			//if(user_id.equals("czj")||user_id.equals("csr"))
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
			<!--完成-->
		</td>
	</tr>

	<tr class="line-even" width="100%">
		<td width="20%" align="right">受理单位：</td>
		<td align="left">
			<%
			CDeptList dList=new CDeptList(dCn);
			dList.setOnchange(false);
			String  seldept=dList.getListByParentID(dList.LISTID,0,"0","departIdOut");
			out.print(seldept);
			%>
			<script language="javascript">
			confirmSelect("departIdOut","<%=departIdOut%>");
			if("<%=isDisabled%>"=="disabled")
			{
				formData.departIdOut.disabled = true;
			}
			</script>
		</td>
	</tr>
	<tr class="line-odd" width="100%">
		<td width="20%" align="right">办理部门：</td>
		<td align="left">
			<%
			seldept=dList.getListByParentID(dList.LISTID,0,"0","departId");
			out.print(seldept);
			%>
			<script language="javascript">
			confirmSelect("departId","<%=departId%>");
			if("<%=isDisabled%>"=="disabled")
			{
				formData.departId.disabled = true;
			}
			</script>
		</td>
	</tr>
	<tr class="line-even" width="100%">
		<td width="20%" align="right">项目名称：</td>
		<td align="left"><input <%=isReadonly%> class="text-line" name="projectName" size="50" value="<%=projectName%>" maxlength="150">&nbsp;<FONT COLOR="#FF0000">*</FONT></td>
	</tr>
	<tr class="line-odd" width="100%">
		<td width="20%" align="right">项目编号：</td>
		<td align="left"><input <%=isReadonly%> class="text-line" name="pr_code" value="<%=pr_code%>" maxlength="50">&nbsp;<FONT COLOR="#FF0000">*</FONT></td>
	</tr>
	<tr class="line-even" width="100%">
		<td width="20%" align="right">项目时限：</td>
		<td align="left"><input <%=isReadonly%> size="8" class="text-line" name="pr_timeLimit" value="<%="".equals(pr_timeLimit)?"0":pr_timeLimit%>" maxlength="50">&nbsp;<FONT  COLOR="#FF0000">(注：项目时限如果为0，表示当场办理)</FONT></td>
	</tr>
<%//if (user_id.equals("admin")) {%>
	<tr class="line-odd" width="100%">
		<td width="20%" align="right">网上受理：</td>
		<td align="left"><input <%//=isDisabled%><%=isReadonly%> type="checkbox" class="checkbox1" name="pr_isaccept" value="1" <%=isChecked%> onclick="isAccept()">
	</tr>
<%//}%>
	<tr class="line-even" width="100%">
		<td width="20%" align="right">受理地址：</td>
		<td align="left">
			<input <%=isReadonly%> type="text" class="text-line" name="pr_url" size="40" value="<%=pr_url%>" maxlength="150"><font color="red">(如果是在浦东网上受理，此项不必填写)</font>
		</td>
	</tr>
	<tr class="line-odd" width="100%">
		<td width="20%" align="right">排序字段：</td>
		<td align="left">
			<input <%=isReadonly%> size="8" class="text-line" name="pr_sequence" value="<%=sequence%>" maxlength="20">
		</td>
	</tr>
	<tr class="line-even" width="100%">
		<td width="20%" align="right">维护部门：</td>
		<td align="left">
			<input <%=isReadonly%> size="20" class="text-line" name="pr_dtname" value="<%=dept_name%>" maxlength="150">&nbsp;&nbsp;<%=pr_edittime%>
			<input type="hidden"  name="pr_sourcedtid" value="<%=dept_id%>">
		</td>
	</tr>
	<tr class="line-odd" width="100%">
		<td width="20%" align="right">前台删除：</td>
		<td align="left"><input <%=isDisabled%> type="checkbox" class="checkbox1" name="pr_isdel" value="1" <%=isCheck%> >
	</tr>
	<tr class="line-even" width="100%">
		<td width="20%" align="right">必填申请：</td>
		<td align="left">
		
			<select class="select-a" name="pr_gut" <%=isDisabled%>>
				
				
				<%
	
				out.println("<option value='0'>无必填选项</option>");				
				String gut_Sql = "select pp_id,pp_value from tb_passport where pp_typeid =1";
				Vector gutPage = dImpl.splitPage(gut_Sql,1000,1);
				if(gutPage!=null){
					for(int i = 0 ;i <gutPage.size();i++){
						Hashtable gutMap = (Hashtable)gutPage.get(i);
						String gutid = gutMap.get("pp_id").toString();
						String gutvalue = gutMap.get("pp_value").toString();

						if(pr_gut.equals(gutid)){
						out.println("<option value='"+gutid+"' selected>"+gutvalue+"</option>");	
						}else{
						out.println("<option value='"+gutid+"'>"+gutvalue+"</option>");		
						}
					}
				}
				%>
			</select>
		
		
	</tr>

	<tr class="line-odd" width="100%">
		<td width="20%" align="right">进入市民中心：</td>
		<td align="left"><input <%=isDisabled%> type="checkbox" class="checkbox1" name="pr_cc" value="1" onclick="javascript:ic(this,'cc');" <%=iscc%> >
	</tr>

	<tr id="cc" class="line-even" style="display:<%=isd%>" width="100%">
		<td width="20%" align="right">办理系统：</td>
		<td align="left"><input <%=isReadonly%> size="35" class="text-line" name="pr_root" value="<%=pr_root%>">
	</tr>

	<tr id="cc" class="line-odd" style="display:<%=isd%>" width="100%">
		<td width="20%" align="right">表单内容：</td>
		<td align="left"><textarea <%=isReadonly%> class="text-line" name="pr_table" value="1" <%=isCheck%> cols="60" rows="5"><%=pr_table%></textarea>
	</tr>

	<tr class="line-even" width="100%">
		<td width="100%" colspan="2" align="left">
			<a onclick="javascript:Display(1)" style="cursor:hand"><img border="0" src="/system/images/topplus.gif" WIDTH="16" HEIGHT="16" id="InfoImg1"></a>
		事项说明&nbsp;&nbsp;&nbsp;&nbsp;§<a onclick="javascript:openImgWindow('forExplain')" style="cursor:hand">上传事项说明图片</a>§</td>
	</tr>
	<tr class="line-even" id="Info1" style="display:none">
		<td align="left" height="20" colspan=2>
			<iframe id="demo1" style="HEIGHT: 400px; TOP: 5px; WIDTH: 100%" src="/system/common/editor/editor.htm"></iframe>
			<textarea id="dt_content" name="dt_content" style="display:none"><%=dt_content%></textarea>
		</td>
	</tr>
	<tr><td>§<a onclick="javascript:openImgWindow('forFlow')" style="cursor:hand">上传流程图</a>§</td></tr>
	<tr>
	   <td class="row" colspan="9">
		 <hr style='border-top-style: dotted; border-top-width: 1; border-bottom-style: dotted; border-bottom-width: 1' dotted; border-top-width: 1; border-bottom-style: dotted; border-bottom-width: 1 size=0 noshade color=#000000>
	   </td>
	</tr>
	<tr>
	   <td colspan="9">
			§<a onclick="vbscript:AddAttach1()" style="cursor:hand">上传附件</a>§（提示：限制上传.exe、.bat、.jsp类型的文件！）<br>以下是已上传的附件：
	   </td>
	</tr>
	<tr>
       <td class="row" id="TdInfo1" colspan="9">
         <hr style='border-top-style: dotted; border-top-width: 1; border-bottom-style: dotted; border-bottom-width: 1' dotted; border-top-width: 1; border-bottom-style: dotted; border-bottom-width: 1 size=0 noshade color=#000000>
		 <%
		 if (!pr_attachpath.equals(""))
		 {
			//String prAttach_save_path = dImpl.getInitParameter("prAttach_save_path");
			//java.io.File oDir=new java.io.File(prAttach_save_path+pr_attachpath);
			sqlStr = "select pa_id,pa_name,pa_upload,pa_filename from tb_proceedingattach where pr_id='"+projectId+"'";
			//System.out.println("******5555******"+sqlStr);
			vPage = dImpl.splitPage(sqlStr,100,1);
			if (vPage!=null)
			{
				for(int n=0;n<vPage.size();n++)
				{
					Hashtable content = (Hashtable)vPage.get(n);
					String fileName = content.get("pa_name").toString();
					String needUpload = content.get("pa_upload").toString();
					%>
					<p align="left">文件名称：&nbsp;&nbsp;&nbsp;&nbsp;<a href="/website/include/download.jsp?pa_id=<%=content.get("pa_id").toString()%>"><%=fileName%></a>&nbsp;&nbsp;
					<%
					if (isDisabled.equals(""))
					{
					%>
					<img SRC="/system/images/delete.gif" onclick="javascript:deleteFile('<%=content.get("pa_filename").toString()%>');" title='删除该文件'style="cursor:hand">
					<%
					}
					%>
					</p>
					<p align="left">是否上传：&nbsp;&nbsp;&nbsp;&nbsp;<%if(needUpload.equals("1")) out.print("需要上传");else out.print("不需要上传");%></p>
					<%
				}
			}
		 }
		 //System.out.println("********pr_img is:"+pr_img);
		 %>
       </td>
    </tr>
	<tr class="title1" width="100%">
		<td colspan="2">
			<input <%=isDisabled%> type="button" name="btnSubmit" value="确定" onclick="checkForm()" class="bttn">&nbsp;
			<input type="reset" <%=isDisabled%> name="btnReset"  value="重写" class="bttn">&nbsp;
			<%if (!"".equals(projectId)) {%>
			<input type="button"  name="btnDel" <%=isDisabled%> value="删除" class="bttn" onclick="deleteThis('<%=projectId%>')">&nbsp;
			<%}%>
			<input type="button" name="btnReturn" value="返回" onclick="javascript:window.history.go(-1);" class="bttn">
		</td>
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
</form>
</table>
<script language="javascript" for=window event="onload">
setHtml();
initCommonWork();
</script>
<%
dImpl.closeStmt();
dCn.closeCn();
} catch (Exception ex) {
	System.out.println(new java.util.Date() + "--"
			+ request.getServletPath() + " : " + ex.getMessage());
} finally {
	if(dImpl != null)
	dImpl.closeStmt();
	if(dCn != null)
	dCn.closeCn();
}
%>
<%@include file="../skin/bottom.jsp"%>