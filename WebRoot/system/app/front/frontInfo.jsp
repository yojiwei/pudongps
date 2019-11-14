<%@page contentType="text/html; charset=GBK"%>
<%@include file="../skin/head.jsp"%>
<script>
	function isZoomPic(obj)
	{
		if(obj.checked)
		{
			document.getElementById("showzpic").style.display = "";
		}
		else
		{
			document.getElementById("showzpic").style.display = "none";
		}
		
	}
	function keepsame(obj)
	{
		var val = obj.value;
		if(val!="-1")
		{
			document.getElementById("z_height").value = val;
		}	
	}
</script>
<%
        String fi_id = "";
		String fs_id = "";
        String sql = "";
        String sql_judge = "";
        String sqlStr = "";
        String sqlCorr = "";
        String fi_title = "";
		String fi_url = "";
		String fi_sequence = "";
		String fi_content = "";
		String fi_img = "";
        String actiontype="add";
		String fi_type = "";
		String ct_fileflag = "";
		String frim_name = ""; //文件名
		String frim_filename = "";//转变后的文件名
		String frim_path = "";//图片文件夹的路径
		String frim_id = "";//图片存储的ID
		String path = "";//文件相对路径
        Vector vPage = null;

        CDataCn dCn = new CDataCn(); //新建数据库连接对象
        CDataImpl dImpl = new CDataImpl(dCn); //新建数据接口对象
		String list_id = CTools.dealString(request.getParameter("list_id")).trim();
        String strTitle="新增信息";
        fi_id=CTools.dealString(request.getParameter("fi_id"));
        if(!fi_id.equals(""))
        {
            sql = "select fi_id,fs_id,fi_title,fi_url,fi_sequence,fi_content,fi_img,fi_type,ct_fileflag from tb_frontinfo where fi_id = '" + fi_id + "'";
               Hashtable content = dImpl.getDataInfo(sql);
               if (content!=null)
               {
                 fi_id = content.get("fi_id").toString();
				 list_id = content.get("fs_id").toString();
                 fi_title = content.get("fi_title").toString();
				 fi_url = content.get("fi_url").toString();
				 fi_sequence = content.get("fi_sequence").toString();
				 fi_content = content.get("fi_content").toString();
				 fi_img = content.get("fi_img").toString();
				 fi_type = content.get("fi_type").toString();
				 ct_fileflag = content.get("ct_fileflag").toString();
                 actiontype = "modify";
                 strTitle = "编辑信息";
                }
				sql ="select frim_name,frim_path,frim_filename,frim_id from tb_frontinfo_image where fi_id='"+fi_id+"'";
				content = dImpl.getDataInfo(sql);
				if(content!=null){
					frim_name = content.get("frim_name").toString();
					frim_path = content.get("frim_path").toString();
					frim_filename = content.get("frim_filename").toString();
					frim_id = content.get("frim_id").toString();
					if(frim_name.equals("")||frim_filename.equals(""))
					{
					dImpl.delete("tb_frontinfo_image","frim_id",frim_id);frim_id="";
					}
				}
         }
		 path = dImpl.getInitParameter("front_http_path");
		 path = path+frim_path+"/"+frim_filename;
//out.print("++"+frim_id+"++");
%>

<form action="frontInfoResult.jsp" method="post" name="formData" enctype="multipart/form-data">
<table WIDTH="100%" CELLPADDING="0" BORDER="0" class="main-table">
   <tr >
     <td width="100%" align="left" valign="top"colspan="2">
      <table class="content-table"  width="100%">
      <tr class="title1">
              <td align="center" colspan=2><%=strTitle %> </td>
      </tr>
      </table>
     </td>
     </tr>
      <tr class="line-even">
        <td align="right">信息标题：</td><td align="left"><input type="text" name="fi_title" value="<%=fi_title%>" class="text-line"> <font color=red>*</font><INPUT TYPE="checkbox" NAME="ct_fileflag" value = "1" <%=ct_fileflag.equals("1") ? "checked" : ""%>> 特别提醒</td></td>
      </tr>
      <tr class="line-odd">
        <td align="right">信息URL链接：</td><td align="left"><input type="text" name="fi_url" value="<%=fi_url%>" class="text-line"> <font color=red></font><INPUT TYPE="checkbox" NAME="fi_type" value = "1"<%if(fi_type.equals("1"))out.println("checked");%>> 是否为绝对路径</td>
      </tr>
	  <tr class="line-even">
        <td align="right">信息排序：</td><td align="left"><input type="text" name="fi_sequence" value="<%=fi_sequence%>" class="text-line"> <font color=red></font></td>
      </tr>
	  <tr class="line-odd">
        <td align="right">信息内容：</td><td align="left"><textarea class="text-area" name="fi_content" cols="60" rows="6" title="信息内容"><%=fi_content%></textarea></td>
      </tr>
	  <tr class="line-even">
        <td align="right">上传图片：</td><td align="left">
		<%
					if(frim_name.equals(""))
					{
						//out.println("<input type=\"file\" name=\"frim_name\" size=\"40\" class=\"text-line\">");
%>
		<input type="file" name="frim_name" size="30" class="text-line" />
		<input type="checkbox" name="zoomPic" onclick="isZoomPic(this)" />是否手动创建缩略图
		<input type="hidden" name="zp_sign" value="1"/> 
<%
					}
					else
					{
						out.println("&nbsp;<a href='"+path+"'>"+frim_name+"</a>&nbsp;&nbsp;<img src=\"../../images/delete.gif\" onclick=\"javascript:delfile('"+fi_id+"','"+list_id+"');\" style=\"cursor:hand\" alt=\"删除文件\">");
%>
		<input type="hidden" name="zp_sign" value="0"/>	
<%
						
					}
%>
					</td>
      </tr>
	  <tr class="line-odd" id="showzpic" style="display:none">
	  <td align="right">缩放比例：</td>
	  <td>
		<select id="z_width" name="z_width" >
		<option value="zpwidth">宽度</option>
		<option value="zpheight">高度</option>
		</select>&nbsp;
		<input type="text" name="zip_para" size="6" value="138"/>
		<!--select id="z_height" name="z_height">
		<option value="-1">缩放高度</option>
		<option value="2">二分之一</option>
		<option value="3">三分之一</option>
		<option value="4">四分之一</option>
		<option value="5">五分之一</option>
		<option value="6">六分之一</option>
		</select-->
	  </td>
	  </tr>
      <tr class=title1>
    <td align=center colspan=2>
    <input type=button onclick="check()" name=b1 value="提交" class="bttn" >&nbsp;
    <%
	if(!actiontype.equals("add"))
	{
	%>
	<input value="删除" class="bttn" onclick="javascript:del()" type="button" size="6">&nbsp;
    <%
	}
 %>
 <input type=reset name=b1 value="重填" class="bttn">
	<input type=button onclick="history.go(-1);" name=b1 value="返回" class="bttn">
  </td>
 </tr>
</table>
<input type=hidden name=actiontype value=<%=actiontype%>>
<input type=hidden name=fi_id value=<%=fi_id%>>
<input type=hidden name=list_id value=<%=list_id%>>
<input type=hidden name=frim_id value=<%=frim_id%>>

</form>

<script language="javascript">
function delfile(fi_id,list_id)
{
	var form = document.formData;
	var con;
	con=confirm("真的要删除吗？");
	if (con)
	{
		form.action = "attachDel.jsp?fi_id="+fi_id+"&list_id="+list_id;
		form.submit();
	}
}

function check()
{
        var form = document.formData ;
        if (form.fi_title.value == "" ) {
                alert("信息标题不能为空！") ;
                form.fi_title.focus();
                return;
        }
        //if (form.fi_url.value == "" ) {
               // alert("信息URL链接不能为空！") ;
               // form.fi_url.focus();
                //return;
        //}
       // if (form.fi_sequence.value == "" ) {
                //alert("信息排序不能为空！") ;
               // form.fi_sequence.focus();
               // return;
        //}
		var val2 = document.getElementById("zp_sign").value; 
		if(val2=="1")
		{

			if(formData.zoomPic.checked)
			{
				if(formData.frim_name.value=="")
				{
					alert("请选择要上传的图片!");
					return;
				}
				if(formData.zip_para.value=="")
				{
					alert("请输入缩放数值！");
					formData.zip_para.focus();
					return;
				}
				var rex = /^\d{1,6}$/;
				if(!rex.test(formData.zip_para.value))
				{
					alert("输入的缩放数值不合理！(1-6位整数)");
					formData.zip_para.focus();
					return;
				}
			}
		}
		//alert("ok!");
        form.submit() ;
}
  function  del()
  {
    if(window.confirm('确认要删除该记录么?'))
   {
    window.location="frontDel.jsp?fi_id=<%=fi_id%>&list_id=<%=list_id%>";
   }
  }
</script>
<%
dImpl.closeStmt();
dCn.closeCn();
%>
<%@include file="../skin/bottom.jsp"%>