<%@page contentType="text/html; charset=GBK"%>
<%@include file="/system/app/skin/head.jsp"%>
<%
//update by yo 200912
String now_time = CDate.getNowTime();
String strTitle = "信访办接口统计数据列表(2009-08-15 12:59:59 至 "+now_time+")";
String sqlStr = "";
int vpsize = 0;
Vector vPage = null;
Hashtable content = null;
String dcl[] = null;//待转交信件数
String dclsb[] = null;//待处理转交失败信件数
String clz[] = null;//处理中转交成功信件数
String ywc[] = null;//已完成信件数
String cp_id[] = null;//信箱类型ID30
String cp_realid = "";//信箱类型ID
String nomoral_cl = "";//受理超时的信件数据
String nomoral_bl = "";//办理超时的信件数据

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
<!--    功能按钮结束    -->
<%@include file="/system/app/skin/skin4/template/list_listtop.jsp"%>                                                                                        
<!--    列表开始    -->
<table width="49%" border="0" cellspacing="1" rules="cols" class="FindAreaTable1" id="ctl00_DataGrid_DataGrid1" style="border-width:0px;">
  <tr class="bttn"> 
    <td width="14%" class="outset-table" nowrap rowspan="2">信箱名称</td>            
    <td colspan="2" align="center" nowrap class="outset-table">待处理信件</td>		
    <td align="center" nowrap class="outset-table">处理中信件</td>
    <td width="20%" align="center" nowrap class="outset-table">已完成信件</td> 
  </tr>
  <tr class="bttn">
    <td width="12%" class="outset-table" nowrap align="center">正待转交</td> 
    <td align="center" nowrap class="outset-table">转交失败</td>
    <td nowrap class="outset-table">转交成功</td>
    <td nowrap class="outset-table">转交成功</td>
  </tr>
   <%
//信访办信箱转交统计：区长信箱、信访信箱、阳光信箱
sqlStr = "select count(decode(cw_status||cw_zhuanjiao,'1'||'0',1,'')) as dcl,count(decode(cw_status||cw_zhuanjiao,'1'||'2',1,'')) as dclsb,count(decode(cw_status||cw_zhuanjiao,'2'||'1',1,'')) as clz,count(decode(cw_status||cw_zhuanjiao,'3'||'1',1,'')) as ywc,cp_id from tb_connwork where cw_applytime > to_date('2009-08-15 12:59:59','yyyy-MM-dd hh24:mi:ss') and cp_id in('o1','o5','mailYGXX') group by cp_id";

vPage= dImpl.splitPage(sqlStr,request,20);
if (vPage != null)
{
	vpsize = vPage.size();
	dcl = new String[vpsize+1];
	dclsb = new String[vpsize+1];
	clz = new String[vpsize+1];
	ywc = new String[vpsize+1];
	cp_id = new String[vpsize+1];
	for(int k=0;k<vPage.size();k++)
	{
		content = (Hashtable)vPage.get(k);
		dcl[k] = CTools.dealNull(content.get("dcl"));
		dclsb[k] = CTools.dealNull(content.get("dclsb"));
		clz[k] = CTools.dealNull(content.get("clz"));
		ywc[k] = CTools.dealNull(content.get("ywc"));
		cp_id[k] = CTools.dealNull(content.get("cp_id"));
	}
}
   
   
  if(vPage!=null)
  {
   for(int n=0;n<vpsize;n++)
   {	
	   if(n % 2 == 0)  out.print("<tr class=\"line-even\">");
	   else out.print("<tr class=\"line-odd\">");
%>
  <td>
  <%
  if("o1".equals(cp_id[n])){
  	out.print("区长信箱");
  }else if("o5".equals(cp_id[n])){
  	out.print("信访信箱");
  }else if("mailYGXX".equals(cp_id[n])){
  	out.print("阳光信箱");
  }%>  </td>
  <td><%=dcl[n]%></td>  
  <td><a href="<%="0".equals(dclsb[n])?"#":"../wardenmail/AppealNzj.jsp?cw_zhuanjiao=2"%>"><font color="red"><%=dclsb[n]%></font></a></td>
  <td><%=clz[n]%></td>
  <td><%=ywc[n]%></td>
</tr>
<%
  }
}
%>
</table>
<!--    列表结束    -->
<br/>
<!--    受理超时    -->
<table width="49%" border="0" cellspacing="1" rules="cols" class="FindAreaTable1" id="ctl00_DataGrid_DataGrid1" style="border-width:0px;">
  <tr class="bttn"> 
    <td width="14%" class="outset-table" nowrap>信箱名称</td>            
    <td align="center" nowrap class="outset-table">受理超时</td>		
  </tr>
  
   <%
//信访办接口异常数据统计：区长信箱、信访信箱、阳光信箱
sqlStr = "select count(*) as cou,cp_id from tb_connwork cw where sysdate-cw.cw_applytime-(select count(*) as cnt from tb_holiday where to_date(to_char(hd_date,'yyyy-MM-dd'),'yyyy-MM-dd')>=cw.cw_applytime and hd_flag=1 and to_date(to_char(hd_date,'yyyy-MM-dd'),'yyyy-MM-dd') <= sysdate) >3 and cw_applytime > to_date('2009-08-15 12:59:59','yyyy-MM-dd hh24:mi:ss') and cw.cw_status=1 and cp_id in('o1','o5','mailYGXX') group by cp_id  ";
   vPage= dImpl.splitPage(sqlStr,4,1);
  if(vPage!=null)
  {
   for(int n=0;n<vPage.size();n++)
   {	
   		content = (Hashtable)vPage.get(n);
   		nomoral_cl = CTools.dealNumber(content.get("cou"));
   		cp_realid = CTools.dealNull(content.get("cp_id"));
   
   if(n % 2 == 0)  out.print("<tr class=\"line-even\">");
   else out.print("<tr class=\"line-odd\">");
%>
  <td>
  <%
  if("o1".equals(cp_realid)){
  	out.print("区长信箱");
  }else if("o5".equals(cp_realid)){
  	out.print("信访信箱");
  }else if("mailYGXX".equals(cp_realid)){
  	out.print("阳光信箱");
  }%>  </td>
  <td><font color="red"><%=nomoral_cl%></font></td>  
  </tr>
<%
  }
/*分页的页脚模块*/
}
%>
</table>
<!--    办理超时    -->
<br/>
<table width="49%" border="0" cellspacing="1" rules="cols" class="FindAreaTable1" id="ctl00_DataGrid_DataGrid1" style="border-width:0px;">
  <tr class="bttn"> 
    <td width="14%" class="outset-table" nowrap>信箱名称</td>            
    <td align="center" nowrap class="outset-table">办理超时</td>		
  </tr>
  
   <%
//信访办接口异常数据统计：区长信箱、信访信箱、阳光信箱
sqlStr = "select count(*) as cou,cp_id from tb_connwork cw where sysdate-cw.cw_applytime-(select count(*) as cnt from tb_holiday where to_date(to_char(hd_date,'yyyy-MM-dd'),'yyyy-MM-dd')>=cw.cw_applytime and hd_flag=1 and to_date(to_char(hd_date,'yyyy-MM-dd'),'yyyy-MM-dd') <= sysdate) >60 and cw_applytime > to_date('2009-08-15 12:59:59','yyyy-MM-dd hh24:mi:ss') and cw.cw_status=2 and cp_id in('o1','o5','mailYGXX') group by cp_id ";
   vPage= dImpl.splitPage(sqlStr,4,1);
  if(vPage!=null)
  {
   for(int n=0;n<vPage.size();n++)
   {	
   		content = (Hashtable)vPage.get(n);
   		nomoral_bl = CTools.dealNumber(content.get("cou"));
   		cp_realid = CTools.dealNull(content.get("cp_id"));
   
   if(n % 2 == 0)  out.print("<tr class=\"line-even\">");
   else out.print("<tr class=\"line-odd\">");
%>
  <td>
  <%
  if("o1".equals(cp_realid)){
  	out.print("区长信箱");
  }else if("o5".equals(cp_realid)){
  	out.print("信访信箱");
  }else if("mailYGXX".equals(cp_realid)){
  	out.print("阳光信箱");
  }%>  </td>
  <td><font color="red"><%=nomoral_bl%></font></td>  
  </tr>
<%
  }
}
%>
</table>

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