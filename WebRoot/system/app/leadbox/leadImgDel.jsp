<%@page contentType="text/html; charset=GBK"%>
<%@include file="../skin/head.jsp"%>
<%@include file="/system/common/parameter.jsp"%>
<%
  //update20080122

CDataCn dCn=null;   //新建数据库连接对象
CDataImpl dImpl=null;  //新建数据接口对象

try {
 dCn = new CDataCn(); 
 dImpl = new CDataImpl(dCn); 

  String path = dImpl.getInitParameter("images_save_path"); //获取路径
  String in_img_path = CTools.dealString(request.getParameter("in_img_path")).trim();
	String in_id = CTools.dealString(request.getParameter("in_id"));
	String OPType=CTools.dealString(request.getParameter("OPType")).trim();
	String File_name = CTools.dealString(request.getParameter("fileName")).trim();
	  boolean successDel=false;
	  File delFile = new File(path+in_img_path+"\\\\"+File_name);
	  
	  dImpl.edit("tb_info","in_id",Integer.parseInt(in_id));
		dImpl.setValue("in_img_path","",CDataImpl.STRING);
		dImpl.update();
	  
	  //out.println(path+in_img_path+"\\\\"+File_name);
	  //if(true)return;
	  /*if(delFile.exists())
	  {
			successDel=delFile.delete(); 
	  }
  if (successDel)
  {*/
  	%>
    <SCRIPT LANGUAGE="JavaScript">
    alert('操作成功！');
    window.location='leadBoxInfo.jsp?OPType=<%=OPType%>&in_id=<%=in_id%>';
    </SCRIPT>
    <%/*
  }else{%>
  <SCRIPT LANGUAGE="JavaScript">
    alert('删除该文件失败！');
    window.location='leadBoxInfo.jsp?OPType=<%=OPType%>&in_id=<%=in_id%>';
    </SCRIPT>
  <%
	}*/
%>
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