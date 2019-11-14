<%@page contentType="text/html; charset=GBK"%>
<%@include file="/system/app/skin/head.jsp"%>
<%String strTitle="在线提问详细信息";%>
<!-- 程序开始 -->
<%
String sql="";//查询条件
String OPType="";//操作方式 Add是添加 Edit是修改
String cl_id="";//主键
String cl_title="";//主题
String cl_content="";//提问内容
String cl_type="";//是否已读，1为已读
String cl_code="";//是否由会计中心处理，1为是
String cl_submit_time="";//提问提交日期

//update20080122

CDataCn dCn=null;   //新建数据库连接对象
CDataImpl dImpl=null;  //新建数据接口对象

try {
 dCn = new CDataCn(); 
 dImpl = new CDataImpl(dCn); 

/*得到上一个页面传过来的参数  开始*/
cl_id=CTools.dealString(request.getParameter("cl_id")).trim();
OPType=CTools.dealString(request.getParameter("OPType")).trim();
/*得到上一个页面传过来的参数  结束*/
if (OPType.equals("Edit"))
{
sql="select cl_title,cl_content,cl_type,cl_code,cl_submit_time from tb_consultation where cl_id=" + cl_id;
Hashtable content=dImpl.getDataInfo(sql);
cl_title=content.get("cl_title").toString() ;//主题
cl_content=content.get("cl_content").toString() ;//提问内容
cl_type=content.get("cl_type").toString() ;//是否已读，1为已读
cl_code=content.get("cl_code").toString() ;//是否由会计中心处理，1为是
cl_submit_time=content.get("cl_submit_time").toString() ;//提问提交日期
}

dImpl.closeStmt();
dCn.closeCn();
%>
<!-- 程序结束 -->
<%@include file="/system/app/skin/skin4/template/info_top.jsp"%>
<!--    模块名称开始    -->
<%=strTitle%>
<!--    模块名称结束    -->
<%@include file="/system/app/skin/skin4/template/info_funtion.jsp"%>
<!--    功能按钮开始    -->

<!--    功能按钮结束    -->
<%@include file="/system/app/skin/skin4/template/info_main.jsp"%>
<!--    表单提交开始    -->
<table class="main-table" width="100%">
<FORM METHOD=POST ACTION="SulResult.jsp">
<tr>
     <td width="100%">
         <table width="100%" class="content-table" height="1">
          <tr class="line-even" >
            <td width="22%" align="right">提问名称：</td>
            <td width="78%" align="left"><input type="text" class="text-line" size="45" name="cl_title" maxlength="200"  value="<%=cl_title%>" readonly>
            </td>
          </tr>
          <tr class="line-odd">
            <td align="right" >提问日期：</td>
            <td align="left"><input type="text" class="text-line" size="45" name="cl_title" maxlength="200"  value="<%=cl_submit_time%>" readonly>
            </td>
          </tr>
          <tr class="line-even">
            <td align="right" valign="top">提问内容：</td>
            <td align="left">
			<TEXTAREA NAME="cl_content" ROWS="12" COLS="80"  readonly><%=cl_content%></TEXTAREA>
            </td>
          </tr>
	  <tr class="line-odd">
            <td align="right" >是否已读</td>
            <td align="left"><INPUT TYPE="checkbox" NAME="cl_type" <% if(cl_type.equals("1"))out.println("checked");%>  value ="1">
            </td>
          </tr>
	  <tr class="line-even">
            <td align="right" >会计中心处理：</td>
            <td align="left"><INPUT TYPE="checkbox" NAME="cl_code" <% if(cl_code.equals("1"))out.println("checked");%> value ="1">
            </td>
          </tr>
	  <tr class=outset-table>
            <td align="center" colspan="2"><INPUT TYPE="submit" value ='提交' class="bttn">&nbsp;&nbsp;&nbsp;&nbsp;<input class="bttn" value="返回" type="button" onclick="history.back();" size="6" >
            <INPUT TYPE="hidden" name = "cl_id" value = "<%=cl_id%>"></td>
          </tr>

        </table>
     </td>
   </tr>
</FORM>
</table>
<!--    表单提交结束    -->
<%@include file="/system/app/skin/skin4/template/info_bottom.jsp"%> 
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
<%@include file="/system/app/skin/bottom.jsp"%>
                                     
