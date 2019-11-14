<%@page contentType="text/html; charset=GBK"%>
<%@include file="/system/app/skin/head.jsp"%>
<%@ page buffer="none"%>
<%
String th_id="";
String th_votetype = "";
String strTitle = "投票用户管理";
Vector vPage = null;
Hashtable content = null; 
String sqlStr = "" ;
String name="匿名";
String ct_id = "";
CDataCn dCn = null;
CDataImpl dImpl = null;
try{
dCn = new CDataCn();
dImpl = new CDataImpl(dCn); 

 th_id = CTools.dealString(request.getParameter("th_id"));
 th_votetype = CTools.dealString(request.getParameter("th_votetype"));
 ct_id = CTools.dealString(request.getParameter("ct_id"));

 sqlStr ="select uc_id,uc_name,uc_address,uc_comment from tb_voteusercomment where th_id='"+th_id+"' order by uc_id desc";
 if(!"".equals(ct_id)){
 	sqlStr = "select vu.uc_id,vu.uc_name,vu.uc_address,vu.uc_comment from tb_voteusercomment vu,tb_selrelate sl where vu.th_id='"+th_id+"' and sl.sc_id=vu.uc_id and sl.su_id = '"+ct_id+"'";
 }
vPage = dImpl.splitPage(sqlStr,request,25);
%>
<script  language="javascript">
	function delinfo(uc_id,th_id,th_votetype){
		if(confirm("确定要删除该记录吗？")){
			window.location="delcomment.jsp?uc_id="+uc_id+"&th_id="+th_id+"&th_votetype="+th_votetype;
    }
	}
	function formchk(){
		document.formData.submit();	
	}
</script>
<%@include file="/system/app/skin/skin4/template/list_top.jsp"%>
<!--    模块名称开始    -->
<%=strTitle%>
<!--    模块名称结束    -->
<%@include file="/system/app/skin/skin4/template/list_function.jsp"%>                                                            
<!--    功能按钮开始    -->
<img src="/system/images/split.gif" align="middle" border="0" WIDTH="5" HEIGHT="8">
<img src="/system/images/goback.gif" border="0" onclick="javascript:history.back();" title="返回" style="cursor:hand" align="absmiddle">
<img src="/system/images/split.gif" align="middle" border="0" WIDTH="5" HEIGHT="8">
<!--    功能按钮结束    -->
<%@include file="/system/app/skin/skin4/template/list_listtop.jsp"%>                                                                                        
<!--    列表开始    -->
<table width="219" height="88" border="0" cellspacing="1" rules="cols" class="FindAreaTable1" id="ctl00_DataGrid_DataGrid1" style="border-width:0px;">			
<tr class="bttn">
	<td width="5%" height="1" class="outset-table">序号</td>
	<td width="35%" height="1" class="outset-table">用户名</td>	
	<td width="20%" height="1" class="outset-table">联系方式</td>	
	<td width="15%" height="1" class="outset-table" >查看</td>
	<td width="15%" height="1" class="outset-table">删除</td >
</tr>
<form name="formData" action="PersonSequence.jsp" method="post">
<%
String uc_id = "";
String uc_name = "";
String uc_address = "";
if(vPage!=null){							
	for(int i=0; i<vPage.size(); i++){
		content = (Hashtable)vPage.get(i);
		 uc_id = content.get("uc_id").toString();
		 uc_name= content.get("uc_name").toString();
		 uc_address = content.get("uc_address").toString();		
		if(i % 2 == 0)  out.print("<tr class=\"line-even\">");
        else out.print("<tr class=\"line-odd\">");
%>
	<td><%=i+1%></td>
	<td><%="".equals(uc_name)?name:uc_name%></td>
	<td><%=uc_address%></td>	
	<td><A href="commentinfo.jsp?uc_id=<%=uc_id%>&th_id=<%=th_id%>"><img class="hand" border="0" src="../../images/modi.gif" title="查看" WIDTH="16" HEIGHT="16"></a></td>
	<td width="15%"><a href="#" onclick="delinfo('<%=uc_id%>','<%=th_id%>','<%=th_votetype%>');">
	<img class="hand" border="0" src="../../images/delete.gif" title="删除" WIDTH="16" HEIGHT="16"></a>
	</td>
</tr> 
<%			
	}
}else{
	out.print("<tr><td height='1' colspan='5'>没有记录！</td></tr>");
}		
%><input type="hidden" value="<%=th_id%>" name="th_id"/>
  </form>
</table>
<!--    列表结束    -->
<%@include file="/system/app/skin/skin4/template/list_bottom.jsp"%> 
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