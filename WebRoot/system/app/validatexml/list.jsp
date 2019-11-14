<%@page contentType="text/html; charset=GBK"%>
<%@include file="/system/app/skin/head.jsp"%>
<%
CMySelf myselfmain = (CMySelf)session.getAttribute("mySelf");	
String dt_id =String.valueOf(myselfmain.getDtId()); 
String strTitle = "";
//update20080122
CDataCn dCn=null;   //新建数据库连接对象
CDataImpl dImpl=null;  //新建数据接口对象

try {
 dCn = new CDataCn(); 
 dImpl = new CDataImpl(dCn); 


  //String sql ="select x.el_id,v.ec_name,v.ec_corporation from tb_entemprvisexml x,tb_enterpvisc v where  x.pp_id ="+dt_id+" and x.ec_id =v.ec_id order by x.el_id desc";

String type =CTools.dealString(request.getParameter("type")).trim();
String typexml ="";
if(!type.equals(""))
{
	if(type.equals("0")){
		strTitle = "未处理列表";
		typexml=" and el_type=0 ";
	}else{
		strTitle = "已处理列表";
		typexml=" and el_type!=0 ";
	}
}  
	String sql ="select x.el_id,v.ec_name,v.ec_corporation,x.el_type from tb_entemprvisexml x,tb_enterpvisc v where x.ec_id =v.ec_id  "+typexml+" and  ec_name is not null and ec_corporation is not null order by x.el_id desc";
%>
<%@include file="/system/app/skin/skin4/template/list_top.jsp"%>
<!--    模块名称开始    -->
<%=strTitle%>
<!--    模块名称结束    -->
<%@include file="/system/app/skin/skin4/template/list_function.jsp"%>                                                            
<!--    功能按钮开始    -->
<img src="/system/images/menu_about.gif" border="0" onclick="javascript:window.location.href='search.jsp'" title="查找" style="cursor:hand" align="absmiddle">
查找              
<!--    功能按钮结束    -->
<%@include file="/system/app/skin/skin4/template/list_listtop.jsp"%>                                                                                        
<!--    列表开始    -->
<table class="FindAreaTable1" cellspacing="1" rules="cols" border="0" id="ctl00_DataGrid_DataGrid1" style="border-width:0px;">
 <tr class="bttn">
   <td width="40%" class="outset-table">单位名称</td>
   <td width="45%" class="outset-table">法人代表</td>
   <td width="15%" class="outset-table" nowrap>编辑</td>
 </tr>
<%
  String strData = null; //初始化
  int i = 0;
  Vector vectorPage = dImpl.splitPage(sql,request,20);
  if(vectorPage != null)
  {
  for(int j=0;j<vectorPage.size();j++)
  {
  Hashtable content = (Hashtable)vectorPage.get(j);


if(j % 2 == 0)
{
 out.println("<tr class=\"line-even\">");
}
else
{
 out.println("<tr class=\"line-odd\">");
  }
  String el_id = content.get("el_id").toString();
  String el_type = content.get("el_type").toString();
  String ec_name = content.get("ec_name").toString();
  String ec_corporation = content.get("ec_corporation").toString();
  String url = "";
  if(el_type.equals("0")){
	url = "<A HREF='info.jsp?el_id="+el_id+"&typeod=s'>审核</A>";
  }else{
	url = "<A HREF='info.jsp?el_id="+el_id+"&typeod=c'>查看</A>";
  }
%>
    <td align="center"><%=ec_name%></td>
    <td align="center"><%=ec_corporation%></td>
		<td  align="center">
	<%=url%>
	</td>
<%
}%>
<tr >
<%
}
else
{
  out.println("<tr><td colspan=6 align=center class=line-odd>没有记录！</td></tr>");
}
%>
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