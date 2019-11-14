<%@page contentType="text/html; charset=GBK"%>
<%@ page import="com.beyondbit.web.publishinfo.Messages" %>
<script LANGUAGE="javascript" src="./common/common.js"></script>
<%
String strTitle = "信息维护";

//判断是否需要审核
String audit = CTools.dealString(request.getParameter("audit"));
if(!audit.equals(""))
{
  strTitle = "审核";
}
%>
<%@include file="/system/app/skin/head.jsp"%>
<%
CDataCn dCn = null;
CDataImpl dImpl = null;
try{
dCn = new CDataCn();
dImpl = new CDataImpl(dCn);

String sj_id="";//栏目id
sj_id=CTools.dealNumber(request.getParameter("sj_id")).trim();
String subIds = "";   //查询条件子栏目
String psubIds = "";  //党务公开全部子栏目
String selDt_id = "";//部门id
selDt_id = CTools.dealString(request.getParameter("dt_id")).trim();
String dt_id   = CTools.dealString(request.getParameter("ModuleDirIds")).trim();
String dt_name = "";
String dtSql   = "";
String isadmin = CTools.dealString(request.getParameter("isadmin"));
String sjName1 = CTools.dealString(request.getParameter("sjName1"));
//dtSql = "select dt_id,dt_name from tb_deptinfo where 1=1 order by dt_sequence,dt_id desc";
//Vector dtList  = dImpl.splitPage(dtSql,100,1);


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

/*得到当前登陆的用户id  结束*/

/*生成栏目列表  开始*/
String subject_ids="";
String subjectCode="";
String strSql="";
subjectCode=CTools.dealString(request.getParameter("subjectCode")).trim();
String start_date=CTools.dealString(request.getParameter("start_date")).trim();
String end_date=CTools.dealString(request.getParameter("end_date")).trim();
String inputb_date=CTools.dealString(request.getParameter("inputb_date")).trim();
String inpute_date=CTools.dealString(request.getParameter("inpute_date")).trim();
String ct_right=CTools.dealString(request.getParameter("ct_right")).trim();
String CT_title=CTools.dealString(request.getParameter("CT_title")).trim();
String strSelect="";

/*得到是否审核的标志  开始  1=审核  0=该栏目不要审核 */
String NeedAudit="0";
String auditsql="";
Vector vectorPage=null;
Hashtable content = null;
/*得到是否审核的标志  结束*/

String sj_ids="";
      
String sWhere="";

if (!CT_title.equals(""))
	{
		sWhere=sWhere + " and ct_title like '%" + CT_title + "%'";
	}
if (!dt_id.equals(""))
	{
		sWhere=sWhere + " and t.dt_id ='" + dt_id + "'";
	}

if (!start_date.equals(""))
{
	sWhere=sWhere + " and TO_DATE(ct_create_time,'YYYY-MM-DD') >= TO_DATE('"+ start_date +"','YYYY-MM-DD')";
}
if (!end_date.equals(""))
{
	sWhere=sWhere + " and TO_DATE(ct_create_time,'YYYY-MM-DD') <= TO_DATE('"+ end_date +"','YYYY-MM-DD')";
}
if (!inputb_date.equals(""))
{
	sWhere=sWhere + " and TO_DATE(CT_INSERTTIME,'YYYY-MM-DD') >= TO_DATE('"+ inputb_date +"','YYYY-MM-DD')";
}
if (!inpute_date.equals(""))
{
	sWhere=sWhere + " and TO_DATE(CT_INSERTTIME,'YYYY-MM-DD') <= TO_DATE('"+ inpute_date +"','YYYY-MM-DD')";
}
if (!ct_right.equals("z"))
	{
		if (ct_right.equals("1")){
			sWhere=sWhere + " and ct_right = '1'";
		}
		else{
		    sWhere=sWhere + " and (ct_right <> '1' or ct_right is null)";
		}
	}
if(!myProject.getMyName().equals("超级管理员")) sWhere += " and t.ur_id='" + uiid + "'";

strSql = "select sj_id from tb_subject connect by prior sj_id = sj_parentid start with  sj_dir = 'partyopen'";

vectorPage = dImpl.splitPage(strSql,1000,1);
if(vectorPage!=null){
		for(int i=0; i<vectorPage.size(); i++){
			content = (Hashtable)vectorPage.get(i);
			psubIds += content.get("sj_id").toString();
			if(vectorPage.size()!=i+1) psubIds += ",";
		}
	}
if(!sj_id.equals("0")){
	strSql = "select sj_id from tb_subject connect by prior sj_id = sj_parentid start with sj_id = '"+sj_id+"'";
	vectorPage = dImpl.splitPage(strSql,request,230);
	if(vectorPage!=null){
		for(int i=0; i<vectorPage.size(); i++){
			content = (Hashtable)vectorPage.get(i);
			subIds += content.get("sj_id").toString();
			if(vectorPage.size()!=i+1) subIds += ",";
		}
	}
	
	sWhere += "and ct.sj_id in (" + subIds + ")";
}
if(audit.equals(""))
{
  strSql = "select distinct t.sj_name, t.ct_id,t.ct_create_time,t.ct_title,t.ct_updatetime,t.ct_publish_flag,t.dt_id,d.dt_name,ct_sequence,t.sj_id from tb_content t,tb_subject s,tb_deptinfo d,tb_contentpublish ct where t.dt_id=d.dt_id and s.sj_id=ct.sj_id and ct.ct_id=t.ct_id and t.ct_delflag = 0 " + sWhere + " and ct.sj_id in ("+psubIds+")  order by to_date(t.ct_create_time,'YYYY-MM-DD') desc,t.ct_id desc" ;
}
else if (audit.equals("true"))
{
  //strSql = "select t.ct_id,t.ct_create_time,t.ct_publish_flag,t.ct_focus_flag,t.ct_updatetime,t.ct_image_flag,t.ct_message_flag,t.ct_title,t.ct_sequence,t.dt_id,s.sj_name,d.dt_name from tb_content t,tb_subject s,tb_deptinfo d where 1=1 and t.dt_id=d.dt_id and t.sj_id=s.sj_id and t.ct_publish_flag <> 1 "+ sWhere +" and s.sj_id in(select sj_id from tb_auditrole where  tr_id in (select tr_id from tb_roleinfo where tr_userids like '%,"+uiid+",%')) order by to_date(t.ct_create_time,'YYYY-MM-DD') desc,t.ct_id desc";
}

vectorPage = dImpl.splitPageOpt(strSql,request,15);
%>
<%@include file="/system/app/skin/skin4/template/list_top.jsp"%>
<!--    模块名称开始    -->
<%=strTitle%>
<!--    模块名称结束    -->
<%@include file="/system/app/skin/skin4/template/list_function.jsp"%>                                                            
<!--    功能按钮开始    -->
<img src="/system/images/menu_about.gif" border="0" onclick="javascript:window.location.href='publishSearch.jsp' " title="查找" style="cursor:hand" align="absmiddle">查找
<img src="/system/images/goback.gif" border="0" onclick="javascript:history.back();" title="返回" style="cursor:hand" align="absmiddle">返回
<!--    功能按钮结束    -->
<%@include file="/system/app/skin/skin4/template/list_listtop.jsp"%>                                                                                        
<!--    列表开始    -->
<table class="FindAreaTable1" cellspacing="1" rules="cols" border="0" id="ctl00_DataGrid_DataGrid1" style="border-width:0px;">
	<form name="formData">
     <INPUT TYPE="hidden" name="subjectCode" value="<%=subjectCode%>">
     <INPUT TYPE="hidden" name="curpage" value="<%=CTools.dealNumber(request.getParameter("strPage"))%>">
     <INPUT TYPE="hidden" name="audit" value="<%=audit%>">
        <tr class="title1">
            <td colspan="7" align="center">
                <table WIDTH="100%" BORDER="0" CELLSPACING="1" CELLPADDING="1">
                    <tr>
						<td valign="center" align="left">
						  栏目选择：
							<input type="hidden" name="sj_id" class="text-line" style="cursor:hand" value="<%=sj_id%>" />			            
							<input type="text" name="sjName1" class="text-line" style="cursor:hand" onclick="fnSelectSJ2(0,17712);" readonly="true" size="40" value="<%=sjName1%>" />
							<input type="hidden" name="autho_Ids" value="" />
							<input type="hidden" name="autho_Names" value="" />
						</td>
					</tr>
				</table>
  </td>
        </tr>
        <tr class="bttn">
            <td width="26%" class="outset-table">信息主题</td>
			<td width="20%" class="outset-table">发布栏目</td>
            <td width="10%" class="outset-table">发布日期</td>
           
            <td width="16%" class="outset-table">部门</td>
            <td width="20%" class="outset-table">更新时间</td>
            <td width="8%" class="outset-table" nowrap>
            <%
            //if (NeedAudit.equals("1"))
            //{
            //out.print("审核");
            //}
            //else
            //{
            out.print("操作");
            //}
            %>
            </td>
        </tr>
<%
  if(vectorPage!=null)
  {
    for(int j=0;j<vectorPage.size();j++)
    {
      content = (Hashtable)vectorPage.get(j);
      String ct_updatetime = CTools.dealString(content.get("ct_updatetime").toString());
      if(j % 2 == 0)  out.print("<tr class=\"line-even\" id=\"tr"+content.get("ct_id")+"\">");
      else out.print("<tr class=\"line-odd\" id=\"tr"+content.get("ct_id")+"\">");
%>

                <td ><img border="0" src="/system/images/arrow_yellow.gif" WIDTH="15" HEIGHT="13" align='left'>&nbsp;<a href="PublishEdit.jsp?OPType=Edit&ct_id=<%=content.get("ct_id")%>&subjectCode=<%=subjectCode%>&curpage=<%=CTools.dealNumber(request.getParameter("strPage"))%>&audit=<%=audit%>"><%=content.get("ct_title")%></a></td>
				<td align="center" ><%=content.get("sj_name")%></td> 
                <td align="center"><%=content.get("ct_create_time")%></td>                              
                <td align=center><%=content.get("dt_name")%></td>
                 <td align=center><%=ct_updatetime%></td>
                <td align="center"><a href="PublishEdit.jsp?OPType=Edit&ct_id=<%=content.get("ct_id")%>&subjectCode=<%=subjectCode%>&curpage=<%=CTools.dealNumber(request.getParameter("strPage"))%>&audit=<%=audit%>"><img class="hand" border="0" src="
                <%
                if (audit.equals("true"))
                {
                out.print("/system/images/dialog/hammer.gif\" title=审核");
                }
                else
                {
                out.print("/system/images/modi.gif\" title=编辑");
                }
                %>
                  WIDTH="16" HEIGHT="16"></a>
								&nbsp;
								<a href="javascript:delcontent('<%=content.get("ct_id")%>');">
								<img class="hand" border="0" src="../../images/delete.gif" title="删除" WIDTH="16" HEIGHT="16" onclick="return window.confirm('确认要删除该记录么?');"></a>
								</td>
            </tr>

<%
    }
%>
</form>
<%
      //out.println("<tr><td colspan=7>" + dImpl.getTail(request) + "</td></tr>"); //输出尾部文件
  }
  else
  {
    out.println("<tr><td colspan=7>没有记录！</td></tr>");
  }
%>
</table>

<script LANGUAGE="javascript">
	function onChange()
	{
		var sj_id;
		var audit;
                sj_id=formData.sj_id.value;
                audit=formData.audit.value;
		formData.action='publishList.jsp?sj_id='+sj_id+'&audit='+audit;
		formData.submit();
	}

function setSequence()
{
	document.formData.action = "setSequence.jsp";
	document.formData.submit();
}

function delcontent(ctId){
var objhttpPending=new ActiveXObject("Msxml2.XMLHTTP");
	var objxmlPending =	objxmlPending=new ActiveXObject("Microsoft.XMLDOM");
		
		strA = "abc"
		
		objhttpPending.Open("post","<%=Messages.getString("xmlHttp")%>/system/app/pinfopublish/delete.jsp?ct_id=" + ctId ,true);
		objhttpPending.setRequestHeader("Content-Length",strA.length);
		objhttpPending.setRequestHeader("CONTENT-TYPE","application/x-www-form-urlencoded");
		
		
		
		objhttpPending.onreadystatechange = function (){
			var statePending = objhttpPending.readyState; 
		    if (statePending == 4)
		    {
		    	var returnvalue = objhttpPending.responsetext;
		    	alert("删除成功");
				//alert(returnvalue);
		    	if(returnvalue.indexOf("删除成功")!=-1){
		    		//eval("document.all.tr"+ctId+".style.display='none'");
					document.location.reload();
		    	}
			}
		};
		
		objhttpPending.Send(strA);

}
</script>
<!--    列表结束    -->
<%@include file="/system/app/skin/skin4/template/list_bottom.jsp"%> 
<%
}
catch(Exception e){
	System.out.print(e.toString());
}
finally{
	dImpl.closeStmt();
	dCn.closeCn(); 
}
%>
<%@include file="/system/app/skin/bottom.jsp"%>