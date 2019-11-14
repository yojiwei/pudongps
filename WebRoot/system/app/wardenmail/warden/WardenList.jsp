<%@page contentType="text/html; charset=GBK"%>
<%@include file="/system/app/skin/head.jsp"%>
<%
CMySelf self = (CMySelf)session.getAttribute("mySelf");
String selfdtid = String.valueOf(self.getDtId());
String sender_id = String.valueOf(self.getMyID());

String sqlStr = "select wd_id,wd_name,wd_sequence from tb_warden order by wd_sequence";
String wd_id = "";
String wd_name = "";
String strTitle = "区长列表";
//update20080122

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
<img src="/system/images/new.gif" border="0" onclick="window.location='WardenInfo.jsp?wd_id=<%=wd_id%>'" title="增加区长" style="cursor:hand" align="absmiddle" WIDTH="16" HEIGHT="16">
新增
<img src="/system/images/sort.gif" title="修改排序" border="0" style="cursor:hand" onclick="javascript:setSequence();" width="16",height="16" align="absmiddle">
修改
<img src="/system/images/goback.gif" border="0" onclick="javascript:history.back();" title="返回" style="cursor:hand" align="absmiddle">
返回
<!--    功能按钮结束    -->
<%@include file="/system/app/skin/skin4/template/list_listtop.jsp"%>                                                                                        
<!--    列表开始    -->
<table class="FindAreaTable1" cellspacing="1" rules="cols" border="0" id="ctl00_DataGrid_DataGrid1" style="border-width:0px;">
<form name="formData" method="postx">
  <tr class="bttn" width="100%">
    <td align="center" width="20%">区长ID</td>
    <td align="center" width="30%">区长姓名</td>
    <td align="center" width="10%">排序</td>
    <td align="center" width="10%">编辑</td>
  </tr>
<%
Vector vPage = dImpl.splitPage(sqlStr,request,20);
if (vPage != null)
{
  for(int j=0;j<vPage.size();j++)
  {
   Hashtable content = (Hashtable)vPage.get(j);
   wd_id = content.get("wd_id").toString();
   wd_name = content.get("wd_name").toString();
   if(j % 2 == 0)  out.print("<tr class=\"line-even\">");
   else out.print("<tr class=\"line-odd\">");
 %>
  <td align="center"><%=wd_id%></td>
  <td align="center"><%=wd_name%></td>
  <td align="center"><input class="text-line" name="<%="module" + content.get("wd_id").toString()%>" size="5" value="<%=content.get("wd_sequence").toString()%>"></td>
  <td align="center"><a href="WardenInfo.jsp?wd_id=<%=wd_id%>"><img class="hand" border="0" src="../../../images/modi.gif" title="编辑" WIDTH="16" HEIGHT="16"></a></td>
 </tr>
<%
  }
%>
</form>
<%
}
%>
</table>
<SCRIPT LANGUAGE="JavaScript">
function setSequence()
{
        var form = document.formData ;
        form.action = "setSequence.jsp";
        form.submit();
}
</SCRIPT>
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