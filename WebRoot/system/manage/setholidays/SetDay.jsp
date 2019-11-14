<%@page contentType="text/html; charset=GBK"%>
<%@include file="/system/app/skin/head.jsp"%>
<script language="javascript" src="/website/include/common.js"></script>
<script language="javascript" src="/website/include/check.js"></script>
<script language="Javascript">
function checkForm()
{
  var form = document.formData;
  if(form.HandleTime.value.length==0)
  {
    alert('起始时间不能为空！')
    form.HandleTime.focus();
    return (false);
  }
  if(form.HandleTime2.value.length==0)
  {
    alert('结束时间不能为空！')
    form.HandleTime2.focus();
    return (false);
  }
  form.action="SetDayResult.jsp";
  form.submit();
}
</script>
<%
String strDate = CTools.dealString(request.getParameter("strDate"));
String HD_remark = "";
String isHoliday = "";
//
CDataCn dCn = null;
CDataImpl dImpl = null;
try{
dCn = new CDataCn();
dImpl = new CDataImpl(dCn);
//
String strSql = "select * from TB_holiday where HD_DATE=to_date('"+strDate+"','YYYY-MM-DD')";
Hashtable content = dImpl.getDataInfo(strSql);
if(content!=null)
{
    HD_remark = content.get("hd_remark").toString();
    isHoliday = content.get("hd_flag").toString();
}
%>
<%@include file="/system/app/skin/skin4/template/info_top.jsp"%>
<!--    模块名称开始    -->
设置节假日
<!--    模块名称结束    -->
<%@include file="/system/app/skin/skin4/template/info_funtion.jsp"%>
<!--    功能按钮开始    -->

<!--    功能按钮结束    -->
<%@include file="/system/app/skin/skin4/template/info_main.jsp"%>
<!--    表单提交开始    -->
<table align="center" width="100%" CELLPADDING="1" cellspacing="1">
<form name="formData" method="post">
   <tr>
     <td width="100%">
         <table width="100%" class="content-table" height="1">
            <tr class="line-even">
                <td align="right" width="100" height="1">时间：</td>
                <td width="526" height="1">&nbsp;&nbsp;&nbsp;
                  <input size="17" type="text" class="text-line" name="HandleTime" value="<%=strDate%>" readonly>&nbsp;
                  <img src="../images/calendar.gif" border="0" onclick="showCal(HandleTime)" align="absmiddle" WIDTH="22" HEIGHT="21" style="cursor:hand">&nbsp;&nbsp;－&nbsp;&nbsp;
                  <input size="17" type="text" class="text-line" name="HandleTime2" value="<%=strDate%>" readonly>&nbsp;
                  <img src="../images/calendar.gif" border="0" onclick="showCal(HandleTime2)" align="absmiddle" WIDTH="22" HEIGHT="21"  style="cursor:hand">
                </td>
            </tr>
            <tr class="line-odd">
                <td align="right" width="100" height="1">假日/工作日：</td>
                <td width="526" height="1">&nbsp;&nbsp;假日&nbsp;
		<input type="radio" class="text-line" name="holiday"  value="1" <% if(isHoliday.equals("1")) out.print("checked");else if(isHoliday.equals("")) out.print("checked");%>>&nbsp;&nbsp;&nbsp;&nbsp;工作日&nbsp;<input type="radio" class="text-line" name="holiday"  value="0" <% if(isHoliday.equals("0")) out.print("checked");%>></td>
            </tr>
            <tr class="line-even">
                <td align="right" width="100" height="1">备注：</td>
                <td width="526" height="1" valign="center">&nbsp;&nbsp;
                <input type="text" class="text-line" name="remark"  value="<%=HD_remark%>" size=40 maxlength="100"></td>
            </tr>
         </table>
     </td>
   </tr>
   <tr class="outset-table" align="center">
       <td colspan="2">
          <input type="button" class="bttn" value=" 确 定 "  name="fsubmit" onclick="checkForm()">
          <input type="reset" class="bttn" value=" 重 写 " name="freset">&nbsp;
          <input type="button" class="bttn" value=" 返 回 " name="freturn" onclick="history.go(-1);"></td>
   </tr>
</form>
</table>
<!--    表单提交结束    -->
<%@include file="/system/app/skin/skin4/template/info_bottom.jsp"%> 
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
                                     
