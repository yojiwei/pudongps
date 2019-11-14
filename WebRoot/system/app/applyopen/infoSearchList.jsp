<%@page contentType="text/html; charset=GBK"%>
<%@include file="/system/app/skin/head.jsp"%>
<%
String strTitle = "申请信息查询结果";
CDataCn dCn = null;
CDataImpl dImpl = null;
try{
dCn = new CDataCn();
dImpl = new CDataImpl(dCn);
//
String in_title = "";
String in_id = "";
String search = CTools.dealString(request.getParameter("search")).trim();
String swhere = "";
if ("".equals(search)) {
  swhere = "";
}
else {
	swhere =  "and c.ct_title like '%" + search + "%'";
}
String sql = "select distinct c.ct_id,c.ct_title from tb_content c,tb_contentpublish p where p.cp_ispublish = '1' and p.ct_id=c.ct_id and c.in_category = '2'" + swhere;
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
	<%
	Vector vectorPage = dImpl.splitPage(sql,request,20);
	if(vectorPage != null)
	{
	%>
		<tr>
		<td>
       <table width="100%" class="content-table">
<%
	for(int i=0;i<vectorPage.size();i++)
	{
		Hashtable content = (Hashtable)vectorPage.get(i);
		in_title = content.get("ct_title").toString();
		in_id = content.get("ct_id").toString();
		%>
        <tr class="<% if(i%2==0) out.println("line-even"); else out.println("line-odd");%>">
          <td width="80%" onclick="fnsubmit(<%=in_id%>)" style="cursor=hand"><%=in_title%></td>
          <td align="center"><a href="javascript:fnsubmit(<%=in_id%>)">申请该事项</a></td>
        </tr>     
 
		<%
	}
%>
      </table>
		</td>
	</tr>
<%
}
else
{
%>
	<tr align="center" class="line-even">
		<td>没有您要检索的信息！</td>
	</tr>
<%
}
%>
  <tr class="outset-table" align="center">
		<td>
			<input type="reset" class="bttn" name="freset" value="返回查询页面" onclick="javascript:window.close();">&nbsp;
			<input type="button" class="bttn" name="back" value="继续申请" onclick="javascript:window.opener.location.href='applyInfo.jsp?keyword=<%=search%>';window.close();">
		</td>
	</tr>
</table>
<script language="javascript">
function fnsubmit(id){
	window.opener.location.href = "applyInfo.jsp?ct_id="+id;
	window.close();
}
</script>
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