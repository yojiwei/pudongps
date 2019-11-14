<%@page contentType="text/html; charset=GBK"%>
<%@include file="../head.jsp"%>
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
//update20080122

CDataCn dCn=null;   //新建数据库连接对象
CDataImpl dImpl=null;  //新建数据接口对象

try {
 dCn = new CDataCn(); 
 dImpl = new CDataImpl(dCn); 

String strSql = "select * from TB_holiday where HD_DATE=to_date('"+strDate+"','YYYY-MM-DD')";
Hashtable content = dImpl.getDataInfo(strSql);
if(content!=null)
{
    HD_remark = content.get("hd_remark").toString();
    isHoliday = content.get("hd_flag").toString();
}
%>
<table class="main-table" align="center" width="100%">
<form name="formData" method="post">
   <tr class="title1">	 
	<TD width="80%" align="center">设置节假日</TD>	
   </tr>
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
                <input type="text" class="text-line" name="remark"  value="<%=HD_remark%>" size=40 ></td>
            </tr>
         </table>
     </td>
   </tr>
   <tr class="line-odd" align="center">
       <td colspan="2">
          <input type="button" class="bttn" value=" 确 定 "  name="fsubmit" onclick="checkForm()">
          <input type="reset" class="bttn" value=" 重 写 " name="freset">&nbsp;
          <input type="button" class="bttn" value=" 返 回 " name="freturn" onclick="history.go(-1);"></td>
   </tr>
</form>
</table>
<%
dImpl.closeStmt();
dCn.closeCn();
%>
<%@include file="../bottom.jsp"%>

<%


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
