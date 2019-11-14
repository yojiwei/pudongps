<%@page contentType="text/html; charset=GBK"%>
<%@include file="/system/app/skin/head.jsp"%>
<%
CDataCn dCn = null;
CDataImpl dImpl = null;
try{
dCn = new CDataCn();
dImpl = new CDataImpl(dCn);
//
String strTitle="诚信企业列表";
String sql="";
String audit = CTools.dealString(request.getParameter("audit"));
String optype = CTools.dealString(request.getParameter("OPType"));

String et_kind = CTools.dealString(request.getParameter("et_kind"));						//类型
String et_name = CTools.dealString(request.getParameter("et_name"));						//企业名称
String et_address = CTools.dealString(request.getParameter("et_address"));					//企业地址
String et_corporation = CTools.dealString(request.getParameter("et_corporation"));			//法人代表
String sWhere = "";

if (!"".equals(et_kind)) {
	sWhere += " and et_kind = '"+ et_kind +"'";
}
if (!"".equals(et_name)) {
	sWhere += " and et_name = '%"+ et_name +"%'";
}
if (!"".equals(et_address)) {
	sWhere += " and et_address = '%"+ et_address +"%'";
}
if (!"".equals(et_corporation)) {
	sWhere += " and et_corporation = '%"+ et_corporation +"%'";
}

String sub_us_id="subString(tb_user.us_id,1,tb_user.us_id.length-1)";
sql = "select et_name,et_id,et_address,et_corporation from tb_creditenterprise where 1=1 ";

sql += sWhere + " order by et_name";

%>
<%@include file="/system/app/skin/skin4/template/list_top.jsp"%>
<!--    模块名称开始    -->
<%=strTitle%>
<!--    模块名称结束    -->
<%@include file="/system/app/skin/skin4/template/list_function.jsp"%>                                                            
<!--    功能按钮开始    -->
 <img src="/system/images/new.gif" border="0" onclick="window.location='EnterpriseInfo.jsp?OPType=Add'" title="新增用户" style="cursor:hand" align="absmiddle" WIDTH="16" HEIGHT="16">
新增用户
<img src="/system/images/menu_about.gif" border="0" onclick="javascript:window.location.href='EnterpriseSearch.jsp' " title="查找" style="cursor:hand" align="absmiddle">
查找
<img src="/system/images/goback.gif" border="0" onclick="javascript:history.back();" title="返回" style="cursor:hand" align="absmiddle">
返回
<!--    功能按钮结束    -->
<%@include file="/system/app/skin/skin4/template/list_listtop.jsp"%>                                                                                        
<!--    列表开始    -->
<table class="FindAreaTable1" cellspacing="1" rules="cols" border="0" id="ctl00_DataGrid_DataGrid1" style="border-width:0px;">
<form name="formData">
<INPUT TYPE="hidden" name="audit" value="<%=audit%>">
<tr class="bttn">
  <td width="8%" class="outset-table" align="center">企业名称</td>
  <td width="5%" class="outset-table" align="center">法人代表</td>
  <td width="10%" class="outset-table" align="center">企业地址</td>
  <td width="10%" class="outset-table" align="center">操作</td>
</tr>
<%
Vector vectorPage = dImpl.splitPage(sql,request,20);
  if(vectorPage!=null)
  {
    for(int j=0;j<vectorPage.size();j++)
    {
      Hashtable content = (Hashtable)vectorPage.get(j);
      if(j % 2 == 0)  out.print("<tr class=\"line-even\">");
      else out.print("<tr class=\"line-odd\">");
%>
        <td align="center"><%=content.get("et_name")%></td>
        <td align="center"><%=content.get("et_corporation")%></td>
        <td align="center"><%=content.get("et_address")%></td>
        <td align="center">             	
        <a href="EnterpriseInfo.jsp?OPType=Edit&et_id=<%=content.get("et_id")%>">
				<img class="hand" border="0" src="../../images/modi.gif" title="编辑" WIDTH="16" HEIGHT="16"></a>&nbsp;		
        <a href="EnterpriseDel.jsp?OPType=del&et_id=<%=content.get("et_id")%>"><img class="hand" border="0" src="../../images/delete.gif" title="删除" WIDTH="16" HEIGHT="16" onclick="return window.confirm('确认要删除该记录么?');"></a>
        </td>
    </tr>
</form>
<%
    }
  }
  else
  {
    out.println("<tr><td colspan=10>没有记录！</td></tr>");
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