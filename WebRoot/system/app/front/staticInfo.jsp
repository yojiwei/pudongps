<%@page contentType="text/html; charset=GBK"%>
<%@include file="/system/app/skin/head.jsp"%>
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
	String ur_id = "";
	Vector vPage = null;
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
        sql = "select fi_id,fs_id,fi_title,fi_url,fi_sequence,fi_content,fi_img,fi_type,ur_id from tb_frontinfo where fi_id = '" + fi_id + "'";
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
						 ur_id = content.get("ur_id").toString();
             actiontype = "modify";
             strTitle = "编辑信息";
            }
     }
 String ui_name = "";
 if (!"".equals(ur_id)) {
	 String strSql = "select ui_name from tb_userinfo where ui_id in (" + ur_id + ")";
	 vPage = dImpl.splitPageOpt(strSql,1000,1);
	 Hashtable ht = null;
	 if (vPage != null) {
	 	for (int i = 0;i < vPage.size();i++) {
	 		ht = (Hashtable)vPage.get(i);
	 		ui_name += ht.get("ui_name").toString() + ",";
	 	}
	 }
 }
%>
<script LANGUAGE="javascript" src="/system/common/treeview/chooseTreeJs.jsp"></script>
<%@include file="/system/app/skin/skin4/template/info_top.jsp"%>
<!--    模块名称开始    -->
<%=strTitle %>
<!--    模块名称结束    -->
<%@include file="/system/app/skin/skin4/template/info_funtion.jsp"%>
<!--    功能按钮开始    -->

<!--    功能按钮结束    -->
<%@include file="/system/app/skin/skin4/template/info_main.jsp"%>
<!--    表单提交开始    -->
<table WIDTH="100%" CELLPADDING="0" BORDER="0">
<form action="staticInfoResult.jsp" method="post" name="formData">
     <tr class="line-even">
        <td align="right">静态页面描述：</td><td align="left"><input type="text" name="fi_title" value="<%=fi_title%>" class="text-line"> <font color=red>*</font></td>
      </tr>
      <tr class="line-odd">
        <td align="right">生成文件：</td><td align="left"><input type="text" name="fi_url" value="<%=fi_url%>" class="text-line"> <font color=red>*</font><INPUT TYPE="checkbox" NAME="fi_type" value = "1"<%if(fi_type.equals("1"))out.println("checked");%>> 是否为绝对路径</td>
      </tr>	 
	  <tr class="line-even">
        <td align="right">动态URL链接：</td><td align="left"><input class="text-line" name="fi_content" value="<%=fi_content%>" size="60"></td>
      </tr>
	  <tr class="line-odd">
        <td align="right">选择维护用户：</td>
        <td align="left">
        	<input type="text" onclick="chooseTree('user');" name="user" value="<%=ui_name%>" treeType="Dept" treeTitle="选择维护用户" isSupportMultiSelect="1" isSupportFile="1" isSupportDirSelect="0"> 
			<input type=button title="选择维护用户" onclick="chooseTree('user');" class="bttn" value=选择...>
			<input type="hidden" name="userDirIds" value>
			<input type="hidden" name="userFileIds" value="<%=ur_id%>">
        </td>
      </tr>
    <tr class=outset-table>
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
	<input type=reset name=b1 value="重填" class="bttn">&nbsp;
	<input type=button name=b1 value="返回" onClick="javascipt:history.go(-1);" class="bttn">
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
</script>
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
                                     
