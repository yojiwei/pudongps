<%@page contentType="text/html; charset=GBK"%>
<%@include file="/system/app/skin/head.jsp"%>
<%
String sqlStr = "";
String sg_id = "";
String strTitle = "特别推荐";
String suggest = "";
String us_kind = "";
String sg_sequence = "0";
String sg_url = "";

sg_id = CTools.dealString(request.getParameter("sg_id")).trim();

//update20080122

CDataCn dCn=null;   //新建数据库连接对象
CDataImpl dImpl=null;  //新建数据接口对象

try {
 dCn = new CDataCn(); 
 dImpl = new CDataImpl(dCn); 

if (!sg_id.equals(""))
{
	sqlStr = "select sg_name,us_kind,sg_sequence,sg_url from tb_suggest where sg_id='"+sg_id+"'";
	Hashtable content = dImpl.getDataInfo(sqlStr);
	if (content!=null)
	{
		suggest = content.get("sg_name").toString();
		us_kind = content.get("us_kind").toString();
		sg_sequence = content.get("sg_sequence").toString();
		sg_url = content.get("sg_url").toString();
	}
}
%>
<%@include file="/system/app/skin/skin4/template/info_top.jsp"%>
<!--    模块名称开始    -->
<%=strTitle%>
<!--    模块名称结束    -->
<%@include file="/system/app/skin/skin4/template/info_funtion.jsp"%>
<!--    功能按钮开始    -->

<!--    功能按钮结束    -->
<%@include file="/system/app/skin/skin4/template/info_main.jsp"%>
<!--    表单提交开始    -->
<script language="javascript">
function delThis(val)
{
	if (confirm("确实要删除吗？"))
	{
		window.location.href="SuggestionDel.jsp?sg_id="+val;
	}
}

function checkForm()
{
	if (formData.suggest.value=="" || formData.suggest.value==" ")
	{
		alert("特别推荐不能为空！");
		formData.suggest.focus();
		return false;
	}
	else if (formData.sg_url.value=="" || formData.sg_url.value==" ")
	{
		alert("链接地址不能为空！");
		formData.sg_url.focus();
		return false;
	}
	else if (formData.sort.value=="")
	{
		alert("排序字段不能为空！");
		formData.sort.focus();
		return false;
	}
	else if (isNaN(formData.sort.value))
	{
		alert("排序字段必须为数字！");
		formData.sort.focus();
		return false;
	}
	formData.action = "SuggestionResult.jsp";
	formData.submit();
}
</script>
<table class="main-table" width="100%">
<form name="formData" method="post">
<tr width="100%">
<td align="center" width="100%">
	<table width="100%" class="content-table">
		<tr width="100%" class="line-even">
			<td width="15%" align="right">用户类型：</td>
			<td align="left">
				<select name="userKind" class="select-a">
					<%
					sqlStr = "select uk_id,uk_name from tb_userkind order by uk_sequence";
					if (!sqlStr.equals(""))
					{
						Vector vPage = dImpl.splitPage(sqlStr,request,20);
						if (vPage!=null)
						{
							for(int i=0;i<vPage.size();i++)
							{
								Hashtable content = (Hashtable)vPage.get(i);
								String uk_id = content.get("uk_id").toString();
								String uk_name = content.get("uk_name").toString();
								%>
								<option value="<%=uk_id%>" <%if(uk_id.equals(us_kind)) out.print("selected");%>><%=uk_name%></option>
								<%
							}
						}
					}
					%>
				</select>
			</td>
		</tr>
		<tr class="line-odd" width="100%">
			<td width="15%" align="right">特别推荐：</td>
			<td align="left"><input type="text" class="text-line" name="suggest" value="<%=suggest%>" maxlength="50"></td>
		</tr>
		<tr class="line-even" width="100%">
			<td width="15%" align="right">链接地址：</td>
			<td align="left"><input size="40" type="text" class="text-line" name="sg_url" value="<%=sg_url%>" maxlength="150"></td>
		</tr>
		<tr class="line-odd" width="100%">
			<td width="15%" align="right">排序字段：</td>
			<td align="left"><input type="text" size="4" class="text-line" name="sort" value="<%=sg_sequence%>"></td>
		</tr>
	</table>
</td>
</tr>
<tr class="outset-table" width="100%">
<td align="center">
	<input type="button" class="bttn" name="btnSubmit" value="确定" onclick="checkForm()">&nbsp;
	<input type="reset" class="bttn" name="btnReset" value="重写">&nbsp;
	<%
	if(!sg_id.equals(""))
	{
	%>
	<input type="button" class="bttn" name="btnDel" value="删除" onclick="delThis('<%=sg_id%>')">&nbsp;
	<%
	}
	%>
	<input type="button" name="btnBack" class="bttn" value="返回" onclick="javascript:window.history.go(-1);">
</td>
</tr>
<input type="hidden" name="sg_id" value="<%=sg_id%>">
</form>
</table>
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
                                     
