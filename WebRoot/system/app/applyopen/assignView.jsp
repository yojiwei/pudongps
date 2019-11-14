<%@page contentType="text/html; charset=GBK"%>
<%@include file="/system/app/skin/head.jsp"%>
<%
//by ph 2007-3-3  信息公开一体化
String sqlStr = "";
Vector vPage = null;
Vector vpd = null;
Hashtable content = null;
String iid = CTools.dealString(request.getParameter("iid")).trim();
CDataCn dCn = null;
CDataImpl dImpl = null;
CDataImpl departImpl = null;

try{
dCn = new CDataCn();
dImpl = new CDataImpl(dCn);
departImpl = new CDataImpl(dCn);
String sql = "select dt_id,dt_name from tb_deptinfo order by dt_sequence ";
vpd = departImpl.splitPage(sql,request,200);

%>
<link href="applyopen.css" type="text/css" rel="stylesheet">
<script language="javascript" src="applyopen.js"></script>
<script>
	function assign(iid)
	{
		var flag1 = document.all.seleDep[0].checked;
		var sign = false;
		var depId = null;
		//alert(flag);
		if(flag1==false)
		{
			alert("请选择指派部门！");
			return;
		}
		//alert(document.all.did);
		var   el=document.getElementsByName("did");
        for(var i=0;i<el.length;i++)
		{   
             if(el[i].checked)
			 {   
				 //alert(el[i].value);
				 sign = true;
				 depId = el[i].value;
			 } 
        }
		if(sign==false)
		{
			alert("请选择指派部门！");
			return;
		}
		//alert(iid);
		var urlStr = "assign.jsp?iid="+iid+"&depId="+depId;
		//alert(urlStr);
		location.reload(urlStr);
	}
	function selectDep()
	{
		//document.all.aanswertime.value="";
		document.all.pass.style.display = "";
		wt("chooseDept.jsp","deptlist","chone");
	}
	function closeList()
	{
		document.all.pass.style.display = "none";
		deptlist.innerHTML = "";
	}
	function rubbish(iid)
	{
		var urlStr = "rubbish.jsp?cid=2&iid="+iid;
		location.reload(urlStr);
	}
</script>
<form name="formData" method="post" action="taskdeal.jsp">
<table class="main-table" width="100%">
	<tr class="title1" align="left">
		<td>信息公开一体化</td>
	</tr>
	<tr>
		<td width="100%">
			<table width="100%" class="content-table" height="1">
				<tr class="line-odd" >
					<td width="100%" colspan="2" align="left">&nbsp;<b>申请信息</b></td>
				</tr>
				<tr>
					<td colspan="2" class="line-even"><%@include file="applySheet.jsp"%></td>
				</tr>
				<tr class="line-odd" >
					<td width="100%" colspan="2" align="left">&nbsp;<b>办理流程</b></td>
				</tr>
				<tr>
					<td colspan="2" class="line-even"><%@include file="applyFlow.jsp"%></td>
				</tr>
			</table>
		</td>
	</tr>
	<!--tr align="left">
		<td>请选择指派部门:
		<select name="assignDepart">
			<option value="-1">---请选择---</option>
<%
					if(vpd!=null)
					{	
						for(int i=0;i<vpd.size();i++)
						{
							
							content = (Hashtable)vpd.get(i);
							String dpId = content.get("dt_id").toString();
							String dpName = content.get("dt_name").toString();
						
%>
							<option value="<%=dpId%>"><%=dpName%></option>
<%
						}
					}
%>
		</select>
		</td>
	</tr-->
	<tr class="title1" align="left" id="btnObj" style="display:"><td align="left">
	<input type="radio" name="seleDep" onclick="selectDep()" value="1"/>打开部门列表
	<input type="radio" name="seleDep" onclick="closeList()" value="2" checked />关闭部门列表
	</td>
	</tr>
	  <tr class="line-even" id="pass" style="display:none">
    <td colspan="5" align="center">
    	<table width="100%" cellspacing="0" cellpadding="0">
				<tr>
					<td valign="bottom">
						<table cellspacing="0" cellpadding="0" width="100%">
							<tr>
								<td id="chone" align="center" class="title_down" style="cursor:hand" onclick="javascript:wt('chooseDept.jsp','deptlist','chone');">直接选择委办局</td>
							</tr>
						</table>
					</td>
					<td class="title_mi" width="2"></td>
					<td valign="bottom">
						<table cellspacing="0" cellpadding="0" width="100%">
							<tr>
								<td id="chtwo" class="title_down" align="center" style="cursor:hand" onclick="javascript:wt('selectDept.jsp','deptlist','chtwo');">根据机构职能指派</td>
							</tr>
						</table>
					</td>
					<td class="title_mi" width="60%"></td>
				</tr>
			</table>
    </td>
  </tr>
  <tr class="line-odd">
  	<td align="center" colspan="5">
  		<table width="90%" border="0" cellspacing="0" cellpadding="0">
  			<tr>
  				<td id="deptlist" align="left"></td>
  			</tr>
  		</table>
  	</td>
  </tr>
	<tr class="title1" align="center" id="btnObj" style="display:">
		<td colspan="2">
			<input type="button" class="bttn" name="" value=" 指派 " onclick="assign('<%=iid%>');">&nbsp;
			<input type="button" class="bttn" name="" value="我来处理" onclick="claimIt('<%=iid%>');">&nbsp;
			<input type="button" class="bttn" name="" value="垃圾回收" onclick="rubbish('<%=iid%>');">&nbsp;
			<input type="button" class="bttn" name="" value=" 返回 " onclick="javascript:history.back();">
		</td>
	</tr>
</table>
</form>
<%}
catch(Exception e){
	out.print(e.toString());
}finally{
	dImpl.closeStmt();
	dCn.closeCn(); 
}
%>
<%@include file="../skin/bottom.jsp"%>

