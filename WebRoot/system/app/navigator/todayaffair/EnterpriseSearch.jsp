<%@page contentType="text/html; charset=GBK"%>
<%@include file="/system/app/skin/head.jsp"%>
<%
String subjectCode="";//获得栏目代码
subjectCode=CTools.dealString(request.getParameter("subjectCode")).trim();
%>
<script LANGUAGE="javascript" src="/system/common/treeview/chooseTreeJs.jsp"></script>
<script LANGUAGE="javascript" src="../../infopublish/common/common.js"></script>
<script language="javascript">
function doCheck(){
	//var formdata = document.formData1;
	//if(formdata.ec_name.value==""){
	//	alert("查询条件不能为空！");
	//	return false;
	//}else{
	//	return true;
	//}
	return true;
}
</script>
<%
/*得到当前登陆的用户id  开始*/
//update20080122
String strTitle = "企业信息查询";
CDataCn dCn=null;   //新建数据库连接对象
CDataImpl dImpl=null;  //新建数据接口对象
String today = new CDate().getThisday();
try {
 dCn = new CDataCn(); 
 dImpl = new CDataImpl(dCn); 
String uiid="";
CMySelf myProject = (CMySelf)session.getAttribute("mySelf");
  if(myProject!=null && myProject.isLogin())
  {
    uiid = Long.toString(myProject.getMyID());
  }
  else
  {
    uiid= "2";
  }

%>
<%@include file="/system/app/skin/skin4/template/info_top.jsp"%>
<!--    模块名称开始    -->
企业信息查询
<!--    模块名称结束    -->
<%@include file="/system/app/skin/skin4/template/info_funtion.jsp"%>
<!--    功能按钮开始    -->

<!--    功能按钮结束    -->
<%@include file="/system/app/skin/skin4/template/info_main.jsp"%>
<!--    表单提交开始    -->
<table width="100%" border="0" cellpadding="0" class="main-table">    
		 <form name="formData1" action="EnterpriseList.jsp" method="post">
          <tr class="line-even">
            <td height="25"  align="right">请输入企业名称：</td>
            <td align="left">
              <input type="text" class="text-line" size="50" name="ec_name" maxlength="150"   >&nbsp;&nbsp;</td>
          </tr>
		  <tr class="line-even">
            <td height="28"  align="right">请输入企业法人代表：</td>
		    <td align="left"><input type="text" class="text-line" size="50" name="ec_corporation" maxlength="150">
	        &nbsp;&nbsp;</td>
		    </tr>
		  <tr class="line-even">
               <td width="27%" height="23" align="right" nowrap>请输入注册时间：</td>
               <td width="73%" nowrap align='left'><input name="strat_time" onclick="javascript:showCal()" style="cursor:hand" readonly type="text" value=""/>&nbsp;到&nbsp;<input name="end_time" onclick="javascript:showCal()" style="cursor:hand" readonly type="text" value=""/> </td>
          </tr>
		  <tr class=outset-table>
               <td height="34" colspan="2" align="center" nowrap><input type="submit" class="bttn" name="fsubmit22"  value="查 询" onclick="return doCheck();" /></td>
           </tr>
		   </form>
</table>
<!--    表单提交结束    -->
<%@include file="/system/app/skin/skin4/template/info_bottom.jsp"%> 
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
                                     
