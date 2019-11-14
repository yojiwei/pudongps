<%@page contentType="text/html; charset=ISO8859_1" %>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<%@include file="/system/app/skin/import.jsp"%>
<%
  //update20080122

CDataCn dCn=null;   //
CDataImpl dImpl=null;  //

try {
 dCn = new CDataCn(); 
 dImpl = new CDataImpl(dCn); 
  
  String strTitle = "互动事项汇总统计表";
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
  String cp = CTools.dealString(request.getParameter("cp")).trim();
    String dtId = CTools.dealString(request.getParameter("dt_id"));
  String sqlWhere = dtId.equals("0")?"":" and a.dt_id='" + dtId + "'";
  String cp_id = "";
  String cp_upid = "";
  int count1 = 0;
  int count2 = 0;
  int count3 = 0;
  int count4 = 0;
  int count5 = 0;
  int j = 0;//区分互动事项类型
  j = Integer.parseInt(cp);
  StringBuffer outputStr = new StringBuffer();

  beginTime = CTools.dealString(request.getParameter("beginTime")).trim();
  endTime = CTools.dealString(request.getParameter("endTime")).trim();
  switch(j)
  {
  	case 1:
             sqlStr_dt = "select a.dt_name,b.dt_id,b.cp_name,b.cp_upid from tb_deptinfo a ,tb_connproc b where a.dt_id=b.dt_id and b.cp_id in('o1','o2','o3') " + sqlWhere + " order by dt_name desc";
             break;
        case 2:
             sqlStr_dt = "select a.dt_name,b.dt_id,b.cp_name,b.cp_upid from tb_deptinfo a ,tb_connproc b where a.dt_id=b.dt_id and b.cp_upid='o6' " + sqlWhere + " order by dt_name desc";
             break;
        case 3:
             //sqlStr_dt = "select a.dt_name,b.dt_id,b.cp_name,b.cp_upid from tb_deptinfo a ,tb_connproc b where a.dt_id=b.dt_id and (b.cp_id='o4' or b.cp_upid='o4') order by dt_name desc";
             sqlStr_dt = "select a.dt_name,b.dt_id,b.cp_name,b.cp_upid from tb_deptinfo a ,tb_connproc b where a.dt_id=b.dt_id and (b.cp_id in('o4','o5','o8','o9','o10')) " + sqlWhere + " order by dt_name desc";             
             break;
		//网上咨询
        case 4:
             //sqlStr_dt = "select a.dt_name,b.dt_id,b.cp_name,b.cp_upid from tb_deptinfo a ,tb_connproc b where a.dt_id=b.dt_id and (b.cp_id='o4' or b.cp_upid='o4') order by dt_name desc";
			 sqlStr_dt = "select a.dt_name,b.dt_id,b.cp_name,b.cp_upid from tb_deptinfo a ,tb_connproc b where a.dt_id=b.dt_id and b.cp_upid='o7' " + sqlWhere + " order by dt_name desc";              
			 break;
		case 5:
             sqlStr_dt = "select a.dt_name,b.dt_id,b.cp_name,b.cp_upid from tb_deptinfo a ,tb_connproc b where a.dt_id=b.dt_id and b.cp_upid='o10000' " + sqlWhere + " order by dt_name desc";         
             break;
        default:
             break;
  }

 outputStr.append("<table class=\"main-table\" width=\"100%\">");
 outputStr.append("<tr>");
  outputStr.append("<td width=\"100%\">");     
   outputStr.append("<table class=\"content-table\" width=\"100%\">");
          outputStr.append("<tr class=\"title1\">"); 
            outputStr.append("<td colspan=\"10\" align=\"center\"> <table WIDTH=\"100%\" BORDER=\"0\" CELLSPACING=\"0\" CELLPADDING=\"0\">");
                outputStr.append("<tr>"); 
                  outputStr.append("<td>"+strTitle+"&nbsp;&nbsp;</td>");
                  outputStr.append("<td align=\"right\" nowrap>&nbsp;");
                  outputStr.append("</td>");
                outputStr.append("</tr>");
              outputStr.append("</table></td>");
          outputStr.append("</tr>");
          outputStr.append("<tr class=\"bttn\">"); 
            outputStr.append("<td width=\"40\" class=\"outset-table\" nowrap rowspan=\"3\">序号</td>");
            outputStr.append("<td width=\"50\" class=\"outset-table\" nowrap rowspan=\"3\" align=\"center\">部门</td>");
            outputStr.append("<td width=\"179\" class=\"outset-talbe\" nowrap rowspan=\"3\">事项名称</td>");
            outputStr.append("<td width=\"65\" class=\"outset-talbe\" nowrap rowspan=\"3\">总收数</td>");
            outputStr.append("<td class=\"outset-table\" nowrap colspan=\"6\">各类型事项数</td>");
          outputStr.append("</tr>");
          outputStr.append("<tr class=\"bttn\">"); 
            outputStr.append("<td class=\"outset-table\" nowrap colspan=\"2\">在办</td>");
            outputStr.append("<td class=\"outset-table\" nowrap colspan=\"2\">已办</td>");
          outputStr.append("</tr>");
          outputStr.append("<tr class=\"bttn\">"); 
            outputStr.append("<td width=\"45\" class=\"outset-table\" nowrap>总数</td>");
            outputStr.append("<td width=\"45\" class=\"outset-table\" nowrap>超时</td>");
            outputStr.append("<td width=\"45\" class=\"outset-table\" nowrap>总数</td>");
            outputStr.append("<td width=\"45\" class=\"outset-table\" nowrap>超时</td>");
          outputStr.append("</tr>");
          Vector vPage = dImpl.splitPage(sqlStr_dt,request,200);
             if (vPage!=null)
             {
	     for (int i=0;i<vPage.size();i++)
	     {
		Hashtable content = (Hashtable)vPage.get(i);
		dt_id = content.get("dt_id").toString();
		cp_name = content.get("cp_name").toString();
		cp_upid = content.get("cp_upid").toString();

				outputStr.append("<tr width=\"100%\">"); 
					outputStr.append("<td align=\"center\">"+String.valueOf(i+1)+"</td>");
					outputStr.append("<td align=\"center\">"+new String(content.get("dt_name").toString().getBytes("GBK"), "ISO8859_1")+"</td>");
					outputStr.append("<td align=\"center\">"+new String(cp_name.getBytes("GBK"), "ISO8859_1")+"</td>");

					  sqlStr = "select count(a.cw_id) ";
					  sqlStr += "from tb_connwork a,tb_connproc b ";
					  sqlStr += "where a.cp_id=b.cp_id and b.dt_id="+dt_id;
					  switch(j)
					  {
					  	case 1:
					  	    sqlStr += " and b.cp_upid='"+cp_upid+"'";
					  	    break;
					  	case 2:
					  	    sqlStr += " and b.cp_upid='"+cp_upid+"'";
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
						sqlStr += " and a.cw_applytime < to_date('" + endTime + " 23:59:59','yyyy-mm-dd hh24:mi:ss')";
					  }
					  content_cw = dImpl.getDataInfo(sqlStr);
					  count1 += Integer.parseInt(content_cw.get("count(a.cw_id)").toString());

					outputStr.append("<td align=\"center\">"+content_cw.get("count(a.cw_id)").toString()+"</td>");

                      sqlStr_cw1 = "select count(a.cw_id) ";
					  sqlStr_cw1 += "from tb_connwork a,tb_connproc b  ";
					  sqlStr_cw1 += "where a.cw_status in('1','2','8') and a.cp_id=b.cp_id and b.dt_id="+dt_id;
					  switch(j)
					  {
					  	case 1:
					  	    sqlStr_cw1 += " and b.cp_upid='"+cp_upid+"'";
					  	    break;
					  	case 2:
					  	    sqlStr_cw1 += " and b.cp_upid='"+cp_upid+"'";
					  	    break;
					  	case 3:
					  	    //sqlStr_cw1 += " and (b.cp_upid='"+cp_upid+"' or b.cp_id='"+cp_upid+"')";
					  	    break;
					  }
					  if (!beginTime.equals(""))
					  {
					 	sqlStr_cw1 += " and a.cw_applytime > to_date('" + beginTime + " 00:00:00','yyyy-mm-dd hh24:mi:ss') ";
					  }
					  if (!endTime.equals(""))
					  {
						sqlStr_cw1 += " and a.cw_applytime < to_date('" + endTime + " 23:59:59','yyyy-mm-dd hh24:mi:ss')";
					  }
					  content_cw1 = dImpl.getDataInfo(sqlStr_cw1);
					  count2 += Integer.parseInt(content_cw1.get("count(a.cw_id)").toString());
                      
					  outputStr.append("<td align=\"center\">"+content_cw1.get("count(a.cw_id)").toString()+"</td>");

					  sqlStr_cw2 = "select count(a.cw_id) ";
					  sqlStr_cw2 += "from tb_connwork a,tb_connproc b  ";
					  sqlStr_cw2 += "where a.cw_status in('1','2','8') and a.cw_isovertime='1' and a.cp_id=b.cp_id and b.dt_id="+dt_id;
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
					  content_cw2 = dImpl.getDataInfo(sqlStr_cw2);
					  count3 += Integer.parseInt(content_cw2.get("count(a.cw_id)").toString());
                      
                      outputStr.append("<td align=\"center\">"+content_cw2.get("count(a.cw_id)").toString()+"</td>");

					  sqlStr_cw3 = "select count(a.cw_id) ";
					  sqlStr_cw3 += "from tb_connwork a,tb_connproc b  ";
					  sqlStr_cw3 += "where a.cw_status='3' and a.cp_id=b.cp_id and b.dt_id="+dt_id;
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
					  content_cw3 = dImpl.getDataInfo(sqlStr_cw3);
					  count4 += Integer.parseInt(content_cw3.get("count(a.cw_id)").toString());
                      
					  outputStr.append("<td align=\"center\">"+content_cw3.get("count(a.cw_id)").toString()+"</td>");

                      sqlStr_cw4 = "select count(a.cw_id) ";
					  sqlStr_cw4 += "from tb_connwork a,tb_connproc b  ";
					  sqlStr_cw4 += "where a.cw_status='3' and a.cw_isovertime='1' and a.cp_id=b.cp_id and b.dt_id="+dt_id;
					  switch(j)
					  {
					  	case 1:
					  	    sqlStr_cw4 += " and b.cp_upid='"+cp_upid+"'";
					  	    break;
					  	case 2:
					  	    sqlStr_cw4 += " and b.cp_upid='"+cp_upid+"'";
					  	    break;
					  	case 3:
					  	    //sqlStr_cw4 += " and (b.cp_upid='"+cp_upid+"' or b.cp_id='"+cp_upid+"')";
					  	    break;
					  }
					  if (!beginTime.equals(""))
					  {
					 	sqlStr_cw4 += " and a.cw_applytime > to_date('" + beginTime + " 00:00:00','yyyy-mm-dd hh24:mi:ss') ";
					  }
					  if (!endTime.equals(""))
					  {
						sqlStr_cw4 += " and a.cw_applytime < to_date('" + endTime + " 23:59:59','yyyy-mm-dd hh24:mi:ss')";
					  }
					  content_cw4 = dImpl.getDataInfo(sqlStr_cw4);
					  count5 += Integer.parseInt(content_cw4.get("count(a.cw_id)").toString());
                      
					  outputStr.append("<td align=\"center\">"+content_cw4.get("count(a.cw_id)").toString()+"</td></tr>");
			        }

				outputStr.append("<tr class=\"line-even\">");
				        outputStr.append("<td align=\"center\">合计");
					outputStr.append("</td>");
					outputStr.append("<td align=\"center\">");
					outputStr.append("</td>");
					outputStr.append("<td align=\"center\">");
					outputStr.append("</td>");
					outputStr.append("<td align=\"center\">"+String.valueOf(count1)+"</td>");
					outputStr.append("<td align=\"center\">"+String.valueOf(count2)+"</td>");
					outputStr.append("<td align=\"center\">"+String.valueOf(count3)+"</td>");
					outputStr.append("<td align=\"center\">"+String.valueOf(count4)+"</td>");
					outputStr.append("<td align=\"center\">"+String.valueOf(count5)+"</td>");
				outputStr.append("</tr>");
				}
				else
				{
					outputStr.append("<tr class='line-even'><td colspan='9'>没有匹配记录</td></tr>");
				}
        outputStr.append("</table>");  
		outputStr.append("</td>");  
	outputStr.append("</tr>");
                                         
outputStr.append("</table>");

dImpl.closeStmt();
dCn.closeCn();
	
	response.setContentType("application/download");
	response.setHeader("Content-Disposition","attachment;filename="+strTitle+".xls");
	out.print(outputStr.toString());
	
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