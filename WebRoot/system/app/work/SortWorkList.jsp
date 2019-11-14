<%@page contentType="text/html; charset=GBK"%>
<%@include file="/system/app/skin/head.jsp"%>
<%
String strTitle="事项分类管理";
String SW_ID = "";
String SW_NAME = "";
String SW_SEQUENCE = "";

CDataCn dCn = null;
CDataImpl dImpl = null;
try{
dCn = new CDataCn();
dImpl = new CDataImpl(dCn);

String strSql="select * from tb_sortwork order by SW_SEQUENCE";
Vector vectorPage = dImpl.splitPage(strSql,request,20);
%>
<%@include file="/system/app/skin/skin4/template/list_top.jsp"%>
<!--    模块名称开始    -->
<%=strTitle%>
<!--    模块名称结束    -->
<%@include file="/system/app/skin/skin4/template/list_function.jsp"%>                                                            
<!--    功能按钮开始    -->
<img src="../../images/new.gif" border="0" onclick="window.location='SortWorkInfo.jsp'" title="新建类型用户" style="cursor:hand" align="absmiddle" WIDTH="16" HEIGHT="16">
新建类型用户
<img src="../../images/dialog/sort.gif" border="0" onclick="setSequence()" title="修改排序" style="cursor:hand" align="absmiddle" WIDTH="15" HEIGHT="15">
修改排序
<img src="../../images/goback.gif" border="0" onclick="javascript:history.back();" title="返回" style="cursor:hand" align="absmiddle">
返回
<!--    功能按钮结束    -->
<%@include file="/system/app/skin/skin4/template/list_listtop.jsp"%>                                                                                        
<!--    列表开始    -->
<table class="FindAreaTable1" cellspacing="1" rules="cols" border="0" id="ctl00_DataGrid_DataGrid1" style="border-width:0px;">
	 <form name="formData" method="post">
  <tr class="bttn">
          <td width="10%" class="outset-table">类别ID</td>
          <td width="60%" class="outset-table">类别名</td>
          <td width="10%" class="outset-table">编辑</td>
          <td width="10%" class="outset-table">删除</td>
          <td width="10%" class="outset-table">排序</td>
  </tr>
           <%

          if(vectorPage!=null)
          {
            for(int j=0;j<vectorPage.size();j++)
            {
             Hashtable content = (Hashtable)vectorPage.get(j);
             SW_ID = content.get("sw_id").toString();
             SW_NAME = content.get("sw_name").toString();
             SW_SEQUENCE = content.get("sw_sequence").toString();

             if(j % 2 == 0)  out.print("<tr class=\"line-even\">");
             else out.print("<tr class=\"line-odd\">");
           %>
            <td><%=SW_ID%></td>
            <td align="center"><%=SW_NAME%></td>
            <td align="center"><a href="SortWorkInfo.jsp?SW_ID=<%=SW_ID%>"><img class="hand" border="0" src="../../images/modi.gif" title="编辑" WIDTH="16" HEIGHT="16"></a></td>
            <td align="center"><a href="SortWorkDel.jsp?SW_ID=<%=SW_ID%>"><img class="hand" border="0" src="../../images/delete.gif" title="删除" WIDTH="16" HEIGHT="16" onclick="return window.confirm('确认要删除该记录么?');"></a></td>
            <td align="center"><input type=text class=text-line name=<%="module" + SW_ID%> value="<%=SW_SEQUENCE%>" size=4 maxlength=4></td>
           </tr>
        <%
            }
        %>
        </form>
        <%
      }
      else
      {
        out.println("<tr><td colspan=17>无记录</td></tr>");
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
<SCRIPT LANGUAGE="JavaScript">
function setSequence()
{
  var form = document.formData ;
  form.action = "setSequence.jsp";
  form.submit();
}
</SCRIPT>
<%@include file="/system/app/skin/bottom.jsp"%>