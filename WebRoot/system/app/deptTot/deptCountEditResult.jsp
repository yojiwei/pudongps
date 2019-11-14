<%@page contentType="text/html; charset=GBK"%>
<%@include file="/system/app/skin/head.jsp"%>
<%
	String tt_type = CTools.dealString(request.getParameter("tt_type"));					//存储的类型
	String type = CTools.dealString(request.getParameter("type"));						 	//添加 add，修改 edit
	String tt_id = CTools.dealString(request.getParameter("tt_id"));
	String tt_dtname = CTools.dealString(request.getParameter("tt_dtname"));
	String tt_dir = CTools.dealString(request.getParameter("tt_dir"));
	String percent = CTools.dealString(request.getParameter("percent"));
	
	String thisUrl = "deptCountList.jsp?tt_type=" + tt_type;
	String alert = "信息已提交！";
	boolean boo = false;
	String sWhere = "";
	
	//System.out.println("deptCountEditResult.jsp_type = " + type);
	 
	if (type.equals("edit")) sWhere = " and tt_id <> " + tt_id;
		
	String sqlStr = "select tt_id from tb_totdept where tt_dir = '" + tt_dir + "'" + sWhere;
	
	CDataCn dCn = null;
  	CDataImpl dImpl = null;
  
  	try {
   		dCn = new CDataCn();
	 	dImpl = new CDataImpl(dCn);
  
  		//检查代码是否重复，如果重复不增加或修改
	  	Hashtable content = dImpl.getDataInfo(sqlStr);
	  	if (content != null) {
	  		boo = true;
	        alert = "代码已存在，请重新输入！";
	        thisUrl = "javascript:history.go(-1);";
	  	} 
	  	
  		if (boo == false) {
	        dImpl.setTableName("tb_totdept");
	        dImpl.setPrimaryFieldName("tt_id");
	        if (type.equals("add")) 
	        	dImpl.addNew();
	        else {
	        	alert = "信息修改完成！";
	        	dImpl.edit(tt_id);
	        }
	        if (tt_type.equals("0")) 
				dImpl.setValue("tt_dtids",percent,CDataImpl.STRING);//统计名称
				
			dImpl.setValue("tt_dtname",tt_dtname,CDataImpl.STRING);//统计名称
			dImpl.setValue("tt_dir",tt_dir,CDataImpl.STRING); //统计代码
			dImpl.setValue("tt_type",tt_type,CDataImpl.STRING); //统计类型
			dImpl.update();
	 	}
	}
	catch(Exception ex) {
		out.print(ex.toString());
	}
	finally {     
		dImpl.closeStmt();
		dCn.closeCn();
		//反馈信息
		
		out.print("<script language='javascript'>");
		out.print("alert('" + alert + "');");
		out.print("window.location='"+thisUrl+"';");
		out.print("</script>");	 
		
  }//finally  
%>
