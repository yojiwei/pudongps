<%@page contentType="text/html; charset=GBK"%>
<%@include file="../skin/head.jsp"%>
<%
        String fs_id = "";
		String fs_parentid = "o0";
        String sql = "";
        String sql_judge = "";
        String sqlStr = "";
        String sqlCorr = "";
        String fs_name = "";
		String fs_code = "";
        String actiontype="add";
        String fs_sequence = "";
        Vector vPage = null;
		String fs_parentid_ext = "";
		String fs_parentname_ext = "";

        //update20080122

CDataCn dCn=null;   //新建数据库连接对象
CDataImpl dImpl=null;  //新建数据接口对象

try {
 dCn = new CDataCn(); 
 dImpl = new CDataImpl(dCn); 
		String list_id = CTools.dealString(request.getParameter("list_id")).trim();
        String strTitle="新增栏目";
        fs_id=CTools.dealString(request.getParameter("fs_id"));
		String sql_parent = "";

        if(!fs_id.equals(""))
        {
            sql = "select fs_id,fs_name,fs_code,fs_parentid from tb_frontsubject where fs_id = '" + fs_id + "'";
               Hashtable content = dImpl.getDataInfo(sql);
               if (content!=null)
               {
                 fs_id = content.get("fs_id").toString();
                 fs_name = content.get("fs_name").toString();
				 fs_code = content.get("fs_code").toString();
				 fs_parentid = content.get("fs_parentid").toString();
                 actiontype = "modify";
                 strTitle = "编辑栏目";
                }
         }

		 sql_parent = "select fs_id,fs_name from tb_frontsubject order by fs_parentid,fs_sequence";
		 vPage = dImpl.splitPage(sql_parent,10000,1);
%>

<form action="frontSubjectInfoResult.jsp" method="post" name="formData">
<table WIDTH="100%" CELLPADDING="0" BORDER="0" class="main-table">
   <tr >
     <td width="100%" align="left" valign="top"colspan="2">
      <table class="content-table"  width="100%">
      <tr class="title1">
              <td align="center" colspan=2><%=strTitle %> </td>
      </tr>
      </table>
     </td>
     </tr>
      <tr class="line-even">
        <td align="right">栏目名称：</td><td><input type="text" name="fs_name" value="<%=fs_name%>" class="text-line"> <font color=red>*</font></td>
      </tr>
      <tr class="line-even">
        <td align="right">栏目代码：</td><td><input type="text" name="fs_code" value="<%=fs_code%>" class="text-line"> <font color=red>*</font></td>
      </tr>
	  <tr class="line-even">
        <td align="right">所属栏目：</td>
		<td>
		<select class="select-a" name="fs_parentid">
		<%
		if (vPage!=null)
		{
				for(int i=0;i<vPage.size();i++)
				{
						Hashtable content = (Hashtable)vPage.get(i);
						fs_parentid_ext = content.get("fs_id").toString();
						fs_parentname_ext = content.get("fs_name").toString();
						%>
						<option value="<%=fs_parentid_ext%>"<%if(fs_parentid_ext.equals(list_id)) out.print("selected");%>><%=fs_parentname_ext%></option>
						<%
				}
		}
		%>
        </select>
		<font color=red>*</font></td>
      </tr>
      <tr class=title1>
    <td align=center colspan=2>
    <input type=submit name=b1 value="提交" class="bttn" >&nbsp;
    <%
	if(!actiontype.equals("add"))
	{
	%>
	<input value="删除" class="bttn" onclick="javascript:del()" type="button" size="6">&nbsp;
    <%
	}	
	%>
	<input type=reset name=b1 value="重填" class="bttn">
  </td>
 </tr>
</table>
<input type=hidden name="actiontype" value=<%=actiontype%>>
<input type=hidden name="fs_id" value=<%=fs_id%>>
<input type=hidden name="list_id" value=<%=list_id%>>
</form>

<script language="javascript">
  function  del()
  {
    if(window.confirm('确认要删除该记录么?'))
   {
    window.location="frontSubjectDel.jsp?fs_id=<%=fs_id%>&list_id=<%=list_id%>";
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
<%@include file="../skin/bottom.jsp"%>