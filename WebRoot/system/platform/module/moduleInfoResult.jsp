<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="../head.jsp" %>
<%
  String list_id;
  String node_title;
  String ft_id;

  String ft_name;
  String ft_parent_id;
  String ft_url;
  String ft_task_url;
  String ft_fast_help;
  String ft_code;
  String ft_isdefault;
  String ft_img;
  CTools tools = null;
  String msg = "";
  String url = "";
  long id;
%>
<%
  tools = new CTools();
  CDataCn dCn=null;
  CModuleInfo jdo = null;
  try{
  	dCn=new CDataCn();
	jdo = new CModuleInfo(dCn);
	
	
  list_id       = request.getParameter("list_id");
  node_title    = tools.iso2gb(request.getParameter("node_title"));

  ft_id         = request.getParameter("ft_id");
  ft_name       = tools.iso2gb(request.getParameter("ft_name"));
  ft_parent_id  = request.getParameter("ft_parent_id");
  ft_url        = tools.iso2gb(request.getParameter("ft_url"));
  ft_task_url   = tools.iso2gb(request.getParameter("ft_task_url"));
  ft_fast_help  = tools.iso2gb(request.getParameter("ft_fast_help"));
  ft_code       = tools.iso2gb(request.getParameter("ft_code"));
  ft_img        = tools.iso2gb(request.getParameter("ft_img"));


    if (ft_id.equals("0")) { //新增
       //检查是否有相同的UID
      if (jdo.hasSameModule(ft_code,-1)){
         msg = "未能成功新增！\\n注：模块代码["+ft_code+"]已经存在！";
      }else{
        jdo.addNew();
      }
    }else{
       //检查是否有相同的UID
      id = java.lang.Long.parseLong(ft_id);
      if (jdo.hasSameModule(ft_code,id)){
         msg = "未能成功修改！\\n注：模块代码["+ft_code+"]已经存在！";
      }else{
        jdo.edit(id);
      }
    }

    if (msg.equals("")){
      jdo.setValue("ft_name",ft_name,jdo.STRING);
      jdo.setValue("ft_parent_id",ft_parent_id,jdo.LONG );
      jdo.setValue("ft_url",ft_url,jdo.STRING );
      jdo.setValue("ft_task_url",ft_task_url,jdo.STRING );
      jdo.setValue("ft_fast_help",ft_fast_help,jdo.STRING );
      jdo.setValue("ft_code",ft_code,jdo.STRING );
      jdo.setValue("ft_img",ft_img,jdo.STRING);
      jdo.update() ;
      jdo.closeStmt();
      url = "moduleList.jsp?list_id="+list_id+"&node_title="+java.net.URLEncoder.encode(node_title);
    }else{
      url = "/system/common/goback/goback.jsp?msg="+java.net.URLEncoder.encode(msg);
    }

    dCn.closeCn();
    response.sendRedirect(url);
    } catch (Exception ex) {
	System.out.println(new java.util.Date() + "--"
			+ request.getServletPath() + " : " + ex.getMessage());
} finally {
	if(jdo != null)
	jdo.closeStmt();
	if(dCn != null)
	dCn.closeCn();
}
%>
