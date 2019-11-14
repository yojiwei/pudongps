<%@page contentType="text/html; charset=GBK"%>
<%@include file="/system/app/skin/head.jsp"%>
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

strTitle = "信息公开一体化 > 垃圾回收站";
Object status = null;
sqlStr = "select id,infoid,infotitle,proposer,pname,ename,to_char(applytime,'yyyy-mm-dd') applytime,indexnum,flownum,commentinfo,signmode,dname from infoopen where checktype=9 order by applytime";

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

<form name="formData" method="post">
<table WIDTH="100%" BORDER="0" CELLSPACING="1" CELLPADDING="1">
<tr>
	<td width="75%" align="left" valign="center"><%=strTitle%></td>
	<td width="25%" align="right" valign="center">
		<input type="button" value="恢复" onclick="jobcheckup('rubbish.jsp?cid=3','','8')" >																	                                </td>
</tr>
</table>
<table class="FindAreaTable1" cellspacing="1" rules="cols" border="0" id="ctl00_DataGrid_DataGrid1" style="border-width:0px;">
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
					if(!(status!=null&&status.equals("2"))){
					%>
					<td align="center"><input name="checkdel" type="checkbox" value="<%=content.get("id")%>"></td>
					<%
					}
					else{
					%>
					<td align="center">-</td>
					<%
					}
					%>
					<td align="center"><font color="red">*</font></td>
					<td align="center"><a href="taskInfo.jsp?iid=<%=content.get("id").toString()%>"><%=content.get("flownum")%></a></td>
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
<td width="7%" align="center"><a href="rubbish.jsp?iid=<%=content.get("id")%>&cid=1">恢复</a></td>
				</tr>
				<%
					}
				}else{
					out.println("<tr><td colspan=19>暂时没有信息！</td></tr>");
				}
				%>
			</form>
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