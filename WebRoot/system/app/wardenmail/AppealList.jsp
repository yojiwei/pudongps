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
  String wd_name = "";
  String str_sql = "";
  String cw_ygname = "";
  String cp_id = "";						//判定阳光信箱还是区长信箱
  String status_lamp = "";

  switch(intStatus)
  {
    case 1:
      strTitle = "待处理区长信件";
      strhref = "AppealInfo.jsp";
      strAct = "受理";
      break;
    case 2:
      strTitle = "处理中区长信件";
      strhref = "AppealInfo.jsp";
      strAct = "办理";
      break;
    case 3:
      strTitle = "已处理区长信件";
      strhref = "AppealInfo.jsp";
      strAct = "查看";
      break;
    case 8:
      strTitle = "协调中区长信件";
      strhref = "AppealInfo.jsp";
      strAct = "查看";
      break;
    case 9:
      strTitle = "垃圾信件";
      strhref = "AppealInfo.jsp";
      strAct = "查看";
      break;
	case 12:
		strTitle = "重复信件";
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
		str_sql = "select c.cw_id, c.cp_id, c.cw_appliedname, c.cw_applieddept,c.cw_subject,to_char(c.cw_managetime, 'yyyy-mm-dd hh24:mi:ss') cw_managetime, c.cw_isovertime,c.cw_isovertimem,to_char(c.cw_applytime, 'yyyy-mm-dd hh24:mi:ss') cw_applytime, to_char(c.cw_finishtime, 'yyyy-mm-dd hh24:mi:ss') cw_finishtime,p.cp_timelimit,p.cp_timelimiting, 20000 as dt_id, c.cw_ygname, c.wd_id, 0 as pc_timelimit FROM tb_connwork c, tb_deptinfo d,tb_connproc p WHERE (p.cp_id = 'o1' or p.cp_upid = 'o1') and c.cp_id = p.cp_id and c.cw_status="+cw_status ;
  }
  else {
    str_sql = "select c.cw_id,c.cp_id,c.cw_appliedname,c.cw_applieddept,c.cw_subject,to_char(c.cw_managetime,'yyyy-mm-dd hh24:mi:ss') cw_managetime,c.cw_isovertime,c.cw_isovertimem,to_char(c.cw_applytime,'yyyy-mm-dd hh24:mi:ss') cw_applytime,to_char(c.cw_finishtime,'yyyy-mm-dd hh24:mi:ss') cw_finishtime,p.cp_timelimit,p.cp_timelimiting,20000 as dt_id,c.cw_ygname,c.wd_id,0 as pc_timelimit FROM tb_connwork c,tb_deptinfo d,tb_connproc p WHERE (p.cp_id='o1'or p.cp_upid='o1') and c.cp_id=p.cp_id  and  c.cw_status='"+cw_status+"'";
	}
if(intStatus==3)
 str_sql = "select c.cw_id,c.cp_id,c.cw_appliedname,c.cw_status,c.cw_applieddept,c.cw_subject,to_char(c.cw_managetime,'yyyy-mm-dd hh24:mi:ss') cw_managetime,c.cw_isovertime,c.cw_isovertimem,to_char(c.cw_applytime,'yyyy-mm-dd hh24:mi:ss') cw_applytime,to_char(c.cw_finishtime,'yyyy-mm-dd hh24:mi:ss') cw_finishtime,p.cp_timelimit,p.cp_timelimiting,20000 as dt_id,c.cw_ygname,c.wd_id,0 as pc_timelimit FROM tb_connwork c,tb_deptinfo d,tb_connproc p WHERE (p.cp_id='o1'or p.cp_upid='o1') and c.cp_id=p.cp_id and (c.cw_status='3' or c.cw_status='18')";
if(intStatus==1)
    str_sql = "select c.cw_id,c.cp_id,c.cw_appliedname,c.cw_applieddept,c.cw_subject,to_char(c.cw_managetime,'yyyy-mm-dd hh24:mi:ss') cw_managetime,c.cw_isovertime,c.cw_isovertimem,to_char(c.cw_applytime,'yyyy-mm-dd hh24:mi:ss') cw_applytime,to_char(c.cw_finishtime,'yyyy-mm-dd hh24:mi:ss') cw_finishtime,p.cp_timelimit,p.cp_timelimiting,20000 as dt_id,c.cw_ygname,c.wd_id,0 as pc_timelimit FROM tb_connwork c,tb_deptinfo d,tb_connproc p WHERE (p.cp_id='o1'or p.cp_upid='o1') and c.cp_id=p.cp_id and c.cw_zhuanjiao = 3 and  c.cw_status='"+cw_status+"'";
 
 
  CRoleAccess ado = new CRoleAccess(dCn);
  if (!ado.isAdmin(sender_id)) {
  	str_sql += " and p.dt_id=" + selfdtid;
  }  
  
  str_sql += " and p.dt_id=d.dt_id";
  
  /*if (intStatus != 8&& intStatus!=3) {
   if(intStatus == 1)	{	 
	  str_sql += " union select c.cw_id,c.cp_id,c.cw_appliedname,c.cw_applieddept,c.cw_subject,to_char(c.cw_managetime,'yyyy-mm-dd hh24:mi:ss') cw_managetime,c.cw_isovertime,c.cw_isovertimem," +
				 "to_char(c.cw_applytime,'yyyy-mm-dd hh24:mi:ss') cw_applytime,to_char(c.cw_finishtime,'yyyy-mm-dd hh24:mi:ss') " +
				 "cw_finishtime,0 as cp_timelimit,0 as cp_timelimiting,20000 as dt_id,c.cw_ygname,c.wd_id,0 as pc_timelimit FROM tb_connwork c,tb_subject s where c.wd_id = s.sj_id and c.cp_id = 'mailYGXX' and c.cw_zhuanjiao = 3 and c.cw_status = " + cw_status;
	  }
	  else{
	str_sql += " union select c.cw_id,c.cp_id,c.cw_appliedname,c.cw_applieddept,c.cw_subject,to_char(c.cw_managetime,'yyyy-mm-dd hh24:mi:ss') cw_managetime,c.cw_isovertime,c.cw_isovertimem," +
				 "to_char(c.cw_applytime,'yyyy-mm-dd hh24:mi:ss') cw_applytime,to_char(c.cw_finishtime,'yyyy-mm-dd hh24:mi:ss') " +
				 "cw_finishtime,0 as cp_timelimit,0 as cp_timelimiting,20000 as dt_id,c.cw_ygname,c.wd_id,0 as pc_timelimit FROM tb_connwork c,tb_subject s where c.wd_id = s.sj_id and c.cp_id = 'mailYGXX' and c.cw_status = " + cw_status;
	  }
  }else if(intStatus == 3){
str_sql += " union select c.cw_id,c.cp_id,c.cw_appliedname,c.cw_status,c.cw_applieddept,c.cw_subject,to_char(c.cw_managetime,'yyyy-mm-dd hh24:mi:ss') cw_managetime,c.cw_isovertime,c.cw_isovertimem," +
  			 "to_char(c.cw_applytime,'yyyy-mm-dd hh24:mi:ss') cw_applytime,to_char(c.cw_finishtime,'yyyy-mm-dd hh24:mi:ss') " +
  			 "cw_finishtime,0 as cp_timelimit,0 as cp_timelimiting,20000 as dt_id,c.cw_ygname,c.wd_id,0 as pc_timelimit FROM tb_connwork c,tb_subject s where c.wd_id = s.sj_id and " + 
  			 "cp_id = 'mailYGXX' and (cw_status ='3' or cw_status='18')";
  }*/
			 
  str_sql += " order by cw_applytime desc";
  //out.print("str_sql============="+str_sql);
  Vector vectorPage = dImpl.splitPage(str_sql,request,20);

%>
<!-- 记录日志 -->
<%
String logstrMenu = "区长信件";
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
<%if(intStatus==1){%>
<input type="button" name="allrublish" value="置为垃圾信件" onclick="AllRublish()"/>
<img src="/system/images/split.gif" align="middle" border="0" WIDTH="5" HEIGHT="8">
<input type="button" name="allrublish" value="置为重复信件" onclick="AllChongfu()"/>
<img src="/system/images/split.gif" align="middle" border="0" WIDTH="5" HEIGHT="8">
<input type="button" name="allturnto" value="转交到信访办"  onclick="AllTurnto()"/>
<img src="/system/images/split.gif" align="middle" border="0" WIDTH="5" HEIGHT="8">
<%}%>
<img src="../../images/goback.gif" border="0" onclick="javascript:history.back();" title="返回" style="cursor:hand" align="absmiddle">

<script language="javascript">
//全选
function SelectAllCheck(a){
	o= document.getElementsByName(a);
	for(i=0;i<o.length;i++){
		o[i].checked=event.srcElement.checked;
	}
}
//置为垃圾信件
function AllRublish(){
	var id="";
	var sign = "false";
	var all=document.getElementsByName("cw_ids");
	for(i=0;i<all.length;i++){
		if(all[i].checked){
			sign = "true";
			id+=all[i].value+",";
		}
	}
	if(sign=="false")
	{
		alert("请您至少选择一条需要置为垃圾信件的记录!");
	}
	else
	{
		if(confirm("您确认置为垃圾信件？")){
			id=id.substring(0,id.length-1);
			formData.cwids.value=id;
			formData.operatetype.value='rublish';
			document.formData.action="AppealOperate.jsp";
			document.formData.submit();
		}
	}
}
//置为重复信件
function AllChongfu(){
	var id="";
	var sign = "false";
	var all=document.getElementsByName("cw_ids");
	for(i=0;i<all.length;i++){
		if(all[i].checked){
			sign = "true";
			id+=all[i].value+",";
		}
	}
	if(sign=="false")
	{
		alert("请您至少选择一条需要置为重复信件的记录!");
	}
	else
	{
		if(confirm("您确认置为重复信件？")){
			id=id.substring(0,id.length-1);
			formData.cwids.value=id;
			formData.operatetype.value='chongfu';
			document.formData.action="AppealOperate.jsp";
			document.formData.submit();
		}
	}
}
//转交到信访办
function AllTurnto(){
	var id="";
	var sign = "false";
	var all=document.getElementsByName("cw_ids");
	for(i=0;i<all.length;i++){
		if(all[i].checked){
			sign = "true";
			id+=all[i].value+",";
		}
	}
	if(sign=="false")
	{
		alert("请您至少选择一条需要转交到信访办的记录!");
	}
	else
	{
		id=id.substring(0,id.length-1);
		formData.cwids.value=id;
		formData.operatetype.value='turnto';
		document.formData.action="AppealOperate.jsp";
		document.formData.submit();
	}
}
</script>

返回
<!--    功能按钮结束    -->
<%@include file="/system/app/skin/skin4/template/list_listtop.jsp"%>
<!--    列表开始    -->

<table class="FindAreaTable1" cellspacing="1" rules="cols" border="0" width="100%" id="ctl00_DataGrid_DataGrid1" style="border-width:0px;">
<tr class="bttn">
  <%if(intStatus==1){%> <td width="10%" class="outset-table"><input type="checkbox" name="checkbox" value="checkbox" onclick="SelectAllCheck('cw_ids')" />&nbsp;全选</td><%}%>
<td width="10%" class="outset-table">收信人</td>                       
<td width="30%" class="outset-table">主题</td>
<td width="11%" class="outset-table">发送时间</td>
<% 
if(intStatus==3)
  out.print("<td width=\"10%\" class=\"outset-table\">办理完成时间</td><td width=\"10%\" class=\"outset-table\">处理状态</td>");
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
	out.print("<form name=\"formData\">");
   if(vectorPage!=null){
       for(int j=0;j<vectorPage.size();j++){
         Hashtable content = (Hashtable)vectorPage.get(j);
         String CW_ID = content.get("cw_id").toString();
         cp_id = content.get("cp_id").toString();
		 String isovertime = content.get("cw_isovertime").toString();
		 String isovertimem = content.get("cw_isovertimem").toString();
         if(intStatus==8){
           deal_dtid = content.get("dt_id").toString();
           if(!deal_dtid.equals("")){
             String sql_deal = "select dt_name from tb_deptinfo where dt_id=" + deal_dtid;
             Hashtable content_deal = dImpl.getDataInfo(sql_deal);
             deal_name = content_deal.get("dt_name").toString();
           }
         }
         if(j % 2 == 0)
           out.print("<tr class=\"line-even\">");
         else
           out.print("<tr class=\"line-odd\">");
  %>
        
            <%if(intStatus==1){%><td  align="center"><input type="checkbox" name="cw_ids" value="<%=CW_ID%>" /></td><%}%>
            <td  align="center">
		  <%
			 cw_ygname = content.get("cw_ygname").toString();
			 if(!cw_ygname.equals("")){
				out.println(cw_ygname);
			 }else{
			 		String st_wdname = "";
			 			//区长姓名
			 			//如果是阳光信箱，像是xx-阳光信箱
			 			if ("mailYGXX".equals(cp_id))
			    	st_wdname = "select sj_name as wd_name from tb_subject where sj_id ='"+content.get("wd_id")+"' ";
			    	else 
			    	st_wdname = "select wd_name from tb_warden where wd_id ='"+content.get("wd_id")+"' ";
						Hashtable ha_wdname = dImpl.getDataInfo(st_wdname);
						if(ha_wdname!=null){
			 			if ("mailYGXX".equals(cp_id)) 
						out.println(ha_wdname.get("wd_name") + "-阳光信箱");
						else 
						out.println(ha_wdname.get("wd_name"));
				}
			 }
		   %>		  </td>
		  <td align="center"><%=content.get("cw_subject") %></td>
          <td align="center"><%=content.get("cw_applytime")%></td>          
          <%
				if(intStatus==3){
				if(content.get("cw_status").toString().equals("18"))
				{
            out.print("<td  align=\"center\">" + content.get("cw_finishtime") + "</td><td  align=\"center\">" +"协调完成"+ "</td>");
				}
				else{
				out.print("<td  align=\"center\">" + content.get("cw_finishtime") + "</td><td  align=\"center\">" +"处理完成"+ "</td>");}
				}
            if(intStatus==8)
				out.print("<td align=\"center\">" + deal_name + "</td>");
          	if (intStatus == 1 || intStatus == 2 || intStatus == 8) {
          %>
          <td  align="center">
          <%if (intStatus == 1) 
          		out.println(content.get("cp_timelimit"));
          	else if (intStatus == 2) 
          		out.println(content.get("cp_timelimiting"));
          	else 
          		out.println(content.get("cp_timelimit"));
          %> 
          	天</td>
          <%
          	}
			
			//是否受理、办理超时
					TimeCalendar tc = new TimeCalendar();
					String cmailapplytime = content.get("cw_applytime").toString();
					String cmailid = content.get("cw_id").toString();
					String cmailisovertime = tc.getIsOverTime(cmailapplytime,cmailid,"isovertime");
				  
				   	if (cmailisovertime.equals("1")){
						out.print("<td align=\"center\"><span style=color:red>是</span></td>");
					 }
					 else{
						out.print("<td align=\"center\">否</td>");
					 }
				  	String cmailisovertimem = tc.getIsOverTime(cmailapplytime,cmailid,"isovertimem");
					 if (cmailisovertimem.equals("1")){
						out.print("<td align=\"center\"><span style=color:red>是</span></td>");
					 }
					 else{
						out.print("<td align=\"center\">否</td>");
					 }
		 //是否受理、办理超时
			
		 /*if (isovertime.equals("1")){
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
		 }*/ 
		 
		 
		 
          %>
		  
          <td width="5%" align="center">
		   <a href="<%=strhref%>?cw_id=<%=CW_ID%>&cw_status=<%=cw_status%>">
		      <img class="hand" border="0" src="../../images/modi.gif" title="<%=strAct%>" WIDTH="16" HEIGHT="16"></a></td></tr>
<%
    }

   }
   else
   {
     out.print("<tr><td colspan=7>无记录</td></tr>");
   }

%>
<input type="hidden" name="cwids"/>
<input type="hidden" name="operatetype"/>
</form>
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