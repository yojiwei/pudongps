<%@page contentType="text/html; charset=GBK"%>
<%
String strTitle = "按部门统计查询";
%>
<%@ include file="../skin/head.jsp"%>
<script language=javascript>
  function showCal(obj)
  {
      if (!obj) var obj = event.srcElement;
      var obDate;
      if ( obj.value == "" ) {
          obDate = new Date();
      } else {
          var obList = obj.value.split( "-" );
          obDate = new Date( obList[0], obList[1]-1, obList[2] );
      }

      var retVal = showModalDialog( "../../common/include/calendar.htm", obDate,
          "dialogWidth=206px; dialogHeight=206px; help=no; scroll=no; status=no; " );

      if ( typeof(retVal) != "undefined" ) {
          var year = retVal.getFullYear();
          var month = retVal.getMonth()+1;
          var day = retVal.getDate();
          obj.value =year + "-" + month + "-" + day;
      }
}
</script>

<%
 String dt_name="";
 /* 
   CDataCn dCn = new CDataCn(); //新建数据库连接对象
   CDataImpl dImpl = new CDataImpl(dCn); //新建数据接口对象
   String dt_name="";
   String sql="select dt_id,dt_name,dt_parent_id from tb_deptinfo where ((dt_parent_id<>0) and (dt_parent_id<>1))";
   Vector vectorPage = dImpl.splitPage(sql,request,50);
 */   
%>
<form name="errquery" action="statlist1.jsp" method="post">
<table border=0 cellspacing="1" cellpadding="0" width="100%">
<tr class="bttn"><td colspan="2">统计分析查询
</td></tr>

<tr class="line-odd"><td width="15%" align="right" >操作部门</td>
<td width="85%">&nbsp;&nbsp;<!--input class="text-line" name="dept" type="text" size="21" maxlength="21"-->
   <select class=select-a  name=dept>
   <option value="all">-------------------</option>
   <% /*if (vectorPage!=null)
       {   
	      for(int j=0;j<vectorPage.size();j++)
			 {
               Hashtable content = (Hashtable)vectorPage.get(j);	
			  dt_name=content.get("dt_name").toString();
	  */
    %>

              <!--option value="<%=dt_name%>"><%= dt_name%></option-->
   <%/*	         }
       }

	   modify in 2003-5-23,nq,部门规定死，共7个部门
	 */ 
  %>
    <option value="3">电子商务信息中心</option>
	<option value="25">办公室</option>
	<option value="10">南区综合处</option>
	<option value="26">社会发展处</option>
	<option value="27">经济贸易处</option>
	<option value="28">规划建设处</option>
	<option value="30">发展与改革处</option>

  </select>
  </td></tr>
<tr class="line-even"><td width="15%" align="right">操作时间</td>
<td width="85%">&nbsp; 
       <input type="date" size=13 name="start_date" onclick="javascript:showCal()" class=text-line style="cursor:hand" readonly >
              &nbsp;-&nbsp;
       <input type="date" size=13 name="end_date" onclick="javascript:showCal()" class=text-line style="cursor:hand" readonly >
</td></tr>

<tr class="bttn"><td colspan="2"><input class="bttn" type="submit" name="query" value="查询" size="6">&nbsp;<input class="bttn" type="reset" name="reset" value="清除" size="6">
</td></tr>

</table>
