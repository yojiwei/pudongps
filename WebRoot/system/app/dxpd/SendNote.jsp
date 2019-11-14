<%@page contentType="text/html; charset=GBK"%>
<%@ page import="java.sql.ResultSet"%>
<%@page import="com.website.*"%>
<%@include file="../../manage/head.jsp"%>

<script LANGUAGE="javascript" src="../infopublish/common/common.js"></script>
<script type="text/javascript" src="../infopublish/editor/fckeditor.js"></script>
<script language="javascript" src="../../../website/js/supervise.js"></script>
<script language="javascript" src="../../../website/js/common.js"></script>
<script language="javascript" src="../../../website/js/check.js"></script>

<html>
	<head>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
	    <style type="text/css">
<!--
.STYLE1 {color: #FF0000}
-->
        </style>
</head>
	<link href="/system/app/skin/skin3/images/style.css" rel="stylesheet"
		type="text/css">
	<link href="../style.css" rel="stylesheet" type="text/css">
	<title>上海浦东门户网站后台管理系统</title>
	<style type="text/css">
<!--
@import url("/system/app/skin/skin3/images/main.css");
-->
    </style>
<script LANGUAGE="javascript" src="/system/common/treeview/chooseTreeJs.js"></script>
<script language=javascript>
function checkFrm(flag)
{
  document.formData.returnPage.value=flag;
}
function showDiv(flag)
{
  var obj=document.getElementsByName('infoOpen');
  for(var i=0;i<obj.length;i++)
  {
    obj[i].style.display=flag;
  }
}

function save()
{  
    var form = document.formData ;
    form.CT_content.value=eWebEditor1.getHTML();
    if(typeof("eWebEditor1")=="undefined")
    {
		alert("编辑框内容未载入完全，请稍后提交!");
		return false;
    }
	
	if(document.formData.content1.value=="")
	{
	    alert("请输入您要发送的短信内容！");
		document.formData.content1.focus;
		return false;
	}
	else {
	    document.formData.action = "SendNoteResult.jsp?id=1";//只是保存而已！
		document.formData.submit();
	}
}
function  checkFieldLength(fieldLength)
{ 

	var str = eval("document.formData.content1.value");
	var theLen=0;
 	var teststr='';
	for (i=0;i<str.length;i++)
	{
		teststr=str.charAt(i); 
	   if(str.charCodeAt(i)>255){
	   	theLen=theLen + 1;
		}
	   else
	   {
		theLen=theLen + 1;
		}
	}
	if( theLen>fieldLength+1 )
	{
		//document.getElementById("message").innerHTML="您输入的字数已经超过了规定，超过部分将分条发送！";
		str   =   str.substring(0,63); 
		eval("document.formData.content1.focus()");
		return false;
	}
	else
	{
		document.getElementById("message").innerHTML=""+theLen+"";
		return true;
	}
}
function saveAndsend()
{
    var form = document.formData ;
    form.CT_content.value=eWebEditor1.getHTML();
    if(typeof("eWebEditor1")=="undefined")
    {
		alert("编辑框内容未载入完全，请稍后提交!");
		return false;
    }
	
	if(document.formData.content1.value=="")
	{
	    alert("请填写您要发送的短信内容！");
		document.formData.content1.focus;
		return false;
	}
	else
	{
	document.formData.action = "SendNoteResult.jsp";   //保存并发送给所订阅的用户！
	document.formData.submit();
	}

}
</script>
<SCRIPT   LANGUAGE="JavaScript">   
<!--//   
function   textCounter(field,   countfield,   maxlimit)   {   
//alert('dd');
//   定义函数，传入3个参数，分别为表单区的名字，表单域元素名，字符限制；   
if   (field.value.length   >   maxlimit){
//如果元素区字符数大于最大字符数，按照最大字符数截断；
document.getElementById("mess").innerHTML="<font color='#FF0000'>注意：您已经超出了</font>";  
document.getElementById("age").innerHTML="&nbsp;&nbsp;&nbsp;超出部分将分条收费！";    
//field.value   =   field.value.substring(0,   maxlimit);
}
else   
//在记数区文本框内显示剩余的字符数；
document.getElementById("mess").innerHTML="注意：您还可以输入";     
countfield.value   =   maxlimit   -   field.value.length;   
}
function pp(field,countfield,maxlimit){ 
var clob = "";
}
setInterval("textCounter(document.all.content1,document.all.message,51)", 1);
//-->   
</SCRIPT> 
<body style="overflow-x:hidden;overflow-y:auto">
<%
  String sendTime = new CDate().getNowTime();

  String ctTitle = "";
  String ct_IsComment = "";
  String ctKeywords = "";
  String ctUrl = "";
  String ctSource = "";
  String ctCreateTime = new CDate().getThisday();
  String ctFileFlag = "0";
  String sjId = "";
  String sjName = "";
  String ctFocusFlag = "";
  String ctInsertTime = new CDate().getThisday();
  String ctBrowseNum = "";
  String ctFeedbackFlag = "";
  String ctContent = "";
  String ctImgpath = "";
  String filePath = "";
  String sj_id = "";
  String Module_name = "";
  String tc_memo="";
  String chkIDs="";
  String checkStatus="0";
  String tcSenderId="";
  String cpCommend = "";
  String ctEndTime = "";		//开发纵横结束时间
  String subscibeid="";          //表示用户定制的标志，用户的ID
  String us_uid="";
  String us_name="";
  
  Hashtable contentSJ =null;
  Hashtable content = null;
  Hashtable contentmy = new Hashtable();
  String IN_INFOTYPE="",IN_MEDIATYPE="",IN_DESCRIPTION="",IN_CATEGORY="",IN_CATCHNUM="",IN_FILENUM="",ct_contentflag="";
  



  CMySelf mySelf = (CMySelf)session.getAttribute("mySelf");
  String ctId = CTools.dealString(request.getParameter("ct_id"));
  String OPType = CTools.dealNull(request.getParameter("OPType"),"Add");
  String goon = CTools.dealString(request.getParameter("goon"));
  CDataCn dCn = new CDataCn();
  CDataImpl dImpl = new CDataImpl(dCn);
  String urID = String.valueOf(mySelf.getMyID());
  String dtID = String.valueOf(mySelf.getDtId()); //所属部门ID
  String dtName = "";
  

  if ("1".equals(goon)) {			  //保存并继续发布
	  Module_name = CTools.dealString(request.getParameter("sjName1")).equals("") ? "" 
  												: CTools.dealString(request.getParameter("sjName1"));
	  sj_id = CTools.dealString(request.getParameter("sj_id"));
  }
  else if(ctId.equals(""))			  //新增的时候初始化栏目
  { 
    sjId = CTools.dealString(request.getParameter("sjId"));
    sjName = CTools.dealString(request.getParameter("sjName"));
    if(session.getAttribute("temppath")!=null) session.setAttribute("temppath",null);
    sj_id=CTools.dealNumber(request.getParameter("sj_id")).trim();
    if(sj_id.equals("0"))sj_id="";

    Module_name="";
    String sj_acdid = "";
    if(!sj_id.equals("0")&&!sj_id.equals("")) {
      String sql="select sj_name,sj_acdid from tb_subject where sj_id=" + sj_id;
      Hashtable content1=dImpl.getDataInfo(sql);
      if(content1!=null) {
        Module_name=CTools.dealNull(content1.get("sj_name"))+",";
        sj_acdid = CTools.dealNull(content1.get("sj_acdid"));

        if(!sj_acdid.equals("")) {
          sj_id += "," + sj_acdid;
          sql = "select sj_name,sj_acdid from tb_subject where sj_id=" + sj_acdid;
          content1=dImpl.getDataInfo(sql);
          if(content1!=null) {
            Module_name +=CTools.dealNull(content1.get("sj_name"))+",";
          }
        }

      }
    }
  }
  else
  {
    String sqlStr = "select * from tb_content,tb_contentdetail where  tb_content.ct_id=tb_contentdetail.ct_id and tb_content.ct_id='" + ctId + "'";
    content = dImpl.getDataInfo(sqlStr);
    if(content!=null)
    {
      ctTitle = CTools.htmlEncode(content.get("ct_title").toString());
      ctKeywords=content.get("ct_keywords").toString() ;
      ctUrl=content.get("ct_url").toString() ;
      ctSource=content.get("ct_source").toString() ;
      ctCreateTime=content.get("ct_create_time").toString() ;
      ctFileFlag=content.get("ct_fileflag").toString();
      sjId=content.get("sj_id").toString() ;
      sjName=content.get("sj_name").toString();
      ctFocusFlag=content.get("ct_specialflag").toString();
      ctInsertTime=CTools.dealNumber(content.get("ct_inserttime").toString());
      ctBrowseNum=CTools.dealNumber(content.get("ct_browse_num").toString());
      ctFeedbackFlag = content.get("ct_feedback_flag").toString();
      ctContent = content.get("ct_content").toString();
      filePath = content.get("ct_filepath").toString();
      ctImgpath = content.get("ct_img_path").toString();
      urID = content.get("ur_id").toString();
      dtID = content.get("dt_id").toString();
      dtName = content.get("dt_name").toString();
	  ct_IsComment = content.get("ct_iscomment").toString();
      
      IN_INFOTYPE = content.get("in_infotype").toString();
      IN_MEDIATYPE = content.get("in_mediatype").toString();
      IN_DESCRIPTION = content.get("in_description").toString();
      IN_CATEGORY = content.get("in_category").toString();
      IN_CATCHNUM = content.get("in_catchnum").toString();
      IN_FILENUM = content.get("in_filenum").toString();
      ct_contentflag = content.get("ct_contentflag").toString();
			
      if(!ctImgpath.equals("")) session.setAttribute("temppath",ctImgpath);
    }
    
	//modify for hh
	if ("".equals(urID)) urID = String.valueOf(mySelf.getMyID());
	//end modify

    //sqlStr = "select sj_id from tb_subject where sj_id in (" + sjId.substring(0,sjId.length()-1) + ") and sj_need_audit='1'";
    sqlStr = "select sj_id from tb_subject where sj_id in (" + CTools.trimEx(sjId,",") + ") and sj_need_audit='1'";

    contentSJ = dImpl.getDataInfo(sqlStr);
    if(contentSJ!=null){
      //out.print(sqlStr);
    CRoleAccess ado=new CRoleAccess(dCn);
    CMySelf self = (CMySelf)session.getAttribute("mySelf");
    String user_id = String.valueOf(self.getMyID());

    if(!ado.isAdmin(user_id))
        out.print("<script language='javascript'>alert('该信息需要审批，修改时请联系管理员！')</script>");
    }
	////////////////////////////////////////
    sj_id=sjId;
    Module_name=sjName;
    
    //如果所属栏目为开发纵横，结束时间有效
    if (Module_name.equals("开发纵横,") || Module_name.equals("浦东论坛,")) {
    	ctEndTime = ctKeywords;
    	ctKeywords = "";
    }
    //mySelf.setSJRole();
    //取得是否是特别推荐栏目
    sqlStr = "select cp_commend from tb_contentpublish where ct_id = " + ctId;// + " and sj_id in (" + sjId.substring(0,sjId.length()-1) + ")";
    ResultSet rs = dImpl.executeQuery(sqlStr);
    if (rs.next()) cpCommend = rs.getString("cp_commend");
  }
  //获取当前机构名称
  if ("".equals(dtName)) {
    String dt_sql = "select dt_name from tb_deptinfo where dt_id =" + dtID;
    Hashtable dt_content = dImpl.getDataInfo(dt_sql);
    if (dt_content != null);
    dtName = dt_content.get("dt_name").toString();
  }




%>

		<form name="formData" action="" method="post">
			<table class="main-table" width="100%">
				<tr class="title1" align=center>
					<td>
						短信信息发布
					</td>
				</tr>
				<tr>
					<td width="100%">
						<table width="100%" height="1">
							<tr class="line-even">
								<td width="19%" align="right">
									发布时间：
								</td>
								<td width="81%" align='left'>
									<input type="text" name="sendtime" class="text-line"
										value="<%=sendTime%>" readonly="true"
										onClick="javascript:showCal()" style="cursor:hand" />
								</td>
							</tr>
							<tr class="line-even">
								<td width="19%" nowrap align="right">
									所属栏目：
								</td>
								<td width="81%" nowrap align='left'>
									<input type="hidden" name="sjId" class="text-line"
										style="cursor:hand" value="<%=sj_id%>" />
									<input type="hidden" name="sjName" class="text-line"
										readonly="true" size="40" value="<%=Module_name%>" />
									<input type="text" size=40 name="Module" class="text-line"
										treeType="Subject" value="<%=Module_name%>" treeTitle="选择所属栏目"
										readonly isSupportMultiSelect="1" isSupportFile="0"
										onClick="chooseTree('Module');formData.Module.value=formData.Module.value.replace(/\x02/ig,',');">
									<input type=button title="选择所属栏目"
										onClick="chooseTree('Module');formData.Module.value=formData.Module.value.replace(/\x02/ig,',');"
										class="bttn" value=选择...>
									<input type="hidden" name="ModuleDirIds" value="<%=sj_id%>">
									<input type="hidden" name="ModuleFileIds" value>
									<input type="hidden" name="ft_parent_id" value="<%=sj_id%>">
								</td>
							</tr>
							<tr class="line-even">
								<td width="19%" nowrap align="right">
									规定单条短信字数(51)：
								</td>
								<td width="81%" nowrap align='left'>
								<span id=mess></span><input name="message" value="51" type="text" size="4" readonly/>个字！<span id="age" class="STYLE1"></span></td>
							</tr>
							<tr class="line-even">
								<td align="left" height="20" colspan=2>
									<textarea name="content1" cols="51" style="WIDTH: 100%; HEIGHT: 80px" onbeforepaste="pp(this.form.content1,this.form.message,55)"></textarea>
								</td>
							</tr>
							<tr class="line-even">
								<td align="center" height="20" colspan=2>短信的详细内容(<span class="STYLE1">*可以在前台页面点击显示</span>)</td>
								<input type="hidden" name="dt_id" value="<%=dtID%>"/>
							</tr>
							<tr class="line-even">
								<td align="center" height="20" colspan=2>
                <textarea id="content" name="CT_content" style="display:none;WIDTH: 100%; HEIGHT: 400px"></textarea>
		<IFRAME ID="eWebEditor1" src="/system/common/edit/eWebEditor.jsp?id=CT_content&style=standard" frameborder="0" scrolling="no" width="100%" height="400"></IFRAME>

       <script type="text/javascript" for=window event=onload>
       	eWebEditor1.setHTML(document.all.CT_content.value);
       </script>
								</td>
							</tr>
							<tr class="line-even">
								<td align="center" height="20" colspan=2>
									<input type="button" value="暂存" class="bttn" onClick="save();"/>
									<input type="button" value="保存" class="bttn" onClick="saveAndsend();"/>
									<input type="reset" value="重置" class="bttn" />
									<input type="button" name="返回" value="返回" class="bttn"
										onClick="javascript:history.go(-1)">
								</td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
		</form>

	</body>
</html>

<script language="vbscript">
'新增附件
function AddAttach1()
dim count_obj,tr_obj,td_obj,file_obj,form_obj,count,table_obj
dim button_obj,countview_obj
dim str1,str2

set form_obj=document.getElementById("formData")
set fj_obj=document.getElementById("TdInfo1")
if fj_obj.innertext="无附件" then
fj_obj.innertext=""
end if

set count_obj=document.getElementById("count_obj")
if (count_obj is nothing) then
set count_obj=document.createElement("input")
count_obj.type="hidden"
count_obj.id="count_obj"
count_obj.value=1

form_obj.appendChild(count_obj)
count=1
count_obj.value=1
else
set count_obj=document.getElementById("count_obj")
count=cint(count_obj.value)+1
count_obj.value=count
end if

set div_obj=document.createElement("div")
div_obj.id="div_"&cstr(count)
fj_obj.appendchild(div_obj)
str1 = "<hr style='border-top-style: dotted; border-top-width: 1; border-bottom-style: dotted; border-bottom-width: 1' dotted; border-top-width: 1; border-bottom-style: dotted; border-bottom-width: 1 size=0 noshade color=#000000>"
str1 = str1 & "附件名称："
str1 = str1 & "<input type='file' name='file1' size=30 class='text-line' id=file >"
str2="<input type='hidden' name='fjsm1'  size=30  class='text-line' maxlength=100 id='fjsm1'>"

str3="&nbsp;<img src='../images/dialog/delete.gif' class=hand onclick='vbscript:delthis1("+""""+div_obj.id+""""+")' id='button1' name='button1'>"
div_obj.innerHtml=str1 + str2 + str3
end function

'删除函数
function delthis1(id)
  dim child,parent
set child_t=document.getElementById(id)
  if  (child_t is nothing ) then
  alert("对象为空")
      else
      call DelMain1(child_t)
          end if
      set parent=document.getElementById("TdInfo1")
          if parent.hasChildNodes() =false then
          parent.innerText="无附件"
          end if
          end function

          function DelMain1(obj)
                                     dim length,i,tt
          set tt=document.getElementById("table_obj")
                                     if (obj.haschildNodes) then
                                     length=obj.childNodes.length
                                     for i=(length-1) to 0 step -1
                                     call DelMain1(obj.childNodes(i))
                                         if obj.childNodes.length=0 then
                                         obj.removeNode(false)
                                             end if
                                         next
                                         else
                                         obj.removeNode(false)
                                             end if
                                         end function
</script>
<%
	dImpl.closeStmt();
	dCn.closeCn();
%>
