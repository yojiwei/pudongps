<%@page contentType="text/html; charset=GBK"%>
<%@ include file="../import.jsp"%>
<%@include file="/system/app/islogin.jsp"%>
<html>
<head>
<title>Untitled Document</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link rel="stylesheet" href="Include/style.css" type="text/css">
</head>
<bgsound id=PlaySound>
<base target="main">

<body bgcolor="E6E0D2" text="#000000" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" background="oa_pic/left_5_bg.gif" >
<table width="100%" border="0" cellspacing="0" cellpadding="0" height="100%">
  <tr>
    <td valign="top" height="187">
      <table width="110" border="0" cellspacing="0" cellpadding="0" background="oa_pic/left_5_bg.gif">


        <tr>
          <td align=center valign=top><img src="oa_pic/left_2.gif" width="110" height="2">
<%
CMySelf mySelf = (CMySelf)session.getAttribute("mySelf");
  if(mySelf!=null)
 {
  String userId = "12";//Session("_userId")
  //update20080122

CDataCn dCn=null;   //新建数据库连接对象
 CModuleInfo jdo = null;

try {
 dCn = new CDataCn(); 
jdo = new CModuleInfo(dCn);

 
  ResultSet MenuRs=null,ChildMenuRs=null;

  //查询某一个主菜单下的所有模块和具体的菜单项（子功能）
  String ID=CTools.dealNull(request.getParameter ("ID")); //返回选择的菜单项ID
  String Menu=CTools.dealNull(request.getParameter("Menu"));	 //返回选择的菜单项
  String Sql="";


  if (ID.equals(""))	//如果是首次进入，默认第一个菜单项
  {
    //查询模块级菜单
    Sql="	SELECT *" +
        "	FROM tb_Function" +
        "	WHERE (ft_parent_id in" +
        "	          (SELECT ft_id" +
        "	         FROM tb_Function" +
        "	         WHERE ft_parent_id = 0))" +
        " and ft_id in(select ft_id from tb_functionrole where tr_id in(select tr_id from tb_roleinfo where tr_userids like '%," + String.valueOf(mySelf.getMyID())  + ",%')) " +
        "                order by ft_sequence ";
    MenuRs=jdo.executeQuery(Sql);
    if(MenuRs.next())
    {
      ID=MenuRs.getString("ft_ID");
      Menu=MenuRs.getString("ft_Name");
    }
    MenuRs.close();
  }

  Sql="Select * from tb_Function Where ft_parent_id="+ID+" and ft_id in(select ft_id from tb_functionrole where tr_id in(select tr_id from tb_roleinfo where tr_userids like '%," + String.valueOf(mySelf.getMyID())  + ",%')) " + " order by ft_sequence";
  jdo.setSql(Sql);

  Vector objVec=jdo.splitPage(request);

  int MenuItem=0;	//菜单项
  int ChildMenuItem=0; //子菜单项
  int MenuItem1=0;
  String FirstURL="";	 //第一个模块的url
  String URL="",URL1="";
  for(int item=0;item<objVec.size();item++)
  {
    Hashtable objHT=(Hashtable)objVec.get(item);
    //if GetAccess(MenuRs("ID")) {
    MenuItem++;
    String strMenuName=CTools.dealNull(objHT.get("ft_name").toString());
    String strMenuId=CTools.dealNull(objHT.get("ft_id").toString());
    String strMenuUrl=CTools.dealNull(objHT.get("ft_url").toString());
    String strMenuOwner=CTools.dealNull(objHT.get("ft_owner").toString());

    //查询子菜单项
    //Sql="Select * from tb_Function Where ft_parent_id=" + strMenuId + " and (ft_owner = 0 or ft_owner=" + userId + " or ft_owner is null or ft_owner ='') order by ft_owner,ft_sequence";
    Sql="Select * from tb_Function Where ft_parent_id=" + strMenuId + " and (ft_owner = 0 or ft_owner=" + userId + " or ft_owner is null or ft_owner ='') " + " and ft_id in(select ft_id from tb_functionrole where tr_id in(select tr_id from tb_roleinfo where tr_userids like '%," + String.valueOf(mySelf.getMyID())  + ",%')) " + " order by ft_owner,ft_sequence";

    //out.println(Sql);if(true)return;
    ChildMenuRs=jdo.executeQuery(Sql);
    while(ChildMenuRs.next())
    {
      //if GetAccess(ChildMenuRs.getString("ID")) {
      //取出每一个模块的默认网页地址
      URL =CTools.dealNull(ChildMenuRs.getString("ft_url"));
      if (!URL.equals(""))
      {
        if (URL.indexOf("?")!=-1){
          URL = URL + "&";
        }else{
          URL = URL + "?";
        }
        URL="../../"+URL+"Menu="+Menu+"&Module="+strMenuName+"&SubMenuID="+ChildMenuRs.getString("ft_ID");
        break;
      }
      //}
    }

    ChildMenuRs.close();

    Sql="Select * from tb_Function Where ft_parent_id=" + strMenuId + " and (ft_owner = 0 or ft_owner=" + userId + " or ft_owner is null or ft_owner ='') " + " and ft_id in(select ft_id from tb_functionrole where tr_id in(select tr_id from tb_roleinfo where tr_userids like '%," + String.valueOf(mySelf.getMyID())  + ",%')) " + " order by ft_owner,ft_sequence";
    ChildMenuRs=jdo.executeQuery(Sql);

    //存储第一个模块的url
    if (MenuItem==1) {
      FirstURL=URL;
    }

%>

  <table border="0" width="105"  cellspacing="0" cellpadding="0" id="Menu<%=MenuItem%>Table">
    <tr>
      <td width="100%" align="middle"  background="oa_pic/left_top.jpg"
        style="CURSOR: hand; HEIGHT: 28px"
    onclick="javascript:OpenMenu(Menu<%=MenuItem%>,'<%=URL%>');" valign=bottom>
  <TABLE WIDTH=100% BORDER=0 CELLSPACING=0 CELLPADDING=3>
   <TR>
    <td background="oa_pic/left_1.jpg" height="31" align=center>&nbsp;<%=strMenuName%></td>
   </TR>
  </TABLE>
    </td>
    </tr>
    <%
  /*if (!request.getParameter("SubMenuID").equals("")) {
   if Not MenuRs.eof {
    if 0+request.getParameter("SubMenuID")=0+clng(MenuRs("id")) {
     MenuItem1=MenuItem
     URL1=URL
    }
   }
  }*/

    %>
    <tr>
      <td width="100%" align="middle" valign="top"  background="oa_pic/1.gif">
   <table border="0" width="105" style="DISPLAY: none" id="Menu<%=MenuItem%>" cellspacing="0" cellpadding="0">
       <tr>
         <td width="109" align="middle" background="oa_pic/1_top.gif"></font></td>
       </tr>
    <%
      if (false) { //如果没有菜单项，应该显示一个空的表格
    %>
    <tr>
      <td width="109" align="middle" background="oa_pic/1.gif"></td>
    </tr>
    <tr>
      <td width="109" align="middle" background="oa_pic/1.gif"><font color="#ffffff">暂时空缺！</font></td>
    </tr>
    <%
      }

      while (ChildMenuRs.next())
      {
        ChildMenuItem++;
        String strSubMenuName=CTools.dealNull(ChildMenuRs.getString("ft_Name"));
        String strSubMenuId=CTools.dealNull(ChildMenuRs.getString("ft_Id"));
        String strSubMenuUrl=CTools.dealNull(ChildMenuRs.getString("ft_Url"));
        String strSubMenuOwner=CTools.dealNull(ChildMenuRs.getString("ft_owner"));
        String strSubMenuImg=CTools.dealNull(ChildMenuRs.getString("ft_img"));

        if(strSubMenuImg.equals("")) strSubMenuImg="img\\initEBooks.gif";

        if (!strSubMenuUrl.equals("")) {
          if (strSubMenuUrl.indexOf("?")!=-1) {
            strSubMenuUrl = strSubMenuUrl + "&";
          }else{
            strSubMenuUrl = strSubMenuUrl + "?";
          }
        }else{
          strSubMenuUrl = strSubMenuUrl + "?";
        }

        if (true) {  //GetAccess(ChildMenuRs.getString("ID")) or strSubMenuOwner.equals(userId)
    %>
       <tr title="<%=strSubMenuName%>">
         <td width="109" align="middle" background="oa_pic/1.gif">
         <A
    <%
      if (strSubMenuUrl.toLowerCase().indexOf("http://")!=-1) {
    %>
        href="<%=strSubMenuUrl%>Menu=<%=Menu%>&Module=<%=strMenuName%>&SubMenuID=<%=strSubMenuId%>" target=_blank

    <%
      }else{
    %>
        href="../../<%=strSubMenuUrl%>Menu=<%=Menu%>&Module=<%=strMenuName%>&SubMenuID=<%=strSubMenuId%>"
    <%
      }
    %>

          onmousedown="PlaySound.src='sound/NIMOver.wav';ImageEffect(<%=ChildMenuItem%>,'inset-table',22,23,2);"
          onmouseout="ImageEffect(<%=ChildMenuItem%>,'main-table',26,27,0);"
          onmouseover="PlaySound.src='sound/NIMOver.wav';ImageEffect(<%=ChildMenuItem%>,'botton',22,23,2);">
       <font color="#ffffff">
       <IMG border=0 height=27 name=images<%=ChildMenuItem%> src="<%=strSubMenuImg%>" width=26></font></A></td>
       </tr>
       <tr>
         <td width="109" align="middle" background="oa_pic/1.gif"><font color="#ffffff"><%=strSubMenuName%></font></td>
       </tr>

    <%
      }
      }
   %>
       <tr>
         <td width="109" align="middle" background="oa_pic/left_bk_bottom.gif"></font></td>
       </tr>
   </table>
      </td>
    </tr>
  </table>
<%//out.println(Sql);if(true)return;
//}
  }//out.println(Sql);if(true)return;
%>

     <img src="oa_pic/left_3.gif" width="110" height="19">
     </td>
        </tr>
      </table>
    </td>
  </tr>



  <tr>
    <td valign="bottom"><img src="oa_pic/left_4.gif" width="110" height="68"></td>
  </tr>
</table>
</body>
</html>

<html></html>
<script language="javascript">
  function changeimage(imagename,filename)
      {document[imagename].src=filename;}

 var PaneHeight=(100-10*(<%=MenuItem%>-1)+1)+"%";

   try{

 <%if (MenuItem1!=0) {%>
   OpenMenu(Menu<%=MenuItem1%>,'<%=URL1%>');
 <%}else{%>
   Menu1.style.display="";
   Menu1Table.height=PaneHeight;
   parent.main.navigate('<%=FirstURL%>');
 <%}%>

   }
   catch(e){};

   function ImageEffect(Item,className,width,height,border)
   {
     eval("images"+Item+".className='"+className+"';");
     eval("images"+Item+".height="+height+";");
     eval("images"+Item+".width="+width+";");
     eval("images"+Item+".style.borderWidth ="+border+";");
   }

   function OpenMenu(Menu,URL)
   {
     parent.main.navigate(URL);

     PlaySound.src="sound/folder.wav";
     var MenuItem=0+Menu.id.substr(4);

 for (i=1;i<=<%=MenuItem%>;i++)
   {
   try
   {
   if(MenuItem!=i){
     eval("Menu"+i+".style.display='none';");
     eval("Menu"+i+"Table.height='';");
   }

 }
 catch(e)

 {
 }

 }

 Menu.style.display=Menu.style.display==""?"none":"";

 if(Menu.style.display=="")
   eval(Menu.id+"Table.height='"+PaneHeight+"';");
 else
   eval(Menu.id+"Table.height='';");
   }
</script>

<%
  jdo.closeStmt();
  dCn.closeCn();
} catch (Exception ex) {
	System.out.println(new java.util.Date() + "--"
			+ request.getServletPath() + " : " + ex.getMessage());
} finally {
	if(jdo != null)
	jdo.closeStmt();
	if(dCn != null)
	dCn.closeCn();
}
 }
%>
