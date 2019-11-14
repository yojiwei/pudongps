<%@page contentType="text/html; charset=GBK"%>
<title>催办单</title>
<%@include file="../skin/pophead.jsp"%>
<%@page import="com.app.*"%>

<!--弹出催办单，写入催办信息-->

<%
String wo_id = "";
wo_id = CTools.dealString(request.getParameter("wo_id")).trim();

%>
<%
String co_id = "";
co_id = CTools.dealString(request.getParameter("co_id")).trim();
%>

<%String dt_id="";
dt_id = CTools.dealString(request.getParameter("dt_id")).trim();
//out.println("dt_id is"+dt_id);
%>

<%String dt_name="";
dt_name = CTools.dealString(request.getParameter("dt_name")).trim();
%>


<form name="formData" action="UrgentInfoResult.jsp" method="post">
<table class="main-table" width="450" height="200"  border="0" cellspacing="0" cellpadding="0">
<tr class ="title1">

<td colspan="6" align="center" height="20" width="100%" ><font size="2" >催办单</font>
</td>
</tr>

 <tr class="line-even">
    <td align="right" >催办对象:
 </td>
 <td>
 <input type="text" name="UngerName" size="40%" value = <%=dt_name%> class = "text-line" >
 </td>
</tr>
   <tr class="line-odd">
    <td align="right" >催办信息:
 </td>
 <td>
<textarea  name="UngerContent" rows="10" cols="50" class = "text-line" ></textarea>
 </td>
</tr>

        <tr class="title1" align="center">
        <td colspan="6">
	<input type="submit" class="bttn" value="提 交" >&nbsp;
	<input type="reset" class="bttn"  value="重 写">&nbsp;
	<input type="button" class="bttn" name="back" value="返 回" onclick="window.close()">
        </td>
         </tr>
</table>
<input type="hidden" name="wo_id" value="<%=wo_id%>">
<input type="hidden" name="dt_id" value="<%=dt_id%>">
<input type="hidden" name="co_id" value="<%=co_id%>">
</form>
<%@include file="../skin/popbottom.jsp"%>