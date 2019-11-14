<%@page contentType="text/html; charset=GBK"%>
<%@include file="/system/app/skin/head.jsp"%>
<%
CDataCn dCn = null;
CDataImpl dImpl = null;
try{
dCn = new CDataCn();
dImpl = new CDataImpl(dCn);
//
String strTitle ="";
String cp = CTools.dealString(request.getParameter("cp"));
String strDt = "";
String sqlStr_dt = "";

int j = 0;//区分互动事项类型
j = Integer.parseInt(cp);
switch(j)
{
	case 1:
         sqlStr_dt = "select a.dt_name,b.dt_id,b.cp_name,b.cp_upid from tb_deptinfo a ,tb_connproc b where a.dt_id=b.dt_id and b.cp_id in('o1','o2','o3') order by dt_name desc";
         break;
    case 2:
         sqlStr_dt = "select a.dt_name,b.dt_id,b.cp_name,b.cp_upid from tb_deptinfo a ,tb_connproc b where a.dt_id=b.dt_id and b.cp_upid='o6' order by dt_name desc";
         break;
    case 3:
         sqlStr_dt = "select a.dt_name,b.dt_id,b.cp_name,b.cp_upid from tb_deptinfo a ,tb_connproc b where a.dt_id=b.dt_id and (b.cp_id in('o4','o5','o8','o9','o10')) order by dt_name desc";  
	 			 strTitle="投诉信箱汇总统计表";
         break;
	//网上咨询
    case 4:
		    sqlStr_dt = "select a.dt_name,b.dt_id,b.cp_name,b.cp_upid from tb_deptinfo a ,tb_connproc b where a.dt_id=b.dt_id and b.cp_upid='o7' order by dt_name desc"; 
			  strTitle="咨询信箱汇总统计表";
			  break;
		case 5:
         sqlStr_dt = "select a.dt_name,b.dt_id,b.cp_name,b.cp_upid from tb_deptinfo a ,tb_connproc b where a.dt_id=b.dt_id and b.cp_upid='o10000' order by dt_name desc";  
	 			 strTitle="街道领导信箱汇总统计表";
         break;
   default:
         break;		
     
}
Vector vPage = dImpl.splitPage(sqlStr_dt,request,200);
if (vPage!=null)
{
	for (int i=0;i<vPage.size();i++)
	{
	Hashtable content = (Hashtable)vPage.get(i);
	strDt +="<option value='" + content.get("dt_id").toString() + "'>" + content.get("dt_name").toString() + "</option>";
}
}

%>
<%@include file="/system/app/skin/skin4/template/info_top.jsp"%>
<!--    模块名称开始    -->
<%=strTitle%>
<!--    模块名称结束    -->
<%@include file="/system/app/skin/skin4/template/info_funtion.jsp"%>
<!--    功能按钮开始    -->
<a href="#" onclick="fnsubmit(2);">导出Excel</a>
<!--    功能按钮结束    -->
<%@include file="/system/app/skin/skin4/template/info_main.jsp"%>
<!--    表单提交开始    -->
<table align="center" width="100%" CELLPADDING="1" cellspacing="1">
<form name="formData" method="post" action="StatConnlist.jsp">
<tr class="line-odd">
<td width="15%" align="right">申请时间</td>
<td align="left"><input name="beginTime" style="cursor:hand" class="text-line" readonly size="10" onclick="showCal()">
&nbsp;至&nbsp;<input style="cursor:hand" name="endTime" class="text-line" readonly size="10" onclick="showCal()"></td>
</tr>
<tr class="line-odd">
<td width="15%" align="right">部门名称</td>
<td align="left">
<select name="dt_id">
<option value="0">全部</option>
<%=strDt%>
</select>
</td>
</tr>
    <tr class="outset-table">
        <td align="right" width="100%" colspan="2">
            <input type="hidden" name="cp" value="<%=cp%>">
            <p align="center">
            <input type="button" class="bttn" value=" 确 定 " name="fsubmit" onclick="fnsubmit(1);">
            <input type="button" class="bttn" value=" 返 回 " name="freturn" onclick="history.go(-1);"></p>
       </td>
    </tr>
</form>
</table>

<script language="javascript">
function fnsubmit(flag)
{
	if(flag==2)
	{
		document.formData.action="StatConnlist_Excel.jsp";
	}
	else
	{
		document.formData.action="StatConnlist.jsp";
	}
	document.formData.submit();
}
</script>
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
                                     
