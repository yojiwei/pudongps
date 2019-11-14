<%@page contentType="text/html; charset=GBK"%>
<%@page import="com.website.*"%>
<%@page import="com.util.*"%>
<%@include file="/system/app/skin/head.jsp"%>
<body>
<%
	CDataCn dCn = null;
	CDataImpl dImpl = null;
	try{
	dCn = new CDataCn();
    dImpl = new CDataImpl(dCn);
%>
<%
CMySelf mySelf = (CMySelf)session.getAttribute("mySelf");
String ui_uid = mySelf.getMyUid();
String sql="select * from tb_count order by co_id desc";
Vector vectorPage = dImpl.splitPage(sql,request,100);
%>



<table class="main-table" width="100%">
 <tr>
  <td width="100%">
       <table class="content-table" width="100%">
	 <form name="formData" method="post">
                <tr class="title1">
                        <td colspan="6" align="center">
                                <table WIDTH="100%" BORDER="0" CELLSPACING="1" CELLPADDING="1">
                                        <tr>
                                                
                                                <td valign="center" align="right" nowrap>

                                                        <img src="/system/images/split.gif" align="middle" border="0" WIDTH="5" HEIGHT="8">
                                                        <!--img src="/system/images/dialog/sort.gif" border="0" onclick="setSequence()" title="修改排序" style="cursor:hand" align="absmiddle" WIDTH="15" HEIGHT="15">
                                                        <img src="/system/images/split.gif" align="middle" border="0" WIDTH="5" HEIGHT="8"-->
                                                        <img src="/system/images/goback.gif" border="0" onclick="javascript:history.back();" title="返回" style="cursor:hand" align="absmiddle">
                                                        <img src="/system/images/split.gif" align="middle" border="0" WIDTH="5" HEIGHT="8">
                                                </td>
                                        </tr>
                                </table>
                        </td>
                </tr>
                <tr class="bttn">
                        <td width="10%" class="outset-table">网站名称</td>
						<td width="30%" class="outset-table">访问量</td>
                        <td width="30%" class="outset-table">权限代码</td>
                        <td width="10%" class="outset-table">编辑</td>
                        <td width="10%" class="outset-table">删除</td>
                        <!--td width="10%" class="outset-table">排序</td-->
                </tr>
           <%

          if(vectorPage!=null)
          {
            for(int j=0;j<vectorPage.size();j++)
            {
             Hashtable content = (Hashtable)vectorPage.get(j);
             String co_webname = content.get("co_webname").toString();
             String co_name = content.get("co_name").toString();
             String co_showflag = content.get("co_showflag").toString();
			 String co_number = content.get("co_number").toString();
			 String co_id = content.get("co_id").toString();

             if(j % 2 == 0)  out.print("<tr class=\"line-even\">");
             else out.print("<tr class=\"line-odd\">");
           %>
            <td align="center"><%=co_webname%></td>
			<td align="center"><%=co_number%></td>
            <td align="center"><%=co_name%></td>
            <td align="center"><a href="countInfo.jsp?co_id=<%=co_id%>"><img class="hand" border="0" src="/system/images/modi.gif" title="编辑" WIDTH="16" HEIGHT="16"></a></td>
            <td align="center"><a href="countDel.jsp?co_name=<%=co_name%>"><img class="hand" border="0" src="/system/images/delete.gif" title="删除" WIDTH="16" HEIGHT="16" onclick="return window.confirm('确认要删除该记录么?');"></a></td>
            <!--td align="center"><input type=text class=text-line name= value="" size=4 maxlength=4></td-->
           </tr>
        <%
            }
        %>
        </form>
        <%
      /*分页的页脚模块*/
      out.println("<tr><td colspan=7>" + dImpl.getTail(request) + "</td></tr>"); //输出尾部文件


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
<%@include file="/system/app/skin/bottom.jsp"%>
</body>

