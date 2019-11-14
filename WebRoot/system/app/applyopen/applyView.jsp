<%@page contentType="text/html; charset=GBK"%>
<%@include file="/system/app/skin/head.jsp"%>
<%
String sqlStr = "";
String strTitle = "信息公开一体化";
Vector vPage = null;
Hashtable content = null;
String iid = CTools.dealString(request.getParameter("iid")).trim();
//
CDataCn dCn = null;
CDataImpl dImpl = null;
try{
dCn = new CDataCn();
dImpl = new CDataImpl(dCn);
%>
<%@include file="/system/app/skin/skin4/template/list_top.jsp"%>
<!--    模块名称开始    -->
<%=strTitle%>
<!--    模块名称结束    -->
<%@include file="/system/app/skin/skin4/template/list_function.jsp"%>                                                            
<!--    功能按钮开始    -->
  
<!--    功能按钮结束    -->
<%@include file="/system/app/skin/skin4/template/list_listtop.jsp"%>                                                                                        
<!--    列表开始    -->
<link href="applyopen.css" type="text/css" rel="stylesheet">
<script language="javascript" src="applyopen.js"></script>
<form name="formData" method="post" action="taskdeal.jsp">
<table class="FindAreaTable1" cellspacing="1" rules="cols" border="0" id="ctl00_DataGrid_DataGrid1" style="border-width:0px;">
		<td width="100%">
			<table width="100%" class="content-table" height="1">
				<tr class="line-odd" >
					<td width="100%" colspan="2" align="left">&nbsp;<b>申请信息</b></td>
				</tr>
				<tr>
					<td colspan="2" class="line-even"><%@include file="applySheet.jsp"%></td>
				</tr>
				<tr class="line-odd" >
					<td width="100%" colspan="2" align="left">&nbsp;<b>办理流程</b></td>
				</tr>
				<tr>
					<td colspan="2" class="line-even"><%@include file="applyFlow.jsp"%></td>
				</tr>
			</table>
		</td>
	</tr>

	<tr class="title1" align="center" id="btnObj" style="display:">
		<td colspan="2">
			<input type="button" class="bttn" name="" value=" 认领 " onclick="javascript:claimIt('<%=iid%>');">&nbsp;
			<input type="button" class="bttn" name="" value=" 返回 " onclick="javascript:history.back();">
		</td>
	</tr>
</table>
</form>
<!--    列表结束    -->
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