<%@ page contentType="text/html; charset=GBK" %>
<%@include file="/system/app/skin/head.jsp"%>
<%
//update20080122

CDataCn dCn=null;   //新建数据库连接对象
CDataImpl dImpl=null;  //新建数据接口对象

try {
 dCn = new CDataCn(); 
 dImpl = new CDataImpl(dCn); 
String OPType = "";
String strTitle = "查询列表";
String dtId = "";
String cp_upid="";
String dt_id = "";
String sqlStr = "";
String cp_name = "";     //项目名称
String cw_applyPeople = "";                   //申请人                   
String cp_timeLimit = "";		      //项目时限
 
                    
String color = "",overTitle="";               //项目超时的时候，设置标志的颜色和title

String status = "3";
String beginTime = "";
String endTime = "";
String cw_isovertime ="";
String cw_isovertimem ="";
String cw_emailtype="";
String [] arrys = null;
String cw_id_str = "";
String sql_cw_id ="";
String content_cw  ="";
 
String dtId2 = CTools.dealString(request.getParameter("dt_id")); 
String sqlWhere = dtId2.equals("")?"":"and b.cp_id = '" + dtId2 + "'";
   
 
  beginTime = CTools.dealString(request.getParameter("beginTime")).trim();
  endTime = CTools.dealString(request.getParameter("endTime")).trim();
 	
		
%>
 
<table class="main-table" width="100%" align="center">
<form name="formData" method="post">
	<tr class="title1" width="100%">
		<td colspan="9" align="center"><font size="2"><%=strTitle%></font></td>
	</tr>
	<tr width="100%">
		<td colspan="9" align="center">
			<table width="100%" border="0" cellpadding="0" cellspacing="0">
				<tr width="100%" class="bttn">	
					<td align="center" class="outset-table" width="10%" >发信人</td>
					<td align="center" class="outset-table" width="32%" >主题</td>					
					<td align="center" class="outset-table" width="16%" >发送时间</td>
					<td align="center" class="outset-table" width="16%" >办理完成时间</td>
				<!--	<td align="center" class="outset-table" width="8%" >受理超时</td>
					<td align="center" class="outset-table" width="8%" >办理超时</td>-->
					<td align="center" class="outset-table" width="10%" >操作</td>
				</tr>
 
 <%
	
    
			 
		 sqlStr = "select a.cw_id, a.cw_isovertime,a.cw_isovertimem,a.cw_applyingname,a.cw_subject,a.cw_applytime,a.cw_finishtime,a.cw_status ";
		 sqlStr += "from tb_connwork a,tb_connproc b ";
		 sqlStr += "where a.cw_status <>9 and a.cp_id=b.cp_id and b.dt_id="+dtId2+" and a.cw_emailtype='1' ";//没有答复的邮件	

		 sql_cw_id = "select a.cw_id, a.cw_isovertime,a.cw_isovertimem,a.cw_applyingname,a.cw_subject,a.cw_applytime,a.cw_finishtime,a.cw_status from tb_connwork a,tb_connproc b where a.cw_status =3 and a.cw_emailtype='1' and a.cp_id=b.cp_id and b.dt_id="+dtId2; //输出已答复的邮件
		 //	 out.print(sql_cw_id);
		  	 
		if (!beginTime.equals(""))//输出开始时间
					  {
						sqlStr += " and a.cw_applytime > to_date('" + beginTime + " 00:00:00','yyyy-mm-dd hh24:mi:ss') ";
						sql_cw_id += " and a.cw_applytime > to_date('" + beginTime + " 00:00:00','yyyy-mm-dd hh24:mi:ss') ";
					 
					  }
		if (!endTime.equals(""))//输出结束时间
					  {
						sqlStr += " and a.cw_applytime < to_date('" + endTime + " 23:59:59','yyyy-mm-dd hh24:mi:ss') "; 
						sql_cw_id += " and a.cw_applytime < to_date('" + endTime + " 23:59:59','yyyy-mm-dd hh24:mi:ss') ";  
					  }
					  
		 sqlStr +=" order by a.cw_applytime desc";
		 sql_cw_id +=" order by a.cw_applytime desc";

			Vector vPage = null;
			if(request.getParameter("oper").equals("all")){
				vPage=dImpl.splitPage(sqlStr,request,20);
			}else{
				vPage=dImpl.splitPage(sql_cw_id,request,20);
			}
			if (vPage!=null)
			{
				for (int i=0;i<vPage.size();i++)
				{
					Hashtable content = (Hashtable)vPage.get(i);
					cw_isovertime = content.get("cw_isovertime")==null?"":content.get("cw_isovertime").toString();
					cw_isovertimem = content.get("cw_isovertimem")==null?"":content.get("cw_isovertimem").toString();
		%>
					<tr width="100%" <%if (i%2==0) out.print("class='line-even'");else out.print("class='line-odd'");%>>
				 
						<td align="center"><%=content.get("cw_applyingname").toString()%></td>				<td><%=content.get("cw_subject").toString()%></td>	
						<td align="center"><%=content.get("cw_applytime").toString()%></td>
						<td><%=content.get("cw_finishtime").toString()%></td>					
					<!--	<td align="center"><%=cw_isovertime.equals("1")?"<font style='color:red'>是</font>":"否"%></td>
						<td align="center"><%=cw_isovertimem.equals("1")?"<font style='color:red'>是</font>":"否"%></td>-->
						<td align="center">	
	                     <span style="cursor:hand" onclick="javascript:window.location='mailtationInfo.jsp?cw_id=<%=content.get("cw_id").toString()%>&cw_status=<%=content.get("cw_status").toString()%>'">查 看</span></td>
					<%
				}
			}
			else
			{
				out.print("<tr class='line-even'><td colspan='9'>没有匹配记录</td></tr>");
			}
			%>
					</tr>
				</table>
			</td>
		</tr>
		<tr>
			<td colspan="9" align="right"><%out.print(dImpl.getTail(request));%></td>
		</tr>
		</form>
	</table>
	<%
	  dImpl.closeStmt();
	  dCn.closeCn();
	%>

<%@include file="/system/app/skin/bottom.jsp"%>
<%


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