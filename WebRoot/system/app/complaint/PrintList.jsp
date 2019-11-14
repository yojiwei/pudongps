<%@include file="../skin/import.jsp"%>
<%@page contentType="text/html; charset=GBK"%>
<title>信访打印列表
</title>
<%
  String cw_id = request.getParameter("cw_id").toString();

//update20080122

CDataCn dCn=null;   //新建数据库连接对象
CDataImpl dImpl=null;  //新建数据接口对象

try {
 dCn = new CDataCn(); 
 dImpl = new CDataImpl(dCn); 


  String cw_status = "";//时间
  String applytime = "";//时间
  String applyname = "";//人姓名
  String applydept = "";//单位
  String strTel = "";//电话
  String strEmail = "";//邮件
  String strSubject = "";//主题
  String strContent = "";//内容
  String strFeedback = "";//回复
  String dt_id = "";//转办单位
  String strSql = "";
  String receivername = "";
  String co_corropioion = "";
  String de_requesttime = "";
  String sqlStr = "select cw_status,cw_applyingname,cw_applyingdept,cw_email,cw_telcode,cw_subject,cw_content,cw_feedback,to_char(cw_applytime,'yyyy-mm-dd hh24:mi:ss') cw_applytime from tb_connwork where cw_id='"+cw_id+"'";
  
  Hashtable content = dImpl.getDataInfo(sqlStr);
  cw_status = content.get("cw_status").toString();
  applyname = content.get("cw_applyingname").toString();
  applydept = content.get("cw_applyingdept").toString();
  strEmail = content.get("cw_email").toString();
  strTel = content.get("cw_telcode").toString();
  applytime = content.get("cw_applytime").toString();
  strSubject = content.get("cw_subject").toString();
  strContent = content.get("cw_content").toString();
  strFeedback = content.get("cw_feedback").toString();
  
  String sqlcorr = "select co_id from tb_correspond where cw_id='" + cw_id + "'";//判断是否转办
  Vector vectorPage = dImpl.splitPage(sqlcorr,request,20);
  if(vectorPage!=null)
  {
    int status = Integer.parseInt(cw_status);
    switch(status)
   {
    case 1:
     dt_id = "e.de_senddeptid";
     break;
    case 2:
     dt_id = "e.de_senddeptid";
     break;
    case 3:
     dt_id = "e.de_senddeptid";
     break;
    case 8:
     dt_id = "e.de_receiverdeptid";
     break;
    default:
  }
   strSql = "select d.co_corropioion,";
   strSql += "e.de_senddeptid,e.de_receiverdeptid,e.de_requesttime,f.dt_name ";
   strSql += "from tb_connwork c,tb_correspond d,tb_documentexchange e,tb_deptinfo f where c.cw_id=d.cw_id and d.co_id=e.de_primaryid and " + dt_id + "=f.dt_id and c.cw_id='" + cw_id + "'";
   Hashtable content_corr = dImpl.getDataInfo(strSql);
   receivername = content_corr.get("dt_name").toString();
   co_corropioion = content_corr.get("co_corropioion").toString();
   de_requesttime = content_corr.get("de_requesttime").toString();
  }
  
  
%>
<table width="98%" align=center>
  <tr>
    <td>&nbsp;
    </td>
  </tr>
  <tr>
    <td align=center><h2>“上海浦东”门户网站——网上信访来信</h2>
    </td>
  </tr>
  <tr>
  <tr>
    <td align=right><h4>浦东新区信访办公室&nbsp;&nbsp;&nbsp;&nbsp;</h4>
    </td>
  </tr>
  <tr>
    <td>
     <table border=2 cellPadding=0 cellSpacing=0 style="BORDER-COLLAPSE: collapse" width="100%">
       <tr>
         <td height=30 width="20%" align=center>来信时间</td>
         <td height=30 align=left><%=applytime%></td>
       </tr>
       <tr>
         <td height=30 align=center>来 信 人</td>
         <td height=30 align=left><%=applyname%></td>
       </tr>
       <tr>
         <td align=center>地址（单位）
         </td>
         <td height=30 align=left><%=applydept%>
         </td>
       </tr>
       <tr>
         <td align=center>联系电话
         </td>
         <td height=30 align=left><%=strTel%>
         </td>
       </tr>
       <tr>
         <td align=center>电子邮件
         </td>
         <td height=30 align=left><%=strEmail%>
         </td>
       </tr>
       <tr>
         <td align=center>主&nbsp;&nbsp;&nbsp;&nbsp;题
         </td>
         <td height=30 align=left><%=strSubject%>
         </td>
       </tr>
       <tr>
         <td width="145" align=center colspan=2>正&nbsp;&nbsp;&nbsp;&nbsp;文
         </td>
       </tr>
       <tr>
         <td colspan=2>
          <table width="96%" align=center>
            <tr>
             <td height=30 align=left>&nbsp;&nbsp;&nbsp;&nbsp;<%=strContent%>
             </td>
            </tr>
          </table>
         </td>
       </tr>
       <%
         if(vectorPage!=null)
         {
       %>
       <tr>
         <td colspan=2>&nbsp;
         </td>
       </tr>
       <tr>
         <td align=center>转办部门
         </td>
         <td height=30 align=left><%=receivername%>
         </td>
       </tr>
       <tr>
         <td align=center>转办时限
         </td>
         <td height=30 align=left><%=de_requesttime%> 天
         </td>
       </tr>
       <tr>
         <td width="145" align=center colspan=2>转办部门意见
         </td>
       </tr>
       <tr>
         <td colspan=2>
          <table width="96%" align=center>
            <tr>
             <td height=30 align=left>&nbsp;&nbsp;&nbsp;&nbsp;<%=co_corropioion%>
             </td>
            </tr>
          </table>
         </td>
       </tr>
       <%
         }
         if(!strFeedback.equals(""))
         {
       %>
       <tr>
         <td width="145" align=center colspan=2>信访回复
         </td>
       </tr>
       <tr>
         <td colspan=2>
          <table width="96%" align=center>
            <tr>
             <td height=30 align=left>&nbsp;&nbsp;&nbsp;&nbsp;<%=strFeedback%>
             </td>
            </tr>
          </table>
         </td>
       </tr>
       <%
         }
       %>
     </table>
    </td>
  </tr>
  
  <tr id="prid" style="display:">
   <td align=center>
  
      <INPUT TYPE="BUTTON" VALUE="打印" onclick="fmprint()">&nbsp;
      <INPUT TYPE="BUTTON" VALUE="关闭" onclick="window.close()">

   </td>
  </tr>
 
</table>
<script language="javascript">
  function fmprint()
  {
  prid.style.display="none";
  window.print();
  window.close();
  }
</script>
<%  
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
%>