<%@page contentType="text/html; charset=GBK"%>
<%@include file="/system/app/skin/head.jsp"%>
<%
String sqlStr = "";
String qu_id = "";
String strTitle = "问题解答";
String question = "";
String answer = "";
String us_kind = "";
String qu_sequence = "0";
String qu_error="";

qu_id = CTools.dealString(request.getParameter("qu_id")).trim();

//update20080122

CDataCn dCn=null;   //新建数据库连接对象
CDataImpl dImpl=null;  //新建数据接口对象

try {
 dCn = new CDataCn(); 
 dImpl = new CDataImpl(dCn); 


if (!qu_id.equals(""))
{
	sqlStr = "select qu_title,us_kind,qu_sequence,qu_content,qu_error from tb_question where qu_id='"+qu_id+"'";
	Hashtable content = dImpl.getDataInfo(sqlStr);
	if (content!=null)
	{
		question = content.get("qu_title").toString();
		us_kind = content.get("us_kind").toString();
		qu_sequence = content.get("qu_sequence").toString();
		answer = content.get("qu_content").toString();
		qu_error = content.get("qu_error").toString();
	}
}
%>
<script language="javascript">
function delThis(val)
{
	if (confirm("确实要删除吗？"))
	{
		window.location.href="QuestionDel.jsp?qu_id="+val;
	}
}

//判定是否以空作为组成内容,是返回fasle,否则返回true
function chkKong(obj) {
	if (obj.length == 0) return false;
	var bool = 0;
	for (var i = 0;i < obj.length;i++) {
		if (obj.substring(i,i+1) == " ") {
			bool = 1;
		}
		else {
			bool = 0;
			return true;
			break;
		}
	}
	if (bool == 1) {
		//alert("不能以空作为内容！");
		return false;
	}
}

function checkForm()
{
	if (formData.question.value=="" || chkKong(formData.question.value) == false)
	{
		alert("热点问题不能为空！");
		formData.question.focus();
		return false;
	}
	else if (formData.answer.value=="" || chkKong(formData.answer.value) == false)
	{
		alert("问题解答不能为空！");
		formData.answer.focus();
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
	formData.action = "QuestionResult.jsp";
	formData.submit();
}
</script>
<table class="main-table" width="100%">
<form name="formData" method="post">
	<tr class="title1" width="100%">
		<td width="100%" align="center"><%=strTitle%></td>
	</tr>
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
					<td width="15%" align="right">问题类型：</td>
					<td align="left">
					 <select name="qu_error" class="select-a">
						<%
						String sqlStr3="select * from tb_datavalue where dd_id='130'";
						Vector vPage2=dImpl.splitPage(sqlStr3,request,20);
						if(vPage2!=null)
						{
							for(int j=0;j<vPage2.size();j++)
							{
								Hashtable con2=(Hashtable)vPage2.get(j);
								String dv_id=con2.get("dv_id").toString();
								String dv_value=con2.get("dv_value").toString();
								%>
								<option value="<%=dv_id%>"<%if(dv_id.equals(qu_error))out.print("selected");%>><%=dv_value%></option>
								<%
							}
						}
						
						%>
						</select>
					</td>
				</tr>
				<tr class="line-odd" width="100%">
					<td width="15%" align="right">热点问题：</td>
					<td align="left"><input size="62" type="text" class="text-line" name="question" value="<%=question%>" maxlength="100"></td>
				</tr>
				<tr class="line-even" width="100%">
					<td width="15%" align="right">问题解答：</td>
					<td align="left"><textarea cols="60" rows="6" name="answer" class="text-line" maxlength="300"><%=answer%></textarea>
				</tr>
				<tr class="line-odd" width="100%">
					<td width="15%" align="right">排序字段：</td>
					<td align="left"><input type="text" size="4" class="text-line" name="sort" value="<%=qu_sequence%>"> </td>
				</tr>
			</table>
		</td>
	</tr>
	<tr class="title1" width="100%">
		<td align="center">
			<input type="button" class="bttn" name="btnSubmit" value="确定" onclick="checkForm()">&nbsp;
			<input type="reset" class="bttn" name="btnReset" value="重写">&nbsp;
			<%
			if(!qu_id.equals(""))
			{
			%>
			<input type="button" class="bttn" name="btnDel" value="删除" onclick="delThis('<%=qu_id%>')">&nbsp;
			<%
			}
			%>
			<input type="button" name="btnBack" class="bttn" value="返回" onclick="javascript:window.history.go(-1);">
		</td>
	</tr>
<input type="hidden" name="qu_id" value="<%=qu_id%>">
</form>
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
