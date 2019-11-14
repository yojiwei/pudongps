<%@page contentType="text/html; charset=GBK"%>
<%@include file="/system/app/skin/head.jsp"%>
<%
CMySelf self = (CMySelf)session.getAttribute("mySelf");
String selfdtid = String.valueOf(self.getDtId());
String sender_id = String.valueOf(self.getMyID());

String sqlStr = "select c.cp_id,c.cp_name,c.dt_name from tb_connproc c,tb_deptinfo d where c.dt_id=d.dt_id and c.cp_upid='o10000' or c.cp_id='o10000' and d.dt_id=" + selfdtid + "order by cp_id";
String cp_id = "";
String cp_name = "";
String dt_name = "";
String strTitle = "街道(乡、镇)领导信箱列表";

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
<img src="../../../images/new.gif" border="0" onclick="window.location='ProceedingInfo.jsp?cp_id=<%=cp_id%>&dt_name=<%=dt_name%>'" title="新增街道(乡、镇)领导信箱" style="cursor:hand" align="absmiddle" WIDTH="16" HEIGHT="16">
新增街道(乡、镇)领导信箱
<img src="../../../images/goback.gif" border="0" onclick="javascript:history.back();" title="返回" style="cursor:hand" align="absmiddle">
返回
<!--    功能按钮结束    -->
<%@include file="/system/app/skin/skin4/template/list_listtop.jsp"%>                                                                                        
<!--    列表开始    -->
<table class="FindAreaTable1" cellspacing="1" rules="cols" border="0" id="ctl00_DataGrid_DataGrid1" style="border-width:0px;">
<form name="formData">
  <tr class="bttn" width="100%">
    <td align="center" width="20%">街道(乡、镇)领导信箱ID</td>
    <td align="center" width="30%">街道(乡、镇)领导信箱名称</td>
    <td align="center" width="30%">街道(乡、镇)领导信箱单位</td>
    <td align="center" width="10%">编辑</td>
  </tr>
<%
Vector vPage = dImpl.splitPage(sqlStr,request,20);
if (vPage != null)
{
  for(int j=0;j<vPage.size();j++)
  {
   Hashtable content = (Hashtable)vPage.get(j);
   cp_id = content.get("cp_id").toString();
   cp_name = content.get("cp_name").toString();
   dt_name = content.get("dt_name").toString();
   if(j % 2 == 0)  out.print("<tr class=\"line-even\">");
   else out.print("<tr class=\"line-odd\">");
 %>
  <td align="center"><%=cp_id%></td>
  <td align="center"><%=cp_name%></td>
  <td align="center"><%=dt_name%></td>
  <td align="center"><a href="ProceedingInfo.jsp?cp_id=<%=cp_id%>&dt_name=<%=dt_name%>"><img class="hand" border="0" src="../../../images/modi.gif" title="编辑" WIDTH="16" HEIGHT="16"></a></td>
 </tr>
<%
  }
%>
</form>
<%
}
%>
</table>
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