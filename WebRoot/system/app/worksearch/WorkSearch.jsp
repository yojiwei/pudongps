<%@ page contentType="text/html; charset=GBK" %>
<%@include file="/system/app/skin/head.jsp"%>
<script LANGUAGE="javascript" src="../infopublish/common/common.js"></script>
<script language="javascript">
function visible()
{
	 var j=0;
	 for (var i=0;i<document.formData.elements.length;i++)
	{
		 if((document.formData.elements[i].checked)&&(document.formData.elements[i].value!=3&&document.formData.elements[i].value!=4))
			j=1;
	}
	if(j==1)
	{
		document.formData.wo_isovertime.style.visibility="visible";
	}
	else
	{
		document.formData.wo_isovertime.style.visibility="hidden";
	}
}
</script>
<table align="center" width="100%" class="main-table">
<form name="formData" method="post" action="WorkList.jsp" onsubmit="merger();">
	<tr class="title1" width="100%">
		<td colspan="2" class="outset-table">网上办事查询
		</td>
	</tr>
	<tr class="line-even">
		<td width="15%" align="right">申请人</td>
		<td align="left"><input name="applyPeople" class="text-line" maxlength="20"></td>
	</tr>
	<tr class="line-even">
		<td width="15%" align="right">单位名称</td>
		<td align="left"><select class="select-a" name="dt_id">
			<option value="">请选择受理单位</option>
			<%
			//update20080122

CDataCn dCn=null;   //新建数据库连接对象
CDataImpl dImpl=null;  //新建数据接口对象

try {
 dCn = new CDataCn(); 
 dImpl = new CDataImpl(dCn); 
			String dt_name = "";
			String dt_id = "";
			Vector vPage = null;
			String sqlStr = "select * from tb_deptinfo order by dt_id";
			vPage = dImpl.splitPage(sqlStr,request,100);
			if (vPage!=null)
			{
					for(int i=0;i<vPage.size();i++)
					{
							Hashtable content = (Hashtable)vPage.get(i);
							dt_id = content.get("dt_id").toString();
							dt_name = content.get("dt_name").toString();
							%>
							<option value="<%=dt_id%>"><%=dt_name%></option>
							<%
					}
			}
			%>
			</select>
		</td>
	</tr>
	<tr class="line-odd">
		<td width="15%" align="right">申请时间</td>
		<td align="left"><input name="beginTime" style="cursor:hand" class="text-line" readonly size="10" onclick="showCal()">&nbsp;至&nbsp;<input style="cursor:hand" name="endTime" class="text-line" readonly size="10" onclick="showCal()"></td>
	</tr>
	<tr class="line-even">
		<td width="15%" align="right">项目名称</td>
		<td align="left"><input name="pr_name" size="40" class="text-line" maxlength="40"></td>
	</tr>
	<tr class="line-odd">
		<td width="15%" align="right">项目状态</td>
		<td align="left">
			<input type="checkbox" name="status" class="checkbox1" value="1" checked onclick="visible()">进行中
			<input type="checkbox" name="status" class="checkbox1" value="3" checked>已通过
			<input type="checkbox" name="status" class="checkbox1" value="4" checked>未通过
			<input type="checkbox" name="status" class="checkbox1" value="8" checked onclick="visible()">协调中
			<input type="checkbox" name="status" class="checkbox1" value="2" checked onclick="visible()">待补件
			<select name="wo_isovertime" class="select-a" style="visibility:visible">
				<option value="">请选择状态</option>
				<option value="0">未超时</option>
				<option value="1">已超时</option>
			</select>
		</td>
	</tr>
	<tr class="title1" width="100%">
		<td colspan="2" class="outset-table">
			<input type="submit" class="bttn" value="搜索">&nbsp;
			<input type="reset" class="bttn" value="重写">&nbsp;
		</td>
	</tr>
<input type="hidden" name="OPType" value="search">
<input type="hidden" name="status1" value="">
</form>
<script language="javascript">
function merger()
{
	var obj1 = formData.status;
	var obj2 = formData.status1;
	var str = "";
	for (var i=0;i<obj1.length;i++)
	{
		if (obj1[i].checked)
		{
			str += obj1[i].value;
			str += ",";
		}
	}
	if (str.length>0)
	{
		str = str.substring(0,str.length-1);
	}
	obj2.value = str;
}
</script>
</table>
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
<%@include file="/system/app/skin/bottom.jsp"%>