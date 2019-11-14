<%@page contentType="text/html; charset=GBK"%>
<%@include file="/system/app/skin/head.jsp"%>
<%@ page buffer="none"%>
<%
String th_id="";
String th_title="";
String sj_id="";
String ct_sequence="";
String va_id="";
String va_votenum="";
String va_votetotalnum="";
String sqlStr ="";
String th_powercode = "" ;
String th_votetype = "";
String th_clicknum = "";
String strTitle = "投票主题管理";
Vector vPage = null;
Hashtable content = null; 

CDataCn dCn = null;
CDataImpl dImpl = null;
try{
dCn = new CDataCn();
dImpl = new CDataImpl(dCn); 

sqlStr ="select th_id,th_votetype,th_title,th_powercode,th_clicknum from tb_votetheame order by th_id desc";
%>
<script  language="javascript">
	function delinfo(id){
		if(confirm("确定要删除该记录吗？")){
			window.location="Subjectdel.jsp?th_id="+id;
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
<img src="/system/images/dialog/split.gif" align="middle" border="0"> 
<img src="/system/images/new.gif" border="0" onclick="window.location='SubjectInfo.jsp?OPType=Add'" title="新增信息" style="cursor:hand" align="absmiddle" WIDTH="16" HEIGHT="16">
<img src="/system/images/dialog/split.gif" align="middle" border="0"> 
<img src="/system/images/goback.gif" border="0" onclick="javascript:history.back();" title="返回" style="cursor:hand" align="absmiddle">
<img src="/system/images/dialog/split.gif" align="middle" border="0"> 
<!--    功能按钮结束    -->
<%@include file="/system/app/skin/skin4/template/list_listtop.jsp"%>                                                                                        
<!--    列表开始    -->
<table class="FindAreaTable1" cellspacing="1" rules="cols" border="0" id="ctl00_DataGrid_DataGrid1" style="border-width:0px;">
	<tr class="bttn">
    <td width="5%" class="outset-table">序号</td>
    <td width="35%" class="outset-table">投票主题</td>	
		<td width="20%" class="outset-table">评论内容</td>
		<td width="10%" class="outset-table">点击数</td>	
		<td width="15%" class="outset-table" >修改</td>
		<td width="15%" class="outset-table">删除</td >  
	</tr>
	<form name="formData" action="PersonSequence.jsp" method="post">
		<%
		vPage = dImpl.splitPage(sqlStr,request,25);
		if(vPage!=null){							
			for(int i=0; i<vPage.size(); i++){
				content = (Hashtable)vPage.get(i);
				th_id = content.get("th_id").toString();
				th_title= content.get("th_title").toString();
				th_powercode = content.get("th_powercode").toString();
				th_votetype = content.get("th_votetype").toString();
				th_clicknum = content.get("th_clicknum").toString();			
				if(i % 2 == 0)  out.print("<tr class=\"line-even\">");
            else out.print("<tr class=\"line-odd\">");
		%>		
			<td  ><%=i+1%></td>
      <td  align="left"><a href="Personlist1.jsp?th_id=<%=th_id%>&th_title=<%=th_title%>&th_powercode=<%=th_powercode%>&th_votetype=<%=th_votetype%>"><%=th_title%></a></td>
			<td  ><a href="commentlist.jsp?th_id=<%=th_id%>&th_votetype=<%=th_votetype%>"><%=th_title%>评论列表</a></td>	
			<td  ><%=th_clicknum%></td>	
			<td  ><a href="SubjectInfo.jsp?th_id=<%=th_id%>&OPType=Edit">
				<img class="hand" border="0" src="../../images/modi.gif" title="编辑" WIDTH="16" HEIGHT="16"></a></td>
			<td width="5%"><a href="#" onclick="delinfo('<%=th_id%>');">
				<img class="hand" border="0" src="../../images/delete.gif" title="删除" WIDTH="16" HEIGHT="16"></a></td>
		</tr>		 
		<%			
			}
		}else{	
			out.print("<tr><td colspan='20'>没有记录！</td></tr>");
		}		
		%>
		<input  type="hidden" name="th_id" value="<%=th_id%>"/>		
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