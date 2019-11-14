<%@page contentType="text/html; charset=GBK"%>
<%@ page import="com.util.CTools"%>
<%@ page import="java.util.Hashtable"%>
<%@ page import="java.util.Vector"%>
<%@ page import="com.component.database.*"%>
<%@ page import="com.platform.admin.*"%>
<%@ page import="com.platform.UI.mainFrame"%>
<link href="../style.css" rel="stylesheet" type="text/css">

<script LANGUAGE="javascript" src="../../common/treeview/chooseTreeJs.jsp"></script>
<%System.out.println();
	request.setCharacterEncoding("GBK");
	//update20080122

CDataCn dCn=null;   //新建数据库连接对象
CDataImpl dImpl=null;  //新建数据接口对象

try {
 dCn = new CDataCn(); 
 dImpl = new CDataImpl(); 
	
	String str_sql="SELECT * FROM TB_ROLEINFO WHERE TR_ID < 5 ORDER BY TR_ID DESC";
	Vector vectorRule = dImpl.splitPage(str_sql,request,1000);

	String strTitle = "权限管理:";
	CTools tools = new CTools();
	String operate = tools.dealNull(request.getParameter("OP"));
	
	String at_loginname = ""; //注册名
	String at_password = ""; //密码
	String at_realname = ""; //姓名
	String at_nickname = ""; //昵称
	//String at_purviewLevel = ""; //权限等级
	String at_ic = ""; //IC卡号
	String at_isactive = "0"; //是否启用
	String at_remark = ""; //描述
	String at_orgname = ""; //用户
	String at_module = ""; //权限
	String at_subject = ""; //栏目
	String at_managelvl = ""; //后台权限
	String dt_id = "";     //用户ID
	String module_id = "";   //权限ID
	String subject_id = ""; //栏目ID

	if(request.getParameter("at_loginname") != null)
		at_loginname = tools.dealString(request.getParameter("at_loginname")).trim();
	str_sql = " SELECT * FROM TB_ADMINISTRATOR WHERE AT_LOGINNAME = '"
			+ at_loginname + "' ";
	Hashtable rs = dImpl.getDataInfo(str_sql);
	Vector subRs = null;
	if(rs != null){
		if(rs.get("at_password") != null)
			at_password = String.valueOf(rs.get("at_password"));
		if(rs.get("at_realname") != null)
			at_realname = String.valueOf(rs.get("at_realname"));
		if(rs.get("at_nickname") != null)
			at_nickname = String.valueOf(rs.get("at_nickname"));
		//if(rs.get("purviewlevel") != null)
			//at_purviewLevel = String.valueOf(rs.get("purviewlevel"));
		if(rs.get("at_ic") != null)
			at_ic = String.valueOf(rs.get("at_ic"));
		if(rs.get("at_isactive") != null)
			at_isactive = String.valueOf(rs.get("at_isactive"));
		if(rs.get("at_remark") != null)
			at_remark = String.valueOf(rs.get("at_remark"));
		if(rs.get("at_orgname") != null){
			at_orgname = String.valueOf(rs.get("at_orgname"));
			str_sql = "select dt_id from tb_deptinfo  where dt_name in ( "+ CTools.tableStr2Str(at_orgname) +" )";
			at_orgname = at_orgname.replaceAll("",",");
			subRs = dImpl.splitPage(str_sql,request,200);
			dt_id = CTools.Result2Str(subRs,"dt_id");
		}
		if(rs.get("at_module") != null){
			at_module = String.valueOf(rs.get("at_module"));
			str_sql = "select ft_id from tb_function  where ft_name in ( "+ CTools.tableStr2Str(at_module)+" )";
			at_module = at_module.replaceAll("",",");
			subRs = dImpl.splitPage(str_sql,request,200);
			module_id = CTools.Result2Str(subRs,"ft_id");
		}
		if(rs.get("at_subject") != null){
			at_subject = String.valueOf(rs.get("at_subject"));
			str_sql = "select sj_id from tb_subject  where sj_name in ( "+ CTools.tableStr2Str(at_subject)+" )";
			at_subject = at_subject.replaceAll("",",");
			subRs = dImpl.splitPage(str_sql,request,200);
			subject_id = CTools.Result2Str(subRs,"sj_id");
		}
		if(rs.get("at_managelvl") != null)
			at_managelvl = String.valueOf(rs.get("at_managelvl"));

	}else{
		at_isactive = "1";
	}
	
	operate = operate.trim();
	String title ="";
	if("ADD".equals(operate)){
		title = "新增管理员";
	} else if("UPD".equals(operate)){ 
		title = "修改管理员";
	} else if("".equals(operate)){
		operate="ADD";
		title = "新增管理员";
	}
%>
<form action="" method="post" name="formData">
<input type="hidden" name="at_managelvlH" value="">
<table class="main-table" width="100%">
	<tr>
		<td width="100%">
		<table class="content-table" width="100%">

			<tr class="title1">
				<td colspan="5" align="center">
				<table WIDTH="100%" BORDER="0" CELLSPACING="1" CELLPADDING="1">
					<tr>
						<td valign="center"><%=strTitle%><%= title%>
						</td>
						<td valign="center" align="right" nowrap>
						<img src="../../images/split.gif" align="middle" border="0" WIDTH="5" HEIGHT="8"> 
						<img src="../../images/new.gif" border="0" onclick="window.location='adminList.jsp?OP=ADD'"
							title="新增管理员" style="cursor:hand" align="absmiddle" WIDTH="16"
							HEIGHT="16"> 
						<img src="../../images/split.gif" align="middle" border="0" WIDTH="5" HEIGHT="8"> 
						<img src="../../images/goback.gif" border="0" onclick="javascript:history.back();" title="返回"
							style="cursor:hand" align="absmiddle"> 
						<img src="images/split.gif" align="middle" border="0" WIDTH="5"	HEIGHT="8">
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
					<td width="85%"><input name="AT_loginname" size="20" class="text-line"
						value="<%= at_loginname%>"  maxlength="20">
					&nbsp;&nbsp;&nbsp;&nbsp;<span style="color:#606060">(可以用字母和数字组合，长度不超过20个)
					</span></td>
				</tr>
				<tr class="line-odd">
					<td width="15%" align="right"><span style="color:red">*</span>密码：</td>
					<td width="85%"><input type="password" class="text-line"
						name="AT_password" size="21" value="<%= at_password%>"
						maxlength="20"> &nbsp;&nbsp;&nbsp;&nbsp;<span style="color:#606060">(字母和数字组合，长度8--20)
					</span></td>
				</tr>
				<tr class="line-odd">
					<td width="15%" align="right"><span style="color:red">*</span>姓名：</td>
					<td width="85%"><input name="AT_realname" size="20" class="text-line"
						value="<%= at_realname%>"  maxlength="20">
					&nbsp;&nbsp;&nbsp;&nbsp;<span style="color:#606060">(可以用字母和数字组合，长度不超过20个，汉字不超过10个)
					</span></td>
				</tr>
				<tr class="line-odd">
					<td width="15%" align="right">昵称：</td>
					<td width="85%"><input name="AT_nickname" size="20" class="text-line"
						value="<%= at_nickname%>" maxlength="20"> &nbsp;&nbsp;&nbsp;&nbsp;<span
						style="color:#606060">(可以用字母和数字组合，长度不超过20个，汉字不超过10个) </span></td>
				</tr>
				
				<tr class="line-odd">
					<td width="15%" align="right"><span style="color:red">*</span>用户：</td>
					<td width="85%">
					<input name="AT_orgname" size="20" readonly="true" treeType="Dept" isSupportMultiSelect="1" 
					   value="<%= at_orgname%>" onBlur="setOrgManage(this)" onclick="chooseTree('AT_orgname');" class="text-line" maxlength="20">
					&nbsp;&nbsp;&nbsp;&nbsp;
					<input class="bttn" value="选择用户" type="button" onclick="chooseTree('AT_orgname');" 
					   size="10" id="button1" onBlur="setOrgManage(this)" name="button1">
					<input type="hidden" name="AT_orgnameDirIds" value="<%=dt_id%>">
               		<input type="hidden" name="AT_orgnameFileIds" value>
					</td>
					
				</tr>
				<tr class="line-odd">
					<td width="15%" align="right"><span style="color:red">*</span>权限：</td>
					<td width="85%">
					<input name="AT_module" size="20" readonly="true" treeType="Module" isSupportMultiSelect="1" 
						value="<%= at_module%>" onclick="chooseTree('AT_module');" class="text-line" maxlength="20">
					&nbsp;&nbsp;&nbsp;&nbsp;
					<input class="bttn" value="选择权限" type="button" onclick="chooseTree('AT_module');"
					    size="10" id="button11" name="button11">
					<input type="hidden" name="AT_moduleDirIds" value="<%=module_id%>">
               		<input type="hidden" name="AT_moduleFileIds" value>
					</td>
					
				</tr>
				<tr class="line-odd">
					<td width="15%" align="right"><span style="color:red">*</span>栏目：</td>
					<td width="85%">
					<input name="AT_subject" size="20" readonly="true" treeType="Subject" isSupportMultiSelect="1" 
					    value="<%= at_subject%>" onclick="chooseTree('AT_subject');" class="text-line" maxlength="20">
					&nbsp;&nbsp;&nbsp;&nbsp;
					<input class="bttn" value="选择栏目" type="button" onclick="chooseTree('AT_subject');" 
					   size="10" id="button12" name="button12">
					<input type="hidden" name="AT_subjectDirIds" value="<%=subject_id%>">
               		<input type="hidden" name="AT_subjectFileIds" value>
					</td>
					
				</tr>
				<tr class="line-odd">
					<td width="15%" align="right"><span style="color:red">*</span>后台权限：</td>
					<td width="85%">
					 <input type="checkbox" name="AT_managelvl" value="0" <%= at_managelvl.indexOf("0") != -1 ? "checked" :""%>>权限管理 
					 <input type="checkbox" id="at_orgManage" disabled="true" name="AT_managelvl" value="1" <%= at_managelvl.indexOf("1") != -1 ? "checked" :""%>>用户管理 
					 <input type="checkbox" name="AT_managelvl" value="2" <%= at_managelvl.indexOf("2") != -1 ? "checked" :""%>>数据字典 
					 <input type="checkbox" name="AT_managelvl" value="3" <%= at_managelvl.indexOf("3") != -1 ? "checked" :""%>>角色管理 
					 <input type="checkbox" name="AT_managelvl" value="4" <%= at_managelvl.indexOf("4") != -1 ? "checked" :""%>>模块管理 
					 <input type="checkbox" name="AT_managelvl" value="5" <%= at_managelvl.indexOf("5") != -1 ? "checked" :""%>>系统配置 
					 <input type="checkbox" name="AT_managelvl" value="6" <%= at_managelvl.indexOf("6") != -1 ? "checked" :""%>>系统日志  
					</td>
					
				</tr>
				<tr class="line-odd">
					<td width="15%" align="right">IC卡号：</td>
					<td width="85%"><input name="AT_ic" size="20" value="<%= at_ic%>" class="text-line" maxlength="20"></td>
				</tr>
				<tr class="line-even">
					<td width="15%" align="right"><span style="color:red">*</span>是否启用：</td>
					<td width="85%">
						<INPUT type="radio" name=AT_isactive <%= ("1".equals(at_isactive)) ? "checked" : ""%> value=1 >是 
						<INPUT type="radio" name=AT_isactive <%= ("0".equals(at_isactive)) ? "checked" : ""%> value=0 >否
					</td>
				</tr>
				<tr class="line-odd">
					<td width="15%" align="right">描述：</td>
					<td width="85%"><input class="text-line" class="text-line"
						name="AT_remark" size="20" value="<%= at_remark%>" maxlength="50"></td>
				</tr>
				</table>
				</td>
			</tr>
			<tr class="title1">
		 		<td width="100%" align="right" colspan="2">
		      		<p align="center">
		      		<input class="bttn" value="提交" type="button" onclick="doOK('<%= operate%>')" size="6" id="button2" name="button2">&nbsp;
		      		<input class="bttn" value="返回" type="button" onclick="doBack('<%=at_loginname%>')" size="6" >&nbsp;
		      		</p>
		      	</td>
		      </tr>
		</table>
		</td>
	</tr>
	

</table>
</form>

<script language="javascript">
function doOK(type){
	if(check()){
		if(type == "ADD"){
			formData.action="adminInfoResult.jsp?type=ADD";
		}else if(type == "UPD"){
			formData.action="adminInfoResult.jsp?type=UPD";
		}
		formData.submit() ;
	}
}
function doBack(at_loginname){
	window.location='adminList.jsp';
} 

function check()
{
  
  if(formData.AT_loginname.value=="")
  {
    alert("请输入注册名");
    formData.AT_loginname.focus();
    return false;
  }
  else
  {
    var login_name=formData.AT_loginname.value+"";

    if(""=="administrator" || ""=="system" || ""=="audit")
          {}
    else
    {
      if(login_name.toLowerCase()=="administrator" || login_name.toLowerCase()=="system" || login_name.toLowerCase()=="audit")
      {
        alert("您不能使用系统注册名！");
        formData.AT_loginname.focus();
        return false;
      }
    }
  }

  //不能用系统管理员名

  //
  if(formData.AT_realname.value=="")
  {
    alert("请输入姓名");
    formData.AT_realname.select();
    return false;
  }

  if(formData.AT_realname.value.search('系统管理员')!=-1)
  {
    alert("不能用系统管理员名！");
    formData.AT_realname.select();
    return false;
  }

  if(formData.AT_password.value=="")
  {
    alert("请输入密码");
    formData.AT_password.focus();
    return false;
  }

   //if(formData.AT_orgname.value=="")
  //{
  //  alert("请选择用户");
  //  formData.AT_orgname.focus();
  //  return false;
 // }

   if(formData.AT_module.value=="")
  {
    alert("请选择权限");
    formData.AT_module.focus();
    return false;
  }

   if(formData.AT_subject.value=="")
  {
    alert("请选择栏目");
    formData.AT_subject.focus();
    return false;
  }
  
  if(getManageLvl() == ""){
	 alert("请选择后台权限");
     return false;
  }
  if(formData.AT_password.value.length<8)
  {
    alert("密码长度不能小于8");
    formData.AT_password.focus();
    return false;
  }
  if(formData.AT_orgname.value=="")
  	  formData.at_orgManage.checked=false;
  return true;
}

function setOrgManage(obj){
	var value = obj.value;
	if(value != ""){
		document.formData.at_orgManage.checked=true;
	}else{
		document.formData.at_orgManage.checked=false;
	}
}

function getManageLvl(){
	var list = document.getElementsByName("AT_managelvl");
	var obj;
	var managelvl ="";
	for( k = 0; k < list.length;k++){
		obj = list[k];
		if(obj.checked){
			managelvl +=obj.value + ",";
		}

	}
	document.forms[0].at_managelvlH.value=managelvl;
	return managelvl;
}
//-->
</script>
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