<%@page contentType="text/html; charset=GBK"%>
<%String strTitle="预设参数" ;%>
<%@include file="../head.jsp"%>
<%
//update20080122

CDataCn dCn=null;   //新建数据库连接对象
CDataImpl dImpl=null;  //新建数据接口对象

try {
 dCn = new CDataCn(); 
 dImpl = new CDataImpl(dCn); 

String str_sql="select * from tb_initparameter";
Vector vectorPage = dImpl.splitPage(str_sql,request,20);

%>
 <table class="main-table" width="100%">
    <tr>
  <td width="100%">
       <table class="content-table" width="100%">

        <tr class="title1">
            <td colspan="5" align="center">
                <table WIDTH="100%" BORDER="0" CELLSPACING="1" CELLPADDING="1">
                    <tr>
                        <td valign="center"><%=strTitle%></td>

                        <td valign="center" align="right" nowrap>

                            <img src="../../images/split.gif" align="middle" border="0" WIDTH="5" HEIGHT="8">
                            <img src="../../images/new.gif" border="0" onclick="window.location='parameterInfo.jsp?OP=Add'" title="新建预设参数" style="cursor:hand" align="absmiddle" WIDTH="16" HEIGHT="16">
                            <img src="../../images/split.gif" align="middle" border="0" WIDTH="5" HEIGHT="8">
                            <img src="../../images/goback.gif" border="0" onclick="javascript:history.back();" title="返回" style="cursor:hand" align="absmiddle">

                            <img src="images/split.gif" align="middle" border="0" WIDTH="5" HEIGHT="8">
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr class="bttn">
            <td width="25%" class="outset-table">预设参数名称</td>

            <td width="40%" class="outset-table">预设参数值</td>
            <td width="27%" class="outset-table">备注</td>

            <td width="8%" class="outset-table" nowrap>编辑</td>
        </tr>
<%

  if(vectorPage != null)
  {
    for(int j=0;j<vectorPage.size();j++)
    {
      Hashtable content = (Hashtable)vectorPage.get(j);
      String intId=content.get("ip_id").toString();
            if(j % 2 == 0)  out.print("<tr class=\"line-even\">");
            else out.print("<tr class=\"line-odd\">");
  %>

            <td><%=content.get("ip_name")%></td>

            <td><%=content.get("ip_value")%></td>
            <td><%=content.get("ip_memo")%></td>

            <td nowrap align=center><a href="parameterInfo.jsp?OP=Edit&strId=<%=intId%>"><img class="hand" border="0" src="../../images/modi.gif" title="编辑" WIDTH="16" HEIGHT="16"></a></td>
        </tr>
<%}%>
</table>
        </td>
    </tr>
<%/*分页的页脚模块*/

   out.println("<tr><td colspan=7>" + dImpl.getTail(request) + "</td></tr>"); //输出尾部文件

  }
  else
  {
    out.println("<tr><td>没有记录！</td></tr>");
  }
%>
</table>


<%@include file="../bottom.jsp"%>

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