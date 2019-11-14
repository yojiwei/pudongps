<%@page contentType="text/html; charset=GBK"%>
<%@include file="/system/app/skin/head.jsp"%>
<%
  CMySelf self = (CMySelf)session.getAttribute("mySelf");

  String selfdtid = String.valueOf(self.getDtId());
  String sender_id = String.valueOf(self.getMyID());

  String cw_status = "";
  String cw_isopen = "";

  String strTitle = "";
  String strhref = "";
  String strAct = "";
  String deal_dtid = "";
  String deal_name = "";
  String wd_name = "";
  String str_sql = "";
  String cw_ygname = "";
  String cp_id = "";
  String status_lamp = "";


strTitle = "已处理信件";
strhref = "AppealInfo.jsp";
strAct = "查看";
  
//
CDataCn dCn = null;
CDataImpl dImpl = null;
try{
dCn = new CDataCn();
dImpl = new CDataImpl(dCn);
cw_isopen = CTools.dealString(request.getParameter("cw_isopen"));
if("".equals(cw_isopen)){
	cw_isopen = "1";
}
//

str_sql = "select c.cw_id, c.cp_id, c.cw_applyingname, c.cw_applieddept,c.cw_subject,to_char(c.cw_managetime, 'yyyy-mm-dd hh24:mi:ss') cw_managetime, c.cw_isovertime,c.cw_isovertimem,to_char(c.cw_applytime, 'yyyy-mm-dd hh24:mi:ss') cw_applytime, to_char(c.cw_finishtime, 'yyyy-mm-dd hh24:mi:ss') cw_finishtime,p.cp_timelimit,p.cp_timelimiting,c.cw_ygname,c.wd_id, 0 as pc_timelimit,c.cw_isopen,c.cw_ischeck FROM tb_connwork c,tb_connproc p WHERE p.cp_id in(select cp_id from tb_connproc where cp_id <> 'o11893' and (cp_upid='o7' or cp_upid = 'o10000')) and c.cp_id = p.cp_id and c.cw_status=3  and cw_applytime >to_date('2012-03-08','yyyy-MM-dd') ";
if(!"".equals(cw_isopen)){
	if("2".equals(cw_isopen)){
		str_sql += " and c.cw_isopen in(0,1)";
	}else{
		str_sql += " and c.cw_isopen="+cw_isopen+"";
	}
}
str_sql += " order by cw_applytime desc";

//out.println(str_sql);
  Vector vectorPage = dImpl.splitPage(str_sql,request,20);

%>
<!-- 记录日志 -->
<%
String logstrMenu = "信件审核列表";
String logstrModule = strTitle;
%>
<%@include file="/system/app/writelogs/WriteListLog.jsp"%>
<!-- 记录日志 -->

<%@include file="/system/app/skin/skin4/template/list_top.jsp"%>
<!--    模块名称开始    -->
<%=strTitle%>
<select name="ischeck" onchange="change(this.value)">
<option value="">请选择</option>
<option value="2" <%="2".equals(cw_isopen)?"selected":""%>>全部</option>
<option value="0" <%="0".equals(cw_isopen)?"selected":""%>>审核通过</option>
<option value="1" <%="1".equals(cw_isopen)?"selected":""%>>审核不通过</option>
</select>
<!--    模块名称结束    -->
<%@include file="/system/app/skin/skin4/template/list_function.jsp"%>                                                            
<!--    功能按钮开始    -->
<img src="/system/images/split.gif" align="middle" border="0" WIDTH="5" HEIGHT="8">
<input type="button" name="allrublish" value="审核通过" onclick="AllTG()"/>
<img src="/system/images/split.gif" align="middle" border="0" WIDTH="5" HEIGHT="8">
<input type="button" name="allrublish" value="审核不通过" onclick="AllBTG()"/>
<img src="/system/images/split.gif" align="middle" border="0" WIDTH="5" HEIGHT="8">
<img src="../../images/goback.gif" border="0" onclick="javascript:history.back();" title="返回" style="cursor:hand" align="absmiddle">

<script language="javascript">
//全选
function SelectAllCheck(a){
	o= document.getElementsByName(a);
	for(i=0;i<o.length;i++){
		o[i].checked=event.srcElement.checked;
	}
}
function change(val){
	window.location.href="AppealList.jsp?cw_status=3&cw_isopen="+val;
}
//置为审核通过
function AllTG(){
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
		alert("请您至少选择一条需要审核通过的记录!");
	}
	else
	{
		if(confirm("您确认审核通过？")){
			id=id.substring(0,id.length-1);
			formData.cwids.value=id;
			formData.cw_ispublish.value='0';
			document.formData.action="AppealOperate.jsp";
			document.formData.submit();
		}
	}
}
//置为不通过
function AllBTG(){
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
		alert("请您至少选择一条需要审核不通过的记录!");
	}
	else
	{
		if(confirm("您确认置为审核不通过？")){
			id=id.substring(0,id.length-1);
			formData.cwids.value=id;
			formData.cw_ispublish.value='1';
			document.formData.action="AppealOperate.jsp";
			document.formData.submit();
		}
	}
}

</script>

返回
<!--    功能按钮结束    -->
<%@include file="/system/app/skin/skin4/template/list_listtop.jsp"%>
<!--    列表开始    -->

<table class="FindAreaTable1" cellspacing="1" rules="cols" border="0" width="100%" id="ctl00_DataGrid_DataGrid1" style="border-width:0px;">
<tr class="bttn">
<td width="10%" class="outset-table"><input type="checkbox" name="checkbox" value="checkbox" onclick="SelectAllCheck('cw_ids')" />&nbsp;全选</td>
<td width="10%" class="outset-table">收信人</td>                       
<td width="30%" class="outset-table">主题</td>
<td width="11%" class="outset-table">发送时间</td>
<td width="10%" class="outset-table">办理完成时间</td>									
<td width="5%" class="outset-table" nowrap><%=strAct%></td>
</tr>
 <%
	out.print("<form name=\"formData\">");
   if(vectorPage!=null){
       for(int j=0;j<vectorPage.size();j++){
         Hashtable content = (Hashtable)vectorPage.get(j);
         String CW_ID = CTools.dealNull(content.get("cw_id"));
		 String cw_ischeck = CTools.dealNull(content.get("cw_ischeck"));
         if(j % 2 == 0)
           out.print("<tr class=\"line-even\">");
         else
           out.print("<tr class=\"line-odd\">");
  %>
        
          <td  align="center"><input type="checkbox" name="cw_ids" value="<%=CW_ID%>" /></td>
          <td  align="center" <%="1".equals(cw_ischeck)?"style=\"color:#666666\"":""%>><%=CTools.dealNull(content.get("cw_applyingname"))%></td>
		  <td align="center" <%="1".equals(cw_ischeck)?"style=\"color:#666666\"":""%>><%=CTools.dealNull(content.get("cw_subject")) %></td>
          <td align="center" <%="1".equals(cw_ischeck)?"style=\"color:#666666\"":""%>><%=CTools.dealNull(content.get("cw_applytime"))%></td>          
          <td  align="center" <%="1".equals(cw_ischeck)?"style=\"color:#666666\"":""%>><%=CTools.dealNull(content.get("cw_finishtime"))%></td>
          <td width="5%" align="center">
		   <a href="<%=strhref%>?cw_id=<%=CW_ID%>&cw_status=3">
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
<input type="hidden" name="cw_ispublish"/>
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