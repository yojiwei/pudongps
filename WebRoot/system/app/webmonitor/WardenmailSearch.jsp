<%@page contentType="text/html; charset=GBK"%>
<%@include file="/system/app/skin/head.jsp"%>
<script LANGUAGE="javascript" src="../infopublish/common/common.js"></script>
<%
CDataCn dCn = null;
CDataImpl dImpl = null;
try{
dCn = new CDataCn();
dImpl = new CDataImpl(dCn);

String wd_id = "";
String wd_name = "";//区长
Vector vPage = null;
Calendar cal = new GregorianCalendar();
cal.add(GregorianCalendar.DATE,-1);
SimpleDateFormat theDate = new SimpleDateFormat("yyyy-MM-dd");
String ul_time = theDate.format(cal.getTime());

%>
<%@include file="/system/app/skin/skin4/template/info_top.jsp"%>
<!--    模块名称开始    -->
区长信箱来信情况查询
<!--    模块名称结束    -->
<%@include file="/system/app/skin/skin4/template/info_funtion.jsp"%>
<!--    功能按钮开始    -->

<!--    功能按钮结束    -->
<%@include file="/system/app/skin/skin4/template/info_main.jsp"%>
<!--    表单提交开始    -->
<table align="center" width="100%" CELLPADDING="1" cellspacing="1">
<form name="formData" method="post" action="WardenmailList.jsp">
	<tr class="line-odd">
		<td width="40%" align="right">区长信箱：</td>
		<td align="left">
			<select name="conntype" class="f12">
			<option value="oo" selected>请选择</option>
      <%
      String Sql_wd = "select wd_id,wd_name from tb_warden order by wd_sequence";
      vPage = dImpl.splitPage(Sql_wd,request,20);
      if (vPage!=null)
      {
       for(int i=0;i<vPage.size();i++)
      {
       Hashtable content = (Hashtable)vPage.get(i);
       wd_id = content.get("wd_id").toString();
       wd_name = content.get("wd_name").toString();
      %>
      <option value="<%=wd_id%>"><%=wd_name%></option>
      <%
       }
       }
      %>
     </select>
		</td>
	</tr>
	<tr class="line-odd" align="left">
		<td width="40%" align="right">查询时间：</td>
		<td>
			<input name="begin_time" style="cursor:hand" class="text-line" readonly size="10" onclick="showCal()" value="<%=ul_time%>">&nbsp;至
			<input name="end_time" style="cursor:hand" class="text-line" readonly size="10" onclick="showCal()" value="<%=ul_time%>">
		</td>
	</tr>
	<tr class="outset-table" width="100%">
		<td colspan="2" class="outset-table">
			<input type="submit" class="bttn" value="搜索">&nbsp;
			<input type="reset" class="bttn" value="重写">&nbsp;
		</td>
	</tr>
<input type="hidden" name="OPType" value="search">
<input type="hidden" name="status1" value="">
</form>
</table>
<!--    表单提交结束    -->
<%@include file="/system/app/skin/skin4/template/info_bottom.jsp"%> 
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
                                     
