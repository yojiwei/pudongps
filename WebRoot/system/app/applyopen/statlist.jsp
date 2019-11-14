<%@page contentType="text/html; charset=GBK"%>
<%@include file="/system/app/skin/head.jsp"%>
<script language="javascript" src="/website/include/common.js"></script>
<script language="javascript" src="/website/include/check.js"></script>
<script language="javascript" src="net.js"></script>
<script language="Javascript">
function checkForm()
{
  var form = document.formData;
  form.action="statlist.jsp";
  form.submit();
}
function tochecked(sdate)
{
	var form = document.formData;
	if(sdate!=form.HandleTime1.value){
	  form.applyTime.checked=true;
	}
}
function tochecked1(sdate)
{
	var form = document.formData;
	if(sdate!=form.HandleTime3.value){
	  form.finishTime.checked=true;
	}
}
</script>
<%
String pname = "";
String ename = "";
String infoid = "";
String infotitle = "";
String dpId="";
String dpName="";
String sqlStr = "";
String sqlWhere = "";
String depart="";
String cscount="";    //超时
String uncscount="";   //不超时
String fdid="";
String dt_name="";
String mysql="";
CDataCn dCn = null;
CDataImpl dImpl = null;
String sql1="";
String sql2="";
//统计查询有用
CDate today = new CDate();
String strDate = today.getThisday();
String strDate1= today.getLastday();
int strYear = today.getNowYear();
String strTitle = "";
String HD_remark = "";
String isHoliday = "";
String s_status = "";
//

String applyStartTime="";
String applyEndTime="";
String finishStartTime="";
String finishEndTime="";
String statuses="";//项目当前状态集合
String genres ="";
String applytime="";
String finishtime="";
String countSql="";
String countSql1="";
String owncount = "";
String sumthings = "";
String overthings="";
String ontimethings="";
String dealcount="";
String ownSql="";
String dealSql="";

Vector vpd = null;
Hashtable content = null;
ResultSet rs = null;
ResultSet rs1 = null;
ResultSet rs2 = null;
ResultSet rs3 = null;
Statement stmtParam= null;
try{
dCn = new CDataCn();
dImpl = new CDataImpl(dCn);

stmtParam = dCn.getConnection().createStatement();

String[] status = request.getParameterValues("status"); //项目当前状态
String[] genre =  request.getParameterValues("genre"); //项目过程状态
//one
if(status!=null&&status.length>0){
for(int i=0;i < status.length;i++){
	if(i<status.length-1){
	statuses+=status[i]+",";
	}
	else{
	statuses+=status[i];
	}
}
}
//two
if(genre!=null&&genre.length>0){
for(int i=0;i < genre.length;i++){
	genres+="'"+CTools.dealString(genre[i])+"',";
}
if(genres.endsWith(",")){
	genres=genres.substring(0,genres.length()-1);
}
}

depart = CTools.dealString(request.getParameter("depart")).trim();//部门ID
applytime = CTools.dealString(request.getParameter("applyTime")).trim();//有没有选中时间复选框
finishtime = CTools.dealString(request.getParameter("finishTime")).trim();//有没有选中时间复选框

applyStartTime=CTools.dealString(request.getParameter("HandleTime1")).trim();//用户申请开始时间
applyEndTime=CTools.dealString(request.getParameter("HandleTime2")).trim();//用户申请结束时间

finishStartTime=CTools.dealString(request.getParameter("HandleTime3")).trim();//办理终结开始时间
finishEndTime=CTools.dealString(request.getParameter("HandleTime4")).trim();//办理终结结束时间

s_status = CTools.dealString(request.getParameter("s_status")).trim();
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
//统计条件查询之条件SQL语句
String supplySql="";
if(!"".equals(statuses)){
supplySql+=" and o.status in ("+statuses+")";
}
if(!"".equals(applytime)&&"1".equals(applytime)){
supplySql+=" and to_date(to_char(o.applytime, 'yyyy-MM-dd'), 'yyyy-MM-dd') between to_date('"+applyStartTime+"','yyyy-MM-dd') and to_date('"+applyEndTime+"','yyyy-MM-dd')";
}
if(!"".equals(finishtime)&&"2".equals(finishtime)){
supplySql+=" and to_date(to_char(o.finishtime, 'yyyy-MM-dd'), 'yyyy-MM-dd') between to_date('"+finishStartTime+"','yyyy-MM-dd') and to_date('"+finishEndTime+"','yyyy-MM-dd')";
}
if(!"".equals(genres)){
supplySql+="  and t.genre in ("+genres+")";
}
//supplySql+="  and to_char(o.applytime,'YYYY')="+strYear+"";
//2008年度总结性SQL语句
String summarizeSql="select count(id) as sumthings from infoopen o where to_char(applytime,'YYYY')="+strYear+"";
//已处理完成
String suoliwengSql="select count(id) as overthings from infoopen o where to_char(applytime,'YYYY')="+strYear+" and status=2";
//按时处理
String ontimeSql="select count(id) as ontimethings from infoopen o where to_char(applytime,'YYYY')="+strYear+" and o.isovertime=2 and o.status=2";
content = dImpl.getDataInfo(summarizeSql);
if(content!=null)
{
    sumthings = content.get("sumthings").toString();
}
content = dImpl.getDataInfo(suoliwengSql);
if(content!=null)
{
    overthings = content.get("overthings").toString();
}
content = dImpl.getDataInfo(ontimeSql);
if(content!=null)
{
    ontimethings = content.get("ontimethings").toString();
}

strTitle = "信息公开一体化 > 统计查询";
%>
<%@include file="/system/app/skin/skin4/template/info_top.jsp"%>
<!--    模块名称开始    -->
<%=strTitle%>
<!--    模块名称结束    -->
<%@include file="/system/app/skin/skin4/template/info_funtion.jsp"%>
<!--    功能按钮开始    -->
<img src="../../images/goback.gif" border="0" onClick="javascript:history.back();" title="返回" style="cursor:hand" align="absmiddle">
返回
<!--    功能按钮结束    -->
<%@include file="/system/app/skin/skin4/template/info_main.jsp"%>
<!--    表单提交开始    -->
<table CELLPADDING="0" cellspacing="0" BORDER="0" width="100%" >
<form name="formData" method="post">
    <tr class="line-odd">
      <td align="right" width="243" height="1">
	  <input type="checkbox" name="applyTime" value="1" <%="".equals(applytime)?"":"checked"%>> 按用户申请时间统计：</td>
      <td width="712" height="1" align="left">
	  <input size="17" type="text" class="text-line" name="HandleTime1" value="<%="".equals(applyStartTime)?strDate1:applyStartTime%>" readonly>
        &nbsp; <img src="images/calendar.gif" border="0" onClick="showCal(HandleTime1),tochecked('<%=strDate1%>')" align="absmiddle" WIDTH="22" HEIGHT="21" style="cursor:hand">&nbsp;&nbsp;－&nbsp;&nbsp;
        <input size="17" type="text" class="text-line" name="HandleTime2" value="<%="".equals(applyEndTime)?strDate:applyEndTime%>" readonly>
        &nbsp; <img src="images/calendar.gif" border="0" onClick="showCal(HandleTime2)" align="absmiddle" WIDTH="22" HEIGHT="21"  style="cursor:hand"> </td>
    </tr>
    <tr class="line-even">
      <td align="right" width="243" height="1">
	  <input type="checkbox" name="finishTime" value="2" <%="".equals(finishtime)?"":"checked"%>> 按办理终结时间统计：</td>
      <td width="712" height="1" align="left">
	  <input size="17" type="text" class="text-line" name="HandleTime3" value="<%="".equals(finishStartTime)?strDate1:finishStartTime%>" readonly>
        &nbsp; <img src="images/calendar.gif" border="0" onClick="showCal(HandleTime3),tochecked1('<%=strDate1%>')" align="absmiddle" WIDTH="22" HEIGHT="21" style="cursor:hand">&nbsp;&nbsp;－&nbsp;&nbsp;
        <input size="17" type="text" class="text-line" name="HandleTime4" value="<%="".equals(finishEndTime)?strDate:finishEndTime%>" readonly>
        &nbsp; <img src="images/calendar.gif" border="0" onClick="showCal(HandleTime4)" align="absmiddle" WIDTH="22" HEIGHT="21"  style="cursor:hand"> </td>
    </tr>
	<input type="hidden" name="s_status" value="520"/>
    <tr class="line-odd">
      <td align="right" width="243" height="1">统计部门：</td>
      <td width="712" height="1" align="left" valign="left">
      	<select name="depart" >
          <option value="-1">全部部门</option>
		  <option value="520" <%=depart.equals("520")?"selected":""%>>法制办</option>
          <%
	if(vpd!=null)
	{
		for(int i=0;i<vpd.size();i++)
		{
			content = (Hashtable) vpd.get(i);
			dpId = content.get("dt_id").toString();
			dpName = content.get("dt_name").toString();
%>
          <option value="<%=dpId%>" <%=dpId.equals(depart)?"selected":""%>><%=dpName%></option>
          <%
		}
	}
%>
        </select>
      </td>
    </tr>
    <tr class="line-even">
      <td align="right" width="243" height="1">项目当前状态：</td>
      <td width="712" height="1" align="left">
      	<input type="checkbox" name="status" value="1" <%=statuses.indexOf("1")>=0?"checked":""%>> 处理中 
      	<input type="checkbox" name="status" value="2" <%=statuses.indexOf("2")>=0?"checked":""%>> 已完成 
      	<input type="checkbox" name="status" value="3" <%=statuses.indexOf("3")>=0?"checked":""%>> 征询中 
      	<input type="checkbox" name="status" value="4" <%=statuses.indexOf("4")>=0?"checked":""%>> 延期中 
      </td>
    </tr>
    <tr class="line-odd">
      <td align="right" width="243" height="1">项目过程状态：</td>
      <td width="712" height="1" align="left">
      	<input type="checkbox" name="genre" value="指派" <%=genres.indexOf("指派")>=0?"checked":""%>> 指 派 
      	<input type="checkbox" name="genre" value="认领"<%=genres.indexOf("认领")>=0?"checked":""%>> 认 领 
      	<input type="checkbox" name="genre" value="转办"<%=genres.indexOf("转办")>=0?"checked":""%>> 转 办 
      	<input type="checkbox" name="genre" value="网上申请"<%=genres.indexOf("网上申请")>=0?"checked":""%>> 网上申请 
      	<input type="checkbox" name="genre" value="现场申请"<%=genres.indexOf("现场申请")>=0?"checked":""%>> 现场申请 
      </td>
    </tr>
    <tr  class="line-even" align="center">
      <td colspan="2"><input type="button" class="bttn" value=" 确 定 "  name="fsubmit" onClick="checkForm()">
        <input type="reset" class="bttn" value=" 重 写 " name="freset">
        &nbsp;
		</td>
    </tr>
	</table>
	</form>
		</td>
	</tr>
	<tr class="line-odd">
		<td>
		<font color="#FF0000"><%=strYear%>年度信息公开申请总数为“<%=sumthings%>”件、已办理“<%=overthings%>”件、其中按时办理“<%=ontimethings%>”件</font>
		</td>
	</tr>
	<tr style="display:<%="".equals(s_status)?"none":""%>">
		<td width="100%">
			<table class="FindAreaTable1" cellspacing="1" rules="cols" border="0" id="ctl00_DataGrid_DataGrid1" style="border-width:0px;">
						
				<tr class="bttn">
					<td width="21%" class="outset-table">办理部门</td>
					<td width="16%" class="outset-table">总收件数(件数)</td>
					<td width="14%" class="outset-table">处理中(件数)</td>
					<td width="14%" class="outset-table">按时办理(件数)</td>
					<td width="14%" class="outset-table">超时办理(件数)</td>
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
							//超时办理SQL
							countSql="select distinct o.id as id from infoopen o,taskcenter t ";
							countSql+=" where t.did="+dpId+" and o.isovertime=1 and t.iid=o.id ";
							countSql+=supplySql;
							//按时办理SQL
							countSql1="select distinct o.id as id  from infoopen o ,taskcenter t ";
							countSql1+=" where t.did="+dpId+" and o.isovertime=2 and t.iid=o.id";
							countSql1+=supplySql;
							//此部门总共收件数
							ownSql="select distinct o.id as id from infoopen o,taskcenter t where t.did="+dpId+" and t.iid=o.id";
							ownSql+=supplySql;
							//此部门总共待处理件数
							dealSql="select distinct o.id as id from infoopen o,taskcenter t where t.did="+dpId+" and t.iid=o.id and o.status<>2";           
							dealSql+=supplySql;
							//超时处理件数
							int notontimecount=0;
							String notontimeid="";
							String notontimeids="";
							rs3 =stmtParam.executeQuery(countSql);
							while(rs3!=null&&rs3.next()){
							notontimeid=rs3.getString("id").toString();
							notontimeids+=notontimeid+",";
							notontimecount++;
							}
							if(notontimeids.endsWith(",")){
								notontimeids=notontimeids.substring(0,notontimeids.length()-1);
							}
							//按时处理件数
							int ontimecount=0;
							String ontimeid="";
							String ontimeids="";
							rs2 =stmtParam.executeQuery(countSql1);
							while(rs2!=null&&rs2.next()){
							ontimeid=rs2.getString("id").toString();
							ontimeids+=ontimeid+",";
							ontimecount++;
							}
							if(ontimeids.endsWith(",")){
								ontimeids=ontimeids.substring(0,ontimeids.length()-1);
							}
							//此部门总共收件数
							int owncounts=0;
							String ownid="";
							String ownids="";
							rs1 =stmtParam.executeQuery(ownSql);
							while(rs1!=null&&rs1.next()){
							ownid=rs1.getString("id").toString();
							ownids+=ownid+",";
							owncounts++;
							}
							if(ownids.endsWith(",")){
								ownids=ownids.substring(0,ownids.length()-1);
							}
							//此部门总处理件数
							int dealcounts=0;
							String dealid="";
							String dealids="";
							rs =stmtParam.executeQuery(dealSql);
							while(rs!=null&&rs.next()){
							dealid=rs.getString("id").toString();
							dealids+=dealid+",";
							dealcounts++;
							}
							if(dealids.endsWith(",")){
								dealids=dealids.substring(0,dealids.length()-1);
							}	/*************************************在这里结束**********************************/
				%>
				
				<tr class="bttn">
					<td align="center"><%=dpName%></td>
					<td align="center">
					<%=(owncounts!=0)?"<a href='states_list.jsp?ids="+ownids+"' style='cursor:hand'/>":""%><%=owncounts%></td>
					<td align="center">
					<%=(dealcounts!=0)?"<a href='states_list.jsp?ids="+dealids+"' style='cursor:hand'/>":""%><%=dealcounts%></td>
					<td align="center">
					<%=(ontimecount!=0)?"<a href='states_list.jsp?ids="+ontimeids+"' style='cursor:hand'/>":""%><%=ontimecount%></td>
					<td align="center">
					<%=(notontimecount!=0)?"<a href='states_list.jsp?ids="+notontimeids+"' style='cursor:hand'/>":""%><%=notontimecount%></td>
				</tr>
				<%
					}
					out.println("</form>");
					out.println("<tr><td colspan=9>" + dImpl.getTail(request) + "</td></tr>");
				}else{
					out.println("<tr><td colspan=9>无记录</td></tr>");
				}
				%>
</table>
<!--    表单提交结束    -->
<%@include file="/system/app/skin/skin4/template/info_bottom.jsp"%> 
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
                                     
