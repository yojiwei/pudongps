<%@page contentType="text/html; charset=GBK"%>
<%@ include file="/website/include/import.jsp" %>

<%
  //Update 20081017
  CDataCn dCn = null;//类库，连接数据库
  CDataImpl dImpl = null;
  
  String sqlStr = "";//sql语句
  Vector vPage = null;//取结果集
  Hashtable content = null;//取单条记录
  
  String us_tel = "";
  String us_email = "";
  String cw_id = "";//表单id

String ApplyTime="";
String FinishTime="";
String applyingname="";   //投诉人
String applyingdept="";   //投诉单位
String appliedname="";    //被投诉人
String applieddept="";    //被投诉单位
String FeedBack="";      // 回复投诉
String Subject="";       //主题
String Content="";       //内容
String telStr="";        //联系电话
String mailStr="";	     //电子邮件
String us_id = "";//用户id
String us_name = "";//用户姓名
String readStatus = ""; //修改状态
String Status = "";
String strStatus = "";
int cw_status;
String isuse = "";

  String sj_dir = "";//取参数
  sj_dir = CTools.dealString(request.getParameter("sj_dir")).trim();//导航栏要用到 subLoaction.jsp  
  cw_id=CTools.dealString(request.getParameter("cw_id")).trim();

  if(sj_dir.equals("")){
     sj_dir = "policy_WSZX";
  }	
  String cpValue = "";
  String get_cp_id = "";
  String cp_id = "";
  String cp_name = "";
  String dt_name = "";//由参数dt_name来得到get_cp_id  
  dt_name = CTools.dealString(request.getParameter("dt_name")).trim();
  cpValue = CTools.dealString(request.getParameter("cpValue")).trim();
  if(!dt_name.equals("")){
	String sql_dt = "SELECT c.cp_id FROM tb_connproc c,tb_deptinfo d WHERE c.dt_id=d.dt_id AND c.cp_upid='o7' AND d.dt_name LIKE '%"+dt_name+"%'";
	Hashtable content_dt = dImpl.getDataInfo(sql_dt);
	if(content_dt!=null){
	  get_cp_id = content_dt.get("cp_id").toString();
	}
	
  }else{
		get_cp_id = cpValue;	
	}
  
  //if(!dt_name.equals(""))
  
  try{
     dCn = new CDataCn();
	 dImpl = new CDataImpl(dCn);
	 
	 User user = (User)session.getAttribute("user");
	 
	 if(user != null){
	    us_id = user.getId(); 
	 }
//update by yoyo

if (!cw_id.equals("")){
	 sqlStr="select tc.cw_id,tc.cw_applyingname,tc.cw_telcode,tc.cw_applyingdept,tc.cw_appliedname,tc.cw_email,tc.cw_applieddept,to_char(tc.cw_applytime,'yyyy-mm-dd hh24:mi:ss') cw_applytime,to_char(tc.cw_finishtime,'yyyy-mm-dd hh24:mi:ss') cw_finishtime,tc.cw_subject,tc.cw_content,tc.cw_feedback,tc.cw_status,tp.cp_name from tb_connwork tc,tb_connproc tp where tp.cp_id=tc.cp_id and tc.cw_id='"+cw_id+"' and tc.us_id = '" + us_id + "'";
	 content = dImpl.getDataInfo(sqlStr);
	 if(content!=null)
	 {
		 readStatus="readonly";
		 cw_id=content.get("cw_id").toString();
		 ApplyTime=content.get("cw_applytime").toString();
		 FinishTime=content.get("cw_finishtime").toString();
		 if(FinishTime.equals("")) FinishTime = "未完成";
		 applyingname=content.get("cw_applyingname").toString();
		 applyingdept=content.get("cw_applyingdept").toString();
		 appliedname=content.get("cw_appliedname").toString();
         applieddept=content.get("cw_applieddept").toString();
		 telStr=content.get("cw_telcode").toString();
		 mailStr=content.get("cw_email").toString();				
		 Subject=content.get("cw_subject").toString();
		 Content=content.get("cw_content").toString();
		 FeedBack=content.get("cw_feedback").toString();
		 Status=content.get("cw_status").toString();
		 cw_status = Integer.parseInt(Status);
		 switch(cw_status)
			{
			 case 1:
				strStatus = "待处理";
				break;
			 case 2:
				strStatus = "处理中";
				break;
			 case 3:
				strStatus = "已完成";
				break;
			 case 8:
				strStatus = "协调中";
				break;
			 default:
				strStatus = "";
			}
	}
 }






//update by yoyo





	 
	 if(!us_id.equals("")){
	   sqlStr = "SELECT us_name,us_tel,us_email FROM tb_user WHERE us_id ="+"'"+us_id+"'";
	   content = dImpl.getDataInfo(sqlStr);
	   
	   us_name = content.get("us_name").toString();
	   us_tel = content.get("us_tel").toString();
	   us_email = content.get("us_email").toString();
	 }
     
	 String is_use = dImpl.getInitParameter("isuseful");//标识(内网和外网)前台的提交页面是否可用！
     
     if(!is_use.equals("yes")){
  	    isuse = "none";	
     } 


//update by yoyo




%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title>上海 · 浦东</title>
<link href="../images/newWebMain.css" rel="stylesheet" type="text/css" />
<script language="JavaScript" type="text/JavaScript">
<!--
function MM_preloadImages() { //v3.0
  var d=document; if(d.images){ if(!d.MM_p) d.MM_p=new Array();
    var i,j=d.MM_p.length,a=MM_preloadImages.arguments; for(i=0; i<a.length; i++)
    if (a[i].indexOf("#")!=0){ d.MM_p[j]=new Image; d.MM_p[j++].src=a[i];}}
}
//-->
</script>
<script language="javascript">
	function doAction() {
		if (formWSZX.tel.value == "" && formWSZX.email.value == "")  {
			alert("联系电话和电子邮件必须有一项填写！");	
			formWSZX.tel.focus();
			return false;
		}
		if (formWSZX.conntype.value == "") {
			alert("请选择咨询对象！");
			formWSZX.conntype.focus();
			return false;
		}
		if (formWSZX.subject.value == "") {
			alert("请输入邮件主题！");
			formWSZX.subject.focus();
			return false;
		}
		if (formWSZX.content.value != "") {
			value = formWSZX.content.value;
			var chineseLen = getChineseLength(value);
			if (chineseLen < 10) {
				alert("投诉内容不能少于十个汉字！");
				formWSZX.content.focus();
				return false;
			}
		}
		if (formWSZX.content.value.length > 201) {
			alert("您输入的内容过长，请精简！");
			formWSZX.content.focus();
			return false;
		}
		validateForm(formWSZX);
	}
</script>
<link href="style.css" rel="stylesheet" type="text/css" />
</head>

<body leftmargin="0" topmargin="0">

<!-- validate the form -->
<script language="javascript" src="/website/js/common.js"></script><!--provide Function: isEmail()-->
<script language="javascript" src="/website/js/check.js"></script>
<script language="javascript" src="/website/js/dealForm.js"></script>

<%@ include file="/website/iframe/index/indexHead.jsp"%>
<%@ include file="/website/iframe/sub/subNewTopNavi.jsp" %> 

<table width="1002" border="0" cellspacing="0" cellpadding="0">
  <tr> 
    <td width="778" valign="top">     
      <table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr>
		  
            <td width="200" height="636" align="center" valign="top" background="../images/sub_leftBg.gif">
					<%@include file="include/left.jsp"%>
			  <table width="100%" border="0" cellspacing="0" cellpadding="0">
                  <tr>
                    <td height="30"></td>
                  </tr>
              </table>
			  <!--
			  <table width="160" border="0" cellspacing="0" cellpadding="0">
	           <tr>
	             <td height="98" align="right">
				    <a href="#">
					  <img src="../images/new_investInfo_link01.gif" width="156" height="61" border="0" />
					</a>
				 </td>
	           </tr>
              </table>
			  -->
			</td>
			  
            <td align="center" valign="top">
			 
			  <%@ include file="/website/iframe/sub/subLocation.jsp" %>
              <%@include file="include/flash.jsp"%>
              <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                  <td height="20"></td>
                </tr>
              </table>
              <table width="550" border="0" cellspacing="0" cellpadding="0">
                <tr>
                  <td height="26" background="../images/new_investInfo_packTop.gif"></td>
                </tr>
                <tr>
                  <td align="center" valign="top" background="../images/new_investInfo_packBg.gif"><table width="92%" border="0" cellspacing="4" cellpadding="0">
                    <tr>
                      <td width="22" height="22" valign="top"><img src="../images/ico02.gif" width="12" height="12" vspace="4" /></td>
                      <td class="f12WH">如果您已是注册用户，请先登录 <a href="/website/usercenter/index.jsp"><strong><font color="#E50808">用户中心</font></strong></a> 以获得在线回复。</td>
                    </tr>
                    <tr>
                      <td height="22" valign="top"><img src="../images/ico02.gif" width="12" height="12" vspace="4" /></td>
                      <td class="f12WH">如果您不是注册用户，请正确填写您的E-mail地址以获得在线回复；或者<a href="/website/register/regfirst.jsp" class="red">注册</a>成为“上海浦东”的用户登录。</td>
                    </tr>
                    <tr>
                      <td height="22" valign="top"><img src="../images/ico02.gif" width="12" height="12" vspace="4" /></td>
                      <td class="f12WH">请务必明确选择咨询对象，这样您的咨询可尽快地到达相应部门。</td>
                    </tr>
                    <tr>
                      <td height="22" valign="top"><img src="../images/ico02.gif" width="12" height="12" vspace="4" /></td>
                      <td class="f12WH">禁止上传.exe、.bat、.jsp类型的附件。</td>
                    </tr>
                  </table></td>
                </tr>
                <tr>
                  <td height="28" background="../images/new_investInfo_packBottom.gif"></td>
                </tr>
              </table>
              <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                  <td height="30"></td>
                </tr>
              </table>
			  <form name="formWSZX" action="mailWSZXResult.jsp" method="post" enctype="multipart/form-data">			 
              <table width="480" border="0" cellspacing="0" cellpadding="2">
                <tr>
                  <td width="100" height="24">姓名：</td>
                  <td width="114"><input name="name" type="text" class="input-mailBox" size="14" maxlength="50" value="<%=us_name%>" /></td>
                  <td width="100" height="24">联系地址：</td>
                  <td width="126"><input name="company" type="text" maxlength="50" class="input-mailBox" size="20" /></td>
                </tr>
                <tr>
                  <td height="24">联系电话：</td>
                  <td><input name="tel" type="text" class="input-mailBox" maxlength="25" size="14" value="<%=us_tel%>" /></td>
                  <td height="24">电子邮件：</td>
                  <td><input name="email" type="text" class="input-mailBox" size="20" maxlength="50" value="<%=us_email%>" /></td>
                </tr>
				<tr>
                  <td height="24">信访目的：</td>
                  <td colspan="3"><select name="md" class="input-mailBox" style="width:106px">
                          <%
						sqlStr = "select dd_name,dd_code from tb_datatdictionary where dd_parentid in (select dd_id from tb_datatdictionary where dd_code = 'xfmd')";
						  vPage = dImpl.splitPage(sqlStr,request,250);
						if(vPage!=null)
						{
							for(int i=0;i<vPage.size();i++)
							{
								content = (Hashtable)vPage.get(i);
						  %>
                            <option value="<%=content.get("dd_code").toString()%>"><%=content.get("dd_name").toString()%></option>
							<%}}%>
                          </select></td>
                </tr>
                <tr>
                  <td height="24">咨询对象：</td>
                  <td colspan="3">
				  
				     <select name="conntype" class="input-mailBox" style="width:200px">
						<option value="">--请选择--</option>
					    <%
						  sqlStr = "select c.cp_id,c.cp_name from tb_connproc c,tb_deptinfo d where c.dt_id=d.dt_id and c.cp_upid='o7' order by cp_sequence,cp_id";
						  vPage = dImpl.splitPage(sqlStr,request,100);
						  if(vPage != null){
						     for(int i = 0;i < vPage.size(); i ++ ){
							    content = (Hashtable)vPage.get(i);
								cp_id = content.get("cp_id").toString();
								cp_name = content.get("cp_name").toString();
						%>
						        <option value="<%=cp_id%>" <%if(get_cp_id.equals(cp_id)){out.print("selected");}%>><%=cp_name%></option> 
						<%		
							 }//for 						  
	     				  }//if(vPage != null)						  
						%>                          
                     </select>
					 
				  </td>
                </tr>
                <tr>
                  <td height="24">邮件主题：</td>
                  <td colspan="3"><input name="subject" type="text" class="input-mailBox" maxlength="50" size="56" value="<%=Subject%>"  <%=readStatus%>/></td>
                </tr>
                <%
					if  (!cw_id.equals("")){
						String sql_att = "select aa_id,aa_filename from tb_appealattach where cw_id='"+cw_id+"'";
						Vector page_att = dImpl.splitPage(sql_att,10,1);
						if(page_att!=null)
						{
								for(int i=0;i<page_att.size();i++)
								{
								Hashtable content_att = (Hashtable)page_att.get(i);
								String aa_id = content_att.get("aa_id").toString();
								String file_name = content_att.get("aa_filename").toString();
								if(i % 2 == 0)  out.print("<tr class=\"line-even\">");
								else out.print("<tr class=\"line-odd\">");
			    %>
								<!-- <tr> -->
								<td align="left">附　　件：</td>
								<td colspan="3"><a href="/website/include/downloadAPPEAL.jsp?aa_id=<%=aa_id%>" target="_blank"><%=file_name%></a></td>
							   </tr>
				<%
								}
						}
						else
						{
				%>	
								<tr>
								    <td align="left">附　　件：</td>
								    <td colspan="3"><input name="attachment" type="file" class="input-mailBox" size="32" <%=readStatus%>></td>
							   </tr>
				 <%
					    }}
				 %>
                <tr>
                  <td>内容：</td>
                  <td colspan="3"><textarea name="content" cols="60" rows="7" class="textarea-mailBox"><%=Content%></textarea></td>
                </tr>
				<tr>
				  <td align="left" nowrap>是否原意公开：</td>
				  <td colspan="3" align="left">
					<input type="radio" name="ispublish" value="0" checked/>
					公开
					<input type="radio" name="ispublish" value="2" />
					不公开</td>
				</tr>
				<tr>
				  <td align="left" nowrap>验证码：</td>
				  <td colspan="3" align="left"><input name="rand" type="text" class="input-mailBox" style="width:34px;height:20px" maxlength="4"/>
					<img src="/connonline/imgcheck/image.jsp" width="44" height="20" /></td>
				</tr>
                <tr>
                  <td height="30" colspan="4" align="center"><table width="160" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                      <td align="center">
						<%if(cw_id.equals("")){%>
					    <div id="function_buttons" align="center" style="display:<%=isuse%>">						
					      <img id="button_sub" src="../images/bt_submit01.gif" width="45" height="21" border="0" onclick="doAction()" />
						   &nbsp;&nbsp;&nbsp;&nbsp;				 
						  <img src="../images/bt_reset01.gif" width="45" height="21" border="0" onclick="document.formWSZX.reset()" />
					    </div>
						<%}else{%>
						<input value="返回" type="button"  size="6" id="button6" name="button6" class="bttn" onclick="javascript:history.go(-1)">&nbsp;
						<%}%>
						<input type="hidden" name="Type" value="add"><!--新增操作-->
						<input type="hidden" name="cw_id" value="<%=cw_id%>"><!--表单id,PK-->
						<!-- <input type="hidden" name="cp_id" value="mailWSZX"> --> <!--事项id-->
					  </td>
                    </tr>
                  </table></td>
                </tr>
              </table>
		      </form> 
              <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                  <td height="30"></td>
                </tr>
              </table></td>
          </tr>
      </table>
        <table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td height="1"></td>
          </tr>
        </table>
		<%@ include file="/website/iframe/index_bottom.jsp" %>
		
    </td>
    <td width="9" background="../images/index_addLeftNewBg.gif"></td>
	
    <td align="center" valign="top" background="../images/index_addBg.gif"> 
        <%@include file="/website/iframe/sub/subRight.jsp"%>  
    </td>
	  
  </tr>
</table>
</body>


<%
  }catch(Exception e){
     out.print(e.toString());
  }finally{
     dImpl.closeStmt();
	 dCn.closeCn();  
  }
%>

