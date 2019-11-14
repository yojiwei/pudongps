<%@page contentType="text/html; charset=GBK"%>
<%@include file="/system/app/skin/head.jsp"%>

<%
	int returnPage = 0;
	String redirectURL ="";
	//String sort_code="";
	String sort_id = CTools.dealString(request.getParameter("sort_id"));
	String sort_name = CTools.dealString(request.getParameter("sort_name"));
	String sort_code = CTools.dealString(request.getParameter("sort_code"));
	String sort_parent_id = CTools.dealString(request.getParameter("sort_parent_id"));
	String sort_sequence = CTools.dealString(request.getParameter("sequence"));

	//String sort_sequence = CTools.dealString(request.getParameter("sort_sequence"));
	String sort_showflag = CTools.dealString(request.getParameter("sort_showflag"));
	String sort_desc = CTools.dealString(request.getParameter("sort_desc"));
	String OPType = CTools.dealString(request.getParameter("OPType"));

	CDataCn dCn = null;
	CDataImpl dImpl = null;
	String sql ;
	try{
		dCn = new CDataCn("pddjw");
		dImpl = new CDataImpl(dCn);	
		dImpl.setTableName("forum_sort");  //设置表名
		dImpl.setPrimaryFieldName("sort_id");//设置主键
		if("add".equalsIgnoreCase(OPType)){
			dImpl.edit("forum_sort","sort_id",sort_id);  //表名，主键，主键值
			sort_id = Long.toString(dImpl.addNew());  //确定为新增记录的方法，自动返回主键，并设置为字段
			dImpl.setValue("sort_code",sort_code,CDataImpl.STRING);
			
			//dImpl.setValue("sort_code",sort_code,CDataImpl.STRING);			
		}else if("edit".equalsIgnoreCase(OPType)){
			dImpl.edit("forum_sort","sort_id",sort_id);//where条件
			dImpl.setValue("sort_code","sort_code",CDataImpl.STRING);
		}
		dImpl.setValue("sort_sequence",sort_sequence,CDataImpl.STRING);
		dImpl.setValue("sort_name",sort_name,CDataImpl.STRING);  //String为插入数据库的内容
		dImpl.setValue("sort_showflag",sort_showflag,CDataImpl.STRING);
		dImpl.setValue("sort_desc",sort_desc,CDataImpl.STRING);
		if (!"".equals(sort_parent_id)){
			dImpl.setValue("sort_parent_id",sort_parent_id,CDataImpl.INT);
		}
		dImpl.update();
		//返回页面设置
		if ("".equals(sort_id)) returnPage = 1;
		switch(returnPage)
		{
			case 0: redirectURL = "postList.jsp";break;
			case 1: redirectURL = "postList.jsp?sort_id=" + sort_id;break;	
		}
		if (dCn.getLastErrString().equals(""))
		{
			dCn.commitTrans();
				
%>
		<script language="javascript">
			alert("操作已成功！");
			window.location="<%=redirectURL%>";
		</script>
<%
			}else{
			dCn.rollbackTrans();
			out.print(dCn.getLastErrString());
%>
		<script language="javascript">
			alert("发生错误，录入失败！");
			window.history.go(-1);
		</script>
<%
		}
	}catch(Exception e){
		//e.printStackTrace();
		out.print(e.toString());
	}
	finally{
		dImpl.closeStmt();
		dCn.closeCn(); 
	}
%>