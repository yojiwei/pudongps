<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="../head.jsp" %>
<%@ page import="com.platform.CManager"%>
<script LANGUAGE="javascript" src="/system/common/treeview/chooseTreeJs.jsp"></script>

<script LANGUAGE="javascript">
<!--
function check()
{

	var form = document.formData ;

	if(form.ui_uid.value == ""){
		alert("请输入注册名!");
		form.ui_uid.focus();
		return false;
	}

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
        formData.dt_id.value=formData.ModuleDirIds.value;
	form.submit() ;
}

function del()
{
  if(!confirm("您确定要删除该用户吗？"))return;
  formData.action = "userInfoDel.jsp"
  formData.submit();
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
   String ui_id="",ui_name="",ui_uid="",ui_password="",ui_sex="",ui_active_flag="",dt_id="",dt_name="",title="",ui_ip="";
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
     CDataImpl dImpl = null; //新建数据接口对象
     CRoleInfo jdo2 = null;
     try{
     	dCn = new CDataCn();
     	jdo = new CUserInfo(dCn);
     	dImpl = new CDataImpl(dCn);
     	jdo2 = new CRoleInfo(dCn);


  if (list_id == null) list_id = "1";


        if (ui_id == null){ //新增状态
          title  = "新增用户";
          ui_id = "0";
        }else{ //显示、修改
          title = "修改用户";

          id = java.lang.Long.parseLong(ui_id);
          sql = "select u.*,d.dt_name from tb_userinfo u,tb_deptinfo d where u.dt_id = d.dt_id and u.ui_id = " + ui_id;
          content = jdo.getDataInfo(sql) ;
          if (content !=null){
            if(content.get("ui_uid") != null)
            	ui_uid       = CTools.dealNull(content.get("ui_uid"));
            if(content.get("ui_name") != null)
            	ui_name      = CTools.dealNull(content.get("ui_name")) ;
            if(content.get("ui_password") != null){
            	ui_password       = CTools.dealNull(content.get("ui_password")) ;
				// 解密开始
				ui_password = SecurityTest.decode(ui_password);
				byte[] bt = new sun.misc.BASE64Decoder().decodeBuffer(ui_password);
				ui_password = new String(bt);
				// 解密结束
			}
            if(content.get("ui_sex") != null)
            	ui_sex       = CTools.dealNull(content.get("ui_sex")) ;
            if(content.get("dt_id") != null)
            	dt_id        = CTools.dealNull(content.get("dt_id")) ;
            if(content.get("dt_name") != null)
            	dt_name      = CTools.dealNull(content.get("dt_name")) ;
            if(content.get("ui_active_flag") != null)
            	ui_active_flag = CTools.dealNull(content.get("ui_active_flag"));
            if(content.get("ui_ip") != null)
            	ui_ip       = CTools.dealNull(content.get("ui_ip"));
            if (ui_sex.equals("女")){
               sCheck[0]   = "";
               sCheck[1]   = "checked";
            }
            if (ui_active_flag.equals("1")){
               sCheck[2]   = "checked";
            }

          }
          

          jdo.closeStmt();
          jdo = null;
        }



        sql="select dt_name from tb_deptinfo where dt_id=" + list_id;
        Hashtable content1=dImpl.getDataInfo(sql);
        String Module_name=CTools.dealNull(content1.get("dt_name"));
  

        sql="select tr_id from tb_roleinfo where tr_type=1 and tr_userids='," + ui_id+",'";
        Hashtable content2=dImpl.getDataInfo(sql);
        String tr_id="-1";
        
		if(content2!=null) 
			tr_id=CTools.dealNull(content2.get("tr_id"));
		else
		{			
			
			tr_id = new String().valueOf(jdo2.addNew());
			
			jdo2.setValue("tr_type","1",CRoleInfo.INT );
			jdo2.setValue("tr_name",ui_name,CRoleInfo.STRING);
			jdo2.setValue("tr_detail","Private",CRoleInfo.STRING);
			jdo2.setValue("tr_level","1",CRoleInfo.INT );
			jdo2.setValue("tr_createby","admin",CRoleInfo.STRING);
			jdo2.setValue("tr_userids",","+ui_id+",",CRoleInfo.STRING);
			jdo2.setValue("dt_id",list_id,CRoleInfo.STRING);
			jdo2.update() ;
			jdo2.closeStmt();
		}
    

		session.setAttribute("_platform_tr_name",dt_name+"/"+ui_name);


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
			<td width="70%" align="left"><a href=../role/roleModuleInfo.jsp?tr_id=<%=tr_id%>>维护权限</a></td>

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
	  	    <td width="15%" align="right"><span style="color:red">*</span>注册名：</td>
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
        <td width="85%">
<input type="text" name="Module" class="text-line" treeType="Dept" value="<%=Module_name%>" treeTitle="选择所属部门" readonly isSupportFile="0" onclick="chooseTree('Module');">
<input type=button  title="选择所属部门" onclick="chooseTree('Module');" class="bttn" value=选择...>
<input type="hidden" name="ModuleDirIds" value="<%=list_id%>">
<input type="hidden" name="ModuleFileIds" value>
<input type="hidden" name="dt_id" value="<%=list_id%>">
	  	    </td>
	  	  </tr>
	  	  <tr class="line-even">
	  	    <td width="15%" align="right">部门服务器ip：</td>
	  	    <td width="85%"><input type="text" class="text-line" name="ui_ip" size="20" value="<%=ui_ip %>" maxlength="20"></td>
	  	  </tr>
	  	  <tr class="line-odd">
	  	    <td width="15%" align="right">帐号停用：</td>
	  	    <td width="85%"> <input type="checkbox" class="checkbox1" value="1" name="ui_active_flag" <%=sCheck[2]%>></td>
	  	  </tr>
<%

CRoleAccess ado=new CRoleAccess(dCn);
CMySelf self = (CMySelf)session.getAttribute("mySelf");
String user_id = String.valueOf(self.getMyID());
if(ado.isAdmin(user_id))
{
%>
	  	  <tr class="line-even">
	  	    <td width="15%" align="right">所属角色：</td>
	  	    <td width="85%">
	  	    
<%      
        sql="select tr_id,tr_name from tb_roleinfo where tr_userids like '%," + ui_id+",%'";
        ResultSet rsRole=dImpl.executeQuery(sql);
      	while(rsRole.next())
      	{
					String roleid=CTools.dealNull(rsRole.getString("tr_id"));
					String rolename=CTools.dealNull(rsRole.getString("tr_name"));
%>
<a href=../role/roleModuleInfo.jsp?tr_id=<%=roleid%>><%=rolename%></a>  
<%
      	}
}
        dImpl.closeStmt();
        dCn.closeCn();
%>	
	  	    	</td>
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
		  			<input class="bttn" value="删除" type="button" onclick="del()" size="6" id="button4" name="button4">&nbsp;
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
	if(dImpl != null)
	dImpl.closeStmt();
	if(jdo != null)
	jdo.closeStmt();
	if(jdo2 != null)
	jdo2.closeStmt();
	if(dCn != null)
	dCn.closeCn();
}

%>