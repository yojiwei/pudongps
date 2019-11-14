<%@page contentType="text/html; charset=GBK"%>
<%String strTitle="栏目管理" ;%>
<%@include file="/system/app/skin/import.jsp"%>
<%@include file="/system/app/islogin.jsp"%>
<script language="javascript" src="/system/include/common.js"></script>
<link href="/system/app/skin/skin3/images/style.css" rel="stylesheet" type="text/css">
<%

    String SJ_parentid = request.getParameter("SJ_parentid");
    //String strtTitle = "";
        int iSJ_parentid = 0;

    if (SJ_parentid==null || SJ_parentid.equals(""))
        {
            iSJ_parentid = 0;
        }
        else
        {
            iSJ_parentid = Integer.parseInt(SJ_parentid);
        }

//update20080122

CDataCn dCn=null;   //新建数据库连接对象
CDataImpl dImpl=null;  //新建数据接口对象

try {
 dCn = new CDataCn(); 
 dImpl = new CDataImpl(dCn); 

String strSBname="";//栏目名称
String strSBurl="";//超链接
String strDIR="";//目录名称
String strSBsequence="";//排序
/*得到传过来的分类参数  sjCode  开始
sjCode=news 是新闻类
sjCode=news 是新闻类
sjCode=news 是新闻类
sjCode=news 是新闻类
*/
String sjCode=CTools.dealString(request.getParameter("sjCode")).trim();
String sjParid = CTools.dealString(request.getParameter("sjParid")).trim();
String node_title = CTools.dealString(request.getParameter("node_title")).trim();
if (sjCode.equals(""))
	sjCode="root";
/*得到传过来的分类参数  sjCode  结束*/

    CRoleAccess ado=new CRoleAccess(dCn);
    CMySelf self = (CMySelf)session.getAttribute("mySelf");
    String user_id = String.valueOf(self.getMyID());
    String filterSql="";

    if(!ado.isAdmin(user_id))
      filterSql=ado.getAccessSqlByUser(user_id,ado.ColumnAccess);


/*生成栏目的下拉列表 by honeyday 开始*/
String sj_id="";//栏目id
sj_id=CTools.dealNull(request.getParameter("sj_id"),"0");
CSubjectList jdo = new CSubjectList(dCn);
String s="";
//s = jdo.getListByCode(sjCode,sj_id);
/*生成栏目的下拉列表 by honeyday 结束*/


String sWhere = "";

sWhere="where 1=1 "+filterSql;

/*if (sj_id.equals("0"))
{
	if(sjCode.equals("root"))
		sj_id="-1";
}*/
if (!sj_id.equals(""))
{
	sWhere=sWhere+" and sj_parentid ="+sj_id;
}

if (!sjCode.equals("") && !sjCode.equals("root"))
{
	sWhere=sWhere+" and sj_dir='" + sjCode + "'";
}
if (sjParid.equals(""))
{
	String paridSql = "select sj_parentid from tb_subject where sj_id = '"+ sj_id +"'";
	Hashtable paridContent = dImpl.getDataInfo(paridSql);
	if (paridContent != null)
	{
		sjParid = paridContent.get("sj_parentid").toString();
	}
}
String sql="select * from tb_subject "+sWhere + " order by sj_sequence,sj_id desc";
//out.print(sql);
//out.close();
Vector vectorPage = dImpl.splitPage(sql,request,20);

%>
<form name="formData">
 <table class="main-table" width="100%">
    <tr>
  <td width="100%">
       <table class="content-table" width="100%">

        <tr class="title1">
            <td colspan="5" align="center">
                <table WIDTH="100%" BORDER="0" CELLSPACING="1" CELLPADDING="1">
                    <tr>
                        <td valign="center"><%=node_title%></td>

                        <td valign="center" align="right" nowrap>


							<img src="../../images/split.gif" align="middle" border="0" WIDTH="5" HEIGHT="8">
                            <img src="../../images/up.gif" border="0" onclick="window.location='subjectList.jsp?sj_id=<%=sjParid%>'" title="返回上级栏目" style="cursor:hand" align="absmiddle">

                            <img src="../../images/split.gif" align="middle" border="0" WIDTH="5" HEIGHT="8">
                            <img src="../../images/new.gif" border="0" onclick="window.location='subjectInfo.jsp?OP=Add&sj_id=<%=sj_id%>'" title="新建栏目" style="cursor:hand" align="absmiddle" WIDTH="16" HEIGHT="16">
                            <img src="../../images/split.gif" align="middle" border="0" WIDTH="5" HEIGHT="8">
							<img src="../../images/dialog/sort.gif" border="0" onclick="setSequence()" title="修改排序" style="cursor:hand" align="absmiddle" WIDTH="15" HEIGHT="15">
							<INPUT TYPE="hidden" name="list_id" value="<%=sj_id%>">
							<img src="../../images/split.gif" align="middle" border="0" WIDTH="5" HEIGHT="8">
                            <img src="../../images/goback.gif" border="0" onclick="javascript:history.back();" title="返回" style="cursor:hand" align="absmiddle">

                            <img src="../..images/split.gif" align="middle" border="0" WIDTH="5" HEIGHT="8">
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr class="bttn">
            <td width="25%" class="outset-table" nowrap>栏目名称</td>
            <td width="42%" class="outset-table">超链接</td>
            <td width="15%" class="outset-table">权限代码</td>
            <td width="8%" class="outset-table" nowrap>编辑</td>
			<td width="10%" class="outset-table">排序</td>
        </tr>
<%

  if(vectorPage != null)
  {
    for(int j=0;j<vectorPage.size();j++)
    {
      Hashtable content = (Hashtable)vectorPage.get(j);
      String strId=content.get("sj_id").toString();
	  String se=content.get("sj_sequence").toString();
            if(j % 2 == 0)  out.print("<tr class=\"line-even\">");
            else out.print("<tr class=\"line-odd\">");

  %>

            <td><A HREF="subjectList.jsp?sj_id=<%=strId%>&sjParid=<%=content.get("sj_parentid")%>&node_title=<%=content.get("sj_name")%>"><%=content.get("sj_name")%></A></td>

            <td><%=content.get("sj_url")%></td>

			<td><%=content.get("sj_dir")%></td>
			<td nowrap align=center><a href="subjectInfo.jsp?OP=Edit&strId=<%=strId%>&sjParid=<%=sjParid%>"><img class="hand" border="0" src="../../images/modi.gif" title="编辑" WIDTH="16" HEIGHT="16"></a></td>
			<td align=center><input type=text class=text-line name=<%="module"+content.get("sj_id").toString()%> value="<%=se%>" size=4 maxlength=4></td>


        </tr>
<%}%>
</table>
        </td>
    </tr></form>
<%/*分页的页脚模块*/
	dImpl.closeStmt();
	dCn.closeCn();
   out.println("<tr><td colspan=7>" + dImpl.getTail(request) + "</td></tr>"); //输出尾部文件

  }
  else
  {
    out.println("<tr><td colspan=7>无子栏目！</td></tr>");
  }
%>
</table>


<SCRIPT LANGUAGE=javascript>
<!--
function setSequence()
{
  formData.action = "setSequence.jsp";
  formData.submit();
}
function onChange()
{
  var sj_id;
  sj_id=formData.sj_id.value;
  formData.action='subjectList.jsp?sj_id='+sj_id;
  formData.submit();
}
//-->
</SCRIPT>
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
