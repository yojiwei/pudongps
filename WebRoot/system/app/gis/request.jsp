<%@page contentType="text/html; charset=GBK"%>
<%@page import="com.util.*"%>
<%@page import="com.component.database.*"%>
<%@page import="java.sql.ResultSet"%>
<%
	//String bigSortID = CTools.dealUploadString(myUpload.getRequest().getParameter("bigSortID"));				//大类ID
	//String smallSort = CTools.dealUploadString(myUpload.getRequest().getParameter("SmallSort"));				//小类
	
	String bigSortID = CTools.dealString(request.getParameter("bigSortID"));				//大类ID
	String smallSort = CTools.dealString(request.getParameter("SmallSort"));				//小类
	String subType = "";					//小类ID
	
	String smallSQL = "select dd_code from tb_datatdictionary where dd_name = '" + smallSort + "' " +
						"and dd_parentid=(select dd_id from tb_datatdictionary where dd_code='"+ bigSortID +"')";
	
	//update20080122

CDataCn dCn=null;   //新建数据库连接对象
CDataImpl dImpl=null;  //新建数据接口对象

try {
 dCn = new CDataCn(); 
 dImpl = new CDataImpl(dCn); 
	
	//取得小类代码
	ResultSet rs = null;
	rs = dImpl.executeQuery(smallSQL);
	if (rs.next()) subType = CTools.dealNull(rs.getString("dd_code"));
	rs.close();
	
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
  	//response.sendRedirect("http://211.144.95.131/bianmin_luodi/XF/index.jsp?bianmin="+subType+"&sendxyurl=http://www.pudong.gov.cn/system/app/gis/refresh.jsp");
  	response.sendRedirect("http://211.144.95.131/bianmin_luodi/XF/index.jsp?bianmin="+subType+"&sendxyurl=http://www.pudong.gov.cn/system/app/gis/refresh.jsp");
  	//http://211.144.95.131:8400/pdbmfw/pdbm/index-2a_x.html?name=浦东文化&url=/pdbmfw/pdbm/mingrenguju/puwh_x.html
%>