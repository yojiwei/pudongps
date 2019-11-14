<%@page contentType="text/html; charset=GBK"%>
<%@page import="java.sql.*"%>
<%@page import="java.io.*"%>
<%@page import="java.util.*"%>
<%@page import="com.component.database.*"%>
<%@page import="com.util.*"%>
<%@include file="/system/app/skin/import.jsp"%>
<%
//update20080122
CDataCn dCn=null;   //新建数据库连接对象
CDataImpl dImpl=null;  //新建数据接口对象

try {
 dCn = new CDataCn(); 
 dImpl = new CDataImpl(dCn); 
  String rd="";//保存后的跳转页面 0 列表 1 发布页
  String sql="";//查询条件
  String OPType="";//操作方式 Add是添加 Edit是修改
  String cg_id               = "";//主键
  String cg_ep_name          = "";//单位名称
  String cg_ep_kind          = "";//企业类型
  String cg_ep_code = "";//主管部门
  String cg_sequence         = "";//排序
  String cg_grade            = "";//财务会计信用等级
/*得到上一个页面传过来的参数  开始*/
  rd=CTools.dealString(request.getParameter("rd")).trim();
  cg_id=CTools.dealString(request.getParameter("cg_id")).trim();//主键
  OPType=CTools.dealString(CTools.htmlEncode(request.getParameter("OPType"))).trim();//操作方式 Add是添加 Edit是修改
  cg_ep_name=CTools.dealString(CTools.htmlEncode(request.getParameter("cg_ep_name"))).trim();//单位名称
  cg_ep_kind=CTools.dealString(CTools.htmlEncode(request.getParameter("cg_ep_kind"))).trim();//企业类型
  cg_ep_code=CTools.dealString(CTools.htmlEncode(request.getParameter("cg_ep_code"))).trim();//主管部门
  cg_sequence=CTools.dealString(CTools.htmlEncode(request.getParameter("cg_sequence"))).trim();//排序
  cg_grade=CTools.dealString(CTools.htmlEncode(request.getParameter("cg_grade"))).trim();//财务会计信用等级
/*得到上一个页面传过来的参数  结束*/

  try
  {
    String lcg_id = "-1";
    if (OPType.equals("Add"))
      lcg_id = Long.toString(dImpl.addNew("tb_kjcreditgrade","cg_id"));
    else if (OPType.equals("Edit"))
    {
      dImpl.edit("tb_kjcreditgrade","cg_id",Integer.parseInt(cg_id));
      lcg_id=cg_id;
    }
    dImpl.setValue("cg_ep_name",cg_ep_name,CDataImpl.STRING);
    dImpl.setValue("cg_ep_kind",cg_ep_kind,CDataImpl.STRING);
    dImpl.setValue("cg_ep_code",cg_ep_code,CDataImpl.STRING);
    //dImpl.setValue("cg_chargedepartment",cg_chargedepartment,CDataImpl.STRING);
    dImpl.setValue("cg_sequence",cg_sequence,CDataImpl.INT);
    dImpl.setValue("cg_grade",cg_grade,CDataImpl.STRING);
    dImpl.update() ;

if (!lcg_id.equals("-1"))
{
  out.print("<script LANGUAGE='javascript'>");
  out.print("alert('发布成功！');");
  out.print("</script>");
}
//关闭
dImpl.closeStmt();
dCn.closeCn();
if(rd.equals("0"))
{
  response.sendRedirect("creditGradeList.jsp");
}
else if(rd.equals("1"))
{
  response.sendRedirect("creditGradeInfo.jsp?OPType=Add");
}
}
  catch(Exception e)
  {
    out.println("error message:" + e.getMessage() +e.toString() );
  }
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
