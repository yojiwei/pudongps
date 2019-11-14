<%@page contentType="text/html; charset=GBK"%>
<%
String strTitle = "信息报送";
%>

<%@include file="/system/app/skin/import.jsp"%>
<%@include file="/system/app/islogin.jsp"%>
<script language="javascript" src="/system/include/common.js"></script>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title>上海浦东门户网站后台管理系统</title>
<style type="text/css">
<!--
@import url("/system/app/skin/skin3/images/main.css");
-->
</style>
<script LANGUAGE="javascript" src="/system/app/infopublish/common/common.js"></script>
<link href="/system/app/skin/skin3/images/style.css" rel="stylesheet" type="text/css">
</head>
<body leftmargin="0" topmargin="0">
<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td height="8"></td>
  </tr>
<%
  String strMenu1 = CTools.dealString(request.getParameter("Menu"));
  String strModule1 = CTools.dealString(request.getParameter("Module"));
  if(!strMenu1.equals("")) session.setAttribute("_strMenu1",strMenu1);
  if(!strModule1.equals("")) session.setAttribute("_strModule1",strModule1);
  strMenu1=CTools.dealNull(session.getAttribute("_strMenu1"));
  strModule1=CTools.dealNull(session.getAttribute("_strModule1"));
%>
  <tr>
    <td height="20" valign="top"><table width="100%" border="0" cellpadding="0" cellspacing="0">
      <tr>
        <td width="42"><img src="/system/app/skin/skin3/images/index_righttb_01.gif" width="42" height="20" /></td>
        <td background="/system/app/skin/skin3/images/index_righttb_bg.gif" class="f12w"><a href="#" class="f12w"><%=strMenu1%></a>=&gt;<%=strModule1%></td>
        <td width="115"><img src="/system/app/skin/skin3/images/index_righttb_03.gif" width="115" height="20" /></td>
        <td width="20" background="/system/app/skin/skin3/images/index_righttb_bg.gif"><a href="#" title="刷新页面" onclick="javascript:location.reload();"><img src="/system/app/skin/skin3/images/index_righttb_04.gif" width="20" height="20" border="0" /></a></td>
        <td width="40"><img src="/system/app/skin/skin3/images/index_righttb_02.gif" width="40" height="20" /></td>
      </tr>
    </table></td>
  </tr>
  <tr>
    <td height="410" align="center" valign="top"><table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td width="11" background="/system/app/skin/skin3/images/index_righttd_bgL.gif"></td>
        <td valign="top">
<%
	//update20080122

CDataCn dCn=null;   //新建数据库连接对象
CDataImpl dImpl=null;  //新建数据接口对象

try {
 dCn = new CDataCn(); 
 dImpl = new CDataImpl(dCn); 

	String begtime = CTools.dealString(request.getParameter("start_date"));
	String endtime = CTools.dealString(request.getParameter("end_date"));
	String sValue = CTools.dealString(request.getParameter("sValue"));
	String sType = CTools.dealString(request.getParameter("percent"));
	String tt_dir = CTools.dealString(request.getParameter("tt_dir"));
	
	String sqlWhere  = "";
	String sqlWhere1 = "";

	if(!"".equals(begtime)) {
		sqlWhere += " and to_date(to_char(addtime,'YYYY-MM-DD hh:mi:ss'),'YYYY-MM-DD hh:mi:ss')>=to_date('" + begtime + " 00:00:01','YYYY-MM-DD hh24:mi:ss')";
	}
	if(!"".equals(endtime)) {
		sqlWhere += " and to_date(to_char(addtime,'YYYY-MM-DD hh:mi:ss'),'YYYY-MM-DD hh:mi:ss')<=to_date('" + endtime + " 23:59:59','YYYY-MM-DD hh24:mi:ss')";
	}
	sqlWhere += tt_dir.equals("0") ? " and type = 0" : " and type = 1"; 
	
	if(!"".equals(sValue)) {	
		Hashtable content = null;
		Vector vPage = null;
		String sqlStr = "select tt_id,tt_dtids from tb_totdept where tt_id = " + sValue;
		vPage = dImpl.splitPage(sqlStr,request,1000);
		if(vPage!=null) {
			for(int i = 0 ; i < vPage.size() ; i++) {
				content = (Hashtable)vPage.get(i);
				sqlWhere1 += content.get("tt_dtids").toString();
			}
			if (!"".equals(sqlWhere1)) {
				if (sqlWhere1.substring(sqlWhere1.length() - 1).equals(","))
					sqlWhere1 = sqlWhere1.substring(0,sqlWhere1.length() - 1);
			}
		}
	}
	String sql = "";
	
	if (!"".equals(sqlWhere1)) 
		sql = "select d.dt_id,d.dt_name,sum(s.addnum)as addCount,sum(s.pubnum)as pubCount,nvl(sum(s.score),'0') as score from" + 
 		  	  "(select dt_id,dt_name from tb_deptinfo where dt_id in (" + sqlWhere1 + "))  d left join (select addnum,pubnum,score,deptid from tb_infostatic where 1 = 1 and infoid in (select p.ct_id from tb_contentpublish p,(select sj_id from tb_subject connect by prior sj_id=sj_parentid start with sj_dir = 'pudongNews') s where p.sj_id = s.sj_id or p.sj_id = '2228') " + sqlWhere + ") s on d.dt_id = s.deptid where 1 = 1 group by d.dt_id,d.dt_name order by score desc,dt_id";
 		  	  
		/*sql = "select d.dt_id,d.dt_name,sum(s.addnum)as addCount,sum(s.pubnum)as pubCount,nvl(sum(s.score),'0') as score from" + 
 		  	  "(select dt_id,dt_name from tb_deptinfo where dt_id in (" + sqlWhere1 + "))  d left join" + 
 		  	  "(select addnum,pubnum,score,deptid from tb_infostatic where 1 = 1 and infoid in " + 
 		  	  "(select cp.ct_id from (select p.ct_id from tb_contentpublish p,(select sj_id from tb_subject connect by prior sj_id=sj_parentid start with sj_dir = 'pudongNews') s where p.sj_id = s.sj_id or p.sj_id = '2228') cp," + 
 		  	  "(select a.infoid from tb_infostatic a,tb_infostatic b where (a.pubnum = 1 and b.addnum=1 and a.infoid = b.infoid) or a.pubnum = 0) st where cp.ct_id = st.infoid)" + 
 		  	  sqlWhere + ") s on d.dt_id = s.deptid where 1 = 1 group by d.dt_id,d.dt_name " + 
 		  	  "order by score desc,dt_id";*/
		/*
        sql = "select * from (select d.dt_name,sum(ADDNUM)as addCount,sum(PUBNUM)as pubCount,sum(s.score) " + 
					 "as score from tb_infostatic s,tb_deptinfo d where (s.ADDNUM=1 or s.PUBNUM=1) " + sqlWhere + 
					 " and s.deptid=d.dt_id and dt_id in (" + sqlWhere1 + ") group by d.dt_name) order by score desc";
		*/
	else
		sql = "select * from tb_infostatic where type = -1";
		//System.out.println("countList.jsp_sql = " + sql);
        ResultSet rs=dImpl.executeQuery(sql);
        //out.println(sql);
        //if (true) return;
%>

<table class="content-table" width="100%">


        <tr class="bttn">
          <td width="100%" class="outset-table" colspan="6"><b>信息报送积分统计（<%=begtime%>至<%=endtime%>）</b></td>
        </tr>
        <tr class="bttn">
        	<td width="6%" class="outset-table"><b>排名</b></td>
            <td width="46%" class="outset-table"><b>部门</b></td>
            <td width="10%" class="outset-table"><b>报送数</b></td>
            <%
            	if (sType.equals("1")) {
            %>
            <td width="6%" class="outset-table"><b>采用数</b></td>
            <td width="6%" class="outset-table"><b>采用率</b></td>
            <td width="12%" class="outset-table"><b>总分</b></td>
            <%
            	}
            %>
        </tr>
<%
  int j=0;
  if (rs.next()) {
  	  rs.beforeFirst();
	  while(rs.next()) {
	      String dt_name = rs.getString("dt_name"); //单位
	      int addCount = rs.getInt("addCount"); //报送数量
	      int pubCount = rs.getInt("pubCount"); //发布数量
	      int score = rs.getInt("score"); //分数
	
	      j++;
	      if(j % 2 == 0)  out.print("<tr class=\"line-even\">");
	      else out.print("<tr class=\"line-odd\">");
%>

                <td align="center"><%=j%></td>
                <td align=left><%=dt_name%></td>
                <td align="center"><%=addCount%></td>
	            <%
	            	if (sType.equals("1")) {
	            %>
                <td align="center"><%=pubCount%></td>
                <%
                	int rate = 0;

                	if(addCount!=0){
                		float rateFloat = (float)pubCount/(float)addCount *100;
	
						//System.out.println("countList.jsp_rateFloat = " + (int)rateFloat);
						
                		rate = (int)rateFloat; //采用率
                	}
                %>
                 <td align="center"><%=rate%>%</td>
                <td align=center><%=score%></td>
				<%}%>
				</td>
            </tr>
<%
    	}
%>
        <tr class="bttn">
          <td width="100%" class="outset-table" colspan="6" align="left"><font color="#FF0000">* 上传一条信息加1分，被采用1条信息加4分，两类分数的累计为总积分。</font></td>
        </tr>
<%
    }
    else
    	out.println("<tr><td colspan=8 align=center>此栏目下暂时没有统计信息！</td></tr>");
%>
</form>
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
<%@ include file="../skin/bottom.jsp"%>
<br>