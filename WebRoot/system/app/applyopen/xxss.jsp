<%@page contentType="text/html; charset=GBK"%>
<%@include file="/system/app/skin/head.jsp"%>
<%
CDataCn dCn = null;
CDataImpl dImpl = null;
String dt_name = "";
Vector vPage = null;
Hashtable content = null;
try{
dCn = new CDataCn();
dImpl = new CDataImpl(dCn);
%>
<%@include file="/system/app/skin/skin4/template/info_top.jsp"%>
<!--    模块名称开始    -->
信息统计查询
<!--    模块名称结束    -->
<%@include file="/system/app/skin/skin4/template/info_funtion.jsp"%>
<!--    功能按钮开始    -->

<!--    功能按钮结束    -->
<%@include file="/system/app/skin/skin4/template/info_main.jsp"%>
<!--    表单提交开始    -->
<table  width="100%" border="0" cellspacing="0" cellpadding="0">
<form name="formData" action="xxtj.jsp" method="post" xxx-onsubmit="merger()">
	<tr class="bttn">
		<td colspan="4" align="center" height="20">
			<font size="2">信息统计查询</font>
		</td>
	<tr class="bttn">
		<td align="center">
			日期
		</td>
		<td align="left">
			<select name="beginYear">
				<%
					java.util.Date ai_date = new java.util.Date();
					java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat(
							"yyyy-MM");
					int yea = Integer.parseInt(sdf.format(ai_date).substring(0, 4));
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
			<select name="beginMon">
				<%
					int yuf = Integer.parseInt(sdf.format(ai_date).substring(5, 7));
					int beginMe = 0;
					for (int i = 1; i < 13; i++) {
						if (i == yuf)
							out.print("<option value=" + i + " selected>" + i
							+ "</option>");
						else
							out.print("<option value=" + i + ">" + i + "</option>");
					}
				%>
			</select>
			&nbsp;月
		</td>
		<td align="center">
			部门名称
		</td>
		<td align="left">
			<select name="dt_id">
				<option value="">----</option>
				<%
					String sql = "select dt_id,dt_name from tb_deptinfo where dt_infoopendept = 1 order by dt_sequence";
					vPage = dImpl.splitPage(sql,150,1);
					if (vPage != null) {
						for (int i = 0; i < vPage.size(); i++) {
							content = (Hashtable) vPage.get(i);
							dt_name = content.get("dt_name").toString();
							out.print("<option value="
							+ content.get("dt_id").toString() + ">" + dt_name
							+ "</option>");
						}
					}
				%>
			</select>
		</td>
	</tr>
	<tr class="outset-table" align="center">
		<td colspan="4">
			<input type="submit" class="bttn" value="查 询">
			&nbsp;
			<input type="button" class="bttn" name="back" value="返 回"
				onclick="history.back();">
			<input type="hidden" name="status1" value="">
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
                                     
