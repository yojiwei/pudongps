<%@page contentType="text/html; charset=GBK"%>
<script LANGUAGE="javascript">
function show_time(obj)
{   
    if(obj.value==2){showText_1.style.display = "none"; showText_2.style.display = "";}
    else{showText_1.style.display="";showText_2.style.display="none";}
}
function showCal(obj)
{
        if (!obj) var obj = event.srcElement;
        var obDate;
        if ( obj.value == "" ) {
                obDate = new Date();
        } else {
                var obList = obj.value.split( "-" );
                obDate = new Date( obList[0], obList[1]-1, obList[2] );
        }

        var retVal = showModalDialog( "/system/common/calendar/calendar.htm", obDate,
                "dialogWidth=206px; dialogHeight=206px; help=no; scroll=no; status=no; " );

        if ( typeof(retVal) != "undefined" ) {
                var year = retVal.getFullYear();
                var month = retVal.getMonth()+1;
                var day = retVal.getDate();
                obj.value =year + "-" + month + "-" + day;
        }
}
function ser()
{     
      if(document.formWSearch.search_time.value==""){  
      if(document.formWSearch.search.value.replace(/(^\s*)|(\s*$)/g, "") =="")
        {
                alert("请输入关键字查询！");
               document.formWSearch.search.focus();
                return false;
        }
        }
         document.formWSearch.submit();
}
</script>
 <%String sendUrl=request.getRequestURI();%>
                     <form name="formWSearch" action="<%=sendUrl%>" method="post">                       
                            <td width="48" align="right" valign="middle"><font color="#AD0000"><strong>查询：</strong></font></td>
                            <td height="26">
                          <select name="sType"  style="width:94px" onchange="show_time(this)">                     
                                <option value="1">项目名称</option>
                                <option value="2">办事日期</option>
                                <option value="3">论坛话题</option>
                          </select>
                          </td>
                            <td width="134" align="center" valign="middle">
                            <div id="showText_1"><input type="text" name="search" style="width:122px" maxlength="500"/></div>
                            <div id="showText_2" style="display:none"><input name="search_time" style="cursor:hand"  readonly  style="width:122px" onclick="showCal()"></div>
                             </td>
                             <td align="left" valign="middle"><img src="images/usercenterNEW_icon15.gif" width="19" height="19" border="0"  onclick = "ser();" style="cursor:hand"/></td>
                    </form>
                     </tr>
                </table>
               
                </td>
              </tr>

<table width="100%" border="0" cellspacing="0" cellpadding="0">   
             <%  if (user!=null){                                                           
                    us_id = user.getId();
                    }
                String new_id="";
                String new_sendtime="";
                String new_title="";
                String istype="";//默认搜索类型为标题搜索
                String search="";
                String type  = CTools.dealString(request.getParameter("sType")).trim();
                if(type.equals("2"))search  = CTools.dealString(request.getParameter("search_time")).trim();
                else search  = CTools.dealString(request.getParameter("search")).trim();
                String sqlSea =""; 
                if(!search.equals("")){            
                if(type.equals("2"))sqlSea = "select '2' as type,ma_id,to_char(ma_sendtime,'yyyy-MM-dd HH24:mi:ss') ma_sendtime,ma_title from tb_message where ma_receiverId='"+us_id+"' and ma_sendtime like to_date('"+search+"','YYYY-MM-DD') order by ma_sendtime desc";
                else if(type.equals("3"))sqlSea = "select '3' as type, post_id as ma_id,to_char(post_date,'yyyy-MM-dd HH24:mi:ss') ma_sendtime,post_title as ma_title from forum_post_pd where post_title like '%"+search+"%' and post_status=1 ";
                else sqlSea = "select '1' as type,ma_id,ma_isnew,to_char(ma_sendtime,'yyyy-MM-dd HH24:mi:ss') ma_sendtime,ma_title from tb_message where ma_receiverId='"+us_id+"' and ma_title like '%"+search+"%' order by ma_sendtime desc";
                Vector vPageSea = null; //out.print("内容:"+search+"类型:"+type+"sql:"+sqlSea);
                vPageSea = dImpl.splitPageOpt(sqlSea,100,1);
                out.print("<tr><td><font color='#072997'>查询结果:</font></td></tr>");
                 %><tr>
                      <td height="1" colspan="25" bgcolor="#ACC2E9"></td>
                 </tr>
                 <tr bgcolor="#F3F4F6">
                      <td width="70%" height="20" align="center" valign="bottom" bgcolor="#F3F4F6"><font color="#072997"><font color="#666666">标&nbsp;&nbsp;&nbsp;&nbsp;题&nbsp;&nbsp;&nbsp;&nbsp;</font></td>
                      <td width="30%" height="20" align="center" valign="bottom" bgcolor="#F3F4F6"><font color="#072997"><font color="#666666">日&nbsp;&nbsp;&nbsp;&nbsp;期&nbsp;&nbsp;&nbsp;&nbsp;</font></td>
                 </tr>
                 <tr>
                      <td height="1" colspan="2" bgcolor="#ACC2E9"></td>
                 </tr>
                <%
                if(vPageSea!=null){
               
                for(int i=0; i<vPageSea.size();i++){
                    content = (Hashtable)vPageSea.get(i);
                    new_id = content.get("ma_id").toString();
                    new_sendtime = content.get("ma_sendtime").toString();
                    new_title = content.get("ma_title").toString();
                    istype = content.get("type").toString();  
             %><tr height="20"><td align="left"  width="70%" valign="bottom">
             <a href="<%if(istype.equals("3"))out.print("/website/pudongForum/revertlist.jsp?post_id="+new_id);else out.print("javascript:readMsg('"+new_id+"','Read');" );%>";title="<%=new_title%>"; <%if(istype.equals("3"))out.print("target='_blank';");%>><%if(new_title.length()>40)out.print("&nbsp;"+new_title.substring(0,40)+"...");else out.print("&nbsp;"+new_title);%>
</a>&nbsp;&nbsp;</td><td width="30%" valign="bottom" align="center" >
<%=new_sendtime%>
&nbsp;&nbsp;
</td></tr> 
            <tr>
               <td height="3" colspan="20" background="images/usercenterNEW_line04.gif"></td>
            </tr>
<%
                    }
                }else out.print("<tr height='20'><td align='left' colspan='2' width='70%' valign='bottom'><font color='#072997'>没有您查询的内容!</font></td></tr>");
               }
%><tr><td height="10"></td></tr>
</table>