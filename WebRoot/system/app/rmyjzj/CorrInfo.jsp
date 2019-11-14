<%@page contentType="text/html; charset=GBK"%>
<%@include file="/system/app/skin/head.jsp"%>
<%
  CMySelf self = (CMySelf)session.getAttribute("mySelf");
  String selfdtid = String.valueOf(self.getDtId());
  String receiver_id = String.valueOf(self.getMyID());

    //update20080122

CDataCn dCn=null;   //新建数据库连接对象
CDataImpl dImpl=null;  //新建数据接口对象

try {
 dCn = new CDataCn(); 
 dImpl = new CDataImpl(dCn); 


    String cw_id;//编号
    String cp_id;//项目编号
    String applyname;//投诉人姓名
    String applydept;//投诉人单位
    String strTel = "";//投诉人电话
    String strEmail;//投诉人邮件
    String appealname;//被投诉人姓名
    String appealdept;//被投诉人单位
    String strSubject;//投诉主题
    String strContent;//投诉内容
    String strQuestion;//投诉主要问题
    String strMainopio;//投诉主办部门意见
    String co_corropioion;//投诉转办部门意见
    String strCorrStatus;//投诉转办部门意见
    int cw_status;//投诉状态
    int CorrStatus;//转办状态
    String co_id = "";//转办编号
    String de_id = "";//文件交换编号
    String sendername;//转办发送部门
    String senderid;
    String dt_idType = selfdtid;
    String receivername;//转办部门
    String sendtime;//转办发送时间
    String signtime;//签收时间
    String requesttime;//转办时限
    String strStatus = "";//投诉状态
    String de_status = "";//文件交换状态
    String CorrType = request.getParameter("CorrType").toString();;//处理类型
	String cw_feedback = "";

	String cp_upid = "";

    if(CorrType.equals("see"))
    {
      dt_idType = "e.de_receiverdeptid";
    }

try
{
 cw_id = request.getParameter("cw_id").toString();
 String strSql = "select c.cp_id,c.cw_applyingname,c.cw_applyingdept,c.cw_email,c.cw_telcode,c.cw_feedback,c.cw_appliedname,c.cw_applieddept,c.cw_subject,c.cw_content,c.cw_status,d.co_id,";
 strSql += "d.co_question,d.co_mainopioion,d.co_corropioion,d.co_status,e.de_id,to_char(e.de_sendtime,'yyyy-mm-dd hh24:mi:ss') de_sendtime,to_char(e.de_signtime,'yyyy-mm-dd hh24:mi:ss') de_signtime,e.de_status,e.de_requesttime,e.de_senddeptid,e.de_receiverdeptid,x.dt_name sendname,y.dt_name receivername,f.cp_upid  ";
 strSql += "from tb_connwork c,tb_correspond d,tb_documentexchange e,tb_deptinfo x,tb_deptinfo y,tb_connproc f ";
 strSql += "where c.cp_id=f.cp_id and c.cw_id=d.cw_id and d.co_id=e.de_primaryid and e.de_senddeptid=x.dt_id and y.dt_id="+dt_idType+" and c.cw_id='" + cw_id + "'";
//out.println(strSql);out.close();
  Hashtable content = dImpl.getDataInfo(strSql);

  cp_id = content.get("cp_id").toString();
  applyname = content.get("cw_applyingname").toString();
  applydept = content.get("cw_applyingdept").toString();
  strTel = content.get("cw_telcode").toString();
  strEmail = content.get("cw_email").toString();
  appealname = content.get("cw_appliedname").toString();
  appealdept = content.get("cw_applieddept").toString();
  strSubject = content.get("cw_subject").toString();
  strContent = content.get("cw_content").toString();
  de_id = content.get("de_id").toString();
  strQuestion = content.get("co_question").toString();
  strMainopio = content.get("co_mainopioion").toString();
  co_corropioion = content.get("co_corropioion").toString();
  co_id = content.get("co_id").toString();
  sendername = content.get("sendname").toString();
  senderid = content.get("de_senddeptid").toString();
  receivername = content.get("receivername").toString();
  sendtime = content.get("de_sendtime").toString();
  signtime = content.get("de_signtime").toString();
  requesttime = content.get("de_requesttime").toString();
  de_status = content.get("de_status").toString();
  cp_upid = content.get("cp_upid").toString();
  cw_feedback = content.get("cw_feedback").toString();
  CorrStatus = Integer.parseInt(content.get("co_status").toString());
  cw_status = Integer.parseInt(content.get("cw_status").toString());

  if(cw_status==8)
    strStatus = "协调中";

  switch(CorrStatus)
  {
  case 1:
    strCorrStatus = "进行中";
    break;
  case 3:
    strCorrStatus = "已通过";
    break;
  default:
    strCorrStatus = "";
  }

	String sql_att = "select aa_id,aa_filename from tb_appealattach where cw_id='"+cw_id+"'";
	Vector page_att = dImpl.splitPage(sql_att,10,1);
%>

<form action="AppealResult.jsp" method="post" name="sForm">
<table WIDTH="100%" CELLPADDING="0" BORDER="0" class="main-table">
            <tr class="title1">
               <td align="center" colspan=2>事项处理</td>
            </tr>
            <tr class="line-odd">
              <td width="18%" align="right">代表姓名：</td>
              <td width="82%"><input class="text-line" type="text" name="applyname" maxlength="10" size="30" title="投诉人" value="<%=applyname%>" readonly></td>
            </tr>
            <tr class="line-even">
              <td width="18%" align="right">单　　位：</td>
              <td width="82%"><input class="text-line" type="text" name="applydept" maxlength="10" size="30" value="<%=applydept%>" readonly></td>
            </tr>
            <tr class="line-odd">
              <td width="18%" align="right">联系电话：</td>
              <td width="82%"><input type="text" class="text-line" name="strTel" maxlength="100" size="30" value="<%=strTel%>" readonly>
              </td>
            </tr>
            <tr class="line-even">
              <td width="18%" align="right">电子邮件：</td>
              <td width="82%"><input class="text-line" type="text" name="strEmail" maxlength="10" size="30" value="<%=strEmail%>" readonly>
              </td>
            </tr>
            <tr class="line-odd">
              <td colspan="2" align="right">&nbsp;</td>
            </tr>
            <tr class="line-even">
              <td width="18%" align="right">主题：</td>
              <td width="82%"><input class="text-line" type="text" name="strSubject" maxlength="100" size="30" title="主题" value="<%=strSubject%>" readonly></td>
            </tr>
            <tr class="line-odd">
              <td align="right">内容：</td>
              <td><textarea class="text-area" name="strContent" cols="60" rows="6" title="投诉内容" readonly><%=strContent%></textarea></td>
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
                    <td><a href="/website/include/downloadAPP.jsp?aa_id=<%=aa_id%>" target="_blank"><%=file_name%></a></td>
                   </tr>
				  <%
					}
			}	  
			%>
            <tr class="line-odd" width="100%">
                <td width="100%" colspan="2" align="left">
                        <a onclick="javascript:Display(2)" style="cursor:hand"><img border="0" src="/system/images/topplus.gif" WIDTH="16" HEIGHT="16" id="InfoImg2"></a>
                转办信息</td>
            </tr>
            <tr class="line-even" id="Info2" style="display:none">
                <td align="left" height="20" colspan=2>
                  <table cellspacing="1" border="0" bgcolor="#ffffff" width="100%">
                   <tr class="line-even">
                     <td width="18%" align="right">主办部门：</td>
                     <td width="82%"><input type="text" class="text-line" name="sendername" maxlength="100" size="30" value="<%if(de_status.equals("5")||CorrType.equals("dealed")) out.print(receivername);  else out.print(sendername);%>" readonly></td>
                   </tr>
                   <tr class="line-odd">
                     <td align="right">涉及主要问题：</td>
                     <td><textarea class="text-area" name="strContent" cols="60" rows="6" title="投诉主要问题" readonly><%=strQuestion%></textarea></td>
                   </tr>
                   <tr class="line-even">
                     <td align="right">主办部门意见：</td>
                     <td><textarea class="text-area" name="strContent" cols="60" rows="6" title="主办部门意见" readonly><%=strMainopio%></textarea></td>
                   </tr>
                 </table>
                </td>
            </tr>
            <tr class="line-odd" width="100%">
                <td width="100%" colspan="2" align="left">
                        <a onclick="javascript:Display(1)" style="cursor:hand"><img border="0" src="/system/images/topplus.gif" WIDTH="16" HEIGHT="16" id="InfoImg1"></a>
                转办处理</td>
	    </tr>
            <tr class="line-even" id="Info1" style="display:none">
                <td align="left" height="20" colspan=2>
                  <table cellspacing="1" border="0" bgcolor="#ffffff" width="100%">
                   <tr class="line-even">
                     <td width="18%" align="right">转办部门：</td>
                     <td width="82%"><input class="text-line" type="text" name="receivername" maxlength="100" size="30" value="<%if(de_status.equals("5")||CorrType.equals("dealed")) out.print(sendername); else out.print(receivername);%>" readonly></td>
                   </tr>
                   <tr class="line-odd">
                     <td align="right">转办时限：</td>
                     <td><%=requesttime%> 天</td>
                   </tr>
                   <tr class="line-even">
                     <td align="right">转办发送时间：</td>
                     <td><%=sendtime%></td>
                   </tr>
                   <tr class="line-odd">
                     <td align="right">转办签收时间：</td>
                     <td><%=signtime%></td>
                   </tr>
                   <tr class="line-even">
                     <td align="right">转办部门意见：</td>
                     <td><textarea class="text-area" name="co_corropioion" cols="60" rows="6" title="转办部门意见"><%=co_corropioion%></textarea></td>
                   </tr>
                   <tr class="line-odds">
                     <td align="right">转办处理状态：</td>
                     <td><%=strCorrStatus%></td>
                   </tr>
                  </table>
                </td>
            </tr>
			<%
			if(cp_upid.equals("o13"))
			{
			%>
			<tr class="line-odd" width="100%">
                <td width="100%" colspan="2" align="left">
                        <a onclick="javascript:Display(7)" style="cursor:hand"><img border="0" src="/system/images/topplus.gif" WIDTH="16" HEIGHT="16" id="InfoImg7"></a>
                信件回复</td>
			</tr>
            <tr class="line-even" id="Info7" style="display:none">
                <td align="left" height="20" colspan=2>
                  <table cellspacing="1" border="0" bgcolor="#ffffff" width="100%">
                   <tr class="line-even">
                     <td width="18%" align="right">回复：</td>
                     <td><textarea class="text-area" name="cw_fb" cols="60" rows="6" title="回复"><%=cw_feedback%></textarea></td>
                   </tr>
                  </table>
                </td>
            </tr>
			<%
			}
			%>
      <tr class=title1>
         <td width="100%" align="right" colspan="2">
          <p align="center">
            <%
             if(de_status.equals("2"))
             {
               if(!CorrType.equals("see")&&!CorrType.equals("dealed"))
               {
                out.print("<input  class='bttn' value='暂存' type='button' onclick='javascript:save()' size='6' id='button5' name='button5'>&nbsp;");
                out.print("<input  class='bttn' value='处理完成' type='button' onclick='javascript:deal()' size='6' id='button6' name='button6'>&nbsp;");
               }
             }
            %>
             <input class="bttn" value="返回" type="button"  size="6" id="button6" name="button6" onclick="javascript:history.go(-1)">&nbsp;
             <input type=hidden name="co_id" value="<%=co_id%>">
             <input type=hidden name="cw_status" value="<%=cw_status%>">
             <input type=hidden name="de_id" value="<%=de_id%>">
             <input type=hidden name="senderid" value="<%=senderid%>">
			 <input type=hidden name="cp_upid" value="<%=cp_upid%>">
         </td>
      </tr>
    </table>
</form>

<script language="javascript">
  function  deal()
  {
    if(document.sForm.cp_upid.value=="o13")
	{
		if(document.all.cw_fb.value=="")
		{
			alert("请填写信件回复！");
			return false;
		}
	}
	if(window.confirm('确认这样处理么?'))
   {
    var form = document.sForm ;
    form.action = "CorrResult.jsp?cw_id=<%=cw_id%>";
    form.submit();
   }
  }
  function  save()
  {
    var form = document.sForm ;
    form.action = "CorrSave.jsp?cw_id=<%=cw_id%>";
    form.submit();
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
</script>
<%
}
catch(Exception e)
{
     out.println(e);
}
dImpl.closeStmt();
dCn.closeCn();
} catch (Exception ex) {
	System.out.println(new java.util.Date() + "--"
			+ request.getServletPath() + " : " + ex.getMessage());
} finally {
	if(dImpl != null)
	dImpl.closeStmt();
	if(dCn != null)
	dCn.closeCn();
}

%>
<%@include file="/system/app/skin/bottom.jsp"%>