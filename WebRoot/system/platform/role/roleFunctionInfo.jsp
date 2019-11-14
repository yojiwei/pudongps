<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="../head.jsp" %>
<%
String tr_id=""; //角色id
tr_id=CTools.dealNumber(request.getParameter("tr_id"));

%>

<table class="main-table" width="100%">
<form name="formData" method="post" action="roleInfoResult.asp">
  <tr>
   <td>
  <table width="100%">
    <tr>
      <td width="100%" align="left" colspan="2">
                <table width="100%" cellspacing="0">
                        <tr class="title1">
                                <td id="TitleTd" width="100%" align="left">当前角色：办公室主任 当前操作：权限</td>
                                <td valign="top" align="right" nowrap>
                                <img src="/system/images/dialog/split.gif" align="middle" border="0">

                                <img src="/system/images/dialog/return.gif" border="0" onclick="javascirpt:history.go(-1);" title="返回" style="cursor:hand" align="absmiddle" id="image3" name="image3" WIDTH="14" HEIGHT="14">
                                <img src="/system/images/dialog/split.gif" align="middle" border="0">
                             </td>
                         </tr>

                   <tr class="igray" height="3">
                      <td width="100%" align="left" colspan="2">
                                <a href="roleInfo.jsp?tr_id=<%=tr_id%>">基本</a>&nbsp;&nbsp;
                                <a href="roleUserInfo.jsp?tr_id=<%=tr_id%>">用户</a>&nbsp;&nbsp;
                                <a href="roleFunctionInfo.jsp?tr_id=<%=tr_id%>">权限</a>&nbsp;&nbsp;&nbsp;&nbsp;
                                <span style="color:red"></span>
                      </td>
                   </tr>


                </table>
      </td>
    </tr>

   <tr>
     <td width="100%">
                 权限列表
         </td>
   </tr>
   <tr class="title1">
      <td width="100%" align="center" colspan="2">
          <input type="button" class="bttn" value="赋予选定权限" onclick="on_choose()">
          <input type="button" class="bttn" value="赋予全部权限" onclick="window.navigate('roleInfoResult.asp?id=29&amp;GiveAccess=true');"  id="button1" name="button1">
                  <input type="button" class="bttn" value="返回" onclick="javascript:history.back();">
      </td>
   </tr>
</table>
<input type="hidden" name="id" value="29">
<input type="hidden" name="control" value>
</td>
</tr>
</form>
</table>