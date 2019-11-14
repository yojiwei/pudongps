<%@page contentType="text/html; charset=GBK"%>
<%@include file="/system/app/skin/head.jsp"%>
<%String strTitle="在线提问" ;%>

<%
String title="";
String sqltitl ="";
String codee ="";
String readSign="";

title=CTools.dealString(request.getParameter("title")).trim();
codee=CTools.dealNumber(request.getParameter("codee")).trim();
readSign=CTools.dealNumber(request.getParameter("readSign")).trim();
//out.println(readSign);

String[] codeSel = new String[2];
  	switch(Integer.parseInt(codee))
  	{
		case 1:
			codeSel[1]="selected";
			sqltitl += "and cl_code = 1 ";
			break;
		default:
			codeSel[0]="selected";
			break;
	}
String[] readSel = new String[3];
  	switch(Integer.parseInt(readSign))
  	{
		case 1:
			readSel[1]="selected";
			sqltitl += "and cl_type = 1 ";
			break;
		case 2:
			readSel[2]="selected";
			sqltitl += "and cl_type = 0 ";
			break;
		default:
			readSel[0]="selected";
			break;
	}

if(!title.equals(""))
{
 sqltitl += "and cl_title like '%"+title+"%'  ";
}


%>
<%@include file="/system/app/skin/skin4/template/list_top.jsp"%>
<!--    模块名称开始    -->
<%=strTitle%>
<!--    模块名称结束    -->
<%@include file="/system/app/skin/skin4/template/list_function.jsp"%>                                                            
<!--    功能按钮开始    -->
  
<!--    功能按钮结束    -->
<%@include file="/system/app/skin/skin4/template/list_listtop.jsp"%>                                                                                        
<!--    列表开始    -->
<table class="FindAreaTable1" cellspacing="1" rules="cols" border="0" id="ctl00_DataGrid_DataGrid1" style="border-width:0px;">
<tr>
  <td width="100%">
    <table class="content-table" width="100%">
		  <tr class="title">
		  <FORM name="selectKind" METHOD=POST ACTION="SulList.jsp">
        <td colspan="7" align="left">		
			查询提问名称：<INPUT TYPE="text" NAME="title" class="text-line"><INPUT TYPE="submit" value ='查询'>　
			是否会计中心处理：<select name="codee" style="width:100" onchange="javascript:document.selectKind.submit();">
			<option value="" <%=codeSel[0]%>>全部</option>
			<option value="1" <%=codeSel[1]%>>会计中心处理</option>
			</select>　
			是否已读：<select name="readSign" style="width:100" onchange="javascript:document.selectKind.submit();">
			<option value="" <%=readSel[0]%>>全部</option>
			<option value="1" <%=readSel[1]%>>已读</option>
			<option value="2" <%=readSel[2]%>>未读</option>
			</select>
		</td>
			</FORM>	
		</tr>
         <tr class="bttn">
           <td width="5%" class="outset-table">序号</td>
           <td width="13%" class="outset-table">提问日期</td>
           <td width="20%" class="outset-table">提问名称</td>
           <td width="36%" class="outset-table">提问内容</td>
           <td width="8%" class="outset-table">已读标记</td>
           <td width="12%" class="outset-table">会计中心处理</td>
           <td width="6%" class="outset-table" nowrap>操作</td>           
         </tr>

<%


  //update20080122

CDataCn dCn=null;   //新建数据库连接对象
CDataImpl dImpl=null;  //新建数据接口对象

try {
 dCn = new CDataCn(); 
 dImpl = new CDataImpl(dCn); 
  String sql = "select cl_id,cl_title,cl_content,cl_type,cl_code,cl_submit_time from tb_consultation where 1=1 "+sqltitl+" order by cl_id desc";
  Vector vectorPage = dImpl.splitPage(sql,request,20);
  if(vectorPage != null)
  {
  for(int j=0;j<vectorPage.size();j++)
  {
  Hashtable content = (Hashtable)vectorPage.get(j);
	String cl_id = content.get("cl_id").toString();
	String cl_title = content.get("cl_title").toString();
	String cl_content = content.get("cl_content").toString();
	String cl_type = content.get("cl_type").toString();
	String cl_code = content.get("cl_code").toString();
	String cl_submit_time = content.get("cl_submit_time").toString();

	String type="未读";
	String code="否";
	
	if(cl_type.equals("1")){
		type ="已读";
	}
	if(cl_code.equals("1")){
		code ="是";
	}

	
	
	
	if(j % 2 == 0)
	{
	 out.println("<tr class=\"line-even\">");
	}
	else
	{
	 out.println("<tr class=\"line-odd\">");
	  }


%>
    <td align=center>
      <%=j+1%>
    </td>
    <td align="center"><%=cl_submit_time%></td>
    <td align="center"><%=cl_title%></td>
    <td ><%=cl_content%></td>
    <td align="center">
	<%
	if(cl_type.equals("0")){
String typeurl = "SulType.jsp?cl_id="+content.get("cl_id")+"";
if(!codee.equals("")){
	typeurl += "&codee="+codee;
}

	out.println("<A HREF='"+typeurl+"'>"+type+"</A>");
}else if(cl_type.equals("1")){
	out.println(type);
}
	
%>
	
	
	
	</td>
    <td align="center">
	<%
	if(cl_code.equals("0")){
String typeurl = "SulCode.jsp?cl_id="+content.get("cl_id")+"";
if(!codee.equals("")){
	typeurl = typeurl+"&codee="+codee+"";
}

	out.println("<A HREF='"+typeurl+"'>"+code+"</A>");
}else if(cl_code.equals("1")){
	out.println(code);
}
	
%></td>
	<td align="center">
		<a href="SulInfo.jsp?OPType=Edit&cl_id=<%=content.get("cl_id")%>"><img class="hand" border="0" src="../../../images/modi.gif" title="查看" WIDTH="16" HEIGHT="16"></a>
		<a href="SulDel.jsp?cl_id=<%=content.get("cl_id")%>"><img class="hand" border="0" src="/system/images/delete.gif" title="删除" WIDTH="16" HEIGHT="16" onclick="return window.confirm('确认要删除该记录么?');"></a>
		
		</td>
	
 </tr>
<%
}%>

<tr >
<td colspan=7>
</td>
</tr>
<%
//out.println("<tr><td colspan=10>" + dImpl.getTail(request) + "</td></tr>"); //输出尾部文件
out.println("</table>");
dImpl.closeStmt();
dCn.closeCn();
}
else
{
  out.println("<tr><td colspan=7 align=center class=line-odd>没有记录！</td></tr>");
}
%>
</table>
<!--    列表结束    -->
<%@include file="/system/app/skin/skin4/template/list_bottom.jsp"%>
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