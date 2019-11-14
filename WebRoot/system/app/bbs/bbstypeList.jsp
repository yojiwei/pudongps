<%@page contentType="text/html; charset=GBK"%>
<%String strTitle="论坛类型" ;%>
<%@include file="../skin/head.jsp"%>
<%
//update20080122

CDataCn dCn=null;   //新建数据库连接对象
CDataImpl dImpl=null;  //新建数据接口对象

try {
 dCn = new CDataCn(); 
 dImpl = new CDataImpl(dCn); 


		String str_sql="select b.*,u.ui_name from tb_bbstype b,tb_userinfo u where b.bt_manager=u.ui_id";
		Vector vectorPage = dImpl.splitPage(str_sql,request,20);

%>
<table class="main-table" width="100%">
 <tr>
  <td width="100%">
       <table class="content-table" width="100%">
                <tr class="title1">
                        <td colspan="8" align="center">
                                <table WIDTH="100%" BORDER="0" CELLSPACING="1" CELLPADDING="1">
                                        <tr>
                                                <td valign="center"><%=strTitle%></td>
                                                <td valign="center" align="right" nowrap>
																											<img src="../../images/split.gif" align="middle" border="0" WIDTH="5" HEIGHT="8">
																                      <img src="../../images/new.gif" border="0" onclick="window.location='bbstypeInfo.jsp'" title="新建" style="cursor:hand" align="absmiddle" WIDTH="16" HEIGHT="16">
																											  <img src="../../images/split.gif" align="middle" border="0" WIDTH="5" HEIGHT="8">
                                                        <img src="../../images/goback.gif" border="0" onclick="javascript:history.back();" title="返回" style="cursor:hand" align="absmiddle">
                                                        <img src="../../images/split.gif" align="middle" border="0" WIDTH="5" HEIGHT="8">
                                                </td>
                                        </tr>
                                </table>
                        </td>
                </tr>
								<tr class="bttn">
                        <td width="70%" class="outset-table">论坛类型</td>
                        <td width="20%" class="outset-table">版主</td>
                        <td width="5%" class="outset-table" nowrap>编辑</td>
                        <td width="5%" class="outset-table" nowrap>删除</td>

                </tr>
 <%
if(vectorPage!=null)
{
  try
  {
    for(int j=0;j<vectorPage.size();j++)
    {
      Hashtable content = (Hashtable)vectorPage.get(j);
      String intId=content.get("bt_id").toString();
            if(j % 2 == 0)  out.print("<tr class=\"line-even\">");
            else out.print("<tr class=\"line-odd\">");
  %>
					<td width="70%"><img border="0" src="../../images/arrow_yellow.gif" WIDTH="15" HEIGHT="13">&nbsp;<%=content.get("bt_name")%></td>
          <td width="20%" %><%=content.get("ui_name")%></td>
					<td width="5%" align="center"><a href="bbstypeInfo.jsp?intId=<%=intId%>"><img class="hand" border="0" src="../../images/modi.gif" title="编辑" WIDTH="16" HEIGHT="16"></a></td>
          <td width="5%" align="center"><a href="bbstypeDel.jsp?intId=<%=intId%>"><img class="hand" border="0" src="../../images/delete.gif" title="删除" WIDTH="16" HEIGHT="16" onclick="return window.confirm('确认要删除该记录么?');"></a></td>
		</tr>
 <%
    }
  %>
   

<%/*分页的页脚模块*/
   out.println("<tr><td colspan=7>" + dImpl.getTail(request) + "</td></tr>"); //输出尾部文件
	}
	catch(Exception e)
	{
		 out.println(e);
	}
}
else
{
  out.println("<tr><td colspan=7>无记录</td></tr>");
}
%>
	</table>
  </td>
</tr>
</table>
<%
dImpl.closeStmt();
dCn.closeCn();
%>
<%@include file="../skin/bottom.jsp"%>
<%


} catch (Exception ex) {
	System.out.println(new java.util.Date() + "--"
			+ request.getServletPath() + " : " + ex.getMessage());
} finally {
	if(dImpl != null)
	dImpl.closeStmt();
	if(dCn != null)
	dCn.closeCn();
}

%>
