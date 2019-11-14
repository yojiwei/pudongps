
<%
//Update 20061231
 try{
    
%>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
	<td height="6"></td>
  </tr>
</table>
  <table width="518" border="0" cellspacing="0" cellpadding="0">
	
	<tr>
	  <td valign="bottom" background="../images/new_policy_subTitleAdd.gif" style="background-repeat:no-repeat; background-position:bottom">
	   <table border="0" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF">
		<tr>
		  <td width="30"><img src="../images/ico06.gif" width="17" height="17" /></td>
		  <td width="82" class="font-title02">网上评议</td>
		</tr>
	   </table>
	  </td>
	</tr>
	
	<tr>
	  <td height="10"></td>
	</tr>
	<tr>
	  <td valign="top"><table width="100%" border="0" cellspacing="0" cellpadding="0">
		<tr>
		  <td width="155"><table width="150" border="0" cellspacing="0" cellpadding="3">
			<tr>
			  <td height="102" valign="top" background="../images/new_policy_photoBg.gif"><img src="../images/new_policy_photo01.jpg" width="136" height="92" /></td>
			</tr>
		  </table></td>
		  <td valign="top"><table width="100%" border="0" cellspacing="0" cellpadding="6">
			<tr>
			  <td height="6"></td>
			</tr>
						
			<%
				sqlStr = "SELECT c.ct_id,c.ct_title,d.ct_content,c.ct_create_time,c.ct_url,c.ct_specialflag " +
					     "FROM tb_content c , tb_contentpublish p , tb_subject s " +
					     ",tb_contentdetail d where d.ct_id=c.ct_id and p.ct_id = c.ct_id AND " + 
							   "p.sj_id = s.sj_id AND " + 
							   "s.sj_dir = 'policy_WSPY' AND " + 
							   "p.cp_ispublish = 1 " +
							   "ORDER BY TO_DATE(ct_create_time,'YYYY-MM-DD') DESC";
				vPage = dImpl.splitPageOpt(sqlStr,4,1);	//获得查询结果
				//String contentWSPY = "";
				 if(vPage != null){
				   content = (Hashtable)vPage.get(0);
				   ct_id = content.get("ct_id").toString();
				   ct_title = content.get("ct_title").toString();
				   //trimedContent =  content.get("ct_content").toString().substring(0,60)+"...";
				   ct_content =  content.get("ct_content").toString();				   	       
				   trimedContent = CWebTools.patternStr(ct_content,70)+"...";
				 }else{
				   trimedContent = "无记录!";
				 } 
				 
				 //if(vPage != null)1	
				
				 //content = (Hashtable)vPage.get(0);
			   	 //String contentWSPY = content.get("ct_content").toString().substring(0,60)+"...";
		    %>
			
			<tr>
			  <td align="center" valign="top" bgcolor="#FFF4EE"><table width="96%" border="0" cellspacing="0" cellpadding="0">
				<tr>
				  <td height="26" valign="top" class="f12WH"><strong><font color="#DE2703"><%=ct_title%></font></strong></td>
				</tr>
				<tr>
				  <td class="f12H">　
				    <%=trimedContent%>　
					<a href="/website/policy/infoContent.jsp?sj_dir=policy_WSPY&ct_id=<%=ct_id%>">
					  <font color="#DE2703">&gt;&gt;查看全文</font>
					</a>
				   </td>
				</tr>

			  </table></td>
			</tr>
			<tr>
			  <td height="6"></td>
			</tr>
		  </table></td>
		</tr>
	  </table></td>
	</tr>
	<tr>
	  <td valign="top">
	   <table width="518" border="0" cellspacing="0" cellpadding="0">
		<tr>
		  <td height="6"></td>
		  <td></td>
		</tr>
		
		<%	
			if(vPage != null){
				for(int i = 0 ; i < vPage.size() ; i ++ ){
					content = (Hashtable)vPage.get(i);
					ct_id = content.get("ct_id").toString();
					ct_title = content.get("ct_title").toString();
					ct_create_time = content.get("ct_create_time").toString();
					ct_url = content.get("ct_url").toString();
					//判断标题长度，若过长则需截取
					if(ct_title.length() > 20){
					   ct_title = ct_title.substring(0,18)+"......" ;				
					}
	     %>		
				<tr>
				  <td width="20" height="28" class="font-list01"><font color="#FF0000">·</font></td>
				  <td class="font-list01">
				    <a href="/website/policy/infoContent.jsp?sj_dir=policy_WSPY&ct_id=<%=ct_id%>">
					  <%=ct_title%>
					</a> (<%=ct_create_time%>)
				  </td>
				</tr>
		
		<% 
	            }//for	
           }else{
		%>
				<tr>
				  <td width="20" height="28" class="font-list01"><font color="#FD0002">·</font></td>
				  <td class="font-list01"><a href="#">无记录！</a>  </td>
				</tr>

	   <%
		   }//if-else		 
	   %>	
				
		<tr>
		  <td height="28"></td>
		  <td align="right">
		    <a href="/website/policy/infoList.jsp?sj_dir=policy_WSPY" class="three">
			   更多>>
			</a>&nbsp;
	      </td>
		</tr>				
	  </table>
	 </td>
	</tr>
  </table>
  <table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
	  <td height="30"></td>
	</tr>
  </table>
  <table width="518" border="0" cellspacing="0" cellpadding="0">
  
	<tr>
	  <td background="../images/new_policy_subTitleAdd.gif" style="background-repeat:no-repeat; background-position:bottom"><table border="0" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF">
		<tr>
		  <td width="30"><img src="../images/ico06.gif" width="17" height="17" /></td>
		  <td width="82" class="font-title02">网上调查</td>
		</tr>
	  </table></td>
	</tr>
	
	<tr>
	  <td height="10"></td>
	</tr>
	<tr>
	  <td valign="top"><table width="100%" border="0" cellspacing="0" cellpadding="0">
		  <tr>
			<td width="155"><table width="150" border="0" cellspacing="0" cellpadding="3">
				<tr>
				  <td height="102" valign="top" background="../images/new_policy_photoBg.gif"><img src="../images/new_policy_photo02.jpg" width="136" height="92" /></td>
				</tr>
			</table></td>
			<td valign="top"><table width="100%" border="0" cellspacing="0" cellpadding="6">
				<tr>
				  <td height="6"></td>
				</tr>
				<%
				 sqlStr = "SELECT c.ct_id,c.ct_title,d.ct_content,c.ct_create_time,c.ct_url,c.ct_specialflag " +
						  "FROM tb_content c , tb_contentpublish p , tb_subject s " +
						  ",tb_contentdetail d where d.ct_id=c.ct_id and p.ct_id = c.ct_id AND " + 
							    "p.sj_id = s.sj_id AND " + 
							    "s.sj_dir = 'policy_WSDC' AND " + 
							    "p.cp_ispublish = 1 " +
							    "ORDER BY TO_DATE(ct_create_time,'YYYY-MM-DD') DESC";
				 //out.print(sqlStr);							   
				 vPage = dImpl.splitPageOpt(sqlStr,4,1);	//获得查询结果
				 
				 if(vPage != null){
				   content = (Hashtable)vPage.get(0);
				   ct_id = content.get("ct_id").toString();
				   ct_title = content.get("ct_title").toString();
				   //trimedContent =  content.get("ct_content").toString().substring(0,60)+"...";				   	       
				   ct_content =  content.get("ct_content").toString();				   	       
				   trimedContent = CWebTools.patternStr(ct_content,60)+"...";
				 }else{
				   trimedContent = "无记录!";
				 }  
				
				%>
				<tr>
				  <td align="center" valign="top" bgcolor="#FFF4EE"><table width="96%" border="0" cellspacing="0" cellpadding="0">
					  <tr>
						<td height="26" valign="top" class="f12WH"><strong><font color="#DE2703"><%=ct_title%></font></strong></td>
					  </tr>
					  <tr>
						<td class="f12H"> 
						  <%=trimedContent%>
						  <a href="/website/policy/infoContent.jsp?sj_dir=policy_WSDC&ct_id=<%=ct_id%>"><font color="#DE2703"> &gt;&gt;查看全文</font></a></td>
					  </tr>
				  </table></td>
				</tr>
				<tr>
				  <td height="6"></td>
				</tr>
			</table></td>
		  </tr>
	  </table></td>
	</tr>
	<tr>
	  <td valign="top"><table width="518" border="0" cellspacing="0" cellpadding="0">
		  <tr>
			<td height="6"></td>
			<td></td>
		  </tr>
		  <%
			if(vPage != null){
				for(int i = 0 ; i < vPage.size() ; i ++ ){
					content = (Hashtable)vPage.get(i);
					ct_id = content.get("ct_id").toString();
					ct_title = content.get("ct_title").toString();
					ct_create_time = content.get("ct_create_time").toString();
					ct_url = content.get("ct_url").toString();
					//判断标题长度，若过长则需截取
					if(ct_title.length() > 20){
					   ct_title = ct_title.substring(0,18)+"......" ;				
					}
	      %>		
				<tr>
				  <td width="20" height="28" class="font-list01"><font color="#FF0000">·</font></td>
				  <td class="font-list01">
				    <a href="/website/policy/infoContent.jsp?sj_dir=policy_WSDC&ct_id=<%=ct_id%>">
					  <%=ct_title%>
					</a> (<%=ct_create_time%>)
				  </td>
				</tr>
		
		  <% 
	            }//for	
           }else{
		   %>
				<tr>
				  <td width="20" height="28" class="font-list01"><font color="#FD0002">·</font></td>
				  <td class="font-list01"><a href="#">无记录！</a>  </td>
				</tr>

	      <%
		   }//if-else		 
	      %>	
		 
		  <tr>
			<td height="28"></td>
			<td align="right">
			   <a href="/website/policy/infoList.jsp?sj_dir=policy_WSDC" class="three">
			      更多&gt;&gt;
			   </a>&nbsp;
			 </td>
		  </tr>
	  </table></td>
	</tr>
  </table>
  <table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
	  <td height="30"></td>
	</tr>
  </table>
  
<%
  }catch(Exception ex){
      out.print(ex.toString()+"<br>");
      throw new Exception("/website/policy/include/policyContent.jsp  is error!");  
  }
%>
