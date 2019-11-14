<%@page contentType="text/html; charset=GBK"%>
<%@include file="/system/app/skin/head.jsp"%>
<%
String pa_id="";
String pa_ask="";
String pa_answer="";
String ac_type = "";
String ac_typename = "";

CDataCn dCn = null;
CDataImpl dImpl = null;
try{
dCn = new CDataCn();
dImpl = new CDataImpl(dCn);
//
ac_type = CTools.dealString(request.getParameter("ac_type"));

//update by dongliang 20090106
String curpage= CTools.dealString(request.getParameter("curpage"));
//
String sql_list = " select pa_id,pa_ask,pa_answer,ac_type from tb_proceeding_ask where table_name='tb_askanswer'";
if(!"".equals(ac_type)){
	sql_list+=" and ac_type='"+ac_type+"'";
}
sql_list += " order by ac_date desc";
//out.println(sql_list);

%>
<%@include file="/system/app/skin/skin4/template/list_top.jsp"%>
<!--    模块名称开始    -->
问答列表
<!--    模块名称结束    -->
<%@include file="/system/app/skin/skin4/template/list_function.jsp"%>                                                            
<!--    功能按钮开始    -->
<script language="javascript">
function TypeChange(){
	var ac_type = document.all.ac_type_.value;
	//alert(ac_type);
	if(ac_type!="0"){
		window.location.href="AnswerList.jsp?ac_type="+ac_type;
	}else{
		window.location.href="AnswerList.jsp";
	}
}
</script>
<select name="ac_type_" onchange="TypeChange()">
<option value="0">请选择</option>
<option value="a1" <%=ac_type.equals("a1")?"selected":""%>>拍卖</option>
<option value="a2" <%=ac_type.equals("a2")?"selected":""%>>网络</option>
<option value="a3" <%=ac_type.equals("a3")?"selected":""%>>市场</option>
<option value="a4" <%=ac_type.equals("a4")?"selected":""%>>广告</option>
</select>
选择类型
<img src="/system/images/new.gif" border="0" onClick="window.location='AnswerInfo.jsp?OPType=Add'" title="新增问答" style="cursor:hand" align="middle" WIDTH="16" HEIGHT="16">
新增问答
<!--    功能按钮结束    -->
<%@include file="/system/app/skin/skin4/template/list_listtop.jsp"%>                                                                                        
<!--    列表开始    -->
<table class="FindAreaTable1" cellspacing="1" rules="cols" border="0" id="ctl00_DataGrid_DataGrid1" style="border-width:0px;">
	<form name="formData">
	</tr>
	<tr class="bttn">
	<td width="10%" class="outset-table" align="center">所属类型</td>
	<td width="35%" class="outset-table" align="center">问题</td>
	<td width="45%" class="outset-table" align="center">答案</td>
	<td width="5%" class="outset-table" align="center">操作</td>
	</tr>
	<%
	Vector vectorList = dImpl.splitPage(sql_list,request,20);
	Hashtable content = null;
	if(vectorList!=null)
	{
		for(int i=0;i<vectorList.size();i++)
		{
			content = (Hashtable)vectorList.get(i);
			pa_id = CTools.dealNull(content.get("pa_id"));
			ac_type = CTools.dealNull(content.get("ac_type"));
			pa_ask = CTools.dealNull(content.get("pa_ask"));
			pa_answer = CTools.dealNull(content.get("pa_answer"));
			if(ac_type.equals("a1")){
				ac_typename = "拍卖";
			}else if(ac_type.equals("a2")){
				ac_typename = "网络";
			}else if(ac_type.equals("a3")){
				ac_typename = "市场";
			}else if(ac_type.equals("a4")){
				ac_typename = "广告";
			}
			if(i % 2 == 0)  out.print("<tr class=\"line-even\">");
			else out.print("<tr class=\"line-odd\">");
	%>
	<td align="center"><%=ac_typename%></td>
	<td align="left"><%=pa_ask%></td>
	<td align="left"><%=pa_answer%></td>
<td align="center">
<a href="AnswerInfo.jsp?OPType=Edit&pa_id=<%=pa_id%>"><img class="hand" border="0" src="../../images/modi.gif" title="编辑该问答" WIDTH="16" HEIGHT="16"></a>&nbsp;
<a href="AnswerDel.jsp?OPType=Del&pa_id=<%=pa_id%>"><img class="hand" border="0" src="../../images/delete.gif" title="删除该问答" WIDTH="16" HEIGHT="16" onClick="return window.confirm('确认要删除该记录么?');"></a>
</td>
</tr>
</form>
<%
    }
  }
  else
  {
    out.println("<tr><td colspan=20>没有记录！</td></tr>");
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