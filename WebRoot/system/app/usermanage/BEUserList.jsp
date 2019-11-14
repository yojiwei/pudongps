<%@page contentType="text/html; charset=GBK"%>
<%@include file="/system/app/skin/head.jsp"%>
<%
CDataCn dCn = null;
CDataImpl dImpl = null;
try{
dCn = new CDataCn();
dImpl = new CDataImpl(dCn);
//
String strTitle="";
String sql="";
String us_uid = "";
String audit = CTools.dealString(request.getParameter("audit"));
String optype = CTools.dealString(request.getParameter("OPType"));

if(optype.equals("Search")){
us_uid =CTools.dealString(request.getParameter("us_uid"));
String ec_name=CTools.dealString(request.getParameter("ec_name"));
String ec_enroladd=CTools.dealString(request.getParameter("ec_enroladd"));
String ec_email=CTools.dealString(request.getParameter("ec_email"));
sql = "select u.us_id,u.us_uid,u.us_istemp,e.ec_name,e.ec_email,e.ec_enroladd,ec_corporation,e.ec_fax from tb_user u, tb_enterpvisc e where u.us_id =e.us_id  and u.uk_id= 'o2'";
strTitle = "企业用户查询列表";
if(!us_uid.equals("")){
	sql = sql+ " and u.us_uid = '"+us_uid+"'";
}

if(!ec_name.equals("")){
	sql = sql+ " and e.ec_name like '%"+ec_name+"%'";
}

if(!ec_enroladd.equals("")){
	sql = sql+ " and e.ec_enroladd = '"+ec_enroladd+"'";
}

if(!ec_email.equals("")){
	sql = sql+ " and e.ec_email = '"+ec_email+"'";
}
sql = sql + " order by to_number(substr(u.us_id,2,length(u.us_id))) desc";
}else{
	strTitle = "企业用户管理列表";
	sql = "select u.us_id,u.us_uid,u.us_istemp,e.ec_name,e.ec_email,e.ec_enroladd,ec_corporation,e.ec_fax from tb_user u, tb_enterpvisc e where u.us_id =e.us_id  and u.uk_id= 'o2' order by to_number(substr(u.us_id,2,length(u.us_id))) desc";
}
if(optype.equals("Audit")){
strTitle = "企业用户审核列表";
}
%>
<%@include file="/system/app/skin/skin4/template/list_top.jsp"%>
<!--    模块名称开始    -->
<%=strTitle%>
<!--    模块名称结束    -->
<%@include file="/system/app/skin/skin4/template/list_function.jsp"%>                                                            
<!--    功能按钮开始    -->
<img src="/system/images/new.gif" border="0" onclick="window.location='BEUserInfo.jsp?OPType=Add'" title="新增企业用户" style="cursor:hand" align="absmiddle" WIDTH="16" HEIGHT="16">
新增企业用户
<img src="/system/images/menu_about.gif" border="0" onclick="javascript:window.location.href='BEUserSearch.jsp' " title="查找" style="cursor:hand" align="absmiddle">
查找
<img src="/system/images/goback.gif" border="0" onclick="javascript:history.back();" title="返回" style="cursor:hand" align="absmiddle">
返回   
<!--    功能按钮结束    -->
<%@include file="/system/app/skin/skin4/template/list_listtop.jsp"%>                                                                                        
<!--    列表开始    -->
<table class="FindAreaTable1" cellspacing="1" rules="cols" border="0" id="ctl00_DataGrid_DataGrid1" style="border-width:0px;">
        <form name="formData">
        <tr class="bttn">  
            <td width="5%" class="outset-table" align="center">用户名</td>
            <td width="10%" class="outset-table" align="center">单位名称</td>
            <td width="10%" class="outset-table" align="center">法人代表</td>
            <td width="10%" class="outset-table" align="center">注册地址</td>
            <td width="20%" class="outset-table" align="center">email</td>
            <td width="10%" class="outset-table" align="center">用户传真</td>
            <td width="10%" class="outset-table" align="center">审核状态</td>
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
                <td align="center"><%=content.get("us_uid")%></td>
                <td align="center"><%=content.get("ec_name")%></td>
                <td align="center"><%=content.get("ec_corporation")%></td>
                <td align="center"><%=content.get("ec_enroladd")%></td>
                <td align="center"><%=content.get("ec_email")%></td>
                <td align="center"><%=content.get("ec_fax")%></td>
                <td align="center">				
				<%
				if(content.get("us_istemp").equals("0"))

				out.print("否");

				else if(content.get("us_istemp").equals("1"))
					out.print("是");
				%></td>
				</td>
                <td align="center">
                <%
		if(optype.equals("Audit")){
		%>
		<a href="BEUserInfo.jsp?OPType=Audit&us_id=<%=content.get("us_id")%>">
		<img class="hand" border="0" src="../../images/dialog/hammer.gif" title="审核" WIDTH="16" HEIGHT="16"></a>&nbsp;
		<%
		}
		else
		{
		%>
                <a href="BEUserInfo.jsp?OPType=Edit&us_id=<%=content.get("us_id")%>">
		<img class="hand" border="0" src="../../images/modi.gif" title="编辑" WIDTH="16" HEIGHT="16"></a>&nbsp;
		<%}%>
                <a href="BEUserDel.jsp?OPType=del&us_id=<%=content.get("us_id")%>"><img class="hand" border="0" src="../../images/delete.gif" title="删除" WIDTH="16" HEIGHT="16" onclick="return window.confirm('确认要删除该记录么?');"></a>
                </td>
            </tr>
</form>
<%
    }
  }
  else
  {
    out.println("<tr><td colspan=20>没有记录！</td></tr>");
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