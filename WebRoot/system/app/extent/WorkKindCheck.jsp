<%@page contentType="text/html; charset=GBK"%>
<%@include file="/system/app/skin/head.jsp"%>
<%
  String wk_id = CTools.dealString(request.getParameter("wk_id"));//事项id
  String wk_id_old = "";//还原字段ID
//update20080122

CDataCn dCn=null;   //新建数据库连接对象
CDataImpl dImpl=null;  //新建数据接口对象

try {
 dCn = new CDataCn(); 
 dImpl = new CDataImpl(dCn); 
  String sql = "select wk_id from tb_workkind where wk_isdefault='1'";
  Vector vPage = dImpl.splitPage(sql,100,1);
  dCn.beginTrans();

  if (vPage != null)
  {
	  for(int j=0;j<vPage.size();j++)
	  {
		Hashtable content = (Hashtable)vPage.get(j);
		wk_id_old = content.get("wk_id").toString();
		dImpl.edit("tb_workkind","wk_id",wk_id_old);
		dImpl.setValue("wk_isdefault","0",CDataImpl.STRING);//名称
		dImpl.update();
	  }
  }

	dImpl.edit("tb_workkind","wk_id",wk_id);
    dImpl.setValue("wk_isdefault","1",CDataImpl.STRING);//名称
	dImpl.update();

    if(dCn.getLastErrString().equals(""))
      dCn.commitTrans();
    else
      dCn.rollbackTrans();
    ///////////////////////
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
    response.sendRedirect("WorkKindList.jsp");
%>