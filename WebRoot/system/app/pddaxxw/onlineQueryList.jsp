<%@page contentType="text/html; charset=GBK"%>
<%@include file="/system/app/skin/head.jsp"%>
<script>
	function tocl(clvalue){
		var cltype = clvalue;
		window.location.href="onlineList.jsp?clstatus="+cltype;		
	}
</script>
<%
String sjs="";
String wcl = "";
String ydf = "";
String strTitle = "";
String beginTime = "";
String endTime = "";

CDataCn dCn = null;
CDataImpl dImpl = null;
try{
dCn = new CDataCn();
dImpl = new CDataImpl(dCn);
beginTime = CTools.dealString(request.getParameter("beginTime")).trim();
endTime = CTools.dealString(request.getParameter("endTime")).trim();

strTitle = "咨询统计";


String sql_list = " select count(decode(dx_status,'0','1','1','1','')) as sjs,count(decode(dx_status,'0','1','')) as wcl,count(decode(dx_status,'1','1','')) as ydf from tb_daxx where dx_type='ask' ";
if (!beginTime.equals(""))
{
 	sql_list += " and dx_applytime > to_date('" + beginTime + " 00:00:00','yyyy-mm-dd hh24:mi:ss') ";
}
if (!endTime.equals(""))
{
	sql_list += " and dx_applytime < to_date('" + endTime + " 23:59:59','yyyy-mm-dd hh24:mi:ss')";
}
//out.println(sql_list);
%>
<%@include file="/system/app/skin/skin4/template/list_top.jsp"%>
<!--    模块名称开始    -->
<%=strTitle%>
<!--    模块名称结束    -->
<%@include file="/system/app/skin/skin4/template/list_function.jsp"%>                                                            
<!--    功能按钮开始    -->
<!--    功能按钮结束    -->
<%@include file="/system/app/skin/skin4/template/list_listtop.jsp"%>                                                                                        
<!--    列表开始    -->
<table class="FindAreaTable1" cellspacing="1" rules="cols" border="0" id="ctl00_DataGrid_DataGrid1" style="border-width:0px;">
	<form name="formData">
	</tr>
	<tr class="bttn">
	<td width="25%" class="outset-table" align="center">收件数</td>
	<td width="25%" class="outset-table" align="center">未处理</td>
	<td width="15%" class="outset-table" align="center">已答复</td>
	</tr>
	<%
	Vector vectorList = dImpl.splitPage(sql_list,request,20);
	Hashtable content = null;
	if(vectorList!=null)
	{
		for(int i=0;i<vectorList.size();i++)
		{
			content = (Hashtable)vectorList.get(i);
			sjs = CTools.dealNull(content.get("sjs"));
			wcl = CTools.dealNull(content.get("wcl"));
			ydf = CTools.dealNull(content.get("ydf"));

			if(i % 2 == 0)  out.print("<tr class=\"line-even\">");
			else out.print("<tr class=\"line-odd\">");
	%>
	<td align="center"><a href="onlineAskList.jsp?clstatus=2&begintime=<%=beginTime%>&endtime=<%=endTime%>"><%=sjs%></a></td>
	<td align="center"><a href="onlineAskList.jsp?clstatus=0&begintime=<%=beginTime%>&endtime=<%=endTime%>"><%=wcl%></a></td>
	<td align="center"><a href="onlineAskList.jsp?clstatus=1&begintime=<%=beginTime%>&endtime=<%=endTime%>"><%=ydf%></a></td>
</tr>
<%
    }
out.print("</form>");
  }

  else
  {
    out.println("<tr><td colspan=20>没有记录！</td></tr>");
  }
%>
</table>
<!--    列表结束    -->
<%@include file="/system/app/skin/skin4/template/list_bottom.jsp"%> 
<%
}
catch(Exception e){
	System.out.println(new java.util.Date() + "--"
			+ request.getServletPath() + " : " + e.getMessage());
}
finally{
	dImpl.closeStmt();
	dCn.closeCn(); 
}
%>
<%@include file="/system/app/skin/bottom.jsp"%>