<%@page contentType="text/html; charset=GBK"%>
<%
CMySelf self = (CMySelf)session.getAttribute("mySelf");
String selfdtid = String.valueOf(self.getDtId());
String sender_id = String.valueOf(self.getMyID());

String cw_status = CTools.dealString(request.getParameter("cw_status")).trim();
String mailkind_get = CTools.dealString(request.getParameter("mailkind")).trim();
String sqlWhere = "";
if (!"".equals(mailkind_get)) {
	sqlWhere = " and cw_subject = '金点子信箱:"+mailkind_get+"' ";
}
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
  strTitle = "待处理信件";
  strhref = "AppealInfo.jsp";
  strAct = "受理";
  break;
case 2:
  strTitle = "处理中信件";
  strhref = "AppealInfo.jsp";
  strAct = "办理";
  break;
case 3:
  strTitle = "已处理信件";
  strhref = "AppealInfo.jsp";
  strAct = "查看";
  break;
case 8:
  strTitle = "协调中信件";
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

%>
<%@include file="/system/app/skin/head.jsp"%>
<%
//update20080122

CDataCn dCn=null;   //新建数据库连接对象
CDataImpl dImpl=null;  //新建数据接口对象

try {
 dCn = new CDataCn(); 
 dImpl = new CDataImpl(dCn); 

if(intStatus==8)
 {
  str_sql="select c.cw_id,c.cp_id,c.cw_applyingname,c.cw_applyingdept,c.cw_trans_id,p.dt_id,c.cw_subject,to_char(c.cw_managetime,'yyyy-mm-dd hh24:mi:ss') cw_managetime,c.cw_isovertime,c.cw_isovertimem,to_char(c.cw_applytime,'yyyy-mm-dd hh24:mi:ss') cw_applytime,to_char(c.cw_finishtime,'yyyy-mm-dd hh24:mi:ss') cw_finishtime,p.cp_timelimit,p.cp_timelimiting from tb_connwork c,tb_deptinfo d,tb_connproc p where  p.cp_id='o11000' and c.cp_id=p.cp_id and c.cw_status=" + cw_status + sqlWhere;
 }
else
 str_sql="select c.cw_id,c.cp_id,c.cw_applyingname,c.cw_applyingdept,c.cw_subject,to_char(c.cw_managetime,'yyyy-mm-dd hh24:mi:ss') cw_managetime,c.cw_isovertime,c.cw_isovertimem,to_char(c.cw_applytime,'yyyy-mm-dd hh24:mi:ss') cw_applytime,to_char(c.cw_finishtime,'yyyy-mm-dd hh24:mi:ss') cw_finishtime,p.cp_timelimit,p.cp_timelimiting from tb_connwork c,tb_deptinfo d,tb_connproc p where p.cp_id='o11000' and c.cp_id=p.cp_id and c.cw_status=" + cw_status + sqlWhere;

  CRoleAccess ado = new CRoleAccess(dCn);
  if (!ado.isAdmin(sender_id)) {
  	str_sql += " and p.dt_id=" + selfdtid;
  }  
  
  str_sql += " and p.dt_id=d.dt_id order by cw_applytime desc";
//   out.println(str_sql);  
 //if(true)return;
Vector vectorPage = dImpl.splitPage(str_sql,request,20);


%>
 <table class="main-table" width="100%" >
 <tr>
  <td width="100%">
       <table class="content-table" width="100%">
                <tr class="title1">
                        <td colspan="9" align="center">
                                <table WIDTH="100%" BORDER="0" CELLSPACING="1" CELLPADDING="1">
									<form name="formData" method="post" action="AppealList.jsp">
									<input type="hidden" id="mailkind" name="mailkind" value="">
									<input type="hidden"  name="cw_id" >
									<input type="hidden" name="cw_status" value="<%=cw_status%>">
                                        <tr>
                                                <td valign="center" width="120"> <select name="pr_name" class="input-mailBox" onchange="javascript:gl(this);">
													<option value="">所有类别</option>
													<option value="经济发展" <%if (mailkind_get.equals("经济发展")) out.println(" selected");%>>经济发展</option>
													<option value="城市建设" <%if (mailkind_get.equals("城市建设")) out.println(" selected");%>>城市建设</option>
													<option value="市容环境" <%if (mailkind_get.equals("市容环境")) out.println(" selected");%>>市容环境</option>
													<option value="教育医疗" <%if (mailkind_get.equals("教育医疗")) out.println(" selected");%>>教育医疗</option>
													<option value="社会管理" <%if (mailkind_get.equals("社会管理")) out.println(" selected");%>>社会管理</option>
													<option value="就业保障" <%if (mailkind_get.equals("就业保障")) out.println(" selected");%>>就业保障</option>
													<option value="政府改革" <%if (mailkind_get.equals("政府改革")) out.println(" selected");%>>政府改革</option>
													<option value="科技创新" <%if (mailkind_get.equals("科技创新")) out.println(" selected");%>>科技创新</option>
													</select>
													</td >
                                                <td valign="center"><%=strTitle%></td >
												  <td valign="center" align="right" nowrap width="40">
                                                        <img src="../../images/split.gif" align="middle" border="0" WIDTH="5" HEIGHT="8">
                                                   <img src="../../images/menu_pullout.gif " border="0" onclick="GetAllSelect();" title="导出到word" style="cursor:hand" align="absmiddle">
											    </td>
                                                <td valign="center" align="right" nowrap width="40">
                                                        <img src="../../images/split.gif" align="middle" border="0" WIDTH="5" HEIGHT="8">
                                                        <img src="../../images/goback.gif" border="0" onclick="javascript:history.back();" title="返回" style="cursor:hand" align="absmiddle">
                                                        <img src="../../images/split.gif" align="middle" border="0" WIDTH="5" HEIGHT="8">
                                                </td>
                                        </tr>
									</form>
                                </table>
                        </td>
                </tr>
                <tr class="bttn">                       
                        <td width="10%" class="outset-table">发信人</td >                       
                        <td width="30%" class="outset-table">主题</td>
                        <td width="11%" class="outset-table">发送时间</td>
                     <%
					// 	if(intStatus!=1 && intStatus != 8)
					//	 	out.print("<td width=\"11%\" class=\"outset-table\">受理时间</td>");
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
						<td width="3%" class="outset-table"><input type="checkbox"   onclick="javascript:SelectAllCheck('checkbox1')"></td>
                </tr>
 <%
if(vectorPage!=null)
{
  try
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
			//if(intStatus!=1)
           //  out.print("<td  align=\"center\">" + content.get("cw_managetime") + "</td>");
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
          		//out.println(content.get("pc_timelimit"));
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
          <td width="5%" align="center"><a href="<%=strhref%>?cw_id=<%=CW_ID%>&cw_status=<%=cw_status%>"><img class="hand" border="0" src="../../images/modi.gif" title="<%=strAct%>" WIDTH="16" HEIGHT="16"></a>
		  </td>
		  
         <td width="3%" class="outset-table"align="center"><input name="checkbox1" type="checkbox" value="<%=CW_ID%>">
		 </td>
<%
    }
  %>
   </tr>

<%/*分页的页脚模块*/
   out.println("<tr><td colspan=7>" + dImpl.getTail(request) + "</td></tr>"); //输出尾部文件
}
catch(Exception e)
{
   out.println(e);
}
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

<script language="javascript">
	function gl(tt) 
	{
		var form = document.formData;
		form.mailkind.value=tt.value;
		form.submit();
	}

/*function unload_word(){
 var url=location.href;
 for (s=0;s<document.sForm.checkdel.length();s++)
	if (document.sForm.checkdel.checked)
	{
  document.sForm.checkdel.checked += ","+"document.sForm.checkdel.value()";
	}
	document.sForm.cw_id.value = document.sForm.checkdel.checked;
}
 //document.sForm.pages.value=document.getElementById("contents").innerHTML;
 //alert(document.sForm.pages.value);
 document.sForm.action="unload_word.jsp";
 document.sForm.submit();
 document.sForm.action="unload_word.jsp";
 document.sForm.submit();
}*/
function GetAllSelect(){
	var id="";
	var sign = "false";
	var all=document.getElementsByName("checkbox1");
	for(i=0;i<all.length;i++){
		if(all[i].checked){
			sign = "true";
			id+=all[i].value+",";
		}
	}
	if(sign=="false")
	{
		alert("请您至少选择一条需要导出的记录!");
	}
	else
	{
		id=id.substring(0,id.length-1);
	//	alert(id);
		formData.cw_id.value=id;
		document.formData.action="unload_word.jsp";
		document.formData.submit();
	}
}
function SelectAllCheck(a){
	o= document.getElementsByName(a);

	for(i=0;i<o.length;i++){
		o[i].checked=event.srcElement.checked;
	}
}
//	if(id){
//		id=id.substring(0,id.lastIndexOf(',')-1);
//		formData.cw_id.value=id;
//		document.formData.action="unload_word.jsp";
//		document.formData.submit();
//	}else{
//		alert("请至少选择一个记录！");
//	}
//}
</script>