<%@page contentType="text/html; charset=GBK"%>
<%@include file="/system/app/skin/head.jsp"%>
<%
String strTitle="修改单位名称" ;

CDataCn dCn = null;
CDataImpl dImpl = null;
try{
dCn = new CDataCn();
dImpl = new CDataImpl(dCn);
//
String el_id="";
el_id=CTools.dealString(request.getParameter("el_id")).trim();
CMySelf myselfmain = (CMySelf)session.getAttribute("mySelf");	
String dt_id =String.valueOf(myselfmain.getDtId()); 

String us_uid = "";
String us_id = "";
String ec_name = "";
String us_nameen = "";				//英文名称
if(!el_id.equals("")){
String sql = "select u.us_id, u.us_uid,u.us_nameen,e.ec_name,e.ec_enroladd,e.ec_enrolzip,e.ec_corporation,e.ec_produceadd,e.ec_producezip,e.ec_mgr,e.ec_linkman,e.ec_fax,e.ec_email,x.el_id,x.el_type,x.pp_id,p.pp_value from tb_enterpvisc e, tb_user u ,tb_entemprvisexml x,tb_passport p  where p.pp_typeid=x.pp_id and e.us_id = u.us_id and x.ec_id= e.ec_id and x.el_id ="+el_id+"";


//out.println(sql);
Hashtable map = dImpl.getDataInfo(sql);
us_uid =map.get("us_uid").toString();
us_id =map.get("us_id").toString();
ec_name =map.get("ec_name").toString();
us_nameen = map.get("us_nameen").toString();
}

//修改单位名称
if(request.getParameter("xiugai") != null){
	String ec_name_new = CTools.dealString(request.getParameter("ec_name_new"));
	String us_nameen_new = CTools.dealString(request.getParameter("us_nameen_new"));
	String us_id_new = request.getParameter("us_id");
	long count = -1;
	String updSql = "update tb_enterpvisc set ec_name = '"+ ec_name_new +"' where us_id = '"+ us_id_new +"'";
	String updUserSql = "update tb_user set us_name = '"+ ec_name_new +"',us_nameen = '" + us_nameen_new + "' where us_id = '"+ us_id_new +"'";
	//out.print(updUserSql);
	if("".equals(ec_name_new)){
	%>
	<script language="JavaScript" type="text/JavaScript">
	<!--
		alert("单位名称不可为空！");
	
	//-->
	</script>
<%}else{
		dImpl.executeUpdate(updSql);
		count = dImpl.executeUpdate(updUserSql);
		if(count == 1){
		%>
			<script language="JavaScript" type="text/JavaScript">
				<!--
					alert("单位名称修改成功！");
					window.location.href='list.jsp';
				//-->
			</script>
			<%
			//response.sendRedirect("list.jsp");
		}else{
			%>
			<script language="JavaScript" type="text/JavaScript">
				<!--
					alert("单位名称修改不成功！");
				//-->
			</script>
			<%
		}
	}
}
%>
<%@include file="/system/app/skin/skin4/template/info_top.jsp"%>
<!--    模块名称开始    -->
<%=strTitle%>
<!--    模块名称结束    -->
<%@include file="/system/app/skin/skin4/template/info_funtion.jsp"%>
<!--    功能按钮开始    -->

<!--    功能按钮结束    -->
<%@include file="/system/app/skin/skin4/template/info_main.jsp"%>
<!--    表单提交开始    -->
<table align="center" width="100%" CELLPADDING="1" cellspacing="1">
<FORM METHOD=POST ACTION="" name='formdate'>		 
	  <tr class="bttn">
       <td colspan="2" align="center"><b>用户基本资料</b></td>        
     </tr>  
     <tr class="line-even">
       <td width="40%"align="center">登陆帐号</td>
       <td width="60%"><%=us_uid%><INPUT TYPE="hidden" name = "us_id" value="<%=us_id%>"></td>
     </tr>        
     <tr class="line-odd">
       <td width="40%" align="center">原企业中文名称</td>
       <td width="60%"><%=ec_name%><INPUT TYPE="hidden" name = "ec_name" value="<%=ec_name%>"></td>
     </tr>
     <tr class="line-even">
       <td width="40%" align="center">新企业中文名称</td>
       <td width="60%" align="left"><INPUT TYPE="text" name = "ec_name_new" value="" size="65"></td>
     </tr>  
     <tr class="line-odd">
       <td width="40%" align="center">原企业英文名称</td>
       <td width="60%"><%=us_nameen%><INPUT TYPE="hidden" name = "us_nameen" value="<%=us_nameen%>"></td>
     </tr>
     <tr class="line-even">
       <td width="40%" align="center">新企业英文名称</td>
       <td width="60%" align="left"><INPUT TYPE="text" name = "us_nameen_new" value="" size="65"></td>
     </tr> 
		 <tr class="outset-table">
       <td colspan="2" align="center">
       	<INPUT TYPE="submit" class="bttn" name="xiugai" value ="修改"> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
       	<INPUT TYPE="reset" class="bttn" value = "重写">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
       	<INPUT TYPE="button" class="bttn" value = "返回" onclick="history.go(-1)">
       </td>
     </tr>
     </FORM>
</table>
<!--    表单提交结束    -->
<%@include file="/system/app/skin/skin4/template/info_bottom.jsp"%> 
<%
}
catch(Exception e){
	System.out.println(new java.util.Date() + "--"
			+ request.getServletPath() + " : " + e.getMessage());
}
finally{
	dImpl.closeStmt();
	dCn.closeCn(); 
}
%>
<%@include file="/system/app/skin/bottom.jsp"%>
                                     
