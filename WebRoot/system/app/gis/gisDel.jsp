<%@page contentType="text/html; charset=GBK"%>
<%@page import="java.sql.*"%>
<%@page import="java.io.*"%>
<%@page import="java.util.*"%>
<%@page import="com.component.database.*"%>
<%@page import="com.util.*"%>
<%
	String gisId = CTools.dealString (request.getParameter("gisId"));
	String bigSort = CTools.dealString (request.getParameter("bigSort"));
	String smallSort = CTools.dealString (request.getParameter("smallSort"));
	String bigSortID = "";
	String subType = "";
	
	//update20080122

CDataCn dCn=null;   //新建数据库连接对象
CDataImpl dImpl=null;  //新建数据接口对象

try {
 dCn = new CDataCn(); 
 dImpl = new CDataImpl(dCn); 
	ResultSet rs = null;
	
	//取得大类id
	String bigSQL = "select dd_code from TB_DATATDICTIONARY where dd_parentid = " +
					  "(select dd_id from TB_DATATDICTIONARY where dd_name = 'GIS分类') and  dd_name = '"+bigSort +"'";
	rs = dImpl.executeQuery(bigSQL);
	if (rs.next()) bigSortID = CTools.dealNull(rs.getString("dd_code"));

	
	//查询小类代码查询语句
	String smallSQL = "select dd_code from tb_datatdictionary where dd_name = '" + smallSort + "' " +
						"and dd_parentid=(select dd_id from tb_datatdictionary where dd_code='"+ bigSortID +"')";
	
	//取point_other代码
	if (!"".equals(bigSortID) && bigSortID.substring(0,5).equals("point")) {
		bigSortID = bigSortID.substring(0,11);
	}	
	
	//取得小类代码
	rs = dImpl.executeQuery(smallSQL);
	if (rs.next()) subType = CTools.dealNull(rs.getString("dd_code"));
	rs.close();	

	  try {
	    //dImpl.delete("tbgis","gsid",Long.parseLong(gisId));
	    
	    dImpl.edit("tbgis","gsid",Long.parseLong(gisId));
		dImpl.setValue("isdel","1",CDataImpl.INT);
		dImpl.update();
		
	    dImpl.closeStmt();
	    dCn.closeCn();
	    /*
	    out.print("<script>");
	    out.print("alert('删除成功！');");
	    out.print("window.location='gisList.jsp';");
	    out.print("</script>");
	   response.sendRedirect("subjectList.jsp");
	   */
	  }
	  catch(Exception e) {
	    out.println("error message:" + e.getMessage());
	  }
	dImpl.closeStmt();
	dCn.closeCn();
%>
<form name="formData" method="post" action="http://211.144.95.131/bianmin_luodi/luoDi.do">
	<div style="display: none">
	<textarea name="table"><%=bigSortID%></textarea>
	<textarea name="subType"><%=subType%></textarea>
	<textarea name="sendID"><%=gisId%></textarea>
	<textarea name="method">delete</textarea>
	</div>
</form>
<script>
	formData.submit();
	alert('删除成功！');
	window.location='gisList.jsp';
</script>
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
