<!--/**
* author: wanghk	
* 前台给后台发消息的时候，选择后台的接收部门
* 支持向多部门发送
* 2003-10-29
*/-->
<%@ page contentType="text/html; charset=GBK"%>
<%@include file="/website/include/import.jsp"%>
<link rel="stylesheet" href="/website/include/main.css" type="text/css">
<script language="javascript">
<!--
function redo()
{
	var nameObj = document.all.selDeptName;
	var idObj = document.all.selDeptId;
	nameObj.value = "";
	idObj.value = "";
	for (var i=0;i<document.all.length;i++)
	{
		var name = document.all[i].id;
		if (name!="")
		{
			if(name.indexOf("div")>=0)
			{
				document.all[i].style.display = "none";
			}
		}
	}
}

function fnComplete()
{
	var retVal = new Object;
	retVal["name"] = document.all.selDeptName.value;
	retVal["id"] = document.all.selDeptId.value;
	returnValue = retVal;
	window.close();
}

function choose(dt,type) //处理鼠标的点击事件
{
	var divObj;
	var tdObj;
	var idObj;
	if (type==1)
	{
		divObj = eval("div"+dt);
		tdObj = eval("td"+dt);
		idObj = eval("id" + dt);
	}
	else
	{
		divObj = eval("div"+dt+"_"+dt);
		tdObj = eval("td" + dt+"_"+dt);
		idObj = eval("id" + dt+"_"+dt);
	}
	if (typeof(divObj)=="undefined") return false;
	if (divObj.style.display=="none")
	{
		divObj.style.display = "";
		if (document.all.selDeptName.value=="")
		{
			document.all.selDeptName.value = tdObj.innerText;
			document.all.selDeptId.value = idObj.value;
		}
		else
		{
			document.all.selDeptName.value = document.all.selDeptName.value + "," + tdObj.innerText;
			document.all.selDeptId.value = document.all.selDeptId.value + "," + idObj.value;
		}
	}
	else
	{
		divObj.style.display = "none";
		dealDept(tdObj.innerText,dt);
	}
}

function dealDept(dtName,dtId) //将选中的部门从显示的以选部门里面去除
{
	var nameObj = document.all.selDeptName;
	var idObj = document.all.selDeptId;
	var strName = "," + dtName + ",";
	var strId = "," + dtId + ",";
	var str1 = "," + nameObj.value + ","; 
	var str2 = "," + idObj.value + ",";
	var index1 = str1.indexOf(strName);
	var index2 = str2.indexOf(strId);
	if (index1>=0 && index2>=0)
	{
		var strHead1 = nameObj.value.substring(0,index1-1);
		var strFoot1 = nameObj.value.substring(index1+strName.length-1,nameObj.value.length); //减1，是为了去掉最后的一个逗号
		var strHead2 =  idObj.value.substring(0,index2-1);
		var strFoot2 =  idObj.value.substring(index2+strId.length-1, idObj.value.length);
		if (strHead1=="") //第一个
		{
			nameObj.value = strFoot1;
			idObj.value = strFoot2;
		}
		else if (strFoot1=="")//最后一个
		{
			nameObj.value = strHead1;
			idObj.value = strHead2;
		}
		else //中间部分
		{
			nameObj.value = strHead1 + "," + strFoot1;
			idObj.value = strHead2 + "," + strFoot2;
		}
	}
}
function check_corr_id(value) {
	var corr_id = document.all.corr_pr_id.value;
	var corr_id_value = corr_id.split(",");
	for (var i = 0;i < corr_id_value.length;i++) {
		if (corr_id_value[i] == value) {
				return true;
				break;
		}
	}
	return false;
}
-->
</script>
<script language="javascript" for="window" event="onload">
<!--
var obDept = dialogArguments;
var strName = obDept["name"];
var strId = obDept["id"];

if (strId!="")
{
	var idSet = strId.split(",");
	for (var i=0;i<idSet.length;i++)
	{
		var bool = check_corr_id(idSet[i]);
		if (bool == true)
			var obj = eval("div" + idSet[i] + "_" + idSet[i]);
		else
			var obj = eval("div" + idSet[i]);
		if (typeof(obj)=="undefined") return false;
		else
		{
			obj.style.display = "";
		}
	}
	document.all.selDeptName.value = strName;
	document.all.selDeptId.value = strId;
}
-->
</script>
<%//Update 20061231
String pr_id = "";
String sqlStrDept = ""; //sql语句，获取主办部门
String sqlStrCorr = ""; //sql语句，获取协办部门
String corr_pr_id = "";	

pr_id = CTools.dealString(request.getParameter("pr_id")).trim();
if (!pr_id.equals(""))
{
	//获取协办部门
	sqlStrCorr = "select dt_name,dt_id from tb_deptinfo where dt_id in(select dt_id from tb_proceedingcorr where pr_id='"+pr_id+"')";
	//获取主办部门名称
	sqlStrDept = "select dt_name,dt_id from tb_deptinfo where dt_id in (select dt_id from tb_proceeding where pr_id='" + pr_id + "')";
}
CDataCn dCn = null;
CDataImpl dImpl = null;
try{
dCn = new CDataCn();
dImpl = new CDataImpl(dCn); 
%>
<table width="100%" border="0" cellspacing="0">
	<tr>
		<td align="left">&nbsp;<b>主办部门</b></td>
	</tr>
	<tr>
	<%
	if (!sqlStrDept.equals(""))
	{
		Hashtable content = dImpl.getDataInfo(sqlStrDept);
		if (content!=null)
		{
			String dt_name = content.get("dt_name").toString();
			String dt_id = content.get("dt_id").toString();
			out.print("<td style='cursor:hand' width=50% height=30 onclick=\"choose('"+dt_id+"',1);\" align=\"center\" id=\"td" +dt_id+ "\">" + dt_name + "<input type=hidden name='id"+dt_id+"'value='" + dt_id + "'></td>");
			out.print("<td align=left><div id=\"div" +dt_id+ "\" style=\"display:none\"><img src=\"/website/images/choossed.gif\"></div></td>");
		}
	}
	%>
	</tr>
	<%
	if (!sqlStrCorr.equals(""))
	{
		Vector vPage = dImpl.splitPage(sqlStrCorr,20,1);
		if (vPage!=null)
		{
		%>
	<tr>
		<td align="left">&nbsp;<b>协办部门</b></td>
	</tr>
	<%
			for (int i=0;i<vPage.size();i++)
			{
				Hashtable content = (Hashtable)vPage.get(i);
				String dt_id = content.get("dt_id").toString();
				String dt_name = content.get("dt_name").toString();
				corr_pr_id += dt_id + ",";
				out.print("<tr>");
				out.print("<td style='cursor:hand' width=50% height=30 onclick=\"choose('"+dt_id+"',2);\" align=\"center\" id=\"td" +dt_id+"_"+dt_id+ "\">" + dt_name + "<input type=hidden name='id"+dt_id+"_"+dt_id+"'value='" + dt_id + "'></td>");
				out.print("<td aglin='left'><div id=\"div" +dt_id+"_"+dt_id+ "\" style=\"display:none\"><img src=\"/website/images/choossed.gif\"></div></td>");
				out.print("</tr>");
			}
		}
		corr_pr_id = corr_pr_id.substring(0,corr_pr_id.length() - 1);
	}
	%>
<input type="hidden" name="corr_pr_id" value="<%=corr_pr_id%>">
	<tr>
		<td background="/website/images/bj-11.gif" colspan="2"> &nbsp;</td>
	</tr>
	<tr>
		<td colspan="2" align="center">
			<textarea readonly class="text-line" rows="3" cols="38" name="selDeptName"></textarea> 
			<input type="hidden" name="selDeptId" value="">
		</td>
	</tr>
	<tr>
		<td align="center" colspan="2">
			<input type="button" class="bttn" onclick="fnComplete();" value="确定">&nbsp;&nbsp;
			<input type="button" class="bttn" onclick="redo();" value="重选">
		</td>
	</tr>
</table>

<%
}
catch(Exception e){
//e.printStackTrace();
out.print(e.toString());
}
finally{
dImpl.closeStmt();
dCn.closeCn(); 
}
%>