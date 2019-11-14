<%@page contentType="text/html; charset=GBK"%>
<%@ page import="com.beyondbit.web.publishinfo.Messages" %>
<%
String strTitle = "信息审批";
%>
<script language='javascript'>
function ChangeC(layerid,status,page)
{
   document.location.href="publishShePiList.jsp?divName=" + layerid + "&status=" + status + "&strPage=" + page;
}

function AllChange(layerid)
{
        var obj=new Array("baseinfo_bt","summarize_bt","cancelinfo_bt");
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
        var layerobj=new Array("baseinfo","summarize");
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
//全选	
function SelectAllCheck(a){
	o= document.getElementsByName(a);

	for(i=0;i<o.length;i++){
		o[i].checked=event.srcElement.checked;
	}
}
//批审批通过
function EaaAllSelect(){
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
		formData.cp_id.value=id;
		document.formData.action="EaaResult.jsp";
		document.formData.submit();
	}
}
//批审批删除
function DeleteAllSelect(cp_type){
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
		formData.cp_id.value=id;
		document.formData.action="PiResult.jsp";
		document.formData.submit();
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
        /*cursor:hand;*/
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
        status=(status.equals(""))?"unchecked":status;
        strPage=(status.equals(""))?"1":strPage;

%>

<table class="main-table" width="100%">

        <tr class="title1" width="100%">
                <td colspan="9" align="center"><%=strTitle%></td>
        </tr>
        <tr>
                <td>
                         <table width="100%" cellspacing="0" cellpadding="0">
                                <tr>
                                        <td valign="bottom" width="100">
                                                <table cellspacing="0" cellpadding="0">
                                                        <tr>
                                                                <td id="summarize_bt" <%if(divName.equals("summarize")) out.println("class=\"title_on\""); else out.println("class=\"title_down\"");%> align="center" onclick="javascript:ChangeC('summarize','unchecked','1');">待审批</td>
                                                        </tr>
                                                </table>
                                        </td>
                                        <td width="2" class="title_mi">　</td>
                                        <td valign="bottom" width="100">
                                                <table cellspacing="0" cellpadding="0">
                                                        <tr>
                                                                <td id="baseinfo_bt" align="center" <%if(divName.equals("baseinfo")) out.println("class=\"title_on\""); else out.println("class=\"title_down\"");%> onclick="javascript:ChangeC('baseinfo','checked','1');">已审批</td>
                                                        </tr>
                                                </table>
                                        </td>
                                        <td width="2" class="title_mi">　</td>
                                        <td valign="bottom" width="100">
                                                <table cellspacing="0" cellpadding="0">
                                                        <tr>
                                                                <td id="cancelinfo_bt" align="center" <%if(divName.equals("cancelinfo")) out.println("class=\"title_on\""); else out.println("class=\"title_down\"");%> onclick="javascript:ChangeC('cancelinfo','checked','1');">已取消</td>
                                                        </tr>
                                                </table>
                                        </td>


                                        <td class="title_mi" align="right"><%if(divName.equals("summarize")){%><input type="button" border="0" onClick="EaaAllSelect();" value="批处理审批通过" style="cursor:hand" align="absmiddle">&nbsp;<%}%><input type="button" border="0" onClick="DeleteAllSelect();" value="批处理删除" style="cursor:hand" align="absmiddle">&nbsp;全选<input type="checkbox"   onclick="javascript:SelectAllCheck('checkbox1')">&nbsp;&nbsp;</td>
                                </tr>
                        </table>
                </td>
        </tr>

        <tr>
                  <td width="100%" id="pending">
                       <%
//update20081104

CDataCn dCn=null;   //新建数据库连接对象
CDataImpl dImpl=null;  //新建数据接口对象

try {
 dCn = new CDataCn(); 
 dImpl = new CDataImpl(dCn); 

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

/*得到当前登陆的用户id  结束*/

/*生成栏目列表  开始*/
String subjectCode="";
subjectCode=CTools.dealString(request.getParameter("subjectCode")).trim();
String infoPage = "";
String strSql = "";
int checkStatus=0;

if(divName.equals("summarize"))
{
  infoPage = "PublishEditShenPi.jsp?OPType=ShenPi";
  checkStatus = 0;
  strSql = "select distinct s.SJ_NAME,t.ct_id,t.ct_create_time,t.ct_title,t.dt_id,t.ct_sequence,t.sj_id,d.dt_name, d.dt_id ,ct.cp_id as cp_id from tb_content t,tb_subject s,tb_deptinfo d,tb_contentpublish ct where t.dt_id=d.dt_id and s.sj_id=ct.sj_id and ct.ct_id=t.ct_id  and  ct.AUDIT_STATUS=1 and ct.CHECK_STATUS="+checkStatus+" order by to_date(t.ct_create_time,'YYYY-MM-DD') desc,t.ct_id desc ";
}
else if(divName.equals("baseinfo"))
{
  infoPage = "PublishEditShenPi.jsp?OPType=ShenPiEdit";
  checkStatus = 1;
  strSql = "select distinct s.SJ_NAME,t.ct_id,t.ct_create_time,t.ct_title,t.dt_id,t.ct_sequence,t.sj_id,d.dt_name, d.dt_id,ct.cp_id as cp_id from tb_content t,tb_subject s,tb_deptinfo d,tb_contentpublish ct where t.dt_id=d.dt_id and s.sj_id=ct.sj_id and ct.ct_id=t.ct_id  and  ct.AUDIT_STATUS=1 and ct.CHECK_STATUS="+checkStatus+" and ct.CP_ISPUBLISH=1 order by t.ct_id desc,to_date(t.ct_create_time,'YYYY-MM-DD') desc";
}
else if(divName.equals("cancelinfo"))
{
  infoPage = "PublishEditShenPi.jsp?OPType=ShenPiCancel";
  checkStatus = 1;
  strSql = "select distinct s.SJ_NAME,t.ct_id,t.ct_create_time,t.ct_title,t.dt_id,t.ct_sequence,t.sj_id,d.dt_name, d.dt_id ,ct.cp_id as cp_id from tb_content t,tb_subject s,tb_deptinfo d,tb_contentpublish ct where t.dt_id=d.dt_id and s.sj_id=ct.sj_id and ct.ct_id=t.ct_id  and  ct.AUDIT_STATUS=1 and ct.CHECK_STATUS=1 and ct.CP_ISPUBLISH=0 order by to_date(t.ct_create_time,'YYYY-MM-DD') desc,t.ct_id desc ";
}


Vector vectorPage = dImpl.splitPage(strSql,request,20);
%>
<table class="content-table" width="100%">
<form name="formData">
        <tr class="bttn">
            <td width="38%" class="outset-table">信息主题</td>
            <td width="12%" class="outset-table">栏目</td>
            <td width="10%" class="outset-table">发布日期</td>
            <td width="8%" class="outset-table">部门</td>
            <td width="8%" class="outset-table" nowrap>操作</td>
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

                <td ><img border="0" src="/system/images/arrow_yellow.gif" WIDTH="15" HEIGHT="13">&nbsp;<a href="<%=infoPage%>?checkStatus=<%=checkStatus%>&OPType=Edit&ct_id=<%=content.get("ct_id")%>&subjectCode=<%=subjectCode%>"><%=content.get("ct_title")%></a></td>
                <td align=center><%=content.get("sj_name")%></td>
                <td align="center"><%=content.get("ct_create_time")%></td>
                <td align="center"><%=content.get("dt_name")%></td>
                <td align="center"><a href="<%=infoPage%>&checkStatus=<%=checkStatus%>&ct_id=<%=content.get("ct_id")%>&subjectCode=<%=subjectCode%>&curpage=<%=CTools.dealNumber(request.getParameter("strPage"))%>"><img class="hand" border="0" src="/system/images/modi.gif" title=审批 WIDTH="16" HEIGHT="16"></a>
				
								<a href="javascript:delcontent('<%=content.get("ct_id")%>');">
								<img class="hand" border="0" src="../../images/delete.gif" title="删除" WIDTH="16" HEIGHT="16" onclick="return window.confirm('确认要删除该记录么?');"></a>
								<input name="checkbox1" type="checkbox" value="<%=content.get("cp_id")%>"/>
								</td>
            </tr>

<%
    }
%>
<input type="hidden" name="cp_type" value="<%=divName%>"/>
<input type="hidden"  name="cp_id" value="">
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


<script LANGUAGE="javascript">
	function onChange()
	{
		var sj_id;
		var audit;
                sj_id=formData.sj_id.value;
                audit=formData.audit.value;
		formData.action='publishList.jsp?sj_id='+sj_id+'&audit='+audit;
		formData.submit();
	}

function setSequence()
{
	//var form = document.formData ;
	document.formData.action = "setSequence.jsp";
	document.formData.submit();
}

function delcontent(ctId){
var objhttpPending=new ActiveXObject("Msxml2.XMLHTTP");
	var objxmlPending =	objxmlPending=new ActiveXObject("Microsoft.XMLDOM");
		strA = "abc"
		objhttpPending.Open("post","http://<%=request.getServerName()%>:<%=request.getServerPort()%>/system/app/infopublish/delete.jsp?ct_id=" + ctId ,true);
		objhttpPending.setRequestHeader("Content-Length",strA.length);
		objhttpPending.setRequestHeader("CONTENT-TYPE","application/x-www-form-urlencoded");
		objhttpPending.onreadystatechange = function (){
			var statePending = objhttpPending.readyState;
		    if (statePending == 4)
		    {
		    	var returnvalue = objhttpPending.responsetext;
		    	alert(returnvalue);
		    	if(returnvalue.indexOf("yes")!=-1){
		    		document.location.reload();
		    	}
			}
		};
	objhttpPending.Send(strA);

}
</script>
<%@ include file="../skin/bottom.jsp"%>

<%
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