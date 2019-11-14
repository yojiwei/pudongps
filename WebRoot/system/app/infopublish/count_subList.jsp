<%@page contentType="text/html; charset=GBK"%>
<%
String strTitle = "栏目统计";
%>
<%@ include file="../skin/head.jsp"%>
<%
/*得到当前登陆的用户id  开始*/

	String uiid="";
	CMySelf myProject = (CMySelf)session.getAttribute("mySelf");
	String begtime = CTools.dealString(request.getParameter("start_date"));
	String endtime = CTools.dealString(request.getParameter("end_date"));
	String strWhere = "";
	if (!"".equals(begtime)) 
		strWhere += " and cs_date >= to_date('" + begtime + " 00:00:00','yyyy-MM-dd hh24:mi:ss')";
	if (!"".equals(endtime)) 
		strWhere += " and cs_date <= to_date('" + endtime + " 23:59:59','yyyy-MM-dd hh24:mi:ss')";

	if(myProject!=null && myProject.isLogin()) {
		uiid = Long.toString(myProject.getMyID());
	}
	else {
		uiid= "2";
	}
%>

<table class="main-table" width="100%">
<form name="formData" method="post" action="count_subList.jsp"  target="">
</form>
  <tr class="title1" align=center>
    <td colspan="2">
		<table cellspacing="0" cellpadding="0" border="0" width="100%">
			<tr>
				<td align="left">&nbsp;&nbsp;栏目统计</td>
				<td align="right"><img src="../../images/goback.gif" border="0" onclick="javascript:history.back();" title="返回" style="cursor:hand" align="absmiddle">&nbsp;&nbsp;</td>
			<tr>
		</table>
	</td>
  </tr>
  <tr class="line-even">
    <td width="30%" align="right">统计栏目</td>
    <td width="70%" align="center">点击数</td>
  </tr>
  <%
	String sj_id = CTools.dealString(request.getParameter("sj_id"));
  	String tb_name = "";
  	int tb_count = 0;
	String sj_dir = "";
	String hrefUrl = "";
	sj_id = "".equals(sj_id) ? "293" : sj_id;					//如果sj_id为空，从计算上海浦东中文版栏目开始计算
	String sql = "select * from (select sj_id,sj_dir,sj_name from tb_subject where sj_parentid = " + sj_id + " order by sj_sequence) where sj_dir is not null";
	String count_sql = "";
	String f_sj_dir = "";
	
	String sqlStr = "";
	Vector sunVt = null;
	Hashtable sunHt = null;
	String sun_dir = "";
	String chg_sj_dir = "";
	int num = 999;

	//update20080122

CDataCn dCn=null;   //新建数据库连接对象
CDataImpl dImpl=null;  //新建数据接口对象

try {
 dCn = new CDataCn(); 
 dImpl = new CDataImpl(dCn); 
	Vector vPage = dImpl.splitPage(sql,request,15);
	Hashtable content = null;
	int kk = 0;
	if (vPage != null) {
		for (int i = 0;i < vPage.size();i++) {
			content = (Hashtable)vPage.get(i);

			sj_id = content.get("sj_id").toString();
			f_sj_dir = content.get("sj_dir").toString();
			sqlStr = "select * from (select sj_dir from tb_subject connect by prior sj_id = sj_parentid start with sj_id = " + sj_id + " order by sj_sequence) where sj_dir is not null";

			ResultSet rs = dImpl.executeQuery(sqlStr);
			while (rs.next()) {
				sj_dir +=  "'" + rs.getString("sj_dir") + "',";
			}
			
			String sjDir[] = sj_dir.split(",");
			if (sjDir.length > num) {
				for (int k = 0;k < sjDir.length;k++) {
					sun_dir += sjDir[k] + ",";
					if (k % num == 0) {
						chg_sj_dir += " or sj_dir in (" + sun_dir.substring(0,sun_dir.length() - 1) + ")";
						sun_dir = "";
					}
				}
				if (sjDir.length % num == 0)
					chg_sj_dir += " or sj_dir in (" + sun_dir.substring(0,sun_dir.length() - 1) + ")";
			}
			else {
				chg_sj_dir = " or sj_dir in (" + sj_dir.substring(0,sj_dir.length() - 1) + ")";
			}
			
			count_sql = "select cs_count from tb_countsubject where " + chg_sj_dir.substring(3) + " and cs_type = 'count' " + strWhere;
			rs = dImpl.executeQuery(count_sql);
			while (rs.next()) {
				tb_count += Integer.parseInt(rs.getString("cs_count"));
			}
			rs.close();

			tb_name = content.get("sj_name").toString(); 
			f_sj_dir = "'" + f_sj_dir + "',";
			hrefUrl = f_sj_dir.equals(sj_dir) ? tb_name : "<a href=\"count_subList.jsp?sj_id=" + sj_id + "&start_date=" + begtime + "&end_date=" + endtime + "\"> " + tb_name + "</a>";
			if (tb_count != 0) {
				kk++;
  %>
			  <tr class=<%=kk%2==2 ? "line-odd" : "line-even"%>>
			    <td align="right"><%=hrefUrl%></td>
			    <td align="center"><%=tb_count%></td>
			  </tr>
  <%
  			}
			sun_dir = "";
			sj_dir = "";
			chg_sj_dir = "";
			tb_count = 0;
  		}
  %>
  <tr>
    <td colspan="2">
  		<table width="100%" cellspacing="0" cellpadding="0" border="0">
  			<tr>
  				<td>
  					<%=dImpl.getTail(request)%>
  				</td>
  			</tr>
  		</table>
  	</td>
  </tr>
  <%
  	}
  	else {
  %>
  <tr class="line-even">
    <td colspan="3">暂时没有栏目统计记录</td>
  </tr>
  <%
  	}
  %>
</table>
<%
	dImpl.closeStmt();
	dCn.closeCn();
	
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
<%@ include file="/system/app/skin/bottom.jsp"%>


