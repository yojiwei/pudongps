<%@ page contentType="text/html; charset=GBK"%>
<%@include file="/website/include/head.jsp"%>
<%@page import="com.website.*"%>
<%
 String keyword="";
 String selectid="";
 String selecttype="";
 String pr_name="";
 String pr_id="";
 String US_ID = "";
 String US_UID = "";
 String cw_id = "";
 String CW_NAME = "";
 String UK_ID = "";
 String uk_id = "";
 String strSql_cw1 = "";
 Vector vectorPage1 = null;
 String strSql_cw2 = "";
 Vector vectorPage2 = null;
 String strSql_cw3 = "";
 Vector vectorPage3 = null;
 String list_uk_id = CTools.dealString(request.getParameter("uk_id")).trim();
 String pType = "";

 pType = CTools.dealString(request.getParameter("pType")).trim();


//Update 20061231
CDataCn dCn = null;
CDataImpl dImpl = null;
try{
dCn = new CDataCn();
dImpl = new CDataImpl(dCn); 

 if(session.getAttribute("user")!=null)
 {
   if(list_uk_id.equals(""))
   {
     User userLeft = (User)session.getAttribute("user");
     UK_ID=userLeft.getUserKind();
   }
   else
      UK_ID=list_uk_id;
 }
 else
 {
   if(list_uk_id.equals(""))
     UK_ID="o1";
   else
     UK_ID=list_uk_id;

 }

 String strSql_cw="select cw_id,cw_name from tb_commonwork where uk_id = '" + UK_ID.trim() + "' order by cw_sequence";
 Vector vectorPage = dImpl.splitPage(strSql_cw,10000,1);


%>
<table width="746" border="0" cellspacing="0" cellpadding="0" align="center">
<tr><td height="5"></td></tr></table>
<table width="746" border="0" cellspacing="0" cellpadding="0" align="center">
  <tr><td align="center">
  <table border="0" cellspacing="0" width="600" cellpadding="0" align="center">
   <tr>
      <td width="600" valign="top" align="center">
      <table border="1" cellpadding="0" cellspacing="0" style="border-collapse: collapse" width="100%" bordercolor="#B49F66" height="100%" align="center">

        <tr>
          <td width="543" height="4" colspan="2" bgcolor="#B49F66"></td>
        </tr>
        <tr>
          <td width="543" height="20" colspan="2" valign="top" background="../images/pint3.gif"><a name="tbtj"></a><img border="0" src="../images/changjwt.gif" width="120" height="20"></td>
        </tr>
        <tr>
          <td width="543" height="30" colspan="2">
          <table border="0" cellpadding="0" cellspacing="0" width="100%">
            <tr><td height="10"></td></tr><tr>
              <td width="23">¡¡</td>
              <td width="520"><table border="0" cellpadding="0" cellspacing="0" width="100%">
                                  <tr><td>
<%
                      String sqlStr_uk1 = "select qu_id,qu_title from tb_question where us_kind='"+UK_ID+"' order by qu_sequence desc";
                      Vector vPage2 = dImpl.splitPage(sqlStr_uk1,1000,1);
                      if (vPage2!=null)
                      {
                              for(int i=0;i<(2<vPage2.size()?2:vPage2.size());i++)
                              {
                                      Hashtable content = (Hashtable)vPage2.get(i);
                                      String qu_id = content.get("qu_id").toString();
                                      String qu_title = content.get("qu_title").toString();
                                      %>
                                      <tr>
                                            <td><li> <a href="javascript:openWin(2,'<%=qu_id%>')"><%=qu_title%></a></li></td>
                                  </tr>
                                      <%
                              }
                      }
                      else
                      {
                              out.print("<tr><td>&nbsp;Ã»ÓÐ¼ÇÂ¼</td></tr>");
                      }
                      %>
</td></tr><tr><td height="10"></td></tr></table></td>
            </tr>
          </table>
          </td>
        </tr>
        <tr>
          <td width="543" height="2" colspan="2" bgcolor="#B49F66"></td>
        </tr>

        <tr>
          <td width="543" height="2" colspan="2" bgcolor="#B49F66"></td>
        </tr>
        </table>
      </td>
      <td width="7">¡¡</td>
    </tr>
    <tr>
      <td height="5" colspan="3"></td>
    </tr>
  </table>
  </td></tr>
</table>
<table width="746" border="0" cellspacing="0" cellpadding="0" align="center">
<tr><td height="5"></td></tr></table>
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
<%@include file="/website/include/bottom.jsp"%>
