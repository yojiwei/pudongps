<%@page contentType="text/html; charset=GBK"%>
<%@include file="/system/app/skin/head.jsp"%>
<%
CDataCn dCn=null;   //新建数据库连接对象
CDataImpl dImpl=null;  //新建数据接口对象

try {
 dCn = new CDataCn(); 
 dImpl = new CDataImpl(dCn); 
String el_id="";
String typeod = "";
el_id=CTools.dealString(request.getParameter("el_id")).trim();
typeod=CTools.dealString(request.getParameter("typeod")).trim();
 CMySelf myselfmain = (CMySelf)session.getAttribute("mySelf");	
 String dt_id =String.valueOf(myselfmain.getDtId()); 
String strTitle = "";
String us_uid = "";
String ec_name = "";
String ec_enroladd = "";
String ec_corporation = "";
String ec_enrolzip = "";
String ec_produceadd = "";
String ec_producezip = "";
String ec_mgr = "";
String ec_linkman = "";
String ec_fax = "";
String ec_email = "";
String el_type = "";
String us_id= "";
String pp_id="";
String us_nameen = "";

String pp_value = "";

if(!el_id.equals("")){
String sql = "select u.us_id, u.us_uid,u.us_nameen,e.ec_name,e.ec_enroladd,e.ec_enrolzip,e.ec_corporation,e.ec_produceadd,e.ec_producezip,e.ec_mgr,e.ec_linkman,e.ec_fax,e.ec_email,x.el_id,x.el_type,x.pp_id,p.pp_value from tb_enterpvisc e, tb_user u ,tb_entemprvisexml x,tb_passport p  where p.pp_typeid=x.pp_id and e.us_id = u.us_id and x.ec_id= e.ec_id and x.el_id ="+el_id+"";


//out.println(sql);
Hashtable map = dImpl.getDataInfo(sql);
us_uid =map.get("us_uid").toString();
us_nameen = map.get("us_nameen").toString();;
us_id =map.get("us_id").toString();
ec_name =map.get("ec_name").toString();
ec_corporation =map.get("ec_corporation").toString();
ec_enroladd =map.get("ec_enroladd").toString();
ec_enrolzip =map.get("ec_enrolzip").toString();
ec_produceadd =map.get("ec_produceadd").toString();
ec_producezip =map.get("ec_producezip").toString();
ec_mgr =map.get("ec_mgr").toString();
ec_linkman =map.get("ec_linkman").toString();
ec_fax =map.get("ec_fax").toString();
ec_email =map.get("ec_email").toString();
el_id =map.get("el_id").toString();
el_type =map.get("el_type").toString();
pp_id =map.get("pp_id").toString();
pp_value =map.get("pp_value").toString();
if(!el_type.equals("0")){
strTitle ="查看用户";
}
}
%>
<script language="JavaScript" type="text/JavaScript">
<!--

function MM_jumpMenu(targ,selObj,restore){ //v3.0
	var SesValue=selObj.options[selObj.selectedIndex].value;
	var	from=document.formdate
	if(SesValue=="0"){
	from.textarea.value="";
	}else if(SesValue=="1"){
	from.textarea.value="您申请的 <%=pp_value%> ，不能通过，请重新申请。";
	
	}else if(SesValue=="2"){
	
	from.textarea.value="您申请的 <%=pp_value%> ，资料不全，请补全资料。请进入验证资料中修改。";
	}else if(SesValue=="3"){
	
	from.textarea.value="申请的 <%=pp_value%> ，申请成功。";
	}
}
//-->
</script>
<%@include file="/system/app/skin/skin4/template/info_top.jsp"%>
<!--    模块名称开始    -->
用户基本资料
<!--    模块名称结束    -->
<%@include file="/system/app/skin/skin4/template/info_funtion.jsp"%>
<!--    功能按钮开始    -->

<!--    功能按钮结束    -->
<%@include file="/system/app/skin/skin4/template/info_main.jsp"%>
<!--    表单提交开始    -->
<FORM METHOD=POST ACTION="Result.jsp" name='formdate'>
<table class="main-table" width="100%">
		<tr class="bttn">
       <td colspan="2" align="center">用户基本资料</td>        
     </tr>  
     <tr class="line-even">
       <td width="40%"align="center">登陆帐号</td>
       <td width="60%"><%=us_uid%></td>
     </tr>        
		<tr class="line-odd">
       <td width="40%" align="center">企业名称</td>
       <td width="60%"><%=ec_name%><INPUT TYPE="hidden" name = "ec_name" value="<%=ec_name%>"></td>
     </tr>      
		<tr class="line-odd">
       <td width="40%" align="center">企业英文名称</td>
       <td width="60%"><%=us_nameen%><INPUT TYPE="hidden" name = "us_nameen" value="<%=us_nameen%>"></td>
     </tr>
     <tr class="line-even">
       <td width="40%"align="center">注册地址</td>
       <td width="60%"><%=ec_enroladd%></td>
     </tr>        
 		<tr class="line-odd">
       <td width="40%" align="center">注册邮编</td>
       <td width="60%"><%=ec_enrolzip%></td>
     </tr>
     <tr class="line-even">
       <td width="40%"align="center">注册法人代表</td>
       <td width="60%"><%=ec_corporation%></td>
     </tr>        
 		<tr class="line-odd">
       <td width="40%" align="center">办公/生产地址</td>
       <td width="60%"><%=ec_produceadd%></td>
     </tr>
     <tr class="line-even">
       <td width="40%"align="center">办公/生产邮编</td>
       <td width="60%"><%=ec_producezip%></td>
     </tr>        
 		<tr class="line-odd">
       <td width="40%" align="center">总经理/负责人</td>
       <td width="60%"><%=ec_mgr%></td>
     </tr>
     <tr class="line-even">
       <td width="40%"align="center">联系方式</td>
       <td width="60%"><%=ec_linkman%></td>
     </tr>        
 		<tr class="line-odd">
       <td width="40%" align="center">传真号码</td>
       <td width="60%"><%=ec_fax%></td>
     </tr>
     <tr class="line-even">
       <td width="40%"align="center">Email</td>
       <td width="60%"><%=ec_email%></td>
     </tr> 
 		<tr class="bttn">
       <td colspan="2" align="center">用户验证资料</td>        
     </tr>  
		<tr class="line-odd">
       <td colspan="2" align="center"><A HREF="TableDisPlay.jsp?el_id=<%=el_id%>&pp_id=<%=pp_id%>" target="_blank">浏览用户验证资料</A></td>        
     </tr> 

  	<tr class="bttn">
       <td colspan="2" align="center">用户验证</td>        
     </tr>  
		<tr class="line-even">
       <td width="40%"align="center">验证状态</td>
       <td width="60%">
	   <%
		if(el_type.equals("0")){
	   %>
	   <select name="el_type"  onChange="MM_jumpMenu('parent',this,0)">
					  <option value="0" selected>未验证</option>
					  <option value="1" >不通过</option>
					  <option value="2" >修改</option>
					  <option value="3" >通过</option>
			</select>
			<%
			}else{
				if(el_type.equals("1")){
					out.println("不通过");
				}
				if(el_type.equals("2")){
					out.println("修改");
				}
				if(el_type.equals("3")){
					out.println("通过");
				}
			}
			%>
	</td>
     </tr> 
 		<tr class="line-odd">
       <td  width="40%" align="center">状态说明</td>  
   <td width="60%"><textarea name="textarea" cols="50" rows="8"></textarea></td>
     </tr>
  	<tr class="bttn">
       <td colspan="2" align="center">用户可申请项目</td>        
     </tr> 

 	<tr class="line-even">
       <td  width="40%" align="center">可申请的项目</td>  
   <td width="60%" align="left"> 
   <%
	 String pr_sql = "select pr_id ,pr_name from tb_proceeding where dt_id="+dt_id+"";
	 Vector vectorPage = dImpl.splitPage(pr_sql,10000,1);
	 if(vectorPage!=null){
		for(int i = 0 ; i<vectorPage.size();i++){
		Hashtable map = (Hashtable)vectorPage.get(i);
		String pr_id = map.get("pr_id").toString();
		String pr_name = map.get("pr_name").toString();
		String up_sql= "select up_id from tb_user_proc where pr_id='"+pr_id+"' and  us_id='"+us_id+"'";
		Hashtable upmap=dImpl.getDataInfo(up_sql);
		if(upmap!=null){
			out.println("<INPUT TYPE='checkbox' NAME='pr_id' value='"+pr_id+"' checked>"+pr_name+"<br>");	
		}else{
			out.println("<INPUT TYPE='checkbox' NAME='pr_id' value='"+pr_id+"'>"+pr_name+"<br>");
	}
	}
 }
 %></td>
     </tr>
 		<tr class="outset-table">
    <td colspan="2" align="center">
	   <INPUT TYPE="hidden" name = "dt_id" value="<%=dt_id%>" >
	   <INPUT TYPE="hidden" name = "us_id" value="<%=us_id%>" >
	   <INPUT TYPE="hidden" name = "pp_id" value="<%=pp_id%>" >
	   <INPUT TYPE="hidden" name = "pp_value" value="<%=pp_value%>" >
   <%
   String submitValue = "";
   String resetValue = "";
   if(typeod.equals("s")){
		submitValue="确认用户验证";
		resetValue="重新验证用户状态";
   }else if(typeod.equals("c")){
		submitValue="修改用户申请";
		resetValue="重置";
   }
   %>
   <INPUT TYPE="hidden" name = "el_id" value="<%=el_id%>" ><INPUT TYPE="submit" class="bttn" value ="<%=submitValue%>"> &nbsp;&nbsp;&nbsp;&nbsp;<INPUT TYPE="reset" class="bttn" value = "<%=resetValue%>"></td>        
   </tr>  
</table>
</FORM>
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
                                     
