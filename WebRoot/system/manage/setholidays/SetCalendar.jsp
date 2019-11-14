<%@page contentType="text/html; charset=GBK"%>
<%@include file="/system/app/skin/head.jsp"%>
<%@page import="java.util.*"%>
<%@page import="java.text.DateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.Calendar"%>
<%
CDate today = new CDate();
String isHoliday = "";
String currDate = CTools.dealString(request.getParameter("currDate"));
String fromMonth = CTools.dealString(request.getParameter("fromMonth"));
String holidays = "",workDays="";
if(currDate.equals(""))
{
    currDate = today.getThisday();
}
int numYear = Integer.parseInt(CTools.dealNumber(request.getParameter("SY")));
if(numYear==0)
{
    numYear = today.getNowYear();//获取年份
}
int numMonth = Integer.parseInt(CTools.dealNumber(request.getParameter("SM")));
if(numMonth==0)
{
    numMonth = today.getNowMonth();//获取月份
}
if(fromMonth.equals("0"))
{
    if(numMonth==1)
    {
	numMonth = 12;
	numYear -= 1;
    }
    else
	numMonth -= 1;
}
else if(fromMonth.equals("2"))
{
    if(numMonth==12)
    {
	numMonth = 1;
	numYear += 1;
    }
    else
	numMonth += 1;
}
currDate = Integer.toString(numYear)+ "-" + Integer.toString(numMonth)+"-"+"1";
CFormatDate firstDay = new CFormatDate(new Date(numYear-1900,numMonth-1,1).toLocaleString());
//Date的初始化函数决定了年份要减1900，月份要-1
//日期不变；

int dayCount = today.getDayCount(numYear,numMonth);

CFormatDate lastDay = new CFormatDate(new Date(numYear-1900,numMonth-1,dayCount).toLocaleString());

DateFormat df = DateFormat.getDateInstance();

int firstDay_of_week = (df.parse(firstDay.getFullDate())).getDay();//获取本月的1号是星期几
int lastDay_of_week = (df.parse(lastDay.getFullDate())).getDay();

String strSql = "select HD_DATE,HD_FLAG,HD_REMARK from TB_HOLIDAY where HD_DATE >= to_date('"+firstDay.getFullDate()+"','YYYY-MM-DD') and  HD_DATE<=to_date('"+lastDay.getFullDate()+"','YYYY-MM-DD')";
//
CDataCn dCn = null;
CDataImpl dImpl = null;
try{
dCn = new CDataCn();
dImpl = new CDataImpl(dCn);
//
String initHoliday = dImpl.getInitParameter("holiday");//读取系统预设休息日参数

Vector vectorPage = dImpl.splitPage(strSql,request,dayCount);
String [] HD_remarks = new String[dayCount+1];
if(vectorPage!=null)
{
    for(int i=0;i<vectorPage.size();i++)
    {
	Hashtable row = (Hashtable)vectorPage.get(i);
	isHoliday = row.get("hd_flag").toString();
	Date myDate = df.parse(row.get("hd_date").toString());
	HD_remarks[myDate.getDate()] = row.get("hd_remark").toString();
	if(isHoliday.equals("1"))
	{
	    holidays += new CFormatDate(row.get("hd_date").toString()).getFullDate()+",";
	}
	else if(isHoliday.equals("0"))
	{
	    workDays += new CFormatDate(row.get("hd_date").toString()).getFullDate()+",";
	}
	if(!holidays.equals("")) holidays = "," + holidays;
	if(!workDays.equals("")) workDays = "," + workDays;
    }
}
%>
<%@include file="/system/app/skin/skin4/template/list_top.jsp"%>
<!--    模块名称开始    -->
工作日/节假日设置
<!--    模块名称结束    -->
<%@include file="/system/app/skin/skin4/template/list_function.jsp"%>                                                            
<!--    功能按钮开始    -->
  
<!--    功能按钮结束    -->
<%@include file="/system/app/skin/skin4/template/list_listtop.jsp"%>                                                                                        
<!--    列表开始    -->
<script language="javascript">
 function Calendar_add()
  {
    document.formData.action="SetDay.jsp";
    document.formData.submit();
  }
 function xpre()
  {
    document.formData.action="SetCalendar.jsp";
    document.formData.fromMonth.value ="0";
    document.formData.submit();
  }

  function xnext()
  {
    formData.action="SetCalendar.jsp";
    formData.fromMonth.value ="2";
    formData.submit();
  }
function changeCld()
{
   var y,m;
   y=formData.SY.selectedIndex+1900;
   m=formData.SM.selectedIndex+1;
   formData.currDate.value=y+"-"+m+"-01";
   formData.action="SetCalendar.jsp";
   formData.submit();
}
</script>
<table align="center" class="main-table" width="100%"><!-- main table -->
<form name="formData" method="post">
  <tr class="title1" width="100%">
  	<td>
  		<table WIDTH="100%" BORDER="0" CELLSPACING="1" CELLPADDING="1">
  			<tr>
  				<td>工作日/节假日设置</td>
  			</tr>
  		</table>
  	</td>
  </tr>
  <tr>
    <td width="60%" valign="top">
     <table width="100%" class=bttn> <!-- bar table-->
      <tr>
           <td width="20%" nowrap>
               <input type="button" class="bttn" value=" < " title="上一月" onclick="xpre()" id=button1 name=button1>
               本月
               <input type="button" class="bttn" value=" > " title="下一月" onclick="xnext()" id=button2 name=button2>&nbsp;&nbsp;
           </td>
           <td width="45%" nowrap align=center>&nbsp;
           </td>
           <td width="35%" align="right" nowrap>
               <input type="button" value="增加"  class="bttn" name="add" onclick="Calendar_add()">
           </td>
       </tr>
     </table> <!-- end of bar table -->
    </td>
  </tr>
  <tr>
    <td>
<table class="FindAreaTable1" cellspacing="1" rules="cols" border="0" id="ctl00_DataGrid_DataGrid1" style="border-width:0px;">
        <tr class=bttn>
          <td colspan="7"  align="center" height=25 class="line-odd">
             <SELECT name="SY" onchange=changeCld() style="FONT-SIZE: 9pt" class="select-a">
             	<SCRIPT language=JavaScript><!--
                	for(var i=1900;i<2050;i++) document.write('<option>'+i+'</option>');
                        /-->
                </SCRIPT>
             </SELECT>&nbsp;年&nbsp;
             <SELECT name="SM" onchange=changeCld() style="FONT-SIZE: 9pt" class="select-a">
                <SCRIPT language=JavaScript><!--
                        for(var i=1;i<13;i++) document.write('<option>'+i+'</option>');
                   //-->
                </SCRIPT>
             </SELECT>&nbsp;月

             <SCRIPT language=JavaScript>
  	  	document.formData.SY.selectedIndex=<%=numYear-1900%>;
  	  	document.formData.SM.selectedIndex=<%=numMonth-1%>;
             </script>
          </td>
        </tr>
        <tr height="30" align="center" class="line-odd">
          <td width=14%>日</td>
          <td width=14%>一</td>
          <td width=14%>二</td>
          <td width=14%>三</td>
          <td width=14%>四</td>
          <td width=14%>五</td>
          <td width=14%>六</td>
        </tr>
	<tr  align="center" height="30" class="line-even">
	<%
	//绘制日历的第一行
	for(int i=0;i<firstDay_of_week;i++)
	{
        	out.println("<td>&nbsp;</td>");
	}
        int date = 1;
	for(int i=firstDay_of_week;i<7;i++)
	{
            String cDay = numYear+"-"+numMonth+"-"+date;
            if(holidays.indexOf(","+cDay+",")>=0)
            {
		out.println("<td bgcolor=#BDCED5 class=groove-table><a href='SetDay.jsp?strDate="+cDay+"' title='"+HD_remarks[date]+"'><font color=red>"+date+"</font></a></td>");
            }
            else if(workDays.indexOf(","+cDay+",")>=0)
            {
		out.println("<td bgcolor=#ffcc33 class=groove-table><a href='SetDay.jsp?strDate="+cDay+"' title='"+HD_remarks[date]+"'><font color=blue>"+date+"</font></a></td>");
            }
            else
            {
            	if(initHoliday.indexOf(","+Integer.toString(i)+",")>=0)
		{
		    out.println("<td><a href='SetDay.jsp?strDate="+cDay+"'><font color=red>"+date+"</font></a></td>");
            	}
		else
		{
                    out.println("<td><a href='SetDay.jsp?strDate="+cDay+"'>"+date+"</a></td>");
		}
            }
	    date++;
	}
	//绘制日历的主体
	while(date<=dayCount)
	{
            for(int i=0;i<7&&date<=dayCount;i++)
	    {
		String cDay = numYear+"-"+numMonth+"-"+date;
		if(i==0)
                   out.println("<tr align='center'height='30' class='line-even'>");
		if(holidays.indexOf(","+cDay+",")>=0)
            	{
                   out.println("<td bgcolor=#BDCED5 class=groove-table><a href='SetDay.jsp?strDate="+cDay+"' title='"+HD_remarks[date]+"'><font color=red>"+date+"</font></a></td>");
            	}
            	else if(workDays.indexOf(","+cDay+",")>=0)
            	{
		    out.println("<td bgcolor=#ffcc33 class=groove-table><a href='SetDay.jsp?strDate="+cDay+"' title='"+HD_remarks[date]+"'><font color=blue>"+date+"</font></a></td>");
            	}
            	else
            	{
            	    if(initHoliday.indexOf(","+Integer.toString(i)+",")>=0)
		    {
		    	out.println("<td><a href='SetDay.jsp?strDate="+cDay+"'><font color=red>"+date+"</font></a></td>");
            	    }
                    else
		    {
                     	out.println("<td><a href='SetDay.jsp?strDate="+cDay+"'>"+date+"</a></td>");
                    }
            	}
		if(i==6)
                   out.println("</tr>");
                date++;
	    }
	}
        //把不满一行的空缺补齐
	for(int i=lastDay_of_week;i<6;i++)
	{
     out.println("<td>&nbsp;</td>");
	}
	//
	if(lastDay_of_week!=6)
		out.println("</tr>");
	%>
	</table><!-- end of out set table-->
	<input type="hidden" name="currDate" value="<%=currDate%>">
 	<input type="hidden" name="fromMonth" value="1">
</form>
</table><!--end of main-table  -->
<!--    列表结束    -->
                    </td>
                </tr>
                <tr class="bttn" align="center">
                    <td width="100%">&nbsp;
                    </td>
                </tr>
            </table>
            <!--    列表结束    -->
        </td>
    </tr>
</table>
</body>
</html>
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