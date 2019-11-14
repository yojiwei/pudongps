<%@page contentType="text/html; charset=GBK"%>
<%@include file="../skin/import.jsp"%>
<%
String actiontype,strId,strContent,strListNum,radiopub;
CDataCn dCn = new CDataCn(); //新建数据库连接对象
CDataImpl dImpl = new CDataImpl(dCn); //新建数据接口对象

actiontype=CTools.dealString(request.getParameter("actiontype"));
strId=CTools.dealString(request.getParameter("strId"));
strContent=CTools.dealString(request.getParameter("scontent")).trim();
String dv_id[]=request.getParameterValues("dv_id");
strListNum=request.getParameter("vt_listnum");
radiopub=request.getParameter("radiopub");

String[] strList=request.getParameterValues("vt_list");
String[] strListId=request.getParameterValues("vt_listId");

if(actiontype.equals("add"))  //新增
{
	
	long lmaxid = dImpl.addNew("tb_vote","vt_id");
	dImpl.setValue("vt_content",strContent,CDataImpl.STRING);
	dImpl.setValue("vt_listnum",strListNum,CDataImpl.STRING);
	dImpl.setValue("vt_pubflag",radiopub,CDataImpl.STRING);
	dImpl.update();

	String smaxid=Long.toString(lmaxid);
	
	for(int i=0;i<strList.length;i++)
	{
    long lmaxlistid=dImpl.getMaxId("tb_votelist");
    String smaxlistid=Long.toString(lmaxlistid);

		dImpl.setTableName("tb_votelist");
	    dImpl.setPrimaryFieldName("vt_listid");
		dImpl.addNew();
		dImpl.setValue("vt_id",smaxid,CDataImpl.STRING);
		dImpl.setValue("vt_listid",smaxlistid,CDataImpl.STRING);
		dImpl.setValue("vt_listcontent",CTools.dealString(strList[i]),CDataImpl.STRING);
		dImpl.update();

	}
	
	for(int j=0;j<dv_id.length;j++)
	{
	long lmax_vd_id=dImpl.getMaxId("TB_VOTE_DATAVALUE");
    String smax_vd_id=Long.toString(lmax_vd_id);
	
		dImpl.setTableName("TB_VOTE_DATAVALUE");
	    dImpl.setPrimaryFieldName("vd_id");
		dImpl.addNew();
		dImpl.setValue("vd_id",smax_vd_id,CDataImpl.STRING);
		dImpl.setValue("vt_id",smaxid,CDataImpl.STRING);
		dImpl.setValue("dv_id",CTools.dealString(dv_id[j]),CDataImpl.STRING);
		dImpl.update();
	}
	
}
else if(actiontype.equals("modify")) 			//修改
{
  	dImpl.edit("tb_vote","vt_id",Integer.parseInt(strId));
	dImpl.setValue("vt_content",strContent,CDataImpl.STRING);
	dImpl.setValue("vt_pubflag",radiopub,CDataImpl.STRING);
	dImpl.update();

	for(int i=0;i<strList.length;i++)
	{
		dImpl.edit("tb_votelist","vt_listid",Integer.parseInt(strListId[i]));
		dImpl.setValue("vt_listcontent",CTools.dealString(strList[i]),CDataImpl.STRING);
		dImpl.update();
	}
	//
	String delVotedatavalue="delete from TB_VOTE_DATAVALUE where vt_id ="+Integer.parseInt(strId);
	dImpl.executeUpdate(delVotedatavalue);
	for(int j=0;j<dv_id.length;j++)
	{
	long lmax_vd_id=dImpl.getMaxId("TB_VOTE_DATAVALUE");
    String smax_vd_id=Long.toString(lmax_vd_id);
	
		dImpl.setTableName("TB_VOTE_DATAVALUE");
	    dImpl.setPrimaryFieldName("vd_id");
		dImpl.addNew();
		dImpl.setValue("vd_id",smax_vd_id,CDataImpl.STRING);
		dImpl.setValue("vt_id",strId,CDataImpl.STRING);
		dImpl.setValue("dv_id",CTools.dealString(dv_id[j]),CDataImpl.STRING);
		dImpl.update();
	}
	

}
else			//发布
{
	String strcheck=CTools.dealString(request.getParameter("radiopub"));
	String strSql="update tb_vote set vt_pubflag=0";
	dImpl.executeUpdate(strSql);

	String strSql2="update tb_vote set vt_pubflag=1 where vt_id="+strcheck;
	dImpl.executeUpdate(strSql2);
}

 dImpl.closeStmt();
 dCn.closeCn();
 response.sendRedirect("voteList.jsp");
%>