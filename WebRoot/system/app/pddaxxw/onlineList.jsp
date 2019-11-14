<%@page contentType="text/html; charset=GBK"%>
<%@include file="/system/app/skin/head.jsp"%>
<script>
	function tocl(clvalue){
		var cltype = clvalue;
		window.location.href="onlineList.jsp?clstatus="+cltype;		
	}
</script>
<%
String dx_id="";
String dx_num = "";
String dx_name="";
String dx_applytime="";
String dx_backtype = "";
String dx_tel = "";
String dx_address = "";
String dx_codenumber = "";
String dx_email = "";
String dx_content = "";
String dx_use = "";
String dx_type = "";
String dx_status = "";
String us_id = "";
String clstatus = "";

CDataCn dCn = null;
CDataImpl dImpl = null;
try{
dCn = new CDataCn();
dImpl = new CDataImpl(dCn);

clstatus = CTools.dealString(request.getParameter("clstatus")).trim();

String sql_list = "select dx_id,dx_num,dx_name,to_char(dx_applytime,'yyyy-MM-dd hh24:mi:ss') as dx_applytime,dx_backtype,dx_status,dx_tel,dx_address,dx_codenumber,dx_email,dx_content,dx_use,dx_type,us_id from tb_daxx where dx_type='apply' ";

if(!"".equals(clstatus)){
	sql_list += " and dx_status='"+clstatus+"'";
}

sql_list += " order by dx_id desc ";
%>
<%@include file="/system/app/skin/skin4/template/list_top.jsp"%>
<!--    模块名称开始    -->
在线申请查档列表
<!--    模块名称结束    -->
<%@include file="/system/app/skin/skin4/template/list_function.jsp"%>                                                            
<!--    功能按钮开始    -->
请选择处理方式
<select name="cltype" onchange="tocl(this.value)">
	<option value="">全部</option>
	<option value="0" <%if("0".equals(clstatus))out.println("selected");%>>待处理</option>
	<option value="1" <%if("1".equals(clstatus))out.println("selected");%>>已完成</option>	
</select>
<!--    功能按钮结束    -->
<%@include file="/system/app/skin/skin4/template/list_listtop.jsp"%>                                                                                        
<!--    列表开始    -->
<table class="FindAreaTable1" cellspacing="1" rules="cols" border="0" id="ctl00_DataGrid_DataGrid1" style="border-width:0px;">
	<form name="formData">
	</tr>
	<tr class="bttn">
	<td width="25%" class="outset-table" align="center">申请序列号</td>
	<td width="15%" class="outset-table" align="center">申请人姓名</td>
	<td width="20%" class="outset-table" align="center">申请时间</td>
	<td width="25%" class="outset-table" align="center">回复方式</td>
	<td width="10%" class="outset-table" align="center">申请状态</td>
	<td width="5%" class="outset-table" align="center">操作</td>
	</tr>
	<%
	Vector vectorList = dImpl.splitPage(sql_list,request,20);
	Hashtable content = null;
	if(vectorList!=null)
	{
		for(int i=0;i<vectorList.size();i++)
		{
			content = (Hashtable)vectorList.get(i);
			dx_id = CTools.dealNull(content.get("dx_id"));
			dx_num = CTools.dealNull(content.get("dx_num"));
			dx_name = CTools.dealNull(content.get("dx_name"));
			dx_applytime = CTools.dealNull(content.get("dx_applytime"));
			dx_backtype = CTools.dealNull(content.get("dx_backtype"));
			dx_status = CTools.dealNull(content.get("dx_status"));
			if("0".equals(dx_status)){
				dx_status = "待处理";
			}else{
				dx_status = "已完成";	
			}
			
			int dx_back = Integer.parseInt(dx_backtype);
			switch (dx_back){
				case 1: dx_backtype="电话回复"; break;
				case 2: dx_backtype="电子邮件回复"; break;
				case 3: dx_backtype="信件回复";
			}
			
			
			if(i % 2 == 0)  out.print("<tr class=\"line-even\">");
			else out.print("<tr class=\"line-odd\">");
	%>
	<td align="center"><%=dx_num%></td>
	<td align="center"><%=dx_name%></td>
	<td align="center"><%=dx_applytime%></td>
	<td align="center"><%=dx_backtype%></td>
	<td align="center"><%=dx_status%></td>
	<td align="center"><a href="onlineInfo.jsp?dx_id=<%=dx_id%>"><img class="hand" border="0" src="../../images/modi.gif" title="操作" WIDTH="16" HEIGHT="16"></a></td>
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