<%@page contentType="text/html; charset=GBK"%>
<%@include file="/system/app/skin/head.jsp"%>
<%
String strTitle = "信息维护";
CDataCn dCn=null;   //新建数据库连接对象
CDataImpl dImpl=null;  //新建数据接口对象
String in_sequence = "";
String ti_name = "";
String ti_id = "";
try {
 dCn = new CDataCn(); 
 dImpl = new CDataImpl(dCn); 
	
	String strSql = "select ti_id,ti_name,ti_sequence from tb_title where ti_upperid =(select ti_id from tb_title where ti_code = 'pudong_jz') order by ti_sequence desc";
		
	Vector vectorPage = dImpl.splitPage(strSql,request,30);
%>
<%@include file="/system/app/skin/skin4/template/list_top.jsp"%>
<!--    模块名称开始    -->
<%=strTitle%>
<!--    模块名称结束    -->
<%@include file="/system/app/skin/skin4/template/list_function.jsp"%>                                                            
<!--    功能按钮开始    -->
<img src="/system/images/new.gif" border="0" onclick="window.location='leadBoxInfo2.jsp?OPType=Add'" title="新增信息" style="cursor:hand" align="absmiddle" WIDTH="16" HEIGHT="16">
新增信息
<!--img src="/system/images/dialog/sort.gif" border="0" onclick="setSequence();" title="修改排序" style="cursor:hand" align="absmiddle" WIDTH="15" HEIGHT="15">
修改排序-->
<img src="/system/images/goback.gif" border="0" onclick="javascript:history.back();" title="返回" style="cursor:hand" align="absmiddle">
返回   
<!--    功能按钮结束    -->
<%@include file="/system/app/skin/skin4/template/list_listtop.jsp"%>                                                                                        
<!--    列表开始    -->
<table class="FindAreaTable1" cellspacing="1" rules="cols" border="0" id="ctl00_DataGrid_DataGrid1" style="border-width:0px;">
<form name="formData" method="post">
<input type="hidden" value="leadBoxList.jsp" name="returnPage">
  <tr class="bttn">
        <td width="50%" class="outset-table">所属街道</td>
         <td width="10%" class="outset-table">排序</td>
    </tr>
<%
  if(vectorPage!=null)
  {
    for(int j=0;j<vectorPage.size();j++)
    {
      Hashtable content = (Hashtable)vectorPage.get(j);
      in_sequence=content.get("ti_sequence").toString();
      ti_id = content.get("ti_id").toString();
      ti_name = content.get("ti_name").toString();
      if(j % 2 == 0)  out.print("<tr class=\"line-even\">");
      else out.print("<tr class=\"line-odd\">");
%>
    <td align="center"><a href="leadBoxInfo2.jsp?ti_id=<%=ti_id%>"><%=ti_name%></a></td>
    <td align=center><input type=text class=text-line name=<%="module"+ti_id%> value="<%=in_sequence%>" size=4 maxlength=4></td>
  </tr>
<%
    }
      out.println("</form>");
  }
  else
  {
    out.println("<tr><td colspan=20>没有记录！</td></tr>");
  }
%>
</table>
<script LANGUAGE="javascript">
function setSequence()
{
  var form = document.formData;
  if (typeof(form.sj_id)!="undefined")
  {
  	var hiddenObj = document.createElement("input");
  	hiddenObj.type = "hidden";
  	hiddenObj.name = "___sj_id";
  	hiddenObj.value = form.sj_id.value;
  	form.appendChild(hiddenObj);
  }
  form.action = "setSequence.jsp";
  form.submit();
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