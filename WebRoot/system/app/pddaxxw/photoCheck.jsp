<%@page contentType="text/html; charset=GBK"%>
<%@include file="/system/app/skin/head.jsp"%>
<%
String op_ischeck="";
String op_imgpath = "";
String op_imgrealname = "";
String op_tel = "";
String op_date = "";
String op_type = "";
String op_imgname = "";
String op_id = "";
String op_name = "";
String op_email = "";
String op_address = "";
String path = "";
String imgpath = "";
CDataCn dCn = null;
CDataImpl dImpl = null;
try{
dCn = new CDataCn();
dImpl = new CDataImpl(dCn);

path = dImpl.getInitParameter("workattach_http_path");//档案局征集图片放置路径
op_type = CTools.dealString(request.getParameter("op_type")).trim();

String sql_list = " select d.op_id,d.op_name,d.op_tel,d.op_email,d.op_address,d.op_imgname,d.op_imgpath,to_char(d.op_date,'yyyy-MM-dd hh24:mi:ss') as op_date,d.op_imgrealname,d.op_ischeck from tb_daxxphoto d where 1=1";
if(!"".equals(op_type)){
	sql_list += " and d.op_ischeck="+op_type+"";
}
sql_list += " order by d.op_id desc ";

%>
<%@include file="/system/app/skin/skin4/template/list_top.jsp"%>
<!--    模块名称开始    -->
向您征集图片列表
<!--    模块名称结束    -->
<%@include file="/system/app/skin/skin4/template/list_function.jsp"%>                                                            
<!--    功能按钮开始    -->
<script language="javascript">
function TypeChange(){
	var ac_type = document.all.op_type_.value;
	if(ac_type!=""){
		window.location.href="photoCheck.jsp?op_type="+ac_type;
	}else{
		window.location.href="photoCheck.jsp";
	}
}
</script>
<select name="op_type_" onchange="TypeChange()">
<option value="">全部</option>
<option value="0" <%=op_type.equals("0")?"selected":""%>>审核通过</option>
<option value="1" <%=op_type.equals("1")?"selected":""%>>审核不通过</option>
</select>
&nbsp;
<input type="button" border="0" onClick="GetAllSelect();" value="批处理审核通过" style="cursor:hand" align="absmiddle">
<input type="button" border="0" onClick="GetNoneSelect();" value="批处理审核不通过" style="cursor:hand" align="absmiddle">
<!--    功能按钮结束    -->
<%@include file="/system/app/skin/skin4/template/list_listtop.jsp"%>                                                                                        
<!--    列表开始    -->
<table class="FindAreaTable1" cellspacing="1" rules="cols" border="0" id="ctl00_DataGrid_DataGrid1" style="border-width:0px;">
	<tr class="bttn">
	<td width="10%" class="outset-table" align="center">征集人</td>
	<td width="10%" class="outset-table" align="center">联系电话</td>
	<td width="10%" class="outset-table" align="center">电子邮件</td>
	<td width="10%" class="outset-table" align="center">家庭地址</td>
	<td width="10%" class="outset-table" align="center">附件名称</td>
	<td width="15%" class="outset-table" align="center">提供时间</td>
	<td width="10%" class="outset-table" align="center">是否审核通过</td>
	<td width="10%" class="outset-table" align="center"><input type="checkbox"   onclick="javascript:SelectAllCheck('opid')">&nbsp;全选</td>
	</tr>
	<form name="formData">
	<%
	Vector vectorList = dImpl.splitPage(sql_list,request,20);
	Hashtable content = null;
	if(vectorList!=null)
	{
		for(int i=0;i<vectorList.size();i++)
		{
			content = (Hashtable)vectorList.get(i);
			op_id = CTools.dealNull(content.get("op_id"));
			op_name = CTools.dealNull(content.get("op_name"));
			op_imgpath = CTools.dealNull(content.get("op_imgpath"));
			op_imgname = CTools.dealNull(content.get("op_imgname"));
			op_imgrealname = CTools.dealNull(content.get("op_imgrealname"));
			op_email = CTools.dealNull(content.get("op_email"));
			op_address = CTools.dealNull(content.get("op_address"));
			op_tel = CTools.dealNull(content.get("op_tel"));
			op_date = CTools.dealNull(content.get("op_date"));
			op_ischeck = CTools.dealNull(content.get("op_ischeck"));
			
			
			imgpath = path+op_imgpath+"/"+op_imgname;
			
			if(i % 2 == 0)  out.print("<tr class=\"line-even\">");
			else out.print("<tr class=\"line-odd\">");
	%>
	<td align="center"><%=op_name%></td>
	<td align="center"><%=op_tel%></td>
	<td align="center"><%=op_email%></td>
	<td align="center"><%=op_address%></td>
	<td align="center"><%="".equals(op_imgrealname)?"无附件":op_imgrealname%></td>
	<td align="center"><%=op_date%></td>	
	<td align="center"><%=op_ischeck.equals("0")?"是":"否"%></td>
	<td align="center">
		<input type="checkbox" name="opid" value="<%=op_id%>"/>&nbsp;<input type="hidden" name="opids" />
	<input type="hidden" name="opischeck" />
		<a href="photoInfo.jsp?op_id=<%=op_id%>"><img class="hand" border="0" src="../../images/modi.gif" title="操作" WIDTH="16" HEIGHT="16"></a>
	</td>
	</tr>
</form>
<%
    }
  }
  else
  {
    out.println("<tr><td colspan=20>没有记录！</td></tr>");
  }
%>
</table>
<script>
//批处理审核通过
function GetAllSelect(){
	var id="";
	var sign = "false";
	var all=document.getElementsByName("opid");
	for(i=0;i<all.length;i++){
		if(all[i].checked){
			sign = "true";
			id+=all[i].value+",";
		}
	}
	if(sign=="false")
	{
		alert("请您至少选择一条需要批处理的记录!");
	}
	else
	{
		id=id.substring(0,id.length-1);
		formData.opids.value=id;
		formData.opischeck.value=0;
		document.formData.action="photoCheckResult.jsp";
		document.formData.submit();
	}
}
//批处理审核不通过
function GetNoneSelect(){
	var id="";
	var sign = "false";
	var all=document.getElementsByName("opid");
	for(i=0;i<all.length;i++){
		if(all[i].checked){
			sign = "true";
			id+=all[i].value+",";
		}
	}
	if(sign=="false")
	{
		alert("请您至少选择一条需要批处理的记录!");
	}
	else
	{
		id=id.substring(0,id.length-1);
		formData.opids.value=id;
		formData.opischeck.value=1;
		document.formData.action="photoCheckResult.jsp";
		document.formData.submit();
	}
}
//全选
function SelectAllCheck(a){
	o= document.getElementsByName(a);
	for(i=0;i<o.length;i++){
		o[i].checked=event.srcElement.checked;
	}
}
</script>
<!--    列表结束    -->
<%@include file="/system/app/skin/skin4/template/list_bottom.jsp"%> 
<%
}
catch(Exception e){
	System.out.println(new java.util.Date() + "--"
			+ request.getServletPath() + " : " + e.getMessage());
}
finally{
	dImpl.closeStmt();
	dCn.closeCn(); 
}
%>
<%@include file="/system/app/skin/bottom.jsp"%>