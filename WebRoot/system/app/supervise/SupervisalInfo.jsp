<%@page contentType="text/html; charset=GBK"%>
<%@include file="../skin/pophead.jsp"%>
<%@page import="com.app.*"%>

<!--弹出督办单，写入督办信息-->
<%
String wo_id = "";
wo_id = CTools.dealString(request.getParameter("wo_id")).trim();

String dt_id="";
dt_id = CTools.dealString(request.getParameter("dt_id")).trim();

String dt_name="";
dt_name = CTools.dealString(request.getParameter("dt_name")).trim();

String co_id = "";
co_id = CTools.dealString(request.getParameter("co_id")).trim();

%>
<form name="formData" action="SupervisalInfoResult.jsp" method="post">
<table class="main-table" width="100%" border="0" cellspacing="0" cellpadding="0">
<tr class ="title1">
<td colspan="6" align="center" height="20%" width="100%" ><font size="2" >督办单</font>
</td>
</tr>


 <tr class="line-even">
    <td align="right" >督办对象:
 </td>
 <td>
 <input type="text" name="svName" size="40%" class = "text-line"  value="<%=dt_name%>"/>
 </td>
</tr>


   <tr class="line-even">
    <td align="right" >督办信息:
 </td>
 <td>

<textarea  name="svContent" rows="6" cols="50" class = "text-line" ></textarea>
 </td>
</tr>
  <tr class="line-even">
    <td align="right" >反馈信息:
 </td>
 <td>
<br>
<br>
<textarea  name="ungerinfom" rows="6" cols="50" class = "text-line" readonly></textarea>
 </td>
</tr>

<tr class="title1" align="center">
<td colspan="6">
<input type="submit" class="bttn" value="提 交" >&nbsp;
<input type="reset" class="bttn"  value="重 写">&nbsp;
<input type="button" class="bttn" name="back" value="关闭" onclick="window.close()">
<input type="hidden" name="wo_id" value="<%=wo_id%>">
<input type="hidden" name="dt_id" value="<%=dt_id%>">
<input type="hidden" name="co_id" value="<%=co_id%>">
</td>
 </tr>
</table>

</form>
<%@include file="../skin/popbottom.jsp"%>