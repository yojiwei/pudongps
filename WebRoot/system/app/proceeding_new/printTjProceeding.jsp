<%@page contentType="text/html; charset=GBK"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title>上海浦东门户网站后台管理系统</title>
<script LANGUAGE="javascript" src="/system/app/infopublish/common/common.js"></script>
</head>
<body leftmargin="0" topmargin="0">
<%
  String strMenu2=CTools.dealString(request.getParameter("Menu"));
  String strModule2=CTools.dealString(request.getParameter("Module"));
  if(!strMenu2.equals("")) session.setAttribute("_strMenu2",strMenu2);
  if(!strModule2.equals("")) session.setAttribute("_strModule2",strModule2);
  strMenu2=CTools.dealNull(session.getAttribute("_strMenu2"));
  strModule2=CTools.dealNull(session.getAttribute("_strModule2"));
%>
<%@include file="/system/app/skin/import.jsp"%>
<%@include file="/system/app/islogin.jsp"%>
<script language="javascript">
function banshi(){
	location.href="TjPorceeding.jsp?order=1";
}
function fmprint()
{
	window.print();
	window.close();
}
</script>
<%
String strTitle = "新事项统计";
String sqlDept="";
String sqlPro = "";
String sqlProTable = "";
String dt_id = "";
String times = "";
String dt_name="";
String coun="";
String counpr="";
int countprs = 0;
int counpas = 0;
int countprc = 0;
String counpa="";
String pr_count = "";
int num = 0;
String order = "";
//
CDataCn dCn = null;
CDataImpl dImpl = null;
Hashtable contentPro = null;
Hashtable contentProTa  = null;
Hashtable content = null;
Vector vPage = null;
try{
dCn = new CDataCn();
dImpl = new CDataImpl(dCn);
//
order  = CTools.dealString(request.getParameter("order"));
%>                                              
<!--    列表开始    -->
<table border="1" cellspacing="0" bordercolor="#333333">
  <tr>
	  <td colspan="5" align="right"><a href="#" onClick="fmprint()">打印</a>&nbsp;</td>
	  <td width="21%">&nbsp;</td>
  </tr>
	<tr>
	  <td width="8%">序号</td>
	  <td width="26%">部门</td>
	  <td width="17%">办事规程▲</td><!--↑--->
	  <td width="14%">表格下载▲</td>
	  <td width="14%">浏览数▲</td>
	  <td width="21%">最后维护日期▲</td>
  </tr>
<%
sqlDept = "select d.dt_name,d.dt_id from tb_deptinfo d where d.dt_id in (select dt_id from tb_proceeding_new p) and d.dt_iswork = 1";//

vPage = dImpl.splitPage(sqlDept,200,1);
if(vPage!=null)	{
	for(int j=0;j<vPage.size();j++){
		content = (Hashtable)vPage.get(j);
		dt_id = content.get("dt_id").toString();
		dt_name = content.get("dt_name").toString();

sqlPro = "select count(pr_id) as cunpr,max(pr_edittime) as times,sum(pr_count) as pr_count from tb_proceeding_new where dt_id ="+dt_id+"";

contentPro = dImpl.getDataInfo(sqlPro);
if(contentPro!=null){
	counpr = contentPro.get("cunpr").toString();
	times = CTools.getDate(contentPro.get("times").toString());
	pr_count = CTools.dealNumber(contentPro.get("pr_count"));
	
}else{
	counpr = "0";
}

sqlProTable = "select count(pa_id) as cunpa from tb_proceedingattach_new p where pr_id in (select n.pr_id from tb_proceeding_new n where n.dt_id ="+dt_id+")";

contentProTa = dImpl.getDataInfo(sqlProTable);
if(contentProTa!=null){
	counpa = contentProTa.get("cunpa").toString();
}else{
	counpa = "0";
}
%>
	<tr>
		<td><%=j+1%></td>
		<td><%=dt_name%></td>
		<td><%=counpr%></td>
		<td><%=counpa%></td>
		<td><%=pr_count%></td>
		<td><%=times%></td>
	</tr>
<%
		countprs+=Integer.parseInt(counpr);
		counpas+=Integer.parseInt(counpa);
		countprc+=Integer.parseInt(pr_count);
	}
}
%>
	<tr>
	  <td colspan="2" align="right">总&nbsp;计&nbsp;</td>
	  <td><%=countprs%></td>
	  <td><%=counpas%></td>
	  <td><%=countprc%></td>
	  <td>&nbsp;</td>
    </tr>
</table>
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
</body>
</html>
