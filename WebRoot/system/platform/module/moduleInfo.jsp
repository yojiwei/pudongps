<%@ page contentType="text/html; charset=GBK" %>
<%@ page import="com.platform.module.*" %>
<%@ page import="com.component.treeview.*" %>
<%@ page import="com.component.database.*" %>
<%@ page import="com.util.CTools" %>
<%@ page import="java.util.*" %>
<script LANGUAGE="javascript" src="/system/common/treeview/chooseTreeJs.jsp"></script>
<link href="../style.css" rel="stylesheet" type="text/css">
<script LANGUAGE="javascript">
<!--
function check()
{
	var form = document.formData ;
        if (form.ft_name.value == "") {
          alert("模块名称不能为空！");
          form.ft_name.focus();
          return;
        }

        form.ft_parent_id.value=form.ModuleDirIds.value;

	form.submit() ;
}
function del()
{
  if(!confirm("您确定要删除该模块吗？"))return;
  formData.action = "moduleInfoDel.jsp"
  formData.submit();
}

function chooseTypeEx(nameObj,idObj,url,title,dir,id,accessField,dW,dH)
{
        try
        {
                if (typeof(url)  == "undefined") {
                        url  = "imgSelect.asp";
                }else{
                        if (url == "")	url = "imgSelect.asp";
                }
                if (typeof(id)  == "undefined") id = 0;
                if (typeof(dir)  == "undefined") dir  = "";
                if (typeof(title) == "undefined") title = "请您选择";
                if (typeof(accessField)  == "undefined") accessField = "";
                if (typeof(dW)    == "undefined") dW    = 210;
                if (typeof(dH)    == "undefined") dH    = 350;

                url = ""+url+"?dir="+dir+"&title="+title+"&id="+id+"&accessField="+accessField;

                var args = new Object();

                returnSet = showModalDialog(url, args ,"dialogWidth: "+dW+"px; dialogHeight: "+dH+"px; help=no; status=no; scroll=no; resizable=yes; ") ;
                if (returnSet == "" || typeof(returnSet) == "undefined")
                {
                        return ;
                }else{
                        nameObj.value = returnSet;
                        var imgHtml =  "<img border=0 valign=absmiddle align=absmiddle src='" +returnSet+"'>";
                        idObj.innerHTML = imgHtml ;
                    }
        }
        catch(e)
        {
                alert("函数chooseTypeEx运行意外发生错误,请您与系统管理员联系!");
                return ;
        }
}
//-->
</script>
<%
   String ft_url="",ft_name="",parentId="",img="",img1="",ft_task_url="",ft_fast_help="",ft_code="",ft_isdefault="",msg="",info="",ft_img="";
   String list_id,ft_id="";
   String node_title="";
   String strList = "";
  // String sCheck[] = {"",""};
   Hashtable content = null;
   long id;
%>

<%
  list_id     = request.getParameter("list_id");
  node_title  = CTools.iso2gb(request.getParameter("node_title"));
  ft_id       = request.getParameter("ft_id");

  if (list_id == null) list_id = "1";

	////////////////////////////////////////////////////////
	// ft_id: 用户本身ID号
	//	list_id: 目录传递ID号

        CDataCn dCn = null;
        CTreeList list = null;
        try{
        	dCn = new CDataCn();
        	list = new CTreeList(dCn,"Module");
        list.setOnchange(false);
        strList = list.getListByCurID(list.LISTID,Integer.parseInt(list_id),list_id,"ft_parent_id");


        String sql="select ft_name from tb_function where ft_id=" + list_id;
        CDataImpl dImpl=new CDataImpl(dCn);
        content=dImpl.getDataInfo(sql);
        String Module_name=CTools.dealNull(content.get("ft_name"));
        dImpl.closeStmt();


	if (ft_id == null){ //新增状态
		info  = "新增模块"; //+ "&nbsp;&nbsp;&nbsp;&nbsp;" + msg;
                //sCheck[0] = "checked";
                ft_id = "0";
	}else{ //显示、修改
          CModuleInfo jdo = new CModuleInfo(dCn);
          id = java.lang.Long.parseLong(ft_id);
          content = jdo.getDataInfo(id);
          if (content !=null){
            ft_name      = content.get("ft_name").toString() ;
            ft_url       = content.get("ft_url").toString() ;
            ft_task_url  = content.get("ft_task_url").toString() ;
            ft_fast_help = content.get("ft_fast_help").toString() ;
            ft_code      = content.get("ft_code").toString() ;
            ft_img       = content.get("ft_img").toString() ;
          }
          jdo.closeStmt();
          dCn.closeCn() ;
          jdo = null;
	}
         // sCheck[1] = "checked";

%>

<form action="moduleInfoResult.jsp" method="post" name="formData">
<div align="center">
<table WIDTH="100%" CELLPADDING="0" BORDER="0" class="main-table">
   <tr>
        <td width="100%" align="left" valign="top">

	  	<table class="content-table" height="1" width="100%">
	  	  <tr class="title1">
	  	    <td width="100%" align="center" colspan=2><%=info%></td>
	  	  </tr>
	  	  <tr class="line-odd">
	  	    <td width="15%" align="right">名称：</td>
	  	    <td width="85%"><input class="text-line" name="ft_name" size="20" value="<%=ft_name%>" maxlength="20"></td>
	  	  </tr>
       <tr height=25>
         <td width="15%" align="right">上级模块：</td>
         <td width="85%">
         <input type="text" name="Module" class="text-line" treeType="Module" value="<%=Module_name%>" treeTitle="选择所属模块" readonly isSupportFile="0" onclick="chooseTree('Module');">
         <input type=button  title="选择所属模块" onclick="chooseTree('Module');" class="bttn" value=选择...>
         <input type="hidden" name="ModuleDirIds" value="<%=list_id%>">
         <input type="hidden" name="ModuleFileIds" value>
         <input type="hidden" name="ft_parent_id" value="<%=list_id%>">
         </td>
              </tr>
	  	  <tr class="line-even">
	  	    <td width="15%" align="right">URL：</td>
	  	    <td width="85%"><input type="text" class="text-line" name="ft_url" size="50" value="<%=ft_url%>" maxlength="100">
	  	    </td>
	  	  </tr>
	  	  <tr class="line-odd">
	  	    <td width="15%" align="right">TASKURL：</td>
	  	    <td width="85%"><input type="text" class="text-line" name="ft_task_url" size="50" value="<%=ft_task_url%>" maxlength="100">
	  	    </td>
	  	  </tr>
<!--
	  	  <tr class="line-even">
	  	    <td width="15%" align="right">图标：</td>
	  	    <td width="85%">
                <input type="button" class="bttn" value="选择..." onclick="chooseTypeEx(formData.menuImg,img1,'chooseMenuImg.asp','选择图标','menuImg');" size="7">
                <input type="hidden" name="menuImg" value="< %//=img%>">&nbsp;
                <span id=img1>< %=img1% ></span>
-->
	  	    </td>
	  	  </tr>
	  	  <tr class="line-odd">
	  	    <td width="15%" align="right">快速入门：</td>
	  	    <td width="85%"> <textarea class="text-area" rows="3" name="ft_fast_help" cols="48"><%=ft_fast_help%></textarea></td>
	  	  </tr>
        <tr class="line-even">
          <td width="15%" align="right">模块图标：</td>
          <td width="85%"><input type="text" class="text-line" onchange="img1.innerHTML='<img border=0  valign=absmiddle align=absmiddle  src=' +this.value+'>'" name="ft_img" size="28" value="<%=ft_img%>" maxlength="100">
            <input type="button" class="bttn" value="选择..." onclick="chooseTypeEx(formData.ft_img,img1,'imgSelect.jsp','<%=java.net.URLEncoder.encode("选择图标")%>','menuImg');" size="7">&nbsp;<span id=img1><img src="<%=ft_img%>"></span></td>
	  	  </tr>
	  	  </tr>
          <tr class="line-odd">
	  	    <td width="15%" align="right">权限代号：</td>
	  	    <td width="85%"><input class="text-line" name="ft_code" size="20" value="<%=ft_code %>" maxlength="20"></td>
          </tr>
          <!--
          <tr class="line-odd">
	  	    <td width="15%" align="right">是否默认：</td>
	  	    <td width="85%">
	  	    <INPUT type="radio" id=radio1 name=ft_isdefault value=1 < %=sCheck[0]%>>是&nbsp;&nbsp;
	  	    <INPUT type="radio" id=radio1 name=ft_isdefault value=0 < %=sCheck[1]%>>否</td>
          </tr>
-->
  	</table>
        </td>
      </tr>
		<tr class=title1>
		  <td width="100%" align="right" colspan="2">
		      <p align="center">

		  	<%  if (ft_id.equals("0")){ //新增界面
                        %>
		  			<input class="bttn" value="提交" type="button" onclick="check()" size="6" id="button2" name="button2">&nbsp;
					<input class="bttn" value="返回" type="button" onclick="history.back();" size="6" id="button3" name="button3">&nbsp;
		  	<%  }else{ 	%>
		  			<input class="bttn" value="修改" type="button" onclick="check()" size="6" id="button4" name="button4">&nbsp;
		  			<input class="bttn" value="删除" type="button" onclick="del()" size="6" id="button4" name="button4">&nbsp;
		  			<input class="bttn" value="返回" type="button" onclick="history.back();" size="6" id="button5" name="button5">&nbsp;
		  	<%  } 	%>

		    </td>
		</tr>
    </table>
</div>
<input type="hidden" name="list_id" value="<%=list_id%>">
<input type="hidden" name="ft_id" value="<%=ft_id%>">
<input type="hidden" name="node_title" value="<%=node_title%>">
</form>
<%


} catch (Exception ex) {
	System.out.println(new java.util.Date() + "--"
			+ request.getServletPath() + " : " + ex.getMessage());
} finally {
	if(list != null)
	list.closeStmt();
	if(dCn != null)
	dCn.closeCn();
}

%>