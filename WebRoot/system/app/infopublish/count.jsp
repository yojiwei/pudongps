<%@page contentType="text/html; charset=GBK"%>
<%
String strTitle = "新闻查询";
%>
<%@ include file="../skin/head.jsp"%>
<%
String subjectCode="";//获得栏目代码
subjectCode=CTools.dealString(request.getParameter("subjectCode")).trim();
%>
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
/*得到当前登陆的用户id  开始*/

String uiid="";
CMySelf myProject = (CMySelf)session.getAttribute("mySelf");
  if(myProject!=null && myProject.isLogin())
  {
    uiid = Long.toString(myProject.getMyID());
  }
  else
  {
    uiid= "2";
  }



%>

<table class="main-table" width="100%">

<form name="formData" method="post" action="countList.jsp"  target="">
<INPUT TYPE="hidden" name="subjectCode" value="<%=subjectCode%>">
 <tr class="title1" align=center>
      <td>查询界面</td>
    </tr>
  <tr>
     <td width="100%">

         <table width="100%" class="content-table" height="1">          
          <tr class="line-even">
            <td  align="right">发布时间：</td>
            <td align="left" >
              开始时间:<input type="date" size=13 name="start_date" onclick="javascript:showCal()" class=text-line style="cursor:hand" readonly >
              &nbsp;-&nbsp;
              结束时间:<input type="date" size=13 name="end_date" onclick="javascript:showCal()" class=text-line style="cursor:hand" readonly >
             </td>

          </tr>
        </table>
     </td>
   </tr>

   <tr class="title1" align="center">
       <td colspan="2">
<input type="submit" class="bttn" name="fsubmit" value="查 询" >&nbsp;
<input type="reset" class="bttn" name="fsubmit" value="重 写">&nbsp;
<input type="button" class="bttn" name="back" value="返 回" onclick="history.back();">
 </td>
   </tr>

</form>
</table>
<%@ include file="/system/app/skin/bottom.jsp"%>


