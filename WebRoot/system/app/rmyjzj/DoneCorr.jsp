<%@page contentType="text/html; charset=GBK" %>
<%@include file="/system/app/skin/head.jsp"%>
<%@page import="com.component.database.*"%>
<%@page import="com.app.*"%>
<%
//update20080122

CDataCn dCn=null;   //新建数据库连接对象
CDataImpl dImpl=null;  //新建数据接口对象

try {
 dCn = new CDataCn(); 
 dImpl = new CDataImpl(dCn); 

CMySelf self = (CMySelf)session.getAttribute("mySelf");
String dt_id="";
dt_id = String.valueOf(self.getDtId());
String sqlUndo ="";
String sendtime="";
sqlUndo = " select x.de_isovertime,x.de_status,to_char(x.de_sendtime,'yyyy-mm-dd hh24:mi:ss') de_sendtime,to_char(x.de_signtime,'yyyy-mm-dd hh24:mi:ss') de_signtime,";
sqlUndo += " to_char(x.de_feedbacktime,'yyyy-mm-dd hh24:mi:ss') de_feedbacktime,to_char(x.de_feedbacksigntime,'yyyy-mm-dd hh24:mi:ss') de_feedbacksigntime, ";
sqlUndo += " x.de_id,x.de_senddeptid,y.co_id,y.cw_id,z.cw_applyingname,u.dt_name senddept,w.dt_name receivedept,v.cp_name ";
sqlUndo += " from tb_documentexchange x,tb_correspond y,tb_connwork z,tb_deptinfo u,tb_connproc v,tb_deptinfo w ";
sqlUndo += " where v.cp_upid='o13' and x.de_type='6' and x.de_status in('5') and z.cp_id=v.cp_id and x.de_senddeptid='"+dt_id+"'";
sqlUndo += " and x.de_primaryid=y.co_id and y.cw_id=z.cw_id and x.de_senddeptid=u.dt_id and x.de_receiverdeptid=w.dt_id";
%>

<table class="main-table" width="100%">
    <tr>
          <td width="100%">
               <table class="content-table" width="100%">
        <form name="formData">
                <tr class="title1">
                    <td colspan="12" align="center">
                        <table WIDTH="100%" BORDER="0" CELLSPACING="1" CELLPADDING="1">
                            <tr width="100%">
                                <td valign="center" width="15%">已完成转办办理信件</td>
                          <td valign="center" align="right" nowrap>
                                                  <img src="/system/images/split.gif" align="middle" border="0" WIDTH="5" HEIGHT="8">
                            <img src="/system/images/menu_about.gif" border="0" onclick="javascript:window.location.href='WorkSearch.jsp' " title="查找" style="cursor:hand" align="absmiddle">
                            <img src="/system/images/split.gif" align="middle" border="0" WIDTH="5" HEIGHT="8">
                            <img src="/system/images/goback.gif" border="0" onclick="javascript:history.back();" title="返回" style="cursor:hand" align="absmiddle">
                            <img src="/system/images/split.gif" align="middle" border="0" WIDTH="5" HEIGHT="8">
   </td>
  </tr>
 </table>
  </td>
        </tr>
                <tr class="bttn">
                        <td width="5%" class="outset-table" align="center"><div title="红色表示超时,绿色表示不超时,黄色表示即将超时">●</div></td>
            <td width="10%" class="outset-table" align="center">状态</td>
            <td width="15%" class="outset-table" align="center">互动事项名称</td>
            <td width="8%" class="outset-table" align="center">发送部门</td>
                        <td width="9%" class="outset-table" align="center">发送人</td>
            <td width="8%" class="outset-table" align="center">接收部门</td>
                        <td width="10%" class="outset-table" align="center">发送时间</td>
                        <td width="10%" class="outset-table" align="center">签收时间</td>
                        <td width="10%" class="outset-table" align="center">反馈时间</td>
                        <td width="10%" class="outset-table" align="center">反馈签收时间</td>
                        <td width="5%" class="outset-table" align="center">操作</td>
                        </tr>
                <%
                Vector vectorPage = dImpl.splitPage(sqlUndo,request,20);
                if(vectorPage!=null)
                {
                        for(int i=0;i<vectorPage.size();i++)
                        {
                                Hashtable content = (Hashtable)vectorPage.get(i);
                            if(i % 2 == 0)  out.print("<tr class=\"line-even\">");
                                else out.print("<tr class=\"line-odd\">");
                %>
                                <td align="center">
                                <%
                                if(content.get("de_isovertime").toString().equals("")||content.get("de_isovertime").toString().equals("0"))
                                {%>
                                <center><span style=color:green>●</span></center>
                                <%
                                }
                                else
                                {
                                %>
                                <center><span style=color:red>●</span></center>
                                <%}%>
                                </td>
                                <td align="center">
                                <%
                            if(content.get("de_status").toString().equals("1"))
                                out.println("发送");
                                //out.println(content.get("wo_id").toString());
                            if(content.get("de_status").toString().equals("2"))
                                out.println("发送签收");
                            %></td>
                                <td align="center"><%=content.get("cp_name")%></td>
                                <td align="center"><%=content.get("senddept")%></td>
                                <td align="center"><%=content.get("cw_applyingname")%></td>
                                <td align="center"><%=content.get("receivedept")%></td>
                                <td align="center"><%=content.get("de_sendtime")%></td>
                                <td align="center"><%=content.get("de_signtime")%></td>
                                <td align="center"><%=content.get("de_feedbacktime")%></td>
                                <td align="center"><%=content.get("de_feedbacksigntime")%></td>
                                <td align="center">
                                 <a href="CorrInfo.jsp?cw_id=<%=content.get("cw_id").toString()%>&CorrType=see">查看</a>
                                </td>
            </tr>
</form>
<%
    }
      out.println("<tr><td colspan=12>" + dImpl.getTail(request) + "</td></tr>"); //输出尾部文件
  }
  else
  {
    out.println("<tr><td colspan=10>没有记录！</td></tr>");
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

<%@include file="/system/app/skin/bottom.jsp"%>