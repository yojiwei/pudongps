<%@page contentType="text/html; charset=GBK"%>
<%@include file="/system/app/skin/head.jsp"%>
<%
//update20080122
String strTitle="预设参数" ;
CDataCn dCn=null;   //新建数据库连接对象
CDataImpl dImpl=null;  //新建数据接口对象
try {
 dCn = new CDataCn(); 
 dImpl = new CDataImpl(dCn); 
 String str_sql="select * from tb_initparameter";
 Vector vectorPage = dImpl.splitPage(str_sql,request,20);

%>
<%@include file="/system/app/skin/skin4/template/list_top.jsp"%>
<!--    模块名称开始    -->
<%=strTitle%>
<!--    模块名称结束    -->
<%@include file="/system/app/skin/skin4/template/list_function.jsp"%>                                                            
<!--    功能按钮开始    -->
<img src="../../images/new.gif" border="0" onclick="window.location='parameterInfo.jsp?OP=Add'" title="新建预设参数" style="cursor:hand" align="absmiddle" WIDTH="16" HEIGHT="16">
新建预设参数
<img src="../../images/goback.gif" border="0" onclick="javascript:history.back();" title="返回" style="cursor:hand" align="absmiddle">
返回
<!--    功能按钮结束    -->
<%@include file="/system/app/skin/skin4/template/list_listtop.jsp"%>                                                                                        
<!--    列表开始    -->
<table class="FindAreaTable1" cellspacing="1" rules="cols" border="0" id="ctl00_DataGrid_DataGrid1" style="border-width:0px;">
<tr class="bttn">
            <td width="25%" class="outset-table">预设参数名称</td>
            <td width=200 class="outset-table">预设参数值</td>
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

            <td ><%=content.get("ip_value")%></td>
            <td><%=content.get("ip_memo")%></td>

            <td nowrap align=center><a href="parameterInfo.jsp?OP=Edit&strId=<%=intId%>"><img class="hand" border="0" src="../../images/modi.gif" title="编辑" WIDTH="16" HEIGHT="16"></a></td>
        </tr>
<%}
/*分页的页脚模块*/
  }
  else
  {
    out.println("<tr><td>没有记录！</td></tr>");
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