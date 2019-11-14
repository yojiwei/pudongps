<%@page contentType="text/html; charset=GBK"%>
<%@include file="/system/app/skin/head.jsp"%>
<%
String strTitle="事项分类管理";
String GW_ID = "";
String GW_NAME = "";
String GW_SEQUENCE = "";
String DT_ID = "";
String DT_NAME = "";
//
Vector vectorPage = null;
Hashtable content = null;
CDataCn dCn = null;
CDataImpl dImpl = null;
try{
dCn = new CDataCn();
dImpl = new CDataImpl(dCn);
String strSql="select a.gw_id,a.gw_name,a.gw_sequence,b.dt_name from tb_gasortwork a,tb_deptinfo b where a.dt_id=b.dt_id order by a.dt_id,a.gw_sequence";
vectorPage = dImpl.splitPage(strSql,request,20);
%>
<%@include file="/system/app/skin/skin4/template/list_top.jsp"%>
<!--    模块名称开始    -->
<%=strTitle%>
<!--    模块名称结束    -->
<%@include file="/system/app/skin/skin4/template/list_function.jsp"%>                                                            
<!--    功能按钮开始    -->
<img src="/system/images/new.gif" border="0" onclick="window.location='SortWorkInfo.jsp'" title="新建类型" style="cursor:hand" align="absmiddle" WIDTH="16" HEIGHT="16">
新建类型
<img src="/system/images/dialog/sort.gif" border="0" onclick="setSequence()" title="修改排序" style="cursor:hand" align="absmiddle" WIDTH="15" HEIGHT="15">
修改排序
<img src="/system/images/goback.gif" border="0" onclick="javascript:history.back();" title="返回" style="cursor:hand" align="absmiddle">
返回
<!--    功能按钮结束    -->
<%@include file="/system/app/skin/skin4/template/list_listtop.jsp"%>                                                                                        
<!--    列表开始    -->
<table class="FindAreaTable1" cellspacing="1" rules="cols" border="0" id="ctl00_DataGrid_DataGrid1" style="border-width:0px;">
	 <form name="formData" method="post">
                <tr class="bttn">
									<td width="10%" class="outset-table">类别ID</td>
									<td width="30%" class="outset-table">所属单位</td>
									<td width="30%" class="outset-table">类别名</td>
									<td width="10%" class="outset-table">编辑</td>
									<td width="10%" class="outset-table">删除</td>
									<td width="10%" class="outset-table">排序</td>
                </tr>
           <%
          if(vectorPage!=null)
          {
            for(int j=0;j<vectorPage.size();j++)
            {
             content = (Hashtable)vectorPage.get(j);
             GW_ID = content.get("gw_id").toString();
             GW_NAME = content.get("gw_name").toString();
             GW_SEQUENCE = content.get("gw_sequence").toString();
			 DT_NAME = content.get("dt_name").toString();

             if(j % 2 == 0)  out.print("<tr class=\"line-even\">");
             else out.print("<tr class=\"line-odd\">");
           %>
            <td align="center"><%=GW_ID%></td>
			<td align="center"><%=DT_NAME%></td>
            <td align="center"><%=GW_NAME%></td>
            <td align="center"><a href="SortWorkInfo.jsp?GW_ID=<%=GW_ID%>"><img class="hand" border="0" src="/system/images/modi.gif" title="编辑" WIDTH="16" HEIGHT="16"></a></td>
            <td align="center"><a href="SortWorkDel.jsp?GW_ID=<%=GW_ID%>"><img class="hand" border="0" src="/system/images/delete.gif" title="删除" WIDTH="16" HEIGHT="16" onclick="return window.confirm('确认要删除该记录么?');"></a></td>
            <td align="center"><input type=text class=text-line name=<%="module" + GW_ID%> value="<%=GW_SEQUENCE%>" size=4 maxlength=4></td>
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
<SCRIPT LANGUAGE="JavaScript">
function setSequence()
{
  var form = document.formData ;
  form.action = "setSequence.jsp";
  form.submit();
}
</SCRIPT>
<%@include file="/system/app/skin/bottom.jsp"%>