<%@page contentType="text/html; charset=GBK"%>
<%@include file="/system/app/skin/head.jsp"%>
<style>
.topic
{
        color:#333399;
        font-weight:bold;
}

.title_on
{
        border-left:1px solid #A2A2A2;
        border-right:1px solid #A2A2A2;
        border-top:4px solid #A2A2A2;
        font-weight:bold;
        height:26;
        width:100;
}
.title_down
{
        border-left:1px solid #A2A2A2;
        border-right:1px solid #A2A2A2;
        border-top:3px solid #C8C8C8;
        border-bottom:1px solid #A2A2A2;
        background-color:#A2A2A2;
        font-weight:bold;
        cursor:hand;
        color:#FFFFFF;
        height:22;
        width:100;
}

.title_mi
{
        border-bottom:1px solid #A2A2A2;
        background-color:white;
}
.mytr
{
        height:18;
}
.removableObj
{
        height:25;
        position:relative;
        border:1px solid #FFFFFF;
        cursor:move;
}
.disremovableObj
{
        height:25;
        position:relative;
        border:1px solid #99CCFF;
        cursor:move;
}
.addObj
{
        height:25;
        position:relative;
        border:1px solid #FFFFFF;
        border-bottom:2px dashed #CC3366;
        cursor:move;
}
</style>
<%
String strTitle = "信息审核";
String divName = "";
String status = "";
String strPage = "";
//
String sj_id="";//栏目id
String selDt_id = "";//部门id
String dt_id   = "";
String dt_name = "";
String dtSql   = "";
String isadmin = "";
//
String subjectCode="";
String infoPage = "";
String strSql = "";
String uiid="";
//
String aa="";
String sm_detail = "";
String sm_con = "";
String sj_name = "";
String sm_sendtime = "";
String sm_id = "";
String sm_sj_id = "";

CDataCn dCn = null;
CDataImpl dImpl = null;
Vector vectorPage = null;
try{
dCn = new CDataCn();
dImpl = new CDataImpl(dCn);

  divName = CTools.dealString(request.getParameter("divName"));
  status = CTools.dealString(request.getParameter("status"));
  strPage = CTools.dealString(request.getParameter("strPage"));
  divName=divName.equals("")?"summarize":divName;
  status=status.equals("")?"1":status;
  strPage=status.equals("")?"1":strPage;
  
  //
  sj_id = CTools.dealNumber(request.getParameter("sj_id")).trim();
	selDt_id = CTools.dealString(request.getParameter("dt_id")).trim();
	isadmin = CTools.dealString(request.getParameter("isadmin")).trim();
	subjectCode=CTools.dealString(request.getParameter("subjectCode")).trim();
	/*得到当前登陆的用户id  开始*/
	CMySelf myProject = (CMySelf)session.getAttribute("mySelf");
	if(myProject!=null && myProject.isLogin())
	{
	  uiid = Long.toString(myProject.getMyID());
	}
	else
	{
	  uiid= "2";
	}
	
strSql="select s.sm_id,s.sm_sj_id,s.sm_con,s.sm_detail,s.sm_sendtime, d.dt_name, j.sj_name from  tb_sms s,tb_deptinfo d,tb_subject j where s.sm_dtid = d.dt_id and s.sm_sj_id = j.sj_id and s.sm_check = "+status+" and s.sm_flagtoo = 10 and s.sm_flag <> 4 and s.sm_tel is null order by s.sm_id desc, s.sm_sendtime desc";

vectorPage =dImpl.splitPage(strSql,request,18); 
%>
<script language='javascript'>
function ChangeC(layerid,status,page)
{
	document.location.href="message.jsp?divName=" + layerid + "&status=" + status + "&strPage=" + page;
}
</script>
<%@include file="/system/app/skin/skin4/template/list_top.jsp"%>
<!--    模块名称开始    -->
<%=strTitle%>
<!--    模块名称结束    -->
<%@include file="/system/app/skin/skin4/template/list_function.jsp"%>                                                    
<!--    功能按钮开始    -->

<!--    功能按钮结束    -->
<%@include file="/system/app/skin/skin4/template/list_listtop.jsp"%>                         
<!--    列表开始    -->
<table width="100%" cellspacing="0" cellpadding="0">
  <tr>
    <td valign="bottom" width="100">
    <table cellspacing="0" cellpadding="0">
    <tr>
    <td id="summarize_bt" <%if(divName.equals("summarize")) out.println("class=\"title_on\""); else out.println("class=\"title_down\"");%> align="center" onClick="javascript:ChangeC('summarize','1','1');">待审核</td>
     </tr>
    </table>
    </td>
    <td width="2" class="title_mi"></td>
      <td valign="bottom" width="100">
              <table cellspacing="0" cellpadding="0">
                      <tr>
      <td id="baseinfo_bt" align="center" <%if(divName.equals("baseinfo")) out.println("class=\"title_on\""); else out.println("class=\"title_down\"");%> onClick="javascript:ChangeC('baseinfo','2','1');">已审核</td>
                      </tr>
              </table>
      </td>
      <td width="2" class="title_mi">　</td>
      <td valign="bottom" width="100">
              <table cellspacing="0" cellpadding="0">
                      <tr>
       <td id="nosubmit_bt" align="center" <%if(divName.equals("nosubmit")) out.println("class=\"title_on\""); else out.println("class=\"title_down\"");%> onClick="javascript:ChangeC('nosubmit','3','1');">审核不通过</td>
                      </tr>
              </table>
      </td>
      <td align="right">
<input type="button" border="0" onClick="GetAllSelect();" value="批处理审核通过" style="cursor:hand" align="absmiddle">
<input type="button" border="0" onClick="GetNoneSelect();" value="批处理审核不通过" style="cursor:hand" align="absmiddle">
</td>
 </tr>
</table>
</td>
</tr>
<tr>
  <td width="100%" id="pending">
<table class="FindAreaTable1" cellspacing="1" rules="cols" border="0" id="ctl00_DataGrid_DataGrid1" style="border-width:0px;">
<form name="formData" method="post">
<tr class="bttn">
  <td width="44%" class="outset-table">短信内容</td>
  <td width="20%" class="outset-table">发布部门</td>
  <td width="15%" class="outset-table">所属栏目</td>
  <td width="13%" class="outset-table" nowrap>发布日期</td>
	<td width="13%" class="outset-table" nowrap>编辑</td>
	<%if(!status.equals("2")){%>
	<td  class="outset-table">
		<input type="checkbox"   onclick="javascript:SelectAllCheck('checkbox1')"></td>
	<%}else{%>
	<td width="13%" class="outset-table" nowrap>操作</td>
	<%}%>
</tr>
<%
  if(vectorPage!=null)
  {
    for(int j=0;j<vectorPage.size();j++)
    {
      Hashtable content = (Hashtable)vectorPage.get(j);
		  
		  sm_detail = CTools.dealNull(content.get("sm_detail"));
		  sm_con = CTools.dealNull(content.get("sm_con"));
		  dt_name = CTools.dealNull(content.get("dt_name"));
		  sj_name = CTools.dealNull(content.get("sj_name"));
		  sm_sendtime = CTools.dealNull(content.get("sm_sendtime"));
		  sm_id = CTools.dealNull(content.get("sm_id"));
		  sm_sj_id = CTools.dealNull(content.get("sm_sj_id"));
		  
		  if(sm_detail.equals("")){
				aa="1";
		  }else{
				aa="2";
	  	}
      if(j % 2 == 0)  out.print("<tr class=\"line-even\">");
      else out.print("<tr class=\"line-odd\">");
%>
	<td align="left">
	<img border="0" src="/system/images/arrow_yellow.gif" WIDTH="15" HEIGHT="13">&nbsp;<%=sm_con%></td>
		<td align="center"><%=dt_name%></td>
		<td align="center"><%=sj_name%></td>
		<td align="center"><%=sm_sendtime%></td>
		<td align="center"><img class="hand" border="0" src="images/dialog/modi.gif" WIDTH="16" HEIGHT="16" onclick="editMessage(<%=sm_id%>,<%=aa%>)" alt="编辑"></td>
		<%if(!status.equals("2")){%>
		<td align="center">
		<input type="hidden" name="sm_sj_id" value="<%=sm_sj_id%>"/>
		<input type="hidden" name="sm_con" value="<%=sm_con%>"/>
		<input name="checkbox1" type="checkbox" value="<%=sm_id%>"/>
		</td>
		<%
		}else{
		%>
		<td>
		<a href="SelectList.jsp?sm_id=<%=sm_id%>&sm_sj_id=<%=sm_sj_id%>">查看发送情况</a>
		</td>
		<%}%>
		</tr>
<%
    }
    }
%>
<input type="hidden"  name="ct_id" >
<INPUT type="hidden" name="tcStatus" value="0">
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
<script>
function editMessage(id,aa)
{
	window.location.href="messageEdit.jsp?sm_id="+id+"&aa="+aa+"";
}
//批处理审核通过
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
		alert("请您至少选择一条需要批处理的记录!");
	}
	else
	{
		id=id.substring(0,id.length-1);
		formData.ct_id.value=id;
		document.formData.action="messageResult.jsp";
		document.formData.submit();
	}
}
//批处理审核不通过
function GetNoneSelect(){
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
		alert("请您至少选择一条需要批处理的记录!");
	}
	else
	{
		id=id.substring(0,id.length-1);
		formData.ct_id.value=id;
		document.formData.action="messageResult.jsp?id=1";
		document.formData.submit();
	}
}
//全选
function SelectAllCheck(a){
	o= document.getElementsByName(a);
	for(i=0;i<o.length;i++){
		o[i].checked=event.srcElement.checked;
	}
}
</script>