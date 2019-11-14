<%@page contentType="text/html; charset=GBK"%>
<%@ include file="../skin/head.jsp"%>
<%
String strTitle = "点击率查看";
String uiid = "";
String audit = CTools.dealString(request.getParameter("audit"));

CMySelf myProject = (CMySelf)session.getAttribute("mySelf");
if(myProject!=null && myProject.isLogin())
  {
    uiid = Long.toString(myProject.getMyID());
  }

//update20080122

CDataCn dCn=null;   //新建数据库连接对象
CDataImpl dImpl=null;  //新建数据接口对象

try {
 dCn = new CDataCn(); 
 dImpl = new CDataImpl(dCn); 

String sjId = CTools.dealString(request.getParameter("ModuleDirIds"));
if("".equals(sjId))
	sjId="26720";
String selDt_id = "";//部门id
selDt_id = CTools.dealString(request.getParameter("dt_id")).trim();
String dt_id   = "";
String dt_name = "";
String dtSql   = "";
dtSql = "select dt_id,dt_name from tb_deptinfo where 1=1 order by dt_sequence,dt_id desc";
Vector dtList  = dImpl.splitPage(dtSql,100,1);

/*生成栏目列表  开始*/
String subject_ids="";
String subjectCode="";
subjectCode=CTools.dealString(request.getParameter("subjectCode")).trim();
String strSelect="";

String strSql="";

//strSql = "select distinct t.ct_id,t.ct_create_time,t.ct_title,t.dt_id,t.ct_sequence,t.sj_id,d.dt_name, d.dt_id from tb_content t,tb_subject s,tb_deptinfo d,tb_contentpublish ct where t.dt_id=d.dt_id and s.sj_id=ct.sj_id and ct.ct_id=t.ct_id  and ct.AUDIT_STATUS=1 and t.UR_ID="+uiid+" order by to_date(t.ct_create_time,'YYYY-MM-DD') desc,t.ct_id desc ";
strSql = "select distinct s.SJ_NAME,t.ct_id,t.ct_create_time,t.ct_title,t.dt_id,t.ct_sequence,t.sj_id,d.dt_name, d.dt_id, nvl(ci.ci_number,0) as ci_number from tb_content t,(select sj_id,SJ_NAME from tb_subject start with sj_id="+sjId+" connect by prior sj_id=sj_parentid) s,tb_deptinfo d,tb_contentpublish ct,tb_contentpublish cp ,tb_countcontentinfo ci where t.dt_id=d.dt_id and s.sj_id=ct.sj_id and ct.ct_id=t.ct_id and cp.ct_id=t.ct_id  and t.ct_id=ci.ct_id(+) and t.ur_id = " + uiid + " order by nvl(ci.ci_number,0)+0 desc,to_date(t.ct_create_time,'YYYY-MM-DD') desc,t.ct_id desc ";
Vector vectorPage = dImpl.splitPage(strSql,request,20);
//out.print(strSql);
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
            <td colspan="7" align="left">
                <table WIDTH="100%" BORDER="0" CELLSPACING="1" CELLPADDING="1">
                    <tr>
                        <td valign="left" nowrap><%=strTitle%></td>
			<td valign="center" align=left></td>
			<td valign="center" align="center">

			</td>
  <td valign="center" align="right" nowrap>
   </td>
  </tr>
 </table>
  </td>
        </tr>
        <tr class="bttn">
            <td width="46%" class="outset-table">信息主题</td>
            <td width="16%" class="outset-table">栏目</td>
            <td width="14%" class="outset-table">发布日期</td>
            <!--<td width="6%" class="outset-table">发布</td>-->
            <td width="12%" class="outset-table">部门</td>
            <!--<td width="8%" class="outset-table">排序</td>-->
            <td width="8%" class="outset-table" nowrap> 点击量</td>
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

                <td align="left"><img border="0" src="/system/images/arrow_yellow.gif" WIDTH="15" HEIGHT="13">&nbsp;
                <!--a href="PublishEditShenPi.jsp?OPType=ShenHeBack&ct_id=<%=content.get("ct_id")%>&subjectCode=<%=subjectCode%>&curpage=<%=CTools.dealNumber(request.getParameter("strPage"))%>&audit=<%=audit%>"--><%=content.get("ct_title")%></a></td>
                <td align="center"><%=content.get("sj_name")%></td>
                <td align="center"><%=content.get("ct_create_time")%></td>
                <!--<td align="center"></td>-->

                <td align=center><%=content.get("dt_name")%></td>
                <!--<td align=center><input type=text class=text-line name='<%="module"+content.get("ct_id").toString()%>' value="<%=content.get("ct_sequence").toString()%>" size=4 maxlength=4></td>-->
                <!--td align="center"><a href="PublishEditShenPi.jsp?OPType=ShenHeBack&ct_id=<%=content.get("ct_id")%>&subjectCode=<%=subjectCode%>&curpage=<%=CTools.dealNumber(request.getParameter("strPage"))%>&audit=<%=audit%>"><img class="hand" border="0" src="
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
								<a href="javascript:delcontent('<%=content.get("ct_id")%>');">
								<img class="hand" border="0" src="../../images/delete.gif" title="删除" WIDTH="16" HEIGHT="16" onclick="return window.confirm('确认要删除该记录么?');"></a>
								</td-->
								 <td align=center><%=content.get("ci_number")%></td>
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
</script>

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
