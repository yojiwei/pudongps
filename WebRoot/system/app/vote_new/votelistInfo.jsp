<%@page contentType="text/html; charset=GBK"%>
<%@include file="/system/app/skin/head.jsp"%>
<script language=javascript>
function dovalidate()
{
  sForm=document.form1;
  return check(sForm.dv_id,sForm);
   for(i=0;i<sForm.length;i++)
   {
    if(sForm[i].title!="")
     if(sForm[i].value=="")//
    {
    sWarn=sForm[i].title+"不能为空!";
    alert(sWarn);
     sForm[i].focus();
     return false ;
     }
   }
return true;
}
//判断订制是否选中
function check(name,form1){
	var b = false;
	var a=0;
	if(name!=undefined){
	  if(name.length==undefined||name.length>0)
	     if(name.checked)b=true;
		 else
		 for(var i=0;i<name.length;i++){
			if(name[i].checked){
				b = true;
				a++;
			}
		}
	}
	if(!b&&a==0){
		alert("对不起请至少选择一个应用网站!");
		return false;
	}else{
		return true;
	}
}
</script>
<%
String strTitle="网上投票管理";
String strContent="";
String strListNum="" ;
String strId="" ;
String actiontype="";
String strListcontent="";
String strListId="";
String vt_pubflag="";
int intList=0;
CDataCn dCn = null;
CDataImpl dImpl = null;
Vector vector=null;
Hashtable content=null;
try{
dCn = new CDataCn();
dImpl = new CDataImpl(dCn);
//
strId=CTools.dealString(request.getParameter("strId"));
vt_pubflag=CTools.dealString(request.getParameter("vt_pubflag"));
if (strId.equals("")==false)
{
	actiontype="modify";
    String strSql="select * from tb_vote where vt_id="+strId;
	content = dImpl.getDataInfo(strSql);
	strContent=content.get("vt_content").toString();
	strListNum=content.get("vt_listnum").toString();
	intList=Integer.parseInt(strListNum);
	

}
else
{
	actiontype="add";
	strContent=CTools.dealString(request.getParameter("vt_content")).trim();
	strListNum=request.getParameter("vt_listnum").trim();
	intList=Integer.parseInt(strListNum);

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

 <table WIDTH="100%" CELLPADDING="0" BORDER="0" class="main-table">
<form name="form1" method="post" action="voteResult.jsp" onsubmit="return dovalidate()">   <tr>
        <td width="100%" align="left" valign="top">
			<table class="content-table" height="" width="100%">
				 <tr class="line-odd">
				  <td width="13%" height="18"  align="right">调查主题</td>
				  <td width="87%"><input type=text name=scontent size=50 value=<%=strContent%>></td>
				 </tr>
				 <tr  class="line-odd">
			      <td align="right">应用网站</td>
			      <td>
				  <%
				  String voteIntelSql="select d.dv_id,d.dv_value from tb_datavalue d,tb_datatdictionary a where d.dd_id=a.dd_id and a.dd_code='voteintel' order by dv_id desc";
				  vector = dImpl.splitPage(voteIntelSql,request,20);
				  if(vector!=null){
				  for(int i=0;i<vector.size();i++){
				  content = (Hashtable)vector.get(i);
				  
				  %>
				  <input type="checkbox" name="dv_id" value="<%=content.get("dv_id").toString()%>" 
				  <%
				  if("modify".equals(actiontype))
				  {
				  	  String voteCheckSql="select * from tb_vote_datavalue where dv_id="+content.get("dv_id").toString()+" and vt_id="+strId;
					  Hashtable contentCheck = dImpl.getDataInfo(voteCheckSql);
					  if(contentCheck!=null){
					  	 out.print("checked");
					  }
				  }
				  %>
				  /> <%=content.get("dv_value").toString()%>&nbsp;
				  <%
				  }
				  }
				  %><font color=red>*</font></td>
			    </tr>
				 <tr class="line-odd">
				  <td width="13%" height="18"  align="right">是否发布</td>
				  <td width="87%"><input type=radio name="radiopub" value="1" <%if(vt_pubflag.equals("1")) out.print("checked"); %> >是&nbsp;&nbsp;<input type=radio name="radiopub" value="0" <%if(vt_pubflag.equals("0")||"add".equals(actiontype)) out.print("checked"); %> >否</td>	
					<!-- <td>排序</td>-->
				 </tr>
    <%
    for(int i=1;i<=intList;i++)
    {
		if (strId.equals("")==false)
		{
			String strSql="select * from tb_votelist where vt_id="+strId;
			vector = dImpl.splitPage(strSql,request,1000);
			if (vector!=null)
			{
			content = (Hashtable)vector.get(i-1);
			strListcontent=content.get("vt_listcontent").toString();
			strListId=content.get("vt_listid").toString();
			}
		}
    %>
				<tr <% if (i%2 == 0) {%>class="line-odd" <%} else {%> class="line-even" <%}%>>
				  <td align="right">选项<%=i%></td>
				  <td>
				  <input name="vt_list" type="text" size=60 maxlength="200" title="选项<%=i%>" value=<%=strListcontent%>>&nbsp;<font color=red>*</font>
				  <input type=hidden name="vt_listId" value=<%=strListId%>>
				  </td>
				</tr>
    <%}%>
		 </table>
	 </td>
  </tr>
  <tr class=outset-table>
	<td width="100%" align="right" colspan="3">
		 <input type="hidden" name="strId" value=<%=strId%>>
		 <input type="hidden" name="actiontype" value=<%=actiontype%>>
		 <input type="hidden" name="vt_content" value="<%=strContent%>">
	     <input type="hidden" name="vt_listnum" value="<%=strListNum%>">
		 <p align="center">
		 <input class="bttn" value="提交" type="submit"  size="6" id="button2" name="button2">&nbsp;
		 <input class="bttn" value="返回" type="button"  size="6" id="button3" name="button3" onclick="javascript:history.go(-1)">
	</td>
 </tr></form>
</table>

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
                                     
