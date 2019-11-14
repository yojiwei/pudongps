<%@ page contentType="text/html; charset=GBK" %>
<title>请选择处理类型</title>
<%@include file="../../skin/pophead.jsp"%>
<script language="javascript">
function checkForm()
{
        if(formData.conntype.value=="")
        {
                alert("请选择处理类型！");
                formData.conntype.focus();
                return false;
        }
        formData.action = "CorrResult.jsp";
        formData.submit();
}
</script>
<%
CMySelf self = (CMySelf)session.getAttribute("mySelf");
String selfdtid = String.valueOf(self.getDtId());
String sender_id = String.valueOf(self.getMyID());

//update20080122

CDataCn dCn=null;   //新建数据库连接对象
CDataImpl dImpl=null;  //新建数据接口对象

try {
 dCn = new CDataCn(); 
 dImpl = new CDataImpl(dCn); 

String sqlStr = "";
String cw_id = "";
String cp_id = "";
String cp_name = "";
String cp_upid = "";
String OPType = "";
Vector vPage = null;

cw_id = CTools.dealString(request.getParameter("cw_id")).trim();
cp_id = CTools.dealString(request.getParameter("cp_id")).trim();
OPType = CTools.dealString(request.getParameter("OPType")).trim();
%>
<p>&nbsp;</P>
<table class="main-table" width="260" align="center">
<form name="formData" method="post">
<tr class="title1" width="100%" align＝"center">
     <td width="50%" align="left" class="outset-table"><font size=1>处理类型:</font></td>
     <td>
      <select class="select-a" name="conntype">
            <%
               sqlStr = "select cp_id,cp_name from tb_connproc where cp_upid='" + cp_id + "' and dt_id="+selfdtid+" order by cp_name";
               vPage = dImpl.splitPage(sqlStr,request,20);
               if (vPage!=null)
               {
                 for(int i=0;i<vPage.size();i++)
                 {
                   Hashtable content = (Hashtable)vPage.get(i);
                   cp_id = content.get("cp_id").toString();
                   cp_name = content.get("cp_name").toString();
             %>
             <option value="<%=cp_id%>"><%=cp_name%></option>
             <%
                }
                }
             %>
      </select>
     </td>
</tr>
<tr>
<td>
&nbsp
</td>
</tr>
<tr>
<td>
&nbsp
</td>
</tr>
<tr class="title1" width="100%" align="center">
        <td width="100%" class="outset-table" colspan="3">
                <input type="button" name="btnSubmit" class="bttn" value="确定" onclick="checkForm()">&nbsp;
                <input type="button" class="bttn" value="关闭" name="btnCloseWin" onclick="window.close();">&nbsp;
        </td>
</tr>
<input type="hidden" name="cw_id" value="<%=cw_id%>">
<input type="hidden" name="OPType" value="<%=OPType%>">
</form>
</table>
<%
dImpl.closeStmt();
dCn.closeCn();
%>
<%@include file="../../skin/popbottom.jsp"%>
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