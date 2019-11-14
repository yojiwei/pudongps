<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="../head.jsp" %>
<%@ page import="com.platform.CManager"%>
<script LANGUAGE="javascript" src="/system/common/treeview/chooseTreeJs.jsp"></script>
<%
	String title="";
	String list_id="";
	String dd_id="";
	String sql="";
	String dt_name="";//部门名称
	String dt_iswork="0";//活动标志
	String dt_operid = "";//组织机构代码
	String dt_deskoperid = "";//统一授权机构代码
	String dt_shortname = "";//部门名称简写
	String dt_custodyflag = "";//是否为监管部门　1为是，0或NULL为非
	String dt_payaddress = "";//信息公开缴费地址
	String dt_infoopendept = "";//是否为信息公开受理、转办单位


	list_id=CTools.dealNumber(request.getParameter("list_id")).trim();
	dd_id=CTools.dealNumber(request.getParameter("dd_id")).trim();

	//CManager manage = (CManager)session.getAttribute("manager");
	//String orgname = manage.getAtOrgname();//用户模块

//update20080122

CDataCn dCn=null;   //新建数据库连接对象
CDataImpl dImpl=null;  //新建数据接口对象

try {
 dCn = new CDataCn(); 
 dImpl = new CDataImpl(dCn); 

        sql="select dt_name from tb_deptinfo where dt_id=" + list_id;
        Hashtable content1=dImpl.getDataInfo(sql);
        String Module_name=CTools.dealNull(content1.get("dt_name"));

        if (dd_id.equals("0"))
			{ //新增状态
			  title  = "新增部门";
		    }
		else
			{ //显示、修改
			  title = "修改部门";
			  sql="select * from tb_deptinfo where dt_id=" + dd_id;
			  Hashtable content=dImpl.getDataInfo(sql);
			  dt_name=content.get("dt_name").toString();
			  dt_iswork=content.get("dt_iswork").toString();
			  dt_shortname=content.get("dt_shortname").toString();
			  dt_operid=content.get("dt_operid").toString();
			  dt_deskoperid = CTools.dealNull(content.get("dt_deskoperid"));
			  dt_custodyflag=content.get("dt_custodyflag").toString();
			  dt_payaddress=content.get("dt_payaddress").toString();
			  dt_infoopendept=content.get("dt_infoopendept").toString();
			}
	//out.print(dd_id);
dt_shortname = dt_shortname.trim();
dt_custodyflag = dt_custodyflag.trim();

if(dt_custodyflag.equals("")) dt_custodyflag = "0";




        sql="select tr_id from tb_roleinfo where tr_type=5 and tr_userids='," + dd_id+",'";
        Hashtable content2=dImpl.getDataInfo(sql);
        String tr_id="-1";
		if(content2!=null) 
			tr_id=CTools.dealNull(content2.get("tr_id"));
		else
		{			
			CRoleInfo jdo = new CRoleInfo(dCn);
			tr_id = new String().valueOf(jdo.addNew());
			jdo.setValue("tr_type","5",jdo.INT );
			jdo.setValue("tr_name",dt_name,jdo.STRING);
			jdo.setValue("tr_detail","Department",jdo.STRING);
			jdo.setValue("tr_level","5",jdo.INT );
			jdo.setValue("tr_createby","admin",jdo.STRING);
			jdo.setValue("tr_userids",","+dd_id+",",jdo.STRING);
			jdo.setValue("dt_id",dd_id,jdo.INT );
			jdo.update() ;
			jdo.closeStmt();
		}

		session.setAttribute("_platform_tr_name",dt_name);

  //CDeptList i = new CDeptList(dCn);
  //String strSelectddid = i.getListByParentID(0,list_id,orgname);
  //i.closeStmt();

%>


<table class="main-table" width="100%">
<tr>
<td>
<form action="deptInfoResult.jsp" method="post" name="formData">
<div align="center">
    <table border="0" width="100%" cellpadding="0" cellspacing="0">
	  <tr>
	   <td width="100%" align="left" colspan="4">
		 <table width="100%" cellpadding="3" cellspacing="0">
		  <tr class="bttn" height="4">
			<td id="TitleTd" width="100%" align="left"><%=title%>&nbsp;<!--a href=../role/roleSubjectInfo.jsp?tr_id=<%=tr_id%>>维护权限</a--></td>
			<td valign="top" align="right" nowrap>
			<img src="/system/images/dialog/split.gif" align="middle" border="0">

			<img src="/system/images/dialog/return.gif" border="0" onclick="window.location='userList.jsp?list_id=<%=list_id%>'" title="返回" style="cursor:hand" align="absmiddle" id="image3" name="image3" WIDTH="14" HEIGHT="14">
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
	  	    <td width="25%" align="right">部门名称：</td>
	  	    <td width="75%"><input class="text-line" name="dd_name" size="20" value="<%=dt_name %>" maxlength="20"></td>
	  	  </tr>
	  	  <tr class="line-even">
	  	    <td width="25%" align="right">部门名称简写：</td>
	  	    <td width="75%"><input class="text-line" name="dt_shortname" size="20" value="<%=dt_shortname%>" maxlength="20"></td>
	  	  </tr>
	  	  <tr class="line-even">
	  	    <td width="25%" align="right">组织机构代码：</td>
	  	    <td width="75%"><input class="text-line" name="dt_operid" size="20" value="<%=dt_operid%>" maxlength="20"></td>
	  	  </tr>
		  <tr class="line-even">
	  	    <td width="25%" align="right">统一授权机构代码：</td>
	  	    <td width="75%"><input class="text-line" name="dt_deskoperid" size="20" value="<%=dt_deskoperid%>" maxlength="20"></td>
	  	  </tr>
	  	  <tr class="line-odd">
	  	    <td width="25%" align="right">上级部门：</td>
	  	    <td width="75%">
         <input type="text" name="Module" class="text-line" treeType="Dept" value="<%=Module_name%>" treeTitle="选择所属部门" readonly isSupportFile="0" onclick="chooseTree('Module');">
         <input type=button  title="选择所属部门" onclick="chooseTree('Module');" class="bttn" value=选择...>
         <input type="hidden" name="ModuleDirIds" value="<%=list_id%>">
         <input type="hidden" name="ModuleFileIds" value>
         <input type="hidden" name="dt_id" value="<%=list_id%>">
          </td>
	  	  </tr>
	  	  <tr class="line-even">
	  	    <td width="25%" align="right">信息公开缴费地址：</td>
	  	    <td width="75%"><input class="text-line" name="dt_payaddress" size="20" value="<%=dt_payaddress %>" maxlength="20"></td>
	  	  </tr>
	  	  <tr class="line-odd">
	  	    <td width="25%" align="right">信息公开受理、转办单位：</td>
	  	    <td width="75%">
	  	    <INPUT type="radio" name=dt_infoopendept value=1 <%if (dt_infoopendept.equals("1")) out.print("checked");%>>是
	  	    <INPUT type="radio" name=dt_infoopendept value=0 <%if (dt_infoopendept.equals("0")) out.print("checked");%>>否
	  	    </td>
	  	  </tr>
	  	  <tr class="line-even">
	  	    <td width="25%" align="right">是否前台显示：</td>
	  	    <td width="75%">
	  	    <INPUT type="radio"  name=dt_iswork value=1 <%if (dt_iswork.equals("1")) out.print("checked");%>>是
	  	    <INPUT type="radio"  name=dt_iswork value=0 <%if (dt_iswork.equals("0")) out.print("checked");%>>否
	  	    </td>
	  	  </tr>

			<tr class="line-odd">
	  	    <td width="25%" align="right" nowrap>是否为监管部门：</td>
	  	    <td width="75%">
			<INPUT type="radio"  name="dt_custodyflag1" value="1" <%if (dt_custodyflag.equals("1")) out.print("checked");%> onclick="formData.dt_custodyflag.value='1';">是
	  	    <INPUT type="radio"  name="dt_custodyflag1" value="0" <%if (dt_custodyflag.equals("0")) out.print("checked");%> onclick="formData.dt_custodyflag.value='0';">否
			<input type=hidden name="dt_custodyflag" value="<%=dt_custodyflag%>">
			</td>
	  	  </tr>
	  	</table>
        </td>
      </tr>
		<tr class="title1">
		  <td width="100%" align="right" colspan="2">
		      <p align="center">
		  	<%  if (dd_id.equals("0")){ //新增界面 %>
		  			<input class="bttn" value="提交" type="button" onclick="check()" size="6" id="button2" name="button2">&nbsp;
					<INPUT TYPE="hidden" name="OPType" value="Add">
		  	<%  }else{ 	%>
		  			<input class="bttn" value="修改" type="button" onclick="check()" size="6" id="button4" name="button4">&nbsp;
						<input class="bttn" value="删除" type="button" onclick="javascript:delDept()" size="6" id="button4" name="button4">&nbsp;
					<INPUT TYPE="hidden" name="OPType" value="Edit">
		  	<%  }	%>
                            <input class="bttn" value="返回" type="button" onclick="history.back();" size="6" >&nbsp;

		    </td>
		</tr>
    </table>
</div>
<input type="hidden" name="dd_id" value="<%=dd_id%>">


</form>
</td>
</tr>
</table>
<script LANGUAGE="javascript">
<!--
	function onChange()
	{}
	function check()
	{
		if(formData.dd_name.value=="")
		{
			alert("部门名称不能为空！");
			formData.dd_name.focus()
			return false;
		}
		//alert(formData.dt_custodyflag.value);
		if( (formData.dt_custodyflag.value=="1") && (formData.dt_shortname.value=="") )
		{
			alert("部门名称简写不能为空！");
			formData.dt_shortname.focus()
			return false;
		}
                formData.dt_id.value=formData.ModuleDirIds.value;
		var form = document.formData ;
		form.submit() ;
	}

	function delDept()
	{
		if(confirm("删除部门前，请确认是否下属还有用户，以及该部门受理的相关项目\n\n是否确认要删除该部门！！！"))
		{
			formData.action="deptDel.jsp";
			formData.submit();
			//alert("del");
		}
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