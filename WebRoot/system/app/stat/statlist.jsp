<%@page contentType="text/html; charset=GBK"%>
<%
String strTitle = "统计列表";
%>
<%@ include file="../skin/head.jsp"%>
<%

//update20080122

CDataCn dCn=null;   //新建数据库连接对象
CDataImpl dImpl=null;  //新建数据接口对象

try {
 dCn = new CDataCn(); 
 dImpl = new CDataImpl(dCn); 

String myname="";
CMySelf mySelf = (CMySelf)session.getAttribute("mySelf");
myname=mySelf.getMyName();
String mytime="";
mytime=(new java.util.Date()).toLocaleString();
mytime=mytime.substring(0,10);

String user,start_date,end_date;
user=CTools.dealString(request.getParameter("user")).trim();
start_date=CTools.dealString(request.getParameter("start_date")).trim();
end_date=CTools.dealString(request.getParameter("end_date")).trim();

//String strSql="select ui.ui_name as ui_name,count(ui.ui_name) as countnum from tb_contentlog cl,tb_userinfo ui " +sWhere+" group by ui_name";

//out.println(strSql);

%>

<table border="0" width="100%">
<tr>
<td></td>
<td align="right">
时间段：
	 <% 
		if ((start_date.equals(""))&&(end_date.equals(""))) 
		   {out.print("不限");}
	    if ((!start_date.equals("")) && (end_date.equals("")))
		   {out.print(start_date+ " 至今");}
		if ((!end_date.equals("")) && (start_date.equals("")))
		   {out.print("截止至 " + end_date);}
		if ((!start_date.equals("")) && !end_date.equals(""))
		   {out.print(start_date+" 到 "+end_date);}	
	  %>
						    
</td></tr>
<tr><td colspan="2">
<table border="0" width="100%" cellpadding="3" height="44">
   <tr class="bttn">
	 <td width="10%" height="1" class="outset-table">序号</td>
	 <td width="25%" height="1" class="outset-table">操作人</td>
	 <td width="15%" height="1" class="outset-table">新增数量</td>
	 <td width="15%" height="1" class="outset-table">修改数量</td>
	 <td width="15%" height="1" class="outset-table">删除数量</td>
	 <td width="20%" height="1" class="outset-table">操作总数</td>				
  </tr>

<%
   String sql="select distinct ui_id,ui_name from tb_userinfo ";
   if(!user.equals(""))
   {sql=sql+ "where ui_name='"+user+"'";
   }
  //  out.println(sql);
   Vector vectorPage = dImpl.splitPage(sql,request,20);
     
	String sWhere="where 1=1 ";
   if (!start_date.equals(""))
	{
		sWhere=sWhere + " and cl_date >= TO_DATE('"+ start_date +"','YYYY-MM-DD')";
	}
   if (!end_date.equals(""))
	{
		sWhere=sWhere + " and cl_date <= TO_DATE('"+ end_date +"','YYYY-MM-DD')";
	} 

     String operate="";
     String Add="0";
	 String Edit="0";
	 String Delete="0"; 
	 int AddCount=0;
	 int EditCount=0;
	 int DeleteCount=0;
	 int CountCount=0;

   if (vectorPage!=null)
     {   
	      for(int j=0;j<vectorPage.size();j++)
			 {
               Hashtable content = (Hashtable)vectorPage.get(j);	
			   if(j % 2 == 0)  out.print("<tr class=\"line-even\">");
               else out.print("<tr class=\"line-odd\">");
			   out.println("<td>" + (j+1) + "</td>");
              out.println("<td>" + content.get("ui_name") + "</td>");

//内层循环，读出统计数量

      String strSql="select count(ui_id) as countnum,cl_operate from tb_contentlog "+sWhere+ " and ui_id="+content.get("ui_id")+" group by cl_operate";
  	// out.println(strSql);
	
             Vector vectorPage1 = dImpl.splitPage(strSql,request,20);
             
			   if (vectorPage1!=null)
                  {  
				   
			     for(int i=0;i<vectorPage1.size();i++)
		           {	

					 
                       Hashtable content1 = (Hashtable)vectorPage1.get(i);
					   operate=content1.get("cl_operate").toString();
					   
						if (operate.equals("Add"))
							{
                           Add=content1.get("countnum").toString();
						}
						
                        if (operate.equals("Delete"))
							{
                            Delete=content1.get("countnum").toString();
							}
						
						if (operate.equals("Edit"))
							{
                           Edit=content1.get("countnum").toString();
						   }
					    
						
                      }
				    }
					int count=Integer.parseInt(Add)+Integer.parseInt(Delete)+Integer.parseInt(Edit);
//内层循环结束
					 out.println("<td>" + Add + "</td>");
					 out.println("<td>" + Edit + "</td>");
					 out.println("<td>" + Delete + "</td>");
		 	         out.println("<td>" + count + "</td>");
	                 out.println("</tr>");
                     
					 AddCount=AddCount+Integer.parseInt(Add); 
					 EditCount=EditCount+Integer.parseInt(Edit); 
					 DeleteCount=DeleteCount+Integer.parseInt(Delete); 
					 CountCount=CountCount+count;
					 Add="0";Edit="0";Delete="0"; 
            }
    }
 
%>
<tr class="bttn">
    <td colspan="2">总计</td>
    <td><%=AddCount%></td>
	<td><%=EditCount%></td>
	<td><%=DeleteCount%></td>
	<td><%=CountCount%></td></tr>
</table>
</td></tr>
<tr>
<td>制表人：<%=myname%>
</td>
<td align="right">
制表时间：<%=mytime%>
</td><tr>
</table>
<%
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
%>
<%@ include file="../skin/bottom.jsp"%>


