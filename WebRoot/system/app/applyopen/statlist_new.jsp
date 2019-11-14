<%@page contentType="text/html; charset=GBK"%>
<%@include file="/system/app/skin/head.jsp"%>
<script language="javascript" src="/website/include/common.js"></script>
<script language="javascript" src="/website/include/check.js"></script>
<script language="javascript" src="net.js"></script>
<script language="javascript">
function selectyear()
{
	window.location.href="statlist_new.jsp?checkyear="+formyear.checkyear.value;
}
</script>
<%
String dpId="";
String dpName="";
String depart="";
String mysql="";
//统计查询有用
CDate today = new CDate();
String strDate = today.getThisday();
String strDate1= today.getLastday();
int strYear = today.getNowYear();

String strTitle = "";
String HD_remark = "";
String isHoliday = "";
String countSql="";
String countSql1="";
String owncount = "";
String sumthings = "";
String overthings="";
String ontimethings="";
String ownSql="";
String dealSql="";
String checkyear="";
String supplySql="";
String searchSql="";
CDataCn dCn = null;
CDataImpl dImpl = null;
Vector vpd = null;
Hashtable content = null;
ResultSet rs = null;
Statement stmtParam= null;
try{
dCn = new CDataCn();
dImpl = new CDataImpl(dCn);

stmtParam = dCn.getConnection().createStatement();

checkyear = CTools.dealString(request.getParameter("checkyear")).trim();//年度统计年份
depart = CTools.dealString(request.getParameter("depart")).trim();//部门ID
checkyear=checkyear.equals("")?strYear+"":checkyear;
//条件查询有用
String sql = "select dt_id,dt_name from tb_deptinfo where dt_infoopendept = 1 order by dt_sequence";
vpd = dImpl.splitPage(sql,200,1);

String strSql = "select * from TB_holiday where HD_DATE=to_date('"+strDate+"','YYYY-MM-DD')";
content = dImpl.getDataInfo(strSql);
if(content!=null)
{
    HD_remark = content.get("hd_remark").toString();
    isHoliday = content.get("hd_flag").toString();
}

//统计条件查询之条件SQL语句--按年度查询
supplySql+="  and to_char(o.applytime,'YYYY')="+checkyear+"";
searchSql+="  and to_char(to_date(ct_create_time,'yyyy-mm-dd'),'yyyy')="+checkyear+"";
strTitle = "信息公开一体化 > 年度统计";
%>
<%@include file="/system/app/skin/skin4/template/list_top.jsp"%>
<!--    模块名称开始    -->
<%=strTitle%>
<!--    模块名称结束    -->
<%@include file="/system/app/skin/skin4/template/list_function.jsp"%>                                              
<!--    功能按钮开始    -->
<img src="../../images/goback.gif" border="0" onClick="javascript:history.back();" title="返回" style="cursor:hand" align="absmiddle">
返回
<!--    功能按钮结束    -->
<%@include file="/system/app/skin/skin4/template/list_listtop.jsp"%>      
<!--    列表开始    -->
<table WIDTH="100%" class="content-table" CELLSPACING="1" CELLPADDING="1">
<form name="formyear" method="post">
			  <tr class="title1">
				<td valign="center" align="left"><%=strTitle%></td>
				<td valign="center" align="right" nowrap>
					<select name="checkyear" onChange="selectyear();">
					<option>请选择年份</option>
					<%for(int i=2003;i<2020;i++){%>
					<option value="<%=i%>" <%=checkyear.equals(i+"")?"selected":""%>><%=i%>年</option>
					<%}%>
					</select>&nbsp;
				</td>
 </tr></form>
 </table>
<table class="FindAreaTable1" cellspacing="1" rules="cols" border="0" id="ctl00_DataGrid_DataGrid1" style="border-width:0px;">
				<tr class="bttn">
					<td width="21%" class="outset-table">办理部门</td>
					<td width="16%" class="outset-table">信息公开总数(件数)</td>
					<td width="14%" class="outset-table">主动公开信息总数(件数)</td>
					<td width="14%" class="outset-table">依申请公开信息总数(件数)</td>
					<td width="14%" class="outset-table">依申请公开受理数(件数)</td>
				</tr>
						<%      
						out.println("<form name='formData1' method=post>");
						if(!depart.equals("")&&!depart.equals("-1"))
						{
							if(depart.equals("520")){
							mysql="select dt_id,dt_name from tb_deptinfo t where t.dt_name='法制办'";
							}else{
							mysql="select dt_id,dt_name from tb_deptinfo t where t.dt_id="+depart;
							}
						}
						else
						{
							mysql="select dt_id,dt_name from tb_deptinfo where dt_infoopendept = 1 order by dt_sequence";
						}
						
						vpd = dImpl.splitPage(mysql,request,200);
						if(vpd!=null)
						{
								for(int i=0;i<vpd.size();i++)
								{
									content = (Hashtable) vpd.get(i);
									dpId = content.get("dt_id").toString();
									dpName = content.get("dt_name").toString();
									
									/************************************在这里开始***************************************/
									//此部门信息公开总收件数
									ownSql="select count(t.ct_id) as id from tb_content t where t.dt_id="+dpId+"";
									ownSql+=searchSql;
									//主动公开信息总数
									countSql1="select count(t.ct_id) as id from tb_content t where t.dt_id="+dpId+" and t.IN_CATEGORY=1 ";
									countSql1+=searchSql;
									//此部门依申请公开信息总数
									dealSql="select count(t.ct_id) as id from tb_content t where t.dt_id="+dpId+" and t.IN_CATEGORY=2 ";
									dealSql+=searchSql;
									//依申请公开受理数（2007年开始，之前为空 ）
									countSql="select distinct o.id as id from infoopen o,taskcenter t where t.did="+dpId+" and t.iid=o.id and to_char(o.applytime,'YYYY')>2007";
									countSql+=supplySql;
									
									//此部门信息公开总收件数
									String xxgk="";
									content = dImpl.getDataInfo(ownSql);
									if(content!=null)
									{
										xxgk = content.get("id").toString();
									}
									//主动公开信息总数
									String zdgk="";
									content = dImpl.getDataInfo(countSql1);
									if(content!=null)
									{
										zdgk = content.get("id").toString();
									}
									//此部门依申请公开信息总数
									String ysqgk="";
									content = dImpl.getDataInfo(dealSql);
									if(content!=null)
									{
										ysqgk = content.get("id").toString();
									}
									//依申请公开受理数（2007年开始，之前为空 ）
									int dealcount=0;
									String dealid="";
									String dealids="";
									rs =stmtParam.executeQuery(countSql);
									while(rs!=null&&rs.next()){
									dealid=rs.getString("id").toString();
									dealids+=dealid+",";
									dealcount++;
									}
									if(dealids.endsWith(",")){
										dealids=dealids.substring(0,dealids.length()-1);
									}
									
									/*************************************在这里结束***************************************/		
									if(i%2 == 0) out.print("<tr class=\"line-even\">");
									else out.print("<tr class=\"line-odd\">");
						%>
					<td align="center"><%=dpName%></td>
					<td align="center"><%=xxgk%></td>
					<td align="center"><%=zdgk%></td>
					<td align="center"><%=ysqgk%></td>
					<td align="center">
					<%=(dealcount!=0)?"<a href='states_list.jsp?ids="+dealids+"' style='cursor:hand'/>":""%><%=dealcount%></td>
				</tr>
								<%
									}
									out.println("</form>");
								}else{
									out.println("<tr><td colspan=9>无记录</td></tr>");
								}
								%>
				<tr class="title1"><td colspan=20></td></tr>
			
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