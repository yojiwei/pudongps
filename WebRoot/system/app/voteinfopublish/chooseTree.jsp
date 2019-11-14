<%@ page contentType="text/html; charset=GBK" %>
<%@ page import="com.component.database.*" %>
<%@ page import="com.component.treeview.*" %>
<%@ page import="com.util.*" %>
<%@ page import="com.platform.role.*" %>

<head>
<title>Untitled Document</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link rel="stylesheet" href="../../platform/images/style.css" type="text/css">
<base target="_self">
</head>
<script LANGUAGE="javascript" src="treeJs.jsp"></script>
<SCRIPT LANGUAGE=javascript for=window event=onload>
<!--
    var args = dialogArguments ;
    var isSupportMultiSelect = args.isSupportMultiSelect;
    var isSupportContentInput = args.isSupportContentInput;

    title.innerHTML = args.treeTitle;
    content.value = args.content;

    setSupportMultiSelect(isSupportMultiSelect);
    setSupportDirSelect(args.isSupportDirSelect);
    setInitFileIds(args.initFileIds);
    setInitDirIds(args.initDirIds);
    setSupportContentInput(isSupportContentInput);

    init();
    document.all.content.focus();
//-->
</SCRIPT>
<SCRIPT LANGUAGE=javascript >
function on_choose()
{
  var sep = "";
  var sep1 = ';' ;
  var sep2 = ',' ;


  s1  = "fileIds="+getSelectedFileIds() ;
  //alert(s1)
  s2  = "dirIds="+getSelectedDirIds() ;
  s3 = "content="+content.value;

  if(demoContent.value!="")
  {
    if(demoType.checked)
      s3 = "content="+demoContent.value+((content.value!='')?',':'')+content.value;
    else
      s3 = "content="+content.value+((content.value!='')?',':'')+demoContent.value;
  }

  s3=s3.replace(/,,/ig,',');

  returnValue = s1 + sep1 + s2 + sep1 + s3 ;
  close() ;
}
function on_clear()
{
  clearTree();
  content.value="";
  demoContent.value="";
}
function title_click(id,value,node,curSelected)
{
  var sep2 = ',';
  //alert(typeof(isSupportMultiSelect));
  if (parseInt(isSupportMultiSelect)!=0)
  {
    //alert("小强！！");
    if (curSelected) //要选择
    {
      //content.value += value+sep2 ;
	  if (content.value=="") content.value += value;
	  else
	  {
	  	content.value += "," + value;
	  }
    }
	else
	{
	  var re;
	  if (content.value!=value)
	  {
		  if (content.value.indexOf(value)>0)
		  {
			eval("re = /" + sep2 + value + "/gi;");
		  }
		  else
		  {
			eval("re = /"+value+sep2+"/gi;");
		  }
	  }
	  else
	  {
	  	eval("re = /" + value + "/ig;");
	  }
      content.value = content.value.replace(re,"");
    }
  }
  else
  {
    content.value = value;
  }
}
</SCRIPT>
<%
  String treeType = "";
  String isSupportFile   = "";
  String owner = "";
  String xml = "";
  long id ;
  String value = "";
  String fType = "";
  int accessType = -1;
  String moduleType = "";
  String ls = "";
  String isSupportAccess = "1";
  String treefilter="";
%>
<%
  treeType =  CTools.dealString(request.getParameter("treeType"));
  fType    =  CTools.dealString(request.getParameter("treeFunctionType"));
  ls = CTools.dealString(request.getParameter("treeAccessType"));
  owner = CTools.dealString(request.getParameter("treeOwner"));
  moduleType = CTools.dealString(request.getParameter("treeModuleType"));
  isSupportAccess = CTools.dealNull(request.getParameter("isSupportAccess"),"1");
  treefilter = CTools.dealString(request.getParameter("treefilter"));

  value =  CTools.dealString(request.getParameter("treeParaValue"));
  isSupportFile   =  CTools.dealString(request.getParameter("isSupportFile"));
  //out.print(parentId);
  CDataCn dCn = null;
  try{
  	dCn = new CDataCn();

  if(treeType.toLowerCase().equals("role"))
  {
    CRoleInfo role=new CRoleInfo(dCn);
    xml=role.getXml();
  }
  else
  {
    IAccess ia = null;
    if (isSupportAccess.equals("1"))
    {
      ia = (IAccess)session.getAttribute("_userInfo");
      if (ia != null )
      {
        if (!ls.equals(""))
        {
          accessType = java.lang.Integer.parseInt(ls);
          ia.setAccessType(accessType);
        }
        if (!moduleType.equals(""))
        {
          ia.setModuleType(moduleType);
        }
      }
    }

    CTreeXML tree = new CTreeXML(dCn,treeType,ia);

    if(!treefilter.equals(""))
    {
      tree.setFilterDirIds(treefilter);
    }

    //out.print(tree.getLastErrString());
    if (isSupportFile.equals("1"))  tree.setSupportFile();
    if (!owner.equals("")) tree.setOwner(java.lang.Long .parseLong(owner));

    if (fType.equals("byCurId"))
    {
      id = java.lang.Long.parseLong(value);
      xml = tree.getXMLByCurID(id);
    }else{
      if (fType.equals("byInfo"))
      {
        xml = tree.getXMLByInfo(value);
      }else{
        id = java.lang.Long.parseLong(value);
        xml = tree.getXMLByParentID(id);
      }
    }
  }
  dCn.closeCn();
%>
<xml id=xmlDoc><%=xml%></xml>
<html>
<head>
<link href="../../platform/style.css" rel="stylesheet" type="text/css">
</head>

<body>
<table cellSpacing="0" cellPadding="2" width="100%" border="0">
   <tr bgColor="#deefff">
     <td align=center><b><font color=blue ><span id=title></span></font></b></td>
   </tr>
</table>

        <div style="overflow: auto; width: 100%; height: 280; border: 0px solid #336699">
          <table cellSpacing="0" cellPadding="2" width="100%" border="0">
            <tbody>
              <tr>
                <td vAlign="top" width="100%" >
                  <table border="0" width="100%" cellpadding="0">
                    <tr>
                      <td style="width:100%">
                        <table border="0" width="100%" cellpadding="0">
                          <tr>
                            <td width="100%" align="left">
                              <p align="left"><span id=TreeRoot>...</span>
                            </td>
                          </tr>
                        </table>
                      </td>
                      <td style="width=100%" valign="top">
                      <p align="right">
                      </td>
                    </tr>
                  </table>
                </td>
              </tr>
            </tbody>
          </table>
        </div>
          <table cellSpacing="0" cellPadding="2" width="100%" border="0">
            <tr bgColor="#deefff">
                        <td>您选择的：
                                <textarea class="text-area" type="text" id="content" style="width:100%;height:80;" readonly></textarea>
                                <input type=hidden id="list_id" value=0>
                        </td>
                </tr>
                <tr id=demoDIV style="display:none">
                        <td>您输入的： <input type="checkbox" id="demoType" value="1" class="check1">放在前面
                                <input onkeydown="if(event.keyCode==13) on_choose();" class="text-area" type="text" id="demoContent" style="width:100%;height:20;"></textarea>
                                <input type=hidden id="list_id" value=0>
                        </td>
            </tr>
                <tr>
                        <td align=center>
                                <input class="bttn" onclick="on_choose();" type="button" value="确定" id=button1 name=button1>
                                <input class="bttn" onclick="on_clear()" type="button" value="清除"  id=button2 name=button2>
                                <input class="bttn" onclick="window.close();" type="button" value="取消" id=button3 name=button3>
<!--
                                <input class="bttn" onclick="alert(dirIds.value);" type="button" value="部门" id=button1 name=button1>
                                <input class="bttn" onclick="alert(fileIds.value);" type="button" value="用户" id=button2 name=button2>
-->
                        </td>
                </tr>
         </table>

<br>

</body>


</html>

<%


} catch (Exception ex) {
	System.out.println(new java.util.Date() + "--"
			+ request.getServletPath() + " : " + ex.getMessage());
} finally {

	if(dCn != null)
	dCn.closeCn();
}

%>
