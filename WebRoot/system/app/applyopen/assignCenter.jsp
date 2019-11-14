<%@page contentType="text/html; charset=GBK"%>
<%@include file="/system/app/skin/head.jsp"%>
<%
String pname = "";
String ename = "";
String infoid = "";
String infotitle = "";
String applytime = "";

String sqlStr = "";
String sqlWhere = "";
String strTitle = "";

String s_flownum = "";
String s_keyword = "";

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

s_flownum = CTools.dealString(request.getParameter("s_flownum")).trim();
s_keyword = CTools.dealString(request.getParameter("s_keyword")).trim();

if(!s_flownum.equals("")) sqlWhere += " and flownum='"+s_flownum+"'";
if(!s_keyword.equals("")) sqlWhere += " and commentinfo like'%"+s_keyword+"%'";

strTitle = "信息公开一体化 > 任务指派";
Object status = null;
status = request.getParameter("status");
if(status!=null&&status.equals("2"))
{
	sqlStr = "select id,infoid,infotitle,proposer,pname,ename,to_char(applytime,'yyyy-mm-dd') applytime,indexnum,flownum,commentinfo,signmode,dname from infoopen where id in (select iid from taskcenter where GENRE = '指派') and checktype!=9 order by applytime desc";
}
else
{
	sqlStr = "select id,infoid,infotitle,proposer,pname,ename,to_char(applytime,'yyyy-mm-dd') applytime,indexnum,flownum,commentinfo,signmode,dname from infoopen where  checktype!=9 and status = 0"+sqlWhere+" order by applytime desc";
}

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
function SelectAllCheck(des,name){
	var obj = eval("document.all." + name);
	if(typeof(obj)=="undefined"){
		return false;
	}else{
		if(obj.length==undefined){
			switch(des.checked){
				case false:
				obj.checked = false;
				break;
				case true:
				obj.checked = true;
				break;
				}
		}else{
			for(i=0;i<obj.length;i++){
				switch(des.checked){
					case false:
					obj[i].checked = false;
					break;
					case true:
					obj[i].checked = true;
					break;
				}
			}
		}
	}
}

function jobcheckup(t,o,c){
	var depId = document.all.depart.value;
	if(depId==-1)
	{
		alert("请选择指派部门！");
		return;
	}
	var obj = document.all.checkdel;
	var status = false;
	if(obj!=undefined){
		if(obj.length==undefined){
			obj.checked?status=true:status=false;
		}else{
			for(i=0;i<obj.length;i++){
				if(obj[i].checked){
					status=true;
					break;
				}
			}
		}
	}
	if(status){
		if(confirm("您确定这样操作？")){
			var form = document.formData;
			form.action = t;
			form.target = o;
			form.hDepart.value = depId;
			form.submit();
		}
	}else{
		alert("请至少选择一个记录！");
	}
}

	function refreshData()
	{
		location.reload("assignCenter.jsp?status="+formSearch.status.value);
	}
	
</script>
<table class="FindAreaTable1" cellspacing="1" rules="cols" border="0" id="ctl00_DataGrid_DataGrid1" style="border-width:0px;">
				<tr class="title1">
					<td colspan="10" align="center">
						<table WIDTH="100%" BORDER="0" CELLSPACING="1" CELLPADDING="1">
							<tr>
								<td valign="center" align="left"><%=strTitle%></td>
								<td valign="center" align="right" nowrap>
								<%
										if(!(status!=null&&status.equals("2")))
										{
										
								%>
									<select name="depart" >
										<option value="-1">请选择指派部门</option>
								<%
									if(vpd!=null)
									{
										for(int i=0;i<vpd.size();i++)
										{
											content1 = (Hashtable) vpd.get(i);
											String dpId = content1.get("dt_id").toString();
											String dpName = content1.get("dt_name").toString();
								%>
											<option value="<%=dpId%>"><%=dpName%></option>
								<%
										}
									}
								%>
									</select>
									<input type="button" value="指派" onclick="jobcheckup('assignIt.jsp','','8')" >
								<%
									}
								%>						
									</td>
							</tr>
						</table>
						</td>
				</tr>
				<tr class="bttn">
<%
					if(!(status!=null&&status.equals("2")))
					{
%>
					<td width="3%" class="outset-table"><input type="checkbox" onclick="javascript:SelectAllCheck(this,'checkdel');"></td>
<%
					}
					else
					{
%>
					<td width="3%" class="outset-table">-</td>
<%
					}
%>
					<td width="2%" class="outset-table"><font color="gray">*</font></td>
					<td width="15%" class="outset-table">事项流水号</td>
					<td width="30%" class="outset-table">申请信息描述</td>
					<td width="15%" class="outset-table">申请时间</td>
					<td width="10%" class="outset-table">受理方式</td>
					<td width="20%" class="outset-table">登记部门</td>
					<td colspan="2" class="outset-table">操作</td>
				</tr>
				<form name="formData" method="post">
				<input type="hidden" name="hDepart" />
				<%
				String commentinfo = "";
				if(vPage!=null){
					for(int i=0; i<vPage.size(); i++){
						content = (Hashtable)vPage.get(i);
						commentinfo = content.get("commentinfo").toString();
						if(commentinfo.length()>18) commentinfo = commentinfo.substring(0,17) + "...";
						commentinfo = commentinfo.replaceAll("&","&amp;");
						commentinfo = commentinfo.replaceAll("<","&lt;");
						commentinfo = commentinfo.replaceAll(">","&gt;");
						commentinfo = commentinfo.replaceAll("\"","&quot;");
						if(i%2 == 0) out.print("<tr class=\"line-even\">");
						else out.print("<tr class=\"line-odd\">");
				%>
<%
					if(!(status!=null&&status.equals("2")))
					{
%>
					<td align="center"><input name="checkdel" type="checkbox" value="<%=content.get("id")%>"></td>
<%
					}
					else
					{
%>
					<td align="center">-</td>
<%
					}
%>
					<td align="center"><font color="red">*</font></td>
					<td align="center"><%=content.get("flownum")%></td>
					<td align="left"><%=commentinfo%></td>
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
					<td align="center"><%=content.get("dname").toString().equals("")?"--":content.get("dname").toString()%>					</td>
<%
			if(!(status!=null&&status.equals("2")))
			{
%>
			<td width="7%" align="center"><a href="assignView.jsp?iid=<%=content.get("id")%>"><img class="hand" border="0" src="../../images/modi.gif" title="指派部门" WIDTH="16" HEIGHT="16"></a></td>
<%	
			}
			else
			{
%>
			<td width="5%" align="center"><a href="taskInfo.jsp?iid=<%=content.get("id")%>"><img class="hand" border="0" src="../../images/modi.gif" title="查看信息" WIDTH="16" HEIGHT="16"></a></td>
<%
			}
%>
					
				</tr>
				<%
					}
					out.println("</form>");
				}
				else{out.print("<tr><td colspan=20>无记录</td></tr>");}
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