<script language="javascript">
function change(obj) {
  if(obj.selectedIndex == 0) { return false; }
  urlhtml=obj.options[obj.selectedIndex].value;
  window.open(urlhtml);
  obj.selectedIndex=0;
  return true;
  }
</script>
<table width="1002" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td height="4" bgcolor="#787878"></td>
  </tr>
  <tr>
    <td height="48" valign="top" bgcolor="#CCCCCC"><table width="890" border="0" align="center" cellpadding="0" cellspacing="0">
      <tr>
		<%//Update 20061231
			String [] link = new String[5];
			sqlStr = "select i.*,s.fs_code from tb_frontinfo i,tb_frontsubject s where s.fs_id = i.fs_id and s.fs_parentid = (select fs_id from tb_frontsubject where fs_code='homelink') order by fi_sequence";
			vPage = dImpl.splitPageOpt(sqlStr,500,1);
			if(vPage!=null)
			{
				for(int i=0;i<vPage.size();i++)
				{
					content = (Hashtable) vPage.get(i);
					String fs_code = content.get("fs_code").toString();
					String fi_title = content.get("fi_title").toString();		
					String fi_url = content.get("fi_url").toString();
					if(fs_code.equals("pdweb")) link[0] +="<option value='" + fi_url + "'>" + fi_title + "</option>";
					if(fs_code.equals("streetweb")) link[1] +="<option  value='" + fi_url + "'>" + fi_title + "</option>";
					if(fs_code.equals("shweb")) link[2] +="<option  value='" + fi_url + "'>" + fi_title + "</option>";
					if(fs_code.equals("areaweb")) link[3] +="<option  value='" + fi_url + "'>" + fi_title + "</option>";
					if(fs_code.equals("newsweb")) link[4] +="<option  value='" + fi_url + "'>" + fi_title + "</option>";
				}
			}
		%>
        <td height="30" valign="bottom"><img src="imagesnew/indexWJ_topicon12.gif" width="79" height="25" /></td>
        <td width="160" align="left" valign="bottom"><select name="select4" class="select-01" style="width:150px" onChange="return change(this);">
                    <option value="0" selected="selected">浦东部门网站</option>
                    <%=link[0]%>
          </select></td>
        <td width="160" align="left" valign="bottom"><select name="select4" class="select-01" style="width:150px" onChange="return change(this);">
                    <option value="0" selected="selected">浦东街镇网站</option>
                    <%=link[1]%>
          </select></td>
        <td width="160" align="left" valign="bottom"><select name="select4" class="select-01" style="width:150px" onChange="return change(this);">
                    <option value="0" selected="selected">上海主要网站</option>
                    <%=link[2]%>
          </select></td>
        <td width="160" align="left" valign="bottom"><select name="select4" class="select-01" style="width:150px" onChange="return change(this);">
                    <option value="0" selected="selected">区县政府网站</option>
					<%=link[3]%>
          </select></td>
        <td width="160" align="left" valign="bottom"><select name="select4" class="select-01" style="width:150px" onChange="return change(this);">
                    <option value="0" selected="selected">新闻媒体网站</option>
					<%=link[4]%>
          </select></td>
      </tr>
    </table></td>
  </tr>
  <tr>
    <td height="21" align="center" valign="top" bgcolor="#C81908"><table width="180" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td height="3" colspan="7"></td>
      </tr>

<%
String count_sj_dir = CTools.dealString(request.getParameter("sj_dir")).trim();
if (!"".equals(count_sj_dir)) {
	CountForWeek count_cfw = new CountForWeek();
	count_cfw.addCount_count("count",count_sj_dir);
}/*
String aboutUs_ctId = "";
String aboutUs_sql = "select p.ct_id from tb_contentpublish p,tb_subject s where s.sj_dir='aboutUs' and s.sj_id = p.sj_id order by p.ct_id desc";
Hashtable aboutUs_content = dImpl.getDataInfo(aboutUs_sql);
if (aboutUs_content != null)
{
	aboutUs_ctId = aboutUs_content.get("ct_id").toString();
}*/
%>
      <tr>
        <!--<td align="center"><a href="#" onClick="window.open('/website/pop/pop.jsp?ct_id=<%=aboutUs_ctId%>','','width=550,height=520,top=50,toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=2,resizable=0');return false;" class="L14"><font color="#FFFFFF">关于我们</font></a></td>
		<td align="center"><font color="#FFFFFF">|</font></td>-->
        <td align="center"><a href="/website/sitemap.jsp" target="_blank" class="L14"><font color="#FFFFFF">网站地图</font></a></td>
        <!--<td align="center"><font color="#FFFFFF">|</font></td>
        <td align="center"><a href="#" class="L14"><font color="#FFFFFF">郑重申明</font></a></td>-->
        <td align="center"><font color="#FFFFFF">|</font></td>
        <td align="center"><a href="#" onClick="window.open('/website/pop/pop_webmaster.jsp','','width=550,height=550,top=50,toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=2,resizable=0');return false;" class="L14"><font color="#FFFFFF">网站纠错</font></a></td>
        </tr>
    </table></td>
  </tr>
</table>
<span style="display:none">
	<iframe src="/website/pudongNews/InfoContent_pd.jsp" name="InfoContent_pd" width='80' height="20" marginwidth="0" allowTransparency="true" marginheight="0" align="center" scrolling="no" frameborder="0">
	</iframe>
<script language="javascript" src="http://count17.51yes.com/click.aspx?id=175188285&logo=1"></script>
</span>