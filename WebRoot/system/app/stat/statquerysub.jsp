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
<form name="errquery" action="statlist2.jsp" method="post">
<table border=0 cellspacing="1" cellpadding="0" width="100%">
<tr class="bttn"><td colspan="2">统计分析查询
</td></tr>

<tr class="line-odd"><td width="15%" align="right" >操作栏目</td>
<td width="85%">&nbsp;&nbsp;<input class="text-line" name="sub" type="text" size="21" maxlength="21"></td></tr>
<tr class="line-even"><td width="15%" align="right">操作时间</td>
<td width="85%">&nbsp; 
       <input type="date" size=13 name="start_date" onclick="javascript:showCal()" class=text-line style="cursor:hand" readonly >
              &nbsp;-&nbsp;
       <input type="date" size=13 name="end_date" onclick="javascript:showCal()" class=text-line style="cursor:hand" readonly >
</td></tr>

<tr class="bttn"><td colspan="2"><input class="bttn" type="submit" name="query" value="查询" size="6">&nbsp;<input class="bttn" type="reset" name="reset" value="清除" size="6">
</td></tr>

</table>
