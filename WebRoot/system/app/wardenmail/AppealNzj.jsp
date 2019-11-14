<%@page contentType="text/html; charset=GBK"%>
<%@include file="/system/app/skin/head.jsp"%>
<%
CMySelf self = (CMySelf)session.getAttribute("mySelf");
  String strTitle = "转交失败信件列表";
  String cw_zhuanjiao = "";
  String cw_id = "";
  String cp_id = "";
  String isovertime = "";
  String isovertimem = "";
  String cw_subject = "";
  String cw_applytime = "";
  String cw_applyingname = "";
  String str_sql = "";
  String cp_name = "";
  String cw_isovertimem = "";
//
CDataCn dCn = null;
CDataImpl dImpl = null;
try{
dCn = new CDataCn();
dImpl = new CDataImpl(dCn);

cw_zhuanjiao = CTools.dealString(request.getParameter("cw_zhuanjiao"));
cw_isovertimem = CTools.dealString(request.getParameter("cw_isovertimem"));

//转交失败列表
str_sql = "select c.cw_id,c.cp_id,c.cw_applyingname,c.cw_subject,to_char(c.cw_applytime,'yyyy-mm-dd hh24:mi:ss') cw_applytime,to_char(c.cw_finishtime,'yyyy-mm-dd hh24:mi:ss') cw_finishtime,c.cw_isovertime,c.cw_isovertimem,p.cp_name from tb_connwork c,tb_connproc p where c.cp_id = p.cp_id(+) and c.cp_id in('o1','o5','mailYGXX') and c.cw_status=1";
if(cw_zhuanjiao.equals("2")){
	str_sql += " and c.cw_zhuanjiao=2";
}
str_sql += " and c.cw_applytime>to_date('2009-08-15 00:00:01','yyyy-MM-dd hh24:mi:ss') order by c.cw_applytime desc";


//办理超时列表
if(cw_isovertimem.equals("1")){
	strTitle = "办理超时列表";
	str_sql = "select c.cw_id,c.cp_id,c.cw_applyingname,c.cw_subject,to_char(c.cw_applytime,'yyyy-mm-dd hh24:mi:ss') cw_applytime,to_char(c.cw_finishtime,'yyyy-mm-dd hh24:mi:ss') cw_finishtime,c.cw_isovertime,c.cw_isovertimem,p.cp_name from tb_connwork c,tb_connproc p where c.cp_id = p.cp_id(+) and c.cw_applytime > to_date('2009-08-15 12:59:59','yyyy-MM-dd hh24:mi:ss') and c.cw_status = 2 and c.cw_zhuanjiao=1 and c.cw_isovertimem=1 and c.cp_id in('o1','o5','mailYGXX') order by c.cw_applytime desc ";
}



//out.println(str_sql);
Vector vectorPage = dImpl.splitPage(str_sql,request,20);

%>
<%@include file="/system/app/skin/skin4/template/list_top.jsp"%>
<!--    模块名称开始    -->
<%=strTitle%>
<!--    模块名称结束    -->
<%@include file="/system/app/skin/skin4/template/list_function.jsp"%>                                                            
<!--    功能按钮开始    -->
<img src="../../images/goback.gif" border="0" onclick="javascript:history.back();" title="返回" style="cursor:hand" align="absmiddle">
返回
<!--    功能按钮结束    -->
<%@include file="/system/app/skin/skin4/template/list_listtop.jsp"%>
<!--    列表开始    -->
<table class="FindAreaTable1" cellspacing="1" rules="cols" border="0" id="ctl00_DataGrid_DataGrid1" style="border-width:0px;">
<tr class="bttn">                       
	<td width="10%" class="outset-table">发信人</td>                       
	<td width="30%" class="outset-table">主题</td>
	<td width="10%" class="outset-table">信件类别</td>
	<td width="11%" class="outset-table">发送时间</td>
	<td width="11%" class="outset-table" nowrap>受理超时</td>
	<td width="11%" class="outset-table" nowrap>办理超时</td>						
	<td width="5%" class="outset-table" nowrap>操作</td>
</tr>
 <%
   if(vectorPage!=null){
       for(int j=0;j<vectorPage.size();j++){
         Hashtable content = (Hashtable)vectorPage.get(j);
         cw_id= CTools.dealNull(content.get("cw_id"));
         cp_name = CTools.dealNull(content.get("cp_name"));
				 isovertime = CTools.dealNull(content.get("cw_isovertime"));
				 isovertimem = CTools.dealNull(content.get("cw_isovertimem"));
				 cw_subject = CTools.dealNull(content.get("cw_subject"));
				 cw_applytime = CTools.dealNull(content.get("cw_applytime"));
				 cw_applyingname = CTools.dealNull(content.get("cw_applyingname"));
         
         if(j % 2 == 0)
           out.print("<tr class=\"line-even\">");
         else
           out.print("<tr class=\"line-odd\">");
  		%>
      <td  align="center"><%=cw_applyingname%></td>
		  <td align="center"><%=cw_subject%></td>
		  <td align="center"><%=cp_name%></td>
      <td align="center"><%=cw_applytime%></td>          
      <td  align="center"><%=isovertime.equals("1")?"是":"否"%></td>
      <td  align="center"><%=isovertimem.equals("1")?"是":"否"%></td>
      <td width="5%" align="center">
      	<%if(cw_isovertimem.equals("1")){%>
	      	<a href="AppealInfo.jsp?cw_id=<%=cw_id%>&cw_status=2">
			      <img class="hand" border="0" src="../../images/modi.gif" title="查看" WIDTH="16" HEIGHT="16">
			   </a>
      	<%}else{%>
			   <a href="AppealNzjResult.jsp?cw_id=<%=cw_id%>">
			      <img class="hand" border="0" src="../../images/modi.gif" title="修改状态" WIDTH="16" HEIGHT="16">
			   </a>
		   <%}%>
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