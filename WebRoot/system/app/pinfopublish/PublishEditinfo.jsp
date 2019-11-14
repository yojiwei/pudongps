<%@page contentType="text/html; charset=GBK"%>
<%@include file="../skin/head.jsp"%>

<script LANGUAGE="javascript" src="./common/common.js"></script>
<script type="text/javascript" src="editor/fckeditor.js"></script>

<%
	String ctTitle = "";
	String ctKeywords = "";
	String ctUrl = "";
	String ctSource = "";
	String ctCreateTime = "";
	String ctFileFlag = "";
	String sjId = "";
	String sjName = "";
	String ctFocusFlag = "";
	String ctInsertTime = "";
	String ctBrowseNum = "";
	String ctFeedbackFlag = "";
	String ctContent = "";
	String tcId = "";
	String tcSenderId = "";
	String chkIDs = "";
	String tcMemo = "";
	String ctImgpath = "";
	String uiName = "";
	String ctRight="";
	String ctTimeLimit="";
	String IN_INFOTYPE="",IN_MEDIATYPE="",IN_DESCRIPTION="",IN_CATEGORY="",IN_CATCHNUM="",IN_FILENUM="",ct_contentflag="";
	
	
	
	CMySelf mySelf = (CMySelf)session.getAttribute("mySelf");

	String ctId = CTools.dealString(request.getParameter("ct_id"));
//update20080122

CDataCn dCn=null;   //新建数据库连接对象
CDataImpl dImpl=null;  //新建数据接口对象

try {
 dCn = new CDataCn(); 
 dImpl = new CDataImpl(dCn); 
	String sqlStr = "select c.*,ct_content,t.tc_id,t.tc_senderid,par.tc_memo,u.ui_name,t.sj_id as chkids from tb_content c,tb_taskcenter t,tb_taskcenter par,tb_userinfo u ,tb_contentdetail d where d.ct_id=c.ct_id and u.ui_id=par.tc_senderid and c.ct_id='" + ctId + "' and t.ct_id = c.ct_id and t.tc_isfinished='0' and t.tc_receiverid='" + mySelf.getMyID() + "' and t.tc_parentid=par.tc_id and rownum=1";
	out.println(sqlStr);
	Hashtable content = dImpl.getDataInfo(sqlStr);
	if(content!=null)
	{
		ctTitle = content.get("ct_title").toString();
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
		tcId = content.get("tc_id").toString();
		tcSenderId = content.get("tc_senderid").toString();
		tcMemo = content.get("tc_memo").toString();
		ctImgpath = content.get("ct_img_path").toString();
		uiName = content.get("ui_name").toString();
		chkIDs = content.get("chkids").toString();
		chkIDs = chkIDs.substring(1,chkIDs.length());
		ctTimeLimit = content.get("ct_timelimit").toString(); 
		ctRight = content.get("ct_right").toString();
		
		IN_INFOTYPE = content.get("in_infotype").toString();
		IN_MEDIATYPE = content.get("in_mediatype").toString();
		IN_DESCRIPTION = content.get("in_description").toString();
		IN_CATEGORY = content.get("in_category").toString();
		IN_CATCHNUM = content.get("in_catchnum").toString();
		IN_FILENUM = content.get("in_filenum").toString();
		ct_contentflag = content.get("ct_contentflag").toString();
		
	}
	

	
%>
<html> 
	<head>
		<title>JSP for PublishForm form</title>
	</head>
	<body >
		<form name="PublishForm" action="publishResult.jsp" method="post" enctype="multipart/form-data">
		<table class="main-table" width="100%">
		<tr class="title1" align=center>
	      	<td>信息发布</td>
	    </tr>
	    <tr>
	     	<td width="100%">
	     		<table width="100%" class="content-table" height="1">
					 <tr class="line-even" >
			            <td width="19%" align="right">主题：</td>
			            <td width="81%" ><input type="text" name="ctTitle"  class="text-line" size="80" value="<%=ctTitle%>"/>
			            </td>
			          </tr>	
			       
			          <tr class="line-even" >
			            <td width="19%" align="right">关键字：</td>
			            <td width="81%" ><input type="text" name="ctKeywords" class="text-line" size="80" value="<%=ctKeywords%>" />
			            </td>
			          </tr>
			          <tr class="line-even" >
			            <td width="19%" align="right">链接地址：</td>
			            <td width="81%" ><input type="text" name="ctUrl" class="text-line"  size="80" value="<%=ctUrl%>"/>
			            </td>
			          </tr>
			           <tr class="line-even" >
			            <td width="19%" align="right">来源：</td>
			            <td width="81%" ><input type="text" name="ctSource" class="text-line" size="80" value="<%=ctSource%>"/>
			            </td>
			          </tr>
			          <tr class="line-even" >
			            <td width="19%" align="right">发布时间：</td>
			            <td width="81%" ><input type="text" name="ctCreateTime" class="text-line" value="<%=ctCreateTime%>" readonly="true" onclick="javascript:showCal()" style="cursor:hand"/>
			            </td>
			          </tr>
			          <tr class="line-even" >
			            <td width="19%" align="right">发布形式：</td>
			            <td width="81%" ><input type="radio" name="ctFileFlag" value="0" <%if(ctFileFlag.equals("0")) out.println("checked");%>/>内容<input type="radio" name="ctFileFlag" value="1" <%if(ctFileFlag.equals("1")) out.println("checked");%>/>文件			         
			            </td>
			          </tr>
                      <tr class="line-even" >
			            <td width="19%" align="right">有效期限：</td>
			            <td width="81%" >
						  <input type="text" name="ct_timelimit" class="text-line" readonly="true" onclick="javascript:showCal()" style="cursor:hand" value="<%=ctTimeLimit%>" /><font color="#FF0000">*</font>
			            </td>
			          </tr>
					  <tr class="line-even" >
			            <td width="19%" align="right">登录权限：</td>
			            <td width="81%" >
						  <select name="ct_right">
								<option value=""  <%if(ctRight.equals("")) out.println("checked");%> >否</option>
								<option value="1" <%if(ctRight.equals("1")) out.println("checked");%>>是</option>
						 </select>
			            </td>
			          </tr>
			          <tr class="line-even" >
			            <td width="19%" align="right">所属栏目：</td>
			            <td width="81%" >			            
			            <input type="hidden" name="sjId" class="text-line" style="cursor:hand" value="<%=sjId%>" />
			            <input type="text" name="sjName" class="text-line" style="cursor:hand" readonly="true" size="80" onclick="javascript:fnSelectSJ(0)" value="<%=sjName%>" />
			            <input type="hidden" name="authoIds" value="<%=mySelf.getSjIds()%>" />
			            <input type="hidden" name="authoNames" value="<%=mySelf.getSjNames()%>" />
			            </td>
			          </tr>
			           <tr class="line-even" >
			            <td width="19%" align="right">特别提醒：</td>
			            <td width="81%" ><input type="checkbox" name="ctFocusFlag" class="text-line" value="1" <%if(ctFocusFlag.equals("1")) out.println("checked");%>/>
			            </td>
			          </tr>
			           <tr class="line-even" >
			            <td width="19%" align="right">录入时间：</td>
			          
			            <td width="81%" ><input type="text" name="ctInsertTime" class="text-line" value="<%= ctInsertTime%>"  readonly="true" />
			            </td>
			          </tr>
			          <!--tr class="line-even" >
			            <td width="19%" align="right">浏览人次：</td>
			            <td width="81%" ><input type="text" name="ctBrowseNum" class="text-line" value="<%=ctBrowseNum%>" readonly/>
			            </td>
			          </tr-->
			          
			          
			          
			           <!--tr class="line-even" >
			            <td width="19%" align="right">信息反馈：</td>
			            <td width="81%" ><input type="checkbox" name="ctFeedbackFlag" value="1" <%if(ctFocusFlag.equals("1")) out.println("checked");%>/>
			            </td>
			          </tr-->
			          
			          <tr class="line-odd" >
								<td width="19%" align="right">公开类别：</td>
								<td width="81%">
									<select name="IN_CATEGORY" class=select-a >
										<option value="1" <%=(IN_CATEGORY.equals("1"))?"selected":""%>>主动公开</option>
										<option value="2" <%=(IN_CATEGORY.equals("2"))?"selected":""%>>依申请公开</option>
									 </select>
								</td>
							</tr>
							<tr class="line-even">
								<td width="19%" align="right" >内容描述：</td>
								<td width="81%" ><input type="text" class="text-line" size="45" name="IN_DESCRIPTION" maxlength="150"  value="<%=IN_DESCRIPTION%>">
								</td>
							</tr>
				                        <tr class="line-odd" >
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
				                        <tr class="line-even" >
				                                <td width="19%" align="right">记录形式：</td>
				                                <td width="81%">
				                                        <select name="IN_INFOTYPE" class=select-a >
				                                                <option value="1" <%=(IN_INFOTYPE.equals("1"))?"selected":""%>>文本</option>
				                                                <option value="2" <%=(IN_INFOTYPE.equals("2"))?"selected":""%>>图表</option>
				                                                <option value="3" <%=(IN_INFOTYPE.equals("3"))?"selected":""%>>照片</option>
				                                                <option value="4" <%=(IN_INFOTYPE.equals("4"))?"selected":""%>>影像</option>
				                                                <option value="5" <%=(IN_INFOTYPE.equals("5"))?"selected":""%>>其他</option>
				                                         </select>
				                                </td>
							</tr>
							
							</table>
							</td>
							</tr>
			         <tr class="line-even">
				           
				           <td align="left" height="20" colspan=2> 
                <textarea id="content" name="CT_content" style="display:none;WIDTH: 100%; HEIGHT: 400px"><%=ctContent%></textarea>
		<IFRAME ID="eWebEditor1" src="/system/common/edit/eWebEditor.jsp?id=CT_content&style=standard" frameborder="0" scrolling="no" width="100%" height="400"></IFRAME>

       <script type="text/javascript" for=window event=onload>
       	eWebEditor1.setHTML(document.all.CT_content.value);
       </script>
							
							 </td>
          			</tr>
          			<tr class="odd">
					   <td width="100%" colspan="4">
							<hr style='border-top-style: dotted; border-top-width: 1; border-bottom-style: dotted; border-bottom-width: 1' size=0 noshade color=#000000>
							§<a onclick="vbscript:AddAttach1()" style="cursor:hand">上传信息附件</a>§<br>以下是已上传的附件：
							<%
				 if (!ctImgpath.equals(""))
				 {
					out.println("<hr style='border-top-style: dotted; border-top-width: 1; border-bottom-style: dotted; border-bottom-width: 1' size=0 noshade color=#000000>");
					String ia_id = "";
					String ia_name = "";
					String ia_path = "";
					String fileName = "";

					String sql_ia = "select fa_id,fa_name,fa_path,fa_filename from tb_fileattach where ct_id="+ctId;
					//out.println(sql_ia);
					Vector vPage_ia = dImpl.splitPage(sql_ia,100,1);
					if (vPage_ia!=null)
					{
						for(int n=0;n<vPage_ia.size();n++)
						{
							Hashtable content_ia = (Hashtable)vPage_ia.get(n);
							ia_id = content_ia.get("fa_id").toString();
							ia_name = content_ia.get("fa_name").toString();
							ia_path = content_ia.get("fa_path").toString();
							fileName = content_ia.get("fa_filename").toString();
							int imgflag = 0;
							if(fileName.toLowerCase().indexOf(".jpg")>0||fileName.toLowerCase().indexOf(".bmp")>0||fileName.toLowerCase().indexOf(".gif")>0)
							{
								imgflag = 1;
							}
							%>
							<p align="left">文件名称：&nbsp;&nbsp;&nbsp;&nbsp;<a href=
							<%
								if(imgflag==1)
								{
									//out.println("javascript:dd('imgPreview.jsp?ia_filename="+fileName+"&ia_path="+ia_path+"');window.close();");
									//out.println("javascript:dd('"+infohttppath+ia_path+"/"+fileName+"');window.close();");
								}
								else
								{
									out.println("download.jsp?ia_id="+ia_id+"w.close();");
								}
							%>
							><%if(!ia_name.equals("")) {out.println(ia_name);} else{out.println(fileName);}%></a>&nbsp;&nbsp;
							<img SRC="../images/dialog/delete.gif" onclick="javascript:deleteFile('<%=fileName%>');" title='删除该文件'style="cursor:hand">
							</p>
							<%
						}
					}
				 }
				 %>
					   </td>
					</tr>
					<tr>
						<td class="row" id="TdInfo1" width="100%" colspan="4">
							<hr style='border-top-style: dotted; border-top-width: 1; border-bottom-style: dotted; border-bottom-width: 1' size=0 noshade color=#000000>
						</td>
					</tr>
					 <tr class="line-even" >
			            <td width="19%" align="right">退回意见：</td>
			            <td width="81%" ><textarea name="tcMemo" cols="60" rows="5" readonly><%=tcMemo%></textarea>
			            </td>
			          </tr>
			           <tr class="line-even" >
			            <td width="19%" align="right">审核人：</td>
			            <td width="81%" ><input type="text" name="checkPerson" value="1" class="text-line" value="<%=uiName%>"/>
			            <input type="hidden" value="<%=tcSenderId%>" name="tcSenderId" />
			            <input type="hidden" name="checkPersonId" value="1" class="text-line" value="<%=Long.toString(mySelf.getMyID())%>"/>
			            
			            <input type="hidden" value="<%=new CDate().getThisday()%>" name="tcTime" />
			            <input type="hidden" value="<%=chkIDs%>" name= chkIDs>
			            </td>
			          </tr>
					</tr>
			          <tr class="line-even">
				            <td align="center" height="20" colspan=2>
				            <input type="button" name="提交" class="bttn" onclick="document.PublishForm.tcStatus.value='1';return checkform(4)" value="通过">				            
				            <input type="reset" value="重置" class="bttn" />
				            </td>
          			</tr>
					</table>
				</td>
			</tr>
		</table>
		<input type="hidden" name="infoStatus" />
		<input type="hidden" name="tcStatus" value="" />
		<INPUT type="hidden" name="tcParentId" value="<%=tcId%>" />
		<input type="hidden" name="dtId" value="<%=Long.toString(mySelf.getDtId())%>"/>
		<INPUT type="hidden" name="urId" value="<%=Long.toString(mySelf.getMyID())%>">
		<INPUT type="hidden" name="ctId" value="<%=ctId%>">
		<INPUT type="hidden" name="orgSjId" value=",<%=sjId%>">		
		</html:form>
		
	</body>
</html>
<script language='javascript'>
	//alert("dd");
	setHtml();
</script>
<script language="vbscript">
		'新增附件
function AddAttach1()
dim count_obj,tr_obj,td_obj,file_obj,form_obj,count,table_obj
dim button_obj,countview_obj
dim str1,str2

set form_obj=document.getElementById("PublishForm")
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
