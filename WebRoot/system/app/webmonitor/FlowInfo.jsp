<%@page contentType="text/html; charset=GBK"%>
<%@include file="/system/app/skin/head.jsp"%>
<%
	//update20080122

CDataCn dCn=null;   //新建数据库连接对象
CDataImpl dImpl=null;  //新建数据接口对象

try {
 dCn = new CDataCn(); 
 dImpl = new CDataImpl(dCn); 
	String strTitle="监督投诉流转单";
	String cw_id=CTools.dealString(request.getParameter("cw_id"));
	String sql_sign = "select c.cw_ispostil,c.cw_postilname,to_char(c.cw_postiltime,'yyyy-mm-dd hh24:mi:ss') cw_postiltime,c.cw_iswardensee,to_char(c.cw_wardenseetime,'yyyy-mm-dd hh24:mi:ss') cw_wardenseetime,c.cw_subject,c.cw_applyingname,c.cw_issign,to_char(c.cw_signedtime,'yyyy-mm-dd hh24:mi:ss') cw_signedtime,c.cw_issee,to_char(c.cw_seetime,'yyyy-mm-dd hh24:mi:ss') cw_seetime,to_char(c.cw_applytime,'yyyy-mm-dd hh24:mi:ss') cw_applytime,c.cw_status,to_char(c.cw_finishtime,'yyyy-mm-dd hh24:mi:ss') cw_finishtime,d.dt_id,e.dt_name from tb_connwork c,tb_connproc d,tb_deptinfo e where c.cp_id=d.cp_id and d.dt_id=e.dt_id and c.cw_id='" + cw_id + "'";
	String cw_applyingname = "";
	String cw_applyingtime = "";
	String cw_subject = "";
	String dt_name = "";
	String cw_issign = "";
	String is_sign = "";
	String cw_issee = "";
	String is_see = "";
	String cw_status = "";
	String cw_finishtime = "";
	int de_status = 0;

	String dt_id = "";
	String turn_dept = "";
	String[] corr_status = {"","","",""};
	String[] corr_time = {"","","",""};
	String[] correr_id = {"","","",""};
	String[] correr_name = {"","","",""};
	String sql_correr = "";
	Hashtable content_correr = null;
	String sql_dt = "";
	Hashtable content_dt = null;

	String ispostil = "";
	int cw_ispostil = 0;
	String postil_status = "";
	String cw_postiltime = "";
	String cw_postilname = "";
	String cw_wardenseetime = "";
	String warden_status = "";
	String sign_time = "";
	Hashtable content_turn = null;
	Hashtable content_sign = dImpl.getDataInfo(sql_sign);
	if (content_sign!=null)
	{
		cw_status = content_sign.get("cw_status").toString();
		cw_subject = content_sign.get("cw_subject").toString();
		cw_applyingname = content_sign.get("cw_applyingname").toString();
		cw_applyingtime = content_sign.get("cw_applytime").toString();
		dt_name = content_sign.get("dt_name").toString();
		cw_issign = content_sign.get("cw_issign").toString();
		cw_issee = content_sign.get("cw_issee").toString();
		ispostil = content_sign.get("cw_ispostil").toString();

		if(cw_issign.equals("1"))
		{
			sign_time = content_sign.get("cw_signedtime").toString();
			is_sign = "已签收";
		}
		else 
		if(cw_issign.equals("0"))
		{
			is_sign = "未签收";
		}
		else
		{
			is_sign = "未监控";
		}

		if(cw_issee.equals("1"))
		{
			is_see = content_sign.get("cw_seetime").toString();
		}

		if(cw_status.equals("3")||cw_status.equals("4"))
		{
			cw_finishtime = content_sign.get("cw_finishtime").toString();
		}
		
		if(!ispostil.equals(""))
		{
				cw_ispostil = Integer.parseInt(ispostil);
				cw_postiltime = content_sign.get("cw_postiltime").toString();
				cw_postilname = content_sign.get("cw_postilname").toString();
				switch(cw_ispostil)
				{
					case 1:
						postil_status = "已批示";
						
						break;
					case 0:
						postil_status = "未批示";
						
						break;
					case 3:
						if(cw_status.equals("9"))
						{
							postil_status = "已退信";
						}
						break;
					default:
						postil_status = "";
				}

				String cw_iswardensee = content_sign.get("cw_iswardensee").toString();
				if(cw_iswardensee.equals("1"))
				{
					warden_status = "已签收";	
					cw_wardenseetime = content_sign.get("cw_wardenseetime").toString();
				}
				else 
				if(cw_iswardensee.equals("0"))
				{
					warden_status = "未签收";
				}
				else
				{
					warden_status = "未监控";
				}
		}

		String sql_corr = "";
		String sql_judge = "select co_id from tb_correspond where cw_id='" + cw_id + "'";//判断是否转办
		content_turn = dImpl.getDataInfo(sql_judge);
		if(content_turn!=null)
		{
			sql_corr= "select  d.co_status,e.de_status,e.de_senddeptid,e.de_receiverdeptid,e.de_isovertime,to_char(e.de_sendtime,'yyyy-mm-dd hh24:mi:ss') de_sendtime,to_char(e.de_signtime,'yyyy-mm-dd hh24:mi:ss') de_signtime,to_char(e.de_feedbacktime,'yyyy-mm-dd hh24:mi:ss') de_feedbacktime,to_char(e.de_feedbacksigntime,'yyyy-mm-dd hh24:mi:ss') de_feedbacksigntime,e.de_senderid,e.de_signerid,e.de_fbsenderid,e.de_fbsignerid ";
			sql_corr += "from tb_connwork c,tb_correspond d,tb_documentexchange e where c.cw_id=d.cw_id and d.co_id=e.de_primaryid and c.cw_id='" + cw_id + "'";
			
			Hashtable content_corr = dImpl.getDataInfo(sql_corr);
			if(content_corr!=null)
			{
						
						de_status = Integer.parseInt(content_corr.get("de_status").toString());
						switch(de_status)
						{
							case 1:
								dt_id = content_corr.get("de_receiverdeptid").toString();
								break;
							case 2:
								dt_id = content_corr.get("de_receiverdeptid").toString();
								break;
							case 4:
								dt_id = content_corr.get("de_senddeptid").toString();
								break;
							case 5:
								dt_id = content_corr.get("de_senddeptid").toString();
								break;
							default:
								dt_id = "";
								break;
						
						}
						corr_status[0] = "发&nbsp;&nbsp;&nbsp;&nbsp;送";
						corr_time[0] = content_corr.get("de_sendtime").toString();
						correr_id[0] = content_corr.get("de_senderid").toString();
						
						corr_status[1] = "发送签收";
						corr_time[1] = content_corr.get("de_signtime").toString();
						correr_id[1] = content_corr.get("de_signerid").toString();

						corr_status[2] = "反馈发送";
						corr_time[2] = content_corr.get("de_feedbacktime").toString();
						correr_id[2] = content_corr.get("de_fbsenderid").toString();

						corr_status[3] = "反馈签收";
						corr_time[3] = content_corr.get("de_feedbacksigntime").toString();
						correr_id[3] = content_corr.get("de_senderid").toString();
				
				for(int j=0;j<4;j++)
				{
					if(!correr_id[j].equals(""))
					{
						sql_correr = "select ui_name from tb_userinfo where ui_id="+correr_id[j];
						content_correr = dImpl.getDataInfo(sql_correr);
						if(content_correr!=null)
						{
							correr_name[j] = content_correr.get("ui_name").toString();
						}
					}
				}
				
				if(!dt_id.equals(""))
				{
					sql_dt = "select dt_name from tb_deptinfo where dt_id="+dt_id;
					content_dt = dImpl.getDataInfo(sql_dt);
					if(content_dt!=null)
					{
						turn_dept = content_dt.get("dt_name").toString();
					}
				}
			}
		}
	}
%>
<table WIDTH="100%" CELLPADDING="0" BORDER="0" class="main-table">
   <tr >
     <td width="100%" align="left" valign="top"colspan="2">
      <table class="content-table"  width="100%">
      <tr class="title1">
              <td align="center" colspan=2><%=strTitle %> </td>
      </tr>
      </table>
     </td>
   </tr>
      <tr class="line-even" >
        <td align="right">主&nbsp;&nbsp;&nbsp;&nbsp;题：</td>
		<td><%=cw_subject%></td>
      </tr>
      <tr class="line-even">
        <td align="right">发&nbsp;送&nbsp;人：</td>
		<td><%=cw_applyingname%></td>
      </tr>
	  <tr class="line-even">
        <td align="right">发送时间：</td>
		<td><%=cw_applyingtime%></td>
      </tr>
      <tr class="line-even">
        <td align="right">受理单位：</td>
		<td><%=dt_name%></td>
      </tr>
	  <tr class="line-odd">
        <td align="center" colspan="2" width="100%">处理状态</td>
      </tr>
	<%
	if(!ispostil.equals(""))
	{
	%>
	  <tr class="line-even">
        <td align="right">区长信件：</td>
		<td><%=warden_status%>&nbsp;&nbsp;<%=cw_wardenseetime%></td>
      </tr>
	<%
		if(!cw_status.equals("0"))
		{
	%>
	  <tr class="line-even">
        <td align="right"></td>
		<td><%=postil_status%>&nbsp;&nbsp;<%=cw_postiltime%>&nbsp;&nbsp;<%=cw_postilname%></td>
      </tr>	
	<%
		}
	}	
	%>
	  <tr class="line-even">
        <td align="right">受理签收：</td>
		<td><%=is_sign%>&nbsp;&nbsp;<%=sign_time%></td>
      </tr>
	<%
	if(content_turn!=null)
	{
	%>
	  <tr class="line-even">
        <td align="right">转办单位：</td>
		<td><%=turn_dept%></td>
      </tr>
	  <tr class="line-even">
        <td align="right">转办状态：</td>
		<td><%=corr_status[0]%>&nbsp;&nbsp;<%=correr_name[0]%>&nbsp;&nbsp;<%=corr_time[0]%></td>
      </tr>
	<%
		for(int k=1;k<4;k++)
		{
		if(!corr_time[k].equals(""))
		{
	%>
	  <tr class="line-even">
        <td align="right"></td>
		<td><%=corr_status[k]%>&nbsp;&nbsp;<%=correr_name[k]%>&nbsp;&nbsp;<%=corr_time[k]%></td>
      </tr>
	<%
		}
		}
	}
	if(cw_status.equals("3")||cw_status.equals("4"))
	{
	%>
	  <tr class="line-even">
        <td align="right">处理完成：</td>
		<td><%if(!correr_id[2].equals("")) {out.print("转办处理&nbsp;&nbsp;"+correr_name[2]);}%>&nbsp;&nbsp;<%=cw_finishtime%></td>
      </tr>
	<%
	}
	if(cw_issee.equals("1"))
	{
	%>
	  <tr class="line-even">
        <td align="right">用户查看：</td>
		<td><%=is_see%></td>
      </tr>
    <%
	}	
	%>
	  <tr class=title1>
		<td align=center colspan=2>
			<input value="返回" class="bttn" onclick="javascript:history.go(-1)" type="button" size="6">&nbsp;
	    </td>
	  </tr>
</table>
<%
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