<%@page contentType="text/html; charset=GBK"%>
<%@include file="/system/app/skin/head.jsp"%>
<%
String sqlStr = "";
String strTitle = "";
String userKind = "";
String sugName = "";
String sequence = "";
String sg_id = "";
String OPType = "";

if(OPType.equals("Search"))
{
	strTitle = "特别推荐>>搜索结果";
}
else
{
	strTitle = "特别推荐>>列表";
}

//update20080122

CDataCn dCn=null;   //新建数据库连接对象
CDataImpl dImpl=null;  //新建数据接口对象

try {
 dCn = new CDataCn(); 
 dImpl = new CDataImpl(dCn); 

sqlStr = "select a.sg_id,a.sg_name,a.sg_sequence,b.uk_name from tb_suggest a,tb_userkind b where a.us_kind=b.uk_id ";
sqlStr += "and a.sg_name like '%"+sugName+"%' ";
if (!userKind.equals(""))
{
	sqlStr += "and a.us_kind='"+userKind+"'";
}
sqlStr += " order by a.sg_sequence";
%>
<%@include file="/system/app/skin/skin4/template/list_top.jsp"%>
<!--    模块名称开始    -->
<%=strTitle%>
<!--    模块名称结束    -->
<%@include file="/system/app/skin/skin4/template/list_function.jsp"%>                                                            
<!--    功能按钮开始    -->
<img src="/system/images/delete.gif" border="0" width="16" height="16" onclick="delSelect()" style="cursor:hand" title="删除选中项">
删除选中项
<input type="checkbox" id="selAll" name="selAll" onclick="selectAll()" style="cursor:hand">
<label for="selAll" style="cursor:hand">全选</label>
全选
<img src="/system/images/new.gif" border="0" onclick="window.location='SuggestionInfo.jsp'" title="新建特别推荐" style="cursor:hand" align="absmiddle" WIDTH="16" HEIGHT="16">
新建特别推荐
<img src="/system/images/sort.gif" title="修改排序" border="0" style="cursor:hand" onclick="javascript:setSequence();" width="16",height="16" align="absmiddle">
修改排序
<img src="/system/images/goback.gif" border="0" onclick="javascript:history.back();" title="返回" style="cursor:hand" align="absmiddle">
返回
<!--    功能按钮结束    -->
<%@include file="/system/app/skin/skin4/template/list_listtop.jsp"%>                                                                                        
<!--    列表开始    -->
<table class="FindAreaTable1" cellspacing="1" rules="cols" border="0" id="ctl00_DataGrid_DataGrid1" style="border-width:0px;">
<form name="formData" method="post">
	<tr class="bttn" width="100%">
		<td align="center" class="outset-table" width="10%">ID</td>
		<td align="center" class="outset-table" width="20%">用户类型</td>
		<td align="center" class="outset-table" width="30%">特别推荐</td>
		<td align="center" class="outset-table" width=10%">编辑</td>
		<td align="center" class="outset-table" width="10%">排序</td>
		<td align="center" class="outset-table" width="10%">删除</td>
	</tr>
	<%
	Vector vPage = dImpl.splitPage(sqlStr,request,20);
	if (vPage!=null)
	{
		for (int i=0;i<vPage.size();i++)
		{
			Hashtable content = (Hashtable)vPage.get(i);
			sg_id = content.get("sg_id").toString();
			sugName = content.get("sg_name").toString();
			sequence = content.get("sg_sequence").toString();
			userKind = content.get("uk_name").toString();
			%>
	<tr <%if(i%2==0) out.print("class='line-even'"); else out.print("class='line-odd'");%> width="100%">
		<td align="center"><%=sg_id%></td>
		<td align="center"><%=userKind%></td>
		<td align="center"><%=sugName%></td>
		<td align="center"><a href="SuggestionInfo.jsp?sg_id=<%=sg_id%>"><img src="/system/images/modi.gif" border="0"></a></td>
		<td ><input class="text-line" name="<%=sg_id%>" size="4" value="<%=sequence%>"></td>
		<td align="center"><input type="checkbox" class="checkbox1" name="del" value="<%=sg_id%>"></td>
	</tr>
			<%
		}
	}
	else
	{
		out.print("<tr class='line-even'><td  colspan=9>没有记录</td></tr>");
	}
	%>
	<input type="hidden" name="sg_id" value="">
	</form>
</table>
<!--    列表结束    -->

<SCRIPT LANGUAGE="javascript">
var sFlag = false;
function selectAll()
{
	var obj = formData.del;
	sFlag = !sFlag;
	if (typeof(obj)=="undefined") return false;
	if (typeof(obj.length)=="undefined")
	{
		obj.checked = sFlag;
	}
	else
	{
		var length = obj.length;
		for(var i=0;i<length;i++)
		{
			obj[i].checked = sFlag;
		}
	}
}

function delSelect()
{
	var obj = formData.del;
	var obj1 = formData.sg_id;
	if (typeof(obj)=="undefined") return false;
	if (typeof(obj.length)=="undefined")
	{
		if(obj.checked)
		{
			obj1.value = obj.value;
		}
	}
	else
	{
		var length = obj.length;
		var str = "";
		for(var i=0;i<length;i++)
		{
			if(obj[i].checked)
			{
				str += obj[i].value + ",";
			}
		}
		if(str.length>0)
		{
			str = str.substring(0,str.length);
		}
		obj1.value = str;
	}
	if(obj1.value!="")
	{
		if (!confirm("确定要删除您选择的记录吗？")) {
			return false;
		}
		formData.action = "SuggestionDel.jsp";
		formData.submit();
	}
	else
	{
		alert("没有选择要删除的项！");
	}
}

function setSequence()
{
        var form = document.formData ;
       	form.action = "setSequence.jsp";
        //form.action = "SuggestionList.jsp?refresh=true";  
        form.submit();
}
</SCRIPT>
<%@include file="/system/app/skin/skin4/template/list_bottom.jsp"%> 
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