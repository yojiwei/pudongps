<%@page contentType="text/html; charset=GBK"%>
<%String strTitle="信息浏览" ;%>
<%@include file="../skin/head.jsp"%>
<%
	
	//得到上一页面传过来的值
	String bigSort = CTools.dealString(request.getParameter("BigSort")).trim();					//大类
	String smallSort = CTools.dealString(request.getParameter("SmallSort")).trim();					//小类
	String gsName = CTools.dealString(request.getParameter("gsName")).trim();					//名称
	String gsAddr = CTools.dealString(request.getParameter("gsAddr")).trim();					//地址
	
	//update20080122

CDataCn dCn=null;   //新建数据库连接对象
CDataImpl dImpl=null;  //新建数据接口对象

try {
 dCn = new CDataCn(); 
 dImpl = new CDataImpl(dCn); 

	String sql="select * from tbgis where 1=1";
	
	if (!bigSort.equals("")) {
		sql += " and gssort ='" + bigSort + "'";
	}
	if (!smallSort.equals("")) {
		sql += " and smallSort = '" + smallSort + "'";
	}
	if (!gsName.equals("")) {
		sql += " and field1 like '%" + gsName + "%'";
	}
	if (!gsAddr.equals("")) {
		sql += " and field2 like '%" + gsAddr + "%'";
	}
	
	sql += " and isdel = 0 order by gsid desc";
		
	Vector vectorPage = dImpl.splitPage(sql,request,12);
	
%>
<%@include file="/system/app/skin/skin4/template/list_top.jsp"%>
<!--    模块名称开始    -->
<%=strTitle%>
<!--    模块名称结束    -->
<%@include file="/system/app/skin/skin4/template/list_function.jsp"%>                                                            
<!--    功能按钮开始    -->
<table WIDTH="100%" BORDER="0" CELLSPACING="1" CELLPADDING="1" >
  <tr> 
      <td align="right" WIDTH="40%" nowrap>
<img src="../../images/split.gif" align="middle" border="0" WIDTH="5" HEIGHT="8">
<img src="../../images/new.gif" border="0" onclick="javascript:location.href='gisAdd.jsp'" title="新增" style="cursor:hand" align="absmiddle">
<img src="../../images/split.gif" align="middle" border="0" WIDTH="5" HEIGHT="8">
<img src="../../images/menu_about.gif" border="0" onclick="javascript:location.href='gisSearch.jsp'" title="查询" style="cursor:hand" align="absmiddle">
          <img src="../../images/split.gif" align="middle" border="0" WIDTH="5" HEIGHT="8">
          <img src="../../images/goback.gif" border="0" onclick="javascript:history.back();" title="返回" style="cursor:hand" align="absmiddle">
          <img src="../..images/split.gif" align="middle" border="0" WIDTH="5" HEIGHT="8">
      </td>
  </tr>
</table>

<!--    功能按钮结束    -->
<%@include file="/system/app/skin/skin4/template/list_listtop.jsp"%>

<form name="formData">
 <table class="main-table" width="100%">
        <tr class="bttn">
            <td width="10%" class="outset-table">大类</td>
            <td width="13%" class="outset-table">小类</td>
            <td width="22%" class="outset-table">名称</td>
            <td width="39%" class="outset-table" nowrap>地址</td>
            <td width="8%" class="outset-table" nowrap>编辑</td>
            <td width="8%" class="outset-table" nowrap>删除</td>
        </tr>
<%
	String gisId = "";
	String gisBigSort =  "";
	String gisSmallSort =  "";
	String gisName =  "";
	String gisAddr =  "";
	if(vectorPage != null) {
	    for(int j=0;j<vectorPage.size();j++) {
	      Hashtable content = (Hashtable)vectorPage.get(j);
	      gisId = content.get("gsid").toString();
		  gisBigSort = content.get("gssort").toString();
		  gisSmallSort = content.get("smallsort").toString();
		  gisName = content.get("field1").toString();
		  gisAddr = content.get("field2").toString();
            if(j % 2 == 0)  out.print("<tr class=\"line-even\">");
            else out.print("<tr class=\"line-odd\">");
%>
            <td><%=gisBigSort%></td>
            <td><%=gisSmallSort%></td>
			<td align=left><a href="gisAdd.jsp?gisId=<%=gisId%>&gsType=1"><%=gisName%></a></td>
			<td align=left><%=gisAddr%></td>
            <td nowrap align=center><a href="gisAdd.jsp?gisId=<%=gisId%>&gsType=1"><img class="hand" border="0" src="../../images/modi.gif" title="编辑" WIDTH="16" HEIGHT="16"></a></td>
            <td nowrap align=center><a href="#" onClick="doDel('<%=gisId%>','<%=gisBigSort%>','<%=gisSmallSort%>')">
    			<img class="hand" border="0" src="../../images/delete.gif" title="删除" WIDTH="16" HEIGHT="16"></a>
    		</td>
        </tr>
<%}%>
</form>
<%/*分页的页脚模块*/
	dImpl.closeStmt();
	dCn.closeCn();
   //out.println("<tr><td colspan=7>" + dImpl.getTail(request) + "</td></tr>"); //输出尾部文件
  }
  else
  {
    out.println("<tr><td colspan=4>没有记录！</td></tr>");
  }
%>
</table>
<!--    列表结束    -->
<%@include file="/system/app/skin/skin4/template/list_bottom.jsp"%> 

<SCRIPT LANGUAGE=javascript>
<!--
	function doDel(obj,bigSort,smallSort) {
		if (confirm("确实要删除此记录吗？")) {
			location.href="gisDel.jsp?gisId="+obj+"&bigSort="+bigSort+"&smallSort="+smallSort;
		}
	}
function setSequence()
{
	//var form = document.formData ;
	var sform = document.formData;
	
	for(i=0;i<sform.length;i++)
	{
		var value = sform[i].value;
		if(value!=""&&isNaN(value)){
			alert("请输入数字！");
			sform[i].focus();
			return false;
		}
	}
	formData.action = "setSequence.jsp";
	formData.submit();
}

function isnumber()
{
	
	
	
	//alert(value);
	
}
	function onChange()
	{
		var sj_id;
		sj_id=formData.sj_id.value;
		formData.action='subjectList.jsp?sj_id='+sj_id;
		formData.submit();
	}
//-->
</SCRIPT>


<%@include file="../skin/bottom.jsp"%>

<%


} catch (Exception ex) {
	System.out.println(new java.util.Date() + "--"
			+ request.getServletPath() + " : " + ex.getMessage());
} finally {
	if(dImpl != null)
	dImpl.closeStmt();
	if(dCn != null)
	dCn.closeCn();
}

%>
