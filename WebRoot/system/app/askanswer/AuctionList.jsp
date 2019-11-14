<%@page contentType="text/html; charset=GBK"%>
<%@include file="/system/app/skin/head.jsp"%>
<%
String au_id = "";
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
String au_check = "";//状态

CDataCn dCn = null;
CDataImpl dImpl = null;
try{
dCn = new CDataCn();
dImpl = new CDataImpl(dCn);
//
String sql_list = "select au_id,au_name,au_company,to_char(au_date,'yyyy-MM-dd') as au_date,au_things,au_media,au_showaddress,au_check from tb_auction order by au_date desc ";

%>
<%@include file="/system/app/skin/skin4/template/list_top.jsp"%>
<!--    模块名称开始    -->
拍卖备案列表
<!--    模块名称结束    -->
<%@include file="/system/app/skin/skin4/template/list_function.jsp"%>                                                            
<!--    功能按钮开始    -->
<!--    功能按钮结束    -->
<%@include file="/system/app/skin/skin4/template/list_listtop.jsp"%>                                                                                        
<!--    列表开始    -->
<table width="825" height="46" border="0" cellspacing="1" rules="cols" class="FindAreaTable1" id="ctl00_DataGrid_DataGrid1" style="border-width:0px;">
	<form name="formData">
	<tr class="bttn">
	<td width="5%" class="outset-table" align="center">序号</td>
	<td width="10%" class="outset-table" align="center">拍卖会名称</td>
	<td width="10%" class="outset-table" align="center">拍卖会公司</td>
	<td width="13%" class="outset-table" align="center">拍卖日期</td>
	<td width="23%" class="outset-table" align="center">拍卖品</td>
	<td width="10%" class="outset-table" align="center">拍卖会媒体</td>
	<td width="17%" class="outset-table" align="center">拍卖地点</td>
	<td width="8%" class="outset-table" align="center">当前状态</td>
	<td width="8%" class="outset-table" align="center">操作</td>
	</tr>
	<%
	Vector vectorList = dImpl.splitPage(sql_list,request,20);
	Hashtable content = null;
	if(vectorList!=null)
	{
		int j=0;
		for(int i=0;i<vectorList.size();i++)
		{
			content = (Hashtable)vectorList.get(i);
			au_id = CTools.dealNull(content.get("au_id"));
			au_name = CTools.dealNull(content.get("au_name"));
			au_company = CTools.dealNull(content.get("au_company"));
			au_date = CTools.dealNull(content.get("au_date"));
			au_things = CTools.dealNull(content.get("au_things"));
			au_media = CTools.dealNull(content.get("au_media"));
			au_showaddress = CTools.dealNull(content.get("au_showaddress"));
			au_check = CTools.dealNull(content.get("au_check"));
			if(au_check.equals("0")){
		  	au_check = "待审核";
		  }else if(au_check.equals("1")){
		  	au_check = "审核通过";
		  }else{
		  	au_check = "退回";
		  }
			
			if(i % 2 == 0)  out.print("<tr class=\"line-even\">");
			else out.print("<tr class=\"line-odd\">");
	%>
	<td align="center"><%=++j%></td>
	<td align="left"><%=au_name%></td>
	<td align="left"><%=au_company%></td>
	<td align="left"><%=au_date%></td>
	<td align="left"><%=au_things%></td>
	<td align="left"><%=au_media%></td>
	<td align="left"><%=au_showaddress%></td>
	<td align="center"><%=au_check%></td>
	<td align="center">
		<a href="AuctionDetail.jsp?au_id=<%=au_id%>">审核</a>
	</td>
</tr>
</form>
<%
    }
  }
  else
  {
    out.println("<tr><td colspan=20>没有记录！</td></tr>");
  }
%>
</table>
<!--    列表结束    -->
<%@include file="/system/app/skin/skin4/template/list_bottom.jsp"%> 
<%
}
catch(Exception e){
	System.out.println(new java.util.Date() + "--"
			+ request.getServletPath() + " : " + e.getMessage());
}
finally{
	dImpl.closeStmt();
	dCn.closeCn(); 
}
%>
<%@include file="/system/app/skin/bottom.jsp"%>