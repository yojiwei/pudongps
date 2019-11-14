<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="../head.jsp" %>
<%@ page import="com.platform.CManager" %>
<%
  String list_id;
  String node_title;
  String ui_id,ui_name,ui_uid,ui_password,ui_sex,ui_active_flag,ui_ip,dt_id;
  String tr_createBy;

  CTools tools = null;
  String msg = "";
  String url = "";
  long id;
%>
<%
  tools = new CTools();
  CDataCn dCn=null;
  CUserInfo jdo = null;
  try{
  	dCn=new CDataCn();
  	jdo = new CUserInfo(dCn);
	
  CMySelf self = (CMySelf)session.getAttribute("mySelf");
  tr_createBy =CTools.dealNull(String.valueOf(self.getMyUid()));

  list_id       = request.getParameter("list_id");
  node_title    = tools.dealString(request.getParameter("node_title"));
 // System.out.print(list_id);
  ui_id         = tools.dealNumber(request.getParameter("ui_id"));
  ui_name       = tools.dealString(request.getParameter("ui_name"));
  ui_uid        = tools.dealString(request.getParameter("ui_uid"));
  ui_password   = tools.dealString(request.getParameter("ui_password"));
  //加密开始
  ui_password = new sun.misc.BASE64Encoder().encode(ui_password.getBytes());
  ui_password = SecurityTest.encode(ui_password);
  //加密结束
  ui_sex        = tools.dealString(request.getParameter("ui_sex"));
  dt_id         = tools.dealString(request.getParameter("dt_id"));
  ui_active_flag= tools.dealNumber(request.getParameter("ui_active_flag"));
  ui_ip         = tools.dealString(request.getParameter("ui_ip"));

  ui_sex = "男".equals(ui_sex) ? "1" : "0";

  //if (ui_active_flag == null){
  //  ui_active_flag = "0";
  //}



    if(ui_id.equals("0"))
	{  //新增
       //检查是否有相同的UID
			 CDataImpl dImpl = new CDataImpl(dCn);
			 String sqlStr = "select ui_id from tb_userinfo where ui_uid='"+ui_uid+"'";
			 Hashtable content = dImpl.getDataInfo(sqlStr);
			 if (content!=null)
			 {
					%>
					<script language="javascript">
						alert("相同的注册名已经存在！");
						window.history.go(-1);
					</script>
					<%
					msg = "未能成功新增！";
					out.close();
			 }
			 else
			 {
			 		jdo.setTableName("tb_userinfo");
			 		jdo.setPrimaryFieldName("UI_ID");
					jdo.addNew();
			 }
			 dImpl.closeStmt();
    }
	else
	{
			 id = java.lang.Long.parseLong(ui_id);
             //检查是否有相同的UID
			 CDataImpl dImpl = new CDataImpl(dCn);
			 String sqlStr = "select ui_id from tb_userinfo where UI_UID='"+ui_uid+"' and ui_id<>"+id;
			 Hashtable content = dImpl.getDataInfo(sqlStr);
			 if (content!=null)
			 {
					%>
					<script language="javascript">
						alert("相同的用户名已经存在！");
						window.history.go(-1);
					</script>
					<%
					msg = "未能修改新增！";
					out.close();
			 }
			 else
			{
       			jdo.edit(id);
			}
    }


  //}

    if (msg.equals("")){
      //out.print(ui_active_flag);
      jdo.setValue("UI_UID",ui_uid,jdo.STRING );
      jdo.setValue("UI_NAME",ui_name,jdo.STRING);
      jdo.setValue("UI_PASSWORD",ui_password,jdo.STRING );
      jdo.setValue("UI_SEX",ui_sex,jdo.STRING );
      jdo.setValue("UI_IP",ui_ip,jdo.STRING );
      jdo.setValue("DT_ID",dt_id,jdo.LONG );
      jdo.setValue("UI_ACTIVE_FLAG",ui_active_flag,jdo.LONG  );
      jdo.update() ;
      jdo.closeStmt();
      
      /*if (ui_id.equals("0"))
      {
      	
      }*/
      
      url = "userList.jsp?list_id="+list_id+"&node_title="+java.net.URLEncoder.encode(node_title);
    }else{
      url = "/system/Common/goback/goback.jsp?msg="+java.net.URLEncoder.encode(msg);
    }

/*生成私有角色*/
    if (ui_id.equals("0")&&msg.equals(""))
    {
      CDataImpl p = new CDataImpl(dCn);
      String strsql="select * from tb_rowcount where rc_tablename='tb_userinfo'";
      Hashtable contentP=p.getDataInfo(strsql);
      String strUid = contentP.get("rc_maxid").toString();
      p.closeStmt();
      CDataImpl dImpl=new CDataImpl(dCn);
      dImpl.setTableName("tb_roleinfo");
      dImpl.setPrimaryFieldName("tr_id");
      dImpl.addNew();
      dImpl.setValue("tr_name",ui_name,dImpl.STRING);
      dImpl.setValue("tr_type","1",dImpl.STRING);
      dImpl.setValue("tr_userids",","+strUid+",",dImpl.STRING);
      dImpl.setValue("tr_createby",tr_createBy,jdo.STRING);
      dImpl.update();
      dImpl.closeStmt();
    }
    dCn.closeCn();
    response.sendRedirect(url);
%>
<%


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