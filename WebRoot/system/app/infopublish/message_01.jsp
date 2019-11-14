<%@page contentType="text/html; charset=GBK"%>
<%@ page import="com.beyondbit.web.publishinfo.Messages" %>
<%
String strTitle = "信息审核";
%>
<script language='javascript'>
function ChangeC(layerid,status,page)
{
	document.location.href="message.jsp?divName=" + layerid + "&status=" + status + "&strPage=" + page;
}

function AllChange(layerid)
{
        var obj=new Array("baseinfo_bt","summarize_bt","nosubmit_bt");
        for(i = 0;i<obj.length;i++)
        {
                if(obj[i]==layerid)
                {
                        eval(obj[i]+".className='title_on';");
                }
                else
                {
                        eval(obj[i]+".className='title_down';");
                }
        }
}

function ShowLayer(layerid)
{
        var layerobj=new Array("baseinfo","summarize","nosubmit");
        for(i=0;i<layerobj.length;i++)
        {
                if(layerobj[i]==layerid)
                {
                        eval("document.all."+layerid+".style.display='';");
                }
                else
                {
                        eval("document.all."+layerobj[i]+".style.display='none';");
                }
        }
}

var objhttpPending=new ActiveXObject("Msxml2.XMLHTTP");

function getPending(status,page)
        {
        var objxmlPending
        pending.innerHTML="数据加载中，请稍候...";
         objxmlPending=new ActiveXObject("Microsoft.XMLDOM");
        strA = "abc"
        objhttpPending.Open("post","<%=Messages.getString("xmlHttp")%>/system/app/subpublish/listCheckLayer.jsp?status=" + status + "&strPage=" + page,true);
        objhttpPending.setRequestHeader("Content-Length",strA.length);
        objhttpPending.setRequestHeader("CONTENT-TYPE","application/x-www-form-urlencoded");
        objhttpPending.onreadystatechange = getRunPending;
        objhttpPending.Send(strA);
        }

        function getRunPending()
        {
                var statePending = objhttpPending.readyState;
            if (statePending == 4)
            {
                    pending.innerHTML = objhttpPending.responsetext;
                }
        }

</script>

<%@ include file="../skin/head.jsp"%>

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
        String divName = CTools.dealString(request.getParameter("divName"));
        String status = CTools.dealString(request.getParameter("status"));
        String strPage = CTools.dealString(request.getParameter("strPage"));

        divName=(divName.equals(""))?"summarize":divName;
        status=(status.equals(""))?"1":status;
        strPage=(status.equals(""))?"1":strPage;

%>

<table class="main-table" width="100%">

        <tr class="title1" width="100%">
                <td colspan="9" align="center" style="position:relative"><%=strTitle%></td>
        </tr>
        <tr>
                <td>
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
				<%//}else{%>
				<!--div style="position:absolute;right:16px;top:37px"><img src="../../images/menu_changedept.gif " border="0" onClick="GetAllDelete();" title="批处理删除" style="cursor:hand" align="absmiddle"></div-->
				<%//}%></td>
                                </tr>
                        </table>
                </td>
        </tr>

        <tr>
                  <td width="100%" id="pending">
                       <%
CDataCn dCn = new CDataCn(); //新建数据库连接对象
CDataImpl dImpl = new CDataImpl(dCn); //新建数据接口对象

String sj_id="";//栏目id
sj_id=CTools.dealNumber(request.getParameter("sj_id")).trim();
String selDt_id = "";//部门id
selDt_id = CTools.dealString(request.getParameter("dt_id")).trim();
String dt_id   = "";
String dt_name = "";
String dtSql   = "";
String isadmin = CTools.dealString(request.getParameter("isadmin"));


/*得到当前登陆的用户id  开始*/
String uiid="";
CMySelf myProject = (CMySelf)session.getAttribute("mySelf");
if(myProject!=null && myProject.isLogin())
{
  uiid = Long.toString(myProject.getMyID());
}
else
{
  uiid= "2";
}


/*生成栏目列表  开始*/
String subjectCode="";
subjectCode=CTools.dealString(request.getParameter("subjectCode")).trim();
String infoPage = "";
String strSql = "";
strSql="  select s.*, d.dt_name, j.sj_name from tb_sms s,tb_deptinfo d,tb_subject j where s.sm_dtid = d.dt_id and s.sm_sj_id = j.sj_id and s.sm_check = "+status+" and s.sm_flagtoo = 10 and s.sm_flag <> 4 and s.sm_tel is null order by s.sm_id desc, s.sm_sendtime desc";

Vector vectorPage =dImpl.splitPage(strSql,request,18); //dImpl.getAllPage(strSql);
%>

<table class="content-table" width="100%">
<form name="formData" method="post">
        <tr class="bttn">
            <td width="44%" class="outset-table">短信内容</td>
            <td width="20%" class="outset-table">发布部门</td>
            <td width="15%" class="outset-table">所属栏目</td>
            <td width="13%" class="outset-table" nowrap>发布日期</td>
			<td width="13%" class="outset-table" nowrap>编辑</td>
			<%if(!status.equals("2")){%>
			<td  class="outset-table"><input type="checkbox"   onclick="javascript:SelectAllCheck('checkbox1')"></td>
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
      if(j % 2 == 0)  out.print("<tr class=\"line-even\">");
      else out.print("<tr class=\"line-odd\">");
%>
          <tr>
<td ><img border="0" src="/system/images/arrow_yellow.gif" WIDTH="15" HEIGHT="13">&nbsp;<%=content.get("sm_con")%></td>
                <td align="center"><%=content.get("dt_name")%></td>
                <td align="center"><%=content.get("sj_name")%></td>
                <td align="center"><%=content.get("sm_sendtime")%></td>
                <td align="center"><img class="hand" border="0" src="images/dialog/modi.gif" WIDTH="16" HEIGHT="16" onclick="editMessage(<%=content.get("sm_id")%>)" alt="编辑"></td>
				<%if(!status.equals("2")){%>
				<td align="center">
				<input type="hidden" name="sm_sj_id" value="<%=content.get("sm_sj_id")%>" />
				<input type="hidden" name="sm_con" value="<%=content.get("sm_con")%>" />
				<input name="checkbox1" type="checkbox" value="<%=content.get("sm_id")%>"/>
				</td>
				<%
				}else{
				%>
				<td>
				<a href="SelectList.jsp?sm_con=<%=content.get("sm_con")%>&sm_sj_id=<%=content.get("sm_sj_id")%>">查看发送情况</a>
				</td>
				<%}%>
          </tr>

<%
    }
%>
<input type="hidden"  name="ct_id" >
<INPUT type="hidden" name="tcStatus" value="0">
</form>
<%
      out.println("<tr><td colspan=7>" + dImpl.getTail(request) + "</td></tr>"); //输出尾部文件
  }
  else
  {
    out.println("<tr><td colspan=7>没有记录！</td></tr>");
  }
%>
</table>

<%
  dImpl.closeStmt();
  dCn.closeCn();
%>
        </td>
    </tr>
</table>
<%@ include file="../skin/bottom.jsp"%>
<script>
function editMessage(id)
{
	window.location.href="messageEdit.jsp?sm_id="+id+"";
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


function GetAllDelete(){
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
		document.formData.action="messageDel.jsp";
		document.formData.submit();
	}
}

function SelectAllCheck(a){
	o= document.getElementsByName(a);

	for(i=0;i<o.length;i++){
		o[i].checked=event.srcElement.checked;
	}
}
</script>