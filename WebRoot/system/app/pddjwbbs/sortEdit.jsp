<%@page contentType="text/html; charset=GBK"%>
<%@include file="/system/app/skin/head.jsp"%>
<script LANGUAGE="javascript" src="common/common.js"></script>
<script type="text/javascript" src="editor/fckeditor.js"></script>
<script type="text/javascript">
	function checkFrm(){
	  if (formData.sort_name.value==""){
		alert("请填写栏目名称!");
		formData.sort_name.focus();
		return false;
	  }

	  formData.action = "sortResult.jsp";
	 formData.submit();
	}

	function delfrm(sort_id){
	 
	  if(confirm("确实要删除吗？\n将会删除该主题下的所有内容!\n请谨慎操作!"))
	  {
			formData.action = "sortdel.jsp?sort_id="+sort_id;
			 formData.submit();
	  }
	}
</script>
<%
String sort_id="";		//分类ID
String sort_name="";		//分类名称
String sort_code="";		//分类代号
String sort_parent_id="";		//分类父级ID
String sort_sequence="";		//分类排序
String sort_showflag="";		//是否显示：1否、1是
String sort_desc="";		//分类说明
String sqlStr = "";
Hashtable content=null; 
sort_id=CTools.dealNumber(request.getParameter("sort_id")).trim();//栏目id
sort_name = CTools.dealNumber(request.getParameter("sort_name")).trim();
sort_code = CTools.dealString(request.getParameter("sort_code")).trim();
sort_parent_id = CTools.dealNumber(request.getParameter("sort_parent_id")).trim();
sort_sequence = CTools.dealString(request.getParameter("sort_sequence")).trim();
sort_showflag = CTools.dealString(request.getParameter("sort_showflag")).trim();
sort_desc = CTools.dealString(request.getParameter("sort_desc")).trim();
String OPType = CTools.dealString(request.getParameter("OPType")).trim();
//
CDataCn dCn = null;
CDataImpl dImpl = null;
try{
dCn = new CDataCn("pddjw");
dImpl = new CDataImpl(dCn);

if (OPType.equals("edit")){
	sqlStr = "select * from FORUM_SORT where sort_id='"+ sort_id +"'";
	content = dImpl.getDataInfo(sqlStr);
	if(content!=null){
		sort_id = content.get("sort_id").toString();
		sort_name = content.get("sort_name").toString();
		sort_code = content.get("sort_code").toString();
		sort_parent_id = content.get("sort_parent_id").toString();
		sort_sequence = content.get("sort_sequence").toString();
		sort_showflag = content.get("sort_showflag").toString();
		sort_desc = content.get("sort_desc").toString();
		sort_sequence = content.get("sort_sequence").toString();
}
	}else if(OPType.equals("add")){
		sort_name ="";
			
		}
%>
<%@include file="/system/app/skin/skin4/template/info_top.jsp"%>
<!--    模块名称开始    -->
<strong>新增栏目</strong>
<!--    模块名称结束    -->
<%@include file="/system/app/skin/skin4/template/info_funtion.jsp"%>
<!--    功能按钮开始    -->

<!--    功能按钮结束    -->
<%@include file="/system/app/skin/skin4/template/info_main.jsp"%>
<!--    表单提交开始    -->

<table CELLPADDING="0" cellspacing="0" BORDER="0" width="100%">
<form name="formData" method="post" >
	  <tr>
   	<td width="100%">
   		<table width="100%" height="1">	
	   		<tr class="line-even" >
	            <td width="19%" align="right">栏目：</td>
	            <td width="81%" align="left" >&nbsp;&nbsp;&nbsp;
	            	<input type="text" name="sort_name"  class="text-line" size="40" value="<%=sort_name%>" maxlength="50"/>&nbsp;&nbsp;<FONT COLOR="red">*</FONT>&nbsp;&nbsp;(注：最多输入50字符)
	            </td>
        		</tr>
        		<tr class="line-odd" >
            	<td width="19%" align="right">发布状态</td>
           	 	<td width="50%" align="left" >&nbsp;&nbsp;&nbsp;
					<INPUT TYPE="radio" NAME="sort_showflag" <%=!"0".equals(sort_showflag)?"checked":""%> value="1">发布&nbsp;&nbsp;
					<INPUT TYPE="radio" NAME="sort_showflag" <%="0".equals(sort_showflag)?"checked":""%>  value="0">不发布
            	</td>
      		</tr>
					<tr class="line-even" >
            	<td width="19%" align="right">排 序</td>
           	 	<td width="50%" align="left" >&nbsp;&nbsp;&nbsp;
					<input type=text class=text-line name="sequence" value="<%=sort_sequence%>" size=4>
            	</td>
      		</tr>
      		<TR class="line-odd"><TD align="right">分类说明：</TD>
      			<TD align="left" >&nbsp;&nbsp;&nbsp;
      				<textarea id="sort_desc" name="sort_desc" cols="60" rows="4" ><%=sort_desc%></textarea>
      			</TD>	
      		</TR>
	   		<tr  class=outset-table>
		   		<td align="center" height="20" colspan=2>
		   			<input type="button"   onclick="checkFrm()" value="保存">
						<%if ("edit".equalsIgnoreCase(OPType)){
						%>
		   		<input type="button" 　 onclick="delfrm(<%=sort_id%>)" value="删除"> 
					<%}%>
		  			 <input type="button" name="previewpost" value="返回" onClick="window.history.back();" />
		  		</td>
         </tr>
	   </table>
	</td>
  </tr>
</table>
<input type="hidden" name=sort_id value="<%=sort_id%>">
<input type="hidden" name="sort_parent_id" value="<%=sort_parent_id%>">	
<input type="hidden" name="OPType" value="<%=OPType%>">	
</form>
<!--    表单提交结束    -->
<%@include file="/system/app/skin/skin4/template/info_bottom.jsp"%> 
<%
}
catch(Exception e){
	System.out.print(e.toString());
}
finally{
	dImpl.closeStmt();
	dCn.closeCn(); 
}
%>
<%@include file="/system/app/skin/bottom.jsp"%>
                                     
