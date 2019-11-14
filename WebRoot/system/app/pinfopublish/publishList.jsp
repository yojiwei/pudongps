<%@page contentType="text/html; charset=GBK"%>
<%@ page import="com.beyondbit.web.publishinfo.Messages" %>
<%@include file="/system/app/skin/head.jsp"%>
<script LANGUAGE="javascript" src="./common/common.js"></script>
<%
String strTitle = "信息维护";

//判断是否需要审核
String audit = CTools.dealString(request.getParameter("audit"));
if(!audit.equals(""))
{
  strTitle = "审核";
}
%>
<head>
<link href="../style.css" rel="stylesheet" type="text/css">
</head>
<%
CDataCn dCn = null;
CDataImpl dImpl = null;
try{
dCn = new CDataCn();
dImpl = new CDataImpl(dCn);

String sj_id="";//栏目id
String sj_dir="partyopen";//栏目名
sj_id=CTools.dealNumber(request.getParameter("sj_id")).trim();
String selDt_id = "";//部门id
selDt_id = CTools.dealString(request.getParameter("dt_id")).trim();
String dt_id   = "";
String dt_name = "";
String dtSql   = "";
String isadmin = CTools.dealString(request.getParameter("isadmin"));
String sjName1 = CTools.dealString(request.getParameter("sjName1"));
//dtSql = "select dt_id,dt_name from tb_deptinfo where 1=1 order by dt_sequence,dt_id desc";
//Vector dtList  = dImpl.splitPage(dtSql,100,1);


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
String subject_ids="";
String subjectCode="";
subjectCode=CTools.dealString(request.getParameter("subjectCode")).trim();
String strSelect="";

/*生成栏目列表  结束*/
if (subject_ids.length()>0){
  subject_ids=subject_ids.substring(0,subject_ids.length()-1);
}

//out.print(subject_ids);
/*得到是否审核的标志  开始  1=审核  0=该栏目不要审核 */
String NeedAudit="0";
String auditsql="";


//audit=CTools.dealString(request.getParameter("audit")).trim();
/*得到是否审核的标志  结束*/

String sj_ids="";

String sWhere="";

Hashtable content = null;
Vector vectorPage = null;

if(!myProject.getMyName().equals("超级管理员")) {
	sWhere += " and t.ur_id=" + uiid;
}


String strSql="";

String subIds = "";
strSql = "select sj_id from tb_subject connect by prior sj_id = sj_parentid start with sj_dir = '"+sj_dir+"'";
vectorPage = dImpl.splitPage(strSql,1000,1);
if(vectorPage!=null){
	for(int i=0; i<vectorPage.size(); i++){
		content = (Hashtable)vectorPage.get(i);
		subIds += content.get("sj_id").toString();
		if(vectorPage.size()!=i+1) subIds += ",";
	}
}

if(audit.equals(""))
{
 strSql = "select * from (select distinct t.ct_id,t.sj_name,t.ct_create_time,t.ct_title,t.ct_updatetime,t.ct_publish_flag,ct.AUDIT_STATUS,ct.CHECK_STATUS,ct.CP_ISPUBLISH,t.dt_id,d.dt_name,ct_sequence,t.sj_id from tb_content t,tb_subject s,tb_deptinfo d,tb_contentpublish ct where ct.ct_id=t.ct_id and s.sj_id=ct.sj_id and  t.dt_id=d.dt_id and cp_id in (select cp_id from (select ct.cp_id from tb_contentpublish ct,tb_content t  where ct.ct_id = t.ct_id " + sWhere + " order by ct.ct_id desc) where rownum <=300) order by to_date(t.ct_create_time,'YYYY-MM-DD') desc,t.ct_id desc) where rownum<=200" ;





}
else if (audit.equals("true"))
{
}
vectorPage = dImpl.splitPageOpt(strSql,request,20);
%>
<%@include file="/system/app/skin/skin4/template/list_top.jsp"%>
<!--    模块名称开始    -->
<%=strTitle%>
<!--    模块名称结束    -->
<%@include file="/system/app/skin/skin4/template/list_function.jsp"%>                                                            
<!--    功能按钮开始    -->
<img src="/system/images/new.gif" border="0" onclick="window.location='PublishInfo.jsp?OPType=Add&sj_id=<%=sj_id%>&subjectCode=<%=subjectCode%>&audit=false'" title="新增信息" style="cursor:hand" align="absmiddle" WIDTH="16" HEIGHT="16">新增信息
<img src="/system/images/menu_about.gif" border="0" onclick="javascript:window.location.href='publishSearch.jsp' " title="查找" style="cursor:hand" align="absmiddle">查找
<img src="/system/images/goback.gif" border="0" onclick="javascript:history.back();" title="返回" style="cursor:hand" align="absmiddle">返回
<!--    功能按钮结束    -->
<%@include file="/system/app/skin/skin4/template/list_listtop.jsp"%>                                                                                        
<!--    列表开始    -->
<table class="FindAreaTable1" cellspacing="1" rules="cols" border="0" id="ctl00_DataGrid_DataGrid1" style="border-width:0px;">
	<form name="formData">
     <INPUT TYPE="hidden" name="subjectCode" value="<%=subjectCode%>">
     <INPUT TYPE="hidden" name="curpage" value="<%=CTools.dealNumber(request.getParameter("strPage"))%>">
     <INPUT TYPE="hidden" name="audit" value="<%=audit%>">
        <tr class="bttn">
            <td width="30%" class="outset-table">信息主题</td>
            <!-- td width="10%" class="outset-table">分类</td-->
			<td width="20%" class="outset-table">发布栏目</td>
            <td width="10%" class="outset-table">发布日期</td>

            <td width="15%" class="outset-table">部门</td>
            <td width="16%" class="outset-table">更新时间</td>
            <!-- td width="8%" class="outset-table">排序</td-->
            <td width="9%" class="outset-table" nowrap>
            <%
            //if (NeedAudit.equals("1"))
            //{
            //out.print("审核");
            //}
            //else
            //{
            out.print("操作");
            //}
            %>
            </td>
        </tr>
<%
  if(vectorPage!=null)
  {
    for(int j=0;j<vectorPage.size();j++)
    {
      content = (Hashtable)vectorPage.get(j);
      String ct_updatetime = CTools.dealString(content.get("ct_updatetime").toString());
      if(j % 2 == 0)  out.print("<tr class=\"line-even\">");
      else out.print("<tr class=\"line-odd\">");
%>

                <td ><img border="0" src="/system/images/arrow_yellow.gif" WIDTH="15" HEIGHT="13" align='left'>&nbsp;<a href="PublishEdit.jsp?OPType=Edit&ct_id=<%=content.get("ct_id")%>&subjectCode=<%=subjectCode%>&curpage=<%=CTools.dealNumber(request.getParameter("strPage"))%>&audit=<%=audit%>">				<%=content.get("ct_title")%></a></td>
                
				<td align="center" ><%=content.get("sj_name")%></td>
                <td align="center" nowrap><%=content.get("ct_create_time")%></td>
                <td align=center nowrap><%=content.get("dt_name")%></td>
                 <td align=center><%=ct_updatetime%></td>
                <td align="center" nowrap><a href="PublishEdit.jsp?OPType=Edit&ct_id=<%=content.get("ct_id")%>&subjectCode=<%=subjectCode%>&curpage=<%=CTools.dealNumber(request.getParameter("strPage"))%>&audit=<%=audit%>"><img class="hand" border="0" src="
                <%
                if (audit.equals("true"))
                {
                out.print("/system/images/dialog/hammer.gif\" title=审核");
                }
                else
                {
                out.print("/system/images/modi.gif\" title=编辑");
                }
                %>
                  WIDTH="16" HEIGHT="16"></a>
								&nbsp;
								<a href="javascript:delcontent('<%=content.get("cp_id")%>','<%=content.get("ct_id")%>');">
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

function delcontent(cpId,ctId){
var objhttpPending=new ActiveXObject("Msxml2.XMLHTTP");
	var objxmlPending =	objxmlPending=new ActiveXObject("Microsoft.XMLDOM");
		
		strA = "abc"
		//objhttpPending.Open("post","<%=Messages.getString("xmlHttp")%>/system/app/pinfopublish/delete.jsp?ct_id=" + ctId ,true);
		objhttpPending.Open("post","/system/app/pinfopublish/infoDel.jsp?ct_id=" + ctId + "&cp_id=" + cpId ,true);
		objhttpPending.setRequestHeader("Content-Length",strA.length);
		objhttpPending.setRequestHeader("CONTENT-TYPE","application/x-www-form-urlencoded");
		
		
		
		objhttpPending.onreadystatechange = function (){
			var statePending = objhttpPending.readyState; 
		    if (statePending == 4)
		    {
		    	var returnvalue = objhttpPending.responsetext;
		    	alert("删除成功");
				//alert(returnvalue);
		    	if(returnvalue.indexOf("删除成功")!=-1){
		    		//eval("document.all.tr"+ctId+".style.display='none'");
					document.location.reload();
		    	}
			}
		};
		
		objhttpPending.Send(strA);

}
</script>
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