<%@page contentType="text/html; charset=GBK"%>
<%@include file="/system/app/skin/head.jsp"%>
<script LANGUAGE="javascript" src="/system/common/treeview/chooseTreeJs.jsp"></script>
<script language="javascript">
function doCheck(){
	var formdata = document.formData1;
	if(formdata.EC_NAME.value==""){
		alert("查询条件不能为空！");
		return false;
	}else{
		return true;
	}
}
</script>
<%
String strTitle = "企业信息列表";
String subjectCode="";//获得栏目代码
String ec_name = "",us_name="",ec_produceadd="",ec_corporation="",ec_tel="",ec_enroladd="",ec_id="";
String sqlStr="",strat_time="",end_time="",addSql="";
subjectCode=CTools.dealString(request.getParameter("subjectCode")).trim();
ec_name=CTools.dealString(request.getParameter("ec_name")).trim();
ec_corporation=CTools.dealString(request.getParameter("ec_corporation")).trim();
strat_time = CTools.dealString(request.getParameter("strat_time")).trim();
end_time = CTools.dealString(request.getParameter("end_time")).trim();

CDataCn dCn=null;   //新建数据库连接对象
CDataImpl dImpl=null;  //新建数据接口对象
Vector vPage = null;
Hashtable content = null;

try {
dCn = new CDataCn(); 
dImpl = new CDataImpl(dCn); 
CMySelf myProject = (CMySelf)session.getAttribute("mySelf");
if(!"".equals(ec_name)){
	addSql+=" and ec_name like '%"+ec_name+"%'";
}else if(!"".equals(ec_corporation)){
	addSql+=" and ec_corporation like '%"+ec_corporation+"%'";
}else if(!"".equals(strat_time)&&!"".equals(end_time)){
	addSql+=" and to_date(to_char(ec_time, 'yyyy-MM-dd'), 'yyyy-MM-dd') between to_date('"+strat_time+"','yyyy-MM-dd') and to_date('"+end_time+"','yyyy-MM-dd')";
}

sqlStr="select e.ec_id,e.ec_name,u.us_name,e.ec_produceadd,e.ec_corporation,e.ec_tel,e.ec_enroladd from TB_ENTERPVISC e,tb_user u where e.us_id = u.us_id "+addSql;
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
<table class="FindAreaTable1" cellspacing="1" rules="cols" border="0" id="ctl00_DataGrid_DataGrid1" style="border-width:0px;">
	<tr class="line-even">
	  <td width="14%" align="center">企业名称</td>
		<td width="13%" height="23" align="center">注册名</td>
		<td width="16%" align="center">注册地址</td>
		<td width="15%" align="center">法人代表</td>
		<td width="15%" align="center">&nbsp;电话</td>
		<td width="13%" align="center">通讯地址</td>
	  <td width="14%" align="center">操作</td>
	</tr>
	<%
	vPage = dImpl.splitPage(sqlStr,request,15);
	if(vPage!=null){
	for(int i=0;i<vPage.size();i++){
		content = (Hashtable)vPage.get(i);
		ec_id = content.get("ec_id").toString();
		ec_name = content.get("ec_name").toString();
		us_name = content.get("us_name").toString();
		ec_produceadd = content.get("ec_produceadd").toString();
		ec_corporation = content.get("ec_corporation").toString();
		ec_tel = content.get("ec_tel").toString();
		ec_enroladd = content.get("ec_enroladd").toString();
	%>
	<tr class=<%=(i%2==0)?"line-even":"line-odd"%>>
	  <td align="center"><%=ec_name%></td>
		<td height="21" align="center"><%=us_name%></td>
		<td align="center"><%=ec_produceadd%></td>
		<td align="center"><%=ec_corporation%></td>
		<td align="center"><%=ec_tel%></td>
		<td align="center"><%=ec_enroladd%></td>
		<td align="center"><a href="EnterpriseDetail.jsp?ec_id=<%=ec_id%>">查看</a></td>
	</tr>
	<%
	}
	%>	
	<%
	}else{
	%>
	<tr>
	  <td height="21" colspan="7" align="center">没有相关信息!</td>
	</tr>
	<%}%>
</table>
<!--    列表结束    -->
<%@include file="/system/app/skin/skin4/template/list_bottom.jsp"%> 
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