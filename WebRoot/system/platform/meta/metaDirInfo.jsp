<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="../head.jsp" %>

<script LANGUAGE="javascript">
<!--
function check()
{
	var form = document.formData ;
	if (form.name.value == "" ) {
		alert("目录名称不能为空！") ;
		form.name.focus();
		return;
	}
	form.submit() ;
}
function del()
{
	formData.action = "metaDirDel.jsp";
	formData.submit();
}
//-->
</script>


<%  CDataCn dCn = null;
 CMetaList i = null; 
 try{
 	dCn = new CDataCn();
 	i = new CMetaList(dCn); 
   String dd_id="",dd_name="",dd_code="";
   String list_id="";
   String node_title="";
   String sql = "";
   String title = "";
   CTools tools = null;
   Hashtable content = null;
   long id;


%>
<%
  tools = new CTools();
  list_id     = request.getParameter("list_id");
  node_title  = tools.iso2gb(request.getParameter("node_title"));
  dd_id       = request.getParameter("dd_id");
 // out.print(list_id);
  
   //i.setOnchange(false);
   i.setOutputSelect(false);
   String strSelectmtid = i.getListByCurID(0,list_id);
   i.closeStmt();

  if (list_id == null) list_id = "1";

        ////////////////////////////////////////////////////////
        // dd_id: 字典目录本身ID号
        // list_id: 目录传递ID号

        if (dd_id == null){ //新增状态
          title  = "新增字典目录";
          dd_id = "0";
        }else{ //显示、修改
          title = "修改字典目录";

          CMetaDirInfo jdo = new CMetaDirInfo(dCn);
          id = java.lang.Long.parseLong(dd_id);
          content = jdo.getDataInfo(id) ;
          if (content !=null){
            dd_name      = content.get("dd_name").toString() ;
            dd_code      = content.get("dd_code").toString() ;
          }
          jdo.closeStmt();

          jdo = null;
        }

%>
<table class="main-table" width="100%">
<form action="metaDirInfoResult.jsp" method="post" name="formData">
<div align="center">
 <tr>
  <td width="100%">
    <table border="0" width="100%" cellpadding="0" cellspacing="0">
	  <tr valign="bottom">
	   <td width="100%" align="left">
	    <table width="100%" cellpadding="0" cellspacing="0">
		  <tr class="title1" height="2">
			<td id="TitleTd" width="100%" align="left"><%=title %></td>
			<td valign="top" align="right" nowrap>
			<img src="/system/images/dialog/split.gif" align="middle" border="0">

			<img src="/system/images/dialog/return.gif" border="0" onclick="javascirpt:history.go(-1);" title="返回" style="cursor:hand" align="absmiddle" id="image3" name="image3" WIDTH="14" HEIGHT="14">
			<img src="/system/images/dialog/split.gif" align="middle" border="0">
			</td>
		  </tr>
		</table></td>
	  </tr>

      <tr>
        <td width="100%" align="left" valign="top">
	  		<table border="0" width="100%" cellspacing="1" cellpadding="0">
	  		  <tr class="line-odd">
	  		    <td width="15%" align="right">名称：</td>
	  		    <td width="85%" align="left"><input type="text" class="text-line" size="20" name="dd_name" value="<%=dd_name%>"></font></td>
	  		  </tr>
	  		  <tr class="line-even">
	  		    <td width="15%" align="right">代码：</td>
	  		    <td width="85%" align="left">
	  		    	<input type="text" name="dd_code" value="<%=dd_code%>" class="text-line">
	  		    </td>
	  		  </tr>
	  		  <tr class="line-odd">
	  		    <td width="15%" align="right">上级目录：</td>
	  		    <td width="85%" align="left">
              <SELECT NAME="list_id" class=select-a size='1'><%=strSelectmtid%></SELECT>

	  			</td>
	  		  </tr>
			</table>
		</td>
	  </tr>

	  <tr class="title1">
	    <td width="100%" align="center" colspan="4">
<%if (dd_id.equals("0")) { //新增
%>
	  		<input class="bttn" value="提交" type="button" onclick="check()" size="6">&nbsp;
<% }else{ %>
	  		<input class="bttn" value="修改" type="button" onclick="check()" size="6">&nbsp;
	  		<input class="bttn" value="删除" type="button" size="6" onclick="del()" id="button2" name="button2">&nbsp;
<% } %>

	  		<input class="bttn" value="返回" type="button" onclick="history.back();" size="6" id="button3" name="button3">&nbsp;
	    </td>
      </tr>
	</table>
</div>
<input type="hidden" name="list_id*-*-zzz" value="<%//=list_id  dd_parentid%>">
<input type="hidden" name="node_title" value="<%=node_title%>">
<input type="hidden" name="dd_id" value="<%=dd_id%>">

</td>
</tr>
</form>
</table>
<% dCn.closeCn() ;%>
<%@ include file="../bottom.jsp" %>
<%


} catch (Exception ex) {
	System.out.println(new java.util.Date() + "--"
			+ request.getServletPath() + " : " + ex.getMessage());
} finally {
	if(i != null)
	i.closeStmt();
	if(dCn != null)
	dCn.closeCn();
}

%>

