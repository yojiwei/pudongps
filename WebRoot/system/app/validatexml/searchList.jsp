<%@page contentType="text/html; charset=GBK"%>
<%@include file="/system/app/skin/head.jsp"%>
<%@ page import="com.beyondbit.web.publishinfo.Messages" %>
<script LANGUAGE="javascript" src="./common/common.js"></script>
<%
String strTitle = "查询结果";
CDataCn dCn = null;
CDataImpl dImpl = null;
try{
dCn = new CDataCn();
dImpl = new CDataImpl(dCn);
String get_us_uid="";//用户登录名
get_us_uid=CTools.dealString(request.getParameter("us_uid")).trim();
String get_ec_name = "";//单位名称
get_ec_name = CTools.dealString(request.getParameter("ec_name")).trim();
String get_ec_corporation   = "";//法人代表
get_ec_corporation = CTools.dealString(request.getParameter("ec_corporation")).trim();

String sWhere="";
String strSql="";

if (!get_us_uid.equals(""))
	{
		sWhere += " and u.us_uid like '%" + get_us_uid + "%'";
	}
if (!get_ec_name.equals(""))
	{
		sWhere += " and e.ec_name like '%" + get_ec_name + "%'";
	}
if (!get_ec_corporation.equals(""))
	{
		sWhere += " and e.ec_corporation like '%" + get_ec_corporation + "%'";
	}
strSql = "select u.us_uid,e.ec_name,e.ec_corporation,x.el_id,x.el_type from tb_enterpvisc e, tb_user u ,tb_entemprvisexml x where e.us_id = u.us_id and x.ec_id= e.ec_id and e.ec_name is not null  " + sWhere + " order by to_number(substr(u.us_id,2)) desc";
Vector vectorPage = dImpl.splitPageOpt(strSql,request,15);
%>
<%@include file="/system/app/skin/skin4/template/list_top.jsp"%>
<!--    模块名称开始    -->
<%=strTitle%>
<!--    模块名称结束    -->
<%@include file="/system/app/skin/skin4/template/list_function.jsp"%>                                                            
<!--    功能按钮开始    -->
<img src="/system/images/menu_about.gif" border="0" onclick="javascript:window.location.href='search.jsp'" title="查找" style="cursor:hand" align="absmiddle">
查找              
<!--    功能按钮结束    -->
<%@include file="/system/app/skin/skin4/template/list_listtop.jsp"%>                                                                                        
<!--    列表开始    -->
<table class="FindAreaTable1" cellspacing="1" rules="cols" border="0" id="ctl00_DataGrid_DataGrid1" style="border-width:0px;">
<form name="formData">
  <tr class="bttn">
     <td width="40%" class="outset-table">单位名称</td>
     <td width="20%" class="outset-table">法人代表</td>
     <td width="20%" class="outset-table">登录名</td>
     <td width="10%" class="outset-table">是否已审核</td>
     <td width="10%" class="outset-table" nowrap>编辑</td>
  </tr>
<%
  if(vectorPage!=null)
  {
    for(int j=0;j<vectorPage.size();j++)
    {
      Hashtable content = (Hashtable)vectorPage.get(j);
			  String el_id = content.get("el_id").toString();
			  String us_uid = content.get("us_uid").toString();
			  String el_type = content.get("el_type").toString();
			  String ec_name = content.get("ec_name").toString();
			  String ec_corporation = content.get("ec_corporation").toString();
			  String ec_audlt = "";
			  String url = "";
			  String updateUrl = "";
			  if(el_type.equals("0")){
				  ec_audlt = "<font color='#FF0000'>未审核</font>";
					url = "<A HREF='info.jsp?el_id="+el_id+"&typeod=s'>审核</A>";
			  }else{
				  ec_audlt = "已审核";
					url = "<A HREF='info.jsp?el_id="+el_id+"&typeod=c'>查看</A>";
			  }
			  updateUrl = "<A HREF='update.jsp?el_id="+el_id+"&typeod=c'>修改单位名称</A>";
%>
			<tr width="100%" <%if(j%2==0) out.print("class='line-even'");else out.print("class='line-odd'");%>>
         <td ><%=ec_name%></td>
         <td ><%=ec_corporation%></td>
         <td ><%=us_uid%></td>
         <td ><%=ec_audlt%></td>
         <td  nowrap><%=url%>&nbsp;&nbsp;<%=updateUrl%></td>
       </tr>
<%
    }
%>
</form>
<%
  }
  else
  {
    out.println("<tr><td colspan=17>没有记录！</td></tr>");
  }
%>
</table>
<script LANGUAGE="javascript">
	function onChange()
	{
		var sj_id;
		var audit;
    sj_id=formData.sj_id.value;
    audit=formData.audit.value;
		formData.action='publishList.jsp?sj_id='+sj_id+'&audit='+audit;
		formData.submit();
	}
function setSequence()
{
	document.formData.action = "setSequence.jsp";
	document.formData.submit();
}

function delcontent(ctId){
var objhttpPending=new ActiveXObject("Msxml2.XMLHTTP");
	var objxmlPending =	objxmlPending=new ActiveXObject("Microsoft.XMLDOM");
		
		strA = "abc"
		
		objhttpPending.Open("post","<%=Messages.getString("xmlHttp")%>/system/app/infopublish/delete.jsp?ct_id=" + ctId ,true);
		objhttpPending.setRequestHeader("Content-Length",strA.length);
		objhttpPending.setRequestHeader("CONTENT-TYPE","application/x-www-form-urlencoded");
		
		
		
		objhttpPending.onreadystatechange = function (){
			var statePending = objhttpPending.readyState; 
		    if (statePending == 4)
		    {
		    	var returnvalue = objhttpPending.responsetext;
		    	alert(returnvalue);
		    	if(returnvalue.indexOf("yes")!=-1){
		    		document.location.reload();
		    	}
			}
		};
		objhttpPending.Send(strA);
}
</script>
<!--    列表结束    -->
<%@include file="/system/app/skin/skin4/template/list_bottom.jsp"%> 
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