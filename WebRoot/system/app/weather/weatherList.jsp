<%@page contentType="text/html; charset=GBK"%>
<%@include file="/system/app/skin/head.jsp"%>
<%
String strTitle = "天气预报浏览";
CDataCn dCn = null;
CDataImpl dImpl = null;
Vector vectorPage = null;
try{
dCn = new CDataCn();
dImpl = new CDataImpl(dCn);
String start_date = CTools.dealString(request.getParameter("start_date")).trim();//天气预报发布起始日期
String end_date = CTools.dealString(request.getParameter("end_date")).trim();//天气预报发布结束日期
String swhere = ""; //查询条件
if (!start_date.equals(""))
{
	swhere += "and to_date(wf_publish_time,'YYYY-MM-DD') >= to_date('"+ start_date +"','YYYY-MM-DD') ";
}
if (!end_date.equals(""))
{
	swhere += "and to_date(wf_publish_time,'YYYY-MM-DD') <= to_date('"+ end_date +"','YYYY-MM-DD') ";
}
String strSql="";
  strSql = "select * from tb_weatherforecast where 1=1 "+ swhere +" order by to_date(wf_publish_time,'YYYY-MM-DD') desc,wf_id desc";

vectorPage = dImpl.splitPage(strSql,request,20);

%>
<%@include file="/system/app/skin/skin4/template/list_top.jsp"%>
<!--    模块名称开始    -->
<%=strTitle%>
<!--    模块名称结束    -->
<%@include file="/system/app/skin/skin4/template/list_function.jsp"%>                                                            
<!--    功能按钮开始    -->
<img src="/system/images/new.gif" border="0" onclick="window.location='weatherInfo.jsp?OPType=Add'" title="新增信息" style="cursor:hand" align="absmiddle" WIDTH="16" HEIGHT="16">
新增信息
<img src="/system/images/menu_about.gif" border="0" onclick="javascript:window.location.href='weatherSearch.jsp' " title="查找" style="cursor:hand" align="absmiddle">
查找
<img src="/system/images/goback.gif" border="0" onclick="javascript:history.back();" title="返回" style="cursor:hand" align="absmiddle">
返回		        
<!--    功能按钮结束    -->
<%@include file="/system/app/skin/skin4/template/list_listtop.jsp"%>                                                                                        
<!--    列表开始    -->
<table class="FindAreaTable1" cellspacing="1" rules="cols" border="0" id="ctl00_DataGrid_DataGrid1" style="border-width:0px;">
 <form name="formData">
    <tr class="bttn">
        <td width="12%" class="outset-table">发布日期</td>
        <td width="40%" class="outset-table">中文版天气预报</td>
        <td width="40%" class="outset-table">英文版天气预报</td>
        <td width="8%" class="outset-table" nowrap>操作</td>
    </tr>
<%
  String conCh = "";
  String conEn = "";
  String conChSub = "";
  String conEnSub = "";
  
  if(vectorPage!=null)
  {
    for(int j=0;j<vectorPage.size();j++)
    {
      Hashtable content = (Hashtable)vectorPage.get(j);
      conCh = content.get("wf_contentch").toString();
      conEn = content.get("wf_contenten").toString();
      conChSub = conCh.length() > 25 ? conCh.substring(0,24)+".." : conCh;
      conEnSub = conEn.length() > 51 ? conEn.substring(0,50)+".." : conEn;
      if(j % 2 == 0)  out.print("<tr class=\"line-even\">");
      else out.print("<tr class=\"line-odd\">");
%>
                <td align="center"><%=content.get("wf_publish_time")%></td>
                <td align="center" title="<%=conCh%>"><%=conChSub%></td>
                <td align="center" title="<%=conEn%>"><%=conEnSub%></td>
                <td align="center"><a href="weatherInfo.jsp?OPType=Edit&WF_id=<%=content.get("wf_id")%>"><img class="hand" border="0" src="/system/images/modi.gif" title=编辑" WIDTH="16" HEIGHT="16"></a>
								&nbsp;
								<a href="weatherDel.jsp?OPType=del&WF_id=<%=content.get("wf_id")%>">
								<img class="hand" border="0" src="../../images/delete.gif" title="删除" WIDTH="16" HEIGHT="16" onclick="return window.confirm('确认要删除该记录么?');"></a>
								</td>
            </tr>

<%
    }
%>
</form>
<%
  }
  else
  {
    out.println("<tr><td colspan=7>没有记录！</td></tr>");
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