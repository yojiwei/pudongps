<%@page contentType="text/html; charset=GBK"%>
<%@include file="../skin/head.jsp"%>
<script language="javascript">
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

function openImgWindow()
{
	  var w = 400 ;
	  var h = 500;
	  var url = "attachInfoImg.jsp";
	  var pr_imgpath = document.formData.pr_imgpath.value;
	  url = url + "?pr_imgpath="+ pr_imgpath;
	  window.open( url, "upload", "Top=0px,Left=0px,Width="+w+"px, Height="+h+"px,toolbar=no,location=no,derectories=no,status=no,menubar=no,scrollbars=yes" );
}

function Display(Num)
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
  if(confirm("确实要删除吗？"))
  {
    formData.action = "ProceedingInfoDel.jsp?projectId="+val;
    formData.submit();
  }
}

function checkForm()
{

	formData.action = "ProceedingList.jsp";
	formData.method = "post";
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
	var subCWName = initCWArray(formData.strCommonWork);
	var subCWId = initCWArray(formData.strCommonId);
	var cwNames = subCWName[0].split(",");
	var cwIds   = subCWId[0].split(",");
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

function field_ondblclick()
{
	if (document.formData.commonWork1.selectedIndex<0)
	{
		return false;
	}

	for (var i=0;i<document.formData.commonWork2.length;i++)
	{
		if (document.formData.commonWork2.options[i].text==document.formData.commonWork1.options[document.formData.commonWork1.selectedIndex].text)
			return false;
	}
	var i_op=document.createElement("OPTION");
	i_op.text=document.formData.commonWork1.options[document.formData.commonWork1.selectedIndex].text;
	i_op.value=document.formData.commonWork1.options[document.formData.commonWork1.selectedIndex].value;
	document.formData.commonWork2.add(i_op);
}

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
String pr_imgpath     = "";  //图片保存的相对路径
String pr_attachpath  = "";
Vector vPage          = null;
String strTitle       = "网上办事查询";
String pr_timeLimit   = "";   //项目的时限
String pr_code        = "";   //项目编号
String strCWorkName   = "";   //按照用户类型排列的常用事务
String strCWorkId     = "";

//update20080122

CDataCn dCn=null;   //新建数据库连接对象
CDataImpl dImpl=null;  //新建数据接口对象

try {
 dCn = new CDataCn(); 
 dImpl = new CDataImpl(dCn); 


projectId = CTools.dealString(request.getParameter("projectId")).trim();
%>

<table class="main-table" width="100%">
<form name="formData" method="post">
	<tr class="title1" width="100%">
		<td colspan="2" align="center"><%=strTitle%></td>
	</tr>
	<tr class="line-odd" width="100%">
		<td width="20%" align="right">用户类型：</TD>
		<td align="left">
			<select name="userKind" class="select-a" onchange="ukChange()">
                   		<option value="0">所有</option>
				<%
				sqlStr = "select * from tb_userkind order by uk_sequence";
				vPage = dImpl.splitPage(sqlStr,request,20);
				if (vPage!=null)
				{
					for(int i=0;i<vPage.size();i++)
					{
						Hashtable content = (Hashtable)vPage.get(i);
						String uk_id = content.get("uk_id").toString();
						String uk_name = content.get("uk_name").toString();
						sqlStr = "select cw_id,cw_name from tb_commonwork where uk_id='"+uk_id+"' order by cw_sequence";
						Vector cwPage = dImpl.splitPage(sqlStr,request,20);
						if (cwPage!=null)
						{
                                                   strCWorkName += "所有,";
                                                   strCWorkId += "0,";
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
						<option value="<%=uk_id%>"><%=uk_name%></option>
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
		<td align="left">
			<table width="60%">
				<tr>
					<td>
						<select class="select-a" name="commonWork1">
                                       </select>
					</td>
				</tr>
			</table>
		</td>
	</tr>
	<tr class="line-odd" width="100%">
		<td width="20%" align="right">分类办事类别：</td>
		<td align="left">
			<select class="select-a" name="sortWork">
                   		<option value="0">所有</option>
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
		</td>
	</tr>

	<tr class="line-even" width="100%">
		<td width="20%" align="right">受理单位：</td>
		<td align="left">
                                <select name="departIdOut" class="select-a">
                                <option value="0">所有</option>
				<%
				CDeptList dList=new CDeptList(dCn);
                                dList.setOutputSelect(false);
				dList.setOnchange(false);
				String  seldept=dList.getListByParentID(dList.LISTID,1,"0","departIdOut");
				out.print(seldept);
				%>
                                </select>
				<script language="javascript">
				confirmSelect("departIdOut","<%=departIdOut%>");
				</script>
		</td>
	</tr>
	<tr class="line-even" width="100%">
		<td width="20%" align="right">项目名称：</td>
		<td align="left"><input class="text-line" name="projectName" size="50" value="<%=projectName%>" maxlength="200"></td>
	</tr>
	<tr class="line-odd" width="100%">
		<td width="20%" align="right">项目编号：</td>
		<td align="left"><input class="text-line" name="pr_code" value="<%=pr_code%>"></td>
	</tr>
	<tr class="line-odd" width="100%">
		<td width="20%" align="right">更新日期：</td>
		<td align="left"><input name="beginTime" style="cursor:hand" class="text-line" readonly size="10" onclick="showCal()">&nbsp;至&nbsp;<input style="cursor:hand" name="endTime" class="text-line" readonly size="10" onclick="showCal()"></td>
	</tr>
	<tr class="title1" width="100%">
		<td colspan="2">
			<input type="button" name="btnSubmit" value="确定" onclick="checkForm()" class="bttn">&nbsp;
			<input type="reset"  name="btnReset"  value="重写" class="bttn">&nbsp;
			<input type="button" name="btnReturn" value="返回" onclick="javascript:window.history.go(-1);" class="bttn">
		</td>
	</tr>
	<input type="hidden" name="projectId" value="<%=projectId%>">			<!--项目id-->
	<input type="hidden" name="pr_imgpath" value="<%=pr_imgpath%>">			<!--项目图片存放路径-->
	<input type="hidden" name="pr_attachpath" value="<%=pr_attachpath%>">	<!--项目附件存放路径-->
	<input type="hidden" name="strCommonWork" value="<%=strCWorkName%>">    <!--常用事务按照用户类型分组-->
	<input type="hidden" name="strCommonId" value="<%=strCWorkId%>">
	<input type="hidden" name="cwList" value="">							<!--选择的常用事务id-->
	<input type="hidden" name="cwDesc" value="">							<!--选择的常用事务名称-->
        <input type="hidden" name="OType" value="query">
</form>
</table>
<script language="javascript" for=window event="onload">
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