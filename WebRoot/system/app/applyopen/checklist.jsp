<%@page contentType="text/html; charset=GBK"%>
<%@include file="/system/app/skin/head.jsp"%>
<%
String pname = "";
String ename = "";
String infoid = "";
String infotitle = "";
String applytime = "";
String checktime = "";
String commentinfodetail = "";
String sqlStr = "";
String sqlWhere = "";
String strTitle = "";
String checktype="";//监查类别1指派任务2即将超时3已经超时
String typestatus = "";
String ctCreateTime = new CDate().getThisday(); //获得当前时间

CDataCn dCn = null;
CDataImpl dImpl = null;
CDataImpl dImpl1 = null;

Vector vPage = null;
Vector vpd = null;
Hashtable content = null;
Hashtable content1 = null;

try{
dCn = new CDataCn();
dImpl = new CDataImpl(dCn);
dImpl1 = new CDataImpl(dCn);

checktype = CTools.dealString(request.getParameter("checktype")).trim();
strTitle = "信息公开一体化 > 监查列表";
Object status = null;
status = request.getParameter("status");
sqlStr = "select id,infoid,infotitle,proposer,pname,ename,to_char(applytime,'yyyy-mm-dd') applytime,floor(to_date('"+ctCreateTime+"','yyyy-mm-dd') - to_date(to_char(limittime, 'yyyy-MM-dd'), 'yyyy-MM-dd')) as abc,indexnum,flownum,commentinfo,signmode,dname,checktype,to_char(limittime,'yyyy-mm-dd') limittime from infoopen ";
	if(!checktype.equals("")&&!checktype.equals("0"))   //9垃圾回收站里的任务
	{
		sqlStr+="where status=1 and checktype="+checktype+" ";
	}
	else
	{
		sqlStr+="where status=1 and checktype in (1,2,3) ";
	}
sqlStr+=" order by applytime";
vPage = dImpl.splitPage(sqlStr,request,20);

String sql = "select dt_id,dt_name from tb_deptinfo where dt_infoopendept = 1 order by dt_sequence";
vpd = dImpl1.splitPage(sql,200,1);
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
<script language="javascript">
function selectmy()
{
	window.location.href="checklist.jsp?checktype="+formmy.checktype.value;
}
</script>
<table WIDTH="100%" BORDER="0" CELLSPACING="1" CELLPADDING="1">
	<form name="formmy" method="post"><tr>
		<td valign="center" align="left"><%=strTitle%></td>
		<td valign="center" align="right" nowrap>
		
			<select name="checktype" onChange="selectmy();">
			  <option value="-1">请选择监查类别</option>
			  <option value="0">所有监查类别</option>
			  <option value="1">指派任务</option>
			  <option value="2">即将超时</option>
			  <option value="3">已超时</option>
			</select></td>
	</tr></form>
</table>
<table class="FindAreaTable1" cellspacing="1" rules="cols" border="0" id="ctl00_DataGrid_DataGrid1" style="border-width:0px;">
				<tr class="bttn">
					<td width="5%" class="outset-table">警告</td>
					<td width="11%" class="outset-table">事项流水号</td>
					<td width="22%" class="outset-table">申请信息描述</td>
					<td width="11%" class="outset-table">申请时间</td>
					<td width="8%" class="outset-table">受理方式</td>
					<td width="13%" class="outset-table">监查类别</td>
					<td width="21%" class="outset-table">登记部门</td>
					<td colspan="2" class="outset-table">查看</td>
				</tr>
				<form name="formData" method="post">
				<input type="hidden" name="hDepart" />
				<%
				String commentinfo = "";
				int abc = 0;
				int xyz = 0;
				if(vPage!=null){
					for(int i=0; i<vPage.size(); i++){
						content = (Hashtable)vPage.get(i);
						commentinfo = content.get("commentinfo").toString();
						commentinfodetail=commentinfo;
						if(commentinfo.length()>13) commentinfo = commentinfo.substring(0,12) + "...";
						commentinfo = commentinfo.replaceAll("&","&amp;");
						commentinfo = commentinfo.replaceAll("<","&lt;");
						commentinfo = commentinfo.replaceAll(">","&gt;");
						commentinfo = commentinfo.replaceAll("\"","&quot;");
						typestatus = content.get("checktype").toString();
						abc = Integer.parseInt(CTools.dealNumber(content.get("abc")));
						//指派任务----黄牌
						if(typestatus.equals("1"))
						{
							xyz=1;
						}else if(typestatus.equals("2"))//即将超时--黄牌
						{
							xyz=4;
						}
						else if(typestatus.equals("3"))//超时任务-----超时1个月之内（红牌）、超过一个月（黑牌）
						{
							if(abc>0&&abc<30)
							{
								xyz=2;//超时1个月之内（红牌）
							}else
							{
								xyz=3;//超过一个月（黑牌）
							}
							
						}
						if(i%2 == 0) out.print("<tr class=\"line-even\">");
						else out.print("<tr class=\"line-odd\">");
				%>
					<td align="center"><img class="hand" border="0" src="images/<%switch (xyz){case 1:out.print("y");break;case 2:out.print("r");break;case 3:out.print("b");break;case 4:out.print("y");break;}%>.gif" 
						title="<%switch (xyz){case 1:out.print("指派任务");break;case 2:out.print("超时30天之内");break;case 3:out.print("已超时30天");break;case 4:out.print("即将超时");break;}%>" WIDTH="16" HEIGHT="16"></td>
					<td align="center"><%=content.get("flownum")%></td>
					<td align="left" title="<%=commentinfodetail%>"><%=commentinfo%></td>
					<td align="center"><%=content.get("applytime")%></td>
					<td align="center"><%
					if(content.get("signmode").toString().equals("0")){
						out.println("网上申请");
					}else if(content.get("signmode").toString().equals("1")){
						out.println("现场申请");
					}else if(content.get("signmode").toString().equals("2")){
						out.println("E-mail申请");
					}else if(content.get("signmode").toString().equals("3")){
						out.println("信函申请");
					}else if(content.get("signmode").toString().equals("4")){
						out.println("电报申请");
					}else if(content.get("signmode").toString().equals("5")){
						out.println("传真申请");
					}else if(content.get("signmode").toString().equals("6")){
						out.println("其他");
					}
					else{
						out.println("--");	
					}%></td>
					<td align="center">
					  <%
					  if(content.get("checktype").toString().equals("1"))
					  {
					  	out.println("指派任务");
					  }else if(content.get("checktype").toString().equals("2"))
					  {
					  	out.println("即将超时");
					  }else if(content.get("checktype").toString().equals("3"))
					  {
					  	out.println("已超时");
					  }
					  %>
					</td>
					<td align="center"><%=content.get("dname").toString().equals("")?"--":content.get("dname").toString()%>					</td>
					<td align="center">
<a href="taskInfo.jsp?iid=<%=content.get("id")%>"><img class="hand" border="0" src="../../images/modi.gif" title="查看信息" WIDTH="16" HEIGHT="16"></a></td>
				</tr>
				<%
					}
					out.println("</form>");
				}else{
					out.println("<tr><td colspan=20>无记录</td></tr>");
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