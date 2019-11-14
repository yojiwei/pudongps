<%@page contentType="text/html; charset=GBK"%>
<%@include file="/system/app/skin/import.jsp"%>
<%
CDataCn dCn = null;
CDataImpl dImpl = null;
String sqlStr = "";
Vector vPage = null;
Hashtable content = null;
SecurityTest st = null;
String ui_id = ""; 
String ui_password = "";
try{
dCn = new CDataCn();
dImpl = new CDataImpl(dCn);
st = new SecurityTest();
sqlStr = "select ui_id,ui_password from tb_userinfo";
	vPage =  dImpl.splitPageOpt(sqlStr,300,1);
		if (vPage != null) {
			for (int i=0;i<vPage.size();i++) {
				content = (Hashtable)vPage.get(i);
				ui_id = CTools.dealNull(content.get("ui_id"));
				ui_password = CTools.dealNull(content.get("ui_password"));
				//================解密开始
        ui_password=st.decode(ui_password);
        byte[] bt = new sun.misc.BASE64Decoder().decodeBuffer(ui_password);
	  		ui_password = new String(bt);
	  		//================解密结束
	  		dCn.beginTrans();
				dImpl.executeUpdate("update tb_userinfo set ui_password='"+ui_password+"' where ui_id='"+ui_id+"'");
				if(dCn.getLastErrString().equals(""))
			  {
			    dCn.commitTrans();
			  }
			  else
			  {
			    dCn.rollbackTrans();
			  }
			}
			out.println("Now is action........");
		}else{
			out.println("Now is noting to change!");
		}

}
catch(Exception e){
out.print(e.toString());
}
finally{
dImpl.closeStmt();
dCn.closeCn(); 
}
%>
