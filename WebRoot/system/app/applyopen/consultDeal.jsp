<%@page contentType="text/html; charset=GBK"%>
<%@include file="/system/app/skin/head.jsp"%>
<%
//by ph 2007-3-3  信息公开一体化
String iid = CTools.dealString(request.getParameter("iid")).trim();
String cid = CTools.dealString(request.getParameter("cid")).trim();
String tid = CTools.dealString(request.getParameter("tid")).trim();
String commentinfo = CTools.dealString(request.getParameter("commentinfo")).trim();

String sqlStr = "";
Hashtable content = null;

CDataCn dCn = null;
CDataImpl dImpl = null;

try{
	dCn = new CDataCn();
	dImpl = new CDataImpl(dCn);

	SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	
	/*CMySelf mySelf = (CMySelf)session.getAttribute("mySelf");
	if (mySelf!=null){
		dt_id = Long.toString(mySelf.getDtId());
		sqlStr = "select dt_name from tb_deptinfo where dt_id = " + dt_id;
		content = dImpl.getDataInfo(sqlStr);
		if (content != null) dt_name = content.get("dt_name").toString();
	}*/

	dCn.beginTrans();//开始事务
	
	//更新征询记录状态
	dImpl.edit("consult","id",Integer.parseInt(cid));
	dImpl.setValue("status","2",CDataImpl.INT);
	dImpl.setValue("finishtime",df.format(new java.util.Date()),CDataImpl.DATE);
	dImpl.setValue("commentinfo",commentinfo,CDataImpl.STRING);
	dImpl.update();
	
	//更新原来任务状态
	dImpl.edit("taskcenter","id",Integer.parseInt(tid));
	dImpl.setValue("status","0",CDataImpl.INT);
	dImpl.update();

	//更新信息公开申请表状态
	dImpl.edit("infoopen","id",Integer.parseInt(iid));
	dImpl.setValue("status","1",CDataImpl.INT);
	dImpl.update();
		
	if (dCn.getLastErrString().equals("")){
		dCn.commitTrans();
%>
		<script language="javascript">
			window.location="conList.jsp";
		</script>
<%
	}else{
		dCn.rollbackTrans();
%>
		<script language="javascript">
			alert("发生错误，操作失败！");
			window.history.go(-1);
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