<%@page contentType="text/html; charset=GBK"%>
<%@include file="/system/app/skin/head.jsp"%>
<%
String ct_id="";
String ct_title="";
String sj_id="";
String ct_sequence="";
String va_id="";
String va_votenum="";
String va_votetotalnum="";
String sqlStr ="";
String  th_votetype = CTools.dealString(request.getParameter("th_votetype"));

Vector vPage = null;
Hashtable content = null; 
String strTitle = "投票人数管理";
String th_id = CTools.dealString(request.getParameter("th_id"));
String th_title = CTools.dealString(request.getParameter("th_title"));
String th_powercode = CTools.dealString(request.getParameter("th_powercode"));
CDataCn dCn = null;
CDataImpl dImpl = null;
CDataImpl dImpl1 = null;
try{
dCn = new CDataCn();
dImpl = new CDataImpl(dCn); 
dImpl1 = new CDataImpl(dCn); 
 sqlStr = "select th_votetotalnum from tb_votetheame where th_id="+th_id;
 content = dImpl1.getDataInfo(sqlStr);
 if(content!=null){
	 va_votetotalnum = content.get("th_votetotalnum").toString();
 }
%>
<script  language="javascript">
	function delinfo(id,td,pd){
		if(confirm("确定要删除该记录吗？")){
			window.location="personDel.jsp?ct_id="+id+"&th_id="+td+"&th_powercode="+pd;
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
<img src="/system/images/new.gif" border="0" onclick="window.location='addperson.jsp?th_id=<%=th_id%>&OPType=Add&th_powercode=<%=th_powercode%>'" title="新增信息" style="cursor:hand" align="absmiddle" WIDTH="16" HEIGHT="16">
<img src="/system/images/dialog/split.gif" align="middle" border="0" WIDTH="5" HEIGHT="8">
<img src="/system/images/dialog/sort.gif" border="0" onclick="formchk();" title="修改排序" style="cursor:hand" align="absmiddle" WIDTH="15" HEIGHT="15">
<img src="/system/images/split.gif" align="middle" border="0" WIDTH="5" HEIGHT="8">
<img src="/system/images/goback.gif" border="0" onclick="javascript:history.back();" title="返回" style="cursor:hand" align="absmiddle">
<img src="/system/images/split.gif" align="middle" border="0" WIDTH="5" HEIGHT="8">
<!--    功能按钮结束    -->
<%@include file="/system/app/skin/skin4/template/list_listtop.jsp"%>                                                                                        
<!--    列表开始    -->
<table class="FindAreaTable1" cellspacing="1" rules="cols" border="0" id="ctl00_DataGrid_DataGrid1" style="border-width:0px;">
<form name="formData" action="PersonSequence.jsp?th_id=<%=th_id%>" method="post">
<tr class="bttn">
  <td width="5%" class="outset-table">序号</td>
  <td width="35%" class="outset-table">候选人姓名</td>
  <td width="20%" class="outset-table">得票数</td> 			  
	<td width="15%" class="outset-table" >修改</td>
	<td width="15%" class="outset-table">删除</td >  
	<td width="10%" class="outset-table">排序</td> 
</tr>
<%
	  sqlStr ="select c.ct_id,c.ct_title,c.ct_sequence,v.va_votenum,v.va_votetotalnum from tb_content c,tb_voteadvanced v,tb_relate r where  r.th_id='"+th_id+"' and c.ct_id = v.ct_id  and r.ct_id=c.ct_id order by c.ct_sequence,ct_id desc";		
		vPage = dImpl.splitPage(sqlStr,request,25);
		if(vPage!=null){							
			for(int i=0; i<vPage.size(); i++){
				content = (Hashtable)vPage.get(i);
				ct_id = content.get("ct_id").toString();
				ct_title= content.get("ct_title").toString();
				ct_sequence = content.get("ct_sequence").toString();
				va_votenum = content.get("va_votenum").toString();
				//va_votetotalnum = content.get("va_votetotalnum").toString();						
				if(i % 2 == 0)  out.print("<tr class=\"line-even\">");
        else out.print("<tr class=\"line-odd\">");
		%>
			<td  ><%=i+1%></td>
      <td  ><a href="commentlist.jsp?th_id=<%=th_id%>&ct_id=<%=ct_id%>"><%=ct_title%></a></td>
      <td  ><%=va_votenum%></td>			 
			<td  ><a href="PublishInfo.jsp?ct_id=<%=ct_id%>&OPType=Edit&th_id=<%=th_id%>&th_powercode=<%=th_powercode%>"><img class="hand" border="0" src="../../images/modi.gif" title="编辑" WIDTH="16" HEIGHT="16"></a></td>
			<td width="5%"><a href="#" onclick="delinfo('<%=ct_id%>','<%=th_id%>','<%=th_powercode%>');"><img class="hand" border="0" src="../../images/delete.gif" title="删除" WIDTH="16" HEIGHT="16"></a></td>
			<td  ><input type="text" name="ct_sequence" size=4 maxlength=4 value="<%=ct_sequence%>">
				<input  type="hidden" name="ct_id" value="<%=ct_id%>"/></td>			
		</tr>
		<%			
			}
			out.print("<tr class='bttn' ><td colspan='6' align='left'><B>&nbsp;&nbsp;投票总人数:"+va_votetotalnum+"</B></td></tr>");
		}else{	
			out.print("<tr><td colspan='20'>没有记录！</td></tr>");	
		}		
		%>
		
		<input type="hidden" value="<%=th_id%>" name="th_id"/>
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
	dImpl1.closeStmt();
	dCn.closeCn(); 
}
%>
<%@include file="/system/app/skin/bottom.jsp"%>