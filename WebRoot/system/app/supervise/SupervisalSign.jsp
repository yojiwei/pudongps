<%@page contentType="text/html; charset=GBK"%>
<%@include file="/system/app/skin/head.jsp"%>
<%
CDataCn dCn = null;
CDataImpl dImpl = null;
try{
dCn = new CDataCn();
dImpl = new CDataImpl(dCn);
//
String sqlWait="";
String sv_dtname="";
String sv_content="";
String de_id="";
String sv_id="";
String sv_type="";
String dt_name="";
dt_name=CTools.dealString(request.getParameter("dt_name")).trim();
sv_type=CTools.dealString(request.getParameter("sv_type")).trim();
String selfdtid="";
String sender_id="";
CMySelf self = (CMySelf)session.getAttribute("mySelf");

selfdtid=String.valueOf(self.getDtId());//取当前用户部门id的值
sender_id=String.valueOf(self.getMyID());//取当前用户id的值
sqlWait="select a.sv_id,a.sv_dtname,a.sv_content,a.sv_type,a.sv_feedback,b.de_status,b.de_id,b.de_sendtime ,to_char(b.de_signtime,'yyyy-mm-dd hh24:mi:ss')de_signtime,b.de_feedbacktime,d.dt_name ,d.dt_id from tb_supervise a,tb_documentexchange b ,tb_deptinfo d  where ( b.de_status='2' or b.de_status='5') and  d.dt_name like '%"+dt_name+"%'  and  a.sv_type like '%"+sv_type+"%' and ( a.sv_type='4' or a.sv_type='5') and (b.de_type='4' or b.de_type='5') and b.de_receiverdeptid="+selfdtid+" and  a.sv_id=b.DE_PRIMARYID  and  b.de_senddeptid =d.dt_id order by b.de_sendtime desc";

%>
<%@include file="/system/app/skin/skin4/template/list_top.jsp"%>
<!--    模块名称开始    -->
已签收督办列表
<!--    模块名称结束    -->
<%@include file="/system/app/skin/skin4/template/list_function.jsp"%>                                                            
<!--    功能按钮开始    -->
已签收督办列表
<!--    功能按钮结束    -->
<%@include file="/system/app/skin/skin4/template/list_listtop.jsp"%>                                                                                        
<!--    列表开始    -->
<table class="FindAreaTable1" cellspacing="1" rules="cols" border="0" id="ctl00_DataGrid_DataGrid1" style="border-width:0px;">
<tr class="bttn">
            <td width="2%" class="outset-table" align="center">序号</td>
            <td width="5%" class="outset-table" align="center" title="是否签收">状态</td>
            <td width="10%" class="outset-table" align="center" >类型</td>
            <td width="10%" class="outset-table" align="center">来电单位</td>
            <td width="10%" class="outset-table" align="center">签收时间</td>
            <td width="5%" class="outset-table" align="center"> 查看</td>
         </tr>
<%
		Vector vectorPage = dImpl.splitPage(sqlWait,request,20);
		if(vectorPage!=null)
		{
			for(int i=0;i<vectorPage.size();i++)
			{
				Hashtable content = (Hashtable)vectorPage.get(i);

         sv_content = content.get("sv_content").toString();
         sv_dtname=content.get("sv_dtname").toString();
         de_id=content.get("de_id").toString();
         sv_id=content.get("sv_id").toString();
         sv_type=content.get("sv_type").toString();

          dt_name=content.get("dt_name").toString();
          String dt_id=content.get("dt_id").toString();
          String de_signtime=content.get("de_signtime").toString();
          String de_status=content.get("de_status").toString();
          String sv_feedback=content.get("sv_feedback").toString();

			  if(i % 2 == 0)  out.print("<tr class=\"line-even\">");
				else out.print("<tr class=\"line-odd\">");

%>
                <td align="center"><%=i+1%></td>
                <td align="center">
                   <%
                    if(de_status.equals("2"))
                                out.println("<font color=\"red\">签收</font>");
                         if(de_status.equals("1"))
                                out.println("<font color=\"red\">未签收</font>");

                        if(de_status.equals("5"))
                                out.println("<font color=\"red\">反馈签收</font>");
                        if(de_status.equals("4"))
                                out.println("<font color=\"red\">反馈未签收</font>");
                   %>
                </td>
                <td align="center">
               	<%  if(sv_type.equals("4"))
           					out.println("项目督办");
                    if(sv_type.equals("5"))
              			out.println("协调单督办");
                %>
                 </td>
                <td align="center"><%=content.get("dt_name")%></td>
                <td align="center"><%=content.get("de_signtime")%></td>

      <%
      if(sv_type.equals("4"))
        {
       %>

            <td align="center"><a href="#" onclick="javascript:window.open('FeedbackInfo.jsp?sv_id=<%=sv_id%>','督办单','Top=0px,Left=0px,Width=470px,Height=290px,toolbar=no,location=no,derectories=no,status=no,menubar=no,scrollbars=yes');">
            查看</a></td>
        <%
        }
        %>


        <%
      if(sv_type.equals("5"))
        {
        %>
     <td align="center"><a href="#" onclick="javascript:window.open('FeedbackCoInfo.jsp?sv_id=<%=sv_id%>','督办单','Top=0px,Left=0px,Width=470px, Height=290px,toolbar=no,location=no,derectories=no,status=no,menubar=no,scrollbars=yes');">查看</a></td>
        <%
        }
        %>
</form>
<%
    }
  }
  else
  {
    out.println("<tr><td colspan=10></td></>");
  }
%>
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