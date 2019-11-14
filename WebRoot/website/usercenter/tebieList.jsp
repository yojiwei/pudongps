<%@ page contentType="text/html; charset=GBK"%>
<%@include file="/website/include/head_hall.jsp"%>
<%@page import="com.website.*"%>
<%
//Update 20061231
CDataCn dCn = null;
try{
dCn = new CDataCn();


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
 String tebie="";
 String strSql_cw1 = "";
 Vector vectorPage1 = null;
 String strSql_cw2 = "";
 Vector vectorPage2 = null;
 String strSql_cw3 = "";
 Vector vectorPage3 = null;
 String list_uk_id = CTools.dealString(request.getParameter("uk_id")).trim();
 String te_bie = CTools.dealString(request.getParameter("tebie")).trim();
 if (te_bie.equals(""))
 {
 te_bie="1";
 }
 String list_cw_id1 = CTools.dealString(request.getParameter("cw_id")).trim();
 String pType = "";
 pType = CTools.dealString(request.getParameter("pType")).trim();
 CDataImpl dImpl_userleft = new CDataImpl(dCn); //新建数据接口对象
 CDataImpl listDImpl = new CDataImpl(dCn);
 if(session.getAttribute("user")!=null)
 {
   if(list_uk_id.equals(""))
   {
     User userLeft = (User)session.getAttribute("user");
     UK_ID=userLeft.getUserKind();
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
 Vector vectorPage = dImpl_userleft.splitPage(strSql_cw,10000,1);
 String strSqllj="select cw_name from tb_commonwork where cw_id = '" + CW_ID.trim() + "' order by cw_sequence";
 Vector vectorPagelj = dImpl_userleft.splitPage(strSqllj,10000,1);
  if(UK_ID.equals("o1")){
 strSql_cw1="select cw_id,cw_name from tb_commonwork where uk_id = 'o2' order by cw_sequence";
 vectorPage1 = dImpl_userleft.splitPage(strSql_cw1,10000,1);
 strSql_cw2="select cw_id,cw_name from tb_commonwork where uk_id = 'o3' order by cw_sequence";
 vectorPage2 = dImpl_userleft.splitPage(strSql_cw2,10000,1);
 strSql_cw3="select cw_id,cw_name from tb_commonwork where uk_id = 'o11' order by cw_sequence";
 vectorPage3 = dImpl_userleft.splitPage(strSql_cw3,10000,1);
 }
 if(UK_ID.equals("o2")){
 strSql_cw1="select cw_id,cw_name from tb_commonwork where uk_id = 'o1' order by cw_sequence";
 vectorPage1 = dImpl_userleft.splitPage(strSql_cw1,10000,1);
 strSql_cw2="select cw_id,cw_name from tb_commonwork where uk_id = 'o3' order by cw_sequence";
 vectorPage2 = dImpl_userleft.splitPage(strSql_cw2,10000,1);
 strSql_cw3="select cw_id,cw_name from tb_commonwork where uk_id = 'o11' order by cw_sequence";
 vectorPage3 = dImpl_userleft.splitPage(strSql_cw3,10000,1);
 }
 if(UK_ID.equals("o3")){
 strSql_cw1="select cw_id,cw_name from tb_commonwork where uk_id = 'o1' order by cw_sequence";
 vectorPage1 = dImpl_userleft.splitPage(strSql_cw1,10000,1);
 strSql_cw2="select cw_id,cw_name from tb_commonwork where uk_id = 'o2' order by cw_sequence";
 vectorPage2 = dImpl_userleft.splitPage(strSql_cw2,10000,1);
 strSql_cw3="select cw_id,cw_name from tb_commonwork where uk_id = 'o11' order by cw_sequence";
 vectorPage3 = dImpl_userleft.splitPage(strSql_cw3,10000,1);
 }
 if(UK_ID.equals("o11")){
 strSql_cw1="select cw_id,cw_name from tb_commonwork where uk_id = 'o1' order by cw_sequence";
 vectorPage1 = dImpl_userleft.splitPage(strSql_cw1,10000,1);
 strSql_cw2="select cw_id,cw_name from tb_commonwork where uk_id = 'o2' order by cw_sequence";
 vectorPage2 = dImpl_userleft.splitPage(strSql_cw2,10000,1);
 strSql_cw3="select cw_id,cw_name from tb_commonwork where uk_id = 'o3' order by cw_sequence";
 vectorPage3 = dImpl_userleft.splitPage(strSql_cw3,10000,1);
}
 //在此取出特别推荐和常见问题解答
 String sqlStr_uk = "select sg_id,sg_name,sg_url from tb_suggest where us_kind='"+UK_ID+"' order by sg_sequence";
 String sqlStr_uk1 = "select qu_id,qu_title from tb_question where us_kind='"+UK_ID+"' order by qu_sequence";
 //注释结束

 String strSql_rc="select * from tb_recommend order by rc_sequence, rc_time desc ";
 Vector vectorRec = dImpl_userleft.splitPage(strSql_rc,10000,1);

 String strSql_dept = "select dt_id,dt_name from tb_deptinfo where dt_iswork = 1 order by dt_sequence";
 Vector vectorDept = dImpl_userleft.splitPage(strSql_dept,10000,1);

 String strSql_sw = "select * from tb_sortwork order by sw_sequence";
 Vector vectorSw = dImpl_userleft.splitPage(strSql_sw,10000,1);

keyword = CTools.dealString(request.getParameter("keyword"));
selectid = CTools.dealString(request.getParameter("selectcontent"));
selecttype = CTools.dealString(request.getParameter("selecttype"));


CDataImpl workdImpl = new CDataImpl(dCn);

String sql_ondept = " select pr_name,pr_id from tb_proceeding where pr_isdel is null and dt_idext="+selectid;

String sql_onwork = " select pr_name,pr_id from tb_proceeding where pr_isdel is null and sw_id='"+selectid+"' ";

String sql_alldept = " select pr_name,pr_id from tb_proceeding where pr_isdel is null and dt_idext is not null ";

String sql_allwork = " select pr_name,pr_id from tb_proceeding where pr_isdel is null and sw_id is not null ";

String sql_all = " select pr_name,pr_id from tb_proceeding where pr_isdel is null ";

if(!keyword.equals("输入关键字"))
{
        sql_ondept += " and pr_name like '%"+keyword+"%' ";
        sql_onwork += " and pr_name like '%"+keyword+"%' ";
        sql_allwork += " and pr_name like '%"+keyword+"%' ";
        sql_alldept += " and pr_name like '%"+keyword+"%' ";
        sql_all += " and pr_name like '%"+keyword+"%' ";
}
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
    Hashtable content = (Hashtable)vectorDept.get(j);
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
    Hashtable content = (Hashtable)vectorSw.get(j);
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
                                              <a href="/website/usercenter/List.jsp"><font color="#ACACAC">办事大厅</font></a>
                                              <font color="#ACACAC">&gt;&gt;</font>
                                              <%if (te_bie.equals("1"))
  {
%>
<font color="#ACACAC">特别推荐</font><%}%>
<%if (te_bie.equals("2"))
  {
%>
<font color="#ACACAC">常见问题解答</font><%}%></td>
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
                                   if(UK_ID.equals("o2")){%>&nbsp;&nbsp;&nbsp;<font size="2" color="#FFFFFF">个人办事</font><%}
                                   if(UK_ID.equals("o3")){%>&nbsp;&nbsp;&nbsp;<font size="2" color="#FFFFFF">个人办事</font><%}
                                   if(UK_ID.equals("o11")){%>&nbsp;&nbsp;&nbsp;<font size="2" color="#FFFFFF">个人办事</font><%}
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
                                   Hashtable content = (Hashtable)vectorPage1.get(j);
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
                                   Hashtable content = (Hashtable)vectorPage2.get(j);
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
                                   Hashtable content = (Hashtable)vectorPage3.get(j);
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
          <td width="543" height="2" colspan="2" bgcolor="#B49F66"></td>
        </tr>
        <tr>
          <td width="543" height="20" colspan="2" valign="top" background="../images/pint3.gif">
        <%if (te_bie.equals("1"))
  {
%><img border="0" src="../images/tebtj.gif" width="80" height="20"><%}%>
<%if (te_bie.equals("2"))
  {
%><img border="0" src="../images/changjwt.gif" width="120" height="20"><%}%>
        </td>
        </tr>
        <tr>
          <td width="543" height="30" colspan="2">
          <table border="0" cellpadding="0" cellspacing="0" width="100%">
            <tr><td height="10"></td></tr><tr>
              <td width="23">　</td>
              <td width="520"><table border="0" cellpadding="0" cellspacing="0" width="100%">
                 <%
                   if (te_bie.equals("1"))
                    {
                    Vector vPage1 = dImpl_userleft.splitPage(sqlStr_uk,request,10);
                    if (vPage1!=null)
                      {
                        for(int j=0;j<vPage1.size();j++)
                           {
                                 Hashtable content = (Hashtable)vPage1.get(j);
                                 String sg_name = content.get("sg_name").toString();
                                 String sg_url = content.get("sg_url").toString();
                                 %>
                             <tr>
                              <td>
                                <a href="<%=sg_url%>" target="_blank">· <%=sg_name%></a>
                              </td>
                             </tr>
                             <%
                             }
                          }
                else
                {
                        out.print("&nbsp;没有记录");
                }}
                if (te_bie.equals("2"))
                    {
                  Vector vPage2 = dImpl_userleft.splitPage(sqlStr_uk1,request,10);
                   if (vPage2!=null)
                      {
                        for(int j=0;j<vPage2.size();j++)
                           {
                                 Hashtable content = (Hashtable)vPage2.get(j);
                                 String qu_id = content.get("qu_id").toString();
                                      String qu_title = content.get("qu_title").toString();
                                      %><tr><td><a href="javascript:openWin(2,'<%=qu_id%>')">· <%=qu_title%></a></td></tr>
                                              <%
                             }
                          }
                else
                {
                        out.print("&nbsp;没有记录");
                }}
                %>
                 <tr><td height="10"></td></tr></table></td>
            </tr>
            <tr>
              <td width="543" height="21" background="../images/pint3.gif" colspan="2" align="center" valign="bottom">
                <p align="right"><%=dImpl_userleft.getTail(request)%></p>
              </td>
            </tr>
          </table>
          </td>
        </tr>

        <tr>
          <td width="543" height="2" colspan="2" bgcolor="#B49F66"></td>
        </tr>
        <tr>
          <td width="543" height="20" colspan="2" valign="top" background="../images/pint3.gif">
<%if (te_bie.equals("1"))
  {
%><img border="0" src="../images/changjwt.gif" width="120" height="20"><%}%>
<%if (te_bie.equals("2"))
  {
%><img border="0" src="../images/tebtj.gif" width="80" height="20"><%}%>
</td>
        </tr>
        <tr>
          <td width="543" height="30" colspan="2">
          <table border="0" cellpadding="0" cellspacing="0" width="100%">
            <tr><td height="10"></td></tr><tr>
              <td width="23">　</td>
              <td width="520"><table border="0" cellpadding="0" cellspacing="0" width="100%">

<%
  if (te_bie.equals("1"))
                    {

                      Vector vPage2 = dImpl_userleft.splitPage(sqlStr_uk1,10,1);
                      if (vPage2!=null)
                      {
                        for(int j=0;j<vPage2.size();j++)
                           {
                                   Hashtable content = (Hashtable)vPage2.get(j);
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
                <p align="right">&gt;&gt;&nbsp; <a href="/website/usercenter/tebieList.jsp?tebie=2&uk_id=<%=UK_ID%>">更多</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                </p>
                <%
                    }
                    else
                    {
                    if (te_bie.equals("2"))
                    {

                      Vector vPage1 = dImpl_userleft.splitPage(sqlStr_uk,10,1);

                      if (vPage1!=null)
                      {
                        for(int j=0;j<vPage1.size();j++)
                           {
                          Hashtable content = (Hashtable)vPage1.get(j);
                        String sg_name = content.get("sg_name").toString();
                        String sg_url = content.get("sg_url").toString();
                 %>
                    <tr>
                     <td>
                       <a href="<%=sg_url%>" target="_blank">· <%=sg_name%></a>
                     </td>
                    </tr>
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
                <p align="right">&gt;&gt;&nbsp; <a href="/website/usercenter/tebieList.jsp?tebie=1&uk_id=<%=UK_ID%>">更多</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                </p>
                    <%}}%>
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
<%@include file="/website/include/bottom_hall.jsp"%>
<%
listDImpl.closeStmt();
workdImpl.closeStmt();
dImpl_userleft.closeStmt();
}
catch(Exception e){
//e.printStackTrace();
out.print(e.toString());
}
finally{
dCn.closeCn(); 
}

%>
