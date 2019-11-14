
<%@page import="com.util.*"%>
<%@page import="com.component.database.*"%>
<%@page contentType="text/html; charset=GBK"%>
<%@ page import="com.beyondbit.dataexchange.*,org.apache.log4j.*,java.sql.*" %>

<%

String il_id="";

il_id=CTools.dealNumber(request.getParameter("ct_id")).trim();//主键id

String cp_id = CTools.dealNumber(request.getParameter("cp_id")).trim();//主键id

//out.println("il_id=" + il_id);

//update20080122

CDataCn dCn=null;   //新建数据库连接对象
CDataImpl dImpl=null;  //新建数据接口对象

try {
 dCn = new CDataCn(); 
 dImpl = new CDataImpl(dCn); 
	  String sjName = "";
	  Statement st = dCn.getConnection().createStatement();
      ResultSet rs = st.executeQuery(" select SJ_NAME from TB_CONTENT where  CT_ID =  "+ Integer.parseInt(il_id));
	  if(rs.next()){
		sjName = rs.getString("SJ_NAME");
	  }
	  rs.close();
	  st.close();

try
{
  dImpl.delete("tb_contentpublish","ct_id",Long.parseLong(il_id));
  dImpl.update() ;
  dImpl.delete("tb_content","ct_id",Long.parseLong(il_id));
  dImpl.update() ;



/************************同步传送删除数据到中台***********************************************/


   if( sjName != null){
			String[] b =sjName.split(",");
			for(int i=0;i<b.length;i++){
				if("图片新闻".equals(b[i])){
					ThreadCache.pushItem(il_id,"2","图片新闻","271","http://in-inforportal.pudong.sh/sites/manage");
					ThreadCache.pushItem(il_id,"2","图片新闻","270","http://inforportal.pudong.sh/sites/manage");
					
				}
				if("区管干部任免".equals(b[i])){
					ThreadCache.pushItem(il_id,"2","人事任免","269","http://in-inforportal.pudong.sh/sites/manage");
					ThreadCache.pushItem(il_id,"2","人事任免","260","http://inforportal.pudong.sh/sites/manage");
				}
			
			}
		}
/************************同步传送删除数据到中台结束***********************************************/



  /***************
  dImpl.delete("tb_content","ct_id",Long.parseLong(il_id));
  //dImpl.edit("tb_iplist","il_id",Integer.parseInt(il_id));
  dImpl.setValue("ct_delflag","1",CDataImpl.INT);
  dImpl.update() ;
  *****************/
  dImpl.closeStmt();
  dCn.closeCn();
  //out.println("删除成功");
  
	out.write("<script language='javascript'>");
	out.write("alert('删除成功');");
	out.write("window.location.href='ipList.jsp';");
	out.write("</script>");
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