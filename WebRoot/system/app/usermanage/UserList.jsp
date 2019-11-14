<%@page contentType="text/html; charset=GBK"%>
<%@include file="/system/app/skin/head.jsp"%>
<%
CDataCn dCn = null;
CDataImpl dImpl = null;
Vector vectorPage = null;
try{
dCn = new CDataCn();
dImpl = new CDataImpl(dCn);
//
String strTitle="";
String sql="";
String audit = CTools.dealString(request.getParameter("audit"));
String optype = CTools.dealString(request.getParameter("OPType"));
String sub_us_id="subString(tb_user.us_id,1,tb_user.us_id.length-1)";
String us_name="";
String uk_id="";
String us_email="";
String us_tel="";
String us_address="";
String us_type = "";
String sWhere="";

String uk_name = "";
String us_uid = "";
String ws_name = "";
String us_isok = "";
String us_istemp = "";
String us_id = "";
String ws_id = "";


if(audit.equals("true"))//审核
{
  strTitle = "普通用户审核";
  sql =" select k.uk_name,u.us_email,u.us_uid,w.ws_name,u.us_name,u.us_address,u.us_tel,u.us_isok,w.ws_id,u.us_id,u.us_istemp from tb_user u,tb_userkind k,tb_website w where u.UK_ID != 'o2' and u.ws_id=w.ws_id and u.uk_id=k.uk_id and u.us_isok=0  order by to_number(substr(u.us_id,2,length(u.us_id)-1)) desc";
}
else if(optype.equals("Search"))//查询
{
	strTitle = "普通用户查询";
	us_name=CTools.dealString(request.getParameter("us_name")).trim();
	us_uid=CTools.dealString(request.getParameter("us_uid")).trim();
	uk_id=CTools.dealString(request.getParameter("uk_id")).trim();
	us_email=CTools.dealString(request.getParameter("us_email")).trim();
	us_tel=CTools.dealString(request.getParameter("us_tel")).trim();
	us_address=CTools.dealString(request.getParameter("us_address")).trim();
	us_type = CTools.dealString(request.getParameter("us_type")).trim();

	if (!us_name.equals(""))
	{
		sWhere=sWhere + "and u.us_name like '%" + us_name + "%'";
	}
	if (!us_uid.equals(""))
	{
		sWhere=sWhere + " and u.us_uid like '%" + us_uid + "%' ";
	}
	if (!uk_id.equals("")&&!"0".equals(us_type))
	{
		sWhere=sWhere + " and u.uk_id='"+uk_id+"'";
	}
	if (!us_email.equals(""))
	{
		sWhere=sWhere + " and u.us_email like '%" + us_email + "%'";
	}
	if (!us_tel.equals(""))
	{
		sWhere=sWhere + " and u.us_tel like '%" + us_tel + "%'";
	}
	if (!us_address.equals(""))
	{
		sWhere=sWhere + " and u.us_address like '%" + us_address + "%'";
	}
	if (!"".equals(us_type)&&!"0".equals(us_type)) 
	{
		sWhere=sWhere + " and k.uk_id like '%" + us_type + "%'";
	}
	
	sql =" select k.uk_name,u.us_uid,w.ws_name,u.us_email,u.us_name,u.us_address,u.us_tel,u.us_isok,w.ws_id,u.us_id,u.us_istemp from tb_user u,tb_userkind k,tb_website w where  u.ws_id=w.ws_id(+) and u.uk_id=k.uk_id(+) "+sWhere+" order by u.us_id desc ";

}
else
{
  strTitle = "普通用户管理列表";
  sql = "select k.uk_name,u.us_uid,w.ws_name,u.us_name,u.us_email,u.us_address,u.us_tel,u.us_isok,w.ws_id,u.us_id,u.us_istemp from tb_user u,tb_userkind k,tb_website w where  u.UK_ID <> 'o2' and u.ws_id=w.ws_id and u.uk_id=k.uk_id order by u.us_id desc";
}


vectorPage = dImpl.splitPage(sql,request,20);

%>
<%@include file="/system/app/skin/skin4/template/list_top.jsp"%>
<!--    模块名称开始    -->
<%=strTitle%>
<!--    模块名称结束    -->
<%@include file="/system/app/skin/skin4/template/list_function.jsp"%>                                                            
<!--    功能按钮开始    -->
<img src="/system/images/new.gif" border="0" onclick="window.location='UserInfo.jsp?OPType=Add'" title="新增普通用户" style="cursor:hand" align="absmiddle" WIDTH="16" HEIGHT="16">
新增普通用户
<img src="/system/images/menu_about.gif" border="0" onclick="javascript:window.location.href='UserSearch.jsp' " title="查找" style="cursor:hand" align="absmiddle">
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
            <td width="8%" class="outset-table" align="center" nowrap>用户类型</td>
            <td width="5%" class="outset-table" align="center" nowrap>用户名</td>
            <td width="10%" class="outset-table" align="center" nowrap>网站类型</td>
            <td width="10%" class="outset-table" align="center" nowrap>用户姓名</td>
            <td width="10%" class="outset-table" align="center" nowrap>email</td>
            <td width="20%" class="outset-table" align="center" nowrap>用户地址</td>
            <td width="10%" class="outset-table" align="center" nowrap>用户电话</td>
            <td width="5%" class="outset-table" align="center" nowrap>是否活动</td>
            <td width="10%" class="outset-table" align="center"  nowrap>是否临时用户</td>
            <td width="10%" class="outset-table" align="center" nowrap>操作</td>
        </tr>
<%
  if(vectorPage!=null)
  {
    for(int j=0;j<vectorPage.size();j++)
    {
      Hashtable content = (Hashtable)vectorPage.get(j);
      uk_name = CTools.dealNull(content.get("uk_name"));
      us_uid = CTools.dealNull(content.get("us_uid"));
      ws_name = CTools.dealNull(content.get("ws_name"));
      us_name = CTools.dealNull(content.get("us_name"));
      us_email = CTools.dealNull(content.get("us_email"));
      us_address = CTools.dealNull(content.get("us_address"));
      us_tel = CTools.dealNull(content.get("us_tel"));
      us_isok = CTools.dealNull(content.get("us_isok"));
      ws_id = CTools.dealNull(content.get("ws_id"));
      us_id = CTools.dealNull(content.get("us_id"));
      us_istemp = CTools.dealNull(content.get("us_istemp"));
      
      if(j % 2 == 0)  out.print("<tr class=\"line-even\">");
      else out.print("<tr class=\"line-odd\">");
%>
        <td align="center"><%=uk_name%></td>
        <td align="center"><%=us_uid%></td>
        <td align="center"><%=ws_name%></td>
        <td align="center"><%=us_name%></td>
        <td align="center"><%=us_email%></td>
        <td align="center"><%=us_address%></td>
        <td align="center"><%=us_tel%></td>
        <td align="center"><%=us_isok.equals("1")?"是":"否"%></td>
				<td align="center">
				<%
				if(us_istemp.equals("0"))
					out.print("否");
				else if(us_istemp.equals("1"))
					out.print("是");
				else 
					out.print("是");
				%>
				</td>
    <td align="center">
    <%
		if(audit.equals("true")){
		%>
		<a href="UserInfo.jsp?OPType=Audit&us_id=<%=us_id%>&ws_id=<%=ws_id%>">
		<img class="hand" border="0" src="../../images/dialog/hammer.gif" title="审核" WIDTH="16" HEIGHT="16"></a>&nbsp;
		<%
		}else{
		%>
    <a href="UserInfo.jsp?OPType=Edit&us_id=<%=us_id%>&ws_id=<%=ws_id%>">
		<img class="hand" border="0" src="../../images/modi.gif" title="编辑" WIDTH="16" HEIGHT="16"></a>&nbsp;
		<%}%>
    <a href="UserDel.jsp?OPType=del&us_id=<%=us_id%>"><img class="hand" border="0" src="../../images/delete.gif" title="删除" WIDTH="16" HEIGHT="16" onclick="return window.confirm('确认要删除该记录么?');"></a>
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