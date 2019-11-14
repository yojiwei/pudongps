<%@page contentType="text/html; charset=GBK"%>
<%String strTitle="下载服务" ;%>
<%@include file="../skin/head.jsp"%>
<%
String sql="";//查询条件
String OPType="";//操作方式 Add是添加 Edit是修改
String strId="";//编号
String strTitle1="";//主体
String strKeywords="";//关键字
String strPF="";//发布标记
String strCT="";//发布时间
String strDesc="";//描述
String sj_id="";//所属栏目
String strDirectory_name="";//目录名
String strFile_name="";//文件名
String strFile_size="";//文件大小
String s="";


//update20080122

CDataCn dCn=null;   //新建数据库连接对象
CDataImpl dImpl=null;  //新建数据接口对象

try {
 dCn = new CDataCn(); 
 dImpl = new CDataImpl(dCn); 

OPType=CTools.dealString(request.getParameter("OP")).trim();//得到操作方式
strId=CTools.dealString(request.getParameter("strId")).trim();//得到编号
sj_id=CTools.dealString(request.getParameter("SJ_id")).trim();//得到编号



if (OPType.equals("Edit"))
{
sql="select * from tb_download where dl_id=" + strId;
Hashtable content=dImpl.getDataInfo(sql);
strTitle1=content.get("dl_title").toString() ;
strKeywords=content.get("dl_keywords").toString() ;
strPF=content.get("dl_publish_flag").toString() ;
strCT=content.get("dl_create_time").toString() ;
strDesc=content.get("dl_desc").toString() ;
strDirectory_name=content.get("dl_directory_name").toString() ;
strFile_name=content.get("dl_file_name").toString() ;
strFile_size=content.get("dl_file_size").toString() ;
strId=content.get("dl_id").toString();

}
CSubjectList jdo = new CSubjectList(dCn);
s = jdo.getListByCode("download",sj_id);

dImpl.closeStmt();
dCn.closeCn();
%>


<table class="main-table" width="100%">
<form name="formData" method="post" action="downloadResult.jsp"  >

 <tr class="title1" align=center>
      <td>下载服务</td>
    </tr>
  <tr>
     <td width="100%">

         <table width="100%" class="content-table" height="1">
          <tr class="line-even" >
            <td width="19%" align="right">主题：</td>
            <td width="81%" ><input type="text" class="text-line" size="45" name="DL_title" maxlength="150"  value="<%=strTitle1%>" >
            </td>
          </tr>
          <tr class="line-odd">
            <td width="19%" align="right" >关键字：</td>
            <td width="81%" ><input type="text" class="text-line" size="45" name="DL_keywords" maxlength="150" value="<%=strKeywords%>"  >
            </td>
          </tr>

          <tr class="line-even">
            <td  align="right">发布：</td>
            <td ><input type="checkbox" name="DL_publish_flag" value="1" class="checkbox1" <%if (strPF.equals("1")) {%> checked <%}%>></td>
          </tr>

          <tr class="line-odd">
            <td  align="right">发布时间：</td>
            <td ><input type="date" size=13 name="DL_create_time" onclick="javascript:showCal()" class=text-line style="cursor:hand" readonly value="<%=strCT%>"></td>
          </tr>


          <tr class="line-even">
            <td width="19%"  align="right">所属栏目：</td>
            <td width="81%" ><%=s%></td>
          </tr>
          <tr class="line-odd">
            <td  align="right">描述：</td>
            <td ><textarea class="text-area" rows="3" name="DL_desc" cols="48"><%=strDesc%></textarea></td>
          </tr>
          <tr class="line-even">
            <td height="1" colspan="4"> </td>
          </tr>

        </table>
     </td>
   </tr>
   <input type="hidden" name="DL_directory_name" value="<%=strDirectory_name%>">
   <input type="hidden" name="DL_file_name" value="<%=strFile_name%>">
   <input type="hidden" name="DL_file_size" value="<%=strFile_size%>">
   <input type="hidden" name="DL_id" value="<%=strId%>">
   <input type="hidden" name="ActionType" value="">

   <tr><td>§<a onclick="javascript:openWindow()" style="cursor:hand">上传附件</a>§ </td></tr>
   <tr>
				<td class="row" id="TdInfo1">
					<hr style='border-top-style: dotted; border-top-width: 1; border-bottom-style: dotted; border-bottom-width: 1' dotted; border-top-width: 1; border-bottom-style: dotted; border-bottom-width: 1 size=0 noshade color=#000000>
				</td>
			</tr>
   <tr class="title1" align="center">
       <td colspan="2">
<%
        if (OPType.equals("Add"))
        {
%>
			<input type="button" class="bttn" name="fsubmit" value="发 布" onclick="javascript:checkform1()">&nbsp;
			<input type="reset" class="bttn" name="reset" value="重 写">&nbsp;
			<input type="button" class="bttn" name="back" value="返 回" onclick="history.back();">
			<INPUT TYPE="hidden" name="OPType" value="Add">
<%
        }
        else
        {
%>
			<input type="button" class="bttn" name="fsubmit" value="修 改" onclick="javascript:checkform1()">&nbsp;
			<input type="button" class="bttn" name="del" value="删 除" onclick="javascript:del1()">&nbsp;
			<input type="button" class="bttn" name="back" value="返 回" onclick="history.back();">
			<INPUT TYPE="hidden" name="OPType" value="Edit">
<%
        }
%>
       </td>
   </tr>

</form>
</table>

<%@include file="../skin/bottom.jsp"%>

<script LANGUAGE="javascript">
function openWindow()
{

	var w = 400 ;
	var h = 500;
	var url = "attachInfo.jsp";
	var DL_directory_name = document.formData.DL_directory_name.value;
	var DL_file_name = document.formData.DL_file_name.value;
	var DL_file_size = document.formData.DL_file_size.value;
	var strId=document.formData.DL_id.value;
	url = url + "?strId=" + strId + "&DL_directory_name="+ DL_directory_name+"&DL_file_name="+DL_file_name+"&DL_file_size="+DL_file_size;
	//window.showModalDialog( url, this, "dialogTop=0px; dialogLeft=0px; dialogWidth="+w+"px; dialogHeight="+h+"px; help=no; status=no; scroll=no; resizable=yes; " );
	window.open( url, "upload", "Top=0px,Left=0px,Width="+w+"px, Height="+h+"px,toolbar=no,location=no,derectories=no,status=no,menubar=no,scrollbars=yes" );
}

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

function checkform1()
{
	var form = document.formData ;

	if	 (form.DL_title.value =="")
	{
		alert("请填写主题!");
		form.DL_title.focus();
		return false;
	}
	if	 (form.DL_create_time.value =="")
	{
		alert("请填写发布时间!");
		form.DL_create_time.focus();
		return false;
	}

	if	 (form.sj_id.value =="")
	{
		alert("请选择栏目!");
		form.sj_id.focus();
		return false;
	}
	form.submit();
}
function del1()
{
    document.formData.ActionType.value = "1";
    document.formData.submit();
}

</script>

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
