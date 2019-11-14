<%@page contentType="text/html; charset=GBK"%>
<%
String strTitle = "短信发送查询";
%>
<%@ include file="../skin/head.jsp"%>
<%
String subjectCode="";//获得栏目代码
subjectCode=CTools.dealString(request.getParameter("subjectCode")).trim();
%>
<script LANGUAGE="javascript" src="/system/common/treeview/chooseTreeJs.jsp"></script>
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
 function checkDate(){

        if(formData.start_date.value!=""&&formData.end_date.value!=""){
	if(formData.start_date.value>formData.end_date.value)
	{alert("开始时间不能大于结束时间!");
	return false;}
	}
   formData.submit();
 }
</script>

<%
/*得到当前登陆的用户id  开始*/
CDataCn dCn = new CDataCn(); //新建数据库连接对象
CDataImpl dImpl = new CDataImpl(dCn); //新建数据接口对象
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
/*得到当前登陆的用户id  结束*/
  String strSelect="";
  strSelect="<select class=select-a name='sj_id' size='1' >";
  strSelect+="<option value=0>请选择...</option>";
  String sjSql="select s.*,f.sj_name f_name,f.sj_id f_id from tb_subject s,tb_subject f where s.sj_parentid = f.sj_id and s.sj_id in(select sj_id from tb_subjectrole where  tr_id in (select tr_id from tb_roleinfo where tr_userids like '%,"+uiid+",%'))";
  Vector vectorPage = dImpl.splitPage(sjSql,1000,1);
    if(vectorPage!=null)
    {
      for(int j=0;j<vectorPage.size();j++)
      {
        Hashtable contentsj = (Hashtable)vectorPage.get(j);

        String f_name="";
        if (contentsj.get("f_id").toString().equals("0"))
          f_name="首页";
        else
          f_name=contentsj.get("f_name").toString();
        strSelect = strSelect+"<option value='"+contentsj.get("sj_id").toString()+"'";

        strSelect += ">"+ f_name + "→" + contentsj.get("sj_name").toString()+"</option>";
      }
    }
  strSelect=strSelect+"</select>";

%>

<table class="main-table" width="100%">
<script LANGUAGE="javascript" src="../infopublish/common/common.js"></script>
<form name="formData" method="post" action="Statisearchlist.jsp"  target="">
<INPUT TYPE="hidden" name="subjectCode" value="<%=subjectCode%>">
 <tr class="title1" align=center>
      <td>查询</td>
    </tr>
  <tr>
     <td width="100%">

         <table width="100%" class="content-table" height="1">
          <tr class="line-even" >
            <td width="19%" align="right">发布部门：</td>
            <td width="81%" align="left">
		<select name="dt_id" style="width:160px">
                      		<option value="">选择要查询的部门</option>
                      		<%
                      		String deptSql = "";
                      		String sdt_id = "";
                      		String sdt_name = "";
                      		Vector dept_list = null;
                      		Hashtable dept_content = null;
                      		deptSql = "select dt_id,dt_name from tb_deptinfo order by dt_sequence,dt_id";
                      		dept_list = dImpl.splitPage(deptSql,500,1);
                      		if (dept_list != null) {
                      		  for (int i=0;i<dept_list.size();i++) {
                      		  dept_content = (Hashtable)dept_list.get(i);
                      		  sdt_id = dept_content.get("dt_id").toString();
                      		  sdt_name = dept_content.get("dt_name").toString();
                      		%>
                      		<option value="<%=sdt_id%>"><%=sdt_name%></option>
                      		<%
                      		  }
                      		}
                      		%>
                      	</select>
            </td>
          </tr>        

          <tr class="line-even">
            <td  align="right">发布时间：</td>
            <td align="left">
              开始时间:<input type="date" size=13 name="start_date" onclick="javascript:showCal()" class=text-line style="cursor:hand" readonly >
              &nbsp;-&nbsp;
              结束时间:<input type="date" size=13 name="end_date" onclick="javascript:showCal()" class=text-line style="cursor:hand" readonly >
             </td>

          </tr>
		  
          <tr class="line-even">
               <td width="19%" nowrap align="right">所属栏目：</td>
               <td width="81%" nowrap align='left'>
          <select name="sj_id" class=select>
		  <option value="">请选择栏目</option>
<%
String strSql="select * from tb_subject s where s.sj_parentid in(select sj_id from tb_subject b where b.sj_dir = 'xxll')";
Vector vectorPage1 = dImpl.splitPage(strSql,request,20);
  if(vectorPage1!=null)
  {
    for(int j=0;j<vectorPage1.size();j++)
    {
      Hashtable content11 = (Hashtable)vectorPage1.get(j);
	  String ri=content11.get("sj_name").toString();
	  String ni = content11.get("sj_id").toString();
%>
          <option value="<%=ni%>"><%=ri%></option>
<%
}
}

dImpl.closeStmt();
dCn.closeCn();
%>
		  </select>
               </td>
          </tr>
          <tr class="line-even">
               <td width="19%" nowrap align="right">发送情况：</td>
               <td width="81%" nowrap align='left'>
			     <input name="sm_flag" type="radio" value="1" checked="checked" />
			     成功&nbsp;&nbsp;<!--1 已经发送成功的的 2还没有发送的-->
				 <input type="radio" name="sm_flag" value="0" />失败
               </td>
          </tr>
		  
        </table>
     </td>
   </tr>

   <tr class="title1" align="center">
       <td colspan="2">
<input type="button" class="bttn" name="fsubmit" value="查 询" onclick="checkDate()">&nbsp;
<input type="reset" class="bttn" name="fsubmit" value="重 写">&nbsp;
<input type="button" class="bttn" name="back" value="返 回" onclick="history.back();">
 </td>
   </tr>

</form>
</table>


<%@ include file="../skin/bottom.jsp"%>

