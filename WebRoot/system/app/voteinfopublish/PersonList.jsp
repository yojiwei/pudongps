<%@page contentType="text/html; charset=GBK"%>
<%@include file="../skin/head.jsp"%>
<%
String ct_id="";
String ct_title="";
String sj_id="";
String ct_sequence="";
String va_id="";
String va_votenum="";
String va_votetotalnum="";
String sqlStr ="";


Vector vPage = null;
Hashtable content = null; 


CDataCn dCn = null;
CDataImpl dImpl = null;
try{
dCn = new CDataCn();
dImpl = new CDataImpl(dCn); 
%>

<script  language="javascript">
	function delinfo(id){
		if(confirm("确定要删除该记录吗？")){
			window.location="personDel.jsp?ct_id="+id;
		}	
	}
	function formchk(){
		document.formData.submit();	
	}




</script>

 <table class="main-table" width="100%">
 <tr>
  <td width="100%">
       <table class="content-table" width="100%">
        <tr class="title1">
            <td colspan="8" align="center">
                <table WIDTH="100%" BORDER="0" CELLSPACING="1" CELLPADDING="1" >
                    <tr>                        
						<td valign="center" align="right" nowrap>
						         
								 <img src="/system/images/split.gif" align="middle" border="0" WIDTH="5" HEIGHT="8">
								<img src="/system/images/new.gif" border="0" onclick="window.location='PublishInfo.jsp?OPType=Add'" title="新增信息" style="cursor:hand" align="absmiddle" WIDTH="16" HEIGHT="16">
								<img src="/system/images/dialog/split.gif" align="middle" border="0" WIDTH="5" HEIGHT="8">
								 <img src="/system/images/dialog/sort.gif" border="0" onclick="formchk();" title="修改排序" style="cursor:hand" align="absmiddle" WIDTH="15" HEIGHT="15">
								<img src="/system/images/split.gif" align="middle" border="0" WIDTH="5" HEIGHT="8">
								<img src="/system/images/goback.gif" border="0" onclick="javascript:history.back();" title="返回" style="cursor:hand" align="absmiddle">
								<img src="/system/images/split.gif" align="middle" border="0" WIDTH="5" HEIGHT="8">
					  </td>
                    </tr>
                </table>
            </td>
        </tr>							
       <form name="formData" action="PersonSequence.jsp" method="post">
		<tr class="bttn">
            <td width="5%" class="outset-table">序号</td>
            <td width="35%" class="outset-table">候选人姓名</td>
            <td width="20%" class="outset-table">得票数</td> 			  
			<td width="15%" class="outset-table" >修改</td>
			<td width="15%" class="outset-table">删除</td >  
			<td width="10%" class="outset-table">排序</td> 
        </tr>
		<%
	 
		sqlStr ="select c.ct_id,c.ct_title,c.ct_sequence,v.va_votenum,v.va_votetotalnum from tb_content c,tb_voteadvanced v where  c.sj_id ='-2046' and c.ct_id = v.ct_id order by c.ct_sequence,ct_id desc";		
		
		vPage = dImpl.splitPage(sqlStr,request,25);
		if(vPage!=null){							
			for(int i=0; i<vPage.size(); i++){
				content = (Hashtable)vPage.get(i);
				ct_id = content.get("ct_id").toString();
				ct_title= content.get("ct_title").toString();
				ct_sequence = content.get("ct_sequence").toString();
				va_votenum = content.get("va_votenum").toString();
				va_votetotalnum = content.get("va_votetotalnum").toString();				
				if(i % 2 == 0)  out.print("<tr class=\"line-even\">");
            else out.print("<tr class=\"line-odd\">");
		%>		
			<td  ><%=i+1%></td>
            <td  ><%=ct_title%></td>
            <td  ><%=va_votenum%></td>			 
			<td  ><a href="PublishInfo.jsp?ct_id=<%=ct_id%>&OPType=Edit"><img class="hand" border="0" src="../../images/modi.gif" title="编辑" WIDTH="16" HEIGHT="16"></a></td>
			<td width="5%"><a href="#" onclick="delinfo('<%=ct_id%>');"><img class="hand" border="0" src="../../images/delete.gif" title="删除" WIDTH="16" HEIGHT="16"></a></td>
			<td  ><input type="text" name="ct_sequence" size=4 maxlength=4 value="<%=ct_sequence%>"><input  type="hidden" name="ct_id" value=<%=ct_id%>></td>			
		</tr>		 
		<%			
			}
			out.print("<tr class='bttn' ><td colspan='6' align='left'><B>&nbsp;&nbsp;投票总人数:"+va_votetotalnum+"</B></td></tr>");
			 out.println("<tr><td colspan=7>" + dImpl.getTail(request) + "</td></tr>"); //输出尾部文件
			
		}else{		
		%>
		<tr><td colspan=6>暂无信息</td></tr>
		<%		
		}		
		%>
		
		</form>
   </table>
   </td>
    </tr></table>
   <%@ include file="../skin/bottom.jsp"%>
<%
}
catch(Exception e){
//e.printStackTrace();
out.print(e.toString());
}
finally{
dImpl.closeStmt();
dCn.closeCn(); 
}	
%>