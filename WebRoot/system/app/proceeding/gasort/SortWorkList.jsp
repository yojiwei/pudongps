<%@page contentType="text/html; charset=GBK"%>
<%@include file="/system/app/skin/head.jsp"%>
<%
String strTitle="事项分类管理";
String GW_ID = "";
String GW_NAME = "";
String GW_SEQUENCE = "";
String DT_ID = "";
String DT_NAME = "";

 //update20080122

CDataCn dCn=null;   //新建数据库连接对象
CDataImpl dImpl=null;  //新建数据接口对象
CMySelf mySelf = (CMySelf)session.getAttribute("mySelf");
String mydtid= String.valueOf(mySelf.getDtId());



try {
 dCn = new CDataCn(); 
 dImpl = new CDataImpl(dCn); 
 String strSql="select a.gw_id,a.gw_name,a.gw_sequence,b.dt_name from tb_gasortwork a,tb_deptinfo b where a.dt_id=b.dt_id and b.dt_id="+mydtid+" order by a.dt_id,a.gw_sequence";
 Vector vectorPage = dImpl.splitPage(strSql,request,20);
%>
<table class="main-table" width="100%">
 <tr>
  <td width="100%">
       <table class="content-table" width="100%">
	 <form name="formData" method="post">
                <tr class="title1">
                        <td colspan="6" align="center">
                                <table WIDTH="100%" BORDER="0" CELLSPACING="1" CELLPADDING="1">
                                        <tr>
                                                <td valign="center"><%=strTitle%></td>
                                                <td valign="center" align="right" nowrap>

                                                        <img src="/system/images/split.gif" align="middle" border="0" WIDTH="5" HEIGHT="8">
                                                        <img src="/system/images/new.gif" border="0" onclick="window.location='SortWorkInfo.jsp'" title="新建类型" style="cursor:hand" align="absmiddle" WIDTH="16" HEIGHT="16">
                                                        <img src="/system/images/split.gif" align="middle" border="0" WIDTH="5" HEIGHT="8">
                                                        <img src="/system/images/dialog/sort.gif" border="0" onclick="setSequence()" title="修改排序" style="cursor:hand" align="absmiddle" WIDTH="15" HEIGHT="15">
                                                        <img src="/system/images/split.gif" align="middle" border="0" WIDTH="5" HEIGHT="8">
                                                        <img src="/system/images/goback.gif" border="0" onclick="javascript:history.back();" title="返回" style="cursor:hand" align="absmiddle">
                                                        <img src="/system/images/split.gif" align="middle" border="0" WIDTH="5" HEIGHT="8">
                                                </td>
                                        </tr>
                                </table>
                        </td>
                </tr>
                <tr class="bttn">
                        <td width="10%" class="outset-table">类别ID</td>
						<td width="30%" class="outset-table">所属单位</td>
                        <td width="30%" class="outset-table">类别名</td>
                        <td width="10%" class="outset-table">编辑</td>
                        <td width="10%" class="outset-table">删除</td>
                        <td width="10%" class="outset-table">排序</td>
                </tr>
           <%

          if(vectorPage!=null)
          {
            for(int j=0;j<vectorPage.size();j++)
            {
             Hashtable content = (Hashtable)vectorPage.get(j);
             GW_ID = content.get("gw_id").toString();
             GW_NAME = content.get("gw_name").toString();
             GW_SEQUENCE = content.get("gw_sequence").toString();
			 DT_NAME = content.get("dt_name").toString();

             if(j % 2 == 0)  out.print("<tr class=\"line-even\">");
             else out.print("<tr class=\"line-odd\">");
           %>
            <td align="center"><%=GW_ID%></td>
			<td align="center"><%=DT_NAME%></td>
            <td align="center"><%=GW_NAME%></td>
            <td align="center"><a href="SortWorkInfo.jsp?GW_ID=<%=GW_ID%>"><img class="hand" border="0" src="/system/images/modi.gif" title="编辑" WIDTH="16" HEIGHT="16"></a></td>
            <td align="center"><a href="SortWorkDel.jsp?GW_ID=<%=GW_ID%>"><img class="hand" border="0" src="/system/images/delete.gif" title="删除" WIDTH="16" HEIGHT="16" onclick="return window.confirm('确认要删除该记录么?');"></a></td>
            <td align="center"><input type=text class=text-line name=<%="module" + GW_ID%> value="<%=GW_SEQUENCE%>" size=4 maxlength=4></td>
           </tr>
        <%
            }
        %>
        </form>
        <%
      /*分页的页脚模块*/
      out.println("<tr><td colspan=7>" + dImpl.getTail(request) + "</td></tr>"); //输出尾部文件


      }
      else
      {
        out.println("<tr><td colspan=7>无记录</td></tr>");
                        }
      %>
       </table>
  </td>
</tr>
</table>
<%
dImpl.closeStmt();
dCn.closeCn();
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
<SCRIPT LANGUAGE="JavaScript">
function setSequence()
{
        var form = document.formData ;
        form.action = "setSequence.jsp";
        form.submit();
}
</SCRIPT>
<%@include file="/system/app/skin/bottom.jsp"%>