<%@page contentType="text/html; charset=GBK"%>
<%String strTitle="论坛内容" ;%>
<%@include file="../skin/head.jsp"%>
<%
//update20080122

CDataCn dCn=null;   //新建数据库连接对象
CDataImpl dImpl=null;  //新建数据接口对象

try {
 dCn = new CDataCn(); 
 dImpl = new CDataImpl(dCn); 
 String stype;
 String bt_name="";
 String bt_manager="";
 String uiid="";
 String managerId,manager;
 stype=CTools.dealNumber(request.getParameter("stype"));
 if(!stype.equals("0"))
 {
	 String strSql="select bt.* ,u.ui_name,u.ui_id from tb_bbstype bt,tb_userinfo u where bt.bt_manager=u.ui_id and bt.bt_id="+stype;
	 Hashtable content = dImpl.getDataInfo(strSql);
	 bt_name=content.get("bt_name").toString();
	 bt_manager=content.get("ui_name").toString();
	 uiid=content.get("ui_id").toString();
 }
 //////////////////////////////////////////////  后台用户
CMySelf myBBs = (CMySelf)session.getAttribute("mySelf");
  if(myBBs!=null && myBBs.isLogin())
  {
    managerId = Long.toString(myBBs.getMyID());
		manager=myBBs.getMyName();
  }
  else
  {
    managerId= "2";
		manager="";
  }
	////////////////////////////////////////////
	boolean flag=false;
	if(uiid.equals(managerId))
	{
		flag=true;
	}

%>
<script language=javascript>
function FormCheck()
{
		
		   //看看是否选中了至少一个要删除的文件
			var bHaveSelected=false;
			if (typeof(formData.delId)!="undefined")
			{
				var o = formData.delId;
				if (formData.delId.checked==true)
				   bHaveSelected=true;				
				for (var i = 0; i < o.length; i++) {  
					//如果选中了任何一个，设定标志
					if(o[i].checked ==true) 
						bHaveSelected= true; 
				} 
					
			 if (!bHaveSelected)  
			 {  
			    alert("请选择需要删除的记录！");  
			    return false;  
			 }	 
			if (confirm("确定要将选中的记录删除吗？"))
			formData.action="bbscontentDel.jsp"
			formData.submit();
		  }
}
function search()
{
var searchtext= document.all.search.value;
var searchkind=document.all.kind.value;
var stype=<%=stype%>;
if(searchtext=="")  return ;
var url="bbscontentDetail.jsp?searchtext="+searchtext+"&searchkind="+searchkind+"&stype="+stype;
//alert(url);
window.location=url;

}
</script>
<table border="0" width="100%" cellspacing="0" cellpadding="0">
  <tr class="title1">
    <td  width="56%" >
		<img border="0" src="../../images/bbs/bbssmall.gif" WIDTH="30" HEIGHT="20"><b>电子论坛-<%=bt_name%></b>
	</td>
    <td width="44%" align="right">
      <b>版主：<%=bt_manager%></b>&nbsp;&nbsp;&nbsp;
    </td>
  </tr>  
</table>

<table border="0" width="100%" cellspacing="0" cellpadding="0" height="22">
	<tr class="line-even">
		<td width=20%>&nbsp;</td>
		<td width="70%" height="22"  valign="middle">
			搜索：
			<input type="text" class="text-line" name="search" size="20">     
			<select size="1" name="kind">     
			   <option value="bt">主题
			   <option value="user_name">作者
			</select>
			&nbsp;&nbsp;&nbsp;<img src="../../images/menu_about.gif" border="0" title="查 询" onclick="search();">
		</td>
		<td align=right>
		<%if (flag)
		{
		%><img src='../../images/delete.gif' border=0 title='删除选中帖子' onclick='javascript:FormCheck();' style='cursor:hand'>
		<%
		}
		%>
		<a href="bbscontentAdd.jsp?stype=<%=stype%>"><img src="../../images/new.gif" title="新增帖子" border=0></a>
		</td>
	</tr>

</table>	
<%
String hit,id,title,sequence,face,user,writetime,child,sreply;
int curlen,prelen;
String swhere,searchtext,searchkind;
searchtext=CTools.dealString(request.getParameter("searchtext")).trim();
searchkind=CTools.dealString(request.getParameter("searchkind"));

swhere=" and 1=1";
if(!searchtext.equals("") && !searchkind.equals(""))
{
	if(searchkind.equals("bt"))
	{
		swhere=swhere+" and bc_title like '%"+searchtext+"%'  ";
	}
	else
	{
		swhere=swhere+" and bc_user like '%"+searchtext+"%'  ";
	}
}

String ssql="select bc_id, bc_title,bc_hit,bc_sequence,bc_child,bc_user,bc_face,bc_writetime from tb_bbscontent where bc_type="+stype+" ";
ssql=ssql+swhere+" order by bc_sequence";
//out.print(ssql);
Vector vectorPage = dImpl.splitPage(ssql,request,100);

%>
<table border="0" width="100%" cellspacing="0" cellpadding="0" >
<form action="" method=post name=formData>
<input type=hidden name=stype value=<%=stype%>>
<tr>
		<td width=100%>
			<dl COMPACT>
<%
if(vectorPage!=null)
{
  try
  {
		//int k=vectorPage.size()-1;
		Hashtable content3 = (Hashtable)vectorPage.get(0);
		prelen=content3.get("bc_sequence").toString().length();
    for(int j=0;j<vectorPage.size();j++)
    {
      Hashtable content2 = (Hashtable)vectorPage.get(j);
			hit=content2.get("bc_hit").toString();
			id=content2.get("bc_id").toString();
			title=content2.get("bc_title").toString();
			child=content2.get("bc_child").toString();
			user=content2.get("bc_user").toString();
			sequence=content2.get("bc_sequence").toString();
			curlen=sequence.length();		//取得当前sequence长度
			writetime=content2.get("bc_writetime").toString();
			face=content2.get("bc_face").toString();

		
		//如果当前的比上一条记录的sequence长，则是上一条的子项
			if (curlen > prelen)
			{
				out.print("<dl compact>");	//是子级
			}
			//以3个数为一级，加回</dl>标记
			else	//是上级
			{
				for (int i=1;i<=(prelen-curlen)/3;i++)
				{
					out.print("</dl>");
				}
			}

			//********************定义加贴，要传的参数******************
		//typeid:版面ID号
		//typename:版面名称
		//bc_id:该记录的id号
		//num:该记录的sequence值,用来排序的
		//child:当前是第几层
		//bt:加贴标题
	sreply="bbscontentReply.jsp?stype="+stype+"&bc_id="+id+"&childs="+child+"&num="+sequence+"&title="+title;

		
	%>
	<dt class=9color align=left><img src=<%=face%> border=0><a href=<%=sreply%>><%=title%></a>【<%=bt_name%>】---<span class=9color>
	<b><%=user%></b></span>&nbsp;&nbsp; <%=writetime%>[点击<%=hit%>次]
	<%if(flag)
			{
	%>
	<input type='checkbox' name='delId' value=<%=id%>>
			<%
			}%>
	</dt>
	<%
		prelen=curlen;
	}	
	out.print("</dl>");
	//out.print(prelen);
	for(int s=1;s<=(prelen-5)/3;s++)              
		{
		out.print("</dl>");
		}
	out.println("</td></tr>");
	out.print("</form>");
	out.println("<tr><td colspan=7>" + dImpl.getTail(request) + "</td></tr>"); //输出尾部文件
	}
	catch(Exception e)
	{
		 out.println(e);
	}
}
else
{
  out.println("<tr><td colspan=7>无记录</td></tr>");
}
%>
</table>

<%
dImpl.closeStmt();
dCn.closeCn();
%>
<%@include file="../skin/bottom.jsp"%>
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