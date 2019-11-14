<%@page contentType="text/html; charset=GBK"%>
<%@include file="../skin/head.jsp"%>
<%
        String fi_id = "";
		String fs_id = "";
        String sql = "";
        String sql_judge = "";
        String sqlStr = "";
        String sqlCorr = "";
        String fi_title = "";
		String fi_url = "";
		String fi_sequence = "";
		String fi_content = "";
		String fi_img = "";
        String actiontype="add";
		String fi_type = "";
        Vector vPage = null;

       //update20080122

CDataCn dCn=null;   //新建数据库连接对象
CDataImpl dImpl=null;  //新建数据接口对象

try {
 dCn = new CDataCn(); 
 dImpl = new CDataImpl(dCn); 
		String list_id = CTools.dealString(request.getParameter("list_id")).trim();
        String strTitle="新增信息";
        fi_id=CTools.dealString(request.getParameter("fi_id"));
        if(!fi_id.equals(""))
        {
            sql = "select fi_id,fs_id,fi_title,fi_url,fi_sequence,fi_content,fi_img,fi_type from tb_frontinfo where fi_id = '" + fi_id + "'";
               Hashtable content = dImpl.getDataInfo(sql);
               if (content!=null)
               {
                 fi_id = content.get("fi_id").toString();
				 list_id = content.get("fs_id").toString();
                 fi_title = content.get("fi_title").toString();
				 fi_url = content.get("fi_url").toString();
				 fi_sequence = content.get("fi_sequence").toString();
				 fi_content = content.get("fi_content").toString();
				 fi_img = content.get("fi_img").toString();
				 fi_type = content.get("fi_type").toString();
                 actiontype = "modify";
                 strTitle = "编辑信息";
                }
         }
%>

<table WIDTH="100%" CELLPADDING="0" BORDER="0" class="main-table">
<form action="radioInfoResult.jsp" method="post" name="formData">

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
        <td align="right">音频名称：</td><td align="left"><input type="text" name="fi_title" value="<%=fi_title%>" class="text-line"> <font color=red>*</font></td>
      </tr>
      <tr class="line-odd">
        <td align="right">连接地址：</td><td align="left"><input type="text" name="fi_url" value="<%=fi_url%>" class="text-line"> <font color=red>*</font><INPUT TYPE="checkbox" NAME="fi_type" value = "1"<%if(fi_type.equals("1"))out.println("checked");%>> 是否为绝对路径</td>
      </tr>	 	 
      <tr class=title1>
    <td align=center colspan=2>
    <input type=button name=b1 value="提交" class="bttn" onclick="sub()">&nbsp;
    <%
	if(!actiontype.equals("add"))
	{
	%>
	<input value="删除" class="bttn" onclick="javascript:del()" type="button" size="6">&nbsp;
    <%
	}	
	%>
	<input type=reset name=b1 value="重填" class="bttn">
	<input type=button name=b1 value="返回" onclick="window.history.back()">
  </td>
 </tr>

<input type=hidden name=actiontype value=<%=actiontype%>>
<input type=hidden name=fi_id value=<%=fi_id%>>
<input type=hidden name=list_id value=<%=list_id%>>
</form>
</table>
<script language="javascript">
  function  del()
  {
    if(window.confirm('确认要删除该记录么?'))
   {
    window.location="frontDel.jsp?fi_id=<%=fi_id%>&list_id=<%=list_id%>";
   }
  }
  function sub() {
	if(document.formData.fi_title.value == "") {
		alert("请输入音频名称");
		formData.fi_title.focus();
		return false;
	}

	if(document.formData.fi_url.value == "") {
		alert("请输入连接地址");
		formData.fi_url.focus();
		return false;
	}
	document.formData.submit();

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