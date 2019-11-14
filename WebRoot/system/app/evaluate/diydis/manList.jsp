<%@page contentType="text/html; charset=GBK"%>
<%@include file="/system/app/skin/head.jsp"%>
<%@page import="com.util.*"%>
<%@page import="Evaluate.*"%>
<%@page import="vote.*"%>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.util.Vector" %>
<%
CDataCn dCn = null;
CDataImpl dImpl = null;
try{
dCn = new CDataCn();
dImpl = new CDataImpl(dCn);
//
Vote vote = new Vote();
String vt_name = "";
String vt_id = CTools.dealString(request.getParameter("id")).trim();
String vt_sort = CTools.dealString(request.getParameter("vt_sort")).trim();
String cSort = CTools.dealString(request.getParameter("cSort")).trim();
String dd_name = CTools.dealString(request.getParameter("dd_name")).trim();

vt_name = vote.getVtName(vt_id);
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
	<table cellspacing="0" cellpadding="3" width="100%" border="0" align="left">
		<tr>
			<td align='left' class='line-odd'> 部门：<%=dd_name%></td>
		</tr>
		<%
			vote.getVoteTitle(vt_id);
			Vector vtVal = vote.RetuenVectorVoteTitle();
			String vType = "";
			String vName = "";
			String vCode = "";
			String tr_ip = "";
			Hashtable hVal = new Hashtable();
			if (vtVal != null) {
				for (int i = 0;i < vtVal.size();i++) {
					VoteStruct votest = new VoteStruct();
					votest = (VoteStruct)vtVal.get(i);
					vType = votest.getType();
					if (vType.equals("textarea") || vType.equals("text")) {
						hVal.put(votest.getDbname(),votest.getName());
						vCode += votest.getDbname() + ",";
					}
				}
			}
			
			String code[] = vCode.substring(0,vCode.length()).split(",");
			String sqlStr = "select " + vCode + "a.vs_id,b.tr_ip from tb_votediy" + vt_id + " a,tb_remip b where a.vs_id = b.vs_id " + 
							"and b.tr_code = '" + cSort + "' order by vs_id desc";
			
			Vector vPage =  dImpl.splitPage(sqlStr,request,8);
			Hashtable content = null;
			if (vPage != null) {
				for (int i = 0;i < vPage.size();i++) {
					content = (Hashtable)vPage.get(i);
					tr_ip = content.get("tr_ip").toString();
		%>
						<tr class='<%=i%2==0 ? "line-even" : "line-odd"%>'>
							<td><table cellspacing="0" cellpadding="3" width="100%" border="0">
								<tr>
									<td align="left" height="15"> IP: <%=tr_ip%></td>
								</tr>
						
		<%
					for (int k = 0;k < code.length;k++) {
		%>
								<tr>
								    <td align="left" height="15"><%=hVal.get(code[k]).toString()%></td>
							   </tr>
								<tr>
								    <td align="left">&nbsp;&nbsp;<%=content.get(code[k]).toString()%></td>
							   </tr>
		<%
					}
		%>
							</table></td>
						</tr>
						
		<%
				}
			}
			out.print("<tr><td>" + dImpl.getTail(request) + "</td></tr>");
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
	System.out.println(new java.util.Date() + "--"
			+ request.getServletPath() + " : " + e.getMessage());
}
finally{
	dImpl.closeStmt();
	dCn.closeCn(); 
}
%>
<%@include file="/system/app/skin/bottom.jsp"%>