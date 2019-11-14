<%
/**************************************
this page is made by honeyday 2002-12-6
***************************************/
%>
<%@page contentType="text/html; charset=GBK"%>
<%@ page import="com.beyondbit.web.publishinfo.Messages" %>
<script LANGUAGE="javascript" src="./common/common.js"></script>
<%
String strTitle = "信息维护";

//判断是否需要审核
String audit = CTools.dealString(request.getParameter("audit"));
if(!audit.equals(""))
{
  strTitle = "审核";
}
//

%>
<%@ include file="../skin/head.jsp"%>
<%
//update20080122

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
String sjName1 = CTools.dealString(request.getParameter("sjName1"));
String sjId = CTools.dealString(request.getParameter("ModuleDirIds"));


/*得到当前登陆的用户id  开始*/
String uiid="";
//登陆用户名
String username="";
CMySelf myProject = (CMySelf)session.getAttribute("mySelf");
  if(myProject!=null && myProject.isLogin())
  {
    uiid = Long.toString(myProject.getMyID());
	dt_id=dt_id = String.valueOf(myProject.getDtId());
	username=String.valueOf(myProject.getMyUid());
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
String start_date=CTools.dealString(request.getParameter("start_date")).trim();
String end_date=CTools.dealString(request.getParameter("end_date")).trim();
String CT_title=CTools.dealString(request.getParameter("CT_title")).trim();
String strSelect="";

//out.print(subject_ids);
/*得到是否审核的标志  开始  1=审核  0=该栏目不要审核 */
String NeedAudit="0";
String auditsql="";


//audit=CTools.dealString(request.getParameter("audit")).trim();
/*得到是否审核的标志  结束*/

String sj_ids="";
      
String sWhere="";

if (!CT_title.equals(""))
{
	sWhere=sWhere + " and ct_title like '%" + CT_title + "%'";
}
if (!start_date.equals(""))
{
	sWhere=sWhere + " and TO_DATE(ct_create_time,'YYYY-MM-DD') >= TO_DATE('"+ start_date +"','YYYY-MM-DD')";
}
if (!end_date.equals(""))
{
	sWhere=sWhere + " and TO_DATE(ct_create_time,'YYYY-MM-DD') <= TO_DATE('"+ end_date +"','YYYY-MM-DD')";
}

StringBuffer sf = new StringBuffer();
Vector ctIdVec = null;
String ctIdSql = "";
Hashtable ctIdTable = null;

if(!sjId.equals("")){
 ctIdSql = "select ct_id from tb_contentpublish where sj_id in (select sj_id from tb_subject start with sj_id="+sjId+" connect by prior sj_id=sj_parentid)";
}else{
}
//out.println(ctIdSql);
ctIdVec = dImpl.splitPage(ctIdSql,200,1);
if(ctIdVec != null){
	for(int cnt = 0; cnt < ctIdVec.size(); cnt++){
		ctIdTable  = (Hashtable) ctIdVec.get(cnt);
		sf.append(ctIdTable.get("ct_id").toString());
		if(cnt != (ctIdVec.size() - 1))
			sf.append(",");
	}
}
if(!sjId.equals("")){
sWhere += " and t.ct_id in ("+sf.toString()+")"; 
}else
{}

String strSql="";
if(audit.equals(""))
{
  strSql = "select distinct t.ct_id,t.ct_create_time,t.ct_title,t.ct_updatetime,t.ct_publish_flag,t.dt_id,d.dt_name,ct_sequence,t.sj_id from tb_content t left outer join tb_deptinfo d on t.dt_id = d.dt_id where 1=1 "+(username.equals("admin")?"":("and t.dt_id="+dt_id))+ sWhere + " order by t.ct_id desc " ;
}
else if (audit.equals("true"))
{

}


//out.println(strSql);
Vector vectorPage = dImpl.splitPageOpt(strSql,request,15);


%>

 <table class="main-table" width="100%">
    <tr>
  <td width="100%">
       <table class="content-table" width="100%">
		 <form name="formData">
     <INPUT TYPE="hidden" name="subjectCode" value="<%=subjectCode%>">
     <INPUT TYPE="hidden" name="curpage" value="<%=CTools.dealNumber(request.getParameter("strPage"))%>">
     <INPUT TYPE="hidden" name="audit" value="<%=audit%>">

        <tr class="title1">
            <td colspan="7" align="center">
                <table WIDTH="100%" BORDER="0" CELLSPACING="1" CELLPADDING="1">
                    <tr>
                        <td valign="center" width=7%><%=strTitle%></td>
			
						<td valign="center" align="left">
						
						</td>
                        <td valign="center" align="right" nowrap>

                            <img src="/system/images/split.gif" align="middle" border="0" WIDTH="5" HEIGHT="8">
                           
                            <img src="/system/images/split.gif" align="middle" border="0" WIDTH="5" HEIGHT="8">
                            <img src="/system/images/menu_about.gif" border="0" onclick="javascript:window.location.href='publishSearch.jsp' " title="查找" style="cursor:hand" align="absmiddle">
                            <!--img src="/system/images/split.gif" align="middle" border="0" WIDTH="5" HEIGHT="8"-->
                            <img src="/system/images/goback.gif" border="0" onclick="javascript:history.back();" title="返回" style="cursor:hand" align="absmiddle">
                            <img src="/system/images/split.gif" align="middle" border="0" WIDTH="5" HEIGHT="8">
   </td>
  </tr>
 </table>
  </td>
        </tr>
        <tr class="bttn">
            <td width="36%" class="outset-table">信息主题</td>
            <td width="10%" class="outset-table">发布日期</td>
            <td width="16%" class="outset-table">部门</td>
            <td width="20%" class="outset-table">更新时间</td>
            <td width="8%" class="outset-table" nowrap>
            <%
            out.print("操作");
            %>
            </td>
        </tr>
<%
  if(vectorPage!=null)
  {
    for(int j=0;j<vectorPage.size();j++)
    {
      Hashtable content = (Hashtable)vectorPage.get(j);
      String ct_updatetime = CTools.dealString(content.get("ct_updatetime").toString());
      if(j % 2 == 0)  out.print("<tr class=\"line-even\">");
      else out.print("<tr class=\"line-odd\">");
%>

                <td ><img border="0" src="/system/images/arrow_yellow.gif" WIDTH="15" HEIGHT="13">&nbsp;<a href="PublishEdit.jsp?OPType=Edit&ct_id=<%=content.get("ct_id")%>&subjectCode=<%=subjectCode%>&curpage=<%=CTools.dealNumber(request.getParameter("strPage"))%>&audit=<%=audit%>"><%=content.get("ct_title")%></a></td>
                <td align="center"><%=content.get("ct_create_time")%></td>                              
                <td align=center><%=content.get("dt_name")%></td>
                 <td align=center><%=ct_updatetime%></td>
                <td align="center"><a href="PublishEdit.jsp?OPType=Edit&ct_id=<%=content.get("ct_id")%>&subjectCode=<%=subjectCode%>&curpage=<%=CTools.dealNumber(request.getParameter("strPage"))%>&audit=<%=audit%>"><img class="hand" border="0" src="
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
								<a href="javascript:delcontent('<%=content.get("ct_id")%>','<%=CTools.htmlEncode(content.get("ct_title").toString())%>')">
								<img class="hand" border="0" src="../../images/delete.gif" title="删除" WIDTH="16" HEIGHT="16" onclick="return window.confirm('确认要删除该记录么?');"></a>
								</td>
            </tr>

<%
    }
%>
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
        </td>
    </tr>
</table>

<%
  dImpl.closeStmt();
  dCn.closeCn();
%>
<%@ include file="../skin/bottom.jsp"%>
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

function delcontent(ctId,ctTitle){
var objhttpPending=new ActiveXObject("Msxml2.XMLHTTP");
	var objxmlPending =	objxmlPending=new ActiveXObject("Microsoft.XMLDOM");

		strA = "abc"

		objhttpPending.Open("post","http://<%=request.getServerName()%>:<%=request.getServerPort()%>/system/app/infopublish/delete.jsp?ct_id=" + ctId + "&ctTitle=" + ctTitle ,true);
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