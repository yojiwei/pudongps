<%@page contentType="text/html; charset=GBK"%>
<%@ include file="../import.jsp"%>
<%@include file="/system/app/islogin.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title>上海浦东门户网站后台管理系统</title>
<link href="images/main.css" rel="stylesheet" type="text/css" />
</head>
<bgsound id=PlaySound>
<base target="main">


<body leftmargin="0" topmargin="0" bgcolor="#A4CCED">
<table width="145" border="0" cellpadding="0" cellspacing="0">
  <tr>
    <td align="center" valign="top">

<%
CDataCn  dCn = null;
try{
   dCn = new CDataCn();
   CMySelf mySelf = (CMySelf)session.getAttribute("mySelf");
   if(mySelf!=null)
   {
     String userId = "12";//Session("_userId")
    
     CModuleInfo jdo = new CModuleInfo(dCn);
     ResultSet MenuRs=null,ChildMenuRs=null;

     //查询某一个主菜单下的所有模块和具体的菜单项（子功能）
     String ID=CTools.dealNull(request.getParameter ("ID")); //返回选择的菜单项ID
     String Menu=CTools.dealString(request.getParameter("Menu"));	 //返回选择的菜单项
     String Sql="";
     String curUrl="";


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
       
         String Url1=strMenuUrl;
		 if (!Url1.equals(""))
		 {
		   if (Url1.indexOf("?")!=-1){
		     Url1 = Url1 + "&";
		   }else{
		     Url1 = Url1 + "?";
		   }
		   Url1="../../"+Url1+"Menu="+Menu+"&Module="+strMenuName+"&SubMenuID="+strMenuId;
		 }
		 
		 if(Url1.equals(""))Url1=URL;
		 //out.println("xx:"+Url1);
		 if(curUrl.equals(""))curUrl=Url1;
%>
    <table width="130" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td height="4"></td>
      </tr>
      <tr>
        <td height="30"  style="CURSOR: hand; "
    onclick="javascript:OpenMenu(Menu<%=MenuItem%>,'<%=Url1%>');"  align="center" valign="middle" background="images/index_toptitleleft01.jpg" class="f13h"><%=strMenuName%></td>
      </tr>
    </table>
      <table width="124"  style="DISPLAY: none" id="Menu<%=MenuItem%>" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td height="8"><img src="images/index_lefttbtop.gif" width="124" height="8" /></td>
        </tr>
        <tr>
          <td height="0" valign="top" background="images/index_lefttbbg.gif"><table width="100%" border="0" cellspacing="0" cellpadding="6">
<%
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

    if(curUrl.equals(""))curUrl=strSubMenuUrl+"Menu="+strMenuName+"&Module="+strSubMenuName+"&SubMenuID="+strSubMenuId;
%>
            <!--tr>
              <td height="30" align="center" valign="middle"><a href="#"><img src="images/index_lefttb_01.gif" width="29" height="29" border="0" /></a></td>
            </tr-->
            <tr>
              <td align="center" valign="middle"> <A
    <%
      if (strSubMenuUrl.toLowerCase().indexOf("http://")!=-1) {
    %>
        href="<%=strSubMenuUrl%>Menu=<%=strMenuName%>&Module=<%=strSubMenuName%>&SubMenuID=<%=strSubMenuId%>" target=_blank

    <%
      }else{
    %>
        href="../../<%=strSubMenuUrl%>Menu=<%=strMenuName%>&Module=<%=strSubMenuName%>&SubMenuID=<%=strSubMenuId%>"
    <%
      }
    %>

          onmousedown="PlaySound.src='sound/NIMOver.wav';"
          onmouseout=""
          onmouseover=""><%=strSubMenuName%></a></td>
            </tr>

<%
  }
%>
          </table></td>
        </tr>
        <tr>
          <td height="8"><img src="images/index_lefttbbottom.gif" width="124" height="8" /></td>
        </tr>
    </table>

<%
  }
%>

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
     //eval("Menu"+i+"Table.height='';");
   }

 }
 catch(e)

 {
 }

 }

 Menu.style.display=Menu.style.display==""?"none":"";


   }

   parent.main.navigate("<%=curUrl%>");
</script>
<%
   }
     
   }catch(Exception budex){
	   budex.printStackTrace();
   }finally{
	   dCn.closeCn();
   }
%>
</td>
  </tr>
</table>

</body>
</html>
