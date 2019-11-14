<%@page contentType="text/html; charset=GBK"%>
<%@include file="/system/app/skin/head.jsp"%>
<%
	CDataCn dCn = null;
	CDataImpl dImpl = null;
	try
	{
		dCn = new CDataCn();
		dImpl = new CDataImpl(dCn);
		Vector mail_vector = null;
		Hashtable mail_content = null;
		boolean cmail =false;
		int number=0;
		String subject = CTools.dealString(request.getParameter("subject")).trim(); 
		String bodycontent = CTools.dealString(request.getParameter("bodycontent")).trim(); 
		String sql = "select em_id,em_value from tb_emailsave where em_needsend='1' order by em_id desc";
        mail_vector = dImpl.splitPage(sql,200,1);
		if(mail_vector!=null){
	      for(int i=0;i<mail_vector.size();i++){
              mail_content = (Hashtable)mail_vector.get(i);
			  String em_id = mail_content.get("em_id")+"";
			  String em_value = mail_content.get("em_value")+"";
        dImpl.executeUpdate("update tb_emailsave set em_sendnumber=em_sendnumber+1 where em_id='"+em_id+"'");
		CMail sMail = new CMail("smtp.pudong.gov.cn"); //新建Mail对象 smtp.pudong.gov.cn 
		sMail.setNeedAuth(true); 
		sMail.setNamePass("zzc","123456"); //发件箱用户名、密码 fzb 123456
		sMail.setSubject(subject);  //发送信件主题
		sMail.setBody("亲爱的"+em_value.substring(0,em_value.indexOf('@'))+":<br/>您好！<br/><br/>"+bodycontent+"<br/><br/>你有什么意见或提议请通过本站投诉信箱写信给我们！假如你要退订，请复制下面地址到地址栏确认:<a href="+"http://www.pudong.gov.cn/pddjw/mailDel.jsp?cancel=cancel&em_id="+em_id+""+"  target="+"_blank"+">http://www.pudong.gov.cn/pddjw/mailDel.jsp?cancel=cancel&em_id="+em_id+"</a>,请不要写信或回复内容到本信箱！");  //发送信件正文com

		sMail.setFrom("zzc@pudong.gov.cn "); //发件箱 xxx@xxx.xxx
		sMail.setTo(em_value); //收件箱 xxx@xxx.xxx
		cmail=sMail.sendout();
		if(cmail)number++;
		}
		}
		out.print("<script>alert('发送成功"+number+"封邮件!');window.location.href='sendInfo.jsp';</script>");
		}catch(Exception ex)
	{
		out.print("<br>"+ex);
	}
	finally
	{
		if(dImpl!=null)
		{
			dImpl.closeStmt();
		}
		if(dCn!=null)
		{
			dCn.closeCn();
		}
	}
%>