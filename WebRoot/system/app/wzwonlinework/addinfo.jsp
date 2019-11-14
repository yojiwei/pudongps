<%@page contentType="text/html; charset=GBK"%>
<%@include file="/system/app/skin/head.jsp"%>
<%@include file="/system/app/skin/import.jsp"%>
<script LANGUAGE="javascript" src="/system/app/infopublish/common/common.js"></script>
<%
 CDataCn dCn = null;
 CDataImpl dImpl = null;
String wz_id = CTools.dealString(request.getParameter("wz_id")).trim();
String OType = CTools.dealString(request.getParameter("OType")).trim();
Vector vPage = null;
Hashtable content = null;
try{
dCn = new CDataCn();
dImpl = new CDataImpl(dCn);
%>
<%@include file="/system/app/skin/skin4/template/info_top.jsp"%>
<!--    模块名称开始    -->

<!--    模块名称结束    -->
<%@include file="/system/app/skin/skin4/template/info_funtion.jsp"%>
<!--    功能按钮开始    -->

<!--    功能按钮结束    -->
<%@include file="/system/app/skin/skin4/template/info_main.jsp"%>
<!--    表单提交开始    -->
<%
	if(!wz_id.equals("")&&OType.equals("Edit")){
	 String sqlStr = "select * from tb_wzwolinework where wz_id='"+wz_id+"'";
      vPage = dImpl.splitPage(sqlStr,1,1);
	  if(vPage != null)
{
	for(int i=0;i<vPage.size();i++)
	{
	 content = (Hashtable)vPage.get(i);
		String wz_reciveid = content.get("wz_reciveid").toString();
		String wz_applydate = content.get("wz_applydate").toString();
		String wz_subjecttname = content.get("wz_subjecttname").toString();
		String wz_dealdepat = content.get("wz_dealdepat").toString();
		String wz_dealperson = content.get("wz_dealperson").toString();
		String wz_dealstatus = content.get("wz_dealstatus").toString();
		String wz_feedback = content.get("wz_feedback").toString();
		
		String wz_applycompany = content.get("wz_apllycompany").toString();
	
		String 	wz_zihao = content.get("wz_zihao").toString();
		String wz_tel = content.get("wz_tel").toString();
		String 	wz_applyname = content.get("wz_applyname").toString();
		String 	wz_companyname = content.get("wz_companyname").toString();
		String 	wz_conncompany = content.get("wz_conncompany").toString();
		String 	wz_connperson = content.get("wz_connperson").toString();
		String 	wz_conntel = content.get("wz_conntel").toString();
		String	wz_connaddress = content.get("wz_connaddress").toString();	
%>
<table align="center" width="100%" class="main-table">
<form name="formData" method="post">
	<tr class="title1" width="100%">
		<td colspan="2" class="outset-table">修改信件
		</td>
	</tr>
	<tr class="line-even">
		<td width="25%" align="right">收文号</td>
		<td width="75%" align="left"><input name="wz_reciveid" class="text-line" maxlength="20" value="<%=wz_reciveid%>"></td>
	</tr>
	<tr class="line-odd">
		<td align="right">申请时间</td>
		<td align="left"><input name="wz_applydate" style="cursor:hand" class="text-line" readonly size="10" onclick="showCal()" value="<%=wz_applydate%>"></td>
	</tr>
	<tr class="line-even">
		<td align="right">项目名称</td>
       <td align="left"><input name="wz_subjecttname" size="40" class="text-line" maxlength="40" value="<%=wz_subjecttname%>"></td> 
	</tr>
    <!--tr class="line-odd">
		<td align="right">经办处室</td>
       <td align="left"><input name="wz_dealdepat" size="10" class="text-line" maxlength="10" value="<%=wz_dealdepat%>"></td> 
	</tr-->
    <tr class="line-odd">
		<td align="right">经办人</td>
       <td align="left"><input name="wz_dealperson" size="10" class="text-line" maxlength="10" value="<%=wz_dealperson%>"></td> 
	</tr>

      <tr class="line-even">
		<td align="right">报送单位</td>
       <td align="left"><input name="wz_applycompany" class="text-line" size="40" value="<%=wz_applycompany%>"></td> 
	</tr>
	 <!--tr class="line-even">
		<td align="right">来文字号</td>
       <td align="left"><input name="wz_zihao" size="10" class="text-line" maxlength="10" value="<%=wz_zihao%>"></td> 
	</tr-->
	<tr class="line-odd">
		<td align="right">报送联系人</td>
       <td align="left"><input name="wz_applyname" class="text-line" maxlength="10" size="10" value="<%=wz_applyname%>"></td> 
	</tr>
    <tr class="line-even">
		<td align="right">报送单位电话</td>
       <td align="left"><input name="wz_tel" size="10" class="text-line" value="<%=wz_tel%>" ></td> 
	</tr>
	 <tr class="line-odd">
		<td align="right">项目单位</td>
       <td align="left"><input name="wz_companyname" size="40" class="text-line"value="<%=wz_companyname%>" ></td> 
	</tr>
	<!--tr class="line-odd">
		<td align="right">项目单位</td>
       <td align="left"><input name="wz_conncompany"  class="text-line" size="40" value="<%=wz_conncompany%>"></td> 
	</tr-->
	
     <tr class="line-even">
		<td align="right">项目联系人</td>
       <td align="left"><input name="wz_connperson" class="text-line" size="10" value="<%=wz_connperson%>"></td> 
	</tr>
	<tr class="line-odd">
		<td align="right">项目单位电话</td>
       <td align="left"><input name="wz_conntel"  class="text-line" maxlength="10" value="<%=wz_conntel%>"></td> 
	</tr>
   <tr class="line-even">
		<td align="right">项目单位地址</td>
       <td align="left"><input name="wz_connaddress"  class="text-line" size="40" value="<%=wz_connaddress%>"></td> 
	</tr>
	<tr class="line-odd">
		<td align="right">办理状态</td>
		<td align="left">
			<select name="wz_dealstatus">
			<option value="审批中">审批中</option>
            <option value="待领取">待领取</option>
             <option value="已办结">已办结</option>
			</select>
		</td>
	</tr>
	  <tr class="line-even">
		<td align="right">问题留言</td>
       <td align="left"><textarea name="wz_feedback" rows="5" cols="45"><%=wz_feedback%></textarea></td> 
	</tr>
	<tr class=outset-table width="100%">
		<td colspan="2" class="outset-table">
            <input type="button" class="bttn" value="修改" onclick="editForm('<%=wz_id%>')">&nbsp;
			<input type="button" class="bttn" value="删除" onclick="delinfo('<%=wz_id%>')">&nbsp;
			<input type="button" class="bttn" value="返回" onclick="javascript:history.back();">&nbsp;
		</td>
	</tr>
</form>
</table>
<%}}}else{%>
<table align="center" width="100%" class="main-table">
<form name="formData" method="post" action="result.jsp">
	<tr class="title1" width="100%">
		<td colspan="2" class="outset-table">新增信件
		</td>
	</tr>
	<tr class="line-even">
		<td width="25%" align="right">收文号</td>
		<td width="75%" align="left"><input name="wz_reciveid" class="text-line" maxlength="20"></td>
	</tr>
	<tr class="line-odd">
		<td align="right">申请时间</td>
		<td align="left"><input name="wz_applydate" style="cursor:hand" class="text-line" readonly size="10" onclick="showCal()"></td>
	</tr>
	<tr class="line-even">
		<td align="right">项目名称</td>
       <td align="left"><input name="wz_subjecttname" size="40" class="text-line" maxlength="40"></td> 
	</tr>
    <!--tr class="line-odd">
		<td align="right">经办处室</td>
       <td align="left"><input name="wz_dealdepat" size="10" class="text-line" maxlength="10"></td> 
	</tr-->
    <tr class="line-odd">
		<td align="right">经办人</td>
       <td align="left"><input name="wz_dealperson" size="10" class="text-line" maxlength="10"></td> 
	</tr>
	  <tr class="line-even">
		<td align="right">报送单位</td>
       <td align="left"><input name="wz_applycompany" class="text-line" size="40"></td> 
	</tr>
	 <!--tr class="line-even">
		<td align="right">来文字号</td>
       <td align="left"><input name="wz_zihao" size="10" class="text-line" maxlength="10" value=""></td> 
	</tr-->
	<tr class="line-odd">
		<td align="right">报送联系人</td>
       <td align="left"><input name="wz_applyname" size="10" class="text-line" maxlength="10" value=""></td> 
	</tr>
    <tr class="line-even">
		<td align="right">报送单位电话</td>
       <td align="left"><input name="wz_tel"  size="10"class="text-line" ></td> 
	</tr>
	 <!--tr class="line-odd">
		<td align="right">项目单位</td>
       <td align="left"><input name="wz_companyname" size="40" class="text-line" ></td> 
	</tr-->
	 <tr class="line-even">
		<td align="right">项目单位</td>
       <td align="left"><input name="wz_companyname" size="40" class="text-line" maxlength="10" value=""></td> 
	</tr>
	
    <tr class="line-even">
		<td align="right">项目联系人</td>
       <td align="left"><input name="wz_connperson" size="10"class="text-line" maxlength="40"></td> 
	</tr>
	 <tr class="line-odd">
		<td align="right">项目单位电话</td>
       <td align="left"><input name="wz_conntel" size="10" class="text-line" maxlength="10" value=""></td> 
	</tr>
  <tr class="line-even">
		<td align="right">项目单位地址</td>
       <td align="left"><input name="wz_connaddress"  class="text-line" size="40"></td> 
	</tr>
   <!-- <tr class="line-odd">
		<td align="right">经办处室</td>
       <td><input name="pr_name" size="40" class="text-line" maxlength="40"></td> 
	</tr-->
	<tr class="line-odd">
		<td align="right">办理状态</td>
		<td align="left">
			<select name="wz_dealstatus">
			<option value="审批中">审批中</option>
            <option value="待领取">待领取</option>
             <option value="已办结">已办结</option>
			</select>
		</td>
	</tr>
	  <tr class="line-even">
		<td align="right">问题留言</td>
       <td align="left"><textarea name="wz_feedback" rows="5" cols="45"></textarea></td> 
	</tr>
	<tr class=outset-table width="100%">
		<td colspan="2" class="outset-table">
			<input type="submit" class="bttn" value="增加">&nbsp;
			<input type="reset" class="bttn" value="重写">&nbsp;
			<input type="button" class="bttn" value="返回" onclick="javascript:history.back();">&nbsp;
		</td>
	</tr>
</form>
</table>
<!--    表单提交结束    -->
<%@include file="/system/app/skin/skin4/template/info_bottom.jsp"%> 
<%}
}
catch(Exception e){
	System.out.print(e.toString());
}
finally{
	dImpl.closeStmt();
	dCn.closeCn(); 
}
%>
<script language="javascript">
function editForm(wz_id)
{
	formData.action = "result.jsp?OType=Edit&wz_id="+wz_id;
	formData.submit();
	return true;
}
function delinfo(wz_id){
if(confirm("确实要删除吗？"))
	  {
			formData.action = "del.jsp?wz_id="+wz_id;
			formData.submit();
	  }
}
</script>
<%@include file="/system/app/skin/bottom.jsp"%>
                                     
