<%@page contentType="text/html; charset=GBK"%>
<%@include file="/system/app/skin/head.jsp"%>
<%
String sqlStr = "select wk_id,wk_name,wk_parameter,wk_isdefault from tb_workkind order by wk_id";
String wk_id = "";
String wk_name = "";
String wk_parameter = "";
String wk_isdefault = "";
String strTitle = "主页网上办事类型列表";

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
<table class="FindAreaTable1" cellspacing="1" rules="cols" border="0" id="ctl00_DataGrid_DataGrid1" style="border-width:0px;">
<form name="formData" method="postx">
  <tr class="bttn" width="100%">
    <td align="center" width="20%">ID</td>
    <td align="center" width="20%">办事类别</td>
    <td align="center" width="20%">传递参数</td>
    <td align="center" width="10%">默认显示</td>
  </tr>
<%
Vector vPage = dImpl.splitPage(sqlStr,request,20);
if (vPage != null)
{
  for(int j=0;j<vPage.size();j++)
  {
   Hashtable content = (Hashtable)vPage.get(j);
   wk_id = content.get("wk_id").toString();
   wk_name = content.get("wk_name").toString();
   wk_parameter = content.get("wk_parameter").toString();
   wk_isdefault = content.get("wk_isdefault").toString();

   if(j % 2 == 0)  out.print("<tr class=\"line-even\">");
   else out.print("<tr class=\"line-odd\">");
 %>
  <td align="center"><%=wk_id%></td>
  <td align="center"><a href="WorkKindInfo.jsp?wk_id=<%=wk_id%>"><%=wk_name%></a></td>
  <td align="center"><%=wk_parameter%></td>
  <td align="center"><input type="radio" name="wk_isdefault" <%if(wk_isdefault.equals("1")) {out.print("checked");}%> onclick="kindcheck('<%=wk_id%>')"></td>
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
<script language="javascript">
  function  kindcheck(wk_id)
  {
	window.location="WorkKindCheck.jsp?wk_id="+wk_id;
  }
</script>
<%@include file="/system/app/skin/bottom.jsp"%>