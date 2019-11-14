<%@page contentType="text/html; charset=GBK"%>
<%@include file="/system/app/skin/head.jsp"%>
<%
CDataCn dCn = null;
CDataImpl dImpl = null;
try{
dCn = new CDataCn();
dImpl = new CDataImpl(dCn);
//
String sql_corrsearch = " select dt_id,dt_name from tb_deptinfo ";
%>
<%@include file="/system/app/skin/skin4/template/info_top.jsp"%>
<!--    模块名称开始    -->
协调单查询
<!--    模块名称结束    -->
<%@include file="/system/app/skin/skin4/template/info_funtion.jsp"%>
<!--    功能按钮开始    -->

<!--    功能按钮结束    -->
<%@include file="/system/app/skin/skin4/template/info_main.jsp"%>
<!--    表单提交开始    -->

<table align="center" width="100%" CELLPADDING="1" cellspacing="1">
<form action="/system/app/cooperate/CorrSearchResult.jsp" method="post" name="formData">
	<tr class="line-even" >
		 <td width="19%" align="right">项目名称：</td>
		 <td width="81%" align="left"><input type="text" class="text-line" size="45" name="wo_projectname" maxlength="150"></td>
	</tr>
	<tr class="line-odd">
		<td width="19%" align="right">发送人：</td>
		<td width="81%" align="left"><input type="text" class="text-line" size="45" name="wo_applypeople" maxlength="150"></td>
	</tr>
	<tr class="line-even">
		<td width="19%" align="right">协调单状态：</td>
		<td width="81%" align="left">
			<select class="select-a" name="de_status">
			<option value="0">全部</option>
			<option value="1">发送</option>
			<option value="2">签收</option>
			<option value="4">反馈发送</option>
			<option value="5">反馈签收</option>
			</select>
		</td>
	</tr>
	<tr class="line-odd">
		<td width="19%" align="right">发送部门：</td>
		<td width="81%" align="left">
		<select class="select-a" name="de_senddeptid">
		<option value="0">选择部门</option>
		<%
		Vector vectorsend = dImpl.splitPage(sql_corrsearch,request,20);
		if(vectorsend!=null)
		{
	
			for(int i=0;i<vectorsend.size();i++)
			{
				Hashtable content = (Hashtable)vectorsend.get(i);
		%>
			<option value="<%=content.get("dt_id").toString()%>"><%=content.get("dt_name").toString()%></option>
		<%
			}
		}
			%>
		</select>
		</td>
	</tr>
	<tr class="line-even">
		<td width="19%" align="right">接收部门：</td>
		<td width="81%" align="left">
		<select class="select-a" name="de_receiverdeptid">
		<option value="0">选择部门</option>
		<%
		Vector vectorreceive = dImpl.splitPage(sql_corrsearch,request,20);
		if(vectorreceive!=null)
		{
	
			for(int i=0;i<vectorreceive.size();i++)
			{
				Hashtable content = (Hashtable)vectorreceive.get(i);
		%>
			<option value="<%=content.get("dt_id").toString()%>"><%=content.get("dt_name").toString()%></option>
		<%
			}
		}
			%>
		</select>
		</td>
	</tr>
	<tr class="title1" width="100%">
	<td width="100%" align="center"  colspan="2" class="outset-table">
	<input class="bttn" value="查询" type="submit" size="6" name="btnSubmit">&nbsp;
	<input class="bttn" value="重写" type="reset">
	<input class="bttn" value="返回" type="button" onclick="history.back();" size="6" >&nbsp;
	</td>
	</tr></form>
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
                                     
