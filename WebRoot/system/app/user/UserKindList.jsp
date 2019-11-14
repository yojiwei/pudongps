<%@page contentType="text/html; charset=GBK"%>
<%@include file="/system/app/skin/head.jsp"%>
<%
String strTitle="用户类别管理";
String UK_ID = "";
String UK_NAME = "";
//
CDataCn dCn = null;
CDataImpl dImpl = null;
try{
dCn = new CDataCn();
dImpl = new CDataImpl(dCn);
//
String strSql="select * from TB_USERKIND";
Vector vectorPage = dImpl.splitPage(strSql,request,20);
%>
<%@include file="/system/app/skin/skin4/template/list_top.jsp"%>
<!--    模块名称开始    -->
<%=strTitle%>
<!--    模块名称结束    -->
<%@include file="/system/app/skin/skin4/template/list_function.jsp"%>                                                            
<!--    功能按钮开始    -->
<img src="../../images/new.gif" border="0" onclick="window.location='UserKindInfo.jsp'" title="新建类型用户" style="cursor:hand" align="absmiddle" WIDTH="16" HEIGHT="16">
新建类型用户
<img src="../../images/goback.gif" border="0" onclick="javascript:history.back();" title="返回" style="cursor:hand" align="absmiddle">
返回
<!--    功能按钮结束    -->
<%@include file="/system/app/skin/skin4/template/list_listtop.jsp"%>                                                                                        
<!--    列表开始    -->
<table class="FindAreaTable1" cellspacing="1" rules="cols" border="0" id="ctl00_DataGrid_DataGrid1" style="border-width:0px;">
                <tr class="bttn">
                        <td width="10%" class="outset-table">类别ID</td>
                        <td width="60%" class="outset-table">类别名</td>
                        <td width="10%" class="outset-table">编辑</td>
                        <td width="10%" class="outset-table">删除</td>
                </tr>
                <%

          if(vectorPage!=null)
          {
            for(int j=0;j<vectorPage.size();j++)
            {
              Hashtable content = (Hashtable)vectorPage.get(j);
              UK_ID=content.get("uk_id").toString();
              UK_NAME=content.get("uk_name").toString();

              if(j % 2 == 0)  out.print("<tr class=\"line-even\">");
              else out.print("<tr class=\"line-odd\">");
        %>
            <td><%=UK_ID%></td>
            <td align="center"><%=UK_NAME%></td>
            <td align="center"><a href="UserKindInfo.jsp?UK_ID=<%=UK_ID%>"><IMG class=hand
src="/system/images/modi.gif" border=0></a></td>
            <td align="center"><a href="UserKindDel.jsp?UK_ID=<%=UK_ID%>"><IMG class=hand title=删除
onclick="return window.confirm('确认要删除该记录么?');" height=16
src="/system/images/delete.gif" width=16 border=0></a></td>
            </tr>
        <%
            }
        %>
        </form>
        <%
      }
      else
      {
        out.println("<tr><td colspan=20>无记录</td></tr>");
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