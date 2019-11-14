<%@ page contentType="text/html; charset=GBK" %>
<HEAD>
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="0">
</HEAD>
<%@ page import="com.component.database.*" %>
<%@ page import="com.app.CMySelf" %>
<%@ page import="com.component.treeview.*" %>
<%@ page import="com.util.*" %>
<%@ page import="com.platform.CManager" %>
<script LANGUAGE="javascript" src="/system/common/treeview/treeJs.js"></script>
<SCRIPT LANGUAGE=javascript for=window event=onload>
<!--
    var args = dialogArguments ;
    var isSupportMultiSelect = args.isSupportMultiSelect;
    title.innerHTML = args.treeTitle;
    content.value = args.content;
    setSupportMultiSelect(('1'==''+args.isSupportMultiSelect));
    setSupportDirSelect(args.isSupportDirSelect);
    setInitFileIds(args.initFileIds);
    setInitDirIds(args.initDirIds);

    //setSupportAutoSelect(1);

    init();
//-->
</SCRIPT>
<SCRIPT LANGUAGE=javascript >
function on_choose()
{
  //绑定栏目的id
  var kidVal = document.all.kidLate.value;
  var sep = "";
  var sep1 = '\x01' ;
  var sep2 = '\x02' ;


  s1  = "fileIds="+getSelectedFileIds() ;
  //alert("s1:" + s1);
  //s2  = "dirIds="+getSelectedDirIds() ;
  //添加绑定栏目的id
  s2  = "dirIds="+getSelectedDirIds() + kidVal;
  //alert("s2:" + s2);
  s3 = "content="+content.value;
  //alert("s3:" + s3);
  returnValue = s1 + sep1 + s2 + sep1 + s3 ;
  //alert(returnValue)
  close() ;
}
function on_clear()
{
  clearTree();
  content.value="";
  demoContent.value="";
  //删除绑定的栏目id 
  document.all.kidLate.value = "";
}
function title_click(id,value,node,curSelected)
{
  var sep2 = '\x02';
  if (isSupportMultiSelect)
  {
    if (curSelected) //要选择
    {
      checkKidLate(id,sep2);
      content.value += value+sep2;
    }else{
      eval("var re = /"+value+sep2+"/gi;");
      content.value = content.value.replace(re,"");
    }
  }else{
    content.value = value;
  }
  <%//session.setAttribute("Module_name",toString(content.value));%>
}

//查看是否有绑定的栏目
function checkKidLate(id,sep2) {
		var objhttpPending=new ActiveXObject("Msxml2.XMLHTTP");
		var objxmlPending =	objxmlPending = new ActiveXObject("Microsoft.XMLDOM");
		strA = "abc"
		objhttpPending.Open("post","/system/common/treeview/test.jsp?id=" + id,true);
		objhttpPending.setRequestHeader("Content-Length",strA.length);
		objhttpPending.setRequestHeader("CONTENT-TYPE","application/x-www-form-urlencoded");
		
		objhttpPending.onreadystatechange = function () {
			var statePending = objhttpPending.readyState;
		    if (statePending == 4)
		    {
		    	var returnvalue = objhttpPending.responsetext;
		    	if(returnvalue.indexOf("yes")!=-1){
		    		//取得绑定栏目的数据，栏目名称，栏目代码
		    		var subrtvalue = returnvalue = returnvalue.substring(returnvalue.indexOf("<br>") + 4);
		    		//取得绑定栏目名称
		    		while (subrtvalue.indexOf("##")>0) {
		    			returnvalue = subrtvalue.substring(0,subrtvalue.indexOf("##"));
		    			subrtvalue = subrtvalue.substring(subrtvalue.indexOf("##")+2,subrtvalue.length);
			    		value = returnvalue.substring(0,returnvalue.indexOf(","));
			    		kidLateVal = returnvalue.substring(returnvalue.indexOf("sj_id=") + 6,returnvalue.length);
			    		document.all.kidLate.value += "," + kidLateVal;
			    		content.value += value + sep2;
		    		}
		    	}
			}
		};
		objhttpPending.Send(strA);
}

</SCRIPT>
<%
  String treeType = "";
  String parentId = "";
  String isSupportFile   = "";
  String xml = "";
  long id ;
%>
<%
  //CManager manage = (CManager)session.getAttribute("manager");
  //String orgname = manage.getAtOrgname();
  treeType = request.getParameter("treeType");
  parentId = request.getParameter("parentId");
  isSupportFile   = request.getParameter("isSupportFile");
  //out.print(parentId);
  CDataCn dCn = null;
  CTreeXML tree = null;
  try{
  	dCn = new CDataCn();
  	tree = new CTreeXML(dCn,treeType);
  //out.print(tree.getLastErrString());
  if (isSupportFile.equals("1"))  tree.setSupportFile();
  if (parentId.equals("")) parentId = "0";
  id = java.lang.Long.parseLong(parentId);
  if("Subject".equals(treeType)){
    //xml = tree.getXMLByParentID(id,orgname);    CDataCn  dCn = new CDataCn();
    CRoleAccess ado=new CRoleAccess(dCn);
    CMySelf self = (CMySelf)session.getAttribute("mySelf");
    String user_id = String.valueOf(self.getMyID());


	//session.setAttribute("_InfoSubject","");
	xml=CTools.dealNull(session.getAttribute("_InfoSubject"));
	if(xml.equals(""))
	{
		if(!ado.isAdmin(user_id)) 
		{
			String ids=ado.getAccessSqlByUser(user_id,ado.ColumnAccess);
			/*out.print(ids);
			ids=CTools.MidStr(ids,"and SJ_ID in(",")");
			String[] idsArr=CTools.split(ids,",");
			int j=0;
			String sqlSpec="SJ_ID in(";
			for(int i=0;i<idsArr.length;i++)
			{
				String cid=CTools.dealNull(idsArr[i]);
				if(!cid.equals(""))
				{
					j++;
					sqlSpec+=cid+",";
					if(j==800)
					{
						j=0;
						sqlSpec+=") or SJ_ID in(";
					}
				}
			}

			String sql1=" and ("+CTools.replace(sqlSpec+")",",)",")")+")";
			//tree.setFilterSql(ado.getAccessSqlByUser(user_id,ado.OrganAccess));*/
			tree.setFilterSql(ids);
	  }

		  //tree.setFilterSql(ado.getAccessSqlByUser(user_id,ado.ColumnAccess));
		xml=tree.getXMLByParentID(id);
		session.setAttribute("_InfoSubject",xml);
	}

/*

    if(!ado.isAdmin(user_id))
      tree.setFilterSql(ado.getAccessSqlByUser(user_id,ado.ColumnAccess));

    xml = tree.getXMLByParentID(id);*/
  }
  else if("Dept".equals(treeType)){
  //xml = tree.getXMLByParentID(id,orgname);    CDataCn  dCn = new CDataCn();
  CRoleAccess ado=new CRoleAccess(dCn);
  CMySelf self = (CMySelf)session.getAttribute("mySelf");
  String user_id = String.valueOf(self.getMyID());

  if(!ado.isAdmin(user_id))
  {
		String ids=ado.getAccessSqlByUser(user_id,ado.OrganAccess);
		/*ids=CTools.MidStr(ids,"and DT_ID in(",")");
		String[] idsArr=CTools.split(ids,",");
		int j=0;
		String sqlSpec="DT_ID in(";
		for(int i=0;i<idsArr.length;i++)
		{
			String cid=CTools.dealNull(idsArr[i]);
			if(!cid.equals(""))
			{
				j++;
				sqlSpec+=cid+",";
				if(j==800)
				{
					j=0;
					sqlSpec+=") or DT_ID in(";
				}
			}
		}

		String sql1=" and ("+CTools.replace(sqlSpec+")",",)",")")+")";
		//tree.setFilterSql(ado.getAccessSqlByUser(user_id,ado.OrganAccess));*/
		tree.setFilterSql(ids);
  }

  xml = tree.getXMLByParentID(id);
  }
  else{
	xml = tree.getXMLByParentID(id);
  }
  dCn.closeCn();
  
  
 //保存content.value session.setAttribute("Module_name",content.value);
  
  
  
%>
<xml id=xmlDoc><%=xml%></xml>
<html>
<head>
<link href="/system/platform/style.css" rel="stylesheet" type="text/css">
</head>
<body>
<input type="hidden" name="kidLate">
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
                                <textarea class="text-area" type="text" id="content" style="width:100%;height:50;" readonly></textarea>
                                <input type=hidden id="list_id" value=0>
                        </td>
                </tr>
                <tr id=demoDIV style="display:none">
                        <td>您输入的： <input type="checkbox" id="demoType" value="1" class="check1">放在前面
                                <textarea class="text-area" type="text" id="demoContent" style="width:100%;height:20;"></textarea>
                                <input type=hidden id="list_id" value=0>
                        </td>
            </tr>
                <tr>
                        <td align=center>
                                <input class="bttn" onClick="on_choose();" type="button" value="确定" id=button1 name=button1>
                                <input class="bttn" onClick="on_clear()" type="button" value="清除"  id=button2 name=button2>
                                <input class="bttn" onClick="window.close();" type="button" value="取消" id=button3 name=button3>
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
	if(tree != null)
	tree.closeStmt();
	if(dCn != null)
	dCn.closeCn();
}

%>