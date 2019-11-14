<%@page contentType="text/html; charset=GBK"%>
<%@ page import="java.sql.ResultSet" %>
<%@include file="../../manage/head.jsp"%>

<script LANGUAGE="javascript" src="./common/common.js"></script>
<script type="text/javascript" src="editor/fckeditor.js"></script>

<%
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

  String sj_copytoid_name = "";//同时发布到的name 2007/10/24
  String sj_copytoid = "";//同时发布到原有的ID 2007/10/24
  
  Hashtable contentSJ =null;
  Hashtable content = null;
  String IN_INFOTYPE="",IN_MEDIATYPE="",IN_DESCRIPTION="",IN_CATEGORY="",IN_CATCHNUM="",IN_FILENUM="",ct_contentflag="";

  CMySelf mySelf = (CMySelf)session.getAttribute("mySelf");
  String ctId = CTools.dealString(request.getParameter("ct_id"));
  String OPType = CTools.dealNull(request.getParameter("OPType"),"Add");
  String goon = CTools.dealString(request.getParameter("goon"));
  String curpage= CTools.dealString(request.getParameter("curpage"));
  CDataCn dCn = new CDataCn();
  CDataImpl dImpl = new CDataImpl(dCn);
  String urID = String.valueOf(mySelf.getMyID());
  String dtID = String.valueOf(mySelf.getDtId());
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

	//加入同时发布的栏目开始
	  String sql_new="select sj_copytoid from tb_subject where sj_id=" + sj_id;
	  	Hashtable content_new=dImpl.getDataInfo(sql_new);
	 sj_copytoid=content_new.get("sj_copytoid").toString() ;//同时发布的ID 2007/10/24
	if(!sj_copytoid.equals(""))
	{
			sj_copytoid = sj_copytoid.substring(1,sj_copytoid.length()-1); //去掉前后的逗号

		String sj_copytoid_split [] = sj_copytoid.split(",");
		 for(int s=0; s<sj_copytoid_split.length;s++)
		{
			String sj_copytoid_a = sj_copytoid_split[s];
			String sql_inner="select sj_name from tb_subject where sj_id="+sj_copytoid_a;
			content=dImpl.getDataInfo(sql_inner);
			if(content!=null) sj_copytoid_name = sj_copytoid_name + content.get("sj_name").toString() +"," ;

		}
	sj_id +="," + sj_copytoid;
	Module_name +=sj_copytoid_name;
	}
	

//加入同时发布的栏目结束

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
	//out.println("<script language='javascript'>alert(\""+sqlStr+"\");</script>");
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
      /*
	  	IN_CATCHNUM   索取号
		IN_FILENUM    文件编号
		IN_DESCRIPTION 内容描述
		IN_MEDIATYPE  载体类型  (纸质、胶带)
		IN_INFOTYPE   记录类型  (文本)
		IN_OPENTYPE   办事结果查询 (结果类)
		IN_CATEGORY   公开类别 (依申请公开、主动公开)
	  */
      IN_INFOTYPE = content.get("in_infotype").toString();
      IN_MEDIATYPE = content.get("in_mediatype").toString();
      IN_DESCRIPTION = content.get("in_description").toString();
      IN_CATEGORY = content.get("in_category").toString();
      IN_CATCHNUM = content.get("in_catchnum").toString();
      IN_FILENUM = content.get("in_filenum").toString();
      ct_contentflag = content.get("ct_contentflag").toString();////////////////////////
			
      if(!ctImgpath.equals("")) session.setAttribute("temppath",ctImgpath);
    }
	//modify for hh
	if ("".equals(urID)) urID = String.valueOf(mySelf.getMyID());
	//end modify
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
  ///////////////////////// 
%>

<html>
<head>
<link href="../style.css" rel="stylesheet" type="text/css">
<style type="text/css">
<!--
.STYLE1 {color: #FF0000}
-->
</style>
</head>

<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title>上海浦东门户网站后台管理系统</title>
<style type="text/css">
<!--
@import url("/system/app/skin/skin3/images/main.css");
-->
</style>
<link href="/system/app/skin/skin3/images/style.css" rel="stylesheet" type="text/css">
<html>
<head>
<meta http-equiv="pragma" content="no-cache">
<link href="../style.css" rel="stylesheet" type="text/css">
<title></title>
<script LANGUAGE="javascript" src="/system/common/treeview/chooseTreeJs.js"></script>
<script language=javascript>
  function checkFrm(flag)
{
  document.formData.returnPage.value=flag;

}
function checkmy()
{
	if(document.formData.messages.value.length>51)
	{
	    alert("您输入了"+document.formData.messages.value.length+"个文字，定制短信内容不得超过51个字，请精简短信内容！");
		document.formData.messages.focus;
	}
}
function  checkFieldLength(fieldLength)
{ 
	var str = eval("document.formData.messages.value");
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
		document.formData.content1.value=str;
		eval("document.formData.messages.focus()");
		return false;
	}
	else
	{
		document.getElementById("message").innerHTML=""+theLen+"";
		return true;
	}
}

function showDiv(flag)
{
  var obj=document.getElementsByName('infoOpen');
  for(var i=0;i<obj.length;i++)
  {
    obj[i].style.display=flag;
  }
}
</script>
<SCRIPT   LANGUAGE="JavaScript">   
<!--//   
function   textCounter(field,   countfield,   maxlimit)   {  
	if(field.value.length   >   maxlimit){
	document.getElementById("mess").innerHTML="<font color='#FF0000'>注意：您已经超出了</font>";  
	} 
	else
	document.getElementById("mess").innerHTML="注意：您还可以输入";  
	countfield.value   =   maxlimit   -   field.value.length;   
}
function pp(field,countfield,maxlimit){ 
var clob = "";
}
//setInterval("textCounter(document.all.messages,document.all.message,55)", 1);
//-->   
</SCRIPT> 
 <body  style="overflow-x:hidden;overflow-y:auto">
  <form name="formData" action="publishResult.jsp" method="post" enctype="multipart/form-data" >
  <input type="hidden" name="curpage" value="<%=curpage%>"/>
  <table class="main-table" width="100%">
  <tr class="title1" align=center>
        <td>信息发布</td>
     </tr>
     <tr>
       <td width="100%">
        <table width="100%"  height="1">
      <tr class="line-even" id=divType style="display:none" >
               <td width="19%" align="right">信息类型：</td>
               <td width="81%" align='left'>
               <input type="radio" value="0" name="ct_contentflag" id="ct_contentflag1" <%if(ct_contentflag.equals("0")||ct_contentflag.equals("")) out.println("checked");%> onClick="showDiv('none');">新闻类
               <input type="radio" value="1" name="ct_contentflag" id="ct_contentflag2" <%if(ct_contentflag.equals("1")) out.println("checked");%> onClick="showDiv('');">信息公开类
               </td>
             </tr>
      <tr class="line-even" >
               <td width="19%" align="right">主题：</td>
               <td width="81%" align='left'><input type="text" name="ctTitle"  class="text-line" size="40" value="<%=ctTitle%>" maxlength="100"/>
               &nbsp;&nbsp;特别提醒：<input type="checkbox" name="ctFocusFlag" class="text-line" value="1" <%if(ctFocusFlag.equals("1")) out.println("checked");%>/>
               </td>
             </tr>
             <tr class="line-even" >
               <td width="19%" align="right">关键字：</td>
               <td width="81%" ><input type="text" name="ctKeywords" class="text-line" size="40" value="<%=ctKeywords%>" maxlength="100"/>
               </td>
             </tr>
             <tr class="line-even" >
               <td width="19%" align="right">链接地址：</td>
               <td width="81%" align='left'><input type="text" name="ctUrl" class="text-line"  size="40" value="<%=ctUrl%>" maxlength="200"/>
               </td>
             </tr>
              <tr class="line-even" >
               <td width="19%" align="right">来源：</td>
               <td width="81%" align='left'><input type="text" name="ctSource" class="text-line" size="40" value="<%=ctSource%>" maxlength="100"/>
               </td>
             </tr>
             <tr class="line-even" >
               <td width="19%" align="right">发布时间：</td>
               <td width="81%" align='left'><input type="text" name="ctCreateTime" class="text-line" value="<%=ctCreateTime%>" readonly="true" onClick="javascript:showCal()" style="cursor:hand"/>
                 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;结束时间：<input type="text" name="ctEndTime" class="text-line" value="<%=ctEndTime%>" readonly="true" onClick="javascript:showCal()" style="cursor:hand"/>
               </td>
             </tr>
             <tr class="line-even" >
               <td width="19%" align="right">发布形式：</td>
               <td width="81%" align='left'><input type="radio" name="ctFileFlag" value="0" <%if(ctFileFlag.equals("0")) out.println("checked");%>/>内容<input type="radio" name="ctFileFlag" value="1" <%if(ctFileFlag.equals("1")) out.println("checked");%>/>文件
                 <html:errors name="ctFileFlag"/>
               </td>
             </tr>
             <tr class="line-even" >
               <td width="19%" nowrap align="right">所属栏目： </td>
               <td width="81%" nowrap align='left'>
                                   <input type="hidden" name="sjId" class="text-line" style="cursor:hand" value="<%=sj_id%>" />
                                    <input type="hidden" name="sjName" class="text-line"  readonly="true" size="40" value="<%=Module_name%>" />
         <input type="hidden" size=40 name="Module" class="text-line" treeType="Subject" value="<%=Module_name%>" treeTitle="选择所属栏目" readonly isSupportMultiSelect="1" isSupportFile="0" onClick="chooseTree_new('Module');formData.Module.value=formData.Module.value.replace(/\x02/ig,',');">
		 &nbsp;<b>+ <a href="#" onClick="chooseTree_new('Module');formData.Module.value=formData.Module.value.replace(/\x02/ig,',');return false;">添加栏目</a></b><span id="signText" style="padding:20px;color:#808080;"></span>
         <!-- <input type=button  title="选择所属栏目" onClick="chooseTree_new('Module');formData.Module.value=formData.Module.value.replace(/\x02/ig,',');" class="bttn" value=选择...> -->
         <input type="hidden" name="ModuleDirIds" value="<%=sj_id%>">
         <input type="hidden" name="ModuleFileIds" value>
         <input type="hidden" name="ft_parent_id" value="<%=sj_id%>">
               </td>
             </tr>
			 <tr class="line-even">
				<td></td>
				<td style="padding:5px"><span id="testname"></span></td>
			 </tr>
			<script>
			//var sid = "<%=sj_id%>";
			//var sname = "<%=Module_name%>";
			//var sid_array = sid.split(",");
			var sid = toArray("<%=sj_id%>",",");
			var ORIGINAL_SID = "<%=sj_id%>";
			//var name_array = sname.split(",");
			var sname = toArray("<%=Module_name%>",",");
			innerST("请点击添加所属栏目！");
			outPut(sid,sname);
			//document.all.testname.innerHTML = sname.toStringFormat(true,"；");
			</script>
              <tr class="line-even" >
               <td width="19%" align="right">特别推荐：</td>
               <td width="81%" ><input type="checkbox" name="ctCommend" class="text-line" value="1" <%=cpCommend.equals("1") ? "checked" : ""%>/>
               </td>
             </tr>
			 <tr class="line-even" >
               <td width="19%" align="right">允许用户评论：</td>
               <td width="81%" ><input type="checkbox" name="ct_IsComment" class="text-line" value="1" <%=ct_IsComment.equals("1") ? "checked" : ""%>/>
               </td>
             </tr>
              <tr class="line-even" >
               <td width="19%" align="right">录入时间：</td>

               <td width="81%" align='left'><input type="text" name="ctInsertTime" class="text-line" value="<%= ctInsertTime%>"  readonly="true" />
               </td>
             </tr>
                 <tr class="line-even"  id=infoOpen style="display:<%if(ct_contentflag.equals("0")||ct_contentflag.equals("")) out.println("none");%>" >
        <td width="19%" align="right">索取号：</td>
        <td width="81%" ><input type="text" class="text-line" size="40" name="IN_CATCHNUM" maxlength="150"  value="<%=IN_CATCHNUM%>" >
        </td>
       </tr>
        <%if (mySelf.getMyName().equals("区政府发布员")) {%>
       <tr class="line-odd"  id=infoOpen style="display:<%if(ct_contentflag.equals("0")||ct_contentflag.equals("")) out.println("none");%>" >
        <td width="19%" align="right">发布机构：</td>
        <td width="81%" ><input type="text" class="text-line" size="40" name="dtName" maxlength="100"  value="<%=dtName%>" >
        </td>
       </tr>
       <%} else {%>
       <input type="hidden" name="dtName" value="<%=dtName%>" >
       <%}%>

               <tr class="line-even"  id=infoOpen style="display:<%if(ct_contentflag.equals("0")||ct_contentflag.equals("")) out.println("none");%>">
                                    <td width="19%" align="right">文件编号：</td>
                                    <td width="81%" align='left'><input type="text" class="text-line" size="40" name="IN_FILENUM" maxlength="150"  value="<%=IN_FILENUM%>">
                            </td>
       </tr>


       <tr class="line-odd"  id=infoOpen style="display:<%if(ct_contentflag.equals("0")||ct_contentflag.equals("")) out.println("none");%>">
        <td width="19%" align="right">公开类别：</td>
        <td width="81%" align='left'>
         <select name="IN_CATEGORY" class=select-a >
          <option value="1" <%=(IN_CATEGORY.equals("1"))?"selected":""%>>主动公开</option>
          <option value="2" <%=(IN_CATEGORY.equals("2"))?"selected":""%>>依申请公开</option>
          </select>
        </td>
       </tr>
       <tr class="line-even" id=infoOpen style="display:<%if(ct_contentflag.equals("0")||ct_contentflag.equals("")) out.println("none");%>">
        <td width="19%" align="right" >内容描述：</td>
        <td width="81%" align='left'><input type="text" class="text-line" size="40" name="IN_DESCRIPTION" maxlength="150"  value="<%=IN_DESCRIPTION%>">
        </td>
       </tr>
                            <tr class="line-odd"  id=infoOpen style="display:<%if(ct_contentflag.equals("0")||ct_contentflag.equals("")) out.println("none");%>">
                                    <td width="19%" align="right">载体类型：</td>
                                    <td width="81%">
                                            <select name="IN_MEDIATYPE" class=select-a >
                 <option value="1" <%=(IN_MEDIATYPE.equals("1"))?"selected":""%>>纸质</option>
                                                    <option value="2" <%=(IN_MEDIATYPE.equals("2"))?"selected":""%>>胶卷</option>
          <option value="3" <%=(IN_MEDIATYPE.equals("3"))?"selected":""%>>磁带</option>
          <option value="4" <%=(IN_MEDIATYPE.equals("4"))?"selected":""%>>磁盘</option>
          <option value="5" <%=(IN_MEDIATYPE.equals("5"))?"selected":""%>>光盘</option>
          <option value="6" <%=(IN_MEDIATYPE.equals("6"))?"selected":""%>>其他</option>
                                             </select>
                                    </td>
       </tr>
                            <tr class="line-even"  id=infoOpen style="display:<%if(ct_contentflag.equals("0")||ct_contentflag.equals("")) out.println("none");%>">
                                    <td width="19%" align="right">记录形式：</td>
                                    <td width="81%" align='left'>
                                            <select name="IN_INFOTYPE" class=select-a >
                                                    <option value="1" <%=(IN_INFOTYPE.equals("1"))?"selected":""%>>文本</option>
                                                    <option value="2" <%=(IN_INFOTYPE.equals("2"))?"selected":""%>>图表</option>
                                                    <option value="3" <%=(IN_INFOTYPE.equals("3"))?"selected":""%>>照片</option>
                                                    <option value="4" <%=(IN_INFOTYPE.equals("4"))?"selected":""%>>影像</option>
                                                    <option value="5" <%=(IN_INFOTYPE.equals("5"))?"selected":""%>>其他</option>
                                             </select>
                                    </td>
       </tr>
                            <tr class="line-odd"  id=infoOpen style="display:<%if(ct_contentflag.equals("0")||ct_contentflag.equals("")) out.println("none");%>">
                                    <td width="19%" align="right">办事结果查询：</td>
                                    <td width="81%" align='left'>
                                            <select name="IN_OPENTYPE" class=select-a >
                                                    <option value="0">请选择</option>
                                                    <option value="结果类">结果类</option>
                                             </select>
                                    </td>
       </tr>
	   

	   
             <tr class="line-even">
                <td align="left" height="20" colspan=2>
                <textarea id="content" name="CT_content" style="display:none;WIDTH: 100%; HEIGHT: 400px"><%=ctContent%></textarea>
		<IFRAME ID="eWebEditor1" src="/system/common/edit/eWebEditor.jsp?id=CT_content&style=standard" frameborder="0" scrolling="no" width="100%" height="400"></IFRAME>

       <script type="text/javascript" for=window event=onload>
       	eWebEditor1.setHTML(document.all.CT_content.value);
       	/*
var oFCKeditor = new FCKeditor('CT_content') ;
oFCKeditor.BasePath = "/system/app/infopublish/editor/" ;
oFCKeditor.Height = 400;
oFCKeditor.ToolbarSet = "Default" ;
oFCKeditor.ReplaceTextarea();*/
       </script>


        </td>
             </tr>

<!--------------------当成短信发送------------------------->
	 <%
		 if(OPType.equals("Edit"))
		 {
		 	String xiaoweiSql="select s.*,d.sj_name from tb_sms s left join tb_subject d on s.sm_sj_id = d.sj_id where s.sm_ct_id="+ctId;
			Vector vectorPage2 = dImpl.splitPage(xiaoweiSql,request,20);
			  if(vectorPage2!=null)
			  {
				for(int w=0;w<vectorPage2.size();w++)
				{
				  Hashtable content121 = (Hashtable)vectorPage2.get(w);
	  
			//Hashtable content1 = dImpl.getDataInfo(xiaoweiSql);
			if (content121!=null)
			{
			%>
	     <tr class="odd">
         <td width="19%" align="left">短信信息：</td>
          <td width="81%" align='left'>
			
			<%
				String sm_con = content121.get("sm_con").toString();
				String sj_name = content121.get("sj_name").toString();
				String sm_check = content121.get("sm_check").toString();//1待审核 2 通过了 3 没有通过
				String sm_flag = content121.get("sm_flag").toString();//1 发送了 2 没有发送
				out.print(sm_con+"&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"+sj_name+"&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");
				switch (Integer.parseInt(sm_check))
				{
				case 1: out.print("待审核");break;
				case 2: out.print("审核通过");break;
				case 3: out.print("没有通过审核");break;
				}
				
				
			%>	
     </td>
     </tr><%
			}
			}
			}
			}
		 %>
<%if(OPType.equals("Add")||OPType.equals("Edit")){%>
     <tr class="line-even">
        <td width="100%" colspan="4">
       §<a onClick="myshow(1,2)" style="cursor:hand">将信息定制成短信</a>(<span id=mess>注意：您还可以输入</span><input name="message" value="51" type="text" size="4" readonly/>个字！<span  class="STYLE1">  超出部分将分条收费！</span>) </td>
     </tr>
	 <%}%>
	 <tr class="odd"  id="submenu2" style="display:none ">
         <td width="19%" align="right">短信所属栏目：</td>
          <td width="81%" align='left'>
          <select name="mysj_id" class=select-a >
<%
String strSql="select sj_id,sj_parentid,sj_dir,sj_name from tb_subject where sj_dir <> 'xxll' connect by prior sj_id = sj_parentid start with sj_dir = 'xxll' order by SJ_SEQUENCE ";
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
%>
		  </select>
     </td>
     </tr>
     <tr class="line-even" id="submenu1"  style="display:none ">
        <td width="100%" colspan="4">
          <textarea name="messages" cols="60" rows="8" onPropertyChange="textCounter(document.all.messages,document.all.message,51);"></textarea>&nbsp;&nbsp;
          </td>
     </tr>

<!--------------------当成短信发送------------------------->   

             <tr class="odd">
        <td width="100%" colspan="4">
       <hr style='border-top-style: dotted; border-top-width: 1; border-bottom-style: dotted; border-bottom-width: 1' size=0 noshade color=#000000>
       §<a onClick="vbscript:AddAttach1()" style="cursor:hand">上传信息附件</a>

<%if(content!=null){
         if (!filePath.equals(""))
         {
           //out.println("<hr style='border-top-style: dotted; border-top-width: 1; border-bottom-style: dotted; border-bottom-width: 1' size=0 noshade color=#000000>");
           String ia_id = "";
           String ia_name = "";
           String ia_path = "";
           String fileName = "";

           String sql_ia = "select im_id,im_name,im_path,im_filename from tb_image where ct_id="+ctId;
           //out.println(sql_ia);
           Vector vPage_ia = dImpl.splitPage(sql_ia,100,1);
           if (vPage_ia!=null)
           {
%>
<br>以下是已上传的附件：
<%
             for(int n=0;n<vPage_ia.size();n++)
             {
               Hashtable content_ia = (Hashtable)vPage_ia.get(n);
               ia_id = content_ia.get("im_id").toString();
               ia_name = content_ia.get("im_name").toString();
               ia_path = content_ia.get("im_path").toString();
               fileName = content_ia.get("im_filename").toString();
               int imgflag = 0;
          %>
          <p align="left">文件名称：&nbsp;&nbsp;&nbsp;&nbsp;<a href="download.jsp?ia_id=<%=ia_id%>"><%if(!ia_name.equals("")) {out.println(ia_name);} else{out.println(fileName);}%></a>&nbsp;&nbsp;
          <img SRC="../images/dialog/delete.gif" onClick="javascript:deleteFile('<%=fileName%>');" title='删除该文件'style="cursor:hand">
          </p>
          <%
            }
           }
         }
        }
        %>
        <span  id="TdInfo1">
                     <hr style='border-top-style: dotted; border-top-width: 1; border-bottom-style: dotted; border-bottom-width: 1' size=0 noshade color=#000000>
        </span>
        </td>
     </tr>

             <tr class="line-even">
                <td align="center" height="20" colspan=2>
<%
   //ResultSet rs=dImpl.executeQuery("select AUDITER,AUDITOPINIION from ");
%>
<%if(OPType.equals("Edit")){%>
                <input type="button" name="提交" class="bttn" onClick="checkFrm('0');return checkform(2)" value="提交">
                <input type="button" name="选择相关新闻" class="bttn" onClick="doAction();" value="选择相关新闻">
<%}else if(OPType.equals("Wenji")){%>
      <input type="button" name="修改" class="bttn" onClick="checkFrm('0');return checkform(2)" value="修改">
<%}else if(OPType.equals("Tingzheng")){%>
      <input type="button" name="修改" class="bttn" onClick="checkFrm('0');return checkform(2)" value="修改">
<%}else if(OPType.equals("ShenHeEdit")){%>
      <input type="button" name="修改" class="bttn" onClick="checkFrm('0');return checkform(2)" value="修改">
<%}else if(OPType.equals("ShenPiCancel")){%>
      <input type="button" name="正式发布" class="bttn" onClick="return checkform(6)" value="正式发布">
<%}else if(OPType.equals("ShenHeBack")){%>
      <input type="button" name="修改" class="bttn" onClick="this.form.tcStatus.value='2';checkform(7)" value="修改">
<%}else if(OPType.equals("ShenPi")){%>
      <input type="button" name="正式发布" class="bttn" onClick="document.formData.publishStatus.value='1';return checkform(4)" value="正式发布">
      <input type="button" name="取消发布" class="bttn" onClick="document.formData.publishStatus.value='0';do_Back();" value="取消发布">
<%}else if(OPType.equals("ShenPiEdit")){%>
      <input type="button" name="修改" class="bttn" onClick="checkFrm('0');return checkform(2)" value="修改">
<%}else if(OPType.equals("Add")){%>
      <input type="button" name="保存并返回列表" class="bttn" onClick="<%if(sj_id.equals("371")){%>autoAddToShanghai();<%}%>checkFrm('0');checkform(1);" value="保存并返回列表">
      <input type="button" name="保存并继续发布" class="bttn" onClick="checkFrm('1');return checkform(1);" value="保存并继续发布">
<%}else if(OPType.equals("ShenHe")){%>
<table border=0 width=100% bgcolor=white>
     <tr>
             <td class="row"  width="100%" colspan="4">
                     <hr style='border-top-style: dotted; border-top-width: 1; border-bottom-style: dotted; border-bottom-width: 1' size=0 noshade color=#000000>
             </td>
     </tr>
      <tr class="line-even" >
 <td width="19%" align="right">审核意见：</td>
 <td width="81%" align="left"><textarea name="tcMemo" cols="60" rows="5"><%=tc_memo%></textarea>
 </td>
</tr>
<tr class="line-even" >
 <td width="19%" align="right">审核人：</td>
 <td width="81%" align="left"><input type="text" name="checkPerson" class="text-line" readonly value="<%=mySelf.getMyName()%>"/>
 </td>
</tr>
     <tr>
             <td class="row" width="100%" colspan="4">
                     <hr style='border-top-style: dotted; border-top-width: 1; border-bottom-style: dotted; border-bottom-width: 1' size=0 noshade color=#000000>
             </td>
     </tr>
     </table>
       <input type="button" name="通过" class="bttn" onClick="if(this.form.tcMemo.value=='')this.form.tcMemo.value='审核通过，准予发布';this.form.tcStatus.value='1';checkform(3)" value="通过">
       <input type="button" name="退回" class="bttn" onClick="if(this.form.tcMemo.value=='')this.form.tcMemo.value='内容有问题，审核没有通过，请修改后重新报送';this.form.tcStatus.value='0';checkform(5)" value="退回">
<%}%>
       <input type="reset" value="重置" class="bttn" />
       <input type="button" name="返回" value="返回" class="bttn" onClick="javascript:history.go(-1)">
                </td>
             </tr>
     </table>
    </td>
   </tr>
  </table>
  <input type="hidden" name="publishStatus" />
  <input type="hidden" name="infoStatus" />
  <input type="hidden" value="<%=tcSenderId%>" name="tcSenderId" />
  <input type="hidden" name="checkPersonId" class="text-line" value="<%=Long.toString(mySelf.getMyID())%>"/>
  <input type="hidden" value="<%=new CDate().getThisday()%>" name="tcTime" />
  <input type="hidden" value="<%=chkIDs%>" name= chkIDs>
  <INPUT type="hidden" name="ctImgpath" value="<%=ctImgpath%>"/>
  <INPUT type="hidden" name="filePath" value="<%=filePath%>"/>
  <input type="hidden" name="dtId" value="<%=dtID%>"/>
  <INPUT type="hidden" name="urId" value="<%=urID%>">
  <INPUT type="hidden" name="ctId" value="<%=ctId%>">
  <input type="hidden" name="returnPage" value="" />
  <INPUT type="hidden" name="tcStatus" value="0">
  <INPUT type="hidden" name="orgSjId" value=",<%=sjId%>">
  <input type=hidden name=OPType value="<%=OPType%>">
            </form>

 </body>
</html>
<script language='javascript'>
function myshow(number,num)
{
	var str=eval("submenu"+number);
	var str1=eval("submenu"+num);
	if(str.style.display=="none")
	{
		eval("submenu"+number+".style.display=''")//等同于document.all.item("submenu"+number).style.display='';
	}else
	{
		eval("submenu"+number+".style.display='none'");//等同于document.all.item("submenu"+number).style.display='';
	}
	if(str1.style.display=="none")
	{
		eval("submenu"+num+".style.display=''")//等同于document.all.item("submenu"+number).style.display='';
	}else
	{
		eval("submenu"+num+".style.display='none'");//等同于document.all.item("submenu"+number).style.display='';
	}
}



	function do_Back() {
		var url = "backReson.jsp?ct_id=<%=ctId%>&ct_title=<%=ctTitle%>";
		var val = window.showModalDialog(url,'newwindow','dialogheight:226px;dialogwidth:500px;help=no; status=no; scroll=no; resizable=no;');  
		if (val == "ok") checkform(4);
	}
	function autoAddToShanghai()
	{
			//window.open("auto.htm","sf666","top=100000000,left=100000000,width=100,height=100");
	}
  function doAction() {
          if (formData.ctKeywords.value == "") {
            alert("请在关键字位置输入关键字，然后选择相关资料！");
            formData.ctKeywords.focus();
            return false;
          }
          var ct_keywords = formData.ctKeywords.value;
 var url = "publishListAbout.jsp?ct_id=<%=ctId%>&OPType=Add&ct_keywords="+ct_keywords;
   window.open(url,'newwindow','height=600,width=700,toolbar=no,menubar=no,scrollbars=yes,resizable=no,location=no,status=no');
        }
        //setHtml();
        function deleteFile(fileName)
        {
          if(confirm("确认要删除该文件吗？"))
          {
            var obj = formData.ctId;
            var url = "attachDel.jsp?fileName="+fileName;
            url += "&in_id="+obj.value;
            window.location = url;
          }
        }

<%
	 boolean isInfoOpen=false;
     if(!sj_id.equals(""))
	 {
			//String sql="select SJ_NAME,level from tb_subject connect by prior SJ_PARENTID=SJ_ID start with sj_id="+sj_id+"  order by level desc";
			//modify for hh
			String sql="select SJ_NAME,level from tb_subject connect by prior SJ_PARENTID=SJ_ID start with sj_id in ("+CTools.trimEx(sj_id,",").replaceAll(",+",",")+")  order by level desc";
			//end modify
			//out.println(">>>>>>>>>>>>>>>>>>>>>> " + sql);
			ResultSet rsName=dImpl.executeQuery(sql);
			while (rsName.next())
			{
				String tb_name=CTools.dealNull(rsName.getString("sj_name"));
				if(tb_name.equals("政府信息公开目录")||tb_name.equals("公开目录")||tb_name.equals("政府公开目录")||tb_name.equals("部门信息公开")||tb_name.equals("部门公开")||tb_name.equals("依申请公开")||tb_name.equals("主动公开"))isInfoOpen=true;
				
			}
	 }
	 if(isInfoOpen)
	 {
%>
document.all.divType.style.display='';
document.all.ct_contentflag2.click();
<%
	  }
%>
</script>
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
