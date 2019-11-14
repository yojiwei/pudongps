<%@page contentType="text/html; charset=GBK"%>
<%@include file="/system/app/skin/head.jsp"%>
<%
String strTitle = "信息维护";
CMySelf self = (CMySelf)session.getAttribute("mySelf");
String dt_id="";
String uiid="";
if(self!=null && self.isLogin())
{
	dt_id = String.valueOf(self.getDtId());
	uiid = Long.toString(self.getMyID());
}

//update20080122

CDataCn dCn=null;   //新建数据库连接对象
CDataImpl dImpl=null;  //新建数据接口对象

try {
 dCn = new CDataCn(); 
 dImpl = new CDataImpl(dCn); 
	String in_id="";//信息的id
	String in_title = "";
	String ti_name ="";
	String in_inputtime = "";
	String in_sequence = "";
	String mytr_name = "";
 String sql_admin = "select * from tb_roleinfo r,tb_functionrole f where tr_userids like '%," + uiid + ",%' and r.tr_id = f.tr_id and f.ft_id = (select ft_id from tb_function where ft_code='ISADMIN')";
	
	Hashtable content_admin = dImpl.getDataInfo(sql_admin);
	String sqland = "";
	
	if(content_admin != null)
	{
		mytr_name = content_admin.get("tr_name").toString();
	}
	if (!"".equals(dt_id)) 
		sqland = "and s.ti_id in (select ti_id from tb_titlelinkconn where dt_id = " + dt_id + ")";
	if("超级管理员".equals(mytr_name))
		sqland = "";
		String strSql = "select t.in_id,t.in_title,s.ti_name,t.in_sequence,to_char(t.in_inputtime,'yyyy-MM-dd') as in_inputtime from tb_info t,tb_title s where t.ti_id=s.ti_id and s.ti_upperid =(select ti_id from tb_title where ti_code = 'pudong_jz') " + sqland + " order by s.ti_sequence,t.in_sequence";
		//out.println(strSql);
		Vector vectorPage = dImpl.splitPage(strSql,request,20);

%>
<%@include file="/system/app/skin/skin4/template/list_top.jsp"%>
<!--    模块名称开始    -->
<%=strTitle%>
<!--    模块名称结束    -->
<%@include file="/system/app/skin/skin4/template/list_function.jsp"%>                                                            
<!--    功能按钮开始    -->
<img src="/system/images/new.gif" border="0" onclick="window.location='leadBoxInfo.jsp?in_id=<%=in_id%>&OPType=Add'" title="新增信息" style="cursor:hand" align="absmiddle" WIDTH="16" HEIGHT="16">
新增信息
<img src="/system/images/dialog/sort.gif" border="0" onclick="setSequence();" title="修改排序" style="cursor:hand" align="absmiddle" WIDTH="15" HEIGHT="15">
修改排序
<img src="/system/images/goback.gif" border="0" onclick="javascript:history.back();" title="返回" style="cursor:hand" align="absmiddle">
返回   
<!--    功能按钮结束    -->
<%@include file="/system/app/skin/skin4/template/list_listtop.jsp"%>                                                                                        
<!--    列表开始    -->
<table class="FindAreaTable1" cellspacing="1" rules="cols" border="0" id="ctl00_DataGrid_DataGrid1" style="border-width:0px;">
<form name="formData" method="post">
<input type="hidden" value="leadBoxList.jsp" name="returnPage">
      <tr class="bttn">
            <td width="35%" class="outset-table">所属街道</td>
            <td width="20%" class="outset-table">领导姓名</td>
			<td width="15%" class="outset-table">更新日期</td>
            <td width="20%" class="outset-table" nowrap>
            <%
				out.print("操作");
            %>
            </td>
             <td width="10%" class="outset-table">排序</td>
        </tr>
<%
  if(vectorPage!=null)
  {
    for(int j=0;j<vectorPage.size();j++)
    {
      Hashtable content = (Hashtable)vectorPage.get(j);
      in_sequence=content.get("in_sequence").toString();
      in_title = content.get("in_title").toString();
      ti_name = content.get("ti_name").toString();
	  in_inputtime = content.get("in_inputtime").toString();
      in_id = content.get("in_id").toString();
      if(j % 2 == 0)  out.print("<tr class=\"line-even\">");
      else out.print("<tr class=\"line-odd\">");
%>
		        
		        <td align="center"><%=ti_name%></td>
		        <td align="center"><%=in_title%></td>
				<td align="center"><%="".equals(in_inputtime)?"2011-05-20":in_inputtime%></td>
		        <td align="center"><a href="leadBoxInfo.jsp?in_id=<%=in_id%>&OPType=Edit">编辑</a>
			<a href="#" onclick="check_del('<%=in_id%>')">删除</a>
			</td>
		        <td align=center><input type=text class=text-line name=<%="module"+in_id%> value="<%=in_sequence%>" size=4 maxlength=4></td>
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
function check_del(in_id)
{
	var con;
    con=confirm("真的要删除吗？");
	if(con)
	{
	  var str= "leadBoxDel.jsp?in_id=" + in_id ;
	  formData.action = str;
	  formData.submit();
	}
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