<%@page contentType="text/html; charset=GBK"%>
<%@include file="/system/app/skin/head.jsp"%>
<script>
	function checkData()
	{
		var st = document.all.s_starttime.value;
		var et = document.all.s_endtime.value;
		if(st!=""&&st==et)
		{
			alert("时间间隔一致！请重新输入！");
			document.all.s_endtime.value = "";
		}
	}
	function searchData()
	{
		var st = formSearch.s_starttime.value;
		var et = formSearch.s_endtime.value;
		
		if(st==""&&et!="")
		{
			alert("请输入申请开始时间！");
			return;
		}
		if(st!=""&&et=="")
		{
			alert("请输入申请结束时间！");
			return;
		}
		if(st!=""&&et!="")
		{
			if(changeDate(st)>changeDate(et))
			{
				alert("开始时间不能晚于结束时间！");
				formSearch.s_starttime.value = "";
				formSearch.s_endtime.value = "";
				return;
			}
			
		}
		searchTerm();
	}
	function changeDate(dt)
	{
		var arry = dt.split('-');
		if(arry[1].length==1)
		{
			arry[1] = "0" + arry[1];
		}
		if(arry[2].length==1)
		{
			arry[2] = "0" + arry[2];
		}
		return arry[0]+"-"+arry[1]+"-"+arry[2];
	}
</script>
<%
String sqlStr = "";
Vector vPage = null;
Hashtable content = null;
CDataCn dCn = null;
CDataImpl dImpl = null;
String strTitle = "信息公开一体化 > 高级检索";
StringBuffer sqlWhere = new StringBuffer("");
String s_status = "";
String s_dealmode = "";
String s_keyword = "";
String s_flownum = "";
String s_name = "";
String s_starttime = "";
String s_endtime = "";

s_starttime = CTools.dealString(request.getParameter("s_starttime")).trim();
s_endtime = CTools.dealString(request.getParameter("s_endtime")).trim();
s_name = CTools.dealString(request.getParameter("s_name")).trim();
s_status = CTools.dealString(request.getParameter("s_status")).trim();
s_dealmode = CTools.dealString(request.getParameter("s_dealmode")).trim();
s_keyword = CTools.dealString(request.getParameter("s_keyword")).trim();
s_flownum = CTools.dealString(request.getParameter("s_flownum")).trim();

if(!s_status.equals("")){
	if(!s_flownum.equals("")){
		sqlWhere.append(" and i.flownum = '"+s_flownum+"'");
	}
	if(!s_keyword.equals("")){
		sqlWhere.append(" and i.commentinfo like'%"+s_keyword+"%'");
	}
	if(!s_name.equals("")){
		sqlWhere.append(" and (i.ename like '%"+s_name+"%' or i.pname like '%"+s_name+"%')");
	}
	if(!s_status.equals("")){
		sqlWhere.append(" and i.status in ("+s_status+")");
	}
	if(!s_dealmode.equals("")){
		sqlWhere.append(" and i.dealmode in ("+s_dealmode+")");
	}
	if(!s_starttime.equals("")&&s_starttime.equals(s_endtime))
	{
		String [] arry = s_endtime.split("-");
		if(arry[1].length()==1)
		{
			arry[1] = "0"+arry[1];
		}
		if(arry[2].length()==1)
		{
			arry[2] = "0"+arry[2];
		}
		s_endtime = arry[0] + "-" + arry[1] + "-" +arry[2];
		sqlWhere.append(" and to_char(i.applytime,'yyyy-mm-dd') = '"+s_endtime+"'");
	}
	else
	{
		if(!s_starttime.equals("")){
		sqlWhere.append(" and i.applytime >= to_date('"+s_starttime+"','yyyy-mm-dd')");
		}
		if(!s_endtime.equals("")){
			sqlWhere.append(" and i.applytime <= to_date('"+s_endtime+"','yyyy-mm-dd')");
		}
	}
	sqlStr = "select distinct i.id iid,i.flownum,to_char(i.applytime,'yyyy-mm-dd') applytime,i.signmode,i.commentinfo,i.dname from infoopen i,taskcenter t where 1=1" + sqlWhere.toString();
}
try{
dCn = new CDataCn();
dImpl = new CDataImpl(dCn);
/*得到当前登陆的用户id  开始*/
String uiid="";
CMySelf myProject = (CMySelf)session.getAttribute("mySelf");
if(myProject!=null && myProject.isLogin()){
	uiid = Long.toString(myProject.getMyID());
}else{
	uiid= "2";
}
/*得到当前登陆的用户id  结束*/
vPage = dImpl.splitPage(sqlStr,request,21);

%>
<%@include file="/system/app/skin/skin4/template/info_top.jsp"%>
<!--    模块名称开始    -->
<%=strTitle%>
<!--    模块名称结束    -->
<%@include file="/system/app/skin/skin4/template/info_funtion.jsp"%>
<!--    功能按钮开始    -->

<!--    功能按钮结束    -->
<%@include file="/system/app/skin/skin4/template/info_main.jsp"%>
<!--    表单提交开始    -->
<script language="javascript" src="applyopen.js"></script>
<table class="main-table" width="100%" CELLPADDING="0" cellspacing="0" BORDER="0">
				<tr>
					<td width="100%"><form name="formSearch" method="post" action="searchTerm.jsp">
						<table width="100%" class="content-table" >
							<tr class="line-even">
								<td width="15%" align="right">流水号：</td>
								<td width="35%" align="left"><input name="s_flownum" type="text" class="text-line" size="20"></td>
								<td width="15%" align="right">信息关键字：</td>
								<td width="35%" align="left"><input name="s_keyword" type="text" class="text-line" size="20"></td>
							</tr>   
							<tr class="line-even" >
								<td align="right">申请人/单位名称：</td>
								<td align="left"><input name="s_name" type="text" class="text-line" size="20"></td>
								<td align="right">申请时间：</td>
								<td align="left"><input name="s_starttime" type="text" class="text-line" size="10" readonly onclick="javascript:showCal()" style="cursor:hand"> - <input name="s_endtime" type="text" class="text-line" size="10" readonly onclick="javascript:showCal()" style="cursor:hand"></td>
							</tr>
							<tr class="line-even" >
								<td align="right">信息状态：</td>
								<td align="left" colspan="3"><input name="s_statusSTR" type="checkbox" value="0" checked>&nbsp;待认领&nbsp;&nbsp;&nbsp;<input name="s_statusSTR" type="checkbox" value="1" checked>&nbsp;待处理&nbsp;&nbsp;&nbsp;<input name="s_statusSTR" type="checkbox" value="2" checked onclick="javascript:dealOver(this,document.all.s_dealmodeSTR);">&nbsp;已完成&nbsp;&nbsp;&nbsp;<input name="s_statusSTR" type="checkbox" value="3" checked>&nbsp;征询中<input type="hidden" name="s_status"></td>
							</tr>
							<tr class="line-even" id="deal">
								<td align="right">办理结果：</td>
								<td align="left" colspan="3"><input name="s_dealmodeSTR" type="checkbox" value="0" checked onclick="dealOn(this,document.all.s_statusSTR[2]);">&nbsp;予以公开&nbsp;&nbsp;&nbsp;<input name="s_dealmodeSTR" type="checkbox" value="1" checked onclick="dealOn(this,document.all.s_statusSTR[2]);">&nbsp;部分公开&nbsp;&nbsp;&nbsp;<input name="s_dealmodeSTR" type="checkbox" value="2" checked onclick="dealOn(this,document.all.s_statusSTR[2]);">&nbsp;不于公开&nbsp;&nbsp;&nbsp;<input name="s_dealmodeSTR" type="checkbox" value="3" checked onclick="dealOn(this,document.all.s_statusSTR[2]);">&nbsp;信息不存在<input type="hidden" name="s_dealmode"></td>
							</tr>
							<tr class="line-even" height="38">
								<td align="right" colspan="4"><input type="button" class="bttn" name="fsubmit" value=" 查询符合条件的信息 " onclick="searchData();">&nbsp;<input type="reset" class="bttn" name="freset" value=" 重写 ">&nbsp;<input type="button" class="bttn" name="back" value=" 返回 " onclick="javascript:history.back();">&nbsp;&nbsp;</td>
							</tr></form>
						</table>
					</td>
				</tr>
				<%if(vPage!=null){%>
				<tr>
					<td width="100%">
						<table class="FindAreaTable1" cellspacing="1" rules="cols" border="0" id="ctl00_DataGrid_DataGrid1" style="border-width:0px;">
							<tr class="bttn">
								<td width="3%" class="outset-table"><input type="checkbox" onclick="javascript:SelectAllCheck(this,'checkdel');"></td>
								<td width="2%" class="outset-table"><font color="gray">*</font></td>
								<td width="15%" class="outset-table">事项流水号</td>
								<td width="30%" class="outset-table">申请信息描述</td>
								<td width="15%" class="outset-table">申请时间</td>
								<td width="10%" class="outset-table">受理方式</td>
								<td width="15%" class="outset-table">登记部门</td>
								<td width="5%" class="outset-table">指定</td>
								<td width="5%" class="outset-table" nowrap>&nbsp;<!-- 办理 --></td>
							</tr>
				<%
					for(int i=0; i<vPage.size(); i++){
						content = (Hashtable)vPage.get(i);
						String commentinfo = content.get("commentinfo").toString();
						if(commentinfo.length()>18) commentinfo = commentinfo.substring(0,17) + "...";
						if(i%2 == 0) out.print("<tr class=\"line-even\">");
						else out.print("<tr class=\"line-odd\">");
				%>
							<td align="center"><input name="checkdel" type="checkbox" value="<%=content.get("iid")%>"></td>
							<td align="center"><font color="red">*</font></td>
							<td align="center"><%=content.get("flownum")%></td>
							<td align="left"><%=commentinfo%></td>
							<td align="center"><%=content.get("applytime")%></td>
							<td align="center"><%
							if(content.get("signmode").toString().equals("0")){
								out.println("网上申请");
							}else if(content.get("signmode").toString().equals("1")){
								out.println("现场申请");
							}else{
								out.println("--");	
							}%></td>
							<td align="center"><%=content.get("dname").toString().equals("")?"--":content.get("dname").toString()%></td>
							<td align="center">--<%//=content.get("genre")%></td>
							<td align="center"><a href="taskInfo.jsp?iid=<%=content.get("iid")%>"><img class="hand" border="0" src="../../images/modi.gif" title="办理" WIDTH="16" HEIGHT="16"></a></td>
						</tr>
				<%
					}
					out.println("<tr><td colspan=9>" + dImpl.getTail(request) + "</td></tr>");
				%>
						</table>
					</td>
				</tr>
				<%}else{}%>
				<tr class="title1" align="center">
					<td></td>
				</tr>
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
                                     
