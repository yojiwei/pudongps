<%@page contentType="text/html; charset=GBK"%>
<%@include file="../skin/head.jsp"%>
<%
  String actiontype,fi_id,fi_title,fi_url,fi_sequence,fi_content,fi_img,list_id,fi_type;
  
  actiontype = CTools.dealString(request.getParameter("actiontype")).trim();//存储类型
  fi_id = CTools.dealString(request.getParameter("fi_id"));//栏目id
  fi_title = CTools.dealString(request.getParameter("fi_title"));//栏目名称
  fi_url = CTools.dealString(request.getParameter("fi_url"));//url连接
  fi_sequence = CTools.dealString(request.getParameter("fi_sequence"));//排序
  fi_content = CTools.dealString(request.getParameter("fi_content"));//信息内容
  fi_img = CTools.dealString(request.getParameter("fi_img"));//信息图片
  list_id = CTools.dealString(request.getParameter("list_id"));//上级栏目代码
  fi_type = CTools.dealString(request.getParameter("fi_type"));//上级栏目代码
  
  String userFileIds = CTools.dealString(request.getParameter("userFileIds")).trim();	//维护用户id
  
  //update20080122

CDataCn dCn=null;   //新建数据库连接对象
CDataImpl dImpl=null;  //新建数据接口对象

try {
 dCn = new CDataCn(); 
 dImpl = new CDataImpl(dCn); 
  dCn.beginTrans();

  if(actiontype.equals("add"))			//新增栏目
  {
     fi_id = dImpl.addNew("tb_frontinfo","fi_id",CDataImpl.PRIMARY_KEY_IS_VARCHAR);
  }
  else  //修改栏目
  {
    dImpl.edit("tb_frontinfo","fi_id",fi_id);
  }
    dImpl.setValue("fi_title",fi_title,CDataImpl.STRING);//栏目名称
    dImpl.setValue("fi_url",fi_url,CDataImpl.STRING);//栏目代码
	dImpl.setValue("fi_sequence",fi_sequence,CDataImpl.STRING);//上级栏目代码
	dImpl.setValue("fi_content",fi_content,CDataImpl.STRING);//上级栏目代码
	dImpl.setValue("fi_img",fi_img,CDataImpl.STRING);//上级栏目代码
	dImpl.setValue("fs_id",list_id,CDataImpl.STRING);//上级栏目代码
	dImpl.setValue("fi_type",fi_type,CDataImpl.STRING);//上级栏目代码
	dImpl.setValue("ur_id",userFileIds,CDataImpl.STRING);//上级栏目代码
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
    response.sendRedirect("frontStaticList.jsp?list_id="+list_id);
%>

