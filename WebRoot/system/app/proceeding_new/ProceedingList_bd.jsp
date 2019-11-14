<%@page contentType="text/html; charset=GBK"%>
<%@include file="/system/app/skin/head.jsp"%>
<%
String strTitle = "网上办事项目列表";
String projectId = "";
String OType = CTools.dealString(request.getParameter("OType")).trim();
String projectName = CTools.dealString(request.getParameter("projectName")).trim();
String pr_code = CTools.dealString(request.getParameter("pr_code")).trim();
String myname = CTools.dealString(request.getParameter("myname")).trim();
String commonWork = "";
String sortWork = "";
String userKind = "";
String departIdOut = "";
String departId = "";
String curUid = "";
String pr_isdel = "";

String pr_sequence = "";

String delStr = "";
String pr_edittime = "";
String pr_begintime = "";
String pr_endtime = "";

int currpageNumber = 20;
currpageNumber = Integer.parseInt(CTools.dealNumber(request.getParameter("page")==null?"20":request.getParameter("page")+"").trim());
String sqlStr = "select p.pr_id,p.pr_name,p.pr_code,p.dt_id,p.pr_isdel,pr_sequence,d.dt_name,to_char(pr_edittime,'yyyy-mm-dd') pr_edittime from tb_proceeding_new p,tb_deptinfo d";
sqlStr+=" where p.dt_id = d.dt_id "; 

//为查询做准备
if (OType.equals("query"))
{
		userKind = CTools.dealString(request.getParameter("userKind")).trim();
    commonWork = CTools.dealUploadString(request.getParameter("commonWork1")).trim();
    sortWork = CTools.dealUploadString(request.getParameter("sortWork")).trim();
    departIdOut = CTools.dealNumber(request.getParameter("departIdOut")).trim();//办理单位
		pr_begintime = CTools.dealNumber(request.getParameter("beginTime")).trim();
		pr_endtime = CTools.dealNumber(request.getParameter("endTime")).trim();


	strTitle += ">>搜索结果";
				if (!"".equals(projectName)) {
						sqlStr += " and p.pr_name like '%"+projectName+"%'";
				}
				if (!"".equals(pr_code)) {
					  sqlStr += " and p.pr_code like '%"+pr_code+"%'";
				}
				if (!"".equals(userKind) && !"0".equals(userKind)) {
					sqlStr += " and p.uk_id = '" + userKind + "'";
				}
        if(!commonWork.equals("")&&!commonWork.equals("0"))
        {
          sqlStr += " and p.cw_id='"+commonWork+"'";
        }
        if(!sortWork.equals("")&&!sortWork.equals("0"))
        {
          sqlStr += " and p.sw_id='"+sortWork+"'";
        }
        if(!departIdOut.equals("")&&!departIdOut.equals("0"))
        {
          //sqlStr += " and d.dt_idext="+departIdOut;
		  		sqlStr += " and d.dt_id="+departIdOut;
        }
				if(!pr_begintime.equals("")&&!pr_begintime.equals("0"))
        {
          sqlStr += " and p.pr_edittime >= to_date('" + pr_begintime + "','yyyy-mm-dd')";
        }
				if(!pr_endtime.equals("")&&!pr_endtime.equals("0"))
        {
          sqlStr += " and p.pr_edittime <= to_date('" + pr_endtime + "','yyyy-mm-dd')";
        }
}

/*//update by yo 20100715 用户测试
com.app.CMySelf mySelflogin = new com.app.CMySelf();
mySelflogin.login("jjw_01","1");
session.setAttribute("mySelflogin",mySelflogin);
com.app.CMySelf mySelf = (com.app.CMySelf)session.getAttribute("mySelflogin");
//update by yo--------over
*/
com.app.CMySelf mySelf = (com.app.CMySelf)session.getAttribute("mySelf");
if (mySelf!=null)
{
	departId = Long.toString(mySelf.getDtId());
	curUid = mySelf.getMyUid();
}
else
{
	response.sendRedirect("/system/app/index.jsp");
	out.close();
}


if(!(departId.equals("")||curUid.equals("")))
{
	if (!curUid.equals("administrator"))
	{   
		if(curUid.equals("czj"))//财政局
		{
			sqlStr +="and p.pr_id in (select pr_id from tb_worklinksort_new where gw_id in (select gw_id from tb_gasortwork where dt_id = "+departId+"))";	
		}else{
			if(!departId.equals("57")){ //投资办
				sqlStr += " and (d.dt_id="+departId+" or p.pr_sourcedtid="+departId+")";
				}
			else {
				sqlStr += " and d.dt_id=57";
				}
		}
	}

}
sqlStr += " and p.pr_isdel is null order by p.pr_sequence,p.pr_edittime desc,p.pr_id desc";
//out.println(sqlStr);

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
每页显示
<select id="contype" onchange="pageNumber(this)">
	<option value="20" <%=(currpageNumber+"").equals("20")?"selected":""%>>20</option>
	<option value="50" <%=(currpageNumber+"").equals("50")?"selected":""%>>50</option>
	<option value="100" <%=(currpageNumber+"").equals("100")?"selected":""%>>100</option>
</select>
<img src="../../images/menu_about.gif" border="0" onclick="window.location='ProceedingQuery.jsp'" title="查找项目" style="cursor:hand" align="absmiddle" WIDTH="16" HEIGHT="16">
查找项目
<img src="../../images/new.gif" border="0" onclick="window.location='ProceedingInfo_bd.jsp'" title="新建项目" style="cursor:hand" align="absmiddle" WIDTH="16" HEIGHT="16">
新建项目
<img src="../../images/dialog/sort.gif" border="0" onclick="setSequence()" title="修改排序" style="cursor:hand" align="absmiddle" WIDTH="15" HEIGHT="15">
修改排序
<img src="../../images/goback.gif" border="0" onclick="javascript:history.back();" title="返回" style="cursor:hand" align="absmiddle">
返回							
<!--    功能按钮结束    -->
<%@include file="/system/app/skin/skin4/template/list_listtop.jsp"%>
<!--    列表开始    -->
<script language="javascript">
function selectAll()
{
	var obj = formData.del;
	var length;
	if(typeof(obj)=="undefined") return false;
	if(typeof(obj.length)=="undefined")
	{
		obj.checked = formData.checkAll.checked;
	}
	else
	{
		length = obj.length;
		for(var i=0;i<length;i++)
		{
		  obj[i].checked = formData.checkAll.checked;
		}
	}
}

function delSelect()
{
  var isok = false;
  var obj = formData.del;
  if(typeof(obj)=="undefined") return false;
  if(typeof(obj.length)=="undefined")
  {
    if(obj.checked)
      isok = true;
  }
  else
  {
    for(var i=0;i<obj.length;i++)
    {
      if(obj[i].checked)
      {
        isok = true;
        break;
      }
    }
  }
  if(isok)
  {
    if(confirm("确定要删除吗?"))
    {
      formData.action = "ProceedingInfoDel.jsp";
      formData.submit();
    }
  }
  else
  {
    alert("至少要选择一个项目！");
    return false;
  }
}
function deleteThis(val)
{
  if(confirm("此操作将删除所有和本项目相关的办事事项，确实要删除吗？"))
  {
  	formData.projectId.value = val;
    formData.action = "ProceedingInfoDel.jsp";
    formData.submit();
  }
}

function setSequence()
{
  formData.action = "setSequence.jsp";
  formData.submit();
}

function pageNumber(obj)
{
	var page = obj.value;
	location.reload("ProceedingList.jsp?page="+page);
}

</script>
<table class="FindAreaTable1" cellspacing="1" rules="cols" border="0" id="ctl00_DataGrid_DataGrid1" style="border-width:0px;">
<form name="formData">
	<input type="hidden" name="projectId" value="">
	<input type="hidden" name="OType" value="<%=OType%>">
	<input type="hidden" name="userKind" value="<%=userKind%>">
	<input type="hidden" name="commonWork1" value="<%=commonWork%>">
	<input type="hidden" name="sortWork" value="<%=sortWork%>">
	<input type="hidden" name="departIdOut" value="<%=departIdOut%>">
	<input type="hidden" name="beginTime" value="<%=pr_begintime%>">
	<input type="hidden" name="endTime" value="<%=pr_endtime%>">
	<!--update by dongliang-->
	<INPUT TYPE="hidden" name="curpage" value="<%=CTools.dealNumber(request.getParameter("strPage"))%>">
  <tr class="bttn" width="100%" >
    <td align="center" width="7%" nowrap>项目ID</td>
    <td align="center" width="35%" nowrap>项目名称</td>
	<td align="center" width="20%" nowrap>办理部门</td>
	<td align="center" width="13%" nowrap>更新日期</td>
	<td align="center" width="5%" nowrap>常见问答</td>
	<td align="center" width="5%" nowrap>协办部门</td>
	<td align="center" width="5%" nowrap>删除</td>
	<td align="center" width="5%" nowrap>编辑</td>
   <td align="center" width="5%" nowrap>排序</td>
  </tr>
<%
Vector vPage = dImpl.splitPage(sqlStr,request,currpageNumber);
Hashtable content = null;
if (vPage != null)
{
	for (int i=0;i<vPage.size();i++)
	{
		content = (Hashtable)vPage.get(i);
		projectId = content.get("pr_id").toString();
		pr_sequence = content.get("pr_sequence").toString();
		pr_isdel = content.get("pr_isdel").toString();
		pr_edittime = content.get("pr_edittime").toString();
		if(pr_isdel.equals("1"))
		{
			delStr = "是";
		}
		else
		{
			delStr = "否";
		}
		%>
		<tr width="100%" <%if (i%2==0) out.print("class='line-odd'");else out.print("class='line-even'");%>>
			<td align="center"><%=content.get("pr_id").toString()%></td>
			<td align="left" title="<%=projectName%>">
			<% //输出项目名称
				projectName = content.get("pr_name").toString();
				if(projectName.length()>40)
				{
					projectName = projectName.substring(0,38) + "...";
				}
				out.print(projectName);
			%></td>
			<td align="center">
			<%
				out.print(content.get("dt_name").toString());
			 %></td>
		   <td align="center"><%=pr_edittime%>
		   </a>		   </td>
		   <td align="center">
		   <span style="cursor:hand" onclick="javascript:window.location='AnswerList.jsp?pr_id=<%=content.get("pr_id").toString()%>&curpage=<%=CTools.dealNumber(request.getParameter("strPage"))%>&pr_name=<%=projectName%>'"><img src="/system/images/clip.gif"  title="常见问答" width="15" height="15" border="0"></span></td>
		   <td align="center">
		   <span style="cursor:hand" onclick="javascript:window.location='../corrdeptmanage/CorrDeptList.jsp?pr_id=<%=content.get("pr_id").toString()%>'"><img src="/system/images/clip.gif" title="协办部门维护" width="15" height="15" border="0"></span>			</td>
			<td align="center"><a href="#" onClick="deleteThis('<%=projectId%>')">
				<img class="hand" border="0" src="../../images/delete.gif" title="删除" WIDTH="16" HEIGHT="16"></a>
			</td>
			<td align="center">
				<a href="ProceedingInfo_bd.jsp?OType=Edit&curpage=<%=CTools.dealNumber(request.getParameter("strPage"))%>&projectId=<%=projectId%>"><img class="hand" border="0" src="../../images/modi.gif" title="项目编辑" WIDTH="16" HEIGHT="16"></a>
			</td>
			<td align="center"><input type=text class=text-line name=<%="module"+projectId%> value="<%=pr_sequence%>" size=4 maxlength=4></td>
		</tr>
		<%
	}
}
else
{
	out.print("<tr class='line-even'><td colspan=9>没有匹配记录</td></tr>");
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