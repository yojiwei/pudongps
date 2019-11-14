<%@page contentType="text/html; charset=GBK"%>
<%@include file="/system/app/skin/head.jsp"%>
<%

String cid = (String)request.getParameter("cid");//2放入垃圾回收站1恢复任务3集体恢复任务
String iid = (String)request.getParameter("iid");
String [] id = request.getParameterValues("checkdel");

CDataCn dCn = null;
CDataImpl dImpl = null;

try{
	dCn = new CDataCn();
	dImpl = new CDataImpl(dCn);
	SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	dCn.beginTrans();
	
	if("3".equals(cid)){          //集体恢复任务到指派任务
	for (int i=0;i<id.length;i++){
	dImpl.edit("infoopen", "id", id[i]);
	dImpl.setValue("checktype", "1", CDataImpl.STRING);
	dImpl.setValue("status", "0", CDataImpl.STRING);
	dImpl.setValue("applytime",df.format(new java.util.Date()),CDataImpl.DATE);
	dImpl.update();
	}
	}else if("2".equals(cid)){    //将任务变成垃圾任务
	dImpl.edit("infoopen", "id", iid);
	dImpl.setValue("checktype", "9", CDataImpl.STRING);
	dImpl.setValue("status", "2", CDataImpl.STRING);
	dImpl.setValue("applytime",df.format(new java.util.Date()),CDataImpl.DATE);
	dImpl.update();
	}else{                         //恢复任务成指派任务
	dImpl.edit("infoopen", "id", iid);
	dImpl.setValue("checktype", "1", CDataImpl.STRING);
	dImpl.setValue("status", "0", CDataImpl.STRING);
	dImpl.setValue("applytime",df.format(new java.util.Date()),CDataImpl.DATE);
	dImpl.update();
	}
	
	dCn.commitTrans();
	if("2".equals(cid)){   //将任务变成垃圾任务,返回到指派任务列表
%>
		<script language="javascript">
			alert("操作已成功！");		
			window.location.reload("assignCenter.jsp");
		</script>
<%
	}else{           //恢复任务成指派任务，返回到垃圾列表
		
%>
		<script language="javascript">
			alert("操作已成功！");		
			window.location.reload("rubbishlist.jsp");
		</script>
<%
	}

}catch(Exception e){
	out.print(e.toString());
}finally{
	dImpl.closeStmt();
	dCn.closeCn(); 
}
%>
<%@include file="/system/app/skin/bottom.jsp"%>