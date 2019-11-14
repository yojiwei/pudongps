<%@page contentType="text/html; charset=GBK"%>
<%@include file="/system/app/skin/head.jsp"%>
<%
String board_name = CTools.dealString(request.getParameter("board_name")).trim();    //主题名称
String board_comment = CTools.dealString(request.getParameter("board_comment")).trim();   //主题说明
String board_netmeet_url = CTools.dealString(request.getParameter("board_netmeet_url")).trim();   //本期办公会URL
String board_shi_url = CTools.dealString(request.getParameter("board_shi_url")).trim();    //实录URL
String board_xuan_url = CTools.dealString(request.getParameter("board_xuan_url")).trim();   //选编URL
if(board_comment.length()>500){
	board_comment.substring(0,500);
}

String board_publish_flag =  CTools.dealString(request.getParameter("board_publish_flag")).trim();//是否发布
String board_hot_flag = CTools.dealString(request.getParameter("board_hot_flag")).trim();   //本期主题
String board_create_date = CTools.dealString(request.getParameter("board_create_date")).trim();   //本期主题创建时间
String sort_id = CTools.dealString(request.getParameter("sort_id")).trim();    //栏目ID
String board_master_id = CTools.dealString(request.getParameter("dept_id")).trim();//所属部门ID 
//out.print(board_master_id+"++");
String board_id="";
String[] vals = board_master_id.split(",");
String board_master_name = "";//所属部位单位
String ssqlStr="";
Hashtable ccontent=null;
CDataCn dCn = null;
CDataImpl dImpl = null;
PreparedStatement stmt = null;

CDataCn cdCn = null;
CDataImpl cdImpl = null;

try{
cdCn = new CDataCn();//源数据库连接
cdImpl = new CDataImpl(cdCn); //源数据库连接

dCn = new CDataCn("pddjw");
dImpl = new CDataImpl(dCn); 

		    Vector vPage = null;
		    dCn.beginTrans();//事务开始		

			if(board_hot_flag.equals("1"))
			{
				String sql="update forum_board_pd set board_hot_flag=0";
				stmt=dCn.getConnection().prepareStatement(sql);
				stmt.executeUpdate();
			}
//主表保存
dImpl.setTableName("forum_board_pd");
dImpl.setPrimaryFieldName("board_id");
	board_id =String.valueOf(dImpl.addNew());//out.print(board_id);if(true)return;
    dImpl.setValue("board_create_date",board_create_date,CDataImpl.DATE);
    dImpl.setValue("BOARD_LAST_POST_DATE",board_create_date,CDataImpl.DATE);
    dImpl.setValue("BOARD_LAST_POSTER",board_master_name,CDataImpl.STRING);
	dImpl.setValue("sort_id",sort_id,CDataImpl.STRING);
	dImpl.setValue("board_name",board_name,CDataImpl.STRING);
    dImpl.setValue("board_comment",board_comment,CDataImpl.STRING);
    dImpl.setValue("board_netmeet_url",board_netmeet_url,CDataImpl.STRING);
	dImpl.setValue("board_shi_url",board_shi_url,CDataImpl.STRING);
    dImpl.setValue("board_xuan_url",board_xuan_url,CDataImpl.STRING);
    dImpl.setValue("board_publish_flag",board_publish_flag,CDataImpl.STRING);
	if(board_hot_flag.equals("1"))dImpl.setValue("board_hot_flag",board_hot_flag,CDataImpl.STRING);
    dImpl.update();
if(!board_master_id.equals(""))
	{

for(int i=0;i<vals.length; i++)
			{	
 			 board_master_id=vals[i];
			 ssqlStr = "select dt_name from tb_deptinfo where dt_id="+board_master_id;
				ccontent = cdImpl.getDataInfo(ssqlStr);		
				if(ccontent!=null)board_master_name = ccontent.get("dt_name").toString();
				dImpl.setTableName("forum_deptmanage_pd");
				dImpl.setPrimaryFieldName("deptmanage_id");
				dImpl.addNew();   
			    dImpl.setValue("board_id",board_id,CDataImpl.STRING);
			    dImpl.setValue("dt_id",board_master_id,CDataImpl.INT);
				dImpl.setValue("dt_name",board_master_name,CDataImpl.STRING);
			    dImpl.update();
								
						}
		}
if (dCn.getLastErrString().equals(""))
{	
	dCn.commitTrans();	
	out.print("<script> alert('新建成功！');  window.location='postList.jsp?sort_id="+sort_id+"';</script>");
   


}
else
{
dCn.rollbackTrans();
%>
<script language="javascript"  >
	alert("发生错误，录入失败！");
	window.history.go(-1);
</script>
<%
}	
}
catch(Exception e){
//e.printStackTrace();
out.print(e.toString());
}
finally{
cdImpl.closeStmt();
cdCn.closeCn(); 

dImpl.closeStmt();
dCn.closeCn(); 
}
%>