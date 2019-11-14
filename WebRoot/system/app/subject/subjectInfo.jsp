<%@page contentType="text/html; charset=GBK"%>
<%String strTitle="栏目新增" ;%>
<%@include file="../../manage/head.jsp"%>
<%@ page import="com.beyondbit.web.publishinfo.Messages" %>
<html>

<link href="../style.css" rel="stylesheet" type="text/css">
<body style="overflow-x:hidden;overflow-y:auto">

<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title>上海浦东门户网站后台管理系统</title>
<style type="text/css">
<!--
@import url("/system/app/skin/skin3/images/main.css");
-->
</style>
<link href="/system/app/skin/skin3/images/style.css" rel="stylesheet" type="text/css">
<script LANGUAGE="javascript" src="/system/common/treeview/chooseTreeJs.jsp"></script>
<%
String strId="";
String SJ_name="";
String SJ_dir="";
String SJ_url="";
String SJ_isPublic="0";
String SJ_counseling_flag="";
String SJ_desc="";
//String SJ_id="";
String OPType="";
String sql="";
String strSelect="";//所属栏目
String sj_id="0";//栏目id
String IsStatic="";
String NeedAudit="0",SJ_SHNames="",SJ_SHIds="",NeedShenHe="0";//需要审核
String SJ_display_flag="0"; //前台显示
String sj_kind="";		//栏目类别
String ur_id = "";
String sj_modelid = "";
String sj_acdid = "";
String filePath = "";
String sj_copytoid_name = "";//同时发布到的name 2007/10/24
String sj_copytoid = "";//同时发布到原有的ID 2007/10/24
////////////
OPType=CTools.dealString(request.getParameter("OP")).trim();//得到操作方式
strId=CTools.dealString(request.getParameter("strId")).trim();//得到编号
sj_id=CTools.dealNumber(request.getParameter("sj_id")).trim();
IsStatic=CTools.dealString(request.getParameter("IsStatic")).trim();
//update20080122

CDataCn dCn=null;   //新建数据库连接对象
CDataImpl dImpl=null;  //新建数据接口对象

try {
 dCn = new CDataCn(); 
 dImpl = new CDataImpl(dCn); 


CRoleAccess ado=new CRoleAccess(dCn);
CMySelf self = (CMySelf)session.getAttribute("mySelf");
String user_id = String.valueOf(self.getMyID());

if (OPType.equals("Edit"))
{	
	strTitle="栏目管理";
	sql="select * from tb_subject where sj_id=" + strId;

	Hashtable content=dImpl.getDataInfo(sql);
	SJ_name=content.get("sj_name").toString() ;
	SJ_dir=content.get("sj_dir").toString() ;
	SJ_url=content.get("sj_url").toString() ;
	sj_copytoid=content.get("sj_copytoid").toString() ;//同时发布的ID 2007/10/24
	SJ_counseling_flag=content.get("sj_counseling_flag").toString();
	SJ_desc=content.get("sj_desc").toString();
	sj_id=content.get("sj_parentid").toString();//得到parentid
	NeedAudit=content.get("sj_need_audit").toString();//得到是否需要审核
	SJ_display_flag=content.get("sj_display_flag").toString(); //得到前台显示的标志
	sj_kind=content.get("sj_kind").toString();
	ur_id = content.get("ur_id").toString();
	sj_modelid = content.get("sj_modelid").toString();
        sj_acdid = content.get("sj_acdid").toString();
        SJ_SHIds = content.get("sj_shids").toString();
	SJ_SHNames = CTools.dealNull(content.get("sj_shnames").toString());
	SJ_isPublic=CTools.dealNull( content.get("sj_ispublic"),"0");
	filePath = content.get("sj_im_path").toString();

	if(!sj_copytoid.equals(""))
	{
		sj_copytoid = sj_copytoid.substring(1,sj_copytoid.length()-1); //去掉前后的逗号

	String sj_copytoid_split [] = sj_copytoid.split(",");
	 for(int s=0; s<sj_copytoid_split.length;s++)
	{
		String sj_copytoid_a = sj_copytoid_split[s];

		sql="select sj_name from tb_subject where sj_id="+sj_copytoid_a;
		content=dImpl.getDataInfo(sql);
		if(content!=null) sj_copytoid_name = sj_copytoid_name + content.get("sj_name").toString() +"," ;

	}
	// out.print(sj_copytoid_name +"====="+ sj_copytoid);if(true)return;

	}


}

NeedShenHe=(SJ_SHNames.equals(""))?"0":"1";
/*生成栏目列表  开始*/
CSubjectList jdo = new CSubjectList(dCn);
//strSelect = jdo.getListByCode("root",sj_id);
/*生成栏目列表  结束*/

sql="select sj_name from tb_subject where sj_id=" + sj_id;
Hashtable content=dImpl.getDataInfo(sql);
String Module_name=CTools.dealNull(content.get("sj_name"));
String Module_id1   = "";
String Module_name1 = "";
String Module_dir   = "";

if(!sj_acdid.equals("")) {
	sql="select sj_name,sj_id,sj_dir from tb_subject where sj_id='" + sj_acdid + "'";
//	out.println(sql);
    content=dImpl.getDataInfo(sql);
	if(content!=null) {
		Module_name1 = CTools.dealNull(content.get("sj_name"));
		Module_id1   = CTools.dealNull(content.get("sj_id"));
		Module_dir   = CTools.dealNull(content.get("sj_dir"));
	}
}



//生成用户分类列表

CTreeList tree = new CMetaList(dCn);
tree.setOnchange(false);
long listid=tree.getIdByCode("userkind");
//String list = tree.getMultiListByCurID(CTree.LISTID,listid,""+sj_kind+"","sj_kind");
String list = tree.getMultiListByCurID(CTree.LISTID,listid,""+sj_kind+"","sj_kind",CTree.CHECKBOX);


//////////////
%>
<script LANGUAGE="javascript">
<!--

function check()
{
	//window.open("http://localhost:8090/system/app/subject/test.jsp?OPType=Edit&sj_id=24871&sjDir=weeklyEconomy");
	var form = document.formData ;
	if	 (form.SJ_name.value =="")
	{
		alert("请填写栏目名称！");
		form.SJ_name.focus();
		return false;
        }

        if(typeof(form.ModuleDirIds)!="undefined") form.sj_id.value=form.ModuleDirIds.value;
        if	 (form.sj_id.value =="")
        {
          alert("请设定上级栏目！");
          return false;
        }

	if	 (form.SJ_dir.value =="")
	{
		alert("请填写栏目权限代码！");
		form.SJ_dir.focus();
		return false;
	}
	else{

		var objxmlPending =	objxmlPending=new ActiveXObject("Microsoft.XMLDOM");
		var dirv = form.SJ_dir.value;
		strA = "abc"
		//alert("http://192.168.6.54:9088/system/app/subject/test.jsp?OPType=<%=OPType%>&sj_id=<%=strId%>&sjDir=" + dirv );
		//objhttpPending.Open("post","<%=Messages.getString("xmlHttp")%>/system/app/subject/test.jsp?OPType=<%=OPType%>&sj_id=<%=strId%>&sjDir=" + dirv ,true);
		objhttpPending.Open("post","/system/app/subject/test.jsp?OPType=<%=OPType%>&sj_id=<%=strId%>&sjDir=" + dirv ,true);
		objhttpPending.setRequestHeader("Content-Length",strA.length);
		objhttpPending.setRequestHeader("CONTENT-TYPE","application/x-www-form-urlencoded");



		objhttpPending.onreadystatechange = function (){
			var statePending = objhttpPending.readyState;
		    if (statePending == 4)
		    {
		    	var returnvalue = objhttpPending.responsetext;
		    	//alert("&&" + returnvalue + "&&"));
		    	//alert(returnvalue);
		    	//alert(returnvalue.indexOf("1"));
		    	if(returnvalue.indexOf("{no}")!=-1){
		    		alert("2该权限代码已存在，请重新输入！");
		    		form.SJ_dir.focus();
		    		return false;

		    	}
		    	else{
		    		if(form.sj_acdstatus.checked) {
						if(form.ModuleacdDirIds.value =="")
						{
						  alert("请设定对应栏目！");
						  return false;
						}
						if(form.sj_codeacd.value == '') {
							alert("请填写栏目代码！");
							form.sj_codeacd.focus();
							return false;
						} else if(form.sj_codeacd.value == form.SJ_dir.value) {
						alert("栏目代码已存在，请重新输入！");
						form.sj_codeacd.focus();
						return false;
						}
					}

					//专题报道
					if (form.Module.value == "专题") {
						var boolZTBD = false;
						var rdZTBD;
						if(document.all.ztModel.style.display=='')
						{
						for (var i = 0;i < 5;i++) {
							if (form.rdZTBD[i].checked) {
								boolZTBD = true;
								rdZTBD = form.rdZTBD[i].value;
								break;
							}
						}
						if (boolZTBD == false) {
							form.SJ_url.value = "special_word.jsp";
						}
					 	else {
					 	    form.SJ_url.value = rdZTBD;
					 	}
						}
					}

					GetDatademo();
				if(form.sj_copystatus[0].checked) form.ModulecopytoDirIds.value="";
					form.submit();
		    	}
			}
		};

		objhttpPending.Send(strA);


	}

}

var objhttpPending=new ActiveXObject("Msxml2.XMLHTTP");

function getRunPending()
{
	var statePending = objhttpPending.readyState;
    if (statePending == 4)
    {
    	var returnvalue = objhttpPending.responsetext;
    	//alert("&&" + returnvalue + "&&"));

    	if(returnvalue.indexOf("1")!=-1){
    		alert("1该权限代码已存在，请重新输入！");
    		form.SJ_dir.focus();
    	}
	}
}


function GetDatademo()
{
var re = "/<"+"script.*.script"+">/ig"
//var re2 = /(http|https|ftp):(\/\/|\\\\)((\w)+){1,}:*[0-9]*(\/|\\){1}/ig;
var re2 = /(src=\")(http|https|ftp):(\/\/|\\\\)(.[^\/|\\]*)(\/|\\)/ig;
var Html=demo.getHTML();
Html = Html.replace(re,"");
//Html = Html.replace(re2,"/");
Html = Html.replace(re2,"src=\"/");
formData.SJ_desc.value=Html;

}
function setHtml()
{
	demo.setHTML (formData.SJ_desc.value);
	//alert(formData.CT_content.value);
}
function onChange()
{}
//-->
</script>
<script language="javascript" for=window event=onload>
setHtml();
</script>

<div align="center">
<form action="subjectResult.jsp" method="post" name="formData" enctype="multipart/form-data">
<table WIDTH="100%" CELLPADDING="0" BORDER="0" class="main-table">
<INPUT TYPE="hidden" name="strId" value="<%=strId%>">
<input type="hidden" name="filePath" value="<%=filePath%>">
   <tr>
        <td width="100%" align="left" valign="top">

	  	<table class="content-table" height="1" width="100%">
            <tr class="title1">
              <td align="center" colspan=2><%=strTitle %> </td>
            </tr>
            <tr class="line-odd">
              <td width="18%" align="right">名称：</td>
              <td width="82%"><input class="text-line" name="SJ_name"  size="20" value="<%=SJ_name %>"  maxlength="50" <%
              if (IsStatic.equals("true"))
                out.print("readonly");
              %>>&nbsp;<font color="red">*</font></td>
            </tr>
            <tr class="line-even">
              <td width="18%" align="right">上级栏目：</td>
              <td width="82%"><INPUT TYPE='hidden' name='sj_id' value= '<%=sj_id%>' >
                  <%
              if (IsStatic.equals("true"))
                out.print("锁定");
              else
              {
              %>
         <input type="text" name="Module" class="text-line" treeType="Subject" value="<%=Module_name%>" treeTitle="选择上级栏目" readonly isSupportFile="0" onClick="chooseTree('Module');">
         <input type=button  title="选择上级栏目" onClick="chooseTree('Module');" class="bttn" value=选择...>
         <input type="hidden" name="ModuleDirIds" value="<%=sj_id%>">
         <input type="hidden" name="ModuleFileIds" value>
         <input type="hidden" name="ft_parent_id" value="<%=sj_id%>">
<%
              }
              %></td>
            </tr>

            <!--tr class="line-odd">
              <td width="18%" align="right">选择模板：</td>
              <td width="82%">
              	  <select name="sj_modelid" >
              	  		<option value="0">无</option>
						<%
							sql = "select template_id,template_name from tb_templates";
							Vector vectModel = dImpl.splitPage(sql,request,100);
							if(vectModel!=null){
								for(int i=0;i<vectModel.size();i++){
									Hashtable conModel = (Hashtable)vectModel.get(i);
						%>
									<option value="<%=conModel.get("template_id")%>" <%if(sj_modelid.equals(conModel.get("template_id").toString())) out.println("selected");%>><%=conModel.get("template_name")%></option>
						<%
								}
							}
						%>
              	  </select>
              </td>
            </tr-->

            <tr class="line-even">
              <td width="18%" align="right">URL：</td>
              <td width="82%"><input  type="text" class="text-line" name="SJ_url" size="50" maxlength="200"  value="<%=SJ_url%>"
              >
              </td>
            </tr>
			 <tr class="line-even">
              <td width="18%" align="right">栏目对应：</td>
              <td width="82%">
			  <INPUT TYPE='radio' name='sj_acdstatus' value="0" <%if(sj_acdid.equals("")) out.println("checked");%>  onclick="document.all.createSub.style.display='none';document.all.gotoSub.style.display='none'">无&nbsp;&nbsp;
			  <INPUT TYPE='radio' name='sj_acdstatus' value="1" onClick="document.all.createSub.style.display='';document.all.gotoSub.style.display='none'">创建到&nbsp;&nbsp;
			  <input type="radio" name='sj_acdstatus' value='2' <%if(!sj_acdid.equals("")) out.println("checked");%> onClick="document.all.createSub.style.display='none';document.all.gotoSub.style.display=''">对应到
			  <div id="createSub" style="display:none"><input type="text" name="Moduleacd" size="15" class="text-line" treeType="Subject" value="" treeTitle="选择上级栏目" readonly isSupportFile="0" onClick="chooseTree('Moduleacd');">
			 <input type=button  title="选择上级栏目" onClick="chooseTree('Moduleacd');" class="bttn" value=选择...>
			 <input type="hidden" name="ModuleacdDirIds" value="">
			 <input type="hidden" name="ModuleacdFileIds" value>
			 栏目代码：<input type="text" name="sj_codeacd" value="" size="10" ></div>

			 <div id="gotoSub" style="display:none">
			 <input type="text" name="Moduleextid" size="15" class="text-line" treeType="Subject" value="<%=Module_name1%>" treeTitle="选择栏目" readonly isSupportFile="0" onClick="chooseTree('Moduleacd');">
			 <input type=button  title="选择栏目" onClick="chooseTree('Moduleextid');" class="bttn" value=选择...>
			 <input type="hidden" name="ModuleextidDirIds" value="<%=Module_id1%>">
			 <input type="hidden" name="ModuleextidFileIds" value>
			 </div>

			  <INPUT TYPE='hidden' name='sj_acdid' value= '<%=sj_acdid%>' >

			 <%
				if(!sj_acdid.equals(""))  out.println("<script language='javascript'>document.all.gotoSub.style.display=''</script>");
			 %>
			</td>
            </tr>
			<!--同时发布到代码开始-->
			  <tr class="line-even">
              <td width="18%" align="right">同时发布到：</td>
              <td width="82%">
			  <INPUT TYPE='radio' name='sj_copystatus' value="0" <%if(sj_copytoid.equals("")) out.println("checked");%>  onclick="document.all.createSub_copy.style.display='none';">无&nbsp;&nbsp;
			  <input type="radio" name='sj_copystatus' value="1" <%if(!sj_copytoid.equals("")) out.println("checked");%> onClick="document.all.createSub_copy.style.display='';">同时发布到			  
			  <div id="createSub_copy" <%if(sj_copytoid.equals("")) out.println("style='display:none'"); %>>
			  
			  <input type="text" size=40 name="Modulecopyto" class="text-line" treeType="Subject" value="<%=sj_copytoid_name%>" treeTitle="选择同时发布栏目" readonly isSupportMultiSelect="1" isSupportFile="0" onClick="chooseTree('Modulecopyto');formData.Modulecopyto.value=formData.Modulecopyto.value.replace(/\x02/ig,',');">
         <input type="button"  title="选择同时发布栏目" onClick="chooseTree('Modulecopyto');formData.Modulecopyto.value=formData.Modulecopyto.value.replace(/\x02/ig,',');" class="bttn" value=选择...>
         <input type="hidden" name="ModulecopytoDirIds" value="<%=sj_copytoid%>">         
           <input type="hidden" name="ModulecopytoFileIds" value>
			 </div>

			</td>
            </tr>

			<!--同时发布到代码结束-->

			<tr class="line-odd">
              <td width="18%" align="right">权限代码：</td>
              <td width="82%"><input <%
              if (IsStatic.equals("true"))
                out.print("readonly");
              %>  type="text" class="text-line" name="SJ_dir" size="50" maxlength="100"  value="<%=SJ_dir%>"
              >&nbsp;<font color="red">*</font>
              </td>
            </tr>


			<tr class="line-odd">
              <td width="18%" align="right">选择模板：</td>
              <td width="82%">
              	<input type="radio" name="chooseModel" id="chooseModeidl" value="1" onClick="document.all.ztModel.style.display=''" <%=!"".equals(SJ_url) && (Module_name.equals("专题") || Module_name.equals("专题报道")) ? "checked" : ""%>>
              	是&nbsp;&nbsp;
              	<input type="radio" name="chooseModel" id="chooseModeid2" value="0" <%="".equals(SJ_url) ? "checked" : ""%> onClick="document.all.ztModel.style.display='none';
              	document.all.ztModellPic.style.display='none'">
              	否
              </td>
            </tr>
            <tr class="line-odd" style="display:none" id="ztModel">
              <td width="18%" align="right">模板：</td>
              <td width="82%">
              	<table width="100%" border="0" cellpadding="0" cellspacing="0">
              	  <tr>
              	  	<td>
		              	<input type="radio" name="rdZTBD" value="special_word.jsp" 
		              		<%=SJ_url.equals("special_word.jsp") ? "checked" : ""%>
		              	 	onClick="document.all.ztModellPic.style.display='none'">
		              		<a href="\website\pudongNews\special_word.htm" target="_blank">文字模板</a>&nbsp;&nbsp;
		              	<input type="radio" name="rdZTBD" value="special_total.jsp" 
		              		<%=SJ_url.equals("special_total.jsp") ? "checked" : ""%>
		              	 	onClick="document.all.ztModellPic.style.display='none'">
		              		<a href="\website\pudongNews\special_total.htm" target="_blank">综合模板</a>&nbsp;&nbsp;
		              	<input type="radio" name="rdZTBD" value="/website/pudongNews/special_list_1.jsp"
		              	 	<%=SJ_url.equals("/website/pudongNews/special_list_1.jsp") ? "checked" : ""%>
		              	 	onClick="document.all.ztModellPic.style.display=''">
		              	<a href="\website\pudongNews\list.html" target="_blank">活动模板1</a>&nbsp;</br>
		              	<input type="radio" name="rdZTBD" value="/website/pudongNews/special_list.jsp"
		              		 <%=SJ_url.equals("/website/pudongNews/special_list.jsp") ? "checked" : ""%>
		              	 	onClick="document.all.ztModellPic.style.display=''">
		              		<a href="/website/pudongNews/special_list.jsp?sj_id=24504" target="_blank">活动模板2</a>&nbsp;
		              	<input type="radio" name="rdZTBD" value="/website/pudongNews/special_listTot.jsp"
		              		 <%=SJ_url.equals("/website/pudongNews/special_listTot.jsp") ? "checked" : ""%>
		              	 	onClick="document.all.ztModellPic.style.display=''">
		              		<a href="/website/pudongNews/special_listTot.jsp?sj_id=25700" target="_blank">活动模板3</a>&nbsp;
		              	<input type="radio" name="rdZTBD" value="/website/pudongNews/special_pic.jsp"
		              		 <%=SJ_url.equals("/website/pudongNews/special_pic.jsp") ? "checked" : ""%>
		              	 	onClick="document.all.ztModellPic.style.display=''">
		              		<a href="\website\pudongNews\pic.html" target="_blank">图片模板</a>
              		</td>
              	  </tr>
              	</table>
              </td>
            </tr>
			<tr class="line-odd" id="ztModellPic" style="display:none">
              <td width="18%" align="right">上传主题图片：</td>
              <td width="82%"><input name="ztModelPic" type="file" class="input-mailBox" size="32" />
              </td>
            </tr>

            <tr class="line-even"  <%=(ado.isAdmin(user_id)||SJ_isPublic.equals("0"))?"":"style='display:none'"%>>
              <td width="18%" align="right">是否需要审核：</td>
              <td width="82%"> <INPUT <%
              if (IsStatic.equals("true"))
                out.print("disabled");
              %> type="radio" onClick="divShenHe.style.display='';"  name="SJ_need_sh" value=1  <%if (NeedShenHe.equals("1")) {%> checked <%}%>>
                是<span id=divShenHe <%=NeedShenHe.equals("0")?"style='display:none'":""%>>
                <input type="text"
                                        name="user" value="<%=SJ_SHNames%>" treeType="Dept" treeTitle="选择审核人员" readonly onClick="chooseTree('user');"
                                        isSupportMultiSelect="1" isSupportDirSelect=0 isSupportFile="1"><input type="hidden"
                                        name="userDirIds" value> <input type="hidden" name="userFileIds"
     value="<%=SJ_SHIds%>"><input type=button  title="选择审核人员" onClick="chooseTree('user');" class="bttn" value=选择...></span>
     &nbsp;&nbsp;<INPUT <%
              if (IsStatic.equals("true"))
                out.print("disabled");
              %> type="radio" onClick="divShenHe.style.display='none';"  name="SJ_need_sh" value=0   <%if (NeedShenHe.equals("0")) {%> checked <%}%> >
                否</td>
            </tr>





            <tr class="line-even"  <%=(ado.isAdmin(user_id)||SJ_isPublic.equals("0"))?"":"style='display:none'"%>>
              <td width="18%" align="right">是否需要审批：</td>
              <td width="82%"> <INPUT <%
              if (IsStatic.equals("true"))
                out.print("disabled");
              %> type="radio"  name="SJ_need_audit" value=1  <%if (NeedAudit.equals("1")) {%> checked <%}%>>
                是&nbsp;&nbsp; <INPUT <%
              if (IsStatic.equals("true"))
                out.print("disabled");
              %> type="radio"  name="SJ_need_audit" value=0   <%if (NeedAudit.equals("0")) {%> checked <%}%> >
                否</td>
            </tr>






            <tr class="line-even" style="display:
             <%
             if(NeedAudit.equals("0"))
             {
               %>
               	none
               <%
             }
             %>
             " id="rl_user">
            <!--td width="19%"  align="right">审核人：</td>
            <td width="81%" >
                  <select name="urId">
                  	<%
                  		String sqlUR = "select substr(tr_userids,2,length(tr_userids)-2) as uiid from tb_roleinfo where tr_detail='infocheck'";
                  		Hashtable contentUR = dImpl.getDataInfo(sqlUR);

				if (contentUR != null) {
                 	 		sqlUR = "select * from tb_userinfo where ui_id in (" + contentUR.get("uiid") + ")";
//if(true)return;
                  			Vector vect1 = dImpl.splitPage(sqlUR,request,100);
                  			for(int i=0;i<vect1.size();i++) {
                  				String checkedvalue = "";
                  				Hashtable content1 = (Hashtable)vect1.get(i);
                  				if(ur_id.equals(content1.get("ui_id"))) checkedvalue = "selected";
                  				out.println("<option value='" + content1.get("ui_id") + "'" + checkedvalue + ">" + content1.get("ui_name") + "</option>");
                  			}
				}
				else {
					out.println("<option value=''>暂时没有审核人</option>");
				}
                  	%>
                  </select>
            </td-->
          </tr>

			<tr class="line-odd">
              <td width="18%" align="right">是否前台显示：</td>
              <td width="82%"> <INPUT <%
              if (IsStatic.equals("true"))
                out.print("disabled");
              %> type="radio"  name="SJ_display_flag" value=0  <%if (SJ_display_flag.equals("0")) {%> checked <%}%>>
                是&nbsp;&nbsp; <INPUT <%
              if (IsStatic.equals("true"))
                out.print("disabled");
              %> type="radio"  name="SJ_display_flag" value=1  <%if (SJ_display_flag.equals("1")) {%> checked <%}%> >
                否</td>
            </tr>

			<tr class="line-event" <%=ado.isAdmin(user_id)?"":"style='display:none'"%>>
              <td nowrap align="right">是否为公共栏目：</td>
              <td width="82%"> <INPUT <%
              if (IsStatic.equals("true"))
                out.print("disabled");
              %> type="radio"  name="SJ_ispublic_flag" value=1  <%if (SJ_isPublic.equals("1")) {%> checked <%}%>>
                是&nbsp;&nbsp; <INPUT <%
              if (IsStatic.equals("true"))
                out.print("disabled");
              %> type="radio"  name="SJ_ispublic_flag" value=0  <%if (SJ_isPublic.equals("0")) {%> checked <%}%> >
                否</td>
            </tr>
            <tr class="line-odd">
              <td width="18%" align="right">描述：</td>
              <td width="82%">
							<iframe id="demo" style="HEIGHT: 230px; TOP: 5px; WIDTH: 100%" src="/system/common/editor/editor.htm"></iframe>
              <input type="hidden" id="SJ_desc" name="SJ_desc" value="<%=CTools.htmlEncode(SJ_desc) %>">
							</td>
            </tr>
          </table>
        </td>
      </tr>

		<tr class=title1>
		  <td width="100%" align="center" colspan="2">


<%
				if (OPType.equals("Add"))
				{
%>
            <input class="bttn" value="提交" type="button" onClick="javascript:check()" size="6" id="button2" name="button2">&nbsp;
					<input class="bttn" value="返回" type="button"  size="6" id="button3" name="button3" onClick="javascript:history.go(-1)">
					<INPUT TYPE="hidden" name="OPType" value="Add">
<%
				}
				else
				{
%>
		  			<input class="bttn" value="修改" type="button" onClick="javascript:check()" size="6" id="button4" name="button4">&nbsp;
            <%if (!IsStatic.equals("true")){%>
		  			<input  class="bttn" value="删除" type="button" onClick="javascript:del(<%=strId+","+sj_id%>)" size="6" id="button4" name="button4">&nbsp;
		  			<%}else if (IsStatic.equals("true")){%>
            <INPUT TYPE="hidden" name="IsStatic" value="true">
            <%}%>
            <input class="bttn" value="返回" type="button"  size="6" id="button5" name="button5" onClick="javascript:history.go(-1)">&nbsp;
					<INPUT TYPE="hidden" name="OPType" value="Edit">

<%
				}
%>
        </td>
		</tr>
    </table>
	</form>
</div>

<SCRIPT LANGUAGE=javascript>
<!--

function del(strId,sj_id)
{
	//alert("haha");
var url="subjectDel.jsp?strId="+strId+"&sj_id="+sj_id;
//alert(url);
if (confirm("确定要删除该纪录吗？"))
	{
		window.location=url;
	}
}
//当选择模板是的时候，同时展开模板一层
if (document.all.chooseModel[0].checked) 
	document.all.chooseModeidl.click();
else 
	document.all.chooseModel[1].checked

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
<%@include file="../skin/bottom.jsp"%>