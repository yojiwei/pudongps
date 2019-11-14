<%@ page contentType="text/html; charset=GBK"%>
<%@include file="/website/include/head_user.jsp"%>
<%@page import="com.website.*"%>
<%
 String keyword="";
 String selectid="";
 String selecttype="";
 String pr_name="";
 String pr_id="";
 String US_ID = "";
 String US_UID = "";
 String cw_id = "";
 String CW_NAME = "";
 String CW_ID = "";
 String UK_ID = "";
 String uk_id = "";
 String strSql_cw1 = "";
 Vector vectorPage1 = null;
 String strSql_cw2 = "";
 Vector vectorPage2 = null;
 String strSql_cw3 = "";
 Vector vectorPage3 = null;
 String list_uk_id = CTools.dealString(request.getParameter("uk_id")).trim();
 String list_cw_id1 = CTools.dealString(request.getParameter("cw_id")).trim();
 String pType = "";
 String dv_id_rq="";
 String sqlStr  = "";

 pType = CTools.dealString(request.getParameter("pType")).trim();
 dv_id_rq=CTools.dealString(request.getParameter("dv_id")).trim();

 //申明变量
CDataCn dCn = null;
CDataImpl dImpl   = null;
String sj_dir = "";
String ct_content = "";
Vector vPage = null;
Hashtable content = null;
try{

dCn = new CDataCn();
dImpl   = new CDataImpl(dCn);
//申明变量结束
 
 
 if(session.getAttribute("user")!=null)
 {
   if(list_uk_id.equals(""))
   {
     User userLeft = (User)session.getAttribute("user");
     //UK_ID=userLeft.getUserKind();
     UK_ID = "o1";
   }
   else
      UK_ID=list_uk_id;
 }
 else
 {
   if(list_uk_id.equals(""))
     UK_ID="o1";
   else
     UK_ID=list_uk_id;

 }
 CW_ID=list_cw_id1;
 String strSql_cw="select cw_id,cw_name from tb_commonwork where uk_id = '" + UK_ID.trim() + "' order by cw_sequence";
 Vector vectorPage = dImpl.splitPage(strSql_cw,10000,1);
 String strSqllj="select cw_name from tb_commonwork where cw_id = '" + CW_ID.trim() + "' order by cw_sequence";
 Vector vectorPagelj = dImpl.splitPage(strSqllj,10000,1);
  if(UK_ID.equals("o1")){
 strSql_cw1="select cw_id,cw_name from tb_commonwork where uk_id = 'o2' order by cw_sequence";
 vectorPage1 = dImpl.splitPage(strSql_cw1,10000,1);
 strSql_cw2="select cw_id,cw_name from tb_commonwork where uk_id = 'o3' order by cw_sequence";
 vectorPage2 = dImpl.splitPage(strSql_cw2,10000,1);
 strSql_cw3="select cw_id,cw_name from tb_commonwork where uk_id = 'o11' order by cw_sequence";
 vectorPage3 = dImpl.splitPage(strSql_cw3,10000,1);
 }
 if(UK_ID.equals("o2")){
 strSql_cw1="select cw_id,cw_name from tb_commonwork where uk_id = 'o1' order by cw_sequence";
 vectorPage1 = dImpl.splitPage(strSql_cw1,10000,1);
 strSql_cw2="select cw_id,cw_name from tb_commonwork where uk_id = 'o3' order by cw_sequence";
 vectorPage2 = dImpl.splitPage(strSql_cw2,10000,1);
 strSql_cw3="select cw_id,cw_name from tb_commonwork where uk_id = 'o11' order by cw_sequence";
 vectorPage3 = dImpl.splitPage(strSql_cw3,10000,1);
 }
 if(UK_ID.equals("o3")){
 strSql_cw1="select cw_id,cw_name from tb_commonwork where uk_id = 'o1' order by cw_sequence";
 vectorPage1 = dImpl.splitPage(strSql_cw1,10000,1);
 strSql_cw2="select cw_id,cw_name from tb_commonwork where uk_id = 'o2' order by cw_sequence";
 vectorPage2 = dImpl.splitPage(strSql_cw2,10000,1);
 strSql_cw3="select cw_id,cw_name from tb_commonwork where uk_id = 'o11' order by cw_sequence";
 vectorPage3 = dImpl.splitPage(strSql_cw3,10000,1);
 }
 if(UK_ID.equals("o11")){
 strSql_cw1="select cw_id,cw_name from tb_commonwork where uk_id = 'o1' order by cw_sequence";
 vectorPage1 = dImpl.splitPage(strSql_cw1,10000,1);
 strSql_cw2="select cw_id,cw_name from tb_commonwork where uk_id = 'o2' order by cw_sequence";
 vectorPage2 = dImpl.splitPage(strSql_cw2,10000,1);
 strSql_cw3="select cw_id,cw_name from tb_commonwork where uk_id = 'o3' order by cw_sequence";
 vectorPage3 = dImpl.splitPage(strSql_cw3,10000,1);
}
//在此取出特别推荐和常见问题解答

 String sqlStr_error = "select * from tb_datavalue where dd_id='130'";
 String   sqlStr_uk = "select sg_id,sg_name,sg_url from tb_suggest where us_kind='"+UK_ID+"' order by sg_sequence";
 String sqlStr_uk1="";
if(!dv_id_rq.equals("")){
  sqlStr_uk1 = "select qu_id,qu_title from tb_question where us_kind='"+UK_ID+"' and qu_error='"+dv_id_rq+"' order by qu_sequence";
}else{
  sqlStr_uk1 = "select qu_id,qu_title from tb_question where us_kind='"+UK_ID+"' order by qu_sequence ";
 }
 //注释结束
 String strSql_rc="select * from tb_recommend order by rc_sequence, rc_time desc ";
 Vector vectorRec = dImpl.splitPage(strSql_rc,10000,1);

 String strSql_dept = "select dt_id,dt_name from tb_deptinfo where dt_iswork = 1 order by dt_name, dt_sequence";
 Vector vectorDept = dImpl.splitPage(strSql_dept,10000,1);

 String strSql_sw = "select * from tb_sortwork order by sw_sequence";
 Vector vectorSw = dImpl.splitPage(strSql_sw,10000,1);

keyword = CTools.dealString(request.getParameter("keyword"));
selectid = CTools.dealString(request.getParameter("selectcontent"));
selecttype = CTools.dealString(request.getParameter("selecttype"));

//CDataCn dCn = new CDataCn();
//CDataImpl dImpl = new CDataImpl(dCn);
/*
String sql_ondept = " select tb_proceeding.pr_name, tb_proceeding.pr_id from tb_proceeding, tb_commonwork, tb_sortwork, tb_commonproceed where ((tb_proceeding.pr_id=tb_commonproceed.pr_id and tb_commonproceed.cw_id=tb_commonwork.cw_id) or tb_proceeding.sw_id=tb_sortwork.sw_id) and tb_proceeding.dt_idext="+selectid;

String sql_onwork = " select tb_proceeding.pr_name, tb_proceeding.pr_id from tb_proceeding, tb_commonwork, tb_sortwork, tb_commonproceed where ((tb_proceeding.pr_id=tb_commonproceed.pr_id and tb_commonproceed.cw_id=tb_commonwork.cw_id) or tb_proceeding.sw_id=tb_sortwork.sw_id) and tb_proceeding.sw_id='"+selectid+"' ";

String sql_alldept = " select tb_proceeding.pr_name, tb_proceeding.pr_id from tb_proceeding, tb_commonwork, tb_sortwork, tb_commonproceed  where ((tb_proceeding.pr_id=tb_commonproceed.pr_id and tb_commonproceed.cw_id=tb_commonwork.cw_id) or tb_proceeding.sw_id=tb_sortwork.sw_id) and tb_proceeding.dt_idext is not null ";

String sql_allwork = " select tb_proceeding.pr_name, tb_proceeding.pr_id from tb_proceeding, tb_commonwork, tb_sortwork, tb_commonproceed  where ((tb_proceeding.pr_id=tb_commonproceed.pr_id and tb_commonproceed.cw_id=tb_commonwork.cw_id) or tb_proceeding.sw_id=tb_sortwork.sw_id) and tb_proceeding.sw_id is not null ";

String sql_all = " select tb_proceeding.pr_name, tb_proceeding.pr_id from tb_proceeding, tb_commonwork, tb_sortwork, tb_commonproceed where ((tb_proceeding.pr_id=tb_commonproceed.pr_id and tb_commonproceed.cw_id=tb_commonwork.cw_id) or tb_proceeding.sw_id=tb_sortwork.sw_id) or ";
*/
String sql_ondept = " select tb_proceeding.pr_name, tb_proceeding.pr_id from tb_proceeding where tb_proceeding.pr_isdel is null and tb_proceeding.dt_idext="+selectid;

String sql_onwork = " select tb_proceeding.pr_name, tb_proceeding.pr_id from tb_proceeding where tb_proceeding.pr_isdel is null and tb_proceeding.sw_id='"+selectid+"' ";

String sql_alldept = " select tb_proceeding.pr_name, tb_proceeding.pr_id from tb_proceeding where tb_proceeding.pr_isdel is null and tb_proceeding.dt_idext is not null ";

String sql_allwork = " select tb_proceeding.pr_name, tb_proceeding.pr_id from tb_proceeding where tb_proceeding.pr_isdel is null and tb_proceeding.sw_id is not null ";

String sql_all = " select tb_proceeding.pr_name distinct, tb_proceeding.pr_id from tb_proceeding where tb_proceeding.pr_isdel is null and";

if(!keyword.equals("输入关键字"))
{
	String [] kwArray = CTools.splite(keyword, " ");
	if(kwArray.length != 0){
		
		sql_all = "select tb_proceeding.pr_name, tb_proceeding.pr_id from tb_proceeding where tb_proceeding.pr_isdel is null and (tb_proceeding.dt_idext<>'57' or (tb_proceeding.dt_id='57' and tb_proceeding.dt_idext=tb_proceeding.dt_id)) and ((tb_proceeding.pr_id in (select tb_commonproceed.pr_id from tb_commonproceed, tb_commonwork where tb_commonproceed.cw_id=tb_commonwork.cw_id and (";

		String cwTempStr = "";
		String swTempStr = "";
		
		for(int j = 0; j < kwArray.length; j++){
			if(j != kwArray.length - 1){
				cwTempStr += "tb_commonwork.cw_name='" + kwArray[j] + "' or ";
				swTempStr += "tb_sortwork.sw_name='" + kwArray[j] + "' or ";
			}
			else {
				cwTempStr += "tb_commonwork.cw_name='" + kwArray[j] + "' ";
				swTempStr += "tb_sortwork.sw_name='" + kwArray[j] + "' ";
			}
		}
		sql_all += cwTempStr + "))) or (tb_proceeding.pr_id in (select tb_proceeding.pr_id from tb_proceeding, tb_sortwork where tb_proceeding.sw_id=tb_sortwork.sw_id and (" + swTempStr + "))) or";
		sql_ondept += " and (";
		sql_onwork += " and (";
		sql_allwork += " and (";
		sql_alldept += " and (";
		sql_all += " (";
		for(int k = 0; k < kwArray.length; k++){
			if(k != kwArray.length - 1){
				sql_ondept += " tb_proceeding.pr_name like '%" + kwArray[k] + "%' or";
				sql_onwork += " tb_proceeding.pr_name like '%" + kwArray[k] + "%' or";
				sql_allwork += " tb_proceeding.pr_name like '%" + kwArray[k] + "%' or";
				sql_alldept += " tb_proceeding.pr_name like '%" + kwArray[k] + "%' or";
				sql_all += " tb_proceeding.pr_name like '%" + kwArray[k] + "%' or";
			}
			else {
				sql_ondept += " tb_proceeding.pr_name like '%" + kwArray[k] + "%')";
				sql_onwork += " tb_proceeding.pr_name like '%" + kwArray[k] + "%')";
				sql_allwork += " tb_proceeding.pr_name like '%" + kwArray[k] + "%')";
				sql_alldept += " tb_proceeding.pr_name like '%" + kwArray[k] + "%')";
				sql_all += " tb_proceeding.pr_name like '%" + kwArray[k] + "%')";
			}
		}
		
		//System.out.println("selecttype:" + selecttype);
		if("0".equals(selecttype)){
			sql_ondept += ")";
			sql_onwork += ")";
			sql_allwork += ")";
			sql_alldept += ")";
			sql_all += ")";
		}
		
		/*
		sql_ondept += " and pr_name like '%"+keyword+"%' ";
		sql_onwork += " and pr_name like '%"+keyword+"%' ";
		sql_allwork += " and pr_name like '%"+keyword+"%' ";
		sql_alldept += " and pr_name like '%"+keyword+"%' ";
		sql_all += " where pr_name like '%"+keyword+"%' ";
		*/
		//System.out.println("1:" + sql_ondept);
		//System.out.println("2:" + sql_onwork);
		//System.out.println("3:" + sql_allwork);
		//System.out.println("4:" + sql_alldept);
		//sql_all= "select tb_proceeding.pr_name, tb_proceeding.pr_id from tb_proceeding where (tb_proceeding.pr_id in (select tb_commonproceed.pr_id from tb_commonproceed, tb_commonwork where tb_commonproceed.cw_id=tb_commonwork.cw_id and (tb_commonwork.cw_name='其他' ))) or (tb_proceeding.pr_id in (select tb_proceeding.pr_id from tb_proceeding, tb_sortwork where tb_proceeding.sw_id=tb_sortwork.sw_id and (tb_sortwork.sw_name='其他' )))";
		//sql_all= "select tb_proceeding.pr_name, tb_proceeding.pr_id from tb_proceeding where (tb_proceeding.pr_id in (select tb_proceeding.pr_id from tb_proceeding, tb_sortwork where tb_proceeding.sw_id=tb_sortwork.sw_id and (tb_sortwork.sw_name='其他' )))";
		
		//System.out.println(sql_all);
		//
	}
}
sql_ondept += " order by pr_sequence,pr_id";
sql_onwork += " order by pr_sequence,pr_id";
sql_allwork += " order by pr_sequence,pr_id";
sql_alldept += " order by pr_sequence,pr_id";
sql_all += " order by pr_sequence,pr_id";
%>
<script language="javascript">
var dt_id = new Array;
var dt_name =new Array;

dt_id[0]="0";
dt_name[0]="所有部门";

<%
if(vectorDept!=null)
{
  for(int j=0;j<vectorDept.size();j++)
  {
    content = (Hashtable)vectorDept.get(j);
%>
dt_id[<%=j+1%>]="<%=content.get("dt_id").toString()%>";
dt_name[<%=j+1%>]="<%=content.get("dt_name").toString()%>";
<%
  }
}
%>

//开始分类办事
var sw_id = new Array;
var sw_name = new Array;

sw_id[0]="0";
sw_name[0]="所有分类";

<%
if(vectorSw!=null)
{
  for(int j=0;j<vectorSw.size();j++)
  {
    content = (Hashtable)vectorSw.get(j);
%>
sw_id[<%=j+1%>]="<%=content.get("sw_id").toString()%>";
sw_name[<%=j+1%>]="<%=content.get("sw_name").toString()%>";
<%
  }
}
%>

function fnChangeSelect(iIndex)
{

  //首先删除所有selectcontent的内容

  for(var j=document.formSearch.selectcontent.length;j>=0;j--)
  {
      document.formSearch.selectcontent.options.remove(j);
  }

  if(iIndex=="1") //如果选择了部门办事
  {

    for(var i=0;i<dt_id.length;i++)
    {
      var oOption = document.createElement("OPTION");
      oOption.text=dt_name[i];
      oOption.value=dt_id[i];
      if(typeof(document.formSearch.selectcontent)!="undefined")
      {
        document.formSearch.selectcontent.add(oOption);
      }
    }

  }

  else if(iIndex=="2")
  {

    for(var i=0;i<sw_id.length;i++)
    {
      var oOption = document.createElement("OPTION");
      oOption.text=sw_name[i];
      oOption.value=sw_id[i];
      if(typeof(document.formSearch.selectcontent)!="undefined")
      {
        document.formSearch.selectcontent.add(oOption);
      }
    }
  }

  else if(iIndex=="0")
  {
    var oOption = document.createElement("OPTION");
    oOption.text="请选择";
    oOption.value="0";
    if(typeof(document.formSearch.selectcontent)!="undefined")
    {
      document.formSearch.selectcontent.add(oOption);
    }
  }
}

function checkForm()
{
        var keyword_ok = formSearch.keyword.value;
        if(formSearch.selectcontent.value=="0" && (keyword_ok==""||keyword_ok=="输入关键字"))
        {
                alert("请填写搜索关键字！");
                formSearch.keyword.focus();
                return false;
        }
                var select_type = formSearch.selecttype.value;
                /*if(select_type=="0")
                {
                                alert("请选择搜索方式！");
                                formSearch.selecttype.focus();
                                return false;
                }*/
                formSearch.submit();
}
</script>

<table width="746" border="0" cellspacing="0" cellpadding="0" align="center">
<tr><td height="5"></td></tr></table>
<table width="746" border="1" cellspacing="0" cellpadding="0" bordercolor="#C0C0C0" align="center">
  <tr><td>
  <table border="0" cellspacing="0" width="100%" cellpadding="0">
    <tr>
      <td height="5" colspan="7">
        <table border="0" cellpadding="0" cellspacing="0" width="100%">
          <tr>
            <td width="100%" height="40">
                 &nbsp;&nbsp;&nbsp; <a href="<%=_WEBSTART%>/website/index.jsp"><font color="#ACACAC">首页</font></a>
                                              <font color="#ACACAC">&gt;&gt;</font>
                                              <a href="/website/usercenter/List.jsp"><font color="#ACACAC">办事大厅</font></a><%
                                                if(pType.equals("search"))
                                                   {%>
                                              <font color="#ACACAC">&gt;&gt;</font>
                                                         <font color="#ACACAC">搜索结果</font><%}
                                                else
                                                           {if(UK_ID.equals("o1"))
                                                        {%>
                                              <font color="#ACACAC">&gt;&gt;</font>
                                                         <a href="/website/usercenter/List.jsp?uk_id=o1"><font color="#ACACAC">市民办事</font></a><%}
                                                          if(UK_ID.equals("o2"))
                                                        {%>
                                              <font color="#ACACAC">&gt;&gt;</font>
                                                         <a href="/website/usercenter/List.jsp?uk_id=o2"><font color="#ACACAC">企业办事</font></a><%}
                                                          if(UK_ID.equals("o3"))
                                                        {%>
                                              <font color="#ACACAC">&gt;&gt;</font>
                                                         <a href="/website/usercenter/List.jsp?uk_id=o3"><font color="#ACACAC">投资创业</font></a><%}
                                                          if(UK_ID.equals("o11"))
                                                        {%>
                                              <font color="#ACACAC">&gt;&gt;</font>
                                                         <a href="/website/usercenter/List.jsp?uk_id=o11"><font color="#ACACAC">特别关爱</font></a><%}}

                                                   %><%if(vectorPagelj!=null)
                             {
                                 content = (Hashtable)vectorPagelj.get(0);
              CW_NAME=content.get("cw_name").toString();%>
                                              <font color="#ACACAC">&gt;&gt;</font>
                                                         <font color="#ACACAC"><%=CW_NAME%><%}%></font></td>
          </tr>
          <tr>
            <td width="100%" height="1"><table border="0" cellpadding="0" cellspacing="0" width="100%">
                <tr>
                  <td width="186" background="/website/images/toplj.gif"></td><td width="558"></td></tr>
              </table>
            </td>
          </tr>
        </table>
      </td>
    </tr>
    <tr>
      <td width="4" height="3"></td>
      <td width="178" height="3"></td>
      <td width="4" height="3"></td>
      <td width="1" height="3" background="../images/pint.gif"></td>
      <td width="7" height="3"></td>
      <td width="543" height="3"></td>
      <td width="7" height="3"></td>
    </tr>
    <tr>
      <td width="4"></td>
      <td width="178" valign="top">
      <table border="0" cellpadding="0" cellspacing="0" width="100%" height="100%">
        <tr>
          <td width="100%" valign="top">
          <table border="0" cellpadding="0" cellspacing="0" width="100%">
<tr>
          <td width="178" height="17" colspan="2" background="../images/left_logo1.gif">
                                           <%
                                   if(UK_ID.equals("o1")){%>&nbsp;&nbsp;&nbsp;<font size="2" color="#FFFFFF">企业办事</font><%}
                                   if(UK_ID.equals("o2")){%>&nbsp;&nbsp;&nbsp;<font size="2" color="#FFFFFF">市民办事</font><%}
                                   if(UK_ID.equals("o3")){%>&nbsp;&nbsp;&nbsp;<font size="2" color="#FFFFFF">市民办事</font><%}
                                   if(UK_ID.equals("o11")){%>&nbsp;&nbsp;&nbsp;<font size="2" color="#FFFFFF">市民办事</font><%}
%>
       </td>
        </tr>
          <tr>
          <td width="178" height="5" colspan="2"></td>
        </tr>
                <tr>
          <td width="8"> </td>
          <td width="170">
          <table border="0" cellpadding="0" cellspacing="0" width="100%">
            <tr>
              <%
                           if(vectorPage1!=null)
                             {
                               for(int j=0;j<vectorPage1.size();j++)
                                 {
                                   content = (Hashtable)vectorPage1.get(j);
                                   CW_NAME=content.get("cw_name").toString();
                                   cw_id = content.get("cw_id").toString();
                                   if(UK_ID.equals("o1")){
                                    uk_id=("o2");
                                   }
                                    if(UK_ID.equals("o2")){
                                    uk_id=("o1");
                                    }
                                    if(UK_ID.equals("o3")){
                                    uk_id=("o1");
                                    }
                                    if(UK_ID.equals("o11")){
                                    uk_id=("o1");
                                    }
                                   %>
                        <td width="170"> · <a href="List.jsp?cw_id=<%=cw_id%>&uk_id=<%=uk_id%>"><font color=""#B49F66""><%=CW_NAME%></font></a></td></tr><tr><td height="3"></td>
                                    <%if(j==0){%></tr><tr><%}
                                    if(j==1){%></tr><tr><%}
                                    if(j==2){%></tr><tr><%}
                                    if(j==3){%></tr><tr><%break;}
                               }
                                 }%></tr><tr><td align="right"><%
                                   if(UK_ID.equals("o1")){
                                    uk_id=("o2");
                                   }
                                    if(UK_ID.equals("o2")){
                                    uk_id=("o1");
                                    }
                                    if(UK_ID.equals("o3")){
                                    uk_id=("o1");
                                    }
                                    if(UK_ID.equals("o11")){
                                    uk_id=("o1");
                                    }
                                    %>>>&nbsp;&nbsp;<a href="List.jsp?uk_id=<%=uk_id%>"><font color=""#B49F66"">更多</font></a>&nbsp;&nbsp;&nbsp;&nbsp;</td></tr><tr><td height="7">  </td></table>
          </td>
        </tr><tr>
          <td width="178" height="17" colspan="2" background="../images/left_logo1.gif">
                                           <%
                                   if(UK_ID.equals("o1")){%>&nbsp;&nbsp;&nbsp;<font size="2" color="#FFFFFF">投资创业</font><%}
                                   if(UK_ID.equals("o2")){%>&nbsp;&nbsp;&nbsp;<font size="2" color="#FFFFFF">投资创业</font><%}
                                   if(UK_ID.equals("o3")){%>&nbsp;&nbsp;&nbsp;<font size="2" color="#FFFFFF">企业办事</font><%}
                                   if(UK_ID.equals("o11")){%>&nbsp;&nbsp;&nbsp;<font size="2" color="#FFFFFF">企业办事</font><%}
                                    %>
       </td>
        </tr>
          <tr>
          <td width="178" height="5" colspan="2"></td>
        </tr>
                <tr>
          <td width="8">　</td>
          <td width="170">
          <table border="0" cellpadding="0" cellspacing="0" width="100%">
            <tr>
              <%
                           if(vectorPage2!=null)
                             {
                               for(int j=0;j<vectorPage2.size();j++)
                                 {
                                   content = (Hashtable)vectorPage2.get(j);
                                   CW_NAME=content.get("cw_name").toString();
                                   cw_id = content.get("cw_id").toString();
                                   if(UK_ID.equals("o1")){
                                  uk_id=("o3");
                                 }
                                  if(UK_ID.equals("o2")){
                                  uk_id=("o3");
                                  }
                                  if(UK_ID.equals("o3")){
                                  uk_id=("o2");
                                  }
                                  if(UK_ID.equals("o11")){
                                  uk_id=("o2");
                                    }
                                   %>
                        <td width="170"> · <a href="List.jsp?cw_id=<%=cw_id%>&uk_id=<%=uk_id%>"><font color=""#B49F66""><%=CW_NAME%></font></a></td></tr><tr><td height="3"></td>
                                    <%if(j==0){%></tr><tr><%}
                                    if(j==1){%></tr><tr><%}
                                    if(j==2){%></tr><tr><%}
                                    if(j==3){%></tr><tr><%break;}
                               }
                                 }%></tr><tr><td align="right"><%
                                   if(UK_ID.equals("o1")){
                                  uk_id=("o3");
                                 }
                                  if(UK_ID.equals("o2")){
                                  uk_id=("o3");
                                  }
                                  if(UK_ID.equals("o3")){
                                  uk_id=("o2");
                                  }
                                  if(UK_ID.equals("o11")){
                                  uk_id=("o2");
                                    }
                                    %>>>&nbsp;&nbsp;<a href="List.jsp?uk_id=<%=uk_id%>"><font color=""#B49F66"">更多</font></a>&nbsp;&nbsp;&nbsp;&nbsp;</td></tr><tr><td height="7">  </td></table>
          </td>
        </tr>
        <tr>
          <td width="178" height="17" colspan="2" background="../images/left_logo1.gif">
                                           <%
                                   if(UK_ID.equals("o1")){%>&nbsp;&nbsp;&nbsp;<font size="2" color="#FFFFFF">特别关爱</font><%}
                                   if(UK_ID.equals("o2")){%>&nbsp;&nbsp;&nbsp;<font size="2" color="#FFFFFF">特别关爱</font><%}
                                   if(UK_ID.equals("o3")){%>&nbsp;&nbsp;&nbsp;<font size="2" color="#FFFFFF">特别关爱</font><%}
                                   if(UK_ID.equals("o11")){%>&nbsp;&nbsp;&nbsp;<font size="2" color="#FFFFFF">投资创业</font><%}%>
       </td>
        </tr>
          <tr>
          <td width="178" height="5" colspan="2"></td>
        </tr>
                <tr>
          <td width="8">　</td>
          <td width="170">
          <table border="0" cellpadding="0" cellspacing="0" width="100%">
            <tr>
              <%
                           if(vectorPage3!=null)
                             {
                               for(int j=0;j<vectorPage3.size();j++)
                                 {
                                   content = (Hashtable)vectorPage3.get(j);
                                   CW_NAME=content.get("cw_name").toString();
                                   cw_id = content.get("cw_id").toString();
                                   if(UK_ID.equals("o1")){
                                   uk_id=("o11");
                                   }
                                   if(UK_ID.equals("o2")){
                                    uk_id=("o11");
                                  }
                                  if(UK_ID.equals("o3")){
                                  uk_id=("o11");
                                  }
                                  if(UK_ID.equals("o11")){
                                  uk_id=("o3");
                                    }
                                   %>
                        <td width="170"> · <a href="List.jsp?cw_id=<%=cw_id%>&uk_id=<%=uk_id%>"><font color=""#B49F66""><%=CW_NAME%></font></a></td></tr><tr><td height="3"></td>
                                    <%if(j==0){%></tr><tr><%}
                                    if(j==1){%></tr><tr><%}
                                    if(j==2){%></tr><tr><%}
                                    if(j==3){%></tr><tr><%break;}
                               }
                                 }%></tr><tr><td align="right"><%
                                   if(UK_ID.equals("o1")){
                                   uk_id=("o11");
                                   }
                                   if(UK_ID.equals("o2")){
                                    uk_id=("o11");
                                  }
                                  if(UK_ID.equals("o3")){
                                  uk_id=("o11");
                                  }
                                  if(UK_ID.equals("o11")){
                                  uk_id=("o3");
                                    }
                                    %>>>&nbsp;&nbsp;<a href="List.jsp?uk_id=<%=uk_id%>"><font color=""#B49F66"">更多</font></a>&nbsp;&nbsp;&nbsp;&nbsp;</td></tr><tr><td height="7">  </td>
          </table>
          </td>
        </tr>
        </table>
          </td>
        </tr>
        <tr>
          <td width="100%" valign="bottom">
<table width="178" border="0" cellspacing="0" cellpadding="0">
        <tr>
                <td width="178" valign="top">
                        <table width="178" border="0" cellspacing="0" cellpadding="0">

                                <form name="formSearch" action="../usercenter/List.jsp?pType=search" method="post">
                                <tr>
                                        <td height="20" background="../images/left_logo1.gif">&nbsp;&nbsp;&nbsp;<font size="2" color="white">办事检索</font></td>
                                </tr>
                                <tr>
                                        <td height="7"> </td>
                                </tr>
                                <tr height="20">
                                        <td>&nbsp;
                                                <select style="width:120px;border:1px solid #C0C0C0; color: #38529C; padding-top: 0; background-color: #FFFFFF" name="selecttype" onChange="javascript:fnChangeSelect(this.selectedIndex)">
                                                        <option value="0">请选择搜索方式</option>
                                                        <option value="1">按办事机构</option>
                                                        <option value="2">按分类办事</option>
                                                </select>
                                        </td>
                                </tr>
                                <tr>
                                        <td height="5"> </td>
                                </tr>
                                <tr height="20">
                                                            <td>&nbsp;
            <select style="width:120px;color: #38529C; padding-top: 0; background-color: #FFFFFF" name="selectcontent">
              <option value="0">请选择</option>
            </select>
                                        </td>
                                </tr>
                                <tr>
                                        <td height="3"> </td>
                                </tr>
                                <tr height="20" valign="middle">
                                        <td>&nbsp;
                                                <input type="text" name="keyword" size="12" style="color: #38529C; border: 1px solid #C0C0C0; padding: 0; background-color: #FFFFFF" onMouseOver="this.focus()"  onFocus="this.select()" value="输入关键字" onclick=this.value="">
                                                <img src="/website/extent/images/search.gif" style="cursor:hand" width="17" height="17" onclick="checkForm()">&nbsp;
                                        </td>
                                </tr>
                          </form>
            </table>
                </td>
        </tr>
</table></td>
        </tr>
      </table>
      </td>
      <td width="4">　</td>
      <td width="1" background="../images/pint.gif">　</td>
      <td width="7">　</td>
      <td width="543"valign="top">
      <table border="1" cellpadding="0" cellspacing="0" style="border-collapse: collapse" width="100%" bordercolor="#B49F66" height="100%">
        <tr>
          <td width="418" height="22" bgcolor="#B49F66">&nbsp;&nbsp;
                                    <%if(UK_ID.equals("o1"))
                                    {%>市民办事<%}
                                      if(UK_ID.equals("o2")){
                                      %>企业办事<%}
                                        if(UK_ID.equals("o3")){
                                      %>投资创业<%}
                                        if(UK_ID.equals("o11")){
                                      %>特别关爱<%}%>
</td>
          <td width="125" height="22" bgcolor="#B49F66">　</td>
        </tr>
         <tr>
          <td width="418" height="4" background="../images/pint3.gif">　</td>
          <td width="125" height="4" background="../images/pint3.gif">　</td>
        </tr>
                <tr>
          <td width="418" height="16" background="../images/pint2.gif">
<table width="418" border="0" cellspacing="2" cellpadding="0"><tr><td width="8"></td><td width="410">
<table width="100%" border="0" cellspacing="2" cellpadding="0">
<%
                 if(vectorPage!=null)
                 {
                          for(int j=0;j<vectorPage.size();j++)
                          {
                                content = (Hashtable)vectorPage.get(j);
                                CW_NAME=content.get("cw_name").toString();
                                cw_id = content.get("cw_id").toString();
                                if(UK_ID.equals("o1")){
                                   uk_id=("o1");
                                   }
                                   if(UK_ID.equals("o2")){
                                    uk_id=("o2");
                                  }
                                  if(UK_ID.equals("o3")){
                                  uk_id=("o3");
                                  }
                                  if(UK_ID.equals("o11")){
                                  uk_id=("o11");
                                    }
                                                                %>
                                  <%if(UK_ID.equals("o1")){
                                     if(j%7==0)
                                     {
                                      %><tr><%
                                     }
                                     %>
                                     <td><a href="List.jsp?cw_id=<%=cw_id%>&uk_id=<%=uk_id%>"><font color=""#B49F66""><%=CW_NAME%></font></a></td>
                                     <%
                                     if(j%7==6||j==vectorPage.size()-1)
                                     {
                                      %></tr><%
                                     }
                                    }
                                      if(UK_ID.equals("o2")){
                                       if(j%5==0)
                                      {
                                      %><tr><%
                                     }
                                    %>
                                     <td><a href="List.jsp?cw_id=<%=cw_id%>&uk_id=<%=uk_id%>"><font color=""#B49F66""><%=CW_NAME%></font></a></td>
                                     <%
                                      if(j%5==4||j==vectorPage.size()-1)
                                     {
                                      %></tr><%
                                     }
                                     }
                                      if(UK_ID.equals("o3")){
                                       if(j % 4 == 0)
                                        {
                                        %><tr><%
                                        }
                                        %>
                                       <td><a href="List.jsp?cw_id=<%=cw_id%>&uk_id=<%=uk_id%>"><font color=""#B49F66""><%=CW_NAME%></font></a></td>
                                       <%
                                        if(j%4==3||j==vectorPage.size()-1)
                                        {
                                         %></tr><%
                                        }
                                        }
                                        if(UK_ID.equals("o11")){
                                         if(j % 6 == 0)
                                         {
                                         %><tr><%
                                        }
                                        %>
                                        <td><a href="List.jsp?cw_id=<%=cw_id%>&uk_id=<%=uk_id%>"><font color=""#B49F66""><%=CW_NAME%></font></a></td>
                                        <%
                                        if(j%6==5||j==vectorPage.size()-1)
                                        {
                                         %></tr><%
                                        }
                                      }
                                 }
                                 }%></table></td></tr></table></td>
          <td width="125" height="16" background="../images/pint3.gif">
          <table border="0" cellpadding="0" cellspacing="0" width="100%">
            <tr>
              <td width="100%" align="center"><img border="0" src="../images/happy.gif" width="16" height="16"><a href="/website/consultation/AppealInfo.jsp"><img border="0" src="../images/woyzx.gif" width="70" height="15"></a></td>
            </tr>
            <tr>
              <td width="100%" height="3"></td>
            </tr>
            <tr>
              <td width="100%" align="center"><img border="0" src="../images/unhappy.gif" width="16" height="16"><a href="/website/connection/SuperviseMain.jsp?PType=doing"><img border="0" src="../images/woyts.gif" width="70" height="15"></a></td>
            </tr>
			<tr>
              <td width="100%" height="3"></td>
            </tr>
            <!--tr>
              <td width="100%" align="center"><img border="0" src="../images/face.gif" width="16" height="16"><a onclick="javascript:window.open('/website/feedback/detial.jsp','','Top=0,Left=0,Width=280,Height=300');" style="cursor:hand"><font color=""#B49F66""><img border="0" src="../images/woyfk.gif" width="70" height="15"></font></a></td>
            </tr-->
          </table>
          </td>
        </tr>
        <tr>
          <td width="543" height="4" colspan="2" bgcolor="#B49F66"></td>
        </tr>
        <tr>
          <td width="543" height="40" colspan="2">
          <table border="0" cellpadding="0" cellspacing="0" width="100%" height="100%">
            <tr>
              <td width="543" height="76" background="../images/temp.gif" colspan="2" valign="top">&nbsp;&nbsp;
            <%
                                     //列表开始
                                     if(pType.equals(""))
                                     {
                                                                        sqlStr  = "";
                                                                        String list_cw_id = CTools.dealString(request.getParameter("cw_id")).trim();
                                                                        if (list_cw_id.equals(""))
                                                                        {
                                                                        //sqlStr = "select a.pr_id,a.pr_name from tb_proceeding a,tb_commonproceed b,tb_commonwork c where c.uk_id='"+UK_ID+"' and a.pr_id=b.pr_id and b.cw_id=c.cw_id";
                                                                        sqlStr = "select pr_id ,pr_name from tb_proceeding where  pr_isdel is null and pr_id in(select distinct b.pr_id from tb_commonwork a,tb_commonproceed b where a.uk_id='"+UK_ID+"'and a.cw_id=b.cw_id) order by pr_sequence,to_number(substr(pr_id,2)) desc ";
                                                                        if(UK_ID.equals("o1")){
                                                                        %>市民办事<%}
                                                                         if(UK_ID.equals("o2")){
                                                                          %>企业办事<%}
                                                                         if(UK_ID.equals("o3")){
                                                                         %>投资创业<%}
                                                                          if(UK_ID.equals("o11")){
                                                                         %>特别关爱<%}%></td></tr><%}
                                                                        else
                                                                           {if(vectorPagelj!=null)
                                                                                {
                                                                                content = (Hashtable)vectorPagelj.get(0);
                                                                        CW_NAME=content.get("cw_name").toString();%><%=CW_NAME%><%}
                                                                        sqlStr = "select a.pr_id,a.pr_name from tb_proceeding a,tb_commonproceed b,tb_commonwork c where a.pr_isdel is null and c.cw_id='"+list_cw_id+"' and a.pr_id=b.pr_id and b.cw_id=c.cw_id order by a.pr_sequence,to_number(substr(a.pr_id,2)) desc ";
                                                                        }
	//out.println(sqlStr);
                                                                        vPage = dImpl.splitPage(sqlStr,request,20);
                                                                        if (vPage!=null)
                                                                        {
                                                                                for (int i=0;i<vPage.size();i++)
                                                                                {
                                                                                        content = (Hashtable)vPage.get(i);
                                                                                        pr_name = content.get("pr_name").toString();

                                                                                        pr_id   = content.get("pr_id").toString();
                                                                                        %>
                                                                                        <tr width="543">
                                                                                                <td width="23">　</td>
                                                                                                <td width="520" align="left">· <a href="ProjectDetail.jsp?pr_id=<%=pr_id%>"><%=pr_name%></a>  </td>
                                                                                        </tr>
                                                                                        <%
                                                                                }
                                                                                %>
                                                                                <tr>
              <td width="543" height="10"colspan="2" align="center"></td>
            </tr>
            <tr>
              <td width="543" height="21" background="../images/pint3.gif" colspan="2" align="center" valign="bottom"><table><tr><td><%=dImpl.getTail(request)%></td></tr></table></td>
            </tr>
                                                                                <%
                                                                        }
                                                     }
                                                     else if(pType.equals("search"))
                                                     {
                                                             out.print("搜索结果");
                                                                            if(selectid.equals("0")&&selecttype.equals("0"))
                                                                        {
                                                                                Vector vectoralldept = dImpl.splitPage(sql_all,request,20);

                                                                                if(vectoralldept!=null)
                                                                                {

																						for(int i=0;i<vectoralldept.size();i++)
                                                                                        {
                                                                                                content = (Hashtable)vectoralldept.get(i);
                                                                                                pr_name = content.get("pr_name").toString();
                                                                                                pr_id   = content.get("pr_id").toString();
								
                                                                        %>
                                                                                            <tr width="100%">
                                                                                                <td width="23">　</td>
                                                                                                <td width="520" align="left"><a href="ProjectDetail.jsp?pr_id=<%=pr_id%>"><%=pr_name%></a></td></tr>

                                                                                        <%
                                                                                        }
                                                                                        %>
                                                                                        <tr>
              <td width="543" height="10"colspan="2" align="center"></td>
            </tr>
            <tr>
              <td width="543" height="21" background="../images/pint3.gif" colspan="2" align="center" valign="bottom"><table><tr><td><%=dImpl.getTail(request)%></td></tr></table></td>
            </tr>
                                                                                        <%
                                                                                }
                                                                                else
                                                                                {
                                                                                        %><tr width="100%"><td width="23">　</td>
                                                                                                <td width="520" align="left"><%out.println("对不起，没有找到您要的记录！");%>
                                                                                       </td></tr><%
                                                                                }
                                                                        }
                                                                        if(selectid.equals("0")&&selecttype.equals("1"))
                                                                        {
                                                                                Vector vectoralldept = dImpl.splitPage(sql_alldept,request,20);

                                                                                if(vectoralldept!=null)
                                                                                {
                                                                                        for(int i=0;i<vectoralldept.size();i++)
                                                                                        {
                                                                                                content = (Hashtable)vectoralldept.get(i);
                                                                                                pr_name = content.get("pr_name").toString();
                                                                                                pr_id   = content.get("pr_id").toString();
                                                                        %>
                                                                                            <tr width="100%">
                                                                                                <td width="23">　</td>
                                                                                                <td width="520" align="left"><a href="ProjectDetail.jsp?pr_id=<%=pr_id%>"><%=pr_name%></a></td></tr>

                                                                                        <%
                                                                                        }
                                                                                        %>
                                                                                        <tr>
              <td width="543" height="10"colspan="2" align="center"></td>
            </tr>
            <tr>
              <td width="543" height="21" background="../images/pint3.gif" colspan="2" align="center" valign="bottom"><table><tr><td><%=dImpl.getTail(request)%></td></tr></table></td>
            </tr>
                                                                                        <%
                                                                                }
                                                                                else
                                                                                {
                                                                                        %><tr width="100%"><td width="23">　</td>
                                                                                                <td width="520" align="left"><%out.println("对不起，没有找到您要的记录！");%>
                                                                                       </td></tr><%
                                                                                }
                                                                        }

                                                                        if(selectid.equals("0")&&selecttype.equals("2"))
                                                                        {
                                                                                Vector vectorallwork = dImpl.splitPage(sql_allwork,request,20);
                                                                                if(vectorallwork!=null)
                                                                                {
                                                                                        for(int i=0;i<vectorallwork.size();i++)
                                                                                        {
                                                                                                content = (Hashtable)vectorallwork.get(i);
                                                                                                pr_name = content.get("pr_name").toString();
                                                                                                pr_id   = content.get("pr_id").toString();
                                                                        %>
                                                                                              <tr width="100%">
                                                                                                <td width="23">　</td>
                                                                                                <td width="520" align="left"><a href="ProjectDetail.jsp?pr_id=<%=pr_id%>"><%=pr_name%></a></td></tr>

                                                                        <%
                                                                                        }
                                                                                        %>
                                                                                        <tr>
              <td width="543" height="10"colspan="2" align="center"></td>
            </tr>
            <tr>
              <td width="543" height="21" background="../images/pint3.gif" colspan="2" align="center" valign="bottom"><table><tr><td><%=dImpl.getTail(request)%></td></tr></table></td>
            </tr>
                                                                                        <%
                                                                                }
                                                                                else
                                                                                {
                                                                                        %><tr width="100%"><td width="23">　</td>
                                                                                                <td width="520" align="left"> <%out.println("对不起，没有找到您要的记录！");%>
                                                                                       </td></tr><%
                                                                                }

                                                                        }

                                                                        if(!selectid.equals("0")&&selecttype.equals("1"))
                                                                        {
                                                                                Vector vectorondept = dImpl.splitPage(sql_ondept,request,20);
                                                                                if(vectorondept!=null)
                                                                                {
                                                                                        for(int i=0;i<vectorondept.size();i++)
                                                                                        {
                                                                                                content = (Hashtable)vectorondept.get(i);
                                                                                                pr_name = content.get("pr_name").toString();
                                                                                                pr_id   = content.get("pr_id").toString();
                                                                        %>
                                                                                               <tr width="100%">
                                                                                                <td width="23">　</td>
                                                                                                <td width="520" align="left"><a href="ProjectDetail.jsp?pr_id=<%=pr_id%>"><%=pr_name%></a></td></tr>

                                                                        <%
                                                                                        }
                                                                                        %>
                                                                                        <tr>
              <td width="543" height="10"colspan="2" align="center"></td>
            </tr>
            <tr>
              <td width="543" height="21" background="../images/pint3.gif" colspan="2" align="center" valign="bottom"><table><tr><td><%=dImpl.getTail(request)%></td></tr></table></td>
            </tr>
                                                                                        <%
                                                                                }
                                                                                else
                                                                                {
                                                                                         %><tr width="100%"><td width="23">　</td>
                                                                                                <td width="520" align="left"><%out.println("对不起，没有找到您要的记录！");%>
                                                                                       </td></tr><%
                                                                                }

                                                                        }

                                                                        if(!selectid.equals("0")&&selecttype.equals("2"))
                                                                        {
                                                                                Vector vectoronwork = dImpl.splitPage(sql_onwork,request,20);
                                                                                if(vectoronwork!=null)
                                                                                {
                                                                                        for(int i=0;i<vectoronwork.size();i++)
                                                                                        {
                                                                                                content = (Hashtable)vectoronwork.get(i);
                                                                                                pr_name = content.get("pr_name").toString();
                                                                                                pr_id   = content.get("pr_id").toString();
                                                                        %>
                                                                                               <tr width="100%">
                                                                                                <td width="23">　</td>
                                                                                                <td width="520" align="left"><a href="ProjectDetail.jsp?pr_id=<%=pr_id%>"><%=pr_name%></a></td></tr>

                                                                        <%
                                                                                        }
                                                                                        %>
                                                                                        <tr>
              <td width="543" height="10"colspan="2" align="center"></td>
            </tr>
            <tr>
              <td width="543" height="21" background="../images/pint3.gif" colspan="2" align="center" valign="bottom"><table><tr><td><%=dImpl.getTail(request)%></td></tr></table></td>
            </tr>
                                                                                        <%
                                                                                }
                                                                                else
                                                                                {
                                                                                        %><tr width="100%"><td width="23">　</td>
                                                                                                <td width="520" align="left"> <%out.println("对不起，没有找到您要的记录！");%>
                                                                                       </td></tr><%
                                                                                }
                                                                        }

                                                     }
                                       //列表结束
                                                                                        %>

          </table>
          </td>
        </tr>
        <tr>
          <td width="543" height="4" colspan="2" bgcolor="#B49F66"></td>
        </tr>
        <tr>
          <td width="543" height="20" colspan="2" valign="top" background="../images/pint3.gif"><a name="tbtj"></a><img border="0" src="../images/tebtj.gif" width="80" height="20"></td>
        </tr>
        <tr>
          <td width="543" height="30" colspan="2">
          <table border="0" cellpadding="0" cellspacing="0" width="100%">
            <tr><td height="10"></td></tr><tr>
              <td width="23">　</td>
              <td width="520"><table border="0" cellpadding="0" cellspacing="0" width="100%">
                 <%
                    Vector vPage1 = dImpl.splitPage(sqlStr_uk,1000,1);
                    if (vPage1!=null)
                      {
                        for(int j=0;j<vPage1.size();j++)
                           {
                                 content = (Hashtable)vPage1.get(j);
                                 String sg_name = content.get("sg_name").toString();
                                 String sg_url = content.get("sg_url").toString();
                                 %>
                             <tr>
                              <td>
                                <a href="<%=sg_url%>" target="_blank">· <%=sg_name%></a>
                              </td>
                             </tr>
                             <%if(j==6)
                                break;
                             }
                          }
                else
                {
                        out.print("&nbsp;没有记录");
                }
                %>
                 <tr><td height="10"></td></tr></table></td>
            </tr>
            <tr>
              <td width="543" height="21" background="../images/pint3.gif" colspan="2" align="center" valign="bottom">
                <p align="right">&gt;&gt;&nbsp; <a href="/website/usercenter/tebieList.jsp?tebie=1&uk_id=<%=UK_ID%>">更多</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p>
              </td>
            </tr>
          </table>
          </td>
        </tr>

        <tr>
          <td width="543" height="2" colspan="2" bgcolor="#B49F66"></td>
        </tr>
        <tr>
          <td width="543" height="20" colspan="2" valign="top" background="../images/pint3.gif"><img border="0" src="../images/changjwt.gif" width="120" height="20"><a name="wtjd"></a>
		  </td>
        </tr>
        <tr>
          <td width="543" height="30" colspan="2">
          <table border="0" cellpadding="0" cellspacing="0" width="100%">
            <tr><td height="10"></td></tr><tr>
              <td width="23">　</td>
              <td width="520"><table border="0" cellpadding="0" cellspacing="0" width="100%">
				<%
				Vector vPage3 = dImpl.splitPage(sqlStr_error,1000,1);
					if(vPage3!=null){
						for(int q=0;q<vPage3.size();q++){
						Hashtable content3 = (Hashtable)vPage3.get(q);
						String dv_id = content3.get("dv_id").toString();
						String dv_value = content3.get("dv_value").toString();
						out.print("<a href=list.jsp?dv_id="+dv_id+"&#wtjd>"+dv_value+"</a>&nbsp;&nbsp;&nbsp;");
						if(q!=0&&q%4==0){
						out.print("<br>");
						}
						}
					}
		%>
<br>
<%
                     Vector vPage2 = dImpl.splitPage(sqlStr_uk1,1000,1);
                      if (vPage2!=null)
                      {
                        for(int j=0;j<vPage2.size();j++)
                           {
                                   content = (Hashtable)vPage2.get(j);
                                      String qu_id = content.get("qu_id").toString();
                                      String qu_title = content.get("qu_title").toString();
                                      %><tr><td><a href="javascript:openWin(2,'<%=qu_id%>')">· <%=qu_title%></a></td></tr>
                                              <%if(j==6){break;}}}
                      else
                      {
                              out.print("<tr><td>&nbsp;没有记录</td></tr>");
                      }
                      %>


                                  <tr><td height="10"></td></tr></table></td>
            </tr>
            <tr>
              <td width="543" height="21" background="../images/pint3.gif" colspan="2" align="center" valign="bottom">
                <p align="right">&gt;&gt;&nbsp; <a href="/website/usercenter/tebieList.jsp?tebie=2&uk_id=<%=UK_ID%>&dv_id_rq=<%=dv_id_rq%>">更多</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                </p>
              </td>
            </tr>
          </table>
          </td>
        </tr>

        <tr>
          <td width="543" height="2" colspan="2" bgcolor="#B49F66"></td>
        </tr>
        </table>
      </td>
      <td width="7">　</td>
    </tr>
    <tr>
      <td height="5" colspan="3"></td>
    </tr>
  </table>
  </td></tr>
</table>
<table width="746" border="0" cellspacing="0" cellpadding="0" align="center">
<tr><td height="5"></td></tr></table>
<%@include file="/website/include/bottom_user.jsp"%>
<%
}
catch(Exception e){
//e.printStackTrace();
out.print(e.toString());
}
finally{
dImpl.closeStmt();
dCn.closeCn(); 
}
%>