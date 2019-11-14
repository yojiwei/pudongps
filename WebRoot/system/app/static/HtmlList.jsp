<%@page contentType="text/html; charset=GBK"%>
<%@include file="/system/app/skin/head.jsp"%>
<%
CDataCn dCn = null;
CDataImpl dImpl = null;
try{
dCn = new CDataCn();
dImpl = new CDataImpl(dCn);

com.app.CMySelf ms = new com.app.CMySelf();
ms = (com.app.CMySelf)session.getAttribute("mySelf");

long myId = ms.getMyID();
String userId = ms.getMyUid();

String sEditUrl = "";
String sNewEditUrl = "";
String sqlStr = "";
if (userId.equals("administrator")) 
	sqlStr = "select fi_id as id ,fi_title as name from tb_frontinfo where fs_id=(select fs_id from " + 
			 "tb_frontsubject where fs_code='staticpage') order by fi_sequence,fi_id";
else
	sqlStr = "select fi_id as id ,fi_title as name from tb_frontinfo where fs_id=(select fs_id from " + 
			 "tb_frontsubject where fs_code='staticpage') and ur_id like '%" + myId + "%' order by fi_sequence,fi_id";


%>
<%@include file="/system/app/skin/skin4/template/list_top.jsp"%>
<!--    模块名称开始    -->
静态生成
<!--    模块名称结束    -->
<%@include file="/system/app/skin/skin4/template/list_function.jsp"%>                                                            
<!--    功能按钮开始    -->
  
<!--    功能按钮结束    -->
<%@include file="/system/app/skin/skin4/template/list_listtop.jsp"%>                                                                                        
<!--    列表开始    -->
<table class="FindAreaTable1" cellspacing="1" rules="cols" border="0" id="ctl00_DataGrid_DataGrid1" style="border-width:0px;">
  <tr class="bttn" width="100%">
    <td align="center" width="10%">序号</td>
	<td align="center" width="60%">名称</td>
	<td align="center" width="15%">生成</td>
  </tr>
<%
Vector vPage = dImpl.splitPage(sqlStr,request,20);
if (vPage != null)
{
  for(int j=0;j<vPage.size();j++)
  {
   Hashtable content = (Hashtable)vPage.get(j);
   if(j % 2 == 0)  out.print("<tr class=\"line-even\">");
   else out.print("<tr class=\"line-odd\">");
   sEditUrl="<a href='createSucess.jsp?fi_id=" + content.get("id").toString() + "'><img src='/system/images/dialog/icon3.gif' border='0' height=16 width=16 title='生成静态页面'></a>";
 %>
  <td align="center"><%=j+1%></td>
  <td align="center"><%=content.get("name").toString()%></td>
  <td align="center"><%=sEditUrl%></td>
 </tr>
<%
  }
}
else
{
out.println("<tr><td colspan=20 align='right'>没有记录！</td></tr>"); //输出尾部文件
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