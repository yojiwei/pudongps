<%@page contentType="text/html; charset=GBK"%>
<%
String strTitle = "信息维护";
%>
<%@include file="../skin/head.jsp"%>
<%@include file="/system/common/parameter.jsp"%>
<%

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
String in_sequence = "";

 String sql_admin = "select * from tb_roleinfo r,tb_functionrole f where tr_userids like '%," + uiid + ",%' and r.tr_id = f.tr_id and f.ft_id = (select ft_id from tb_function where ft_code='ISADMIN')";
	//out.println(sql_admin);
	Hashtable content_admin = dImpl.getDataInfo(sql_admin);
	String sqland = "";
	/*******************
	if(content_admin != null)
	{
		sqland = " and s.ti_ownerdtid = '" + dt_id + "'";
	}
	*******************/
	
	if (!"".equals(dt_id)) 
		//sqland = " and s.ti_ownerdtid = '" + dt_id + "'";
		sqland = "and s.ti_id = (select ti_id from tb_titlelinkconn where dt_id = " + dt_id + ")";
 String strSql = "select t.in_id,t.in_title,s.ti_name,t.in_sequence from tb_info t,tb_title s where t.ti_id=s.ti_id and s.ti_upperid =(select ti_id from tb_title where ti_code = 'pudong_jz') " + sqland + " order by s.ti_sequence,t.in_sequence";


Vector vectorPage = dImpl.splitPage(strSql,request,20);

%>

<table class="main-table" width="100%">
<form name="formData" method="post">
<input type="hidden" value="leadBoxList.jsp" name="returnPage">
  <tr>
  <td width="100%">
       <table class="content-table" width="100%">
        <tr class="title1">
            <td colspan="8" align="center">
                <table WIDTH="100%" BORDER="0" CELLSPACING="1" CELLPADDING="1">
                    <tr>
                        <td valign="center" nowrap><%=strTitle%></td>
                        <td valign="center" align="right" nowrap>
                            <img src="/system/images/split.gif" align="middle" border="0" WIDTH="5" HEIGHT="8">
							<img src="/system/images/new.gif" border="0" onclick="window.location='leadBoxInfo.jsp?in_id=<%=in_id%>&OPType=Add'" title="新增信息" style="cursor:hand" align="absmiddle" WIDTH="16" HEIGHT="16">
                            <img src="/system/images/split.gif" align="middle" border="0" WIDTH="5" HEIGHT="8">
                            <img src="/system/images/dialog/sort.gif" border="0" onclick="setSequence();" title="修改排序" style="cursor:hand" align="absmiddle" WIDTH="15" HEIGHT="15">
                            <img src="/system/images/split.gif" align="middle" border="0" WIDTH="5" HEIGHT="8">
                            <img src="/system/images/goback.gif" border="0" onclick="javascript:history.back();" title="返回" style="cursor:hand" align="absmiddle">
                            <img src="/system/images/split.gif" align="middle" border="0" WIDTH="5" HEIGHT="8">
   </td>
  </tr>
 </table>
  </td>
        </tr>
        <tr class="bttn">
            <td width="50%" class="outset-table">所属街道</td>
            <td width="20%" class="outset-table">领导姓名</td>
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
      in_id = content.get("in_id").toString();
      if(j % 2 == 0)  out.print("<tr class=\"line-even\">");
      else out.print("<tr class=\"line-odd\">");
%>
		        
		        <td align="center"><%=ti_name%></td>
		        <td align="center"><%=in_title%></td>
		        <td align="center"><a href="leadBoxInfo.jsp?in_id=<%=in_id%>&OPType=Edit">编辑</a>
			<a href="#" onclick="check_del('<%=in_id%>')">删除</a>
			</td>
		        <td align=center><input type=text class=text-line name=<%="module"+in_id%> value="<%=in_sequence%>" size=4 maxlength=4></td>
		      </tr>

<%
    }
      out.println("</form>");
      out.println("<tr><td colspan=4>" + dImpl.getTail(request) + "</td></tr>"); //输出尾部文件
  }
  else
  {
    out.println("<tr><td colspan=4>没有记录！</td></tr>");
  }
%>
</table>
        </td>
    </tr>

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
<%
dImpl.closeStmt();
dCn.closeCn();

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
<%@include file="../skin/bottom.jsp"%>
