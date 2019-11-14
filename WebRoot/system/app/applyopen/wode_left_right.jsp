<%@page contentType="text/html; charset=GBK"%>
<%@include file="../skin/head.jsp"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title>两边倒</title>
</head>
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
</script>
<script type="text/javascript" for=window event=onload>
initCommonWork();
</script>
<body>
<%
String projectId      = "";
String sqlStr         = "";
String isChecked      = "";
String isDisabled     = "disabled";
String isReadonly     = "readonly";
String strCWorkName   = "";   //按照用户类型排列的常用事务
String strCWorkId     = "";
String isCheck        = "";
String pd_uk_id		  = "";
projectId = CTools.dealString(request.getParameter("projectId")).trim();
Vector vPage          = null;
CDataCn dCn = null;//新建数据库连接
CDataImpl dImpl = null;//新建数据接口对象
try{
dCn = new CDataCn();
dImpl = new CDataImpl(dCn);
%>
<form name="formData" enctype="multipart/form-data" method="post">
<table width="864" height="255" border="1">
<tr class="line-odd" width="100%">
	<td width="100" align="right">用户类型：</TD>
		<td align="left">
			<select name="userKind" class="select-a" onChange="ukChange()">
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
			</select>
		</td>
</tr>
<tr class="line-even" width="100%">
<td width="100" align="right"><nobr>常用办事类别：</nobr></td>
<td align="left" nowrap>
<table width="" >
<tr>
	<td>
		<select class="select-a" size="7" style="width:150px"  name="commonWork1" ondblclick="field_ondblclick()">
		</select>
	</td>
	<td align="center">>>&nbsp;</td>
	<td>
		<select class="select-a" size="7" style="width:150px" name="commonWork2" ondblclick="delSelect()">
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
</table>&nbsp;<FONT COLOR="#FF0000">（注：左边为待选类别，右边为已选类别，选中或者删除某一个类别，请鼠标双击该类别名称）</font></td>
</tr>
</table>
<input type="hidden" name="strCommonWork" value="<%=strCWorkName%>">    <!--常用事务按照用户类型分组-->
	<input type="hidden" name="strCommonId" value="<%=strCWorkId%>">
</form>
</body>
<%@include file="../skin/bottom.jsp"%>
<%}
catch(Exception e){
out.print(e.toString());
}
finally{
dImpl.closeStmt();
dCn.closeCn(); 
}
%>
</html>