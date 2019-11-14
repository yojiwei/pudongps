<%@page contentType="text/html; charset=GBK"%>
<%@ include file="../import.jsp"%>
<%@include file="/system/app/islogin.jsp"%>
<html>
<head>
<title>上海浦东门户网站后台管理系统</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<style type="text/css">
<!--
@import url("images/style.css");
-->
</style>
</head>
<%
    CMySelf self = (CMySelf)session.getAttribute("mySelf");
    if(self==null)response.sendRedirect("login.jsp");
    String user_name =CTools.trimTitle(CTools.dealNull(String.valueOf(self.getMyName())),3);
    String user_dept =CTools.dealNull(String.valueOf(self.getDtId()));
    
		//update20080122

CDataCn dCn=null;   //新建数据库连接对象
CDataImpl dImpl=null;  //新建数据接口对象
try {
 dCn = new CDataCn(); 
 dImpl = new CDataImpl(dCn); 
		String sql="select dt_name from tb_deptinfo where dt_id=" + user_dept;
		String Module_name="";
		Hashtable content1=dImpl.getDataInfo(sql);
		if(content1!=null){
		    Module_name=CTools.dealNull(content1.get("dt_name"));
		}
%>
<body bgcolor="#FFFFFF" leftmargin="0" topmargin="0" onResize="setWidth();" marginwidth="0" marginheight="0">
<!-- ImageReady Slices (未标题-2) -->
<OBJECT  WIDTH = 1 HEIGHT=1
    ID="RemoveIEToolbar"
    CLASSID="CLSID:2646205B-878C-11d1-B07C-0000C040BCDB"      codebase="../../dll/nskey.dll" VIEWASTEXT>
         <PARAM NAME=ToolBar VALUE=0>
  </OBJECT>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td valign="top" background="images/index_topbg.jpg"><table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
      <tr>
        <td width="241"><img src="images/index_top_01.jpg" width="241" height="78" alt=""></td>
        <td width="165"><img src="images/index_top_02.jpg" width="165" height="78" alt=""></td>
        <td width="201" height="78" valign="top" background="images/index_top_03.jpg"><table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0">
            <tr>
              <td width="12" height="19"></td>
              <td nowrap valign="bottom" id=Clock></td>
            </tr>
            <tr>
              <td></td>
              <td></td>
            </tr>
        </table></td>
        <td>&nbsp;</td>
        <td width="158" height="78" align="right" valign="top" background="images/index_top_04.jpg"><table width="128" border="0" cellpadding="0" cellspacing="0">
          <tr>
            <td height="28" valign="bottom"><table border="0" cellspacing="0" cellpadding="0">
                <tr>
                  <td width="28" align="center"><a href="/doc/help.htm" target="_blank">帮助</a></td>
                  <td width="5" align="center">|</td>
                  <td width="54" align="center"><a target=main href="/system/app/config/ConfigPwd.jsp?Menu=今日事务&Module=个人设置">修改密码</a></td>
                  <td width="5" align="center">|</td>
                  <td width="28" align="center"><a href="javascript:check();">退出</a></td>
                </tr>
            </table></td>
          </tr>
        </table></td>
      </tr>
    </table></td>
  </tr>
  <tr>
    <td height="27" background="images/index_toptitle_bg2.jpg"><table width="100%" border="0" cellpadding="0" cellspacing="0">
      <tr>
        <td width="6" valign="top"><img src="images/index_toptitle_01.jpg" width="6" height="27"></td>
        <td width="113" align="center" background="images/index_toptitle_bg1.jpg" class="f12c"><table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0">
            <tr>
              <td height="8"></td>
            </tr>
            <tr>
              <td align="center" nowrap valign="middle" class="f12c"><%=Module_name.length() > 8 ? Module_name.substring(0,7) + "." : Module_name%>：<%=user_name%></td>
            </tr>
        </table></td>
        <td width="30"></td>
        <td width="22" valign="bottom"><a href="javascript:toLeft()"><img id=leftArr style1="display:none" src="images/index_toptitle_tubiao2.gif" width="22" height="16" border="0"></a></td>
        <td width="7" background="images/index_toptitle_bg1.jpg" valign="bottom"></td>
<td  nowrap valign="bottom" background="images/index_toptitle_bg1.jpg"><span id="divsrl" nowrap  style="overflow:hidden;width:<%=102*8%>;height:22;"><table border="0" cellpadding="0" cellspacing="0"><tr>
<%
  String bgImg="";
  int pos=0;
  CMySelf mySelf = (CMySelf)session.getAttribute("mySelf");
  if(mySelf!=null)
  {
    //查询模块级菜单
    String Sql="	SELECT ft_Name,ft_ID" +
               "	FROM tb_Function" +
               "	WHERE (ft_parent_id in" +
               "	          (SELECT ft_id" +
               "	         FROM tb_Function" +
               "	         WHERE ft_parent_id = 0)) " +
               " and ft_id in(select ft_id from tb_functionrole where tr_id in(select tr_id from tb_roleinfo where tr_userids like '%," + String.valueOf(mySelf.getMyID())  + ",%')) " +
               " order by ft_sequence";
    //out.println(Sql+"<br>");
    CDataImpl jdo = new CDataImpl(dCn);

    ResultSet MenuRs=jdo.executeQuery(Sql);
    while(MenuRs.next())
    {
      pos++;
      bgImg=(pos==1)?"s":"";
%>
        <td width="102" valign="bottom" id=topTd1_<%=pos%>><table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td nowrap width="6"><img  id=topTd2_<%=pos%> src="images/index_toptitle01<%=bgImg%>.gif" width="6" height="22"></td>
            <td nowrap width="76" align="center" id=topTd3_<%=pos%> valign="middle" background="images/index_toptitle03<%=bgImg%>.gif"><a onClick="changeBK('<%=pos%>');"
                                        href="left.jsp?ID=<%=MenuRs.getString("ft_ID")%>&Menu=<%=MenuRs.getString("ft_Name")%>" target=nav><%=MenuRs.getString("ft_Name")%></a></td>
            <td nowrap width="20"><img id=topTd4_<%=pos%> src="images/index_toptitle02<%=bgImg%>.gif" width="7" height="22"></td>
          </tr>
        </table></td>
<%
    if(!MenuRs.isLast())
    {
%>
        <td width="11"></td>

<%
    }
  }

  if(pos==0){
%>
<script>
	alert("您尚未授予任何权限，请联系您的系统管理员。");
	top.location.href="../../";
</script>
<%
  }

  MenuRs.close();
  jdo.closeStmt();
  dCn.closeCn();
  }
%></tr></table></span></td>
        <td width="22" valign="bottom"><a href="javascript:toRight()"><img id=rightArr style1="display:none" onmouseover1="toRight()" src="images/index_toptitle_tubiao1.gif" width="22" height="16" border="0"></a></td>
        <td width="7" background="images/index_toptitle_bg1.jpg"></td>
        <td>&nbsp;</td>
      </tr>
    </table></td>
  </tr>
  <tr>
    <td height="4" background="images/index_toptitle_bg3.gif"></td>
  </tr>
</table>

<script>
function makeArray() {
        var args = makeArray.arguments;
        for (var i = 0; i < args.length; i++) {
        this[i] = args[i];
        }
        this.length = args.length;
        }
function fixDate(date) {date.setTime(Date.parse(document.lastModified));}
function getString(date) {var months = new makeArray("1", "2", "3","4","5","6", "7","8","9","10", "11", "12");
        var day_of_week = date.getDay();
        var str = "";
        if (day_of_week == 0)
            str = "星期天 ";
        if (day_of_week == 1)
            str = "星期一 ";
        if (day_of_week == 2)
            str = "星期二 ";
        if (day_of_week == 3)
            str = "星期三 ";
        if (day_of_week == 4)
            str = "星期四 ";
        if (day_of_week == 5)
            str = "星期五 ";
        if (day_of_week == 6)
            str = "星期六 ";
        return ((date.getYear() < 100) ? "19" : "") + date.getYear()+"年"+""+months[date.getMonth()] + "月" + date.getDate() + "日    ";
        }
function tick() {
var hours, minutes, seconds, xfile;
var intHours, intMinutes, intSeconds;
var today;
today = new Date();
intHours = today.getHours();
intMinutes = today.getMinutes();
intSeconds = today.getSeconds();
//timeString = intHours+"点"+intMinutes+"分"+intSeconds+"秒";
Clock.innerHTML =getString(today);// +timeString;
//setTimeout("tick();", 1000);
}
window.onload = tick;
</script>
<!-- End ImageReady Slices -->
<script language=javascript>
var currentGrid=1;
var pos=0;
var len=8;
if (window.screen.width==800) {
	len=6;
}
if (window.screen.width==640) {
	len=5;
}
var span=102*len;
var leftNum=0;
var rightNum=<%=pos%>-len;
if(rightNum<=0)rightNum=0;


function toLeft()
{
  pos-=span;
  leftNum=leftNum-len;
  rightNum=rightNum+len;
    if(rightNum>=<%=pos%>)rightNum=<%=pos%>;
      if(leftNum<=0)leftNum=0;
  divsrl.scrollLeft=pos;
  showArr();
}
function toRight()
{
  pos+=span;
  leftNum=leftNum+len;
  rightNum=rightNum-len;
  if(leftNum>=<%=pos%>)leftNum=<%=pos%>;
    if(rightNum<=0)rightNum=0;
  divsrl.scrollLeft=pos;
  showArr();
}

function showArr()
{
  var obj1=document.all.leftArr;
  var obj2=document.all.rightArr;
//window.status=leftNum;
  obj1.style.display=(leftNum<=0)?"none":"";
  obj2.style.display=(rightNum<=0)?"none":"";

}

showArr();

function changeBK(index)
{
  currentGrid=parseInt(index);
  for(i=1;i<=<%=pos%>;i++)
  {
    var obj1=eval("document.all.topTd1_"+i);
    var obj2=eval("document.all.topTd2_"+i);
    var obj3=eval("document.all.topTd3_"+i);
    var obj4=eval("document.all.topTd4_"+i);

    if(currentGrid==i)
    {
      //obj1.style.backgroundImage="url(images/index_toptitle_bg1s.jpg)";
      obj3.style.backgroundImage="url(images/index_toptitle03s.gif)";
      obj2.src="images/index_toptitle01s.gif";
      obj4.src="images/index_toptitle02s.gif";
    }
    else
    {
      //obj1.style.backgroundImage="url(images/index_toptitle_bg1.jpg)";
      obj3.style.backgroundImage="url(images/index_toptitle03.gif)";
      obj2.src="images/index_toptitle01.gif";
      obj4.src="images/index_toptitle02.gif";
    }
  }
}

function check(){
  re=confirm("你确定要退出吗？");
  if(re){
    top.location.href="../../../app/logout.jsp";
  }else{
  }
}

function setWidth()
{
  var wndWidth=document.body.clientWidth;
  wndWidth-=170;
  len=parseInt(wndWidth/102);
  span=102*len;
  rightNum=<%=pos%>-len;
  document.all.divsrl.style.width=""+span+"px";
}

setWidth();

</script>

</body>
</html>
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
