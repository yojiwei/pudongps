<%@page contentType="text/html; charset=GBK"%>
<%@include file="/system/app/skin/head.jsp"%>
<%
String dt_id="";
String dt_name="";
String dt_addr="";
String dt_phone="";
String dt_create_time="";
String strTitle = "受理网点管理";//
Vector vPage = null;
Hashtable content = null; 
//
CDataCn dCn = null;
CDataImpl dImpl = null;
try{
dCn = new CDataCn();
dImpl = new CDataImpl(dCn);
%>
<%@include file="/system/app/skin/skin4/template/list_top.jsp"%>
<!--    模块名称开始    -->
<%=strTitle%>
<!--    模块名称结束    -->
<%@include file="/system/app/skin/skin4/template/list_function.jsp"%>                                                            
<!--    功能按钮开始    -->
<img src="/system/images/new.gif" border="0" onclick="window.location='deptInfo.jsp?OPType=Add'" title="新增信息" style="cursor:hand" align="absmiddle" WIDTH="16" HEIGHT="16">
新增信息
<img src="/system/images/goback.gif" border="0" onclick="javascript:history.back();" title="返回" style="cursor:hand" align="absmiddle">
返回						
<!--    功能按钮结束    -->
<%@include file="/system/app/skin/skin4/template/list_listtop.jsp"%>                                                                                        
<!--    列表开始    -->
<table class="FindAreaTable1" cellspacing="1" rules="cols" border="0" id="ctl00_DataGrid_DataGrid1" style="border-width:0px;">
<tr class="bttn">
    <td width="5%" class="outset-table">序号</td>
    <td width="30%" class="outset-table">受理机构名称</td>
    <td width="30%" class="outset-table">受理机构地址</td>
    <td width="10%" class="outset-table" >联系电话</td>			
		<td width="16%" class="outset-table">生成日期</td>			
		<td width="5%" class="outset-table">编辑</td>            
</tr>
		<%
		String sqlStr = "select d.*,to_char(d.dt_create_time,'yyyy-mm-dd') as indate from tb_departinfo d order by dt_create_time desc,dt_id desc";
		vPage = dImpl.splitPage(sqlStr,request,15);
		if(vPage!=null){							
			for(int i=0; i<vPage.size(); i++){
				content = (Hashtable)vPage.get(i);
				dt_id = content.get("dt_id").toString();
				dt_name=content.get("dt_name").toString();
				dt_addr = content.get("dt_addr").toString();
				dt_phone = content.get("dt_phone").toString();
				dt_create_time=content.get("indate").toString();				
				if(i % 2 == 0)  out.print("<tr class=\"line-even\">");
            else out.print("<tr class=\"line-odd\">");
		%>		
			<td ><%=i+1%></td>
            <td ><%=dt_name%></td>
            <td ><%=dt_addr%></td>
            <td ><%=dt_phone%></td>
			<td ><%=dt_create_time%></td>
			<td ><a href="deptInfo.jsp?dt_id=<%=dt_id%>&OPType=Edit"><img class="hand" border="0" src="../../images/modi.gif" title="编辑" WIDTH="16" HEIGHT="16"></a></td> 
		</tr>		 
		<%			
			}
		}else{		
		%>
		<tr><td colspan=10>暂无信息</td></tr></table>		
		</td>
    </tr>
		<%
		}	
		%>
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