 <%@ page contentType="text/html; charset=GBK" %>
<%@include file="/website/include/IsLogin.jsp"%>
<%@include file="/website/include/head_zw_user.jsp"%>
<%
//update by yo 20090811
User userTop = (User)session.getAttribute("user");
String us_id = userTop.getId();
String us_uid = userTop.getUid();

%>
<script LANGUAGE="javascript">
function checkFormLogin()
{
	var form = document.formLogin ;
	if	 (form.us_uid.value =="")
	{
		alert("请填写用户名！");
		form.us_uid.focus();
		return false;
	}
	if	 (form.us_pwd.value =="")
	{
		alert("请填写密码！");
		form.us_pwd.focus();
		return false;
	}
	return true;
}
function jumpTo(opage){
	window.location.href= unescape(opage);
}
</script>
<table width="760" border="0" align="center" cellpadding="0" cellspacing="0" height="250" align="center">
  <tr>
    <td width="30%"><div align="center"><img src="/website/images/ban.jpg" width="210" height="171"></div></td>
    <td width="70%">
	<TABLE height=35 cellSpacing=0 cellPadding=0 width="500" align=center 
      border=0>
                  <TBODY>
                    <TR> 
                      <TD width=4 height=3><IMG height=3 
            src="images/2_corner_left_up.gif" width=4></TD>
                      <TD background=images/2_background_up.gif></TD>
                      <TD width=5><IMG height=3 
            src="images/2_corner_right_up.gif" width=5></TD>
                    </TR>
                    <TR> 
                      <TD background=images/2_background_left.gif></TD>
                      <TD bgColor=#FFFFFF> 
                        <TABLE cellSpacing=0 cellPadding=0 width="100%" 
              border=0>
                          <TBODY>
                            <TR> 
                              <TD vAlign=top> 
                                <TABLE cellSpacing=0 cellPadding=0 width="480" align=center 
                  border=0>
                                  <TBODY>
                                    <TR> 
                                      <TD height=40 align="center" class="text3"><strong><font color="#CC0000">我要办事</font></strong></TD>
                                    </TR>
                                    <TR> 
                                      <TD bgcolor="#F3F3F3">
<table width="100%" border="0" cellspacing="10" cellpadding="0">                       
<%
//Update 20061231
//申明变量
CDataCn dCn = null;
CDataImpl dImpl = null;

String sj_dir = "";
String sqlStr = "";
String ct_content = "";
Vector vPage = null;
Hashtable content = null;

try{
dCn = new CDataCn();
dImpl = new CDataImpl(dCn); 
//申明变量结束


										String sql = "select u.us_id from tb_user u,tb_enterpvisc c ,tb_entemprvisexml x where u.us_id =c.us_id and c.ec_id=x.ec_id and u.us_id='"+us_id+"' and x.el_type=3";
										Hashtable map = dImpl.getDataInfo(sql);
										if(map!=null){
										%>
																				  <tr> 
                                          <td align="center">您是&quot;上海浦东&quot;门户网站的验证企业用户,</td>
                                          </tr>
                                          <tr> 
                                            <td align="center">跟据您申请的办事证书，您可在网上直接办理：</td>
                                          </tr>
										  
										   <tr> 
                                            <td align="center"><a href="/website/waishi/index.jsp?sj_id=156"><font color="#CC0000">外事类网上办事</font></a>
                                            </td>
                                          </tr>
										  <%	
										}else{
										%>
																				  <tr> 
                                          <td align="center">您是&quot;上海浦东&quot;门户网站的普通用户,</td>
                                          </tr>
                                          <tr> 
                                            <td align="center">只能进行网上投诉,咨询和办事事项表格下载等非验证办理.</td>
                                          </tr>
										<%										
										}
										%> 									<!--update by yo 20091109-->
																			<%
																				//if("yangtest".equals(us_uid)){
																				%>
																				 <tr> 
                                            <td align="center">
                                            <a href="http://211.144.95.130/pdhb.wsbs"><font color="#CC0000">环保局网上办事系统</font></a>
																						</td>
                                          </tr>
                                         <%//}%>
                                        <!--update by yo 20091109-->	
                                        
                                        </table>
                                      </TD>
                                    </TR>
                                    <TR> 
                                      <TD 
            height=50 align="right"><A HREF="../workHall/index.jsp" ><img src="../images/go.gif" width="180" height="25" border="0"></A></TD>
                                    </TR>
                                  </TBODY>
                                </TABLE>
                              </TD>
                            </TR>
                          </TBODY>
                        </TABLE>
                      </TD>
                      <TD background=images/2_background_right.gif></TD>
                    </TR>
                    <TR> 
                      <TD height=6><IMG height=6 
            src="images/2_corner_left_down.gif" width=4></TD>
                      <TD background=images/2_background_down.gif></TD>
                      <TD><IMG height=6 
            src="images/2_corner_right_down.gif" 
        width=5></TD>
                    </TR>
                  </TBODY>
                </TABLE>
	</td>
  </tr>
</table>
<%@include file="/website/include/bottom_user.jsp"%>
<%}
catch(Exception e){
//e.printStackTrace();
out.print(e.toString());
}
finally{
dImpl.closeStmt();
dCn.closeCn(); 
}
%>