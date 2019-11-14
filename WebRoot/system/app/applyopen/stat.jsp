<%@page contentType="text/html; charset=GBK"%>
<%@page import="com.util.CDate"%>
<%@include file="/system/app/skin/head.jsp"%>
<script language="javascript" src="/website/include/common.js"></script>
<script language="javascript" src="/website/include/check.js"></script>
<script language="Javascript">
function checkForm()
{
  var form = document.formData;
  form.action="statlist.jsp";
  form.submit();
}
function tochecked(sdate)
{
	var form = document.formData;
	if(sdate!=form.HandleTime1.value){
	  form.applyTime.checked=true;
	}
}
function tochecked1(sdate)
{
	var form = document.formData;
	if(sdate!=form.HandleTime3.value){
	  form.finishTime.checked=true;
	}
}
</script>
<%
CDate today = new CDate();
String strDate = today.getThisday();
String strDate1= today.getLastday();
String strTitle = "";
String HD_remark = "";
String isHoliday = "";
//update20080122

CDataCn dCn=null;   //新建数据库连接对象
CDataImpl dImpl=null;  //新建数据接口对象

try {
 dCn = new CDataCn(); 
 dImpl = new CDataImpl(dCn); 

String sql = "select dt_id,dt_name from tb_deptinfo where dt_infoopendept = 1 order by dt_sequence";
Vector vpd = dImpl.splitPage(sql,200,1);
String strSql = "select * from TB_holiday where HD_DATE=to_date('"+strDate+"','YYYY-MM-DD')";
Hashtable content = dImpl.getDataInfo(strSql);
if(content!=null)
{
    HD_remark = content.get("hd_remark").toString();
    isHoliday = content.get("hd_flag").toString();
}

strTitle = "信息公开一体化 > 按条件统计";
%>

  <form name="formData" method="post">
  <table class="main-table" width="100%">
  <tr>
  <td width="100%">
  <table class="content-table" width="100%">
    <tr class="title1">
      <td colspan="9" align="center">
	  <table WIDTH="100%" BORDER="0" CELLSPACING="1" CELLPADDING="1">
          <tr>
            <td valign="center" align="left"><%=strTitle%></td>
            <td valign="center" align="right" nowrap><img src="../../images/split.gif" align="middle" border="0" WIDTH="5" HEIGHT="8"> <img src="../../images/goback.gif" border="0" onClick="javascript:history.back();" title="返回" style="cursor:hand" align="absmiddle"> <img src="../../images/split.gif" align="middle" border="0" WIDTH="5" HEIGHT="8"> </td>
          </tr>
        </table>
		</td>
    </tr>
    <tr class="line-odd">
      <td align="right" width="243" height="1">
	  <input type="checkbox" name="applyTime" value="1"> 按用户申请时间统计：</td>
      <td width="712" height="1" align="left">
	  <input size="17" type="text" class="text-line" name="HandleTime1" value="<%=strDate1%>" readonly>
        &nbsp; <img src="images/calendar.gif" border="0" onClick="showCal(HandleTime1),tochecked('<%=strDate1%>')" align="absmiddle" WIDTH="22" HEIGHT="21" style="cursor:hand">&nbsp;&nbsp;－&nbsp;&nbsp;
        <input size="17" type="text" class="text-line" name="HandleTime2" value="<%=strDate%>" readonly>
        &nbsp; <img src="images/calendar.gif" border="0" onClick="showCal(HandleTime2)" align="absmiddle" WIDTH="22" HEIGHT="21"  style="cursor:hand"> </td>
    </tr>
    <tr class="line-even">
      <td align="right" width="243" height="1">
	  <input type="checkbox" name="finishTime" value="2"> 按办理终结时间统计：</td>
      <td width="712" height="1" align="left">
	  <input size="17" type="text" class="text-line" name="HandleTime3" value="<%=strDate1%>" readonly>
        &nbsp; <img src="images/calendar.gif" border="0" onClick="showCal(HandleTime3),tochecked1('<%=strDate1%>')" align="absmiddle" WIDTH="22" HEIGHT="21" style="cursor:hand">&nbsp;&nbsp;－&nbsp;&nbsp;
        <input size="17" type="text" class="text-line" name="HandleTime4" value="<%=strDate%>" readonly>
        &nbsp; <img src="images/calendar.gif" border="0" onClick="showCal(HandleTime4)" align="absmiddle" WIDTH="22" HEIGHT="21"  style="cursor:hand"> </td>
    </tr>
    <tr class="line-odd">
      <td align="right" width="243" height="1">统计部门：</td>
      <td width="712" height="1" align="left" valign="left">
      	<select name="depart" >
          <option value="-1">全部部门</option>
          <%
	if(vpd!=null)
	{
		for(int i=0;i<vpd.size();i++)
		{
			Hashtable content1 = (Hashtable) vpd.get(i);
			String dpId = content1.get("dt_id").toString();
			String dpName = content1.get("dt_name").toString();
%>
          <option value="<%=dpId%>"><%=dpName%></option>
          <%
		}
	}
%>
        </select>
      </td>
    </tr>
    <tr class="line-even">
      <td align="right" width="243" height="1">项目当前状态：</td>
      <td width="712" height="1" align="left">
      	<input type="checkbox" name="status" value="1"> 处理中 
      	<input type="checkbox" name="status" value="2"> 已完成 
      	<input type="checkbox" name="status" value="3"> 征询中 
      	<input type="checkbox" name="status" value="4"> 延期中 
      </td>
    </tr>
    <tr class="line-odd">
      <td align="right" width="243" height="1">项目过程状态：</td>
      <td width="712" height="1" align="left">
      	<input type="checkbox" name="genre" value="指派"> 指 派 
      	<input type="checkbox" name="genre" value="认领"> 认 领 
      	<input type="checkbox" name="genre" value="转办"> 转 办 
      	<input type="checkbox" name="genre" value="网上申请"> 网上申请 
      	<input type="checkbox" name="genre" value="现场申请"> 现场申请 
      </td>
    </tr>
    <tr class="title1" align="center">
      <td colspan="2"><input type="button" class="bttn" value=" 确 定 "  name="fsubmit" onClick="checkForm()">
        <input type="reset" class="bttn" value=" 重 写 " name="freset">
        &nbsp;
        <!--input type="button" class="bttn" value=" 返 回 " name="freturn" onclick="history.go(-1);"-->
		</td>
    </tr>
	</table>
    </td>
    </tr>
  </table>
</form>
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
<%@include file="/system/app/skin/bottom.jsp"%>