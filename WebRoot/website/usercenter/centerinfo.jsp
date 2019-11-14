<%@page contentType="text/html; charset=GBK"%>
<%@include file="/website/include/IsLogin.jsp"%>
<%@include file="/website/include/head_zw_user.jsp"%>

<script language="JavaScript" type="text/JavaScript">
<!--
function MM_openBrWindow(theURL,winName,features) { //v2.0
  window.open(theURL,winName,features);
}
function MM_goToURL() { //v3.0
  var i, args=MM_goToURL.arguments; document.MM_returnValue = false;
  for (i=0; i<(args.length-1); i+=2) eval(args[i]+".location='"+args[i+1]+"'");
}
//-->
</script>
<style type="text/css">
<!--
.kuang {
	border: 1px solid #999999;
}
-->
</style>

<%

//Update 20061231
CDataCn dCn = null;
CDataImpl dImpl = null;
CDataImpl dImpl_IN = null;

String sj_dir = "";
String sqlStr = "";
String ct_content = "";	
String name = "";
String us_id ="";
String checkEnterpviscSql = "";
Vector vPage = null;
Hashtable content = null;
Hashtable contentEnter = null;
try{
dCn = new CDataCn();
dImpl = new CDataImpl(dCn); 
dImpl_IN = new CDataImpl(dCn); 
//申明变量结
User user = (User)session.getAttribute("user");
if(user!=null){
	name =user.getUid();
	us_id=user.getId();
	checkEnterpviscSql = "select ec_id,ec_name from tb_enterpvisc where us_id = '"+us_id+"'";
	contentEnter = dImpl.getDataInfo(checkEnterpviscSql);
	if(contentEnter==null){
		out.println("<script>alert('抱歉，您不是企业用户，请升级成企业用户！');window.location.href='/website/usermanage/Modify.jsp?oType=modify';</script>");
	}
}
%>
<table width="760" border="0" align="center" cellpadding="0" cellspacing="0">
<form method="post" action="ProjectResult.jsp" name="userinfo">
  <tr>
                <td height="10">&nbsp;</td>
              </tr><tr>
    <td>     <TABLE width=680 border=0 align=center cellPadding=10 cellSpacing=0 
            bgColor=#FEFFF0 class="kuang">
                  <TBODY>
                    <TR> 
                      <TD>
                        　　您现在已经成为上海浦东门户网站注册用户，您的用户名为<FONT 
                  color=#ff0000><%=name%></FONT>。<BR> <BR>
                        　　目前您的用户名还没有经过认证，作为非认证用户，您现在可以使用网上的<A 
                  href="/website/usercenter/index.jsp"><FONT 
                  color=#ff0000>用户中心</FONT></A>进行网上咨询、投诉、信访建议等活动。真诚欢迎您对浦东的发展建设建言献策、批评指导！<BR> 
                        <BR> 
                        <!--input type="button" name="Submit" value="进入用户中心" onClick="MM_goToURL('parent','/website/usercenter/index.jsp');return document.MM_returnValue"> <br-->
                        　　<B>用户如果想进行网上事项办理的申请，必须经过相关类别的实件认证，成为认证用户。</B> <BR> <BR>
                        　　须知：<BR>
                        　　　　认证审批通过后，该用户将被"上海浦东"门户网站用户中心升级为认证用户，为了保护用户合法权益，我们将对您填写的用户信息实行信息保护。也即，您的用户名与您提交的企业关键信息（如企业名称、组织机构代码等）有唯一对应关系，不能随意更改。您注册的用户名是该企业在上海浦东门户网站进行一切网上申理活动的唯一代号，请牢记和谨慎保管。<FONT 
                  style="CURSOR: hand" 
                  onclick='window.open("lc.html","外事办","Top=0px,Left=0px,Width=400px,Height=350px,toolbar=no,location=no,derectories=no,status=no,menubar=no,resizable=no,scrollbars=yes");'><B>(申请流程)</B></FONT> 
                        　
<hr size="1" noshade>
                
                      </TD>
                    </TR>
					<tr>

					<td>

					<%
					String typeid=request.getParameter("typeid");
					%>
<TABLE cellSpacing=0 cellPadding=0 width="100%" 
                        align=center border=0>
  <TBODY>
    <TR> 
      <TD width=1 bgColor=#b49f66 rowSpan=12><IMG 
                              height=1 src="" width=1></TD>
      <TD bgColor=#b49f66 colSpan=15 height=4><IMG 
                              height=4 src="" width=1></TD>
      <TD width=1 bgColor=#b49f66 rowSpan=12><IMG 
                              height=1 src="" width=1></TD>
    </TR>
    <TR> 
      <TD vAlign=top> <TABLE cellSpacing=0 cellPadding=0 width="100%" 
                              border=0>
          <TBODY>
            <TR> 
              <TD> <TABLE cellSpacing=0 cellPadding=0 width="100%" 
                                border=0>
                  <TBODY>
                    <TR> 
                      <TD><IMG height=26 src="/website/images/1<%=typeid%>_info.gif" 
                                width=705 useMap=#top border=0> </TD>
                    </TR>
                  </TBODY>
                </TABLE></TD>
            </TR>
            <TR> 
              <TD align=middle> <TABLE cellSpacing=3 cellPadding=1 width="100%" 
                                border=0>
                  <TBODY>
                    <TR> 
                      <TD> 
                        <!-- 开始 -->
                        <TABLE cellSpacing=1 cellPadding=0 width="100%" 
                                bgColor=#b49f66 border=0>
                          <TBODY>
                            <TR> 
                              <TD width="5%" bgColor=#f2e5d4 height=20> <DIV align=center>●</DIV></TD>
                              <TD width="30%" bgColor=#f2e5d4 height=20> <DIV align=center>事项名称</DIV></TD>
                              <TD width="10%" bgColor=#f2e5d4 height=20> <DIV align=center>办事部门</DIV></TD>
                              <TD width="20%" bgColor=#f2e5d4 height=20> <DIV align=center>状态</DIV></TD>                       
                              <TD width="15%" bgColor=#f2e5d4 height=20> <DIV align=center>操作</DIV></TD>
                            </TR>

<%

if(user!=null){
String sql  = "select pp_typeid,pp_value,pp_path,dt_name from tb_passport p,tb_deptinfo d where p.pp_typeid=d.dt_id";

Vector vec_pass = dImpl.splitPageOpt(sql,request,1000);
if(vec_pass!=null){
			for(int i = 0 ; i <vec_pass.size();i++){
				Hashtable map = (Hashtable)vec_pass.get(i);
				String pp_typeid = map.get("pp_typeid").toString();
				String pp_value = map.get("pp_value").toString();
				String pp_path = map.get("pp_path").toString();
				String dt_name = map.get("dt_name").toString();

				String pp_sql ="select p.pp_value,pp_path,x.el_type from tb_enterpvisc e, tb_user u ,tb_entemprvisexml x ,tb_passport p where e.us_id=u.us_id and x.ec_id=e.ec_id and p.pp_typeid ="+pp_typeid+" and u.us_id='"+us_id+"'";
				//out.println(pp_sql);
				Hashtable ppmap = dImpl_IN.getDataInfo(pp_sql);
				if(ppmap!=null){
					if(typeid.equals("2")){
						String el_type=ppmap.get("el_type").toString();
						out.println("<tr class=line-even>");
						out.println("<td align=conter>");
						out.println("</td>");
						out.println("<td align=conter>");
						out.println(pp_value);
						out.println("</td>");
						out.println("<td align=conter>");
						out.println(dt_name);
						out.println("</td>");
						out.println("<td align=conter>");
					if(el_type.equals("0")){
						out.println("审核中");
					}else if(el_type.equals("1")){
						out.println("审核不通过");
					}else if(el_type.equals("2")){
						out.println("补全信息");
					}else if(el_type.equals("3")){
						out.println("审核通过");
					}

						out.println("</td>");
						out.println("<td align=conter>");
						if(el_type.equals("2")){
						out.println("<A HREF='"+pp_path+"?typeid="+pp_typeid+"'>修改资料</A>");
						}else{
						out.println("没有任何操作");
						}
						out.println("</td>");

						out.println("</tr>");
					}
				}else{
					if(typeid.equals("1")){
						out.println("<tr class=line-even>");
						out.println("<td align=conter>");
						out.println("</td>");
						out.println("<td align=conter>");
						out.println(pp_value);
						out.println("</td>");
						out.println("<td align=conter>");
						out.println(dt_name);
						out.println("</td>");
						out.println("<td align=conter>");
						out.println("未进行任何操作");
						out.println("</td>");
						out.println("<td align=conter>");
						out.println("<A HREF='"+pp_path+"'>填写资料</A>");
						out.println("</td>");

						out.println("</tr>");	
					}
				}

			}
}

}%>			
							<TR> 
                              <TD bgColor=#fbf4ee colSpan=9> <SCRIPT language=javascript>function docheck(formname){if ( isNaN(formname.strPage.value) )	{	alert("转入页面必须为数字！");	formname.strPage.focus();	return (false);	}if (formname.strPage.value > 0 || formname.strPage.value < 0)	{	alert("抱歉！你输入的页数不在查询对象的范围之内，请重新输入。");	formname.strPage.focus();	return (false)	}return (true)}function dopage(strPage){document.PageForm.strPage.value = strPage;document.PageForm.submit()}</SCRIPT> 
                                <TABLE width="100%">
                                  <TBODY>
                                    <TR> 
                                      <TD align=right><%=dImpl.getTail(request)%></TD>
                                    </TR>
                                  </TBODY>
                                </TABLE></TD>
                            </TR>
                          </TBODY>
                        </TABLE>
                        <!-- 结束 -->
                      </TD>
                    </TR>
                  </TBODY>
                </TABLE></TD>
            </TR>
          </TBODY>
        </TABLE></TD>
    </TR>
    <TR> 
      <TD bgColor=#b49f66 colSpan=15 height=4><IMG 
                              height=4 src="" 
                    width=1></TD>
    </TR>
  </TBODY>
</TABLE>
<MAP 
      name=top>
  <AREA shape=RECT coords=28,9,88,24 
        href="/website/usercenter/centerinfo.jsp?typeid=1">
  <AREA 
        shape=RECT coords=124,9,184,24 
        href="/website/usercenter/centerinfo.jsp?typeid=2">
</MAP>

					</td>

					</tr>
					
					
					</TBODY></TABLE>

					
					
					</td>
  </tr>
 </form>
</table>


<%@include file="/website/include/bottom_user.jsp"%>
<%}
catch(Exception e){
//e.printStackTrace();
out.print(e.toString());
}
finally{
dImpl_IN.closeStmt();
dImpl.closeStmt();
dCn.closeCn(); 
}
%>