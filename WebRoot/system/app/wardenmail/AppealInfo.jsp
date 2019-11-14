<%@page contentType="text/html; charset=GBK"%>
<%@include file="/system/app/skin/head.jsp"%>
<%
 	response.setHeader("Cache-Control","no-store");
  response.setHeader("Pragrma","no-cache");
  response.setDateHeader("Expires",0);
  
  CMySelf self = (CMySelf)session.getAttribute("mySelf");
  
  String selfdtid = String.valueOf(self.getDtId());
  String sender_id = String.valueOf(self.getMyID());
  //
CDataCn dCn = null;
CDataImpl dImpl = null;
try{
dCn = new CDataCn();
dImpl = new CDataImpl(dCn);
//
		String cw_typecode = "";
    String cw_id = "";//编
    String cp_id = "";//项目编号
    String cw_number = "";//事项编号
    String us_id = "";//用户id
    String is_us = "否";//是否注册用户
    String strTel = "";//投诉人电话
    String applyname = "";//投诉人姓名
    String applytime = "";//投诉时间
    String applydept = "";//投诉人单位
    String strEmail = "";//投诉人邮件
    String appealname = "";//被投诉人姓名
    String appealdept = "";//被投诉人单位
    String strSubject = "";//投诉主题
    String strContent = "";//投诉内容
		String strfeedback = "";//投诉反馈
    String feedbackType = "";//投诉反馈
		String strchongfu ="";//重复信件
    int cw_status;//投诉状态
    String cw_statusStr = "";
    String strStatus = "";//投诉状态
    String strSql = "";
    String sqlcorr = "";//判断是否转办
    String receivername = "";//转办部门
    String dept_name = "";
    String wd_name = "";//区长
    String co_corropioion = "";//转办部门意见
    String co_id = "";//转办编号
    String de_requesttime = "";//转办时限
    String wd_id = "";
    String cw_ygname = "";
    String cw_parentid = "";
		String cw_emailtype = "";
		String cp_id_conn = "";
    String cp_name_conn = ""; 
		String cw_trans_id = "";
		String sqlStr = "";
	 	Vector vPage = null;
	 	String Sql_class = "";
   	Vector vPage1 = null;
		String dd_name = "" ;
		String dd_id= "" ;//投诉类型
   	String cw_ispublish = "";//用户是否同意发布
	
    cw_statusStr = request.getParameter("cw_status").toString();
    cw_status = Integer.parseInt(cw_statusStr);
	
    switch(cw_status)
   {
    case 1:
		 strStatus = "待处理";
		 dept_name = "e.de_senddeptid";
		 break;
    case 2:
		 strStatus = "处理中";
		 break;
    case 3:
		 strStatus = "已完成";
		 dept_name = "e.de_senddeptid";
		 feedbackType = "readonly";
		 break;
    case 8:
		 strStatus = "协调中";
		 dept_name = "e.de_receiverdeptid";
		 break;
	case 9:
		 strStatus = "垃圾信件";
		 dept_name = "e.de_senddeptid";
		 feedbackType = "readonly";
		 break;
	case 12:
		 strStatus = "重复信件";
		 dept_name = "e.de_senddeptid";
		 feedbackType = "readonly";
     break;
    default:
		 strStatus = "";
  }
  cw_id = request.getParameter("cw_id").toString();
  sqlcorr = "select co_id from tb_correspond where cw_id='" + cw_id + "'";//判断是否转办

  Vector vectorPage = dImpl.splitPage(sqlcorr,request,20);

  if(vectorPage!=null){//edit by arin
   strSql = "select c.wd_id, c.cw_id,c.cw_ygname,c.us_id,c.cw_ispublish,c.dd_id,c.cw_emailtype,c.cw_telcode,c.cw_parentid,c.cp_id,c.cw_typecode,c.cw_applyingname,c.cw_applyingdept,c.cw_email,c.cw_appliedname,c.cw_applieddept,";
   strSql += "c.cw_subject,c.cw_content,c.cw_feedback,c.cw_chongfu,c.cw_status,c.cw_number,c.dd_id,c.cw_ispublish,to_char(c.cw_applytime,'yyyy-mm-dd hh24:mi:ss') cw_applytime,d.co_question,d.co_mainopioion,d.co_corropioion,d.co_status,";
   strSql += "e.de_senddeptid,e.de_receiverdeptid,e.de_isovertime,e.de_requesttime,f.dt_name,w.wd_name ";
   strSql += "from tb_connwork c,tb_correspond d,tb_documentexchange e,tb_deptinfo f,tb_warden w where c.wd_id=w.wd_id and c.cw_id=d.cw_id and d.co_id=e.de_primaryid and " + dept_name + "=f.dt_id and c.cw_id='" + cw_id + "'";
  } 
  else {
   strSql = "select c.wd_id, c.cw_id,c.cw_ygname,c.us_id,c.cw_telcode,c.cw_parentid,c.cw_emailtype,c.cw_ispublish,c.dd_id,c.cp_id,c.cw_typecode,cw_number,c.cw_applyingname,to_char(cw_applytime,'yyyy-mm-dd hh24:mi:ss') cw_applytime,c.cw_applyingdept,c.cw_email,c.cw_appliedname,c.cw_applieddept,c.cw_subject,c.dd_id,c.cw_ispublish,c.cw_content,c.cw_feedback,c.cw_chongfu,c.wd_id,c.cw_ygname from tb_connwork c where  c.cw_id='"+ cw_id +"'";
  }
  Hashtable content = dImpl.getDataInfo(strSql);

  if(content!=null)
	{
  cw_id = content.get("cw_id").toString();
  us_id = content.get("us_id").toString();
  if(!us_id.equals(""))
  {
   is_us = "是";
  }
  cw_typecode = content.get("cw_typecode").toString();//edit by arin
  cp_id = content.get("cp_id").toString();
  wd_id = content.get("wd_id").toString();
  cw_ygname = content.get("cw_ygname").toString();
	if(!cw_ygname.equals("")) {
		wd_name = cw_ygname;		
	}
	else {
		String st_wdname = "";
		//如果是阳光信箱查询对应的tb_subject表 
		if ("mailYGXX".equals(cp_id))
			st_wdname = "select sj_name as wd_name from tb_subject where sj_id = " + wd_id;
		else  
			st_wdname = "select wd_name from tb_warden where wd_id = '" + wd_id + "'";
		Hashtable ha_wdname = dImpl.getDataInfo(st_wdname);
		if(ha_wdname!=null) {
			wd_name=ha_wdname.get("wd_name").toString();
		}
		else {
			wd_name="已调任区长";
		}
	} 

  applyname = content.get("cw_applyingname").toString();
  applytime = content.get("cw_applytime").toString();
  applydept = content.get("cw_applyingdept").toString();
  strTel = content.get("cw_telcode").toString();
  strEmail = content.get("cw_email").toString();
  appealname = content.get("cw_appliedname").toString();
  appealdept = content.get("cw_applieddept").toString();
  cw_number = content.get("cw_number").toString();
  strSubject = content.get("cw_subject").toString();
  cw_emailtype = content.get("cw_emailtype").toString();
  cw_parentid = content.get("cw_parentid").toString();
  strContent = content.get("cw_content").toString();
  
  strchongfu = content.get("cw_chongfu").toString();
  strfeedback = content.get("cw_feedback").toString();

  dd_id = content.get("dd_id").toString();
  cw_ispublish = content.get("cw_ispublish").toString();
}
  if(vectorPage!=null)
  {
   if(content!=null)
	{
	   receivername = content.get("dt_name").toString();
	   co_corropioion = content.get("co_corropioion").toString();
	   de_requesttime = content.get("de_requesttime").toString();
	}
  }

	String sql_att = "select aa_id,aa_filename from tb_appealattach where cw_id = '"+cw_id+"'";
	Vector page_att = dImpl.splitPage(sql_att,10,1);
%>
<!-- 记录日志 -->
<%
String logstrMenu = "区长信件";
String logstrModule = "受理区长信件";
%>
<%@include file="/system/app/writelogs/WriteDetailLog.jsp"%>
<!-- 记录日志 -->
<%@include file="/system/app/skin/skin4/template/info_top.jsp"%>
<!--    模块名称开始    -->
受理区长信件
<!--    模块名称结束    -->
<%@include file="/system/app/skin/skin4/template/info_funtion.jsp"%>
<!--    功能按钮开始    -->

<!--    功能按钮结束    -->
<%@include file="/system/app/skin/skin4/template/info_main.jsp"%>
<!--    表单提交开始    -->
<table WIDTH="100%" CELLPADDING="0" cellspacing="0" BORDER="0">
  <form  method="post" name="sForm">
    <tr>
      <td width="100%" align="left" valign="top"><table class="content-table" height="1" width="100%">
          <tr class="line-odd">
            <td width="18%" align="right">发 送 人：</td>
            <td width="82%"><input type="text" class="text-line" name="applyname" maxlength="10" size="30" title="发送人" value="<%=applyname%>" readonly></td>
          </tr>
          <%
					  if(!"".equals(dd_id)){
					String sql_dd_name = "select dd_name from tb_datatdictionary where dd_code='"+dd_id+"'";
					Vector page_dd_name = dImpl.splitPage(sql_dd_name,1,1);
				  if(page_dd_name!=null)
			{
					for(int i=0;i<page_dd_name.size();i++)
					{
					Hashtable content_dd_name = (Hashtable)page_dd_name.get(i);
				    dd_name = content_dd_name.get("dd_name").toString();
					}
					}
					  %>
          <tr class="line-odd">
            <td width="18%" align="right">信访目的：</td>
            <td width="82%" align="left"><input type="text" class="text-line" name="dd_name" maxlength="10" size="30" title="信访目的" value="<%=dd_name%>" readonly></td>
          </tr>
          <%}%>
          <tr class="line-even">
            <td width="18%" align="right">单　　位：</td>
            <td width="82%"><input type="text" class="text-line" name="applydept" maxlength="10" size="30" value="<%=applydept%>" readonly></td>
          </tr>
          <tr class="line-odd">
            <td width="18%" align="right">联系电话：</td>
            <td width="82%"><input type="text" class="text-line" name="strTel" maxlength="100" size="30" value="<%=strTel%>" readonly>
            </td>
          </tr>
          <tr class="line-even">
            <td width="18%" align="right">电子邮件：</td>
            <td width="82%"><input type="text" class="text-line" name="strEmail" maxlength="10" size="30" value="<%=strEmail%>" readonly>
            </td>
          </tr>
          <tr class="line-odd">
            <td width="18%" align="right">是否注册用户：</td>
            <td width="82%"><input type="text" class="text-line" name="is_us" maxlength="100" size="30" title="注册用户" value="<%=is_us%>" readonly></td>
          </tr>
          <tr class="line-even">
            <td colspan="2" align="right">&nbsp;</td>
          </tr>
          <tr class="line-odd">
            <td width="18%" align="right"><%=cp_id.equals("mailYGXX") ? "阳光信箱" : "区长信箱"%>：</td>
            <td width="82%"><input type="text" class="text-line" name="wd_name" maxlength="10" size="30" title="区长信箱" value="<%=wd_name%>"readonly></td>
          </tr>
      <%
			String wd_from = wd_name;
		 if(cw_ygname.equals("")){
			if(wd_name.length()>1){
				wd_from = wd_name.substring(wd_name.length() - 3,wd_name.length())+"信箱";		
			}
			}

			%>
          <input type="hidden" name="wd_from"  value="<%=wd_from%>">
          <tr class="line-even">
            <td width="18%" align="right">信件主题：</td>
            <td width="82%"><input type="text" class="text-line" name="strSubject1" maxlength="10" size="30" value='<%=CTools.replace(strSubject,"\'","\"")%>' readonly>
              <textarea style="display:none" name = "strSubject"><%=strSubject%></textarea></td>
          </tr>
          <tr class="line-odd">
            <td align="right">信件内容：</td>
            <td><textarea class="text-area" name="strContent" cols="60" rows="6" title="信件内容" readonly><%=strContent%></textarea>
            </td>
          </tr>
          <%if("0".equals(cw_ispublish)){%>
          <tr class="line-even">
            <td width="18%" align="right">是否信息公开:</td>
            <td colspan="2" align="left"><input type="radio" name="ispublish" value="1" checked/>
              公开
              <input type="radio" name="ispublish" value="2" />
              不公开</td>
          </tr>
          <%}%>
          <%if("1".equals(cw_ispublish)){%>
          <tr class="line-even">
            <td width="18%" align="right">是否信息公开:</td>
            <td colspan="2" align="left">公开
          </tr>
          <%}%>
          <%
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
          <td align="right" width="18%">附件名称：</td>
            <td><a href="/website/include/downloadAPPEAL.jsp?aa_id=<%=aa_id%>" target="_blank"><%=file_name%></a></td>
          </tr>
          <%
					}
			}
			%>
          <tr class="line-even">
            <td align="right" colspan=2>&nbsp;</td>
          </tr>
          <tr class="line-even">
            <td align="right">来信编号：</td>
            <td><input type="text" class="text-line" name="cw_number" maxlength="100" size="30" value="<%=cw_number%>"></td>
          </tr>
          <tr class="line-odd">
            <td align="right">信件处理状态：</td>
            <td><%=strStatus%></td>
          </tr>
          <!--
		   add by  arin 2006-10-12-------------begin
		   -->
		   <tr class="line-even">
            <td align="right">信件内容分类：</td>
            <td><select name="classtype">
                <option value="">请选择分类</option>
                <%
						   Sql_class = "select cc_code,cc_name from tb_connclass order by cc_id ";
						 vPage1 = dImpl.splitPage(Sql_class,request,1000);
						  if (vPage1!=null){
						      for(int i=0;i<vPage1.size();i++){
								   Hashtable content1 = (Hashtable)vPage1.get(i);
								  String cc_code = content1.get("cc_code").toString();
								  String cc_name = content1.get("cc_name").toString();
								  
						  %>
                <option value="<%=cc_code%>"<%if(cc_code.equals(cw_typecode)) out.print("selected");%>><%=cc_name%></option>
                <%
						       }
						   }
						  %>
              </select>
            </td>
          </tr>
		  <%if(cw_status!=12){%>
          <tr class="line-odd">
            <td align="right">转交处理：</td>
            <td align="left"><select name="deptconn" onchange='setValue11();'>
                <option value="">请选择委办局</option>
                <option value="o5" <%=cw_trans_id.equals("o5") ? "selected" : ""%>>信访信箱</option>
                <option value="o4" <%=cw_trans_id.equals("o4") ? "selected" : ""%>>网上咨询－监察信箱</option>
                <%
                   Sql_class = "select cp_id,cp_name from tb_connproc where cp_upid='o7' order by dt_name";
                  vPage1 = dImpl.splitPage(Sql_class,request,100);
                  if (vPage1!=null)
                  {
                   for(int i=0;i<vPage1.size();i++)
                  {
                   Hashtable content1 = (Hashtable)vPage1.get(i);
                   cp_id_conn = content1.get("cp_id").toString();
                   cp_name_conn = content1.get("cp_name").toString();
                  %>
									<option value="<%=cp_id_conn%>" <%=cw_trans_id.equals(cp_id_conn) ? "selected" : ""%>><%=cp_name_conn%></option>
									<%
                   }
                   }
 						sqlStr="select c.cp_id, c.cp_name, c.dt_name from tb_connproc c, tb_deptinfo d where c.dt_id = d.dt_id and c.cp_upid = 'o10000' and c.cp_id !='o11895'  order by cp_id";
						//or c.cp_id = 'o10000'and d.dt_id = '11883'
            vPage = dImpl.splitPage(sqlStr,request,250);
						if(vPage!=null)
						{
							for(int j=0;j<vPage.size();j++)
							{
								 content = (Hashtable)vPage.get(j);
						  %>
                <option value="<%=content.get("cp_id").toString()%>"><%="街镇领导信箱－"+content.get("cp_name").toString()%></option>
                <%}}%>
              </select>
          </tr>
          <!--
			     add by  arin 2006-10-12-------------end
			    -->
          <tr class="line-even" width="100%">
            <td width="100%" colspan="2" align="left"><a onclick="javascript:Display(1)" style="cursor:hand"><img border="0" src="/system/images/topplus.gif" WIDTH="16" HEIGHT="16" id="InfoImg1"></a> 转办处理情况</td>
          </tr>
          <tr class="line-odd" id="Info1" style="display:none">
            <td align="left" height="20" colspan=2><table cellspacing="1" border="0" bgcolor="#ffffff" width="100%">
                <tr class="line-odd">
                  <td align="right" width="18%">转办部门：</td>
                  <td><%=receivername%>
                    <input type="hidden" name="receivername" value="<%=receivername%>"></td>
                </tr>
                <tr class="line-even">
                  <td align="right" width="18%">转办时限：</td>
                  <td><%=de_requesttime%> 天
                    <input type="hidden" name="de_requesttime" value="<%=de_requesttime%>"></td>
                </tr>
                <tr class="line-odd">
                  <td align="right" width="18%">转办部门意见：</td>
                  <td>
                 <textarea class="text-area" name="co_corropioion" cols="60" rows="6" title="转办部门意见" readonly><%=co_corropioion%></textarea></td>
                </tr>
              </table></td>
          </tr>
          <tr class="line-even" width="100%">
            <td width="100%" colspan="2" align="left"><a onclick="javascript:Display(2)" style="cursor:hand"><img border="0" src="/system/images/topplus.gif" WIDTH="16" HEIGHT="16" id="InfoImg2"></a> 信件回复：</td>
          </tr>
          <tr class="line-odd" id="Info2" style="display:none">
            <td align="left" height="20" colspan=2><table cellspacing="1" border="0" bgcolor="#ffffff" width="100%">
                <tr class="line-odd">
                  <td align="right" width="18%">信件反馈回复：</td>
                  <td valign="middle">
                  <textarea class="text-area" name="strFeedback" cols="60" rows="6" title="信件反馈" <%=feedbackType%>><%if(!strfeedback.equals("")||cw_status==3||cw_status==9) out.print(strfeedback); else{%>XXX同志，您好！
									　　您写给区长信箱的电子邮件已经收悉。受区长委托，我办已经在三个工作日内将您的编号为浦邮200900XXX的信件转交给浦东新区XXX，地址是：XXX，电话是：XXX。您可以向该单位信访部门查询处理情况。
									　　特此回复。
									
									
									　　中共上海市浦东新区委员会信访办公室
									　　上海市浦东新区人民政府信访办公室
									　　2009年XX月XX日
									<%}%>
									
				    			</textarea>
                    </td>
                  <td><font color="#EC004D">
                    <%if(strfeedback.equals("")){%>
                    （注：＃＃由信访处理人员根据实际情况替换）
                    <%}%></font></td>
                </tr>
				<input type="hidden" name="isOver" value=""/>
              </table></td>
          </tr>
		  <%}
		  if(cw_status==12||!strchongfu.equals("")){%>
		  <!--重复信件开始--->
		  <tr class="line-odd" width="100%">
            <td width="100%" colspan="2" align="left">重复信件回复：</td>
          </tr>
          <tr class="line-odd" id="Info3">
            <td align="left" height="20" colspan=2><table cellspacing="1" border="0" bgcolor="#ffffff" width="100%">
                <tr class="line-odd">
                  <td align="right" width="18%">重复信件回复：</td>
                  <td><textarea class="text-area" name="strChongfu" cols="60" rows="6" title="重复信件" <%if(cw_status==3)out.print(feedbackType);%>><%if(!strchongfu.equals("")||cw_status==12) out.print(strchongfu); else{%>
先生/女士：
您好！
    您发来的电子邮件已收悉。根据您反映的内容和《信访条例》的规定，我们已经将您的电子邮件转请XXXXXX阅处。
    感谢您对浦东新区的关心和支持。

             中共浦东新区委员会信访办公室 
             浦东新区人民政府信访办公室
<%out.println(new CDate().getThisday());%>
<%}%>
</textarea>
                    </td>
                  <td><font color="#EC004D">
                    <%if(strchongfu.equals("")){%>
                    （注：＃＃由信访处理人员根据实际情况替换）
                    <%}%></font></td>
                </tr>
				<input type="hidden" name="isOver" value="1"/>
              </table></td>
          </tr>
		  <!--重复信件结束--->
		  <%}%>
        </table></td>
    </tr>
    <tr class=outset-table>
      <td width="100%" align="right" colspan="2"><p align="center">
          <%
              switch(cw_status)
              {
               case 1:
                 //out.print("<input class='bttn' value='处理中' type='button' onclick='dealLetter(document.sForm)'  size='6' id='button1' name='button1'>&nbsp;");
                 //out.print("<input class='bttn' value='E-mail回复' type='button' onclick='directDeal(document.sForm)'  size='6' id='button1' name='button1'>&nbsp;");
                 //out.print("<input class='bttn' value='转办' type='button' onclick='dovalidate(document.sForm)'  size='6' id='button2' name='button2'>&nbsp;");
                 //out.print("<input class='bttn' value='处理完成' type='button' onclick='finish(document.sForm)'  size='6' id='button3' name='button3'>&nbsp;");
           out.print("<input class='bttn' value='重复信件' type='button' onclick='chongfu()'  size='6' id='button3' name='button3'>&nbsp;");
				   out.print("<input class='bttn' value='转到信访办' type='button' onclick='turnto()'  size='6' id='button3' name='button3'>&nbsp;");
				   out.print("<input class='bttn' value='垃圾信件' type='button' onclick='garbage(document.sForm)'  size='6' id='button3' name='button4'>&nbsp;");
                  break;
               case 2:
                 strStatus = "处理中";
				 //out.print("<input class='bttn' value='处理中' type='button' onclick='dealLetter(document.sForm)'  size='6' id='button1' name='button1'>&nbsp;");
                 //out.print("<input class='bttn' value='E-mail回复' type='button' onclick='directDeal(document.sForm)'  size='6' id='button1' name='button1'>&nbsp;");
                 //out.print("<input class='bttn' value='转办' type='button' onclick='dovalidate(document.sForm)'  size='6' id='button2' name='button2'>&nbsp;");
                 //out.print("<input class='bttn' value='处理完成' type='button' onclick='finish(document.sForm)'  size='6' id='button3' name='button3'>&nbsp;");
				    out.print("<input class='bttn' value='转到信访办' type='button' onclick='turnto()'  size='6' id='button3' name='button3'>&nbsp;");
				 	out.print("<input class='bttn' value='垃圾信件' type='button' onclick='garbage(document.sForm)'  size='6' id='button3' name='button4'>&nbsp;");
				 	out.print("<input class='bttn' value='重复信件' type='button' onclick='chongfu()'  size='6' id='button5' name='button5'>&nbsp;");
                 break;
               case 3:
                break;
               case 8:
                 break;
			   case 9:
                 strStatus = "垃圾信件";
                 break;
				case 12:
                 strStatus = "重复信件";
				 //out.print("<input class='bttn' value='提交' type='button' onclick='chongfuSubmit(document.sForm)'  size='6' id='button5' name='button5'>&nbsp;");
                 break;
               default:
                 strStatus = "";
              }
          %>
          <%if(cw_status!=12){%>
          <input class="bttn" value="打印" type="button"  size="6" id="button6" name="button6" onclick="printlist('<%=cw_status%>')">
          &nbsp;
          <%}%>
          <input class="bttn" value="返回" type="button"  size="6" id="button6" name="button6" onclick="javascript:history.go(-1)">
          &nbsp;
          <input type=hidden name="cw_status" value="<%=cw_status%>">
          <textarea style="display:none" name="Content"><%=strContent%></textarea>
          <input type=hidden name="cw_parentid" value="<%=cw_parentid%>">
          <input type=hidden name="cp_id" value="<%=cp_id%>">
          <input type=hidden name="us_id" value="<%=us_id%>">
          <input type=hidden name="cw_status" value="<%=cw_status%>">
          <input type=hidden name="strSubject" value="<%=strSubject%>">
          <input type=hidden name="strfeedback" value="<%=strfeedback%>">
		  		<input type=hidden name="strChongfu" value="<%=strchongfu%>">
          <input type=hidden name="cw_applytime" value="<%=applytime%>">
          <input type=hidden name="cw_emailtype" value="<%=cw_emailtype%>">
          <input type=hidden name="dd_id" value="<%=dd_id%>">
          <input type=hidden name="cw_ispublish" value="<%=cw_ispublish%>">
      </td>
    </tr>
  </form>
</table>
<script language="javascript">
	 function dovalidate(sForm)//通用文本域校验
  {
      if(sForm.deptconn.value=="")
		{
              alert("转办部门不能为空！");
              return false;
        }
		 else
    if(window.confirm('确认要这样处理吗？')){
	    var form = document.sForm;
	    form.action = "AppealResult.jsp?cw_id=<%=cw_id%>&cw_status=8";
	    form.submit();
    }
  }
  function  del()
  {
    if(window.confirm('确认要删除该记录么?'))
   {
    window.location="/system/app/wardenmail/AppealDel.jsp?cw_id=<%=cw_id%>";
   }
  }
  
  //处理中
  function dealLetter(sForm) {
    var form = document.sForm;
    if (form.strFeedback.value == "") {
	    alert("回复不能为空！");
	    return false;
    }
	
  	if (confirm("确认要把信件存入'处理中信件'吗？")) {
	    form.action = "AppealResult.jsp?cw_id=<%=cw_id%>&cw_status=2";
	    form.submit();
    }
  }

  function directDeal(sForm)
  {
    if(sForm.classtype.value==""){
       alert("信件内容类型不能为空！");
       sForm.classtype.focus();
       return false;
    }


    if(sForm.strEmail.value!="")
     {
       if(isEmail(sForm.strEmail.value)==true)
      {
       if(window.confirm('确认要E-mail反馈吗？'))
       {
       //window.location="mailto:" + sForm.strEmail.value;
       window.open("mailto:"+ sForm.strEmail.value);
       window.close();
       var form = document.sForm;
       form.action = "AppealDeal.jsp?cw_id=<%=cw_id%>&status=3";
       form.submit();
       }
      }
      else
      {
       alert("邮件地址格式不对！");
       sForm.strEmail.focus();
      }
     }
   else
     {
      alert("邮件地址为空，不能E-mail回复！");
      sForm.strEmail.focus();
     }
  }

  function printlist(cw_status)
  {
    var w = screen.availWidth;
    var h = screen.availHeight;
    var args = new Object;
    var form = document.sForm;
    var status = cw_status;
    args["applyname"] = form.applyname.value;
    args["cw_number"] = form.cw_number.value;
    args["applydept"] = form.applydept.value;
    args["applyingtime"] = form.cw_applytime.value;
    args["strTel"] = form.strTel.value;
    args["strEmail"] = form.strEmail.value;
    args["wd_name"] = form.wd_name.value;
    args["wd_from"] = form.wd_from.value;
    args["strSubject"] = form.strSubject1.value;
    args["strContent"] = form.Content.value;
    args["receivername"] = form.receivername.value;
    args["de_requesttime"] = form.de_requesttime.value;
    args["co_corropioion"] = form.co_corropioion.value;
    args["feedback"] = form.strfeedback.value;
	args["chongfu"] = form.strChongfu.value;
    var url = "printPage.htm";
    window.showModalDialog(url,args,'dialogTop=0px;dialogLeft=0px;dialogWidth='+w+'px;dialogHeight='+h+'px;help=no;status=no;scroll=yes;resizable=yes;');
		if(status!=3){
	    form.action = "PrintResult.jsp?cw_id=<%=cw_id%>";
	    form.submit();
	  }
  }

  function withdraw()
  {
    window.location="/system/app/wardenmail/AppealDrop.jsp?cw_id=<%=cw_id%>";
  }
  //edit by arin 
  function finish(sForm){
    if(sForm.strFeedback.value==""){
       alert("回复不能为空！");
       return false;
    }
	else if(sForm.classtype.value==""){
       alert("信件内容类型不能为空！");
       sForm.classtype.focus();
       return false;
    }
	else if(window.confirm('确认要这样处理吗？')){
       var form = document.sForm;
       form.action = "AppealResult.jsp?cw_id=<%=cw_id%>&cw_status=3";
       form.submit();
    }
  }
  function setValue11()
  {		
	var form = document.sForm;		
	for(i=1;i<form.deptconn.length;i++)
	{		
		if(form.deptconn[i].selected)
		{
			form.strFeedback.value="已将该情况交由“" + form.deptconn[i].text　+ "”办理";
		}
	}
	if(form.deptconn[0].selected)
	{
		form.strFeedback.value="";
	}
	if(form.deptconn.value=="")		
	{
		//document.all.bttn_sel.style.display="";
		//document.all.bttn_sel.disabled=false;
	}
	else{
		//document.all.bttn_sel.style.display="none";
		//document.all.bttn_sel.disabled=true;
	}
  }
  
  function garbage(sForm)
  {
		var form = document.sForm;
  	if (form.strFeedback.value == "") {
	    alert("回复不能为空！");
	    return false;
    }
    if(window.confirm("确认要把信件放入'垃圾信件'吗？")){
	    //form.action = "AppealGarbage.jsp?cw_id=<%=cw_id%>&cw_status=9";
	    //form.submit();
	    window.location.href="AppealOperate.jsp?cwids=<%=cw_id%>&operatetype=rublish";
    }
  }
  
  function chongfu()
  {
    window.location.href="AppealOperate.jsp?cwids=<%=cw_id%>&operatetype=chongfu";
    //window.location.href="AppealInfo.jsp?cw_id=<%=cw_id%>&cw_status=12";
  }
  function turnto()
  {
  	window.location.href="AppealOperate.jsp?cwids=<%=cw_id%>&operatetype=turnto";
  }
  function chongfuSubmit(sForm)
  {
    if(window.confirm("确认要这样处理吗？")){
	    var form = document.sForm;
	    form.action = "AppealChongfu.jsp?cw_id=<%=cw_id%>&cw_status=12";
	    form.submit();
    }
  }

  function Display(Num)
  {
        var obj=eval("Info"+Num);
        var objImg=eval("document.sForm.InfoImg"+Num);

        if (typeof(obj)=="undefined") return false;
        if (obj.style.display=="none")
        {
                obj.style.display="";
                objImg.src="/system/images/topminus.gif";
        }
        else
        {
                obj.style.display="none";
                objImg.src="/system/images/topplus.gif";
        }
  }

  function openwindow()
  {
          var w=500;
          var h=300;
          var url="/system/app/appeal/exchange/RemoveCorr.jsp?cw_id=<%=cw_id%>";
          window.open(url,"撤销协调单","top=300px,left=300px,width="+w+",height="+h+",toolbar=no,location=no,derectories=no,status=no,menubar=no,resizable=yes,scrollbars=yes");
  }
</script>
<!--    表单提交结束    -->
<%@include file="/system/app/skin/skin4/template/info_bottom.jsp"%> 
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
                                     
