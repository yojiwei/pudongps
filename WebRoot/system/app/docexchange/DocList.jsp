<%@page contentType="text/html; charset=GBK"%>
<%@include file="/system/app/skin/head.jsp"%>
<%
CDataCn dCn = null;
CDataImpl dImpl = null;
String dt_id="";
String sqlCorr="";
String sqlUrgItem="";
String sqlUrgCorr="";
String sqlSupItem="";
String sqlSupCorr="";
String CorrNum="";
String UrgNum="";
String SupNum="";
String strTitle = "催办单交换箱";
try{
dCn = new CDataCn();
dImpl = new CDataImpl(dCn);
//
CMySelf self = (CMySelf)session.getAttribute("mySelf");
dt_id = String.valueOf(self.getDtId());

sqlCorr = " select de_id from tb_documentexchange ";
sqlCorr += " where de_receiverdeptid="+dt_id+" and (de_status='1' or de_status='4') and de_type='1' ";
sqlUrgItem = " select * from tb_documentexchange where de_receiverdeptid="+dt_id+" and de_type='2' and de_status='1' ";
sqlUrgCorr = " select * from tb_documentexchange where de_receiverdeptid="+dt_id+" and de_type='3' and de_status='1' ";
sqlSupItem = " select * from tb_documentexchange where de_receiverdeptid="+dt_id+" and de_type='4' and de_status='1' ";
sqlSupCorr = " select * from tb_documentexchange where de_receiverdeptid="+dt_id+" and de_type='5' and de_status='1' ";

Vector vectorCorr=dImpl.splitPage(sqlCorr,request,20);
Vector vectorUrgItem=dImpl.splitPage(sqlUrgItem,request,20);
Vector vectorUrgCorr=dImpl.splitPage(sqlUrgCorr,request,20);
Vector vectorSupItem=dImpl.splitPage(sqlSupItem,request,20);
Vector vectorSupCorr=dImpl.splitPage(sqlSupCorr,request,20);

if(vectorCorr!=null) 
	CorrNum=String.valueOf(vectorCorr.size()); 
else CorrNum="0";
if(vectorUrgItem!=null&&vectorUrgCorr!=null) 
	UrgNum=String.valueOf(vectorUrgItem.size()+vectorUrgCorr.size());
else UrgNum="0";
if(vectorSupItem!=null&&vectorSupCorr!=null) 
	SupNum=String.valueOf(vectorSupItem.size()+vectorSupCorr.size());
else SupNum="0";
%>
<%@include file="/system/app/skin/skin4/template/list_top.jsp"%>
<!--    模块名称开始    -->
<%=strTitle%>
<!--    模块名称结束    -->
<%@include file="/system/app/skin/skin4/template/list_function.jsp"%>                                                            
<!--    功能按钮开始    -->
未签收文件列表
<!--    功能按钮结束    -->
<%@include file="/system/app/skin/skin4/template/list_listtop.jsp"%>                                                                                        
<!--    列表开始    -->
<table class="FindAreaTable1" cellspacing="1" rules="cols" border="0" id="ctl00_DataGrid_DataGrid1" style="border-width:0px;">
    <tr class="bttn">
      <td width="20%" class="outset-table" align="center">文件类型</td>
      <td width="20%" class="outset-table" align="center">数量</td>
      <td width="20%" class="outset-table" align="center">操作</td>
    </tr>
    <tr class="line-even">
      <td align="center">未签收协调单</td>
      <td align="center"><%=CorrNum%></td>
      <td align="center"><a href="SignAll.jsp" onclick="return window.confirm('确认要签收吗?')">签收 </td>
    </tr>
    <tr class="line-even">
      <td align="center">未签收催办单</td>
      <td align="center"><%=UrgNum%></td>
      <td align="center"><a href="SignAll.jsp" onclick="return window.confirm('确认要签收吗?')">签收 </td>
    </tr>
    <tr class="line-even">
      <td align="center">未签收督办单</td>
      <td align="center"><%=SupNum%></td>
      <td align="center"><a href="SignAll.jsp" onclick="return window.confirm('确认要签收吗?')">签收 </td>
    </tr>
    </form>
</table>
<!--    列表结束    -->
<%@include file="/system/app/skin/skin4/template/list_bottom.jsp"%> 
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