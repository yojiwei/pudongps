<%@page contentType="text/html; charset=GBK"%>
<%@include file="../../manage/head.jsp"%>

<body>
<%
  String ct_id = CTools.dealString(request.getParameter("ct_id")).trim(); //关联信息主键
  String cc_id = CTools.dealString(request.getParameter("cc_id")).trim(); //主键
  String cc_answer_time = CTools.dealString(request.getParameter("ccAnswerTime")).trim(); //是否发布标记
  String cc_publish_flag = CTools.dealString(request.getParameter("ccPublishFlag")).trim(); //是否发布标记
	String cc_answer = CTools.dealString(request.getParameter("ccAnswer")).trim(); //答复内容
	String thisUrl = "commentListZB.jsp?ct_id=" + ct_id;
	
	if ("0".equals(cc_publish_flag)) {
	  thisUrl += "&publishFlag=0";
	}
	
	if ("".equals(cc_answer_time)) {
  java.util.Date answerDate  = new java.util.Date();

  cc_answer_time = answerDate.toLocaleString();
	}
	
	CDataCn dCn = null;
  CDataImpl dImpl = null;
  
  try {
   dCn = new CDataCn();
	 dImpl = new CDataImpl(dCn);

  dImpl.edit("tb_contentcomment","cc_id",cc_id);//答复评论
  dImpl.setValue("cc_answer_time",cc_answer_time,CDataImpl.STRING);//答复时间
  dImpl.setValue("cc_publish_flag",cc_publish_flag,CDataImpl.STRING); //是否发布标记
  dImpl.setValue("cc_answer",cc_answer,CDataImpl.STRING); //是否发布标记
  dImpl.update();
	 
  }catch(Exception ex){
     out.print(ex.toString());
  }finally{     
		 dImpl.closeStmt();
		 dCn.closeCn();
		 //反馈信息
		 
		 out.write("<script language='javascript'>");
		 out.write("alert('答复已提交!');");
		 out.write("window.location='"+thisUrl+"';");
		 out.write("</script>");	 
		
  }//finally 
%>
</body>