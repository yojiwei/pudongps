<%@page contentType="text/html; charset=GBK"%>
<%@include file="/system/app/skin/head.jsp"%>
<%
//casso data
MyCDataCn mydCn = null;
MyCDataImpl mydImpl = null;
//pudong data
CDataCn dCn = null;
CDataImpl dImpl = null;

String sqlStr = "";
String ct_content = "";
String us_uid = "";           //用户UID
String us_pwd = "";           //用户密码
String us_tel = "";           //用户联系方式
String us_name="";            //用户真实姓名
String uk_id="";              //用户类型
String us_regdate="";              //用户类型
String us_isok = "";
String strSql = "";
String sAny = "";
String ms_uid = "";
String ms_uids = "";
String strTitle = "用户管理";
String today = new CDate().getThisday();

Vector vPage = null;
Vector vectorPage = null;
Hashtable content = null;
Hashtable contentdx = null;
Hashtable contentms = null;
try{
//CASSO数据库
mydCn = new MyCDataCn();
mydImpl = new MyCDataImpl(mydCn); 
//浦东数据库
dCn = new CDataCn();
dImpl = new CDataImpl(dCn);
//
us_name=CTools.dealString(request.getParameter("us_name")).trim();
us_uid=CTools.dealString(request.getParameter("us_uid")).trim();
if(!"".equals(us_uid)){
	us_uid = us_uid+"@pudong.gov.cn";
}
String sWhere="select us_id,us_uid,us_pwd,us_regdate,us_isok from tb_user where 1=1";
if (!us_name.equals(""))
{
	sAny = "select us_uid from tb_user where us_name like '%" + us_name + "%'";
	vPage = dImpl.splitPage(sAny,100,1);
	if(vPage!=null)
	{
	   for(int i=0;i<vPage.size();i++)
	   {
	   	 contentms = (Hashtable)vPage.get(i);
		 ms_uid = CTools.dealNull(contentms.get("us_uid"));
		 ms_uid = ms_uid + "@pudong.gov.cn";
		  if(i<vPage.size()-1){
		 	ms_uids += "'"+ms_uid +"',";
		  }else{
		    ms_uids +="'"+ms_uid+"'";
		  }
		}
	  }
	sWhere=sWhere + " and us_uid in ("+ms_uids+")";
}
if (!us_uid.equals(""))
{
	sWhere=sWhere + " and us_uid ='" + us_uid + "' ";
}
sWhere = sWhere + "order by us_regdate desc";
%>
<%@include file="/system/app/skin/skin4/template/list_top.jsp"%>
<!--    模块名称开始    -->
<%=strTitle%>
<!--    模块名称结束    -->
<%@include file="/system/app/skin/skin4/template/list_function.jsp"%>                                                            
<!--    功能按钮开始    -->
<img src="/system/images/menu_about.gif" border="0" onclick="javascript:window.location.href='UserSearch1.jsp' " title="查找" style="cursor:hand" align="absmiddle">
查找
<img src="/system/images/goback.gif" border="0" onclick="javascript:history.back();" title="返回" style="cursor:hand" align="absmiddle">
返回
<!--    功能按钮结束    -->
<%@include file="/system/app/skin/skin4/template/list_listtop.jsp"%>                                                           
<!--    列表开始    -->
<table class="FindAreaTable1" cellspacing="1" rules="cols" border="0" id="ctl00_DataGrid_DataGrid1" style="border-width:0px;">
<form name="formData">
	<tr class="bttn">
		<td width="10%" class="outset-table" align="center" nowrap>用户名</td>
		<td width="15%" class="outset-table" align="center" nowrap>用户姓名</td>
		<td width="10%" class="outset-table" align="center" nowrap>用户密码</td>
		<td width="10%" class="outset-table" align="center" nowrap>用户注册时间</td>
		<td width="10%" class="outset-table" align="center"  nowrap>是否可用</td>
		<td width="10%" class="outset-table" align="center" nowrap>操作</td>
	</tr>
<%
  //out.println(sWhere);
  vectorPage = mydImpl.splitPage(sWhere,request,20);
  if(vectorPage!=null)
  {
    for(int j=0;j<vectorPage.size();j++)
    {
      content = (Hashtable)vectorPage.get(j);
	  us_uid = CTools.dealNull(content.get("us_uid"));
	  us_uid = us_uid.replaceAll("@pudong.gov.cn","");
	  //
	  sqlStr = "select us_name from tb_user where us_uid = '"+us_uid+"'";
	  contentdx = (Hashtable)dImpl.getDataInfo(sqlStr);
	  if(contentdx!=null){
		us_name = CTools.dealNull(contentdx.get("us_name"));
	  }
	  //
	  us_pwd = CTools.dealNull(content.get("us_pwd"));
	  us_regdate = CTools.dealNull(content.get("us_regdate"));
	  us_isok = CTools.dealNull(content.get("us_isok"));
	  
      if(j % 2 == 0)  out.print("<tr class=\"line-even\">");
      else out.print("<tr class=\"line-odd\">");
%>
		<td align="center"><%=us_uid%></td>
		<td align="center"><%=us_name%></td>
		<td align="center"><%=us_pwd%></td>
		<td align="center"><%=us_regdate%></td>
		<td align="center">
		<%
		if(us_isok.equals("0"))
			out.print("否");
		else if(us_isok.equals("1"))
			out.print("是");
		%>
		</td>
		<td align="center">
    	<a href="UserInfo1.jsp?us_id=<%=content.get("us_id")%>">
		<img class="hand" border="0" src="../../images/modi.gif" title="编辑" WIDTH="16" HEIGHT="16"></a>&nbsp;
		</td>
		</tr>
</form>
<%
    }
  }
  else
  {
    out.println("<tr><td colspan=20>没有记录！</td></tr>");
  }
%>
</table>
<!--    列表结束    -->
				</td>
			</tr>
			<tr class="bttn" align="center">
				<td width="100%">
					<%=mydImpl.getTail(request)%>
				</td>
			</tr>
		</table>
		<!--    列表结束    -->
	</td>
</tr>
</table>
<%
}
catch(Exception e){
	System.out.print(e.toString());
}
finally{
	dImpl.closeStmt();
	dCn.closeCn(); 
	mydImpl.closeStmt();
	mydCn.closeCn(); 
}
%>
<%@include file="/system/app/skin/bottom.jsp"%>