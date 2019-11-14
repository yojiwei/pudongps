<%@page contentType="text/html; charset=GBK"%>
<%@include file="../skin/head.jsp"%>
<%
  CMySelf self = (CMySelf)session.getAttribute("mySelf");
  String selfdtid = String.valueOf(self.getDtId());
  String sender_id = String.valueOf(self.getMyID());

  String actiontype,fs_id,fs_name,fs_code,list_id,fs_parentid;

  actiontype = CTools.dealString(request.getParameter("actiontype")).trim();//存储类型
  fs_id = CTools.dealString(request.getParameter("fs_id"));//栏目id
  fs_name = CTools.dealString(request.getParameter("fs_name"));//栏目名称
  fs_code = CTools.dealString(request.getParameter("fs_code"));
  list_id = CTools.dealString(request.getParameter("list_id"));//上级栏目代码
  fs_parentid = CTools.dealString(request.getParameter("fs_parentid"));//上级栏目代码

//update20080122

CDataCn dCn=null;   //新建数据库连接对象
CDataImpl dImpl=null;  //新建数据接口对象

try {
 dCn = new CDataCn(); 
 dImpl = new CDataImpl(dCn); 
  dCn.beginTrans();

  if(actiontype.equals("add"))			//新增栏目
  {
     fs_id = dImpl.addNew("tb_frontsubject","fs_id",CDataImpl.PRIMARY_KEY_IS_VARCHAR);
	 dImpl.setValue("fs_parentid",list_id,CDataImpl.STRING);//上级栏目代码
  }
  else  //修改栏目
  {
    dImpl.edit("tb_frontsubject","fs_id",fs_id);
	dImpl.setValue("fs_parentid",fs_parentid,CDataImpl.STRING);//上级栏目代码
  }
    dImpl.setValue("fs_name",fs_name,CDataImpl.STRING);//栏目名称
    dImpl.setValue("fs_code",fs_code,CDataImpl.STRING);//栏目代码
	
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
    response.sendRedirect("frontSubjectList.jsp?list_id="+list_id);
%>

