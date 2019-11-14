<%@page contentType="text/html; charset=GBK"%>
<%@ include file="../skin/head.jsp"%>
<%
String strTitle = "信息维护";
String uiid = "";
//判断是否需要审核 0--审核 2--修改
String audit = CTools.dealString(request.getParameter("audit"));

CMySelf myProject = (CMySelf)session.getAttribute("mySelf");
if(myProject!=null && myProject.isLogin())
  {
    uiid = Long.toString(myProject.getMyID());
  }
if(!audit.equals("0"))
{
  strTitle = "审核";
}

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
dtSql = "select dt_id,dt_name from tb_deptinfo where 1=1 order by dt_sequence,dt_id desc";
Vector dtList  = dImpl.splitPage(dtSql,100,1);

/*生成栏目列表  开始*/
String subject_ids="";
String subjectCode="";
subjectCode=CTools.dealString(request.getParameter("subjectCode")).trim();
String strSelect="";

String strSql="";

strSql = "select distinct t.ct_id,t.ct_create_time,t.ct_title,t.dt_id,t.ct_sequence,t.sj_id,d.dt_name,";
strSql +=" d.dt_id from tb_content t,tb_subject s,tb_deptinfo d,tb_contentpublish ct,tb_contentpublish cp,tb_taskcenter tk where t.dt_id=d.dt_id and s.sj_id=ct.sj_id and ct.ct_id=t.ct_id and cp.ct_id=t.ct_id and tk.ct_id=ct.ct_id and tk.tc_receiverid='" + uiid + "' and tk.tc_isfinished='0' and tc_tasktype='2' order by to_date(t.ct_create_time,'YYYY-MM-DD') desc,t.ct_id desc" ;
//strSql = "select a.tc_id,b.* from (select tc_id,ct_id from tb_taskcenter where rownum=1 and ) a,(select distinct t.ct_id,t.ct_create_time,t.ct_title,t.dt_id,t.ct_sequence,t.sj_id,d.dt_name from tb_content t,tb_subject s,tb_deptinfo d,tb_contentpublish ct,tb_contentpublish cp,tb_taskcenter tk where t.dt_id=d.dt_id and s.sj_id=ct.sj_id and ct.ct_id=t.ct_id and cp.ct_id=ct.ct_id and tk.ct_id=ct.ct_id and tk.tc_receiverid='" + uiid + "' and tk.tc_isfinished='0' and tc_tasktype='0') b  where a.ct_id=b.ct_id";
//out.println(strSql);
Vector vectorPage = dImpl.splitPage(strSql,request,20);

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
            <td width="10%" class="outset-table">分类</td>
            <td width="10%" class="outset-table">发布日期</td>
            <td width="6%" class="outset-table">发布</td>
            <td width="12%" class="outset-table">部门</td>
            <td width="8%" class="outset-table">排序</td>
            <td width="8%" class="outset-table" nowrap>
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
      Hashtable content = (Hashtable)vectorPage.get(j);
      if(j % 2 == 0)  out.print("<tr class=\"line-even\">");
      else out.print("<tr class=\"line-odd\">");
%>

                <td ><img border="0" src="/system/images/arrow_yellow.gif" WIDTH="15" HEIGHT="13">&nbsp;
                <a href="PublishEditinfo.jsp?OPType=editinfo&ct_id=<%=content.get("ct_id")%>"><%=content.get("ct_title")%></a></td>
                <td align="center"></td>
                <td align="center"><%=content.get("ct_create_time")%></td>
                <td align="center"></td>

                <td align=center><%=content.get("dt_name")%></td>
                <td align=center><input type=text class=text-line name='<%="module"+content.get("ct_id").toString()%>' value="<%=content.get("ct_sequence").toString()%>" size=4 maxlength=4></td>
                <td align="center"><a href="PublishEditinfo.jsp?OPType=editinfo&ct_id=<%=content.get("ct_id")%>&subjectCode=<%=subjectCode%>&curpage=<%=CTools.dealNumber(request.getParameter("strPage"))%>&audit=<%=audit%>"><img class="hand" border="0" src="
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
								<a href="publishDel.jsp?OPType=del&CT_id=<%=content.get("ct_id")%>&subjectCode=<%=subjectCode%>&curpage=<%=CTools.dealNumber(request.getParameter("strPage"))%>&audit=<%=audit%>">
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
