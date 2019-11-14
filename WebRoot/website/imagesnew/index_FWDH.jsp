
<table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td height="2" bgcolor="#828282"></td>
        </tr>
      <tr>
        <td height="1"></td>
        </tr>
      <tr>
        <td valign="top" background="imagesnew/indexWJ_middleBG03.jpg"><table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td width="496" height="120" valign="top"><object 
classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" 
codebase="http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=7,0,19,0" width="496" height="120">
          <param name="movie" value="/website/flash/banner-service1.swf" />
          <param name="quality" value="high" />
          <param name="wmode" value="transparent" />
          <embed src="/website/flash/banner-service1.swf" quality="high" pluginspage="http://www.macromedia.com/go/getflashplayer" type="application/x-shockwave-flash" width="496" height="120"></embed>
        </object>
            </td>
            <td width="308" align="left" valign="top"><table width="300" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td height="6"></td>
              </tr>
              <tr>
                <td valign="top"><table width="100%" border="0" cellpadding="0" cellspacing="1" bgcolor="#181818">
                  <tr bgcolor="#FFFFFF">
                    <td valign="top"><table width="92%" border="0" align="center" cellpadding="0" cellspacing="0">
              <%
			  //Update 20061231
          		StringBuffer sf_bmtx = new StringBuffer();
				Vector ctIdVec_bmtx  = null;
				String ctIdSql_bmtx = "";
				Hashtable ctIdTable_bmtx = null;
				ctIdSql_bmtx = "select ct_id from tb_contentpublish where sj_id in (select sj_id "+
								 "from tb_subject connect by prior sj_id = sj_parentid start with sj_dir='pudongNews_BMTX') order by ct_id desc";
				ctIdVec_bmtx = dImpl.splitPage(ctIdSql_bmtx,20,1);
				if(ctIdVec_bmtx != null){
					for(int cnt = 0; cnt < ctIdVec_bmtx.size(); cnt++){
						ctIdTable_bmtx = (Hashtable) ctIdVec_bmtx.get(cnt);
						sf_bmtx.append(ctIdTable_bmtx.get("ct_id").toString());
						if(cnt != (ctIdVec_bmtx.size() - 1))
							sf_bmtx.append(",");
					}
				}
				
				sqlStr = "select distinct ct_id,dt_id,ct_title,ct_create_time,ct_url,ct_specialflag from tb_content where ct_id in ("+sf_bmtx.toString()+") order by to_date(ct_create_time,'YYYY-MM-DD') desc,ct_id desc";
				ii = 0;
				vPage = dImpl.splitPageOpt(sqlStr,request,4);
				if(vPage!=null) {
					for(int i=0;i<vPage.size();i++) {
						content = (Hashtable)vPage.get(i);
						ctTitle = content.get("ct_title").toString();
						specialFlag = content.get("ct_specialflag").toString();
						ctCreateTime = content.get("ct_create_time").toString();
						ctId = content.get("ct_id").toString();
						ctUrl = content.get("ct_url").toString();
						href = !ctUrl.equals("") ? ctUrl : "/website/pudongNews/InfoContent.jsp?sj_dir=pudongNews_BMTX&ct_id=" + ctId;
						ii++;
						
						//ctTitle = ctTitle.length() > 17 ? ctTitle.substring(0,16) + ".." : ctTitle;
              %>
              <tr>
                <td width="18" height="24" align="left" valign="bottom"><img src="imagesnew/indexWJ_topicon05.gif" width="3" height="3" hspace="5" vspace="8" /></td>
              				<%
              
						if (i == 3) {
              				%>
                <td valign="bottom">
                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                	<tr>	
                		<td align="left">
                			<a href="<%=href%>" title="<%=ctTitle%>"><%=CWebTools.sperateFontColor(specialFlag,ctTitle,17)%></a>
                		</td>
                		<td align="right">
                			<a href="/website/pudongNews/InfoList.jsp?sj_dir=pudongNews_BMTX"><font color="#181818">¸ü¶à>></font></a>
                		</td>
                	</tr>
                </table>
                </td>
                			<%
                				}
                				else {
                			%>
                <td valign="bottom"><a href="<%=href%>" title="<%=ctTitle%>"><%=CWebTools.sperateFontColor(specialFlag,ctTitle,21)%></a></td>
                			<%
                				}
                			%>
                </tr>
              <tr>
                <td height="1" colspan="2" background="imagesnew/indexWJ_line02.gif"></td>
              </tr>		  
			  <%
					}
				}
				for(;ii < 4;ii++) {
			  %>	
              <tr>
                <td width="18" height="24" align="left" valign="bottom"><img src="imagesnew/indexWJ_topicon05.gif" width="3" height="3" hspace="5" vspace="8" /></td>
                <td valign="bottom">&nbsp;</td>
                </tr>
              <tr>
                <td height="1" colspan="2" background="imagesnew/indexWJ_line02.gif"></td>
              </tr>	
              <%}%>
              <tr>
                <td height="5" colspan="2"></td>
              </tr>
            </table></td>
                  </tr>
                </table></td>
              </tr>
            </table></td>
          </tr>
        </table></td>
        </tr>
      <tr>
        <td height="1"></td>
      </tr>
      <tr>
        <td height="2" bgcolor="#828282"></td>
      </tr>
    </table>