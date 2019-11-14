<table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td height="24" align="right" valign="bottom" background="imagesnew/indexWJ_rightTitle01.gif"><a href="/website/pudongNews/InfoList.jsp?sj_dir=pudongNews_inform">更多&gt;&gt;</a>&nbsp;&nbsp;</td>
      </tr>
      <tr>
        <td valign="top" background="imagesnew/indexWJ_rightTitle04.gif"><table width="92%" border="0" align="center" cellpadding="0" cellspacing="0">
          <tr>
            <td height="8" colspan="2"></td>
          </tr>
          <%//Update 20061231
          	//公告栏
      		StringBuffer sf_right = new StringBuffer();
			Vector ctIdVec_right  = null;
			String ctIdSql_right = "";
			Hashtable ctIdTable_right = null;
			ctIdSql_right = "select ct_id from tb_contentpublish where sj_id in (select sj_id "+
							 "from tb_subject connect by prior sj_id = sj_parentid start with sj_dir='pudongNews_inform') order by ct_id desc";
			ctIdVec_right = dImpl.splitPage(ctIdSql_right,20,1);
			if(ctIdVec_right != null){
				for(int cnt = 0; cnt < ctIdVec_right.size(); cnt++){
					ctIdTable_right = (Hashtable) ctIdVec_right.get(cnt);
					sf_right.append(ctIdTable_right.get("ct_id").toString());
					if(cnt != (ctIdVec_right.size() - 1))
						sf_right.append(",");
				}
			}
			
			sqlStr = "select distinct ct_id,dt_id,ct_title,ct_create_time,ct_url,ct_specialflag from tb_content where ct_id in ("+sf_right.toString()+") order by to_date(ct_create_time,'YYYY-MM-DD') desc,ct_id desc";
			ii = 0;
			vPage = dImpl.splitPageOpt(sqlStr,request,6);
			if(vPage!=null) {
				for(int i=0;i<vPage.size();i++) {
					content = (Hashtable)vPage.get(i);
					ctTitle = content.get("ct_title").toString();
					specialFlag = content.get("ct_specialflag").toString();
					ctCreateTime = content.get("ct_create_time").toString();
					ctId = content.get("ct_id").toString();
					ctUrl = content.get("ct_url").toString();
					href = !ctUrl.equals("") ? ctUrl : "/website/pudongNews/InfoContent.jsp?sj_dir=pudongNews_inform&ct_id=" + ctId;
					ii++;
          %>
          <tr>
            <td width="20" height="24" align="left"><img src="imagesnew/indexWJ_topicon03.gif" width="7" height="7" hspace="4" /></td>
            <td><a href="<%=href%>" title="<%=ctTitle%>"><%=CWebTools.sperateFontColor(specialFlag,ctTitle,13)%></a></td>
          </tr>
		  <%
				}
			}
			for(;ii < 6;ii++) {
		  %>
          <tr>
            <td width="20" height="24" align="left"><img src="imagesnew/indexWJ_topicon03.gif" width="7" height="7" hspace="4" /></td>
            <td>&nbsp;</td>
          </tr>
          <%}%>
          <tr>
            <td height="10" colspan="2"></td>
            </tr>
        </table></td>
      </tr>
    </table>
      <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td height="24" background="imagesnew/indexWJ_rightTitle02.gif"></td>
        </tr>
        <tr>
          <td valign="top" background="imagesnew/indexWJ_rightTitle04.gif"><table width="92%" border="0" align="center" cellpadding="0" cellspacing="0">
          <tr>
            <td height="8" colspan="2"></td>
            </tr>
          <tr>
            <td width="20" height="24" align="left"><img src="imagesnew/indexWJ_topicon04.gif" width="5" height="5" hspace="4" /></td>
            <td><a href="/website/policy/mailQZXX.jsp?sj_dir=policy_QZXX&pardir=policy">给我们的区长写信</a></td>
          </tr>
          <tr>
            <td height="24" align="left"><img src="imagesnew/indexWJ_topicon04.gif" width="5" height="5" hspace="4" /></td>
            <td><a href="/website/govOpen/LeadMail.jsp?sj_dir=govOpenJLM&pardir=govOpen">给街道主任（镇长）写信</a></td>
          </tr>
          <tr>
            <td height="24" align="left"><img src="imagesnew/indexWJ_topicon04.gif" width="5" height="5" hspace="4" /></td>
            <td><a href="/website/supervise/content.jsp?sj_dir=qxxz&pardir=supervise"><font color="#FF0000">行政效能投诉</font></a></td>
          </tr>
          <tr>
            <td height="24" align="left"><img src="imagesnew/indexWJ_topicon04.gif" width="5" height="5" hspace="4" /></td>
            <td><a href="/website/policy/mailWSZX.jsp?sj_dir=policy_WSZX&pardir=policy">有问题要咨询</a></td>
          </tr>
          <tr>
            <td height="24" align="left"><img src="imagesnew/indexWJ_topicon04.gif" width="5" height="5" hspace="4" /></td>
            <td><a href="/website/supervise/other.jsp?sj_dir=OT_TS&pardir=supervise">有情况要信访</a></td>
          </tr>
          <%
			sqlStr = "select * from (select * from tb_frontinfo where fs_id in (select fs_id from tb_frontsubject where fs_code='want') order by fi_sequence) where rownum <= 4";
			vPage = dImpl.splitPageOpt(sqlStr,4,1);

			if(vPage!=null) {
				for(int i=0;i<vPage.size();i++) {
					content = (Hashtable) vPage.get(i);
					String fi_title  = content.get("fi_title").toString();
					//String fi_titleShow = fi_title;
					//if(fi_titleShow.length()>13) fi_titleShow = fi_titleShow.substring(0,12)+"..";
					String fi_url = content.get("fi_url").toString();
					String fi_fileFlag = content.get("ct_fileflag").toString();
					fi_fileFlag = "".equals(fi_fileFlag) ? "0" : fi_fileFlag;
		   %>
          <tr>
            <td height="24" align="left"><img src="imagesnew/indexWJ_topicon04.gif" width="5" height="5" hspace="4" /></td>
            <td><a href="<%=fi_url%>" title="<%=fi_title%>"><font color="#375C85"><%=CWebTools.sperateFontColor(fi_fileFlag,fi_title,13)%></font></a></td>
          </tr>
		  <%
				}
			}
		  %>
          <tr>
            <td height="24" align="left"><img src="imagesnew/indexWJ_topicon04.gif" width="5" height="5" hspace="4" /></td>
            <td><a href="/website/policy/voteList.jsp?sj_dir=policy_WSPY&sort=0">参加网上评议</a></td>
          </tr>
          <tr>
            <td height="24" align="left"><img src="imagesnew/indexWJ_topicon04.gif" width="5" height="5" hspace="4" /></td>
            <td><a href="/website/policy/voteList.jsp?sj_dir=policy_WSDC&sort=1">做做网上调查</a></td>
          </tr>
          <tr>
            <td height="10" colspan="2"></td>
            </tr>
        </table></td>
        </tr>
      </table>
      <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td height="24" align="right" valign="bottom" background="imagesnew/indexWJ_rightTitle03.gif"><a href="/website/policy/returnList.jsp?sj_dir=policy_jrxffk&pardir=policy">更多&gt;&gt;</a>&nbsp;&nbsp;</td>
        </tr>
        <tr>
          <td valign="top" background="imagesnew/indexWJ_rightTitle04.gif"><table width="90%" border="0" align="center" cellpadding="0" cellspacing="0">
            <tr>
              <td height="5" colspan="2"></td>
            </tr>
            <%
            //信访反馈
			sqlStr = "select * from (select cw_id,cw_applyingname,cw_subject from tb_connwork where cw_status = 3 and cw_finishtime is not null  order by cw_finishtime desc) where rownum <= 4";
			ii = 0;
			String cw_id = "";
			String applyingname = "";
			String cw_subject = "";
			vPage = dImpl.splitPageOpt(sqlStr,request,4);
			if(vPage!=null) {
				for(int i=0;i<vPage.size();i++) {
					content = (Hashtable)vPage.get(i);
					cw_id = content.get("cw_id").toString();
					//applyingname = content.get("cw_applyingname").toString();
					applyingname = content.get("cw_subject").toString();
					us_message = "关于“" + applyingname + "”的反馈";
					ctTitle = us_message.length() > 13 ? us_message.substring(0,12) + ".." : us_message;
					ii++;
          %>
            <tr>
              <td width="18" height="26" align="left" valign="bottom"><img src="imagesnew/indexWJ_topicon02.gif" width="3" height="3" hspace="5" vspace="8" /></td>
              <td valign="bottom"><a href="/website/usercenter/index.jsp" title="<%=us_message%>"><%=ctTitle%></a></td>
            </tr>
            <tr>
              <td height="1" colspan="2" background="imagesnew/indexWJ_line01.jpg"></td>
            </tr>
		  <%
				}
			}
			for(;ii < 4;ii++) {
		  %>
            <tr>
              <td width="18" height="26" align="left" valign="bottom"><img src="imagesnew/indexWJ_topicon02.gif" width="3" height="3" hspace="5" vspace="8" /></td>
              <td valign="bottom">&nbsp;</td>
            </tr>
            <tr>
              <td height="1" colspan="2" background="imagesnew/indexWJ_line01.jpg"></td>
            </tr>
		  <%}%>
            <tr>
              <td height="14" colspan="2"></td>
              </tr>
          </table></td>
        </tr>
      </table>
      <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td height="24" background="imagesnew/indexWJ_rightTitle06.gif"></td>
        </tr>
        <tr>
          <td valign="top" background="imagesnew/indexWJ_rightTitle04.gif"><table width="170" border="0" align="center" cellpadding="0" cellspacing="0">
            <tr>
              <td height="5" colspan="2"></td>
              </tr>
			  <%
				String spe_fi_title = "";
				String spe_fi_url   = "";
				vPage = null;
				sqlStr = "select i.fi_title,i.fi_url from tb_frontinfo i,tb_frontsubject s where s.fs_code = 'specialWebLink' and i.fs_id = s.fs_id order by i.fi_sequence";	
				vPage = dImpl.splitPageOpt(sqlStr,request,12);
				if (vPage != null) {
					for (int i=0;i<vPage.size();i++) {
						content = (Hashtable)vPage.get(i);
						spe_fi_title = content.get("fi_title").toString();
						spe_fi_url   = content.get("fi_url").toString();
			
						if (i%2 == 0) out.print("<tr>");
			  %>
              <td height="26" align="center"><a href="<%=spe_fi_url%>" class="F12L_wjj" target="_blank">[ <%=spe_fi_title%> ]</a></td>
            <%
						if (i%2 == 1) out.print("</tr>");
            		}
            	}
            %>
            <tr>
              <td height="10" colspan="2"></td>
              </tr>
          </table></td>
        </tr>
      </table><table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td height="24" background="imagesnew/indexWJ_rightTitle05.gif"></td>
        </tr>
        <tr>
          <td valign="top" background="imagesnew/indexWJ_rightTitle04.gif"><table width="100%" border="0" cellspacing="0" cellpadding="0">
            <tr>
              <td height="12">&nbsp;</td>
            </tr>
			<form action=http://211.144.95.139:8080/cgi-bin/web.cgi method=get name="serviecfrm" target='_blank'>
            <tr>
              <td height="32" align="center" valign="top"><select name="ch_id_1" class="select-01" style="width:150px">
                <option value=7>上海浦东</option>
                <option value=6>浦东站群</option>
                <option value=>互联网</option>
              </select>
              </td>
            </tr>
            <tr>
              <td height="32" align="center" valign="top"><table width="150" border="0" cellspacing="0" cellpadding="0">
                <tr>
                  <td align="left" valign="top"><input type="text" name="query_text" style="width:114px" class="input-text01" value="关键字"/></td>
                  <td align="right"><img src="imagesnew/indexWJ_topicon07.gif" width="19" height="19" border="0" style="cursor:hand" onClick="do_Search()"/></td>
                </tr>
              </table></td>
            </tr>
            <script language="javascript">
            	function do_Search() {
            		var ch_id = document.serviecfrm.ch_id_1.value;
            		var endStr = document.serviecfrm.query_text.value;
            		if("良宇" == endStr || "陈良宇" == endStr){
				  		alert("没有找到你要查找的内容！");
				  		return false;
				  	}else{
	            		document.serviecfrm.ch_id.value = ch_id;
	            		document.serviecfrm.query.value = endStr;
				  		document.serviecfrm.submit();
				  	}
            	}
            </script>
			<input type=hidden value=wst name=tn>
			<input type=hidden value=0 name=iftitle>
			<input type=hidden value="Last-Modified DESC" name=sort>
			<input type=hidden name=c1>
			<input type=hidden name=from_date>
			<input type=hidden name=to_date>
			<input type=hidden value=10 name=rn>
			<input type=hidden name=content>
			<input type=hidden value=0 name=pn>
			<input type=hidden value=1 name=relative>
			<input type=hidden name=title>
			<input type=hidden name=content>
			<input type=hidden value=0 name=table_id>
			<input type=hidden name=file_type>
			<input type=hidden name=source_type>
			<input type=hidden value=1  name=thesaurus>
			<input type=hidden value=1 name=smart_abstract>
			<input type=hidden name=categories_id>
			<input type=hidden name=ch_id value=>
			<input type=hidden name=query value=>
            </form>
            <tr>
              <td height="8"></td>
            </tr>
          </table></td>
        </tr>
      </table><table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td height="24" background="imagesnew/indexWJ_rightTitle07.gif"></td>
        </tr>
        <tr>
          <td valign="top" background="imagesnew/indexWJ_rightTitle04.gif"><table width="90%" border="0" align="center" cellpadding="0" cellspacing="0">
            <tr>
              <td height="2" colspan="2"></td>
            </tr>
            <%
      		sf_right = new StringBuffer();
			ctIdSql_right = "select ct_id from tb_contentpublish where sj_id in (select sj_id "+
							 "from tb_subject connect by prior sj_id = sj_parentid start with sj_dir='inform_Array') order by ct_id desc";
			ctIdVec_right = dImpl.splitPage(ctIdSql_right,50,1);
			if(ctIdVec_right != null){
				for(int cnt = 0; cnt < ctIdVec_right.size(); cnt++){
					ctIdTable_right = (Hashtable) ctIdVec_right.get(cnt);
					sf_right.append(ctIdTable_right.get("ct_id").toString());
					if(cnt != (ctIdVec_right.size() - 1))
						sf_right.append(",");
				}
			}
			
			sqlStr = "select distinct ct_id,dt_id,ct_title,ct_create_time,ct_url,ct_specialflag from tb_content where ct_id in ("+sf_right.toString()+") order by to_date(ct_create_time,'YYYY-MM-DD') desc,ct_id desc";
			ii = 0;
			vPage = dImpl.splitPageOpt(sqlStr,request,10);
			if(vPage!=null) {
				for(int i=0;i<vPage.size();i++) {
					content = (Hashtable)vPage.get(i);
					ctTitle = content.get("ct_title").toString();
					specialFlag = content.get("ct_specialflag").toString();
					ctId = content.get("ct_id").toString();
					ctUrl = content.get("ct_url").toString();
					href = !ctUrl.equals("") ? ctUrl : "/website/pudongNews/InfoContent.jsp?sj_dir=pudongNews_inform&ct_id=" + ctId;
					ii++;
          %>
            <tr>
              <td width="18" height="26" align="right" valign="bottom"><font color="#666666"><%=i+1%>.</font></td>
              <td valign="bottom"><a href="<%=href%>" title="<%=ctTitle%>"><%=CWebTools.sperateFontColor(specialFlag,ctTitle,13)%></a></td>
            </tr>
            <tr>
              <td height="1" colspan="2" background="imagesnew/indexWJ_line01.jpg"></td>
            </tr>
		  <%
				}
			}
			for(;ii < 10;ii++) {
		  %>
            <tr>
              <td width="18" height="26" align="left" valign="bottom"><img src="imagesnew/indexWJ_topicon02.gif" width="3" height="3" hspace="5" vspace="8" /></td>
              <td valign="bottom">&nbsp;</td>
            </tr>
            <tr>
              <td height="1" colspan="2" background="imagesnew/indexWJ_line01.jpg"></td>
            </tr>
		  <%}%>
            <tr>
              <td height="14" colspan="2"></td>
              </tr>
          </table></td>
        </tr>
        <tr>
          <td height="3" bgcolor="#8F8B8C"></td>
        </tr>
    </table>
      <table width="100%" border="0" cellpadding="0" cellspacing="0" background="imagesnew/indexWJ_rightTitle06.jpg">
        <tr>
          <td height="14" colspan="3"></td>
        </tr>
        <tr>
          <td width="32" height="28" align="right" class="f13"><font color="#666666">第</font></td>
          <td align="center">
			<iframe src="/website/iframe/indexnew/count.jsp" name="picPDPreview" width='80' height="24" marginwidth="0" allowTransparency="true" marginheight="0" align="center" scrolling="no" frameborder="0"></iframe>
		  </td>
          <td width="66" align="left" class="f13"><font color="#666666">位访问者</font></td>
        </tr>
      </table>