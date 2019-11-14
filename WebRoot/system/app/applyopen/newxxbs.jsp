<%@page contentType="text/html; charset=GBK"%>
<%@include file="/system/app/skin/head.jsp"%>
<%
String dt_name = "";
Vector vPage = null;
Hashtable content = null;
	
CDataCn dCn = null;
CDataImpl dImpl = null;
try{
dCn = new CDataCn();
dImpl = new CDataImpl(dCn);
%>
<%@include file="/system/app/skin/skin4/template/info_top.jsp"%>
<!--    模块名称开始    -->
信息报送
<!--    模块名称结束    -->
<%@include file="/system/app/skin/skin4/template/info_funtion.jsp"%>
<!--    功能按钮开始    -->

<!--    功能按钮结束    -->
<%@include file="/system/app/skin/skin4/template/info_main.jsp"%>
<!--    表单提交开始    -->
<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<form name="formData" action="xxtj.jsp" method="post" xxx-onsubmit="merger()">
	<tr class="line-odd">
		<td colspan="4" align="center" height="20">
			<font size="2">信息报送</font>
		</td>
	<tr class="bttn">
		<td align="center" colspan=2>
			请选择报送日期：<select name="beginYear">
				<%
					java.util.Calendar c=java.util.Calendar.getInstance();
					if(c.get(Calendar.DAY_OF_MONTH)<11){
						c.add(Calendar.MONTH, -1);
								//out.println("报送的是"+c.get(Calendar.MONTH));
					}
					java.util.Date ai_date = new java.util.Date();
					java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat(
							"yyyy-MM");
					int yea = c.get(Calendar.YEAR);;
					int beginYear = 0;
					out.print("<option value=" + yea + ">" + yea + "</option>");
					for (int i = 1; i < 10; i++) {
						beginYear = yea - i;
						out.print("<option value=" + beginYear + ">" + beginYear
						+ "</option>");
					}
				%>
			</select>
			&nbsp;年
			<input type=hidden name="look" value="true">
			<select name="beginMon">
				<%
					

					int yuf = Integer.parseInt(sdf.format(ai_date).substring(5, 7));
					int beginMe = 0;
					for (int i = 1; i < 13; i++) {
						if (i == (c.get(Calendar.MONTH)+1))
							out.print("<option value=" + i + " selected>" + i
							+ "</option>");
						else
							out.print("<option value=" + i + ">" + i + "</option>");
					}
				%>
			</select>
			&nbsp;月
		</td>
	</tr>
	<tr class="outset-table" align="center">
		<td colspan="4">
			<input type="submit" class="bttn" value="信息报送">
			&nbsp;
			<input type="button" class="bttn" name="back" value="返 回"
				onclick="history.back();">
		</td>
	</tr>
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
                                     
