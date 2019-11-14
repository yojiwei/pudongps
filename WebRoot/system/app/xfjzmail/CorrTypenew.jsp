<%@ page contentType="text/html; charset=GBK" %>
<%@include file="/system/app/skin/pophead.jsp"%>
<script language="javascript">
function checkForm()
{
        if(formData.conntype.value=="")
        {
                alert("请选择信访处理类型！");
                formData.conntype.focus();
                return false;
        }
        formData.action = "moredeal.jsp";
        formData.submit();
}
</script>
<%
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
String cp_id_conn = "";
String cp_name_conn = "";

cw_id = CTools.dealString(request.getParameter("cw_id")).trim();
cp_id = CTools.dealString(request.getParameter("cp_id")).trim();
OPType = CTools.dealString(request.getParameter("OPType")).trim();
%>
<p>&nbsp;</P>
<table class="main-table" width="260" align="center">
<form name="formData" method="post">
<tr class="title1" width="100%" align＝"center">
     <td width="30%" align="left" class="outset-a"><font size=2>转办单位:</font></td>
     <td>
      <select class="select-a" name="conntype" onchange="setValue11()">
           <!-- <%
               sqlStr = "select cp_id,cp_name from tb_connproc where cp_upid='" + cp_id + "' order by cp_name";
               out.println(sqlStr);
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
             %>--> <option value="">请选择转办单位</option>
			   <option value="o5">信访信箱</option>
                                     <%
                                      String Sql_class = "select cp_id,cp_name from tb_connproc where cp_upid='o7' order by dt_name";
                                      Vector vPage1 = dImpl.splitPage(Sql_class,request,100);
                                      if (vPage1!=null)
                                      {
                                       for(int i=0;i<vPage1.size();i++)
                                      {
                                       Hashtable content1 = (Hashtable)vPage1.get(i);
                                       cp_id_conn = content1.get("cp_id").toString();
                                       cp_name_conn = content1.get("cp_name").toString();
                                      %>
                                      <option value="<%=cp_id_conn%>" <%=cp_id.equals(cp_id_conn) ? "selected" : ""%>><%=cp_name_conn%></option>
									  <%
                                       }
                                       }
                                      %>
									   <%
						 // sqlStr = "select ti_name, ti_id from tb_title where ti_upperid =(select ti_id from tb_title where ti_code = 'pudong_jz')order by ti_sequence";
  
 sqlStr="select c.cp_id, c.cp_name, c.dt_name from tb_connproc c, tb_deptinfo d where c.dt_id = d.dt_id and c.cp_upid = 'o10000' or c.cp_id = 'o10000' and d.dt_id = '11883' order by cp_id";
                       vPage = dImpl.splitPage(sqlStr,request,250);
						if(vPage!=null)
						{
							for(int j=0;j<vPage.size();j++)
							{
								Hashtable content = (Hashtable)vPage.get(j);
						  %>
                            <option value="<%=content.get("cp_id").toString()%>"><%=content.get("cp_name").toString()%></option>
							<%}}%>
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
                <input type="button" class="bttn" value="关闭" name="btnCloseWin" onclick="window.history.go(-1);">&nbsp;
        </td>
</tr>
<input type="hidden" name="cw_id" value="<%=cw_id%>">
<input type="hidden" name="OPType" value="<%=OPType%>">
<input type="hidden" name="strFeedback" value="">
</form>
</table>
<script>
function setValue11()
  {		
	var form = document.formData;		
	for(i=1;i<form.conntype.length;i++)
	{		
		if(form.conntype[i].selected)
		{
			form.strFeedback.value="已将该情况交由“" + form.conntype[i].text　+ "”办理";
		}
	}
	if(form.conntype[0].selected)
	{
		form.strFeedback.value="";
	}
	if(form.conntype.value=="")		
	{
		//document.all.bttn_sel.style.display="";
	//	document.all.bttn_sel.disabled=false;
	}
	else{
		//document.all.bttn_sel.style.display="none";
		//document.all.bttn_sel.disabled=true;
	}
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
<%@include file="/system/app/skin/popbottom.jsp"%>