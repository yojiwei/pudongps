<%@page contentType="text/html; charset=GBK"%>
<%@include file="/system/app/skin/head.jsp"%>
<%@page import="com.util.*"%>
<%@page import="Evaluate.*"%>
<%@page import="vote.*"%>
<%@ page import="java.sql.ResultSet" %>
<%
Vote vote = new Vote();

String vt_name = "";
String vt_id = CTools.dealString(request.getParameter("id")).trim();
String vt_sort = CTools.dealString(request.getParameter("vt_sort")).trim();

vt_name = vote.getVtName(vt_id);
//
CDataCn dCn = null;
CDataImpl dImpl = null;
try{
dCn = new CDataCn();
dImpl = new CDataImpl(dCn);
%>
<%@include file="/system/app/skin/skin4/template/list_top.jsp"%>
<!--    模块名称开始    -->
<%=vt_name%>
<!--    模块名称结束    -->
<%@include file="/system/app/skin/skin4/template/list_function.jsp"%>                                                            
<!--    功能按钮开始    -->
  
<!--    功能按钮结束    -->
<%@include file="/system/app/skin/skin4/template/list_listtop.jsp"%>                                                                                        
<!--    列表开始    -->
<TABLE cellSpacing="0" cellPadding="0" width="100%" border="0" align="center">
<tr width="100%" align="center" class="title1">
<td background="/website/images/mid10.gif" width="1" colspan="15"><img src="/website/images/mid10.gif" width="1" height="3"></td>
</tr>
<tr>
<td background="/website/images/mid10.gif" width="1" colspan="15"><img src="/website/images/mid10.gif" width="1" height="3"></td>
</tr>
<tr>
  <td colspan="2">
<table class="FindAreaTable1" cellspacing="1" rules="cols" border="0" id="ctl00_DataGrid_DataGrid1" style="border-width:0px;">

		<%
		vote.getVoteTitle(vt_id);
		out.print(vote.totalManTitle(vt_id,14));
		out.print(vote.reTotalDept_Date(vt_id,vt_sort));
		%>
	</table>
  </td>
</tr>
<tr>
 <td background="/website/images/mid10.gif" width="1" colspan="13">
 	<img src="/website/images/mid10.gif" width="1" height="3"></td>
</tr>
</table>
<table cellspacing="0" cellpadding="0" width="100%" border="0" align="center">
  <tr>
    <td class="title1">
		<input type="button" name="btnReturn" value="返回" onclick="javascript:window.history.go(-1);" class="bttn">
    </td>
  </tr>
</table>
<!--    列表结束    -->
                            </td>
                        </tr>
                        <tr class="bttn" align="center">
                            <td width="100%">&nbsp;
                            </td>
                        </tr>
                    </table>
                    <!--    列表结束    -->
                </td>
            </tr>
        </table>
</body>
</html>
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