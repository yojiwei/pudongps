<%@page contentType="text/html; charset=GBK"%>
<%@include file="/system/app/skin/head.jsp"%>
<%
CDataCn dCn = null;
CDataImpl dImpl = null;
try{
dCn = new CDataCn();
dImpl = new CDataImpl(dCn);

CMySelf mySelf = (CMySelf)session.getAttribute("mySelf");
String ui_uid = mySelf.getMyUid();
String sql="select * from tb_count where co_name = 'pddjw_num'";
Vector vectorPage = dImpl.splitPage(sql,request,100);
%>
<%@include file="/system/app/skin/skin4/template/list_top.jsp"%>
<!--    模块名称开始    -->
党建网访问量
<!--    模块名称结束    -->
<%@include file="/system/app/skin/skin4/template/list_function.jsp"%>                                                            
<!--    功能按钮开始    -->
<img src="/system/images/goback.gif" border="0" onClick="javascript:history.back();" title="返回" style="cursor:hand" align="absmiddle">返回
<!--    功能按钮结束    -->
<%@include file="/system/app/skin/skin4/template/list_listtop.jsp"%>                                                                                        
<!--    列表开始    -->
<table class="main-table" width="100%">
	 <form name="formData" method="post">
                <tr class="bttn">
                        <td width="10%" class="outset-table">网站名称</td>
						<td width="30%" class="outset-table">访问量</td>
                        <td width="30%" class="outset-table">权限代码</td>
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
           </tr>
        <%
            }
        %>
        </form>
        <%
      }
      else
      {
        out.println("<tr><td colspan=7>无记录</td></tr>");
                        }
      %>
      
</table>
<!--    列表结束    -->
<%@include file="/system/app/skin/skin4/template/list_bottom.jsp"%> 
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