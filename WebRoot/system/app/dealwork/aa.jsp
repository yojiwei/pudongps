<%@ page contentType="text/html; charset=GBK" %>
<%@include file="/system/app/skin/head.jsp"%>
<script language="javascript">
function selectAll()
{
	var obj = document.all.del;
	var obj1 = selAll;
	if (typeof(obj)=="undefined") return false;
	if (typeof(obj.length)=="undefined")
	{
		obj.checked = obj1.checked;
	}
	else
	{
		for (var i=0;i<obj.length;i++)
		{
			obj[i].checked = obj1.checked;
		}
	}
}

function check()
{
	var obj = document.all.del;
	if (typeof(obj)=="undefined") return false;
	if (typeof(obj.length)=="undefined")
	{
		if (obj.checked)
			return true;
	}
	else
	{
		for (var i=0;i<obj.length;i++)
		{
			if (obj[i].checked)
				return true;
		}
	}
	return false;
}

function delAll()
{
	if(check())
	{
		if(confirm("确实要删除吗？"))
		{
			formData.action = "ProceedLawDelResult.jsp";
			formData.submit();
		}
	}
	else
	{
		alert("没有选中要删除的项！");
	}
}
</script>
<%
String pr_id = "";
String pr_name = "";
String sqlStr = "";
pr_id = CTools.dealString(request.getParameter("pr_id")).trim();
if (!pr_id.equals(""))
{
	sqlStr = "select a.pr_name,a.contentid,b.contenttitle from tb_proceedlaw a,carmot.tbcontent b where a.pr_id='"+pr_id+"' and b.contentid=a.contentid";
}
//update20080122

CDataCn dCn=null;   //新建数据库连接对象
CDataImpl dImpl=null;  //新建数据接口对象

try {
 dCn = new CDataCn(); 
 dImpl = new CDataImpl(dCn); 
%>
<table width="100%" class="main-table">
	<tr class="title1" width="100%">
		<td colspan="3">
			<table border="0" cellspacing="0" width="100%">
				<tr width="100%">
					<td align="left">&nbsp;法律法规</td>
					<td align="right">
						<img src="/system/images/split.gif" align="middle" border="0" WIDTH="5" HEIGHT="8">
						<img src="/system/images/delete.gif" align="middle" border="0" style="cursor:hand" onclick="delAll()" title="删除选中">
						<img src="/system/images/split.gif" align="middle" border="0" WIDTH="5" HEIGHT="8">
						<input type="checkbox" id="selAll" onclick="selectAll()" style="cursor:hand">
						<label for="selAll" style="cursor:hand">全选</label>
						<img src="/system/images/split.gif" align="middle" border="0" WIDTH="5" HEIGHT="8">
						<img src="/system/images/new.gif" border="0" onclick="javascript:window.location.href='ProceedLaw.jsp?pr_id=<%=pr_id%>'" title="新增" style="cursor:hand" align="absmiddle">
						<img src="/system/images/split.gif" align="middle" border="0" WIDTH="5" HEIGHT="8">
						<img src="/system/images/goback.gif" border="0" onclick="javascript:history.back();" title="返回" style="cursor:hand" align="absmiddle">
						<img src="/system/images/split.gif" align="middle" border="0" WIDTH="5" HEIGHT="8">
					</td>
				</tr>
			</table>
		</td>
	</tr>
	<tr class="bttn" width="100%">
		<td class="outset-table" align="center" width="45%">项目名称</td>
		<td class="outset-table" align="center" width="45%">法律法规</td>
		<td class="outset-table" align="center" width="10%">删除</td>
	</tr>
<%
if (!sqlStr.equals(""))
{
	Vector vPage = dImpl.splitPage(sqlStr,1000,1);
	if (vPage!=null)
	{
		for (int i=0;i<vPage.size();i++)
		{
			Hashtable content = (Hashtable)vPage.get(i);
			pr_name = content.get("pr_name").toString();
			String title = content.get("contenttitle").toString();
			%>
			<tr class="<%if(i%2==0) out.print("line-even");else out.print("line-odd");%>" width="100%">
				<td><%=pr_name%></td>
				<td><%=title%></td>
				<td><input type="checkbox" class="checkbox1" name="del"></td>
			</tr>
			<%
		}
	}
}
%>
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