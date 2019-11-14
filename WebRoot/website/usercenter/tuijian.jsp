<%@ page contentType="text/html; charset=GBK"%>
<%@include file="/website/include/head.jsp"%>
<%@page import="com.website.*"%>
<%//Update 20061231
CDataCn dCn = null;
try{
dCn = new CDataCn();

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

 CDataImpl dImpl_userleft = new CDataImpl(dCn); //新建数据接口对象
 CDataImpl listDImpl = new CDataImpl(dCn);
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
 Vector vectorPage = dImpl_userleft.splitPage(strSql_cw,10000,1);


CDataImpl workdImpl = new CDataImpl(dCn);

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
          <td width="543" height="20" colspan="2" valign="top" background="../images/pint3.gif"><a name="tbtj"></a><img border="0" src="../images/tebtj.gif" width="80" height="20"></td>
        </tr>
        <tr>
          <td width="543" height="30" colspan="2">
          <table border="0" cellpadding="0" cellspacing="0" width="100%">
            <tr><td height="10"></td></tr><tr>
              <td width="23">　</td>
              <td width="520"><table border="0" cellpadding="0" cellspacing="0" width="100%">
                                  <tr><td>
<%
                       String sqlStr_uk = "select sg_id,sg_name,sg_url from tb_suggest where us_kind='"+UK_ID+"' order by sg_sequence desc";
                           Vector vPage1 = dImpl_userleft.splitPage(sqlStr_uk,1000,1);
                    if (vPage1!=null)
                {
                        for (int i=0;i<(4<vPage1.size()? 4:vPage1.size());i++)
                        {
                                Hashtable content = (Hashtable)vPage1.get(i);
                                String sg_id = content.get("sg_id").toString();
                                String sg_name = content.get("sg_name").toString();
                                String sg_url = content.get("sg_url").toString();
                                %>
                                <li><a href="<%=sg_url%>" target="_blank"><%=sg_name%></a></li>
                                <%
                                if (i%2==1)
                                {
                                        out.print("<br>");
                                }
                        }
                        /*if (vPage.size()>4)
                        {
                                out.print("<tr><td align='right' colspan='2'>更多...</td></tr>");
                        } */
                }
                else
                {
                        out.print("&nbsp;没有记录");
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
      <td width="7">　</td>
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
listDImpl.closeStmt();
workdImpl.closeStmt();
dImpl_userleft.closeStmt();
%>
<%@include file="/website/include/bottom.jsp"%>
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