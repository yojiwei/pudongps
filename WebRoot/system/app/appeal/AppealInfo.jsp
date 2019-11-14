<%@page contentType="text/html; charset=GBK"%>
<%@include file="/system/app/skin/head.jsp"%>

<%
CMySelf self = (CMySelf)session.getAttribute("mySelf");

String selfdtid = String.valueOf(self.getDtId());
String sender_id = String.valueOf(self.getMyID());
//
CDataCn dCn = null;
CDataImpl dImpl = null;
try{
dCn = new CDataCn();
dImpl = new CDataImpl(dCn);

		String cs_id_all = "";
    String corr_ok = "";//是否转办
    String cs_name_all = "";
    String cw_typecode = "";
    String cw_id = "";//编号
    String us_id = "";//用户id
    String is_us = "否";//是否注册用户
    String cp_id = "";//项目编号
    String applyname = "";//投诉人姓名
    String applydept = "";//投诉人单位
    String strTel = "";//投诉人电话
    String strEmail = "";//投诉人邮件
    String appealname = "";//被投诉人姓名
    String appealdept = "";//被投诉人单位
    String strSubject = "";//投诉主题
    String strContent = "";//投诉内容
    String strfeedback = "";//投诉反馈
    String feedbackType = "";//投诉反馈
    int cw_status=0;         //投诉状态
    String cw_statusStr = "";
    String strStatus = "";//投诉状态
    String strSql = "";
    String sqlcorr = "";//判断是否转办
    String receivername = "";//转办部门
    String dept_name = "";
    String co_corropioion = "";//转办部门意见
    String co_id = "";//转办编号
    String cp_id_conn = "";
    String dd_id = "";
    String cp_name_conn = ""; 
    String cw_trans_id = "";
    String cw_parentid = "";
    String cw_emailtype = "";
    String cw_ispublish = "";
    String sqlStr = "";
    Vector vPage = null;
		String de_requesttime = "";//转办时限
    cw_statusStr = CTools.dealNumber(request.getParameter("cw_status"));
    cw_status = Integer.parseInt(cw_statusStr);
    switch(cw_status)
   	{
    case 1:
     strStatus = "待处理";
     dept_name = "e.de_senddeptid";
     break;
    case 2:
     dept_name = "e.de_senddeptid";
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
     default:
     strStatus = "";
  }

  cw_id = request.getParameter("cw_id").toString();
  sqlcorr = "select co_id from tb_correspond where cw_id='" + cw_id + "'";//判断是否转办

  Vector vectorPage = dImpl.splitPage(sqlcorr,request,20);

  if(vectorPage!=null)
  {
   strSql = "select c.cw_id,c.us_id,c.us_id,c.cp_id,c.cw_typecode,c.cw_applyingname,c.cw_ispublish,c.dd_id,c.cw_applyingdept,c.cw_emailtype,c.cw_telcode,c.cw_parentid,c.cw_email,c.cw_appliedname,c.cw_applieddept,";
   strSql += "c.cw_subject,c.cw_content,c.cw_feedback,c.cw_status,d.co_question,d.co_mainopioion,d.co_corropioion,d.co_status,";
   strSql += "e.de_senddeptid,e.de_receiverdeptid,e.de_isovertime,e.de_requesttime,f.dt_name ";
   strSql += "from tb_connwork c,tb_correspond d,tb_documentexchange e,tb_deptinfo f where c.cw_id=d.cw_id and d.co_id=e.de_primaryid and " + dept_name + "=f.dt_id and c.cw_id='" + cw_id + "'";
  }
  else
  {
   strSql = "select cw_id,us_id,cw_typecode,cp_id,cw_applyingname,cw_applyingdept,cw_telcode,dd_id,cw_ispublish,cw_emailtype,cw_email,cw_appliedname,cw_parentid,cw_applieddept,cw_subject,cw_content,cw_feedback from tb_connwork where cw_id='"+ cw_id +"'";
  }
  Hashtable content = dImpl.getDataInfo(strSql);

  cw_id = content.get("cw_id").toString();
  us_id = content.get("us_id").toString();
  cw_typecode = content.get("cw_typecode").toString();
  if(!us_id.equals(""))
  {
    is_us = "是";
  }
  cp_id = content.get("cp_id").toString();
  applyname = content.get("cw_applyingname").toString();
  applydept = content.get("cw_applyingdept").toString();
  strTel = content.get("cw_telcode").toString();
  strEmail = content.get("cw_email").toString();
  appealname = content.get("cw_appliedname").toString();
  appealdept = content.get("cw_applieddept").toString();
  strSubject = content.get("cw_subject").toString();
  strContent = content.get("cw_content").toString();
  strfeedback = content.get("cw_feedback").toString();
  cw_parentid = content.get("cw_parentid").toString();
  cw_emailtype = content.get("cw_emailtype").toString();
  cw_ispublish = CTools.dealNull(content.get("cw_ispublish"));
  dd_id = content.get("dd_id").toString();
  if(vectorPage!=null)
  {
   receivername = content.get("dt_name").toString();
   co_corropioion = content.get("co_corropioion").toString();
   de_requesttime = content.get("de_requesttime").toString();
  }

	String sql_att = "select aa_id,aa_filename from tb_appealattach where cw_id='"+cw_id+"'";
	Vector page_att = dImpl.splitPage(sql_att,10,1);
	
%>
<!-- 记录日志 -->
<%
String logstrMenu = "网上投诉";
String logstrModule = "受理网上投诉";
%>
<%@include file="/system/app/writelogs/WriteDetailLog.jsp"%>
<!-- 记录日志 -->
<%@include file="/system/app/skin/skin4/template/info_top.jsp"%>
<!--    模块名称开始    -->
受理网上投诉
<!--    模块名称结束    -->
<%@include file="/system/app/skin/skin4/template/info_funtion.jsp"%>
<!--    功能按钮开始    -->
受理网上投诉
<!--    功能按钮结束    -->
<%@include file="/system/app/skin/skin4/template/info_main.jsp"%>
<!--    表单提交开始    -->
<table WIDTH="100%" CELLPADDING="0" cellspacing="0" BORDER="0">
<form method="post" name="sForm">
	<tr>
    <td width="100%" align="left" valign="top">
    	<table width="100%">
      	<tr class="line-odd">
          <td width="18%" align="right">投 诉 人：</td>
          <td width="82%"><input type="text" class="text-line" name="applyname" maxlength="100" size="30" title="投诉人" value="<%=applyname%>" readonly></td>
        </tr>
        <tr class="line-even">
          <td width="18%" align="right">单　　位：</td>
          <td width="82%"><input type="text" class="text-line" name="applydept" maxlength="100" size="30" value="<%=applydept%>" readonly></td>
        </tr>
        <tr class="line-odd">
          <td width="18%" align="right">联系电话：</td>
          <td width="82%"><input type="text" class="text-line" name="strTel" maxlength="100" size="30" value="<%=strTel%>" readonly>
          </td>
        </tr>
        <tr class="line-even">
          <td width="18%" align="right">电子邮件：</td>
          <td width="82%"><input type="text" class="text-line" name="strEmail" maxlength="100" size="30" value="<%=strEmail%>" readonly>
          </td>
        <tr class="line-odd">
          <td width="18%" align="right">是否注册用户：</td>
          <td width="82%"><input type="text" class="text-line" name="is_us" maxlength="100" size="30" title="注册用户" value="<%=is_us%>" readonly></td>
        </tr>
        </tr>
        <tr class="line-even">
          <td colspan="2" align="right">&nbsp;</td>
        </tr>
        <tr class="line-odd">
          <td width="18%" align="right">被投诉人：</td>
          <td width="82%"><input type="text" class="text-line" name="appealname" maxlength="100" size="30" title="投诉人" value="<%=appealname%>"readonly></td>
        </tr>
        <tr class="line-even">
          <td width="18%" align="right">单　　位：</td>
          <td width="82%"><input type="text" class="text-line" name="appealdept" maxlength="100" size="30" value="<%=appealdept%>" readonly></td>
        </tr>
        <tr class="line-odd">
          <td width="18%" align="right">投诉主题：</td>
          <td width="82%"><input type="text" class="text-line" name="strSubject" maxlength="100" size="30" value="<%=strSubject%>" readonly></td>
        </tr>
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
          <td align="right">投诉内容：</td>
          <td><textarea class="text-area" name="strContent" cols="60" rows="6" title="投诉内容" readonly><%=strContent%></textarea></td>
        </tr>
        <tr class="line-even">
          <td align="right">投诉处理状态：</td>
          <td><%=strStatus%></td>
        </tr>
        <tr class="line-odd">
          <td align="right">投诉处理分类：</td>
          <td><select name="classtype">
              <%
              String Sql_class = "select cs_id,cs_name from tb_class where cs_id!='o2' order by cs_sequence";
              Vector vPage1 = dImpl.splitPage(Sql_class,request,1000);
              if (vPage1!=null)
              {
               for(int i=0;i<vPage1.size();i++)
              {
               Hashtable content1 = (Hashtable)vPage1.get(i);
               cs_id_all = content1.get("cs_id").toString();
               cs_name_all = content1.get("cs_name").toString();
              %>
              <option value="<%=cs_id_all%>"<%if(cs_id_all.equals(cw_typecode)) out.print("selected");%>><%=cs_name_all%></option>
              <%
			         }
			         }
			        %>
            </select>
          </td>
        </tr>
        <!--部门转办-->
        <tr class="line-odd">
            <td align="right">转交处理：</td>
            <td align="left"><select name="deptconn" onchange='setValue11();'>
                <option value="">请选择委办局</option>
                <option value="o5" <%=cw_trans_id.equals("o5") ? "selected" : ""%>>信访信箱</option>
                <%
                   String Sql_zb = "select cp_id,cp_name from tb_connproc where cp_upid='o7' order by dt_name";
                  	vPage1 = dImpl.splitPage(Sql_zb,request,100);
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
						vPage = dImpl.splitPage(sqlStr,request,250);
						if(vPage!=null)
						{
							for(int j=0;j<vPage.size();j++)
							{
								 content = (Hashtable)vPage.get(j);
						  %>
                <option value="<%=content.get("cp_id").toString()%>"><%="街镇领导信箱－"+content.get("cp_name").toString()%></option>
                <%
              }
             }
           %>
              </select>
          </tr>
          <!--部门转办-->
          <tr class="line-even" width="100%">
          <td width="100%" colspan="2" align="left"><a onclick="javascript:Display(1)" style="cursor:hand"><img border="0" src="/system/images/topplus.gif" WIDTH="16" HEIGHT="16" id="InfoImg1"></a> 转办处理情况</td>
        </tr>
        <tr class="line-odd" id="Info1" style="display:none">
          <td align="left" height="20" colspan=2><table cellspacing="1" border="0" bgcolor="#ffffff" width="100%">
              <tr class="line-odd">
                <td align="right" width="18%">转办部门：</td>
                <td><%=receivername%></td>
              </tr>
              <tr class="line-even">
                <td align="right" width="18%">转办时限：</td>
                <td><%=de_requesttime%> 天</td>
              </tr>
              <tr class="line-odd">
                <td align="right" width="18%">转办部门意见：</td>
                <td><textarea class="text-area" name="co_corropioion" cols="60" rows="6" title="转办部门意见" readonly><%=co_corropioion%></textarea></td>
              </tr>
            </table></td>
        </tr>
        <tr class="line-even" width="100%">
          <td width="100%" colspan="2" align="left"><a onclick="javascript:Display(2)" style="cursor:hand"><img border="0" src="/system/images/topplus.gif" WIDTH="16" HEIGHT="16" id="InfoImg2"></a> 投诉回复：</td>
        </tr>
        <tr class="line-odd" id="Info2" style="display:none">
          <td align="left" height="20" colspan=2><table cellspacing="1" border="0" bgcolor="#ffffff" width="100%">
              <tr class="line-odd">
                <td align="right" width="18%">投诉反馈回复：</td>
                <td><textarea class="text-area" name="strFeedback" cols="60" rows="6" title="投诉反馈" <%=feedbackType%>><%=strfeedback%></textarea></td>
              </tr>
            </table></td>
        </tr>
      </table></td>
    </tr>
    
    <tr class=outset-table>
      <td width="100%" align="right" colspan="2"><p align="center">
          <%
              if(!receivername.equals(""))
              corr_ok="disabled";
              switch(cw_status)
              {
               case 1:             //class="BtnStyle"
                 out.print("<input class='bttn' value='处理中' type='button'  size='6' id='button6' name='button6' onclick='javascript:save()'>&nbsp;");
                 //out.print("<input class='bttn' value='E-mail回复' type='button' onclick='directDeal(document.sForm)'  size='6' id='button1' name='button1'>&nbsp;");
                 out.print("<input class='bttn' value='转办' "+corr_ok+" type='button' onclick='dovalidate(document.sForm)'  size='6' id='button2' name='button2'>&nbsp;");
                 out.print("<input class='bttn' value='处理完成' type='button' onclick='finish(document.sForm)'  size='6' id='button3' name='button3'>&nbsp;");
                 out.print("<input class='bttn' value='垃圾信件' type='button' onclick='garbage(document.sForm)'  size='6' id='button4' name='button4'>&nbsp;");
                 break;
               case 2:
                 out.print("<input class='bttn' value='处理中' type='button'  size='6' id='button6' name='button6' onclick='javascript:save()'>&nbsp;");
                 //out.print("<input class='bttn' value='E-mail回复' type='button' onclick='directDeal(document.sForm)'  size='6' id='button1' name='button1'>&nbsp;");
                 out.print("<input class='bttn' value='转办' "+corr_ok+" type='button' onclick='dovalidate(document.sForm)'  size='6' id='button2' name='button2'>&nbsp;");
                 out.print("<input class='bttn' value='处理完成' type='button' onclick='finish(document.sForm)'  size='6' id='button3' name='button3'>&nbsp;");
                 out.print("<input class='bttn' value='垃圾信件' type='button' onclick='garbage(document.sForm)'  size='6' id='button4' name='button4'>&nbsp;");
                 break;
               case 3:
                break;
               case 8:
                 //out.print("<input  class='bttn' value='撤销协调单' type='button' onclick='openwindow()' size='6' id='button5' name='button5'>&nbsp;");
                 break;
               default:
                 strStatus = "";
              }
            %>
            
      <input class="bttn" value="返回" type="button"  size="6" id="button6" name="button6" onclick="javascript:history.go(-1)">
       &nbsp;
	  <input type=hidden name="cw_status" value="<%=cw_status%>">
	  <input type=hidden name="cw_parentid" value="<%=cw_parentid%>">
	  <input type=hidden name="strSubject" value="<%=strSubject%>">
	  <input type=hidden name="appealname" value="<%=appealname%>">
	  <input type=hidden name="appealdept" value="<%=appealdept%>">
	  <input type=hidden name="cp_id" value="<%=cp_id%>">
	  <input type=hidden name="dd_id" value="<%=dd_id%>">
	  <input type=hidden name="strfeedback" value="<%=strfeedback%>">
	  <input type=hidden name="cw_emailtype" value="<%=cw_emailtype%>">
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
  function  del()
  {
    if(window.confirm('确认要删除该记录么？'))
   {
    window.location="/system/app/appeal/AppealDel.jsp?cw_id=<%=cw_id%>";
   }
  }

  function directDeal(sForm)
  {
    if(sForm.strEmail.value!="")
     {
       if(isEmail(sForm.strEmail.value)==true)
      {
       if(window.confirm('确认要E-mail反馈吗？'))
       {
       window.open("mailto:"+ sForm.strEmail.value);
       window.close();
       var form = document.sForm;
       form.action = "AppealDeal.jsp?cw_id=<%=cw_id%>&cw_status=3";
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

  function withdraw()
  {
    window.location="/system/app/appeal/AppealDrop.jsp?cw_id=<%=cw_id%>";
  }
  function save()
  {
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
  function finish(sForm)
  {
    if(sForm.strFeedback.value=="")
            {
              alert("回复不能为空！");
              return false;
             }
    else
    if(window.confirm('确认要这样处理吗？')){
    var form = document.sForm;
    form.action = "AppealResult.jsp?cw_id=<%=cw_id%>&cw_status=3";
    form.submit();
    }
  }
  
  function garbage(sForm)
  {
  		if(window.confirm("确认要把信件放入'垃圾信件'吗？")){
    	sForm.action = "AppealGarbage.jsp?cw_id=<%=cw_id%>";
    	sForm.submit();
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
    var url="exchange/RemoveCorr.jsp?cw_id=<%=cw_id%>";
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
                                     
