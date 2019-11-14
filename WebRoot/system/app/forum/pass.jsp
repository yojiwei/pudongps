<%@page contentType="text/html; charset=GBK"%>
<%@ page import="org.apache.commons.lang.StringUtils.*" %>
<%@include file="/system/app/skin/head.jsp"%>
<%
	String revert_id = "";
	String passflag = "";
	String passresult = "";
	String strPage = CTools.dealString(request.getParameter("strPage")).trim();    //当前页
	
	revert_id = CTools.dealString(request.getParameter("revert_id")).trim(); 
	passresult = CTools.dealString(request.getParameter("passresult")).trim(); 
	
	String sort_id = CTools.dealString(request.getParameter("sort_id")).trim(); 
	String board_id = CTools.dealString(request.getParameter("board_id")).trim(); 
	String post_id = CTools.dealString(request.getParameter("post_id")).trim(); 
	
	String revert_audit_date = "";//审核时间 
	java.text.DateFormat df = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	java.util.Date date = new java.util.Date();
	revert_audit_date = df.format(date);
	
   if(passresult.equals("通过"))passflag="1";
   else if(passresult.equals("不通过"))passflag="2";
   else passflag="0";
	CDataCn dCn = null;
	CDataImpl dImpl = null;
	try{
		dCn = new CDataCn();
		dImpl = new CDataImpl(dCn); 
		dCn.beginTrans();//事务开始
		//主表保存
		//回复后更新主题
dImpl.edit("forum_revert","revert_id",revert_id);
dImpl.setValue("revert_status",passflag,CDataImpl.STRING);//forum_revert中是否通过
dImpl.setValue("revert_audit_date",revert_audit_date,CDataImpl.DATE);
dImpl.update();

			if("".equals(dCn.getLastErrString())){
				dCn.commitTrans();	
	%>
				<script language="javascript">						
					window.location="revertList.jsp?strPage=<%=strPage%>&sort_id=<%=sort_id%>&revert_id=<%=revert_id%>&board_id=<%=board_id%>&post_id=<%=post_id%>";
				</script>
	<%
			}else{
				dCn.rollbackTrans();
	%>
				<script language="javascript"  >
					alert("发生错误，审核失败");
					window.history.go(-1);
				</script>
	<%
			}
			
	}catch(Exception e){
		//e.printStackTrace();
		out.print(e.toString());
	}finally{
		dImpl.closeStmt();
		dCn.closeCn(); 
	}
%> 