<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="../skin/head.jsp"%>
<%@page import="com.component.database.*"%>
<%@page import="com.app.*"%>
<%
String de_id="";
String de_status="";
String co_id="";
String pr_id="";
String wo_id="";
String de_senddeptid="";
String selfdtid="";
String de_signerid="";
boolean statusFlag=true;

//update20080122

CDataCn dCn=null;   //新建数据库连接对象
CDataImpl dImpl=null;  //新建数据接口对象

try {
 dCn = new CDataCn(); 
 dImpl = new CDataImpl(dCn); 


CMySelf self = (CMySelf)session.getAttribute("mySelf");
//out.println(self.getDtId());
selfdtid = String.valueOf(self.getDtId());
String my_id = String.valueOf(self.getMyID());


de_id = CTools.dealString(request.getParameter("de_id")).trim();
String sql_de= " select de_status,de_senddeptid from tb_documentexchange where de_id='"+de_id+"' ";
Hashtable content_de = dImpl.getDataInfo(sql_de);
if(content_de!=null)
{
de_status = content_de.get("de_status").toString();
de_senddeptid = content_de.get("de_senddeptid").toString();
}
//de_status = CTools.dealString(request.getParameter("de_status")).trim();
co_id = CTools.dealString(request.getParameter("co_id")).trim();
pr_id = CTools.dealString(request.getParameter("pr_id")).trim();
wo_id = CTools.dealString(request.getParameter("wo_id")).trim();
//de_senddeptid = CTools.dealString(request.getParameter("de_senddeptid")).trim();
//out.print(wo_id);out.close();
dCn.beginTrans();

dImpl.edit("tb_documentexchange","de_id",de_id);
		if(de_status.equals("1"))
		{
			dImpl.setValue("de_status","2",CDataImpl.STRING);
			dImpl.setValue("de_signtime",(new java.util.Date()).toLocaleString(),CDataImpl.DATE);
			dImpl.setValue("de_signerid",my_id,CDataImpl.INT);
			dImpl.update();
     		response.sendRedirect("../cooperate/CorrForm.jsp?OPType=Recorr&wo_id="+wo_id+"&co_id="+co_id+"&de_id="+de_id+"&de_senddeptid="+de_senddeptid);

		}
		else if(de_status.equals("4"))
		{   out.println(de_status);
			dImpl.setValue("de_status","5",CDataImpl.STRING);
			dImpl.setValue("de_feedbacksigntime",(new java.util.Date()).toLocaleString(),CDataImpl.DATE);
			dImpl.setValue("de_fbsignerid",my_id,CDataImpl.INT);
			dImpl.update();

			String sqlWStatus = " select co_status from tb_correspond where wo_id='"+wo_id+"' and co_status in ('1','2')";
			//out.println(sqlWStatus);out.close();
			//if (true) return ;
			//out.println(statusFlag);
			Vector vectorWStatus = dImpl.splitPage(sqlWStatus,request,20);
			if(vectorWStatus==null)
			{
				/*for(int i=0;i<vectorWStatus.size();i++)
				{
					Hashtable content=(Hashtable)vectorWStatus.get(i);
					if(!content.get("co_status").toString().equals("3")&&!content.get("co_status").toString().equals("4"))
					{
						out.println("adf");out.close();
						statusFlag=false;
						break;
					}
				}*/
				dImpl.edit("tb_work","wo_id",wo_id);
				dImpl.setValue("wo_status","1",CDataImpl.STRING);
				dImpl.update();
			}
			/*if(statusFlag==true)
			{
				out.println(statusFlag);
				dImpl.edit("tb_work","wo_id",wo_id);
				dImpl.setValue("wo_status","1",CDataImpl.STRING);
				dImpl.update();
			}*/
     		response.sendRedirect("../cooperate/CorrForm.jsp?OPType=fdsign&co_id="+co_id);

		}


dCn.commitTrans();

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
//out.println(co_id);
%>

<%@include file="../skin/bottom.jsp"%>

