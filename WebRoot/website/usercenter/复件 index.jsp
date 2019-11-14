<%@ page contentType="text/html; charset=GBK"%>
<%@include file="/website/include/head_zw_user.jsp"%>
<%@page import="com.website.*"%>
<%@ page pageEncoding="GBK"%>
<!--<script language="javascript">
	window.showModalDialog("fj.htm");
</script>
-->
<%

User checkLogin = (User)session.getAttribute("user");
//update by yanker 20080919 ----start-------------------------
String us_uidN = CTools.dealString(request.getParameter("asd"));
String us_pwdN = request.getParameter("rfv");
boolean loginFlag = false;
//update by yanker 20080919 ----end---------------------------

if(!"".equals(us_uidN)){
	if(checkLogin==null||!checkLogin.isLogin())
	{
		checkLogin = new User();
		loginFlag = checkLogin.loginWSB(CBase64.getDecodeString(us_uidN),CBase64.getDecodeString(us_pwdN),"o27");
		if(loginFlag){
			session.setAttribute("user",checkLogin);
		}else{
	       out.println("<script>");
	       out.println("window.location.href='/website/login/Login.jsp';");
	       out.println("</script>");
		   return;
		}
	}
}else{
	if(checkLogin==null||!checkLogin.isLogin()) {
		out.println("<script>");
        out.println("window.location.href='/website/login/Login.jsp';");
        out.println("</script>");
	    return;
	}
}

String wo_id = "";
String wo_status = "";
String pr_name = "";
String pr_id = "";
String pr_url = "";
String us_id = "";
String us_uid = "";
String status = "";
String deptName = "";//部门名
String beginTime = "";//收到时间
String endTime = ""; //办结时间
String timeLimit = "";
String isOverTime = "";
String sendDept = "";
String sqlStr = "";
Vector vPage = null;
Hashtable content = new Hashtable();
Hashtable new_content = new Hashtable();

CDataCn dCn = null;
CDataImpl dImpl = null;

try{
dCn = new CDataCn();
dImpl = new CDataImpl(dCn); 
User user = (User)session.getAttribute("user");
if(user!= null) {
	us_id=user.getId();
	us_uid = user.getUid();
}else{
	user = new User();
	loginFlag = user.loginWSB(CBase64.getDecodeString(us_uidN),CBase64.getDecodeString(us_pwdN),"o27");
	if(loginFlag){
		session.setAttribute("user",user);
		us_id=user.getId();
		us_uid = user.getUid();
	}
}
String url = "";
//下面是未读信息
 String sql = "select count(*) as new_num from tb_message where ma_receiverId='"+us_id+"' and ma_sendtime+10>SYSDATE and ma_isnew='"+1+"'";
 String new_num="";
 new_content=dImpl.getDataInfo(sql);
 if(new_content!=null){
 	new_num = new_content.get("new_num").toString();
 }
%>

<link href="images/newWebMain.css" rel="stylesheet" type="text/css" />
<link href="images/main.css" rel="stylesheet" type="text/css" />
<table width="760" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td height="18"></td>
  </tr>
  <tr>
    <td height="1" bgcolor="#C7C7C7"></td>
  </tr>
  <tr>
    <td background="images/usercenterNEW_bg04.gif"><table width="734" border="0" align="center" cellpadding="0" cellspacing="0">
      <tr>
        <td height="10"></td>
      </tr>
      <tr>
        <td align="left" valign="top"><table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td width="166" height="52" align="left" valign="top"><img src="images/usercenterNEW_bg06.jpg" width="143" height="43" /></td>
            <td align="left" valign="top"><table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td height="5"></td>
              </tr>
              <tr>
                <td height="21" align="left" valign="top">欢迎您，尊敬的<font color="#AD0000"><%if(user.getUserName() != null) out.print(user.getUserName());%></font>用户！</td>
              </tr>
              <tr>
                <td align="left" valign="top"><font color="#0004BB">[ <a href="/website/usercenter/index.jsp"><font color="#0004BB">用户首页</font></a> | <a href="/website/login/Logout.jsp"><font color="#0004BB">注销</font></a> | <%
							String eurl = "";
							if(user!=null){
							String ws_id =user.getWsid();
							if(ws_id.equals("o27")){
								eurl="/website/usermanage/Modifyo27.jsp";
							}else{
								eurl="/website/usermanage/Modify.jsp";
							}
							}
						%><a href="<%=eurl%>"><font color="#0004BB">用户信息维护</font></a> ]</font></td>
              </tr>
            </table></td>
            <td width="205" align="right" valign="bottom"><table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td align="right" valign="bottom"><a href="/website/pudongForum/index.jsp"><img src="images/usercenterNEW_icon03.jpg" width="100" height="30" border="0" /></a></td>
                <td width="5"></td>
                <td align="right" valign="bottom"><a href="/website/dxpd/index.jsp"><img src="images/usercenterNEW_icon02.jpg" width="100" height="30" border="0" /></a></td>
              </tr>
            </table></td>
          </tr>
        </table></td>
      </tr>
      <tr>
	  <%
	  //update by yo 2007
		  String meSql="select sj_desc from tb_subject where sj_dir='dxpd'";
		  Hashtable contentyu = (Hashtable)dImpl.getDataInfo(meSql);
		  String sj_desc="";
		  if(contentyu!=null){
				sj_desc=contentyu.get("sj_desc").toString(); //用户记录表中的tb_usertake中的字段ut_id主键
	 		}
	  %>
	  <td height="32" valign="middle" background="images/usercenterNEW_bg05.gif"><marquee scrollamount=2><a href="tz.htm" target="_blank">浦东外事办关于调整“取件时间”的重要通知</a>&nbsp;&nbsp;&nbsp;&nbsp;<a href="http://www.pudong.gov.cn/website/dxpd/TakeNoteThird.jsp?hello=bangding&sj_dir=lmtake&pardir=dxpd">欢迎订阅短信服务的互动反馈栏目，您将通过手机短信免费获得办事咨询等反馈提醒。</a>
        </marquee></td>
      </tr>
      <tr>
        <td align="left" valign="top"><table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td width="179" valign="top"><table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td height="18" background="images/usercenterNEW_table01.gif"></td>
              </tr>
              <tr>
                <td background="images/usercenterNEW_table03.gif"><table width="149" border="0" align="center" cellpadding="0" cellspacing="0">
                  <tr>
                    <td height="9" colspan="2"></td>
                    </tr>
                  <tr>
                    <td width="36" align="center" valign="top"><img src="images/usercenterNEW_icon04.gif" width="18" height="14" /></td>
                    <td width="121" height="25" align="left" valign="middle"><a href="/website/connection/index_msgList.jsp" target="main" ><font color="#0655A2"><strong class="f14">最新反馈信息</strong></font><font color="red">[<%=new_num%>]</font></a></td>
                  </tr>
                  <tr>
                    <td height="7" colspan="2" align="left" valign="top"><img src="images/usercenterNEW_line02.gif" width="113" height="1" /></td>
                    </tr><%
													if(user!=null){
													String ws_id =user.getWsid();
													if(ws_id.equals("o27")){
												%>
                  <tr>
                    <td align="center" valign="top"><img src="images/usercenterNEW_icon05.gif" width="19" height="18" vspace="2" /></td>
                   <td height="25" align="left" valign="middle"><a href="/website/usercenter/centerinfo.jsp?typeid=2"><font color="#0655A2"><strong class="f14">申请办事证书</strong></font></a></td>
                  </tr>
                  <tr>
                    <td height="7" colspan="2" align="left" valign="top"><img src="images/usercenterNEW_line02.gif" width="113" height="1" /></td>
                    </tr>
                  <tr>
                    <td align="center" valign="top"><img src="images/usercenterNEW_icon06.gif" width="20" height="18" vspace="1" /></td>
                    <td height="25" align="left" valign="middle"><a href="/website/usercenter/zcList.jsp?typeid=1"><font color="#0655A2"><strong class="f14">暂存事项</strong></font></a></td>
                  </tr><%							
												}
											}
											%>
                  <tr>
                    <td height="1" colspan="2"></td>
                    </tr>
                </table></td>
              </tr>
              <tr>
                <td height="6" background="images/usercenterNEW_table04.gif"></td>
              </tr>
              <tr>
                <td height="10"></td>
              </tr>
            </table>
              <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                  <td height="6" background="images/usercenterNEW_table02.gif"></td>
                </tr>
                <tr>
                  <td valign="top" background="images/usercenterNEW_table03.gif"><table width="157" border="0" align="center" cellpadding="0" cellspacing="0">
                    <tr>
                      <td height="13" colspan="2"></td>
                      </tr>
                    <tr>
                      <td width="24" height="28" align="left" valign="top"><img src="images/usercenterNEW_icon08.gif" width="16" height="16" /></td>
                      <td align="left" valign="top"><font color="#072997"><a href="/website/policy/mailWSZX.jsp"><font color="#072997">我要咨询</font></a> | <a href="/website/usercenter/UserList.jsp"><font color="#072997">办事</font></a> | <a href="/website/supervise/apply.jsp?sj_dir=JJTS&pardir=supervise"><font color="#072997">投诉</font></a></font></td>
                    </tr>
                    <tr>
                      <td height="24" align="left" valign="top"><img src="images/usercenterNEW_icon07.gif" width="16" height="16" /></td>
                      <td align="left" valign="top"><a href="/website/connection/infoOpenList.jsp" target="main"><font color="#072997">依申请公开</font></a></td>
                    </tr>
                  </table></td>
                </tr>
                <tr>
                  <td height="6" background="images/usercenterNEW_table04.gif"></td>
                </tr>
                <tr>
                  <td height="10"></td>
                </tr>
              </table>
              <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                  <td height="6" background="images/usercenterNEW_table02.gif"></td>
                </tr>
                <tr>
                  <td valign="top" background="images/usercenterNEW_table03.gif"><table width="157" border="0" align="center" cellpadding="0" cellspacing="0">
                    <tr>
                      <td height="13" colspan="2"></td>
                    </tr>
                    <tr>
                      <td height="24" colspan="2" align="right" valign="top"><img src="images/usercenterNEW_icon09.gif" width="142" height="13" /></td>
                      </tr>
                    <tr>
                      <td width="24" height="28" align="left" valign="top"><img src="images/usercenterNEW_icon12.gif" width="16" height="16" /></td>
                    <%  //在办事项
                    	new_num="0";
                    	sql = "select count(*) as new_num from tb_work a,tb_proceeding b where a.us_id='"+us_id+"' and a.pr_id=b.pr_id  and a.wo_status in('0','1','2','8') ";
											new_content=dImpl.getDataInfo(sql);
											if(new_content!=null){
												new_num = new_content.get("new_num").toString();
											}
										%>
                      <td align="left" valign="top"><font color="#072997"><a href="/website/usercenter/indexlist1.jsp"  target="main"><font color="#072997">在办事项</font><font color="red">[<%=new_num%>]</font></a>| <a href="/website/usercenter/indexlist2.jsp" target="main" ><font color="#072997">已办事项</font></a></font></td>
                    </tr>
                    <tr>
                      <td height="24" colspan="2" align="right" valign="top"><img src="images/usercenterNEW_icon10.gif" width="142" height="13" /></td>
                      </tr>
                    <tr>
                      <td width="24" height="28" align="left" valign="top"><img src="images/usercenterNEW_icon13.gif" width="16" height="16" /></td>
                       <%  //在办投诉
                    	new_num="0";
                    	sql = "select count(*) as new_num from tb_connwork a,tb_connproc b where a.us_id='"+us_id+"' and a.cw_status in('1','2','8') and a.cp_id=b.cp_id and (b.cp_id in('o4','o5','o8','o9','o10','o1126') or b.cp_upid in('o4','o5','o10')) ";
												new_content=dImpl.getDataInfo(sql);
												if(new_content!=null){
												new_num = new_content.get("new_num").toString();
												}
											%>
                      <td  align="left" valign="top"><font color="#072997"><a href="/website/connection/SuperviseList1.jsp" target="main" ><font color="#072997">在办投诉</font><font color="red">[<%=new_num%>]</font></a>| <a href="/website/connection/SuperviseList2.jsp" target="main"><font color="#072997">已办投诉</font></a></font></td>
                    </tr>
                    <tr>
                        <%  //在办信件
                    		new_num="0";
                    		sql = "select count(*) as new_num from tb_connwork a,tb_connproc b where a.us_id='"+us_id+"' and a.cw_status in('1','2','8') and a.cp_id=b.cp_id and b.cp_id not in (select cp_id from tb_connproc where cp_id in('o4','o5','o8','o9','o10') or cp_upid in ('o4','o5','o10')) ";
											  new_content=dImpl.getDataInfo(sql);
											  if(new_content!=null){
											  new_num = new_content.get("new_num").toString();
											  }
											%>
                      <td width="24" height="28" align="left" valign="top"><img src="images/usercenterNEW_icon14.gif" width="16" height="16" /></td>
                      <td  align="left" valign="top"><font color="#072997"><a href="/website/connection/PolicyList1.jsp" target="main" ><font color="#072997">在办信件</font><font color="red">[<%=new_num%>]</font></a>| <a href="/website/connection/PolicyList2.jsp" target="main"><font color="#072997">已办信件</font></a></font></td>
                    </tr>
                    <tr>
                      <td height="24" colspan="2" align="right" valign="top"><img src="images/usercenterNEW_icon11.gif" width="142" height="13" /></td>
                      </tr>
                    <tr>
                      <td height="24" align="left" valign="top"><img src="images/usercenterNEW_icon13.gif" width="16" height="16" /></td>
                      <td align="left" valign="top"><font color="#072997"><a href="forumrevert.jsp" target="main"><font color="#072997">我的回复</font></a> | <a href="forumcollection.jsp" target="main"><font color="#072997">我的收藏</font></a></font></td>
                    </tr>

                  </table></td>
                </tr>
                <tr>
                  <td height="6" background="images/usercenterNEW_table04.gif"></td>
                </tr>
              </table></td>
            <td width="15"></td>
            <td width="540" valign="top">
			    <table width="100%" height="400" border="0" cellspacing="0" cellpadding="0">				
                  <tr>
                    <td valign='top' ><iframe src="/website/connection/index_msgList.jsp" width="100%" height="100%" scrolling="no" frameborder="0" allowtransparency="yes" name="main"></iframe></td>
                  </tr>
                </table>
			</td>
          </tr>
        </table></td>
      </tr>
      <tr>
        <td height="10"></td>
      </tr>
    </table></td>
  </tr>
  <tr>
    <td height="1" bgcolor="#C7C7C7"></td>
  </tr>
  <tr>
    <td height="10"></td>
  </tr>
</table>
<%@include file="/website/include/bottom_user.jsp"%>
<%
//漂浮框
	Adv ad = new Adv(dCn);
	String adcontent = ad.ShowAdv("userCenterFloat");
	out.println(adcontent);
}
catch(Exception e){
	out.print(e.toString());
}
finally{
	dImpl.closeStmt();
	dCn.closeCn(); 
}
%>