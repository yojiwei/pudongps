<%@page contentType="text/html; charset=GBK"%>
<%@include file="/system/app/skin/head.jsp"%>

<%
CMySelf self = (CMySelf)session.getAttribute("mySelf");

String selfdtid = String.valueOf(self.getDtId());
String sender_id = String.valueOf(self.getMyID());

String cw_status = request.getParameter("cw_status").toString();
int intStatus = Integer.parseInt(cw_status);
String strTitle = "";
String strhref = "";
String strAct = "";
String deal_dtid = "";
String deal_name = "";
String str_sql = "";
String status_lamp = "";
String cw_trans_id = "";
String sql_deal ="";
Hashtable content_dt = null;
switch(intStatus)
{
case 1:
  strTitle = "待处理办理信箱";
  strhref = "AppealInfo.jsp";
  strAct = "受理";
  break;
case 2:
  strTitle = "处理中办理信箱";
  strhref = "AppealInfo.jsp";
  strAct = "办理";
  break;
case 3:
  strTitle = "已处理办理信箱";
  strhref = "AppealInfo.jsp";
  strAct = "查看";
  break;
case 8:
  strTitle = "协调中办理信箱";
  strhref = "AppealInfo.jsp";
  strAct = "查看";
  break;
case 9:
  strTitle = "垃圾信件";
  strhref = "AppealInfo.jsp";
  strAct = "查看";
  break;
case 18:
	strTitle = "协调完成信件";
	strhref = "AppealInfo.jsp";
	strAct = "查看";
	break;
default:
  strTitle = "";
}

//
CDataCn dCn = null;
CDataImpl dImpl = null;
try{
dCn = new CDataCn();
dImpl = new CDataImpl(dCn);
//
if(intStatus==8)
 {
  str_sql="select c.cw_id,c.cp_id,c.cw_applyingname,c.cw_applyingdept,c.cw_trans_id,p.dt_id,c.cw_subject,to_char(c.cw_managetime,'yyyy-mm-dd hh24:mi:ss') cw_managetime,c.cw_isovertime,c.cw_isovertimem,to_char(c.cw_applytime,'yyyy-mm-dd hh24:mi:ss') cw_applytime,to_char(c.cw_finishtime,'yyyy-mm-dd hh24:mi:ss') cw_finishtime,p.cp_timelimit,p.cp_timelimiting from tb_connwork c,tb_deptinfo d,tb_connproc p where  (p.cp_id='o13' or p.cp_upid='o13') and c.cp_id=p.cp_id and c.cw_status=" + cw_status;
 }
else
 str_sql="select c.cw_id,c.cp_id,c.cw_applyingname,c.cw_applyingdept,c.cw_subject,to_char(c.cw_managetime,'yyyy-mm-dd hh24:mi:ss') cw_managetime,c.cw_isovertime,c.cw_isovertimem,to_char(c.cw_applytime,'yyyy-mm-dd hh24:mi:ss') cw_applytime,to_char(c.cw_finishtime,'yyyy-mm-dd hh24:mi:ss') cw_finishtime,p.cp_timelimit,p.cp_timelimiting from tb_connwork c,tb_deptinfo d,tb_connproc p where (p.cp_id='o13' or p.cp_upid='o13') and c.cp_id=p.cp_id and c.cw_status=" + cw_status;

  CRoleAccess ado = new CRoleAccess(dCn);
  if (!ado.isAdmin(sender_id)) {
  	str_sql += " and p.dt_id=" + selfdtid;
  }  
  
  str_sql += " and p.dt_id=d.dt_id order by cw_applytime desc";
	Vector vectorPage = dImpl.splitPage(str_sql,request,20);
%>
<!-- 记录日志 -->
<%
String logstrMenu = "办理件处理";
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
<img src="../../images/goback.gif" border="0" onclick="javascript:history.back();" title="返回" style="cursor:hand" align="absmiddle">
返回                                              
<!--    功能按钮结束    -->
<%@include file="/system/app/skin/skin4/template/list_listtop.jsp"%>                                                                                        
<!--    列表开始    -->
<table class="FindAreaTable1" cellspacing="1" rules="cols" border="0" id="ctl00_DataGrid_DataGrid1" style="border-width:0px;">
                <tr class="bttn">                       
                        <td width="10%" class="outset-table">发信人</td >                       
                        <td width="30%" class="outset-table">主题</td>
                        <td width="11%" class="outset-table">发送时间</td>
                        <%
						              if(intStatus==3)
                          out.print("<td width=\"10%\" class=\"outset-table\">办理完成时间</td>");
                         if(intStatus==8)
                          out.print("<td width=\"16%\" class=\"outset-table\">转办单位</td>");
						 if(intStatus == 1 ) 
							out.print("<td width='11%' class='outset-table'>受理时限</td>");                        
						 if( intStatus == 2 || intStatus == 8) 
							out.print("<td width='11%' class='outset-table'>办理时限</td>");
						%>						
						<td width="11%" class="outset-table" nowrap>受理超时</td>
						<td width="11%" class="outset-table" nowrap>办理超时</td>						
                        <td width="5%" class="outset-table" nowrap><%=strAct%></td>
                </tr>
 <%
if(vectorPage!=null)
{
    for(int j=0;j<vectorPage.size();j++)
    {
      Hashtable content = (Hashtable)vectorPage.get(j);
      String CW_ID = content.get("cw_id").toString();
	  String isovertime = content.get("cw_isovertime").toString();
	  String isovertimem = content.get("cw_isovertimem").toString();
	  
      if(intStatus==8)
      {
		cw_trans_id = content.get("cw_trans_id").toString();
		sql_deal ="select dt_id from tb_connproc where cp_id='"+cw_trans_id+"'";
		content_dt = dImpl.getDataInfo(sql_deal);
		if(content_dt!=null){
			deal_dtid = content_dt.get("dt_id").toString();
		}
        if(!deal_dtid.equals(""))
        {
         sql_deal = "select dt_name from tb_deptinfo where dt_id=" + deal_dtid;
         Hashtable content_deal = dImpl.getDataInfo(sql_deal);
         deal_name = content_deal.get("dt_name").toString();
        }
      }
            if(j % 2 == 0)  out.print("<tr class=\"line-even\">");
            else out.print("<tr class=\"line-odd\">");
  %>
          <td  align="center"><%=content.get("cw_applyingname")%></td>          
          <td align="center"><%=content.get("cw_subject") %></td>
          <td align="center"><%=content.get("cw_applytime")%></td>
          <%
			      if(intStatus==3)
            out.print("<td  align=\"center\">" + content.get("cw_finishtime") + "</td>");		    
            if(intStatus==8)
            out.print("<td align=\"center\">" + deal_name + "</td>");
            if (intStatus == 1 || intStatus == 2 || intStatus == 8) {
          %>
          <td width="16%" align="center">
          <%if (intStatus == 1) 
          		out.println(content.get("cp_timelimit"));
          	else if (intStatus == 2) 
          		out.println(content.get("cp_timelimiting"));
          	else 
						out.println("60");
          %> 
             天</td>
          <%}
		   if (isovertime.equals("1")){
				out.print("<td><span style=color:red>是</span></td>");
			 }
			 else{
				out.print("<td>否</td>");
			 }
			 if (isovertimem.equals("1")){
				out.print("<td><span style=color:red>是</span></td>");
			 }
			 else{
				out.print("<td>否</td>");
			 }
		  %>
          <td width="5%" align="center"><a href="<%=strhref%>?cw_id=<%=CW_ID%>&cw_status=<%=cw_status%>"><img class="hand" border="0" src="../../images/modi.gif" title="<%=strAct%>" WIDTH="16" HEIGHT="16"></a></td>
<%
    }
  %>
   </tr>

<%
}
else
{
  out.println("<tr><td colspan=50>无记录</td></tr>");
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