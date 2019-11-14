<%@page contentType="text/html; charset=GBK"%>
<%@include file="/system/app/skin/head.jsp"%>
<%
String sqlWait="";
String selfdtid="";
String sender_id="";
//
String v_sid = "";
String v_sname = "";//事项名称
String ivname = "";//事项分类名称
String ovname = "";//办理部门名称
String v_stype = "";//事项类型
String c_sobject = "";//服务对象
String cavailable = "";//控制办理事项是否前台显示Y有效N无效
String vurl = "";//网上在线服务
String vremark = "";//备注
String vgist = "";//办理依据
String vcondition = "";//办理条件
String vprocess = "";//办理程序
String vcharge = "";//收费标准及依据
String vtimelimit = "";//办理期限及服务承诺
String vdoclist = "";//办事需提交的材料目录
String vcontacttel = "";//联系电话
String vaddress = "";//办理地点
String vwindowsno = "";//受理窗口
String vweburl = "";//办理网址
String vlawsuittel = "";//投诉电话
String vlawsuitpro = "";//投诉处理时限
String vworkflwo = ""; //存放办事流程图片路径
String v_onlineservice = ""; //记录网上办事模块网址 
String orgids = "";
//update by 20090716
CDataCn dCn = null;
CDataImpl dImpl = null;
Hashtable content = null;
Vector vectorPage = null;
try{
dCn = new CDataCn();
dImpl = new CDataImpl(dCn);
//

CMySelf self = (CMySelf)session.getAttribute("mySelf");
if(self!=null){
	selfdtid = String.valueOf(self.getDtId());//取当前用户部门id的值
	sender_id = String.valueOf(self.getMyID());//取当前用户id的值
}
orgids = CTools.dealString(request.getParameter("v_orgid"));

sqlWait="select distinct s.v_sid,s.v_sname,i.v_name as ivname,o.v_name as ovname,s.v_stype,s.c_sobject,s.C_Available,s.v_url,s.v_remark,g.v_gist,g.v_condition,g.v_process,g.v_charge,g.v_timelimit,g.v_doclist,g.v_contacttel,g.v_address,g.v_windowsno,g.v_weburl,g.d_edittime,g.v_lawsuittel,g.v_lawsuitpro,g.v_workflow,g.v_onlineservice from hss_serviceitem s, hss_serviceguide g,hsm_organ o, hss_serviceindex i  where s.v_sid = g.v_sid and s.v_orgid = o.v_orgid and s.v_sid = i.v_sid and s.ismove=0 ";
if(!orgids.equals("")){
	sqlWait += "and o.v_orgid="+orgids+"";
}


//out.println(sqlWait);
%>
<script language="javascript">
function toNanHui(v_orgid){
	window.location.href="NanHuiProceedingList.jsp?v_orgid="+v_orgid;
}	
</script>
<%@include file="/system/app/skin/skin4/template/list_top.jsp"%>
<!--    模块名称开始    -->
南汇办事事项列表
<!--    模块名称结束    -->
<%@include file="/system/app/skin/skin4/template/list_function.jsp"%>                                                            
<!--    功能按钮开始    -->
<select name="v_orgid" style="width:160px" onchange="toNanHui(this.value)">
<option value="0">选择相关受理部门</option>
<%
String deptSql = "";
String sdt_id = "";
String sdt_name = "";
Vector dept_list = null;
Hashtable dept_content = null;
deptSql = "select v_orgid,v_name from hsm_organ";
dept_list = dImpl.splitPageOpt(deptSql,500,1);
if (dept_list != null) {
  for (int i=0;i<dept_list.size();i++) {
  dept_content = (Hashtable)dept_list.get(i);
  sdt_id = dept_content.get("v_orgid").toString();
  sdt_name = dept_content.get("v_name").toString();
%>
<option value="<%=sdt_id%>" <%=sdt_id.equals(orgids)?"selected":""%>><%=sdt_name%></option>
<%
  }
}
%>
</select>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<!--    功能按钮结束    -->
<%@include file="/system/app/skin/skin4/template/list_listtop.jsp"%>                                                                                        
<!--    列表开始    -->
<table class="FindAreaTable1" cellspacing="1" rules="cols" border="0" id="ctl00_DataGrid_DataGrid1" style="border-width:0px;">
 <tr class="bttn">
    <td width="2%" class="outset-table" align="center">序号</td>
    <td width="25%" class="outset-table" align="center">事项名称</td>
    <td width="5%" class="outset-table" align="center" >事项类型</td>
    <td width="5%" class="outset-table" align="center">办理部门</td>
    <td width="10%" class="outset-table" align="center">服务对象</td>
    <td width="5%" class="outset-table" align="center">操作</td>
 </tr>
 <form name="formData">
<%
vectorPage = dImpl.splitPage(sqlWait,request,20);
if(vectorPage!=null)
{
  for(int i=0;i<vectorPage.size();i++)
  {
	  content = (Hashtable)vectorPage.get(i);
	   v_sid = CTools.dealNull(content.get("v_sid"));
	   v_sname= CTools.dealNull(content.get("v_sname"));
	   v_stype= CTools.dealNull(content.get("v_stype"));
	   ovname= CTools.dealNull(content.get("ovname"));
	   c_sobject= CTools.dealNull(content.get("c_sobject"));
	   if("A".equals(c_sobject)){
	   		c_sobject = "个人";
	   }else if("B".equals(c_sobject)){
	   		c_sobject = "企业";
	   }else if("C".equals(c_sobject)){
	   		c_sobject = "投资";
	   }else if("D".equals(c_sobject)){
	   		c_sobject = "旅游";
	   }
	   //A:个人，B:企业，C:投资，D:旅游
%>
	<tr class="<%if(i%2==0)out.print("line-even");else out.print("line-odd");%>">
	<td align="center"><%=i+1%></td>
	<td align="center"><%=v_sname%></td>
	<td align="center"><%=v_stype%></td>
	<td align="center"><%=ovname%></td>
	<td align="center"><%=c_sobject%></td>
	<td align="center"><a href="NanHuiProceedingInfo.jsp?projectId=<%=v_sid%>">查看</a>
		<!--|<a href="NanHuiProceedingResult.jsp?v_sid=<%=v_sid%>">导入</a>--></td>
	</tr>
</form>
<%
    }
}
else
{
	out.println("<tr><td colspan=10>暂时没有记录</td></tr>");
}
%>
</table>
<!--    列表结束    -->
<%@include file="/system/app/skin/skin4/template/list_bottom.jsp"%> 
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