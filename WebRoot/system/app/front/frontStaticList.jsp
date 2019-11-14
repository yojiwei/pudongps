<%@page contentType="text/html; charset=GBK"%>
<%@include file="/system/app/skin/head.jsp"%>
<script language="javascript">
function query(list_id,node_title)
{
	var form = document.formData ;
	form.list_id.value = list_id ;
	form.submit();
}
function setSequence(list_id)
{
	var form = document.formData ;
	form.list_id.value = list_id ;
	form.action = "setSequence.jsp" ;
	form.submit();
}
</script>
<%
CMySelf self = (CMySelf)session.getAttribute("mySelf");

String selfdtid = String.valueOf(self.getDtId());
String sender_id = String.valueOf(self.getMyID());

String seName = "";
String sImg = "";
String sUrl = "";
String sEditUrl = "";
String sequence = "";

String list_id = CTools.dealString(request.getParameter("list_id")).trim();
if(list_id.equals("")) list_id = "o0";
String sqlStr = "select fs_id as id,fs_name as name,1 as flag,fs_sequence as sequence from tb_frontsubject where fs_parentid='"+list_id+"' union select fi_id as id ,fi_title as name,2 as flag,fi_sequence as sequence from tb_frontinfo where fs_id='"+list_id+"' order by flag,sequence";

CDataCn dCn = null;
CDataImpl dImpl = null;
try{
dCn = new CDataCn();
dImpl = new CDataImpl(dCn);
%>
<%@include file="/system/app/skin/skin4/template/list_top.jsp"%>
<!--    模块名称开始    -->
静态维护
<!--    模块名称结束    -->
<%@include file="/system/app/skin/skin4/template/list_function.jsp"%>                                                            
<!--    功能按钮开始    -->
<img src="/system/images/new.gif" border="0" onclick="window.location='staticInfo.jsp?list_id=<%=list_id%>'" title="增加信息" style="cursor:hand" align="absmiddle" WIDTH="16" HEIGHT="16">
增加信息
<img src="/system/images/dialog/sort.gif" border="0" onclick="setSequence('<%=list_id%>')" title="修改排序" style="cursor:hand" align="absmiddle" id="image2" name="image2" WIDTH="16" HEIGHT="16">
修改排序
<img src="/system/images/goback.gif" border="0" onclick="javascript:history.back();" title="返回" style="cursor:hand" align="absmiddle">
返回
<!--    功能按钮结束    -->
<%@include file="/system/app/skin/skin4/template/list_listtop.jsp"%>                                                                                        
<!--    列表开始    -->
<table class="FindAreaTable1" cellspacing="1" rules="cols" border="0" id="ctl00_DataGrid_DataGrid1" style="border-width:0px;">
<form name="formData" method="post" action="frontSubjectList.jsp">
  <tr class="bttn" width="100%">
    <td align="center" width="10%">序号</td>
    <td align="center" width="10%">类型</td>
	<td align="center" width="60%">名称</td>
    <td align="center" width="10%">编辑</td>
	<td align="center" width="10%">排序</td>
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
   sequence = content.get("sequence").toString();
 
   seName   = "info" + content.get("id").toString() ;
   sImg     = "<img border=0 src='/system/images/dialog/document.gif'>";
   sUrl="staticInfo.jsp?fi_id=" + content.get("id").toString() + "&list_id="+list_id;
   sEditUrl="<a href='" + sUrl + "'><img src='/system/images/dialog/icon3.gif' border='0' height=16 width=16 title='修改'></a>";
      
 %>
  <td align="center"><%=j+1%></td>
  <td align="center"><%=sImg%></td>
  <td align="center"><a href="<%=sUrl%>"><%=content.get("name").toString()%></a></td>
  <td align="center"><%=sEditUrl%></td>
  <td align="center"><input class="text-line" name="<%=seName%>" size="5" value="<%=sequence%>"></td>
 </tr>
<%
  }
%>         
<input type="hidden" name="list_id" value="<%=list_id%>">
</form>
<%
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