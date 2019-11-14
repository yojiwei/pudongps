<%@ page contentType="text/html; charset=GBK" %>
<%@include file="/system/app/skin/head.jsp"%>
<%
String pr_id = "";
String pr_name = "";
String sqlStr = "";
String categoryid = "";
String keyword = "";
String cIds = "";
String strTitle = "相关法律法规";

pr_id = CTools.dealString(request.getParameter("pr_id")).trim();
categoryid = CTools.dealString(request.getParameter("category")).trim();
keyword = CTools.dealString(request.getParameter("title")).trim();

CDataCn dCn = null;
CDataImpl dImpl = null;
try{
dCn = new CDataCn();
dImpl = new CDataImpl(dCn);
if (!pr_id.equals(""))
{
	sqlStr = "select pr_name from tb_proceeding where pr_id='"+pr_id+"'";
	Hashtable content = dImpl.getDataInfo(sqlStr);
	if (content!=null)
	{
		pr_name = content.get("pr_name").toString();
	}
}
%>
<script language="javascript">
function openQuery()
{
	formData.action="ProceedLaw.jsp";
	formData.submit();
}

function delSelect()
{
	var obj = formData.content;
	if (obj.length>0)
	{
		var index = obj.selectedIndex;
		if (typeof(index)=="undefined") return false;
		obj.remove(index);
	}
}

function checkForm()
{
	var obj1 = formData.selectedContent;
	var obj2 = formData.content;
	if (obj2.length>0)
	{
		var str = "";
		for (var i=0;i<obj2.length;i++)
		{
			str += obj2.options[i].value;

			str += ",";
		}
		if (str.length>0)
		{
			str = str.substring(0,str.length-1);
		}
		obj1.value = str;
	}
	else
	{
		alert("没有选出相关法律法规！");
		return false;
	}
	formData.action = "ProceedLawResult.jsp";
	formData.submit();
}
</script>
<table class="main-table" width="100%" align="center">
<form name="formData" method="post">
	<tr class="title1" width="100%">
		<td colspan="2"><%=strTitle%></td>
	</tr>
	<tr class="line-even" width="100%">
		<td align="right" width="18%">项目名称：</td>
		<td align="left">&nbsp;<input name="pr_name" class="text-line" value="<%=pr_name%>" size="40" readonly><input type="hidden" name="pr_id" value="<%=pr_id%>"></td>
	</tr>
	<tr class="line-odd" width="100%">
		<td align="right" width="18%">法规栏目：</td>
		<td align="left">
			<span style="width:6px"> </span>
			<select name="category" class="select-a" style="width:300px">
				<option value="0">所有</option>
<%
sqlStr = "select categoryname,categoryid from carmot.tbcategory where ";  //列出法律法规的所有栏目
sqlStr += "categorypath like '101,74301,74701%' order by categorypath";
Vector vPage = null;
if (!sqlStr.equals(""))
{
	vPage = dImpl.splitPage(sqlStr,1000,1);
	Hashtable content = null;
	String id = "";
	String name = "";
	if (vPage!=null)
	{
		for (int i=0;i<vPage.size();i++)
		{
			content = (Hashtable)vPage.get(i);
			id = content.get("categoryid").toString();
			name = content.get("categoryname").toString();
			cIds += "'"+ id +"'" + ",";
			%>
									<option value="<%=id%>" <%if(id.equals(categoryid)) out.print("selected");%>><%=name%></option>
			<%
		}
		if (cIds.length()>0)
		{
			cIds = cIds.substring(0,cIds.length()-1);
		}
	}
}
%>
							</select>
		</td>
	</tr>
	<tr class="line-even" width="100%">
		<td width="18%" align="right">法规名称：</td>
		<td align="left">
			<span style="width:6px"> </span>
			<input name="title" size="40" class="text-line" value="<%=keyword%>" maxlength="200">&nbsp;&nbsp;
			<img src="/system/images/menu_about.gif" border="0" onclick="javascript:openQuery();" title="查找法律法规" style="cursor:hand" align="absmiddle" WIDTH="16" HEIGHT="16">
		</td>
	</tr>
	<tr class="line-odd" width="100%">
		<td width="18%" align="right">搜索结果：</td>
		<td align="left">
			<span style="width:6px"> </span>
			<select name="content" class="select-a" size="6" style="width:470px" ondblclick="delSelect()">
			<%
			if (!categoryid.equals(""))
			{
				if (!categoryid.equals("0"))
					sqlStr = "select a.contenttitle,a.contentid from carmot.tbcontent a,carmot.tbcontent_category b where a.contentid=b.contentid and b.categoryid="+categoryid +" and a.contenttitle like '%"+keyword+"%'";
				else
					sqlStr = "select a.contenttitle,a.contentid from carmot.tbcontent a,carmot.tbcontent_category b where a.contentid=b.contentid and b.categoryid in("+cIds+") and a.contenttitle like '%"+keyword+"%'";
				out.print("sqlStr="+sqlStr);
				vPage = dImpl.splitPage(sqlStr,1000,1);
				String title = "";
				if (vPage!=null)
				{
					for (int i=0;i<vPage.size();i++)
					{
						content = (Hashtable)vPage.get(i);
						id = content.get("contentid").toString();
						title = content.get("contenttitle").toString();
						%>
						<option value="<%=id%>"><%=title%></option>
						<%
					}
				}
			}
			%>
			</select>
		</td>
	</tr>
	<tr class="title1" width="100%">
		<td width="100%" align="center" colspan="2">
			<input type="button" class="bttn" value="提交" onclick="checkForm()">&nbsp;
			<input type="reset" class="bttn" value="重写">&nbsp;
			<input type="button" class="bttn" value="返回" onclick="window.history.go(-1);">&nbsp;
		</td>
	</tr>
<input type="hidden" name="selectedContent" value="">
</form>
</table>
<%
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