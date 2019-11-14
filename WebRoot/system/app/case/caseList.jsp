<%@page contentType="text/html; charset=GBK"%>
<%@include file="/system/app/skin/head.jsp"%>

<%
  CMySelf self = (CMySelf)session.getAttribute("mySelf");
  
  String selfdtid = String.valueOf(self.getDtId());
  String cp_id = request.getParameter("type").toString();
  String str_sql="";
  String strTitle ="典型案例";   
  String cs_id ="";
  String cs_title ="";
  String cs_dateCreated = "";
//
CDataCn dCn = null;
CDataImpl dImpl = null;
try{
dCn = new CDataCn();
dImpl = new CDataImpl(dCn);

str_sql="select cs.cs_id,cs.cs_title,cs.dateCreated from tb_conncase cs where cs.dt_id=" + selfdtid + " and cp_id='"+cp_id+"' order by cs.datecreated desc";
Vector vectorPage = dImpl.splitPage(str_sql,request,20);
%>
<!-- 记录日志 -->
<%
String logstrMenu = "典型案例";
String logstrModule = strTitle;
%>
<%@include file="/system/app/writelogs/WriteListLog.jsp"%>
<!-- 记录日志 -->
<%@include file="/system/app/skin/skin4/template/list_top.jsp"%>
<!--    模块名称开始    -->
<%=strTitle%>
<!--    模块名称结束    -->
<%@include file="/system/app/skin/skin4/template/list_function.jsp"%>                                                            
<!--    功能按钮开始    -->
<img src="../../images/split.gif" align="middle" border="0" WIDTH="5" HEIGHT="8">
<img src="../../images/new.gif" border="0" onclick="window.location='caseInfo.jsp?type=<%=cp_id%>'" title="新增" style="cursor:hand" align="absmiddle">
<img src="../../images/split.gif" align="middle" border="0" WIDTH="5" HEIGHT="8">
<img src="../../images/goback.gif" border="0" onclick="javascript:history.back();" title="返回" style="cursor:hand" align="absmiddle">
<img src="../../images/split.gif" align="middle" border="0" WIDTH="5" HEIGHT="8">
<!--    功能按钮结束    -->
<%@include file="/system/app/skin/skin4/template/list_listtop.jsp"%>                                                                                        <asp:ContentPlaceHolder ID="DataGrid" runat="server">
<!--    列表开始    -->
<table class="FindAreaTable1" cellspacing="1" rules="cols" border="0" id="ctl00_DataGrid_DataGrid1" style="border-width:0px;">
		<tr class="bttn">
			<td width="5%" class="outset-table" align="center">序号</td>					
			<td width="65%" class="outset-table">主题</td>	
			<td width="20%" class="outset-table">提交时间</td>
			<td width="10%" class="outset-table" nowrap>操作</td>
		</tr>
 <%
   if(vectorPage!=null){
       for(int j=0;j<vectorPage.size();j++){
	     	 Hashtable content = (Hashtable)vectorPage.get(j);        
			   cs_title = content.get("cs_title").toString();
			   cs_id =  content.get("cs_id").toString();
			   cs_dateCreated = content.get("datecreated").toString();
         
         if(j % 2 == 0)
           out.print("<tr class=\"line-even\">");
         else
           out.print("<tr class=\"line-odd\">");
  %>
      <td width="5%" align="center">
		  <%=j%>
		  </td>
          <td width="65%" align="center"><div align='left'><%=cs_title%></div></td>
		  <td width="20%" align="center"><%=cs_dateCreated%></td>         
          <td width="10%" align="center">
		   <!-- cw_id:表单id ，cw_status:信件状态 -->
		   <a href="caseInfo.jsp?type=<%=cp_id%>&cs_id=<%=cs_id%>">
		      <img class="hand" border="0" src="../../images/modi.gif" title="修改" WIDTH="16" HEIGHT="16">
		   </a>
		   <a href="caseDel.jsp?type=<%=cp_id%>&cs_id=<%=cs_id%>">
		      <img class="hand" border="0" src="../../images/delete.gif" title="删除" WIDTH="16" HEIGHT="16" onclick="return window.confirm('确认要删除该记录么?');">
		   </a>
		  </td>
<%
    }
  %>
   </tr>
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