<%@ page contentType="text/html; charset=GBK" %>
<%@ page import="com.component.database.*" %>
<%@ page import="com.platform.role.CRoleInfo" %>
<%@ page import="com.util.*" %>
<%@ page import="java.util.*" %>
<%@ page import="com.platform.CManager" %>
<%
  CDataCn dCn = null;
  CRoleInfo rInfo = null;
  try{
  	dCn = new CDataCn();
  	rInfo = new CRoleInfo(dCn);
  //CManager manage = (CManager)session.getAttribute("manager");
  //String loginname = manage.getLoginName();
  String sql = "select * from tb_roleinfo where tr_type<>1 and tr_type<>5 order by tr_id";//　where tr_createby = '"+ loginname +"' order by tr_id";
  Vector vectorPage = rInfo.splitPage(sql,request,10000);
%>
<html>
<head>
<meta http-equiv="pragma" content="no-cache">
<link href="../style.css" rel="stylesheet" type="text/css">
<title></title>

</head>


<body topmargin="30" leftmargin=30  >

        <%
        if(vectorPage!=null)
        {
          for(int j=0;j<vectorPage.size();j++)
          {
            Hashtable content = (Hashtable)vectorPage.get(j);
        %>
                        &nbsp;<img src="/system/images/arrow.gif" border="0" WIDTH="12" HEIGHT="13">
                        <a href=# onclick="javascript:parent.document.all.main.src='role/roleList.jsp?tr_id=<%=content.get("tr_id")%>';" target="_self"><%=CTools.dealNull(content.get("tr_name"),"无")%></a>
                        <br>
        <%
          }
        }
        else
        {
          out.println("没有角色");
        }
        %>
<%
rInfo.closeStmt();
dCn.closeCn();
} catch (Exception ex) {
	System.out.println(new java.util.Date() + "--"
			+ request.getServletPath() + " : " + ex.getMessage());
} finally {
	if(rInfo != null)
	rInfo.closeStmt();
	if(dCn != null)
	dCn.closeCn();
}
%>
