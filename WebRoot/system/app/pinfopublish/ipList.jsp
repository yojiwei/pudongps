<%@page contentType="text/html; charset=GBK"%>
<%@ page import="com.beyondbit.web.publishinfo.Messages" %>
<script LANGUAGE="javascript" src="./common/common.js"></script>
<%
String strTitle = "IP地址配置";

%>
<%@include file="/system/app/skin/head.jsp"%>
<%
CDataCn dCn = null;
CDataImpl dImpl = null;
try{
dCn = new CDataCn();
dImpl = new CDataImpl(dCn);

String sj_id="";//栏目id
sj_id=CTools.dealNumber(request.getParameter("sj_id")).trim();
String selDt_id = "";//部门id
selDt_id = CTools.dealString(request.getParameter("dt_id")).trim();
String dt_id   = "";
String dt_name = "";
String dtSql   = "";
String isadmin = CTools.dealString(request.getParameter("isadmin"));
String sjName1 = CTools.dealString(request.getParameter("sjName1"));
//dtSql = "select dt_id,dt_name from tb_deptinfo where 1=1 order by dt_sequence,dt_id desc";
//Vector dtList  = dImpl.splitPage(dtSql,100,1);


/*得到当前登陆的用户id  开始*/
String uiid="";
CMySelf myProject = (CMySelf)session.getAttribute("mySelf");
if(myProject!=null && myProject.isLogin()){
	uiid = Long.toString(myProject.getMyID());
}else{
	uiid= "2";
}

/*得到当前登陆的用户id  结束*/

String strSql = "select il_id,il_status,il_begin,il_end,il_date from tb_iplist" ;

Vector vectorPage = dImpl.splitPageOpt(strSql,request,20);
%>
<%@include file="/system/app/skin/skin4/template/list_top.jsp"%>
<!--    模块名称开始    -->
<%=strTitle%>
<!--    模块名称结束    -->
<%@include file="/system/app/skin/skin4/template/list_function.jsp"%>                                                            
<!--    功能按钮开始    -->
<img src="/system/images/new.gif" border="0" onclick="window.location='ipInfo.jsp?OPType=Add'" title="新增信息" style="cursor:hand" align="absmiddle" WIDTH="16" HEIGHT="16">新增信息
<img src="/system/images/goback.gif" border="0" onclick="javascript:history.back();" title="返回" style="cursor:hand" align="absmiddle">返回
<!--    功能按钮结束    -->
<%@include file="/system/app/skin/skin4/template/list_listtop.jsp"%>                                                                                        
<!--    列表开始    -->
<table class="FindAreaTable1" cellspacing="1" rules="cols" border="0" id="ctl00_DataGrid_DataGrid1" style="border-width:0px;">
		<form name="formData">
        <tr class="bttn">
            <td width="10%" class="outset-table">&nbsp;</td>
            <td width="40%" class="outset-table">起始地址</td>
            <td width="40%" class="outset-table">结束地址</td>
            <td width="10%" class="outset-table" nowrap>操作</td>
        </tr>
<%
  if(vectorPage!=null)
  {
    for(int j=0;j<vectorPage.size();j++)
    {
      Hashtable content = (Hashtable)vectorPage.get(j);
      String il_id = content.get("il_id").toString();
	    String il_begin = content.get("il_begin").toString();
	    String il_end = content.get("il_end").toString();
	    String il_status = content.get("il_status").toString();
	    String il_date = content.get("il_date").toString();

      if(j % 2 == 0)  out.print("<tr class=\"line-even\">");
      else out.print("<tr class=\"line-odd\">");
%>

                <td ><%=j+1%></td>
                <td align="center" nowrap><%=content.get("il_begin")%></td>
                <td align=center nowrap><%=content.get("il_end")%></td>
                <td align="center" nowrap><a href="ipInfo.jsp?OPType=Edit&il_id=<%=content.get("il_id")%>"><img class="hand" border="0" src="/system/images/modi.gif" title=编辑 WIDTH="16" HEIGHT="16"></a>
								&nbsp;
								<a href="/system/app/pinfopublish/delete.jsp?il_id=<%=il_id%>">
								<img class="hand" border="0" src="../../images/delete.gif" title="删除" WIDTH="16" HEIGHT="16" onclick="return window.confirm('确认要删除该记录么?');"></a>
								</td>
            </tr>

<%
    }
%>
</form>
<%
    
  }
  else
  {
    out.println("<tr><td colspan=7>没有记录！</td></tr>");
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
	//var form = document.formData ;
	document.formData.action = "setSequence.jsp";
	document.formData.submit();
}

function delcontent(ilId){
var objhttpPending=new ActiveXObject("Msxml2.XMLHTTP");
	var objxmlPending =	objxmlPending=new ActiveXObject("Microsoft.XMLDOM");
		strA = "abc"

		objhttpPending.Open("post","<%=Messages.getString("xmlHttp")%>/system/app/pinfopublish/delete.jsp?il_id=" + ilId ,true);
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
	System.out.print(e.toString());
}
finally{
	dImpl.closeStmt();
	dCn.closeCn(); 
}
%>
<%@include file="/system/app/skin/bottom.jsp"%>