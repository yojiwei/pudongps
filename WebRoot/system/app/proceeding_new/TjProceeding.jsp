<%@page contentType="text/html; charset=GBK"%>
<%@include file="/system/app/skin/head.jsp"%>
<script language="javascript">
function banshi(){
	location.href="TjPorceeding.jsp?order=1";
}
function fmshow()
{
	var w = screen.availWidth;
	var h = screen.availHeight;
	var url = "printTjProceeding.jsp";
	window.showModalDialog(url,0,'dialogTop=0px;dialogLeft=0px;dialogWidth='+w+'px;dialogHeight='+h+'px;help=no;status=no;scroll=yes;resizable=yes;');
}
function tochange(){
	var cc = document.all.dt_type.value;
	window.location.href="TjProceeding.jsp?dt_type="+cc;
}
</script>
<%
String strTitle = "新事项统计";
String sqlDept="";
String sqlPro = "";
String sqlProTable = "";
String sqlProAnswer ="";
String dt_id = "";
String times = "";
String dt_name="";
String coun="";
String counpr="";
int countprs = 0;
int counpas = 0;
int countprc = 0;
int counanses = 0;
String counpa="";
String pr_count = "";
String counans = "";
int num = 0;
String order = "";
String dt_type = "";
String sqlWhere = "";
// update by yo 20090519
CDataCn dCn = null;
CDataImpl dImpl = null;
Hashtable contentPro = null;
Hashtable contentProTa  = null;
Hashtable contentProAns = null;
Hashtable content = null;
Vector vPage = null;
try{
dCn = new CDataCn();
dImpl = new CDataImpl(dCn);
//
order  = CTools.dealString(request.getParameter("order"));
dt_type  = CTools.dealString(request.getParameter("dt_type"));
dt_type = dt_type.equals("")?"1":dt_type;
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
	  <td colspan="5" align="left">
	    <select name="dt_type" onchange="tochange()">
	      <option value="1" <%=dt_type.equals("1")?"selected":""%>>部门</option>
	      <option value="0" <%=dt_type.equals("0")?"selected":""%>>街道镇</option>
        </select></td>
	  <td align="right"><a href="#" onclick="fmshow()">打印预览</a></td>
	  <td width="22%"><a href="printTjExcel.jsp">导出EXECEL</a></td>
    </tr>
	<tr>
	  <td width="7%">序号</td>
	  <td width="26%">部门</td>
	  <td width="13%">办事规程▲</td><!--↑--->
	  <td width="11%">表格下载▲</td>
	  <td width="11%">常见问题数▲</td>
	  <td width="10%">浏览数▲</td>
	  <td width="22%">最后维护日期▲</td>
  </tr>
<%
//1委办局0街道镇
if(dt_type.equals("1")){
	//sqlWhere = " where p.dt_id in(select d.dt_id as id from tb_deptinfo d where d.dt_iswork=1 and (dt_parent_id = 1129 or d.dt_id = 35 or d.dt_id = 34))";
	sqlDept = "select d.dt_name,d.dt_id from tb_deptinfo d where d.dt_id in (select p.dt_id from tb_proceeding_new p where p.dt_id in(select d.dt_id as id from tb_deptinfo d where d.dt_iswork=1 and (dt_parent_id = 1129 or d.dt_id = 35 or d.dt_id = 34))) and d.dt_iswork = 1";
}else if(dt_type.equals("0")){
	//加入了南汇的街道镇
	//sqlWhere = " where p.dt_id in(select dt_id as id from tb_deptinfo where dt_parent_id in (select dt_id from tb_deptinfo where dt_name like '%功能区域%') and dt_iswork=1)";
	sqlDept = "select d.dt_name,d.dt_id from tb_deptinfo d where d.dt_id in (select p.dt_id from tb_proceeding_new p where p.dt_id in(select dt_id as id from tb_deptinfo where dt_parent_id in (select dt_id from tb_deptinfo where dt_name like '%功能区域%') and dt_iswork=1)) union select d.dt_name, d.dt_id from tb_deptinfo d where d.dt_parent_id in(20051,20050)";
}
//有办事事项的单位
//sqlDept = "select d.dt_name,d.dt_id from tb_deptinfo d where d.dt_id in (select p.dt_id from tb_proceeding_new p where p.dt_id in(select dt_id as id from tb_deptinfo where dt_parent_id in (select dt_id from tb_deptinfo where dt_name like '%功能区域%') and dt_iswork=1)) and d.dt_iswork = 1";



vPage = dImpl.splitPage(sqlDept,200,1);
if(vPage!=null)	{
	for(int j=0;j<vPage.size();j++){
		content = (Hashtable)vPage.get(j);
		dt_id = content.get("dt_id").toString();
		dt_name = content.get("dt_name").toString();
//部门下面办事事项的数据统计
sqlPro = "select count(pr_id) as cunpr,max(pr_edittime) as times,sum(pr_count) as pr_count from tb_proceeding_new where dt_id ="+dt_id+"";

contentPro = dImpl.getDataInfo(sqlPro);
if(contentPro!=null){
	counpr = contentPro.get("cunpr").toString();
	times = CTools.getDate(contentPro.get("times").toString());
	pr_count = CTools.dealNumber(contentPro.get("pr_count"));
	
}else{
	counpr = "0";
}
//部门下面办事事项的附件数据统计
sqlProTable = "select count(pa_id) as cunpa from tb_proceedingattach_new p where pr_id in (select n.pr_id from tb_proceeding_new n where n.dt_id ="+dt_id+")";

contentProTa = dImpl.getDataInfo(sqlProTable);
if(contentProTa!=null){
	counpa = contentProTa.get("cunpa").toString();
}else{
	counpa = "0";
}
//部门下面办事事项的常见问答的数据统计
sqlProAnswer = "select count(pa_id) as cunans from tb_proceeding_ask p where pr_id in (select n.pr_id from tb_proceeding_new n where n.dt_id ="+dt_id+")";

contentProAns = dImpl.getDataInfo(sqlProAnswer);
if(contentProAns!=null){
	counans = contentProAns.get("cunans").toString();
}else{
	counans = "0";
}
%>
	<tr>
		<td><%=j+1%></td>
		<td><%=dt_name%></td>
		<td><font color="<%="0".equals(counpr)?"red":""%>"><%=counpr%></font></td>
		<td><%=counpa%></td>
		<td><%=counans%></td>
		<td><%=pr_count%></td>
		<td><%=times%></td>
	</tr>
<%
//有关办事事项的总数据统计
		countprs+=Integer.parseInt(counpr);
		counpas+=Integer.parseInt(counpa);
		countprc+=Integer.parseInt(pr_count);
		counanses += Integer.parseInt(counans);
	}
}
%>
	<tr>
	  <td colspan="2" align="center"><strong>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;总&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;计</strong></td>
	  <td><%=countprs%></td>
	  <td><%=counpas%></td>
	  <td><%=counanses%></td>
	  <td><%=countprc%></td>
	  <td align="center">--</td>
  </tr>
</table>
<!--    列表结束    -->
                    </td>
                </tr>
                <tr class="bttn" align="center">
                    <td width="100%">&nbsp;
                    </td>
                </tr>
				<tr class="bttn" align="center">
                    <td width="100%">&nbsp;
                    </td>
                </tr>
            </table>
            <!--    列表结束    -->
        </td>
    </tr>
</table>
</body>
</html>
<%
}
catch(Exception e){
			System.out.println(new java.util.Date() + "--"
			+ request.getServletPath() + " : " + e.getMessage());
}
finally{
	dImpl.closeStmt();
	dCn.closeCn(); 
}
%>
<%@include file="/system/app/skin/bottom.jsp"%>