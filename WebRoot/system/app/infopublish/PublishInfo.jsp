<%@page contentType="text/html; charset=GBK"%>
<%
    response.sendRedirect("PublishEdit.jsp");
%>
<%@include file="../../manage/head.jsp"%>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />

<script LANGUAGE="javascript" src="./common/common.js"></script>
<script type="text/javascript" src="editor/fckeditor.js"></script><html>
<head>
<link href="../style.css" rel="stylesheet" type="text/css">
</head>
<body leftmargin=0 topmargin=0>

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

<%
  CMySelf mySelf = (CMySelf)session.getAttribute("mySelf");
  String sjId = CTools.dealString(request.getParameter("sjId"));
  String sjName = CTools.dealString(request.getParameter("sjName"));
  if(session.getAttribute("temppath")!=null) session.setAttribute("temppath",null);
  //mySelf.setSJRole();
  String sj_id=CTools.dealNumber(request.getParameter("sj_id")).trim();
  if(sj_id.equals("0"))sj_id="";

 //update20080122

CDataCn dCn=null;   //新建数据库连接对象
CDataImpl dImpl=null;  //新建数据接口对象

try {
 dCn = new CDataCn(); 
 dImpl = new CDataImpl(dCn); 

  String Module_name="";
  String sj_acdid = "";
  if(!sj_id.equals("0")&&!sj_id.equals("")) {
    String sql="select sj_name,sj_acdid from tb_subject where sj_id=" + sj_id;

    Hashtable content=dImpl.getDataInfo(sql);
    if(content!=null) {
      Module_name=CTools.dealNull(content.get("sj_name"))+",";
      sj_acdid = CTools.dealNull(content.get("sj_acdid"));

      if(!sj_acdid.equals("")) {
        sj_id += "," + sj_acdid;
        sql = "select sj_name,sj_acdid from tb_subject where sj_id=" + sj_acdid;
        content=dImpl.getDataInfo(sql);
        if(content!=null) {
          Module_name +=CTools.dealNull(content.get("sj_name"))+",";
        }
      }

    }
  }

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

<script LANGUAGE="javascript" src="/system/common/treeview/chooseTreeJs.jsp"></script>
<script language=javascript>
  function checkFrm(flag)
{
  formData.sjName.value=formData.Module.value;
  formData.sjId.value=formData.ModuleDirIds.value;
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
</script>
<html>
 <head>
  <title>JSP for formData form</title>
 </head>
 <body>
  <form name="formData" action="publishResult.jsp" method="post" enctype="multipart/form-data">
  <table class="main-table" width="100%">
  <tr class="title1" align=center>
        <td>信息发布</td>
     </tr>
     <tr>
       <td width="100%">
        <table width="100%" height="1">
       <tr class="line-even" >
               <td width="19%" nowrap align="right">信息类型：</td>
               <td width="81%" >
               <input type="radio" value="0" name="ct_contentflag" checked id="ct_contentflag1" onclick="showDiv('none');">新闻类
               <input type="radio" value="1" name="ct_contentflag" id="ct_contentflag2" onclick="showDiv('');">信息公开类
               </td>
             </tr>
      <tr class="line-even" >
               <td width="19%" align="right">主题：</td>
               <td width="81%" ><input type="text" name="ctTitle"  class="text-line" size="40"/><font color="#FF0000">*</font>
               &nbsp;&nbsp;特别提醒：<input type="checkbox" name="ctFocusFlag" class="text-line" value="1">
               </td>
               </tr>
             <tr class="line-even" >
               <td width="19%" align="right">关键字：</td>
               <td width="81%" ><input type="text" name="ctKeywords" class="text-line" size="40"/>
               </td>
             </tr>
             <tr class="line-even" >
               <td width="19%" align="right">链接地址：</td>
               <td width="81%" ><input type="text" name="ctUrl" class="text-line"  size="40" value="http://"/>
               </td>
             </tr>
              <tr class="line-even" >
               <td width="19%" align="right">来源：</td>
               <td width="81%" ><input type="text" name="ctSource" class="text-line" size="40"/>
               </td>
             </tr>
             <!--tr class="line-even" >
               <td width="19%" align="right">排序：</td>
               <td width="81%" ><input type="text" name="ctSequence" class="text-line" value="1000"/>
               </td>
             </tr-->

             <tr class="line-even" >
               <td width="19%" align="right">发布时间：</td>
               <td width="81%" >
        <input type="text" name="ctCreateTime" class="text-line" readonly="true" onclick="javascript:showCal()" style="cursor:hand" value="<%= new CDate().getThisday()%>" /><font color="#FF0000">*</font>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;结束时间：
        <input type="text" name="ctEndTime" class="text-line" readonly="true" onclick="javascript:showCal()" style="cursor:hand" value="<%= new CDate().getThisday()%>" />
               </td>
             </tr>

       <tr class="line-even" >
               <td width="19%" align="right">发布形式：</td>
               <td width="81%" ><input type="radio" name="ctFileFlag" value="0"  checked/>内容<input type="radio" name="ctFileFlag" value="1" />文件
                 <html:errors name="ctFileFlag"/>
               </td>
             </tr>
             <tr class="line-even" >
               <td width="19%" nowrap align="right">所属栏目：</td>
               <td width="81%" nowrap >

                        <input type="hidden" name="sjId" class="text-line" style="cursor:hand" value="<%=sj_id%>" />
               <input type="hidden" name="sjName" class="text-line"  readonly="true" size="40" value="<%=Module_name%>" />
            <input type="text" size=50 name="Module" class="text-line" treeType="Subject" value="<%=Module_name%>" treeTitle="选择所属栏目" readonly isSupportMultiSelect="1" isSupportFile="0" onclick="chooseTree('Module');formData.Module.value=formData.Module.value.replace(/\x02/ig,',');">
            <input type=button  title="选择所属栏目" onclick="chooseTree('Module');formData.Module.value=formData.Module.value.replace(/\x02/ig,',');" class="bttn" value=选择...><font color="#FF0000">*</font>
            <input type="hidden" name="ModuleDirIds" value="<%=sj_id%>">
            <input type="hidden" name="ModuleFileIds" value>
            <input type="hidden" name="ft_parent_id" value="<%=sj_id%>">

               </td>
             </tr>
              <tr class="line-even" >
               <td width="19%" align="right">特别推荐：</td>
               <td width="81%" ><input type="checkbox" name="ctCommend" class="text-line" value="1" />
               </td>
             </tr>
              <tr class="line-even" >
               <td width="19%" align="right">录入时间：</td>

               <td width="81%" >
        <input type="text" name="ctInsertTime" class="text-line" value="<%= new CDate().getThisday()%>"  readonly="true" />
               </td>
             </tr>

                <tr id=infoOpen style="display:none" class="line-even" >
         <td width="19%" align="right">索取号：</td>
         <td width="81%" ><input type="text" class="text-line" size="40" name="IN_CATCHNUM" maxlength="150"  value="" >
         </td>
        </tr>

                <tr id=infoOpen style="display:none" class="line-even" >
                                 <td width="19%" align="right">文件编号：</td>
                                 <td width="81%" >
                                  <input type="text" class="text-line" size="40" name="IN_FILENUM" maxlength="150"  value="" >
                                 </td>
        </tr>


        <tr id=infoOpen style="display:none" class="line-odd" >
         <td width="19%" align="right">公开类别：</td>
         <td width="81%">
          <select name="IN_CATEGORY" class=select-a>
           <option value="1" >主动公开</option>
           <option value="2" >依申请公开</option>
           </select>
         </td>
        </tr>
        <tr id=infoOpen style="display:none" class="line-even">
         <td width="19%" align="right" >内容描述：</td>
         <td width="81%" ><input type="text" class="text-line" size="40" name="IN_DESCRIPTION" maxlength="150"  value="">
         </td>
        </tr>
                          <tr class="line-odd"  id=infoOpen style="display:none">
                                  <td width="19%" align="right">载体类型：</td>
                                  <td width="81%">
                                          <select name="IN_MEDIATYPE" class=select-a>
                    <option value="1" >纸质</option>
                                   <option value="2" >胶卷</option>
              <option value="3" >磁带</option>
              <option value="4" >磁盘</option>
              <option value="5" >光盘</option>
              <option value="6" >其他</option>
                                          </select>
                                  </td>
        </tr>
                          <tr class="line-even" id=infoOpen style="display:none">
                                  <td width="19%" align="right">记录形式：</td>
                                  <td width="81%">
                                          <select name="IN_INFOTYPE" class=select-a>
                                                  <option value="1" >文本</option>
                                                  <option value="2" >图表</option>
                                                  <option value="3" >照片</option>
                                                  <option value="4" >影像</option>
                                                  <option value="5" >其他</option>
                                          </select>
                                  </td>
        </tr>
                                 <tr class="line-even">
                                    <td align="left" height="20" colspan=2>
                                      <textarea id="content" name="CT_content" style="WIDTH: 100%; HEIGHT: 400px"></textarea>
                                          <script type="text/javascript">
var oFCKeditor = new FCKeditor('CT_content') ;
oFCKeditor.BasePath = "/system/app/infopublish/editor/";
oFCKeditor.Height = 400;
oFCKeditor.ToolbarSet = "Default" ;
oFCKeditor.ReplaceTextarea();
                                          </script>
                                   </td>
                                 </tr>
                                 <tr class="odd">
                                          <td width="100%" colspan="4">
                                                       <hr style='border-top-style: dotted; border-top-width: 1; border-bottom-style: dotted; border-bottom-width: 1' size=0 noshade color=#000000>
                                                       §<a onclick="vbscript:AddAttach1()" style="cursor:hand">上传信息附件</a>§（提示：选择附件后请点击＂上传附件＂按钮）<a href="#" onclick="javascript:window.open('explainFil.jsp', 'placard', 'Top=320px,Left=500px,Width=500,Height=150,toolbar=no,location=no,derectories=no,status=no,menubar=no,resizable=yes,scrollbars=yes')"></a><br>
                                          </td>
                  </tr>
                                       <tr>
                                               <td class="row" id="TdInfo1" width="100%" colspan="4">
                                                       <hr style='border-top-style: dotted; border-top-width: 1; border-bottom-style: dotted; border-bottom-width: 1' size=0 noshade color=#000000>
                                               </td>
                                       </tr>
                                 <tr class="line-even">
                                           <td align="center" height="20" colspan=2>

                                           <input type="button" name="保存并返回列表" class="bttn" onclick="checkFrm('0');return checkform(1)" value="保存并返回列表">
                                           <input type="button" name="保存并继续发布" class="bttn" onclick="checkFrm('1');return checkform(1)" value="保存并继续发布">
                                           <input type="reset" value="重置" class="bttn" />
                                           </td>
                                 </tr>
              </table>
          </td>
                       </tr>
</table>
                              <input type="hidden" name="dtId" value="<%=Long.toString(mySelf.getDtId())%>"/>
               <INPUT type="hidden" name="urId" value="<%=Long.toString(mySelf.getMyID())%>">
               <input type="hidden" name="returnPage" value="" />
      <input type="hidden" name="infoStatus" value="" />
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
str1 = str1 & "<input type='file' name='file1' size=30 class='text-line' id=file' >"
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