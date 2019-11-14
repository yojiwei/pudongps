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
String ur_type="";
String ur_id="";
String ur_dtname="";
String ur_content="";
String de_id="";
String de_signtime="";
String de_sendtime="";
String dt_id="";
String dt_name="";
String wo_projectname="";

String selfdtid="";
String sender_id="";
CMySelf self = (CMySelf)session.getAttribute("mySelf");

selfdtid = String.valueOf(self.getDtId());//取当前用户部门id的值
sender_id = String.valueOf(self.getMyID());//取当前用户id的值

ur_id=CTools.dealString(request.getParameter("pjcode")).trim();//编号
ur_type=CTools.dealString(request.getParameter("ur_type")).trim();
ur_dtname=CTools.dealString(request.getParameter("work")).trim();
dt_name=CTools.dealString(request.getParameter("dt_name")).trim();
sqlWait="select a.ur_id, a.ur_dtname, a.ur_content,a.ur_type, b.de_status, b.de_id, b.de_sendtime ,to_char(b.de_signtime,'yyyy-mm-dd hh24:mi:ss') de_signtime,c.dt_id,c.dt_name from tb_urgent a,tb_documentexchange b  ,tb_deptinfo c  where  b.de_status='2' and (a.ur_type='2' or a.ur_type='3') and (b.de_type='2' or b.de_type='3') and  c.dt_name like '%"+dt_name+"%'  and   a.ur_type like '%"+ur_type+"%' and  b.de_receiverdeptid="+selfdtid+" and a.ur_id=b.DE_PRIMARYID and b.de_senddeptid =c.dt_id order by b.de_signtime desc";

%>
<%@include file="/system/app/skin/skin4/template/list_top.jsp"%>
<!--    模块名称开始    -->
已签收摧办列表
<!--    模块名称结束    -->
<%@include file="/system/app/skin/skin4/template/list_function.jsp"%>                                                            
<!--    功能按钮开始    -->

<!--    功能按钮结束    -->
<%@include file="/system/app/skin/skin4/template/list_listtop.jsp"%>                                                                                        
<!--    列表开始    -->
<table class="FindAreaTable1" cellspacing="1" rules="cols" border="0" id="ctl00_DataGrid_DataGrid1" style="border-width:0px;">
	 <tr class="bttn">
            <td width="2%" class="outset-table" align="center">序号</td>
            <td width="5%" align="center" class="outset-table" >状态</td>
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
				ur_type = content.get("ur_type").toString();
        ur_id=content.get("ur_id").toString();
        ur_content=content.get("ur_content").toString();
        ur_dtname=content.get("ur_dtname").toString();
        de_id=content.get("de_id").toString();
        de_sendtime=content.get("de_sendtime").toString();
        de_signtime=content.get("de_signtime").toString();
        String color=content.get("de_status").toString();
        dt_id=content.get("dt_id").toString();
        dt_name=content.get("dt_name").toString();
				if(i % 2 == 0)  out.print("<tr class=\"line-even\">");
				else out.print("<tr class=\"line-odd\">");
%>
                <td align="center"> <%=i+1%></td>

                <td align="center">
                <%  if(color.equals("2"))
                                out.println("<font color=\"red\">签收</font>");
                                 else
                                out.println("<font color=\"red\">发送</font>");
                %>
                 </td>
                <td align="center">
   <%  if(ur_type.equals("2"))
 out.println("项目催办");
   if(ur_type.equals("3"))
 out.println("协调单催办");
                %>

                </td>
                <td align="center"><%=content.get("dt_name")%></td>
                <td align="center"><%=content.get("de_signtime")%></td>
                     <%
                    if(ur_type.equals("2"))
                      {
                     %>
               <td align="center"><a href="#" onclick="javascript:window.open('Urgentlist.jsp?ur_id=<%=ur_id%>&urgentlist=2','督办单','Top=0px,Left=0px,Width=470px, Height=200px,toolbar=no,location=no,derectories=no,status=no,menubar=no,scrollbars=yes');">查看</a></td>
                      <%
                      }
                    if(ur_type.equals("3"))
                      {
                      %>
              <td align="center"><a href="#" onclick="javascript:window.open('UrgentCoList.jsp?ur_id=<%=ur_id%>&urgentcolist=2','督办单','Top=0px,Left=0px,Width=470px, Height=200px,toolbar=no,location=no,derectories=no,status=no,menubar=no,scrollbars=yes');">查看</a></td>
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