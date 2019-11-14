<%@ page contentType="text/html; charset=GBK"%>
                <table width="100%" cellspacing="0">
                        <tr class="title1">
                                <td id="TitleTd" width="100%" align="left">当前角色：<%=session.getAttribute("_platform_tr_name").toString()%> 当前操作：<%=Operate%></td>
                                <td valign="top" align="right" nowrap>
                                <img src="/system/images/dialog/split.gif" align="middle" border="0">

                                <img src="/system/images/dialog/return.gif" border="0" onclick="javascirpt:history.go(-1);" title="返回" style="cursor:hand" align="absmiddle" id="image3" name="image3" WIDTH="14" HEIGHT="14">
                                <img src="/system/images/dialog/split.gif" align="middle" border="0">
                             </td>
                         </tr>

<%@ include file="column.jsp" %>


                </table>