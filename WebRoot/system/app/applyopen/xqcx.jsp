<%@page contentType="text/html; charset=GBK"%>
<%@include file="/system/app/skin/head.jsp"%>
<script language="javascript">
function todo(id,val) {
	var obj;
	obj = document.getElementById(id);
	obj.innerHTML = val;
}
</script>
<%
	String ID = "";
	String ename = "";
	String infoid = "";
	String infotitle = "";
	String applytime = "";
	String genre = "";
	String status = "";

	String sqlStr = "";
	String strTitle = "";
	String getbeginYear = CTools.dealString(
			request.getParameter("beginYear")).trim();
	String getbeginMon = CTools.dealString(
			request.getParameter("beginMon")).trim();

	strTitle = getbeginYear + "年" + getbeginMon + "月部门报送情况";

	CDataCn dCn = null;
	CDataImpl dImpl = null;

	Vector vPage = null;
	Hashtable content = null;
	ResultSet rs = null;
	try {
		dCn = new CDataCn();
		dImpl = new CDataImpl(dCn);
%>
<%@include file="/system/app/skin/skin4/template/list_top.jsp"%>
<!--    模块名称开始    -->
<%=strTitle%>
<!--    模块名称结束    -->
<%@include file="/system/app/skin/skin4/template/list_function.jsp"%>                                                            
<!--    功能按钮开始    -->
<img src="../../images/goback.gif" border="0"
											onclick="javascript:history.back();" title="返回"
											style="cursor:hand" align="absmiddle">
返回
<!--    功能按钮结束    -->
<%@include file="/system/app/skin/skin4/template/list_listtop.jsp"%>                                                                                        
<!--    列表开始    -->
<form name="formData" action="xqcx.jsp" method="post">
<table class="FindAreaTable1" cellspacing="1" rules="cols" border="0" id="ctl00_DataGrid_DataGrid1" style="border-width:0px;">

					<tr class="bttn">
						<%
								sqlStr = "select dt_id,dt_name from tb_deptinfo where dt_infoopendept = 1 order by dt_sequence";
								vPage = dImpl.splitPageOpt(sqlStr, 2000, 1);
								String href = "";
								if (vPage != null) {
									for (int i = 0; i < vPage.size(); i++) {
								content = (Hashtable) vPage.get(i);
								sqlStr = "select id from iostat where did = "
										+ content.get("dt_id").toString()
										+ " and reportyear = " + getbeginYear
										+ " and reportmonth = " + getbeginMon;
								rs = dImpl.executeQuery(sqlStr);
						%>
						<td>
							<%
							if (rs.next()) {
							%>
							<a href="ckList.jsp?id=<%=rs.getString("id")%>&dt_name=<%=content.get("dt_name").toString()%>&reportyear=<%=getbeginYear%>&reportmonth=<%=getbeginMon%>&dt_id=<%=content.get("dt_id").toString()%>"><font
								color="red"><%=content.get("dt_name").toString()%> </font> </a>
							<%
							} else {
							%>
							<%=content.get("dt_name").toString()%>
							<%
							}
							%>
						</td>
						<%
									if ((i + 1) % 4 == 0)
									out.println("<tr class=\"bttn\">");
									}
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