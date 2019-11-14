<%@ page contentType="text/html; charset=GBK"%>
<%@ page import="com.component.database.*"%>
<%@ page import="java.util.*"%>
<%@ page import="com.platform.meta.*"%>
<%@ page import="com.util.CTools"%>

<link href="../style.css" rel="stylesheet" type="text/css">
<script LANGUAGE="javascript">
<!--
function check()
{
	var form = document.formData ;
	if (form.name.value == "" ) {
		alert("数据名称不能为空！") ;
		form.name.focus();
		return;
	}
	form.submit() ;
}

function del()
{
  if(!confirm("您确定要删除该字典数据吗？"))return;
  formData.action = "metaFileDel.jsp";
  formData.submit();
}
//-->
</script>

<script language="javascript" for="window" event="onload">
	document.formData.dv_value.focus();
</script>

<%
	String dv_id = "", dv_value = "";
	String list_id = "";
	String node_title = "";
	String sql = "";
	String title = "";
	String dv_code = "";
	CTools tools = null;
	Hashtable content = null;
	long id;
%>

<%
	tools = new CTools();
	list_id = request.getParameter("list_id");
	node_title = tools.iso2gb(request.getParameter("node_title"));
	dv_id = request.getParameter("dv_id");
	// out.print(list_id);

	if (list_id == null)
		list_id = "1";

	////////////////////////////////////////////////////////
	// dv_id: 字典本身ID号
	// list_id: 目录传递ID号

	if (dv_id == null) { //新增状态
		title = "新增字典";
		dv_id = "0";
	} else { //显示、修改
		title = "修改字典";
		CDataCn dCn = null;
		CMetaFileInfo jdo = null;
		try {
			dCn = new CDataCn();
			jdo = new CMetaFileInfo(dCn);
			id = java.lang.Long.parseLong(dv_id);
			content = jdo.getDataInfo(id);
			if (content != null) {
		dv_value = content.get("dv_value").toString();
		dv_code = content.get("dv_code").toString();
			}
			jdo.closeStmt();
			dCn.closeCn();
			jdo = null;
		} catch (Exception ex) {
			System.out.println(new java.util.Date() + "--"
			+ request.getServletPath() + " : "
			+ ex.getMessage());
		} finally {
			if (jdo != null)
		jdo.closeStmt();
			if (dCn != null)
		dCn.closeCn();
		}
	}
%>
<table class="main-table" width="100%">
	<form action="metaFileInfoResult.jsp" method="post" name="formData">
	<tr>
		<td width="100%">
			<div align="center">
				<table border="0" width="100%" cellpadding="0" cellspacing="0">
					<tr valign="bottom" class="bttn">
						<td width="100%" align="left" colspan="4">
							<table width="100%">
								<tr>
									<td id="TitleTd" width="100%" align="left">
										<%=title%>
									</td>
									<td valign="top" align="right" nowrap>
										<img src="/system/images/dialog/split.gif" align="middle"
											border="0">

										<img src="/system/images/dialog/return.gif" border="0"
											onclick="javascirpt:history.go(-1);" title="返回"
											style="cursor:hand" align="absmiddle" id="image3"
											name="image3" WIDTH="14" HEIGHT="14">
										<img src="/system/images/dialog/split.gif" align="middle"
											border="0">
									</td>
								</tr>
							</table>
						</td>
					</tr>
					<tr>
						<td width="100%" align="left" valign="top">
							<table border="0" width="100%" cellspacing="1" cellpadding="0">
								<tr class="line-odd">
									<td width="15%" align="right">
										名称：
									</td>
									<td width="85%">
										<input class="text-line" name="dv_value" size="20"
											value="<%=dv_value%>" maxlength="20">
									</td>
								</tr>

								<tr class="line-even">
									<td width="15%" align="right">
										值：
									</td>
									<td width="85%">
										<input class="text-line" type="text" value="<%=dv_code%>"
											name="dv_code">
									</td>
								</tr>

							</table>
						</td>
					</tr>

					<tr>
						<td width="100%" align="right" colspan="2" class="title1">
							<p align="center">
								<%
								if (dv_id.equals("0")) {//新增
								%>
								<input class="bttn" value="提交" type="button" onclick="check()"
									size="6">
								&nbsp;
								<%
								} else {
								%>
								<input class="bttn" value="修改" type="button" onclick="check()"
									size="6">
								&nbsp;
								<input class="bttn" value="删除" type="button" size="6"
									onclick="del()">
								&nbsp;
								<%
								}
								%>
								<input class="bttn" value="返回" type="button"
									onclick="history.back()" size="6">
								&nbsp;
						</td>
					</tr>
				</table>
			</div>
			<input type="hidden" name="list_id" value="<%=list_id%>">
			<input type="hidden" name="node_title" value="<%=node_title%>">
			<input type="hidden" name="dv_id" value="<%=dv_id%>">
		</td>
	</tr>
	</form>
</table>


