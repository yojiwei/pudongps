<%@page contentType="text/html; charset=GBK"%>
<%
String strTitle = "新闻查询";
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
</script>

<%
/*得到当前登陆的用户id  开始*/

CDataCn dCn=null;   //新建数据库连接对象
CDataImpl dImpl=null;  //新建数据接口对象

try {
 dCn = new CDataCn(); 
 dImpl = new CDataImpl(dCn); 
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

dImpl.closeStmt();
dCn.closeCn();
%>

<table class="main-table" width="100%">
<script LANGUAGE="javascript" src="./common/common.js"></script>
<form name="formData" method="post" action="djwInfocount.jsp"  target="">
<INPUT TYPE="hidden" name="subjectCode" value="<%=subjectCode%>">
 <tr class="title1" align=center>
      <td>查询</td>
    </tr>
  <tr>
     <td width="100%">

         <table width="100%" class="content-table" height="1">
          <!--tr class="line-even" >
            <td width="19%" align="right">主题：</td>
            <td width="81%" align="left"><input type="text" class="text-line" size="50" name="CT_title" maxlength="150"   >
            </td>
          </tr>        

          <tr class="line-even">
            <td  align="right">发布时间：</td>
            <td align="left">
              开始时间:<input type="date" size=13 name="start_date" onclick="javascript:showCal()" class=text-line style="cursor:hand" readonly >
              &nbsp;-&nbsp;
              结束时间:<input type="date" size=13 name="end_date" onclick="javascript:showCal()" class=text-line style="cursor:hand" readonly >
             </td>

          </tr-->
		  
          <tr class="line-even">
               <td width="19%" nowrap align="right">所属栏目：</td>
               <td width="81%" nowrap align='left'>
                                   <input type="hidden" name="sjId" class="text-line" style="cursor:hand" value="" />
                                    <input type="hidden" name="sjName" class="text-line"  readonly="true" size="40" value="" />
         <input type="text" size=40 name="Module" class="text-line" treeType="Subject" value="" treeTitle="选择所属栏目" readonly isSupportMultiSelect=0 isSupportFile=0 onclick="chooseTree('Module');formData.Module.value=formData.Module.value.replace(/\x02/ig,',');">
         <input type=button title="选择所属栏目" onclick="chooseTree('Module');formData.Module.value=formData.Module.value.replace(/\x02/ig,',');" class="bttn" value=选择...>
         <input type="hidden" name="ModuleDirIds" value="">
         <input type="hidden" name="ModuleFileIds" value>
         <input type="hidden" name="ft_parent_id" value="">
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


<%@ include file="../skin/bottom.jsp"%>
<%


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
