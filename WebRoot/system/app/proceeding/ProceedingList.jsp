<%@page contentType="text/html; charset=GBK"%>
<%@include file="/system/app/skin/head.jsp"%>
<script>
	function pageNumber(obj)
	{
		var page = obj.value;
		location.reload("ProceedingList.jsp?page="+page);
	}
</script>
<%
String strTitle = "网上办事项目列表";
String projectId = "";
String OType    = CTools.dealString(request.getParameter("OType")).trim();
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
String sqlStr = "select p.pr_id,p.pr_name,p.pr_code,p.dt_id,p.pr_isdel,pr_sequence,to_char(pr_edittime,'yyyy-mm-dd') pr_edittime from tb_proceeding p";
if(myname.equals("wssb")||myname.equals("hdxcjd"))
{
	sqlStr+=",tb_worklinksort w ";
}
sqlStr+=" where 1=1 "; 

currpageNumber = Integer.parseInt(CTools.dealNumber(request.getParameter("page")==null?"20":request.getParameter("page")+"").trim());
//为查询做准备
if (OType.equals("query"))
{
		userKind = CTools.dealString(request.getParameter("userKind")).trim();
        commonWork = CTools.dealUploadString(request.getParameter("commonWork1")).trim();
        sortWork = CTools.dealUploadString(request.getParameter("sortWork")).trim();
        departIdOut = CTools.dealNumber(request.getParameter("departIdOut")).trim();
		pr_begintime = CTools.dealNumber(request.getParameter("beginTime")).trim();
		pr_endtime = CTools.dealNumber(request.getParameter("endTime")).trim();


	strTitle += ">>搜索结果";
				if (!"".equals(projectName)) {
						sqlStr += " and pr_name like '%"+projectName+"%'";
				}
				if (!"".equals(pr_code)) {
					  sqlStr += " and pr_code like '%"+pr_code+"%'";
				}
				if (!"".equals(userKind) && !"0".equals(userKind)) {
					sqlStr += " and uk_id = '" + userKind + "'";
				}
        if(!commonWork.equals("")&&!commonWork.equals("0"))
        {
          sqlStr += " and cw_id='"+commonWork+"'";
        }
        if(!sortWork.equals("")&&!sortWork.equals("0"))
        {
          sqlStr += " and sw_id='"+sortWork+"'";
        }
        if(!departIdOut.equals("")&&!departIdOut.equals("0"))
        {
          sqlStr += " and dt_idext="+departIdOut;
        }
				if(!pr_begintime.equals("")&&!pr_begintime.equals("0"))
        {
          sqlStr += " and pr_edittime >= to_date('" + pr_begintime + "','yyyy-mm-dd')";
        }
				if(!pr_endtime.equals("")&&!pr_endtime.equals("0"))
        {
          sqlStr += " and pr_edittime <= to_date('" + pr_endtime + "','yyyy-mm-dd')";
        }
}

com.app.CMySelf mySelf = (com.app.CMySelf)session.getAttribute("mySelf");
if (mySelf!=null)
{
	departId = Long.toString(mySelf.getDtId());
	//out.println("dtid:" + departId);
	curUid = mySelf.getMyUid();
}
else
{
	response.sendRedirect("/system/app/index.jsp");
	out.close();
}

if(!(departId.equals("")||curUid.equals("")))
{
	if (!curUid.equals("admin"))
	{                      
		if(!departId.equals("57")) sqlStr += " and (dt_id="+departId+" or dt_idext="+departId+" or pr_sourcedtid="+departId+")";
		else sqlStr += " and dt_idext=57";
	}
	if(myname.equals("wssb"))
	{
     sqlStr+="and p.pr_id = w.pr_id and w.pr_id in (select pr_id from tb_worklinksort l where l.gw_id in  ";
     sqlStr+="(select gw_id from tb_gasortwork where gw_name='企业社会责任网事项'))";
	}
	if(myname.equals("hdxcjd"))
	{
     sqlStr+="and p.pr_id = w.pr_id and w.pr_id in (select pr_id from tb_worklinksort l where l.gw_id in  ";
     sqlStr+="(select gw_id from tb_gasortwork where dt_id='20018'))";
	}
}
sqlStr += " and pr_isdel is null order by pr_sequence,pr_edittime desc,pr_id desc";


CDataCn dCn = new CDataCn();
CDataImpl dImpl = new CDataImpl(dCn);
%>
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
</script>

<table class="main-table" width="100%">
  <form name="formData">
    <input type="hidden" name="projectId" value="">
    <input type="hidden" name="OType" value="<%=OType%>">
    <input type="hidden" name="userKind" value="<%=userKind%>">
    <input type="hidden" name="commonWork1" value="<%=commonWork%>">
    <input type="hidden" name="sortWork" value="<%=sortWork%>">
    <input type="hidden" name="departIdOut" value="<%=departIdOut%>">
    <input type="hidden" name="beginTime" value="<%=pr_begintime%>">
    <input type="hidden" name="endTime" value="<%=pr_endtime%>">
    <tr>
      <td width="100%" colspan="9"><table class="content-table" width="100%">
          <tr class="title1">
            <td colspan="4" align="center"><table WIDTH="100%" BORDER="0" CELLSPACING="1" CELLPADDING="1">
                <tr>
                  <td valign="center" align="left"><%=strTitle%></td>
				  <td>
												每页显示
												<select id="contype" onchange="pageNumber(this)">
													<option value="20" <%=(currpageNumber+"").equals("20")?"selected":""%>>20</option>
													<option value="50" <%=(currpageNumber+"").equals("50")?"selected":""%>>50</option>
													<option value="100" <%=(currpageNumber+"").equals("100")?"selected":""%>>100</option>
												</select>
												</td>
                  <td valign="center" align="right" nowrap>
                  	<img src="../../images/split.gif" align="middle" border="0" WIDTH="5" HEIGHT="8">
                  	<img src="../../images/menu_about.gif" border="0" onclick="window.location='ProceedingQuery.jsp'" title="查找项目" style="cursor:hand" align="absmiddle" WIDTH="16" HEIGHT="16">
                  	<img src="../../images/split.gif" align="middle" border="0" WIDTH="5" HEIGHT="8">
                  	<img src="../../images/new.gif" border="0" onclick="window.location='ProceedingInfo.jsp'" title="新建项目" style="cursor:hand" align="absmiddle" WIDTH="16" HEIGHT="16">
                  	<img src="../../images/split.gif" align="middle" border="0" WIDTH="5" HEIGHT="8">
                  	<img src="../../images/dialog/sort.gif" border="0" onclick="setSequence()" title="修改排序" style="cursor:hand" align="absmiddle" WIDTH="15" HEIGHT="15">
                  	<img src="../../images/split.gif" align="middle" border="0" WIDTH="5" HEIGHT="8">
                  	<img src="../../images/goback.gif" border="0" onclick="javascript:history.back();" title="返回" style="cursor:hand" align="absmiddle">
                  	<img src="../../images/split.gif" align="middle" border="0" WIDTH="5" HEIGHT="8">
                  </td>
                </tr>
              </table></td>
          </tr>
        </table></td>
    </tr>
    <tr class="bttn" width="100%">
      <td align="center" width="6%" nowrap>项目ID</td>
      <td align="center" width="12%" nowrap>办理部门</td>
      <td align="center" width="42%" nowrap>项目名称</td>
      <td align="center" width="12%" nowrap>更新日期</td>
      <td align="center" width="8%" nowrap>协办部门</td>
      <td align="center" width="12%" nowrap>操作</td>
      <!--td align="center" width="6%" nowrap><%if(OType.equals("manage"))out.print("编辑");else out.print("查看");%></td-->
      <td align="center" width="8%" nowrap>排序</td>
    </tr>
    <%

Vector vPage = dImpl.splitPage(sqlStr,request,currpageNumber);
if (vPage != null)
{
	for (int i=0;i<vPage.size();i++)
	{
		Hashtable content = (Hashtable)vPage.get(i);
		projectId = content.get("pr_id").toString();
		pr_isdel = content.get("pr_isdel").toString();
		pr_sequence = content.get("pr_sequence").toString();
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
      <td align="center"><%
			  sqlStr = "select dt_name from tb_deptinfo where dt_id="+content.get("dt_id").toString();
			  Hashtable content1 = dImpl.getDataInfo(sqlStr);
				if(content1!=null)
				{
					out.print(content1.get("dt_name").toString());
				}
			 %>
      </td>
      <%projectName = content.get("pr_name").toString();%>
      <td title="<%=projectName%>"><% //输出项目名称
				if(projectName.length()>40)
				{
					projectName = projectName.substring(0,38) + "...";
				}
				out.print(projectName);
			%>
      </td>
      <td align="center"><%=pr_edittime%> </a> </td>
      <td align="center"><span style="cursor:hand" onclick="javascript:window.location='../corrdeptmanage/CorrDeptList.jsp?pr_id=<%=content.get("pr_id").toString()%>'"><img src="/system/images/clip.gif" title="协办部门维护" width="15" height="15" border="0"></span> </td>
      <td align="center">
      <%
			if(OType.equals("manage"))
			{
			%>
        <a href="ProceedingInfo.jsp?OType=Edit&projectId=<%=projectId%>"><img class="hand" border="0" src="../../images/modi.gif" title="项目编辑" WIDTH="16" HEIGHT="16"></a>
        <%
			}
			else
			{
			%>
			 <a href="ProceedingInfo.jsp?OType=Edit&projectId=<%=projectId%>"><img class="hand" border="0" src="../../images/modi.gif" title="项目编辑" WIDTH="16" HEIGHT="16"></a>
        <!--a href="ProceedingInfo.jsp?OType=view&projectId=<%=projectId%>">查看</a-->
        <%
			}
			%>
      	&nbsp;<a href="#" onClick="deleteThis('<%=projectId%>')"> <img class="hand" border="0" src="../../images/delete.gif" title="删除" WIDTH="16" HEIGHT="16"></a> </td>
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
  <tr>
    <td colspan="9"><%=dImpl.getTail(request)%></td>
  </tr>
</table>

<%
dImpl.closeStmt();
dCn.closeCn();
%>
<%@include file="/system/app/skin/bottom.jsp"%>
