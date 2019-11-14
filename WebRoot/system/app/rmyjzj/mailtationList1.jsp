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
  String sqlStr_cw2 = "";//选在办超时
  String sqlStr_cw3 = "";//选已办总数
  String sqlStr_cw4 = "";//选已办超时
  Hashtable content_cw = null;//选事项
  Hashtable content_cw1 = null;//选在办总数
  Hashtable content_cw2 = null;//选在办超时
  Hashtable content_cw3 = null;//选已办总数
  Hashtable content_cw4 = null;//选已办超时
  String cp_id = "";
  String cp_upid = "";
  String cw_emailtype = CTools.dealString(request.getParameter("cw_emailtype"));
  int j=0;
  String dtId = CTools.dealString(request.getParameter("dt_id")); 
  String sqlWhere = dtId.equals("0")?"":"and b.dt_id = '" + dtId + "'";
  int count1 = 0;
  int count2 = 0;
  int count3 = 0;
  int count4 = 0;
  int count5 = 0;


  beginTime = CTools.dealString(request.getParameter("beginTime")).trim();
  endTime = CTools.dealString(request.getParameter("endTime")).trim();
 //deptconn = CTools.dealString(request.getParameter("deptconn")).trim();
  
 //sqlStr_dt = "select a.dt_name,b.dt_id,b.cp_name,b.cp_upid from tb_deptinfo a ,tb_connproc b where a.cp_id=b.cp_id " + sqlWhere + " order by  dt_name desc";
 sqlStr_dt = "select  b.dt_name,b.dt_id,b.cp_name,b.cp_upid from tb_connwork c ,tb_connproc b  where c.cp_id=b.cp_id  "+ sqlWhere +" order by  b.dt_name desc";
// out.println(sqlStr_dt);
	 //if(true)return;
%>
  
 <table class="main-table" width="100%" id="data">
 <tr>
  <td width="100%">     
   <table class="content-table" width="100%">
          <tr class="title1"> 
            <td colspan="4" align="center"> <table WIDTH="100%" BORDER="0" CELLSPACING="0" CELLPADDING="0">
                <tr> 
                  <td>金点子信箱统计表</td>
                  <td align="right" nowrap>
                    <!--<img src="../../skin/default/images/split.gif" align="middle" border="0">-->
                    <!--<img src="../../skin/default/images/puncher09.gif" border="0" title="打印" style="cursor:hand" onclick="javascript:window.open('statPrjReportPrint.asp','_Blank','width=500,height=500,noresize=1,scrollbars=1');" align="absmiddle" WIDTH="18	" HEIGHT="18">                     <img src="../../skin/default/images/split.gif" align="middle" border="0">                     -->
                    <img src="../../images/dialog/return.gif" border="0" onclick="javascript:history.back();" title="返回" style="cursor:hand" align="absmiddle" WIDTH="14" HEIGHT="14">&nbsp;
                    <!--<img src="../../skin/default/images/split.gif" align="middle" border="0">--> 
                  </td>
                </tr>
              </table></td>
          </tr>
    	<tr width="100%" class="bttn">	
					<td align="center" class="outset-table" width="10%" >发信人</td>
					<td align="center" class="outset-table" width="32%" >主题</td>					
					<td align="center" class="outset-table" width="16%" >发送时间</td>
					<td align="center" class="outset-table" width="16%" >办理完成时间</td>
					<td align="center" class="outset-table" width="8%" >受理超时</td>
					<td align="center" class="outset-table" width="8%" >办理超时</td>
					<td align="center" class="outset-table" width="10%" >操作</td>
				</tr>
          <!--tr class="bttn"> 
            <td class="outset-table" nowrap>受理超时</td>
            <td class="outset-table" nowrap>办理超时</td>
          </tr>
          <!--tr class="bttn"> 
            <td width="45" class="outset-table" nowrap>总数</td>
            <td width="45" class="outset-table" nowrap>超时</td>
            <td width="45" class="outset-table" nowrap>总数</td>
            <td width="45" class="outset-table" nowrap>超时</td>
            <td width="45" class="outset-table" nowrap>提前</td>
            <td width="45" class="outset-table" nowrap>退回</td>
          </tr-->
          <%
		
          Vector vPage = dImpl.splitPage(sqlStr_dt,request,200);
             if (vPage!=null)

             {	
				
	     for (int i=0;i<vPage.size();i++)
	     {
		Hashtable content = (Hashtable)vPage.get(i);
		dt_id = content.get("dt_id").toString();
		cp_name = content.get("cp_name").toString();
		cp_upid = content.get("cp_upid").toString();		 
		%>
				<tr width="100%" <%if (i%2==0) out.print("class='line-even'");else out.print("class='line-odd'");%>>
					<td align="center"><%=i+1%></td>
					<td align="center"><%=content.get("dt_name").toString()%>
					<%
					sqlStr="select * from tb_connwork where cw_emailtype='"+cw_emailtype+"'";	
					%>
						</td>					
					<%
					  sqlStr = "select count(a.cw_id) ";
					  sqlStr += "from tb_connwork a,tb_connproc b ";
					  //sqlStr += "where (b.cp_id='o5' or b.cp_upid='o5') and  a.cp_id=b.cp_id and b.dt_id="+dt_id;
					  sqlStr += "where a.cp_id=b.cp_id and b.dt_id="+dt_id;
					  switch(j)
					  {
					  	case 1:
					  	    sqlStr += " and b.cp_upid='"+cp_upid+"'";
							
					  	    break;
							
					  	case 2:
					  	    sqlStr += " and b.cp_upid='"+cp_upid+"'and emailtype='1'";
							
					  	    break;
					  	case 3:
							
					  	    //sqlStr += " and b.cp_upid='"+cp_upid+"'";
					  	    //sqlStr += " and (b.cp_upid='"+cp_upid+"' or b.cp_id='"+cp_upid+"')";
					  	    break;
					  }
					  if (!beginTime.equals(""))
					  {
					 	sqlStr += " and a.cw_applytime > to_date('" + beginTime + " 00:00:00','yyyy-mm-dd hh24:mi:ss') ";
					  }
					  if (!endTime.equals(""))
					  {
						sqlStr += " and a.cw_applytime < to_date('" + endTime + " 23:59:59','yyyy-mm-dd hh24:mi:ss') ";
					  }
					//  out.println(sqlStr);
					  content_cw = dImpl.getDataInfo(sqlStr);
					  count1 += Integer.parseInt(content_cw.get("count(a.cw_id)").toString());
					%>
					 
                      <%
                      sqlStr_cw2 = "select count(a.cw_id) ";
					  sqlStr_cw2 += "from tb_connwork a,tb_connproc b  ";
					  sqlStr_cw2 += "where a.cw_status <> 9 and a.cw_isovertime='1' and a.cp_id=b.cp_id and b.dt_id="+dt_id;
					  switch(j)
					  {
					  	case 1:
					  	    sqlStr_cw2 += " and b.cp_upid='"+cp_upid+"'";
					  	    break;
					  	case 2:
					  	    sqlStr_cw2 += " and b.cp_upid='"+cp_upid+"'";
					  	    break;
					  	case 3:
					  	    //sqlStr_cw2 += " and (b.cp_upid='"+cp_upid+"' or b.cp_id='"+cp_upid+"')";
					  	    break;
					  }
					  if (!beginTime.equals(""))
					  {
					 	sqlStr_cw2 += " and a.cw_applytime > to_date('" + beginTime + " 00:00:00','yyyy-mm-dd hh24:mi:ss') ";
					  }
					  if (!endTime.equals(""))
					  {
						sqlStr_cw2 += " and a.cw_applytime < to_date('" + endTime + " 23:59:59','yyyy-mm-dd hh24:mi:ss')";
					  }
					  // out.println("<br>"+sqlStr_cw2);
					  //  out.println(sqlStr_cw2);
					  content_cw2 = dImpl.getDataInfo(sqlStr_cw2);
					  count3 += Integer.parseInt(content_cw2.get("count(a.cw_id)").toString());
                                        %>
                                  <td align="center"><%=count1%> 
								 
                                        </td>          
                      <%
                      sqlStr_cw3 = "select count(a.cw_id) ";
					  sqlStr_cw3 += "from tb_connwork a,tb_connproc b  ";
					  sqlStr_cw3 += "where a.cw_status <> 9 and a.cw_isovertimem='1' and a.cp_id=b.cp_id and b.dt_id="+dt_id;
					  switch(j)
					  {
					  	case 1:
					  	    sqlStr_cw3 += " and b.cp_upid='"+cp_upid+"'";
					  	    break;
					  	case 2:
					  	    sqlStr_cw3 += " and b.cp_upid='"+cp_upid+"'";
					  	    break;
					  	case 3:
					  	    //sqlStr_cw3 += " and (b.cp_upid='"+cp_upid+"' or b.cp_id='"+cp_upid+"')";
					  	    break;
					  }
					  if (!beginTime.equals(""))
					  {
					 	sqlStr_cw3 += " and a.cw_applytime > to_date('" + beginTime + " 00:00:00','yyyy-mm-dd hh24:mi:ss') ";
					  }
					  if (!endTime.equals(""))
					  {
						sqlStr_cw3 += " and a.cw_applytime < to_date('" + endTime + " 23:59:59','yyyy-mm-dd hh24:mi:ss')";
					  }
					  //out.println("<br>"+sqlStr_cw3);
					  content_cw3 = dImpl.getDataInfo(sqlStr_cw3);
					  count4 += Integer.parseInt(content_cw3.get("count(a.cw_id)").toString());
                                        %>
                  <td  align="center"><%=count1%> </td>
                  <td></td>
				</tr>
				<%
				        }
				%>
				<tr class="line-even">
				        <td align="center">合计
					</td>
				 					
					<td align="center"><%=count1%></td>
					   <td align="center"> </td>  
                                        
					 
					<td align="center"> 
					</td>
					
				</tr>
				<%
				}
				else
				{
					out.print("<tr class='line-even'><td colspan='5'>没有匹配记录</td></tr>");
				}
				%>
        </table>  
		</td>  
	</tr>
	
                                            
</table>
<SCRIPT LANGUAGE="javascript"> 
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