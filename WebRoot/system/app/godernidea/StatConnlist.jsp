<%@ page contentType="text/html; charset=GBK" %>
<%@include file="/system/app/skin/head.jsp"%>
<%
  //update20080122

CDataCn dCn=null;   //新建数据库连接对象
CDataImpl dImpl=null;  //新建数据接口对象

try {
 dCn = new CDataCn(); 
 dImpl = new CDataImpl(dCn); 
  String strTitle ="";
  String beginTime = "";
  String endTime = "";
  String cp_name = "";
  String dt_id = "";
  String sqlStr = "";//选事项
  String sqlStr_dt = "";//选部门
  String sqlStr_cw1 = "";//选在办总数
  //String sqlStr_cw2 = "";//选在办超时
  //String sqlStr_cw3 = "";//选已办总数
  String sqlStr_cw4 = "";//选已办超时
  Hashtable content_cw = null;//选事项
  Hashtable content_cw1 = null;//选在办总数

  String cp_id = "";
  String cp_upid = "";
  String emailtype="";
  String sql_cw_id = "";
  Vector get_cw_id_vec = null;
  Vector vPage2 = null;
  Hashtable content2 = null;
  int j=3;
  String dtId = CTools.dealString(request.getParameter("dt_id")); 
  String sqlWhere = dtId.equals("")?"":"and b.cp_id ='" + dtId + "'";
  int count1 = 0;
  int count2 = 0;
  int totcount1 = 0;
  int totcount2 = 0;

  beginTime = CTools.dealString(request.getParameter("beginTime")).trim();
  endTime = CTools.dealString(request.getParameter("endTime")).trim();

if("".equals(dtId)){	//循环查处dtid（部门）
	sqlStr ="select dt_id from tb_connproc where cp_upid='o7' order by dt_name ";
	vPage2 = dImpl.splitPage(sqlStr,200,1);
	if(vPage2!=null)
	{		
		for(int n=0;n<vPage2.size();n++)//
		{
			content2 = (Hashtable)vPage2.get(n);
			sqlWhere += content2.get("dt_id").toString()+",";
		}
		sqlWhere = sqlWhere.substring(0,sqlWhere.length()-1);//去除最后的，；

		sqlWhere =" and b.dt_id in("+sqlWhere+")";		
	}	
}else{	
	
	sqlWhere =" and b.dt_id='"+dtId+"'";
}

sqlStr_dt = "select a.dt_name,b.dt_id,b.cp_name,b.cp_upid from tb_deptinfo a ,tb_connproc b where b.cp_upid='o7' and a.dt_id=b.dt_id "+ sqlWhere +" order by  dt_name desc";
%>

 <table class="main-table" width="100%" id="data">
 <tr>
  <td width="100%">     
   <table class="content-table" width="100%">
          <tr class="title1"> 
            <td colspan="4" align="center"> <table WIDTH="100%" BORDER="0" CELLSPACING="0" CELLPADDING="0">
                <tr> 
                  <td>&nbsp;&nbsp;&nbsp;&nbsp;金点子信箱统计表</td>
                  <td align="right" nowrap>
                    <img src="../../images/dialog/return.gif" border="0" onclick="javascript:history.back();" title="返回" style="cursor:hand" align="absmiddle" WIDTH="14" HEIGHT="14">&nbsp;
                  </td>
                </tr>
				<%
					  String sql_count="select count(*) as ad  from tb_connwork  where cp_id='o11000'";
					  int count_1=0,count_2=0,count_3=0;
					  Hashtable content_count = dImpl.getDataInfo(sql_count);
						if(content_count!=null)
						{
						count_1=Integer.parseInt(content_count.get("ad").toString()); 
						}
					  String sql_count2="select count(*) as ad2  from tb_connwork where cp_id='o11000' and cw_status='9'";
					  content_count = dImpl.getDataInfo(sql_count2);
						if(content_count!=null)
						{
						count_2=Integer.parseInt(content_count.get("ad2").toString()); 
						}
					   count_3= count_1-count_2;
				%>
				<tr>
					<td class="outset-table" align="center" colspan='2'>
						<font color='red'>信箱总信件数<%=count_1%>&nbsp;&nbsp;&nbsp;&nbsp;信箱有效信件数<%=count_3%></font>
					</td>
				</tr>
              </table></td>
          </tr>
          <tr class="bttn"> 
            <td width="10%" class="outset-table" nowrap align="center">序号</td>
            <td width="50%" class="outset-table" nowrap align="center">部门</td>
            <td width="20%" class="outset-table" nowrap align="center">收到信件</td>
            <td width="20%" class="outset-table" nowrap align="center">已答复信件</td>

          </tr>
          <%
	 //out.print(sqlStr_dt);
          Vector vPage = dImpl.splitPage(sqlStr_dt,request,200);
             if (vPage!=null)
             {				  
				 for (int i=0;i<vPage.size();i++)
				 {
					Hashtable content = (Hashtable)vPage.get(i);
			//	 	out.print(dt_id+"=dt_id");
					dt_id = content.get("dt_id").toString();
					cp_name = content.get("cp_name").toString();
					cp_upid = content.get("cp_upid").toString();
		%>
				<tr  width="100%" <%if (i%2==0) out.print("class='line-even'");else out.print("class='line-odd'");%>>
					<td align="center"><%=i+1%></td>
					<td align="center"><%=cp_name%></td>					
					<%
					  sqlStr = "select count(a.cw_id) ";
					  sqlStr += "from tb_connwork a,tb_connproc b ";
					  sqlStr += "where a.cw_status <>9 and a.cp_id=b.cp_id and b.dt_id="+dt_id+" and a.cw_emailtype='1' ";//没有答复的邮件

					  sql_cw_id = "select count(a.cw_id)  from tb_connwork a,tb_connproc b where a.cw_status =3 and a.cw_emailtype='1' and a.cp_id=b.cp_id and b.dt_id="+dt_id; //输出已答复的邮件
					  
					  if (!beginTime.equals(""))//输出开始时间
					  {
						sqlStr += " and a.cw_applytime > to_date('" + beginTime + " 00:00:00','yyyy-mm-dd hh24:mi:ss') ";
						sql_cw_id += " and a.cw_applytime > to_date('" + beginTime + " 00:00:00','yyyy-mm-dd hh24:mi:ss') ";
					 
					  }
					  if (!endTime.equals(""))//输出结束时间
					  {
						sqlStr += " and a.cw_applytime < to_date('" + endTime + " 23:59:59','yyyy-mm-dd hh24:mi:ss') "; 
						sql_cw_id += " and a.cw_applytime < to_date('" + endTime + " 23:59:59','yyyy-mm-dd hh24:mi:ss') ";  
					  }
				
					
					   
			    	  content_cw = dImpl.getDataInfo(sqlStr);
					  content_cw1 = dImpl.getDataInfo(sql_cw_id);
					
					if(content_cw!=null){ //判断邮件并自增
						
					       count1 = Integer.parseInt(content_cw.get("count(a.cw_id)").toString());
					       totcount1 += Integer.parseInt(content_cw.get("count(a.cw_id)").toString());//接收的邮件自增
					  
					}

					 if(content_cw!=null){

					      count2 = Integer.parseInt(content_cw1.get("count(a.cw_id)").toString());	  
                          totcount2 += Integer.parseInt(content_cw1.get("count(a.cw_id)").toString());//已答复邮件的自增
                  // out.print(sql_cw_id);    
				  
				  }             
				   %>
                  <td align="center"><a href="#"  onclick="fnsubmit(<%=dt_id%>,'all')"><%=count1%></a></td>
                  <td align="center"><a href="#"  onclick="fnsubmit(<%=dt_id%>,'finish')"><%=count2%></a></td>                  
				</tr>
				
				<%
						}
					if ("".equals(dtId)) {
				%>
				<tr class="line-even">
				    <td align="center">合计</td>
				    <td align="center">&nbsp;</td>
					<td align="center"><%=totcount1%></td>
					<td align="center"><%=totcount2%></td>
					 
					
				</tr>
				<%
					}
				}
				else
				{
					out.print("<tr class='line-even'><td colspan='5'>没有匹配记录</td></tr>");
				}
				%>
        </table>  
		</td>  
	</tr> <!-- 把提交的  传数值给下个页面  -->
	
	 <form name="formData" method="post" action="mailtationList.jsp"> 
		<input type="hidden"  value="" name="dt_id">
		<input type="hidden"  value="<%=beginTime%>" name="beginTime">
		<input type="hidden"  value="<%=endTime%>" name="endTime">
	
	 </form>

</table>
<SCRIPT LANGUAGE="javascript"> 

function fnsubmit(id,oper){	

	formData.dt_id.value=id;
	formData.action=formData.action+"?oper="+oper;
	formData.submit();
}

<!-- 
function AutomateExcel() 
{ 
// Start Excel and get Application object. 
var oXL = new ActiveXObject("Excel.Application"); 
// Get a new workbook. 
var oWB = oXL.Workbooks.Add(); 
var oSheet = oWB.ActiveSheet; 
var table = document.all.data; 
var hang = table.rows.length; 

var lie = table.rows(0).cells.length; 

// Add table headers going cell by cell. 
for (i=0;i<hang;i++) 
{ 
for (j=0;j<lie;j++) 
{ 
oSheet.Cells(i+1,j+1).value = table.rows(i).cells(j).innerText; 
} 

} 
oXL.Visible = true; 
oXL.UserControl = true; 
} 
//--> 
</SCRIPT>
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
<%@include file="/system/app/skin/bottom.jsp"%>