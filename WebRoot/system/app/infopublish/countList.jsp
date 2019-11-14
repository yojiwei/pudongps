<%@page contentType="text/html; charset=GBK"%>
<%
String strTitle = "信息报送";
%>

<%@ include file="../skin/head.jsp"%>
<%
//update20080122

CDataCn dCn=null;   //新建数据库连接对象
CDataImpl dImpl=null;  //新建数据接口对象

try {
 dCn = new CDataCn(); 
 dImpl = new CDataImpl(dCn); 



	String begtime = CTools.dealString(request.getParameter("start_date"));
	String endtime = CTools.dealString(request.getParameter("end_date"));

	String sqlWhere  = "";

	if(!begtime.equals(""))
	{
		sqlWhere += " and s.OPERTIME>=to_date('" + begtime + "','YYYY-MM-DD')";
	}

	if(!endtime.equals(""))
	{
		sqlWhere += " and s.OPERTIME<=to_date('" + endtime + "','YYYY-MM-DD')";
	}
        //String sql = "select d.dt_name,sum(ADDNUM)as addCount,sum(PUBNUM)as pubCount,sum(s.score) as score from tb_infostatic s,tb_deptinfo d where (s.ADDNUM=1 or s.PUBNUM=1) "+sqlWhere+" and s.deptid=d.dt_id group by d.dt_name";
        String sql = "select * from (select d.dt_name,sum(ADDNUM)as addCount,sum(PUBNUM)as pubCount,sum(s.score) as score from tb_infostatic s,tb_deptinfo d where (s.ADDNUM=1 or s.PUBNUM=1) "+sqlWhere+" and s.deptid=d.dt_id and dt_id not in (select dt_id from tb_deptinfo connect by prior  dt_id = dt_parent_id start with dt_id = 11883) group by d.dt_name) order by score desc";

        ResultSet rs=dImpl.executeQuery(sql);
%>

<table class="content-table" width="100%">


         <tr class="bttn">
            <td width="100%" class="outset-table" colspan="6"><b>信息报送积分统计（<%=begtime%>至<%=endtime%>）</b></td>

        </tr>
        <tr class="bttn">
        	<td width="6%" class="outset-table"><b>排名</b></td>
            <td width="46%" class="outset-table"><b>部门</b></td>
            <td width="10%" class="outset-table"><b>报送数</b></td>
            <td width="6%" class="outset-table"><b>采用数</b></td>
            <td width="6%" class="outset-table"><b>采用率</b></td>
            <td width="12%" class="outset-table"><b>总分</b></td>
        </tr>
<%
  int j=0;
  while(rs.next())
  {
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
                <td align="center"><%=pubCount%></td>
                <%
                	String rate = "0";

                	if(addCount!=0){
                		float rateFloat = (float)pubCount/(float)addCount *100;
                		rate = String.valueOf(rateFloat); //采用率
                	}
                %>
                 <td align="center"><%=rate%>%</td>
                <td align=center><%=score%></td>

				</td>
            </tr>
<%
    }
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