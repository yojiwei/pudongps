<%@page contentType="text/html; charset=GBK"%>
<%@include file="../skin/import.jsp"%>
<%
//update20080122

CDataCn dCn=null;   //新建数据库连接对象
CDataImpl dImpl=null;  //新建数据接口对象

try {
 dCn = new CDataCn(); 
 dImpl = new CDataImpl(dCn); 


  String co_id = "";
  String de_id = "";
  String cw_id = request.getParameter("cw_id");

  String sqlcorr = "select co_id from tb_correspond where cw_id='" + cw_id + "'";//判断是否转办
  Vector vectorPage = dImpl.splitPage(sqlcorr,request,20);

  if(vectorPage!=null)
  {
   String sql_corr = "select d.co_id,e.de_id from tb_connwork c,tb_correspond d,tb_documentexchange e where c.cw_id=d.cw_id and d.co_id=e.de_primaryid and c.cw_id='" + cw_id + "'";
   Hashtable content = dImpl.getDataInfo(sql_corr);
   co_id = content.get("co_id").toString();
   de_id = content.get("de_id").toString();
  }

  dCn.beginTrans();

  dImpl.delete("tb_correspond","co_id",co_id);
  dImpl.delete("tb_documentexchange","de_id",de_id);
  dImpl.delete("tb_connwork","cw_id",cw_id);

  if(dCn.getLastErrString().equals(""))
  {
    dCn.commitTrans();
  }
  else
  {
    dCn.rollbackTrans();
  }
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
  response.sendRedirect("AppealList.jsp");
%>
