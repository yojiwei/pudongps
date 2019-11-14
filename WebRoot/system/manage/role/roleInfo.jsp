<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="../head.jsp" %>
<%
String tr_id; //角色id
String tr_name   = "";
String tr_detail = "";
String tr_level  = "10";
String tr_type = "";
String sql = "";
String _disabled = "";
String msg = "";
String dt_id = "";

tr_id = request.getParameter("tr_id");
  Vector vectDT = null;
//out.print(tr_id);
//out.close();
CDataCn dCn = null;
  CRoleInfo jdo=null;
  try{
  	dCn = new CDataCn();
  	jdo=new CRoleInfo(dCn);
  String sqlDT = "select dt_name,dt_id from tb_deptinfo order by dt_sequence";
	vectDT = jdo.splitPage(sqlDT,request,100);
if (tr_id != null)
{
  if (tr_id.equals("")) tr_id = "1";
  
  sql="select * from tb_roleinfo where tr_id="+tr_id;

  Hashtable content=jdo.getDataInfo(sql);
  if (content == null)
  {
    msg = "该角色不存在！";
    msg = java.net.URLEncoder.encode(msg);

    //out.print(msg);
    jdo.closeStmt();
    dCn.closeCn();
    response.sendRedirect("/system/common/goback/goback.jsp?msg="+msg);
    //out.close();
  }else{
    tr_name   = content.get("tr_name").toString();
    tr_detail = content.get("tr_detail").toString();
    tr_level  = content.get("tr_level").toString();
    tr_type   = content.get("tr_type").toString() ;
	dt_id	  = content.get("dt_id").toString() ;
    if (tr_type.equals("0")) _disabled = " disabled ";

    session.setAttribute("_platform_tr_name",tr_name);

	

    
  }
}else{
  tr_id = "0";
}
jdo.closeStmt();
    dCn.closeCn();
%>
<script LANGUAGE="javascript">
<!--
function edit()
{
  if (formData.tr_name.value == "") {
       alert("角色名称不能为空！");
       return;
    }
    formData.submit();
}
function del()
{
    if (!confirm("确认删除当前角色!")) return;
    formData.action = "roleDel.jsp";
    formData.submit();
}
//-->
</script>
<table class="main-table" width="100%">
<form name="formData" method="post" action="roleInfoResult.jsp">
  <tr>
   <td>
  <table width="100%">
    <tr>
      <td width="100%" align="left" colspan="2">
<%String Operate="配置角色基本信息";%>
<%@ include file="nav.jsp" %>
      </td>
    </tr>

   <tr>
     <td width="100%">
         <table width="100%" class="content-table" height="150" cellspacing="0" cellpadding="0">
            <tr class="line-odd">
                <td align="right" height="20" width="20%"><span  style="color:red">*</span>名称：</td>
                <td height="20" width="80%">
                                        <input type="text" class="text-line" name="tr_name" value="<%=tr_name%>" maxlength="30" size="30" <%=_disabled%>>
                                </td>
            </tr>
            <tr class="line-even">
                <td align="right" height="88" width="20%">描述：</td>
                <td height="88" width="80%">
                     <textarea name="tr_detail" class="text-area" rows="5" cols="60" <%=_disabled%>><%=tr_detail%></textarea>
                </td>
            </tr>
            <tr class="line-odd">
                <td align="right" height="20" width="20%">级别：</td>
                <td height="20" width="80%">
                                        <select name="tr_level" class="select-a">

                                                <option <%= "1".equals(tr_level) ? "selected" : ""%>>1
                                                <option <%= "2".equals(tr_level) ? "selected" : ""%>>2
                                                <option <%= "3".equals(tr_level) ? "selected" : ""%>>3
                                                <option <%= "4".equals(tr_level) ? "selected" : ""%>>4
                                                <option <%= "5".equals(tr_level) ? "selected" : ""%>>5
                                                <option <%= "6".equals(tr_level) ? "selected" : ""%>>6
                                                <option <%= "7".equals(tr_level) ? "selected" : ""%>>7
                                                <option <%= "8".equals(tr_level) ? "selected" : ""%>>8
                                                <option <%= "9".equals(tr_level) ? "selected" : ""%>>9
                                                <option <%= "10".equals(tr_level) ? "selected" : ""%>>10
                                        </select>
                                </td>
            </tr>

			 <tr class="line-even">
                <td align="right" height="20" width="20%">所属部门：</td>
                <td height="20" width="80%">                                   
					  <select name="dt_id" class="select-a">              		
					  <option value="0">无</option>
					  <%
						

						
						if(vectDT!=null)
						{
							for(int i=0;i<vectDT.size();i++)
							{
								Hashtable contentDT = (Hashtable)vectDT.get(i);
					  %>
								<option value="<%=contentDT.get("dt_id")%>" <%if(dt_id.equals(contentDT.get("dt_id").toString())) out.println("selected");%>><%=contentDT.get("dt_name")%></option>
					  <%
							}
						}
						%>
					</select>
               </td>
            </tr>

                   </table>
         </td>
   </tr>
   <tr class="title1">
      <td width="100%" align="center" colspan="2">

          <input type="button" class="bttn" value="新增" onclick="window.location='roleInfo.jsp'" >
          <input type="button" class="bttn" value="保存" onclick="edit();" >
          <input type="button" class="bttn" value="删除" <%=(tr_name.equals("超级管理员"))?"disabled":""%> onclick="del()" >

      </td>
   </tr>
</table>
<input type="hidden" name="tr_id" value="<%=tr_id%>">
<input type="hidden" name="control" value>
</td>
</tr>
</form>
</table>

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