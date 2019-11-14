<%@page contentType="text/html; charset=GBK"%>
<%@include file="/system/app/skin/head.jsp"%>
<script language="javascript" src="/system/include/common.js"></script>
<script LANGUAGE="javascript" src="/system/app/infopublish/common/common.js"></script>
<style type="text/css">
<!--
.STYLE3 {
	font-size: 16px;
	font-weight: bold;
}
-->
</style>
<%
String au_company = "";//拍卖公司
String au_name = "";//拍卖会名称
String au_address = "";//拍卖会地点
String au_date = "";//拍卖会时间
String au_things = "";//主要拍品
String au_media = "";//公告发布媒体
String au_publicdate = "";//公告发布日期
String au_showdate = "";//拍卖标的展示时间
String au_showaddress = "";//拍卖标的展示地址
String au_man1 = "";//一号拍卖师姓名
String au_number1 = "";//一号拍卖师证号
String au_man2 = "";//二号拍卖师姓名
String au_number2 = "";//二号拍卖师证号
String au_man3 = "";//三号拍卖师姓名
String au_number3 = "";//三号拍卖师证号
String au_booknumber = "";//拍卖委托书份数
String au_money = "";//拍卖委托金额
String au_answer = "";//现场负责人姓名
String au_tel = "";//联系电话
String au_check = "";//是否审核通过
String strSql = "";
String au_id = "";

CDataCn dCn = null;
CDataImpl dImpl = null;
Hashtable content = null;
Vector vPage = null;
try{
dCn = new CDataCn();
dImpl = new CDataImpl(dCn);
au_id = CTools.dealNull(request.getParameter("au_id"));
strSql = "select au_name,au_company,au_address,au_date,au_address,au_things,au_publicdate,au_media,au_showaddress,au_showdate,au_man1,au_number1,au_man2,au_number2,au_man3,au_number3,au_booknumber,au_money,au_answer,au_tel,au_check from tb_auction where au_id='"+au_id+"'";
content = dImpl.getDataInfo(strSql);

if(content!=null){
	au_name = CTools.dealNull(content.get("au_name"));
	au_company = CTools.dealNull(content.get("au_company"));
	au_date = CTools.dealNull(content.get("au_date"));
	au_things = CTools.dealNull(content.get("au_things"));
	au_media = CTools.dealNull(content.get("au_media"));
	au_showaddress = CTools.dealNull(content.get("au_showaddress"));
	au_address = CTools.dealNull(content.get("au_address"));
	au_showdate = CTools.dealNull(content.get("au_showdate"));
	au_publicdate = CTools.dealNull(content.get("au_publicdate"));
	au_man1 = CTools.dealNull(content.get("au_man1"));
	au_number1 = CTools.dealNull(content.get("au_number1"));
	au_man2 = CTools.dealNull(content.get("au_man2"));
	au_number2 = CTools.dealNull(content.get("au_number2"));
	au_man3 = CTools.dealNull(content.get("au_man3"));
	au_number3 = CTools.dealNull(content.get("au_number3"));
	au_booknumber = CTools.dealNull(content.get("au_booknumber"));
	au_money = CTools.dealNull(content.get("au_money"));
	au_answer = CTools.dealNull(content.get("au_answer"));
	au_tel = CTools.dealNull(content.get("au_tel"));
	au_check = CTools.dealNull(content.get("au_check"));
}
%>
<%@include file="/system/app/skin/skin4/template/info_top.jsp"%>
<!--    模块名称开始    -->
拍卖活动前备案查看
<!--    模块名称结束    -->
<%@include file="/system/app/skin/skin4/template/info_funtion.jsp"%>
<!--    功能按钮开始    -->

<!--    功能按钮结束    -->
<%@include file="/system/app/skin/skin4/template/info_main.jsp"%>
<!--    表单提交开始    -->
<table class="FindAreaTable1" cellspacing="1" rules="cols" border="0" id="ctl00_DataGrid_DataGrid1" style="border-width:0px;">
<!--table width="100%" height="539" border="0" CELLPADDING="1" cellspacing="1"-->
  <tr class="line-even">
    <td height="20" colspan="4" align="center"><span class="STYLE3">拍卖活动前备案表</span></td>
  </tr>
  <tr class="line-odd">
    <td width="140">拍卖公司：</td>
    <td colspan="3" align="left"><%=au_company%></td>
  </tr>
  <tr class="line-even">
    <td>拍卖会名称：</td>
    <td colspan="3"  align="left"><%=au_name%></td>
  </tr>
  <tr class="line-odd">
    <td>拍卖会地址： </td>
    <td colspan="3"  align="left"><%=au_address%></td>
  </tr>
  <tr class="line-even">
    <td>拍卖会时间： </td>
    <td colspan="3"  align="left"><%=au_date%></td>
  </tr>
  <tr class="line-odd">
    <td>主要拍品：</td>
    <td colspan="3"  align="left"><%=au_things%></td>
  </tr>
  <tr class="line-even">
    <td>公告发布媒体：</td>
    <td width="185"><%=au_media%></td>
    <td width="160">公告发布日期：</td>
    <td width="176"><%=au_publicdate%></td>
  </tr>
  <tr class="line-odd">
    <td>拍卖标的展示日期：</td>
    <td colspan="3"  align="left"><%=au_showdate%></td>
  </tr>
  <tr class="line-even">
    <td>拍卖标的展示地址：</td>
    <td colspan="3"  align="left"><%=au_showaddress%></td>
  </tr>
  <tr class="line-odd">
    <td>拍卖师姓名：</td>
    <td><%=au_man1%></td>
    <td>拍卖师证号：</td>
    <td><%=au_number1%></td>
  </tr>
  <tr class="line-even">
    <td>拍卖师姓名：</td>
    <td><%=au_man2%></td>
    <td>拍卖师证号：</td>
    <td><%=au_number2%></td>
  </tr>
  <tr class="line-odd">
    <td>拍卖师姓名：</td>
    <td><%=au_man3%></td>
    <td>拍卖师证号：</td>
    <td><%=au_number3%></td>
  </tr>
  <tr class="line-even">
    <td>拍卖委托书份数：</td>
    <td><%=au_booknumber%></td>
    <td>拍卖委托金额：</td>
    <td><%=au_money%></td>
  </tr>
  <tr class="line-odd">
    <td>现场负责人姓名：</td>
    <td><%=au_answer%></td>
    <td>联系电话：</td>
    <td><%=au_tel%></td>
  </tr>
  <tr>
    <td height="37">已经上传的材料：</td>
    <td colspan="3" align="left"><p>1、拍卖公告复印件 <br />
      2、拍卖标的清单 <br />
      3、竞买人须知及拍卖特别规定 </p></td>
  </tr>
    <iframe id=downFrm name=downFrm  style="width:0px;height:0px;"></iframe>
   <%
   strSql = "select wa_id,pa_name from tb_workattach where wo_id='" + au_id + "'";
	 vPage = dImpl.splitPage(strSql,request,10);
	 if(vPage!=null){
		for(int i=0;i<vPage.size();i++){
			content = (Hashtable)vPage.get(i);
			String l_Name = CTools.dealNull(content.get("pa_name"));
			String wa_id = CTools.dealNull(content.get("wa_id"));
   %>
   <tr>
   	<td height="30">附件名：</td>
    <td colspan="3" align="left"><a href="Aucdownload.jsp?wa_id=<%=wa_id%>" target="downFrm"><%=l_Name%></a></td>
   </tr>
   <%}
  	}else{
  		out.println("<tr><td>&nbsp;</td><td colspan=3>没有上传附件！&nbsp;</td></tr>");
  	}%>
  <tr class="line-odd">
    <td colspan="4">
    	<%if(!au_check.equals("1")){%>
    	<input type="button" name="submit" onclick="ischeck(1,'<%=au_id%>')" value="审核通过"/> &nbsp;&nbsp;&nbsp;&nbsp;<input type="button" name="submit1" onclick="ischeck(2,'<%=au_id%>')" value="退回"/><%}%>&nbsp;&nbsp;&nbsp;&nbsp;
    <input type="button" name="submit1" onclick="javascript:window.history.back();" value="返回"/></td>
  </tr>	
</table>
<script language="javascript">
function ischeck(status,tid){
	var status = status ;
	var tid = tid;
	window.location.href="AuctionCheck.jsp?status="+status+"&au_id="+tid;
}
</script>
<!--    表单提交结束    -->
<%@include file="/system/app/skin/skin4/template/info_bottom.jsp"%> 
<%
}
catch(Exception ex){
	System.out.println(new java.util.Date() + "--"
			+ request.getServletPath() + " : " + ex.getMessage());
}
finally{
	dImpl.closeStmt();
	dCn.closeCn(); 
}
%>
<%@include file="/system/app/skin/bottom.jsp"%>
                                     
