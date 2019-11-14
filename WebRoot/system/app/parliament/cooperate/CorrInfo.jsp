<%@page contentType="text/html; charset=GBK"%>
<%@include file="../../skin/head.jsp"%>
<%
  CMySelf self = (CMySelf)session.getAttribute("mySelf");
  String selfdtid = String.valueOf(self.getDtId());
  String sender_id = String.valueOf(self.getMyID());

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
    String strEmail;//投诉人邮件
    String appealname;//被投诉人姓名
    String appealdept;//被投诉人单位
    String strSubject;//投诉主题
    String strContent;//投诉内容
    String strQuestion;//投诉主要问题
    String strMainopio;//投诉主办部门意见
    String strCorropio;//投诉转办部门意见
    String strCorrStatus;//投诉转办部门意见
    int cw_status;//投诉状态
    int CorrStatus;//转办状态
    String strStatus = "";//投诉状态
try
{
 cw_id = request.getParameter("cw_id").toString();
 String strSql = "select c.cp_id,c.cw_applyingname,c.cw_applyingdept,c.cw_email,c.cw_appliedname,c.cw_applieddept,c.cw_subject,c.cw_content,c.cw_status,d.co_id,d.co_question,d.co_mainopioion,d.co_corropioion,d.co_status from tb_connwork c,tb_correspond d where c.cw_id=d.cw_id and c.cw_id='" + cw_id + "'";

  Hashtable content = dImpl.getDataInfo(strSql);

  cp_id = content.get("cp_id").toString();
  applyname = content.get("cw_applyingname").toString();
  applydept = content.get("cw_applyingdept").toString();
  strEmail = content.get("cw_email").toString();
  appealname = content.get("cw_appliedname").toString();
  appealdept = content.get("cw_applieddept").toString();
  strSubject = content.get("cw_subject").toString();
  strContent = content.get("cw_content").toString();
  strQuestion = content.get("co_question").toString();
  strMainopio = content.get("co_mainopioion").toString();
  strCorropio = content.get("co_corropioion").toString();
  CorrStatus = Integer.parseInt(content.get("co_status").toString());
  cw_status = Integer.parseInt(content.get("cw_status").toString());
  if(cw_status==8)
    strStatus = "协调中";

  switch(CorrStatus)
  {
  case 1:
    strCorrStatus = "进行中";
    break;
  case 2:
    strCorrStatus = "已通过";
    break;
  case 3:
    strCorrStatus = "未通过";
    break;
  default:
    strCorrStatus = "";
  }
%>

<form action="AppealResult.jsp" method="post" name="sForm" id="sForm">
<table WIDTH="100%" CELLPADDING="0" BORDER="0" class="main-table">
   <tr>
        <td width="100%" align="left" valign="top">

                  <table class="content-table" height="1" width="100%">
            <tr class="title1">
              <td align="center" colspan=2>查看网上投诉</td>
            </tr>
            <tr class="line-odd">
              <td width="18%" align="right">投诉人：</td>
              <td width="82%"><input type="text" name="applyname" maxlength="10" size="30" title="投诉人" value="<%=applyname%>" readonly></td>
            </tr>
            <tr class="line-even">
              <td width="18%" align="right">单　　位：</td>
              <td width="82%"><input type="text" name="applydept" maxlength="10" size="30" value="<%=applydept%>" readonly></td>
            </tr>
            <tr class="line-odd">
              <td width="18%" align="right">E-mail：</td>
              <td width="82%"><input type="text" name="strEmail" maxlength="10" size="30" value="<%=strEmail%>" readonly>
              </td>
            </tr>
            <tr class="line-even">
              <td colspan="2" align="right">&nbsp;</td>
            </tr>
            <tr class="line-odd">
              <td width="18%" align="right">被投诉人：</td>
              <td width="82%"><input type="text" name="appealname" maxlength="10" size="30" title="投诉人" value="<%=appealname%>"readonly></td>
            </tr>
            <tr class="line-even">
              <td width="18%" align="right">单　　位：</td>
              <td width="82%"><input type="text" name="appealdept" maxlength="10" size="30" value="<%=appealdept%>" readonly></td>
            </tr>
            <tr class="line-even">
              <td width="18%" align="right">投诉主题：</td>
              <td width="82%"><input type="text" name="strSubject" maxlength="10" size="30" value="<%=strSubject%>" readonly></td>
            </tr>
            <tr class="line-odd">
              <td align="right">投诉内容：</td>
              <td><textarea name="strContent" cols="60" rows="6" title="投诉内容" readonly><%=strContent%></textarea></td>
            </tr>
            <tr class="line-odd">
              <td align="right">投诉主要问题：</td>
              <td><textarea name="strContent" cols="60" rows="6" title="投诉主要问题" readonly><%=strQuestion%></textarea></td>
            </tr>
            <tr class="line-odd">
              <td align="right">主办部门意见：</td>
              <td><textarea name="strContent" cols="60" rows="6" title="主办部门意见" readonly><%=strMainopio%></textarea></td>
            </tr>
            <tr class="line-odd">
              <td align="right">转办部门意见：</td>
              <td><textarea name="strContent" cols="60" rows="6" title="转办部门意见" readonly><%=strCorropio%></textarea></td>
            </tr>
            <tr class="line-even">
              <td colspan="2" align="right">&nbsp;</td>
            </tr>
             <tr class="line-odd">
              <td align="right">投诉转办处理状态：</td>
              <td><%=strCorrStatus%></td>
             </tr>
            <tr class="line-odd">
              <td align="right">投诉处理状态：</td>
              <td><%=strStatus%></td>
             </tr>
          </table>
        </td>
      </tr>
      <tr class=title1>
         <td width="100%" align="right" colspan="2">
          <p align="center">
            <input  class="bttn" value="删除" type="button" onclick="javascript:del()" size="6" id="button5" name="button5">&nbsp;
            <input class="bttn" value="返回" type="button"  size="6" id="button6" name="button6" onclick="javascript:history.go(-1)">&nbsp;
            <input type=hidden name="cw_status" value="<%=cw_status%>">
         </td>
      </tr>
    </table>
</form>

<script language="javascript">
  function  del()
  {
    if(window.confirm('确认要删除该记录么?'))
   {
    window.location="/system/app/appeal/AppealDel.jsp?cw_id=<%=cw_id%>";
   }
  }
  function directDeal()
  {
    window.location="/system/app/appeal/AppealDeal.jsp?cw_id=<%=cw_id%>";
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
<%@include file="../../skin/bottom.jsp"%>

