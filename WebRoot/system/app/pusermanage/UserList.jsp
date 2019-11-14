<%@page contentType="text/html; charset=GBK"%>
<%@include file="/system/app/skin/head.jsp"%>
<%
CDataCn dCn = null; //新建数据库连接对象
CDataImpl dImpl = null; //新建数据接口对象
try{
dCn = new CDataCn(); //新建数据库连接对象
dImpl = new CDataImpl(dCn); //新建数据接口对象
String strTitle="";
String sql="";
String audit = CTools.dealString(request.getParameter("audit"));
String optype = CTools.dealString(request.getParameter("OPType"));
String sub_us_id="subString(tb_user.us_id,1,tb_user.us_id.length-1)";


if(audit.equals("true"))
{
  strTitle = "普通用户审核";
  sql =" select * from tb_user,tb_userkind,tb_website ";
  sql +=" where tb_user.UK_ID != 'o2' and tb_user.ws_id=tb_website.ws_id and tb_user.uk_id=tb_userkind.uk_id and us_isok=0 ";
  sql += " order by to_number(substr(tb_user.us_id,2,length(tb_user.us_id)-1)) desc";
}
else if(optype.equals("Search"))
{
strTitle = "普通用户查询";

String us_name="";
String us_uid="";
String uk_id="";
String us_email="";
String us_tel="";
String us_address="";

us_name=CTools.dealString(request.getParameter("us_name")).trim();
us_uid=CTools.dealString(request.getParameter("us_uid")).trim();
uk_id=CTools.dealString(request.getParameter("uk_id")).trim();
us_email=CTools.dealString(request.getParameter("us_email")).trim();
us_tel=CTools.dealString(request.getParameter("us_tel")).trim();
us_address=CTools.dealString(request.getParameter("us_address")).trim();
String us_type = CTools.dealString(request.getParameter("us_type")).trim();

String sWhere="";
if (!us_name.equals(""))
	{
		sWhere=sWhere + "and us_name like '%" + us_name + "%'";
	}
if (!us_uid.equals(""))
	{
		sWhere=sWhere + " and us_uid like '%" + us_uid + "%'";
	}
if (!uk_id.equals(""))
	{
		sWhere=sWhere + " and uk_id='"+uk_id+"'";
	}
if (!us_email.equals(""))
	{
		sWhere=sWhere + " and us_email like '%" + us_email + "%'";
	}
if (!us_tel.equals(""))
	{
		sWhere=sWhere + " and us_tel like '%" + us_tel + "%'";
	}
if (!us_address.equals(""))
	{
		sWhere=sWhere + " and us_address like '%" + us_address + "%'";
	}
if (!"".equals(us_type)) {
	sWhere=sWhere + " and tb_userkind.uk_id like '%" + us_type + "%'";
}

  sql =" select * from tb_user,tb_userkind,tb_website ";
  sql +=" where tb_user.UK_ID != 'o2' and tb_user.ws_id=tb_website.ws_id and tb_user.uk_id=tb_userkind.uk_id "+sWhere;
  sql += " order by to_number(substr(tb_user.us_id,2,length(tb_user.us_id)-1)) desc";
}
else
{
  strTitle = "普通用户管理列表";
  sql = "select * from tb_user u,tb_userkind k,tb_website w where u.uk_id=k.uk_id and k.uk_name = '党务专网用户' and w.ws_id = u.ws_id and w.ws_name='浦东党务网' order by us_id desc  ";
}

%>
<%@include file="/system/app/skin/skin4/template/list_top.jsp"%>
<!--    模块名称开始    -->
<%=strTitle%>
<!--    模块名称结束    -->
<%@include file="/system/app/skin/skin4/template/list_function.jsp"%>                                                            
<!--    功能按钮开始    -->
<img src="/system/images/new.gif" border="0" onclick="window.location='UserInfo.jsp?OPType=Add'" title="新增用户" style="cursor:hand" align="absmiddle" WIDTH="16" HEIGHT="16">
新增用户
<img src="/system/images/goback.gif" border="0" onclick="javascript:history.back();" title="返回" style="cursor:hand" align="absmiddle">
返回
<!--    功能按钮结束    -->
<%@include file="/system/app/skin/skin4/template/list_listtop.jsp"%>                                                                                        
<!--    列表开始    -->
<table class="FindAreaTable1" cellspacing="1" rules="cols" border="0" id="ctl00_DataGrid_DataGrid1" style="border-width:0px;">
<form name="formData">
	 <INPUT TYPE="hidden" name="audit" value="<%=audit%>">
    <tr class="bttn">
        <td width="20%" class="outset-table" align="center" nowrap>用户类型</td>
        <td width="30%" class="outset-table" align="center" nowrap>用户名</td>
				<td width="20%" class="outset-table" align="center" nowrap>用户姓名</td>
        <td width="10%" class="outset-table" align="center" nowrap>网站类型</td>
        <td width="20%" class="outset-table" align="center" nowrap>操作</td>
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
	  <td align="center"><%=content.get("uk_name")%></td>
	  <td align="center"><%=content.get("us_uid")%></td>
		<td align="center"><%=content.get("us_name")%></td>
	  <td align="center"><%=content.get("ws_name")%></td>
	  <td align="center">
	  <%
		if(audit.equals("true")){
		%>
		<a href="UserInfo.jsp?OPType=Audit&us_id=<%=content.get("us_id")%>&ws_id=<%=content.get("ws_id")%>">
		<img class="hand" border="0" src="../../images/dialog/hammer.gif" title="审核" WIDTH="16" HEIGHT="16"></a>&nbsp;
		<%
		}
		else
		{
		%>
                <a href="UserInfo.jsp?OPType=Edit&us_id=<%=content.get("us_id")%>">
		<img class="hand" border="0" src="../../images/modi.gif" title="编辑" WIDTH="16" HEIGHT="16"></a>&nbsp;
		<%}%>
                <a href="UserDel.jsp?OPType=del&us_id=<%=content.get("us_id")%>"><img class="hand" border="0" src="../../images/delete.gif" title="删除" WIDTH="16" HEIGHT="16" onclick="return window.confirm('确认要删除该记录么?');"></a>
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