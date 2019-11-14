<%@page contentType="text/html; charset=GBK"%>
<%@page import="com.util.*"%>
<%@page import="com.beyondbit.dataexchange.*,com.component.database.*,java.sql.*"%>
<%@include file="/system/app/islogin.jsp"%>

<%

String CT_id="";

CT_id = CTools.dealNumber(request.getParameter("ct_id")).trim();//??id
String ct_title = CTools.dealString(request.getParameter("ctTitle"));

//update20080122

CDataCn dCn=null;   //
CDataImpl dImpl=null;  //

try {
 dCn = new CDataCn(); 
 dImpl = new CDataImpl(dCn); 


try
{

	 String sjName = "";
	  Statement st = dCn.getConnection().createStatement();
      ResultSet rs = st.executeQuery(" select SJ_NAME from TB_CONTENT where  CT_ID =  "+ Integer.parseInt(CT_id));
	  if(rs.next()){
		sjName = rs.getString("SJ_NAME");
	  }
	  rs.close();
	  st.close();
	  if( sjName != null){
			String[] b =sjName.split(",");
			for(int i=0;i<b.length;i++){
				if("图片新闻".equals(b[i])){
					ThreadCache.pushItem(CT_id,"2","图片新闻","271","http://in-inforportal.pudong.sh/sites/manage");
					ThreadCache.pushItem(CT_id,"2","图片新闻","270","http://inforportal.pudong.sh/sites/manage");
					
				}
				if("区管干部任免".equals(b[i])){
					ThreadCache.pushItem(CT_id,"2","人事任免","269","http://in-inforportal.pudong.sh/sites/manage");
					ThreadCache.pushItem(CT_id,"2","人事任免","260","http://inforportal.pudong.sh/sites/manage");
				}
			
			}
		}
	//modify for hh
	CMySelf mySelf = (CMySelf)session.getAttribute("mySelf");
    String userName = mySelf.getMyName();
    String userId = String.valueOf(mySelf.getMyUid());
    String action = "";
	if (!"".equals(userId)) action += "," + userId;
	if (!"".equals(CT_id)) action += "," + CT_id;
	com.beyondbit.web.publishinfo.LogAction lan = new com.beyondbit.web.publishinfo.LogAction();
	lan.setDelLog(userName,action,ct_title);
	//end modify
  dImpl.delete("tb_content","ct_id",Long.parseLong(CT_id));

  dImpl.update() ;
  
  dImpl.executeUpdate("delete tb_infostatic where infoid = '" + CT_id + "'");
  
  dImpl.closeStmt();
  dCn.closeCn();
	
  out.println("yes?");
}
catch(Exception e)
{
  out.println("error message:" + e.getMessage());
}



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