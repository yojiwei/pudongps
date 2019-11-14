<%@page contentType="text/html; charset=GBK"%>
<%@include file="/system/app/skin/head.jsp"%>
<%@include file="/system/app/skin/skin4/template/info_top.jsp"%>
<!--    模块名称开始    -->
互动事项查询
<!--    模块名称结束    -->
<%@include file="/system/app/skin/skin4/template/info_funtion.jsp"%>
<!--    功能按钮开始    -->

<!--    功能按钮结束    -->
<%@include file="/system/app/skin/skin4/template/info_main.jsp"%>
<!--    表单提交开始    -->
<script LANGUAGE="javascript" src="../infopublish/common/common.js"></script>
<script language="javascript">
function visible()
{
	 var j=0;
	 for (var i=0;i<document.formData.elements.length;i++)
	{
		 if((document.formData.elements[i].checked)&&document.formData.elements[i].value!=3)
			j=1;
	}
	if(j==1)
	{
		document.formData.cw_isovertime.style.visibility="visible";
	}
	else
	{
		document.formData.cw_isovertime.style.visibility="hidden";
	}
}
</script>
<table align="center" width="100%" CELLPADDING="1" cellspacing="1">
<form name="formData" method="post" action="AppealList.jsp" onsubmit="merger();">
	<tr class="title1" width="100%">
		<td colspan="2" class="outset-table">互动事项查询
		</td>
	</tr>
	<tr class="line-even">
		<td width="15%" align="right">申请人</td>
		<td align="left"><input name="applyPeople" class="text-line" maxlength="20"></td>
	<tr class="line-even" width="100%">
                <td width="15%" align="right">受理单位：</td>
                <td align="left"><select class="select-a" name="dt_id">
                        <option value="">请选择受理单位</option>
                        <%
                        CDataCn dCn = null; //新建数据库连接对象
                        CDataImpl dImpl = null; //新建数据接口对象
                         CDataImpl dImp2 = null; //新建数据接口对象
                         try{
                         	dCn = new CDataCn(); 
                         	dImpl = new CDataImpl(dCn);
                         	dImp2 = new CDataImpl(dCn); 
                         	
                        String dt_name = "";
                        String dt_id = "";
                        Vector vPage = null;
                        String sqlStr = "select * from tb_deptinfo order by dt_id";
                        vPage = dImpl.splitPage(sqlStr,request,100);
                        if (vPage!=null)
                        {
                                for(int i=0;i<vPage.size();i++)
                                {
                                        Hashtable content = (Hashtable)vPage.get(i);
                                        dt_id = content.get("dt_id").toString();
                                        dt_name = content.get("dt_name").toString();
                                        %>
                                        <option value="<%=dt_id%>"><%=dt_name%></option>
                                        <%
                                }
                        }
                        %>
                        </select>
                </td>
    </tr>
	<tr class="line-even" width="100%">
                <td width="15%" align="right">事项类型：</td>
                <td align="left"><select class="select-a" name="cp_id">
                        <option value="">请选择事项类型</option>
						<%
                       
						String cp_id = "";
						String cp_name = "";
						Vector vPage2 = null;
						String sqlStr2 = "select * from tb_connproc where cp_upid is null or cp_upid='' ";
						vPage2 = dImp2.splitPage(sqlStr2,request,100);
						if (vPage2!=null)
						{
							for (int j=0;j<vPage2.size();j++)
							{
								Hashtable content2=(Hashtable)vPage2.get(j);
								cp_id = content2.get("cp_id").toString();
								cp_name = content2.get("cp_name").toString();
								%>
								<option value="<%=cp_id%>"><%=cp_name%></option>
								<%
							}
						}
                        %>
                        </select>
                </td>
    </tr>
	</tr>
	<tr class="line-odd">
		<td width="15%" align="right">申请时间</td>
		<td align="left"><input name="beginTime" style="cursor:hand" class="text-line" readonly size="10" onclick="showCal()">&nbsp;至&nbsp;<input style="cursor:hand" name="endTime" class="text-line" readonly size="10" onclick="showCal()"></td>
	</tr>
	<tr class="line-even">
		<td width="15%" align="right">事项名称</td>
		<td align="left"><input name="pr_name" size="40" class="text-line" maxlength="40"></td>
	</tr>
	<tr class="line-odd">
		<td width="15%" align="right">事项状态</td>
		<td align="left">
			<input type="checkbox" name="status" class="checkbox1" value="1" checked onclick="visible()">待处理
			<input type="checkbox" name="status" class="checkbox1" value="2" checked onclick="visible()">进行中
			<input type="checkbox" name="status" class="checkbox1" value="8" checked onclick="visible()">协调中
			<input type="checkbox" name="status" class="checkbox1" value="3" checked>已完成
			<select name="cw_isovertime" class="select-a" style="visibility:visible">
				<option value="">请选择状态</option>
				<option value="0">未超时</option>
				<option value="1">已超时</option>
			</select>
		</td>
	</tr>
	<tr class="title1" width="100%">
		<td colspan="2" class="outset-table">
			<input type="submit" class="bttn" value="搜索">&nbsp;
			<input type="reset" class="bttn" value="重写">&nbsp;
		</td>
	</tr>
<input type="hidden" name="OPType" value="search">
<input type="hidden" name="status1" value="">
</form>
<script language="javascript">
function merger()
{
	var obj1 = formData.status;
	var obj2 = formData.status1;
	var str = "";
	for (var i=0;i<obj1.length;i++)
	{
		if (obj1[i].checked)
		{
			str += obj1[i].value;
			str += ",";
		}
	}
	if (str.length>0)
	{
		str = str.substring(0,str.length-1);
	}
	obj2.value = str;
}
</script>
</table>
<!--    表单提交结束    -->
<%@include file="/system/app/skin/skin4/template/info_bottom.jsp"%> 
<%
dImpl.closeStmt();
dImp2.closeStmt();
dCn.closeCn();

} catch (Exception ex) {
	System.out.println(new java.util.Date() + "--"
			+ request.getServletPath() + " : " + ex.getMessage());
} finally {
	if(dImpl != null)
	dImpl.closeStmt();
	if(dImp2 != null)
	dImp2.closeStmt();
	if(dCn != null)
	dCn.closeCn();
}
%>
<%@include file="/system/app/skin/bottom.jsp"%>
                                     
