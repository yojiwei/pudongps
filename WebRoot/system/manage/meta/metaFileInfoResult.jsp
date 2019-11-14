<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="../head.jsp" %>
<%
  String list_id;
  String node_title;
  String dv_id;
  String dv_code = "";

  String dv_value;
  CTools tools = null;
  String url = "";
  long id=0;
	String strstatus="";		//交换的方式
%>
<%
  tools = new CTools();
  //update20080122

CDataCn dCn=null;   //新建数据库连接对象
CDataImpl dImpl=null;  //新建数据接口对象

try {
 dCn = new CDataCn(); 
 dImpl = new CDataImpl(dCn); 

  CMetaFileInfo jdo = new CMetaFileInfo(dCn);

  list_id       = request.getParameter("list_id");
  node_title    = tools.iso2gb(request.getParameter("node_title"));

  dv_id         = request.getParameter("dv_id");
  dv_value      = tools.iso2gb(request.getParameter("dv_value"));
  dv_code       = tools.iso2gb(request.getParameter("dv_code"));

    if (dv_id.equals("0")) { //新增
			 strstatus="1";	
       id=jdo.addNew();
    }else{			//修改
			strstatus="2";
      id = java.lang.Long.parseLong(dv_id);
      jdo.edit(id);
    }

    jdo.setValue("dv_value",dv_value,jdo.STRING);
     jdo.setValue("dv_code",dv_code,jdo.STRING);
    jdo.setValue("dd_id",list_id,jdo.LONG );
    jdo.update() ;

		///////////////////////
					dImpl.addNew("tb_exchange","ec_id");
						dImpl.setValue("ec_kind","11",CDataImpl.INT);//关系类型
						dImpl.setValue("pm_id",Long.toString(id),CDataImpl.STRING);
						dImpl.setValue("ec_method",strstatus,CDataImpl.INT);//交换的方式
						dImpl.setValue("ec_status","0",CDataImpl.INT);//未交换
					dImpl.update();
		///////////////////////

    jdo.closeStmt();

    url = "metaList.jsp?list_id="+list_id+"&node_title="+java.net.URLEncoder.encode(node_title);

		dImpl.closeStmt();
    dCn.closeCn();
    response.sendRedirect(url);
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

