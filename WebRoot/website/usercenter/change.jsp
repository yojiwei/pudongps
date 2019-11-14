<link rel="stylesheet" href="/website/include/main.css" type="text/css">
<%@ page contentType="text/html; charset=GBK"%>
<%@include file="/website/include/import.jsp"%>

<%
  String cw_id = "";
 String CW_NAME = "";
  String UK_ID = "";
  String strSql_cw1 = "";
  Vector vectorPage1 = null;
  String strSql_cw2 = "";
  Vector vectorPage2 = null;
  String strSql_cw3 = "";
 Vector vectorPage3 = null;

//Update 20061231
CDataCn dCn = null;
CDataImpl dImpl = null;
try{
dCn = new CDataCn();
dImpl = new CDataImpl(dCn); 

 if(session.getAttribute("user")!=null)
{
  {
    User userLeft = (User)session.getAttribute("user");
    UK_ID=userLeft.getUserKind();
  }
}
else
{
     UK_ID="o1";
  }
 String strSql_cw="select cw_id,cw_name from tb_commonwork where uk_id = '" + UK_ID.trim() + "' order by cw_sequence";
 Vector vectorPage = dImpl.splitPage(strSql_cw,10000,1);
 strSql_cw1="select cw_id,cw_name from tb_commonwork where uk_id = 'o2' order by cw_sequence";
 vectorPage1 = dImpl.splitPage(strSql_cw1,10000,1);
 strSql_cw2="select cw_id,cw_name from tb_commonwork where uk_id = 'o3' order by cw_sequence";
 vectorPage2 = dImpl.splitPage(strSql_cw2,10000,1);
 strSql_cw3="select cw_id,cw_name from tb_commonwork where uk_id = 'o11' order by cw_sequence";
 vectorPage3 = dImpl.splitPage(strSql_cw3,10000,1);%>
<script language="JavaScript">

function MM_jumpMenu(targ,selObj,restore){
  eval(targ+".location='"+selObj.options[selObj.selectedIndex].value+"'");
  if (restore) selObj.selectedIndex=0;
}

</script>
<body topmargin="0" leftmargin="0" style="color: #38529C; font-size: 10px" bgcolor="#F6F1EE">

<table border="0" cellpadding="0" cellspacing="0" width="100%" bgcolor="#F6F1EE">
  <tr>
    <td width="100%" colspan="2" height="20">
    <table border="0" cellpadding="0" cellspacing="0" width="100%">
      <tr>
        <td width="5"></td>
        <td height="20"><a href="List.jsp?uk_id=o1" target="_top"><font color="#38529C">市民办事</font></a></td>
      </tr>
    </table>
    </td>
  </tr>
      <tr>
    <td width="100%" colspan="2" height="20">
    <table border="0" cellpadding="0" cellspacing="0" width="100%">
      <tr>
        <td width="5">　</td>
        <td height="20"><a href="List.jsp?uk_id=o2" target="_top"><font color="#38529C">企业办事</font></a></td>
      </tr>
    </table>
    </td>
  </tr>
  <tr>
    <td width="100%" colspan="2" height="20">
    <table border="0" cellpadding="0" cellspacing="0" width="100%">
      <tr>
        <td width="5"></td>
        <td height="20"><a href="List.jsp?uk_id=o3" target="_top"><font color="#38529C">投资创业</font></a></td>
      </tr>
    </table>
    </td>
  </tr>
  <tr>
    <td width="100%" colspan="2" height="20">
    <table border="0" cellpadding="0" cellspacing="0" width="100%">
      <tr>
        <td width="5"></td>
        <td height="20"><a href="List.jsp?uk_id=o11" target="_top"><font color="red">特别关爱</font></a></td>
      </tr>
    </table>
    </td>
  </tr>
  </table>
<%
}
catch(Exception e){
//e.printStackTrace();
out.print(e.toString());
}
finally{
dImpl.closeStmt();
dCn.closeCn(); 
}
%>