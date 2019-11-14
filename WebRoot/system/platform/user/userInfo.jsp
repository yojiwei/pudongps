<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="../head.jsp" %>
<%@ page import="com.platform.CManager"%>

<script LANGUAGE="javascript">
<!--
function check()
{

	var form = document.formData ;

	if(form.ui_password.value == ""){
		alert("请输入密码!");
		form.ui_password.focus();
		return false;
	}

	if(form.ui_name.value == ""){
		alert("请输入姓名!");
		form.ui_name.focus();
		return false;
	}
	form.submit() ;
}

function chooseRole(obj)
{
		var roleList ;
		var args = new Object(); args["roleList"] = obj;
		roleList = showModalDialog("chooseRole.asp", args, "dialogWidth: 150px; dialogHeight: 320px; ");
		if (typeof(roleList) != "undefined") {
			obj.value = roleList ;
		}
}
//-->
</script>

<%
   String ui_id="",ui_name="",ui_uid="",ui_password="",ui_sex="",ui_active_flag="",dt_id="",dt_name="",title="";
   String list_id="";
   String node_title="";
   String sql = "";
   String sCheck[] = {"","",""};
   String sDeptList = "";
   CTools tools = null;
   Hashtable content = null;
   long id;
%>

<%
  tools = new CTools();
  list_id     = tools.dealNumber(request.getParameter("list_id")).trim();
  node_title  = tools.iso2gb(request.getParameter("node_title"));
  ui_id       = request.getParameter("ui_id");
  sCheck[0]   = "checked";
  CDataCn dCn = null;
  CUserInfo jdo = null; 
  try{
  	dCn = new CDataCn();
  	jdo = new CUserInfo(dCn); 
  CManager manage = (CManager)session.getAttribute("manager");
  String orgname = manage.getAtOrgname();//用户模块
 // out.print(list_id);

  if (list_id == null) list_id = "1";

        ////////////////////////////////////////////////////////
        // ui_id: 用户本身ID号
        // list_id: 目录传递ID号

        if (ui_id == null){ //新增状态
          title  = "新增用户";
          //sCheck[0] = "checked";
          ui_id = "0";
        }else{ //显示、修改
          title = "修改用户";
          
          //CDeptList list = new CDeptList(dCn);

          id = java.lang.Long.parseLong(ui_id);
          sql = "select u.*,d.dt_name from tb_userinfo u,tb_deptinfo d where u.dt_id = d.dt_id and u.ui_id = " + ui_id;
          content = jdo.getDataInfo(sql) ;
          if (content !=null){
            if(content.get("ui_uid") != null)
            	ui_uid       = content.get("ui_uid").toString();
            if(content.get("ui_name") != null)
            	ui_name      = content.get("ui_name").toString() ;
            if(content.get("ui_password") != null)
            	ui_password       = content.get("ui_password").toString() ;
            if(content.get("ui_sex") != null)
            	ui_sex       = content.get("ui_sex").toString() ;
            if(content.get("dt_id") != null)
            	dt_id        = content.get("dt_id").toString() ;
            if(content.get("dt_name") != null)
            	dt_name      = content.get("dt_name").toString() ;
            if(content.get("ui_active_flag") != null)
            	ui_active_flag = content.get("ui_active_flag").toString();
            if (ui_sex.equals("女")){
               sCheck[0]   = "";
               sCheck[1]   = "checked";
            }
            if (ui_active_flag.equals("1")){
               sCheck[2]   = "checked";
            }

          }


          ///sDeptList = list.getListByParentID(0,list_id);
          jdo.closeStmt();
          jdo = null;
        }

        CDeptList i = new CDeptList(dCn);
				i.setOnchange(false);
        sDeptList = i.getListByParentID(0,list_id,orgname);
        i.closeStmt();
        dCn.closeCn();
%>

<table class="main-table" width="100%">
<tr>
<td>
<form action="userInfoResult.jsp" method="post" name="formData">
<div align="center">
    <table border="0" width="100%" cellpadding="0" cellspacing="0">
	  <tr>
	   <td width="100%" align="left" colspan="4">
		 <table width="100%" cellpadding="3" cellspacing="0">
		  <tr class="bttn" height="4">
			<td id="TitleTd" width="10%" align="left"><%=title%></td>
			<td width="70%" align="left">察看所属角色集</td>

			<td valign="top" align="right" nowrap>
			<img src="/system/images/dialog/split.gif" align="middle" border="0">

			<img src="/system/images/dialog/return.gif" border="0" onclick="window.location='userList.asp?list_id=<%=list_id%>&amp;node_title=<%=node_title%>'" title="返回" style="cursor:hand" align="absmiddle" id="image3" name="image3" WIDTH="14" HEIGHT="14">
			<img src="/system/images/dialog/split.gif" align="middle" border="0">
			</td>
		  </tr>
		</table>
	   </td>
	  </tr>
      <tr>
        <td width="100%" align="left" valign="top">

	  	<table border="0" width="100%" cellspacing="1" cellpadding="0">
	  	  <tr class="line-odd">
	  	    <td width="15%" align="right">注册名：</td>
	  	    <td width="85%"><input class="text-line" name="ui_uid" size="20" value="<%=ui_uid %>" maxlength="20"></td>
	  	  </tr>
	  	  <tr class="line-even">
	  	    <td width="15%" align="right"><span style="color:red">*</span>密码：</td>
	  	    <td width="85%"><input type="password" class="text-line" name="ui_password" size="20" value="<%=ui_password %>" maxlength="20"></td>
	  	  </tr>
	  	  <tr class="line-odd">
	  	    <td width="15%" align="right"><span style="color:red">*</span>姓名：</td>
	  	    <td width="85%"><input class="text-line" name="ui_name" size="20" value="<%=ui_name%>" maxlength="20"></td>
	  	  </tr>
	  	  <tr class="line-even">
	  	    <td width="15%" align="right">性别：</td>
	  	    <td width="85%">
	  	    <INPUT type="radio" id=Sex name=ui_sex value=男 <%=sCheck[0]%>>男
	  	    <INPUT type="radio" id=Sex name=ui_sex value=女 <%=sCheck[1]%>>女
	  	    </td>
	  	  </tr>

	  	  <tr class="line-odd">
	  	    <td width="15%" align="right">部门：</td>
	  	    <td width="85%"><%=sDeptList %>
<!--
<input class="text-line" name="dt_name" size="20" maxlength="20" value="< %=dt_name%>" readonly>
	  	    	<input type="hidden" name="dt_id" value="< %=dt_id %>">
	  	    	<input type="button" class="bttn" value="选择..." onclick="chooseTreeEx(formData.dt_name,formData.dt_id,'','选择部门','dept');" size="7" id="button1" name="button1">
-->
	  	    </td>
	  	  </tr>
	  	  <tr class="line-even">
	  	    <td width="15%" align="right">帐号停用：</td>
	  	    <td width="85%"> <input type="checkbox" class="checkbox1" value="1" name="ui_active_flag" <%=sCheck[2]%>></td>
	  	  </tr>
	  	</table>
        </td>
      </tr>
		<tr class="title1">
		  <td width="100%" align="right" colspan="2">
		      <p align="center">
		  	<%  if (ui_id.equals("0")){ //新增界面 %>
		  			<input class="bttn" value="提交" type="button" onclick="check()" size="6" id="button2" name="button2">&nbsp;
		  	<%  }else{ 	%>
		  			<input class="bttn" value="修改" type="button" onclick="check()" size="6" id="button4" name="button4">&nbsp;
		  	<%  }	%>
                            <input class="bttn" value="返回" type="button" onclick="history.back();" size="6" >&nbsp;

		    </td>
		</tr>
    </table>
</div>
<input type="hidden" name="list_id" value="<%=list_id%>">
<input type="hidden" name="node_title" value="<%=node_title%>">
<input type="hidden" name="ui_id" value="<%=ui_id %>">
</form>
</td>
</tr>
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