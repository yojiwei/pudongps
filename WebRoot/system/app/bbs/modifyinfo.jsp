<%@page contentType="text/html; charset=gb2312" language="java" import="java.sql.*"  %>
<html>
<head>
<link rel='stylesheet' type='text/css' href='inc/FORUM.CSS'>
<META NAME="keywords" CONTENT=" 论坛  java forum jsp forum">
<META NAME="description" CONTENT=" 论坛  java forum jsp forum">
<script language="JavaScript"> 
function Popup(url, window_name, window_width, window_height) 
{ settings= 
"toolbar=no,location=no,directories=no,"+ 
"status=no,menubar=no,scrollbars=yes,"+ 
"resizable=yes,width="+window_width+",height="+window_height; 

NewWindow=window.open(url,window_name,settings); }

function icon(theicon) { 
document.input.message.value += " "+theicon; 
document.input.message.focus(); 
} 
</script>

<title>论坛</title>
<SCRIPT LANGUAGE="JavaScript">
<!-- 
function CheckValue()//检查标题内容是否为空值
{
 var name=document.all.name.value;
  var re=/( )/gi
  name=name.replace(re,"")
  re=/\</gi
  name=name.replace(re,"&lt;")
  if(name==""||name.length<1)
  {
    alert("用户名不能为空");
    document.all.name.focus();
    return false;
  }
  document.all.name.value=name;
  TheText=document.all.email.value;
  var re=/( )/gi
  TheText=TheText.replace(re,"")
  if(TheText=="")
  {
        alert("内容不能为空");
    document.all.email.focus();
    return false;
  }

  if (form1.mobile.value!="")
   {
    if(checkNumber1(form1.mobile.value)==false)
		return false;
   } 
   if (form1.oicq.value!="")
   {
    if(checkNumber2(form1.oicq.value)==false)
		return false;
   } 
  
  return true;
}

function checkNumber1(TempS)
{
 for(Count=0;Count<TempS.length;Count++)
 {
    TempChar=TempS.substring(Count,Count+1);
    RefString="0123456789";
     if (RefString.indexOf(TempChar,0)==-1)
      {
       alert("手机号码有非法字符，请输入数字");
       form1.mobile.focus();
	   return false;
      }
 }
}
function checkNumber2(TempS)
{
 for(Count=0;Count<TempS.length;Count++)
 {
    TempChar=TempS.substring(Count,Count+1);
    RefString="0123456789";
     if (RefString.indexOf(TempChar,0)==-1)
      {
       alert("OICQ有非法字符，请输入数字");
       form1.oicq.focus();
	   return false;
      }
 }
}



function Popup(url, window_name, window_width, window_height) 
{ settings= 
"toolbar=no,location=no,directories=no,"+ 
"status=no,menubar=no,scrollbars=yes,"+ 
"resizable=yes,width="+window_width+",height="+window_height; 

NewWindow=window.open(url,window_name,settings); }

function icon(theicon) { 
document.input.message.value += " "+theicon; 
document.input.message.focus(); 
} 
</script>
<title>论坛</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
</head>
<body text="#0000ff" > 
<jsp:include page="inc/public.jsp" flush="true"/>
<table width="760" cellspacing="0" cellpadding="0" align="center">

<tr>
    <td bgcolor="#ffffff"  width="501"> <a href="../default1.asp"><br>
      首页</a>&gt;&gt;<a href="index.jsp">论坛</a>&gt;&gt;修改资料</td>
    <td bgcolor="#ffffff" class="post" align="right" width="230">　</td>
  </tr></table>

<jsp:useBean id="yy" scope="page" class="yy.jdbc"/>
<%!String User_Name,User_Password,sql,User_Sex,User_Email,User_Address,User_Mobile,User_ur_oicq,User_Birthay,User_Icon,User_Sign;%>
<%
Connection con=yy.getConn();
Statement  stmt=con.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_READ_ONLY);
ResultSet  rs=null;
sql="select * from USERINFO where ur_loginname='"+session.getValue("UserName")+"'";
rs=stmt.executeQuery(sql);
rs.last();
if (rs.getRow()>0)
{
	    User_Name=rs.getString("ur_loginname");
		User_Password=rs.getString("ur_password");
		User_Sex=rs.getString("ur_sex");
		User_Email=rs.getString("ur_email");
		User_Address=rs.getString("ur_address");
		User_Mobile=rs.getString("mobilephone");
		User_ur_oicq=rs.getString("ur_oicq");
		User_Birthay=rs.getString("ur_birthday");
		User_Sign=rs.getString("ur_sign");
        User_Icon=rs.getString("ur_portrait");
}
%>
<table border="0" cellspacing="1" cellpadding="3" width="743"  bgcolor="#009ACE">
<form method="post" name=form1  action="modifyuser.jsp">                  
				  
				  <tr bgcolor="#FFFFFF" height="30"> 
                    <td colspan="2" height="30" width="731" bgcolor="#9CCFFF">修改资料- 必填的项目：</td>
                  </tr>
                  <tr bgcolor="#FFFFFF"> 
                    <td width="235" class="tablerow" height="25"  >用户名称</td>
                    <td class="tablerow" height="25" width="486"> 
                      <input type="text" disabled  name="name" size="30" maxlength="25" value=<%=User_Name%>>
                      <font color="#FF0000">***不能含有非法字符</font></td>         
                  </tr>       
                  <tr bgcolor="#FFFFFF">        
                    <td class="tablerow" height="25" width="235" bgcolor="#C6EFFF">用户密码</td>       
                    <td class="tablerow" height="25" width="486" bgcolor="#C6EFFF">        
                      <input type="password" name="password" size="30" value=<%=User_Password%>>       
                      <font color="#FF0000">***长度不能大于12小于6</font></td>         
                  </tr>       
                  <tr bgcolor="#FFFFFF">        
                    <td class="tablerow" height="25" width="235" bgcolor="#C6EFFF">重复密码</td>      
                    <td class="tablerow" height="25" width="486" bgcolor="#C6EFFF">       
                      <input type="password" name="password2" size="30" value=<%=User_Password%>>      
                      <font color="#FF0000">***长度不能大于12小于6</font></td>         
                  </tr>       
                      
       
                         
                  <tr bgcolor="#FFFFFF">        
                    <td class="tablerow" height="16" width="235" bgcolor="#FFFFFF">用户性别</td>      
                    <td class="tablerow" height="16" width="486" bgcolor="#FFFFFF">       
                      <input type="radio" name="sex" value="男"   
					  <%  
					  if (User_Sex.equals("男"))  
					  out.println("checked");  
					    
					  %>  
					    
					  >      
                      男&nbsp; <input type="radio" name="sex" value="女"  
					  					  <%  
					  if (!User_Sex.equals("男"))  
					  out.println("checked");  
					    
					  %>  
					    
					    
					  >      
                      女&nbsp;</td>         
                  </tr>       
                  <tr bgcolor="#FFFFFF">        
                    <td class="tablerow" height="1" width="235">E-Mail</td>      
                    <td class="tablerow" height="1" width="486">       
                      <input type="text" name="email" size="30"  value=<%=User_Email%>>      
                      <font color="#FF0000">***</font></td>      
                  </tr>      
                  <tr bgcolor="#FFFFFF">       
                    <td colspan="2"  height="30" width="731" bgcolor="#9CCFFF">修改资料   
                      - 可选的项目：</td>        
                  </tr>        
                    <tr bgcolor="#FFFFFF">       
                    <td class="tablerow" height="1" width="235" bgcolor="#C0EFFE">手机号码</td>      
                    <td class="tablerow" height="1" width="486" bgcolor="#C0EFFE">       
                      <input type="text" name="mobile" size="30" value=<%=User_Mobile%>>      
                      </td>        
                  </tr>     
				       
				       
				  <tr bgcolor="#FFFFFF">       
                    <td class="tablerow" height="4" width="235">家庭地址</td>      
                    <td class="tablerow" height="4" width="486">       
                      <input type="text" name="address" size="30" value=<%=User_Address%> >      
                    </td>      
                  </tr>      
                  <tr bgcolor="#FFFFFF">       
                    <td class="tablerow" height="1" width="235" bgcolor="#C6EFFF">OICQ:</td>      
                    <td class="tablerow" height="1" width="486" bgcolor="#C6EFFF">       
                      <input type="text" name="ur_oicq" size="30" value=<%=User_Oicq%> >      
                    </td>      
                  </tr>      
                  <tr bgcolor="#FFFFFF">       
                    <td class="tablerow" height="1" width="235">出生年生日：</td>      
                    <td class="tablerow" height="1" width="486">       
                      <input type="text" name="birthday" size="30" value=<%=User_Birthay%>>      
                      </td>        
                  </tr>      
                  <tr bgcolor="#FFFFFF">       
                    <td class="tablerow" height="1" width="235" bgcolor="#C6EFFF">头像地址</td>      
                    <td class="tablerow" height="1" width="486" bgcolor="#C6EFFF">       
                      <table>      
                        <tr>       
                          <td>       
                            <select name=icon size=1 onChange="document.images['avatar'].src=options[selectedIndex].value;" style="BACKGROUND-COLOR: #FFFFFF; BORDER-BOTTOM: 1px double; BORDER-LEFT: 1px double; BORDER-RIGHT: 1px double; BORDER-TOP: 1px double; COLOR: #000000">      
                              
							  <option value='<%=User_Icon%>'>Image1</option>
							  <option value='./PIC/Image1.gif'>Image1</option>
                              <option value='./PIC/Image2.gif'>Image2</option>
                              <option value='./PIC/Image3.gif'>Image3</option>
                              <option value='./PIC/Image3.gif'>Image3</option>
                              <option value='./PIC/Image4.gif'>Image4</option>
                              <option value='./PIC/Image5.gif'>Image5</option>
                              <option value='./PIC/Image6.gif'>Image6</option>
                              <option value='./PIC/Image7.gif'>Image7</option>
                              <option value='./PIC/Image8.gif'>Image8</option>
                              <option value='./PIC/Image9.gif'>Image9</option>
                              <option value='./PIC/Image10.gif'>Image10</option>
                              <option value='./PIC/Image11.gif'>Image11</option>
                              <option value='./PIC/Image12.gif'>Image12</option>
                              <option value='./PIC/Image13.gif'>Image13</option>
                              <option value='./PIC/Image14.gif'>Image14</option>
                              <option value='./PIC/Image15.gif'>Image15</option>
                              <option value='./PIC/Image16.gif'>Image16</option>
                              <option value='./PIC/Image17.gif'>Image17</option>
                              <option value='./PIC/Image18.gif'>Image18</option>
                              <option value='./PIC/Image19.gif' >Image19</option>
                              <option value='./PIC/Image20.gif'>Image20</option>
                              <option value='./PIC/Image21.gif'>Image21</option>
                              <option value='./PIC/Image22.gif'>Image22</option>
                              <option value='./PIC/Image23.gif'>Image23</option>
                              <option value='./PIC/Image24.gif'>Image24</option>
                              <option value='./PIC/Image25.gif'>Image25</option>
                              <option value='./PIC/Image26.gif'>Image26</option>
                              <option value='./PIC/Image27.gif'>Image27</option>
                              <option value='./PIC/Image28.gif'>Image28</option>
                              <option value='./PIC/Image29.gif'>Image29</option>
                              <option value='./PIC/Image30.gif'>Image30</option>
                              <option value='./PIC/Image31.gif'>Image31</option>
                              <option value='./PIC/Image32.gif'>Image32</option>
                              <option value='./PIC/Image33.gif'>Image33</option>
                              <option value='./PIC/Image34.gif'>Image34</option>
                              <option value='./PIC/Image35.gif'>Image35</option>
                              <option value='./PIC/Image36.gif'>Image36</option>
                              <option value='./PIC/Image37.gif'>Image37</option>
                              <option value='./PIC/Image38.gif'>Image38</option>
                              <option value='./PIC/Image39.gif'>Image39</option>
                              <option value='./PIC/Image40.gif'>Image40</option>
                              <option value='./PIC/Image41.gif'>Image41</option>
                              <option value='./PIC/Image42.gif'>Image42</option>
                              <option value='./PIC/Image43.gif'>Image43</option>
                              <option value='./PIC/Image44.gif'>Image44</option>
                              <option value='./PIC/Image45.gif'>Image45</option>
                              <option value='./PIC/Image46.gif'>Image46</option>
                              <option value='./PIC/Image47.gif'>Image47</option>
                              <option value='./PIC/Image48.gif'>Image48</option>
                              <option value='./PIC/Image49.gif'>Image49</option>
                              <option value='./PIC/Image50.gif'>Image50</option>
                              <option value='./PIC/Image51.gif'>Image51</option>
                              <option value='./PIC/Image52.gif'>Image52</option>
                              <option value='./PIC/Image53.gif'>Image53</option>
                              <option value='./PIC/Image54.gif'>Image54</option>
                              <option value='./PIC/Image55.gif'>Image55</option>
                              <option value='./PIC/Image56.gif'>Image56</option>
                              <option value='./PIC/Image57.gif'>Image57</option>
                              <option value='./PIC/Image58.gif'>Image58</option>
                              <option value='./PIC/Image59.gif'>Image59</option>
                              <option value='./PIC/Image60.gif'>Image60</option>
                            </select>
                          </td>
                          <td width=180 height=32>&nbsp;&nbsp;<img id=avatar src="./PIC/Image1.gif" alt=个人形象代表 width="32" height="32">&nbsp;-          
                            选择自己满意的头像</td>       
                        </tr>       
                      </table>       
                    </td>       
                  </tr>       
                  <tr bgcolor="#FFFFFF">        
                    <td class="tablerow" height="0" width="235">个人签名：<br />      
                      HTML 开启<br />        
                    </td>      
                    <td class="tablerow" height="0" width="486">       
                      <textarea rows="4" cols="45" name="sign"><%=User_Sign%></textarea>      
                    </td>      
                  </tr>      
                  <tr bgcolor="#FFFFFF">       
                    <td class="tablerow" height="0" colspan="2" width="731" bgcolor="#C6EFFF">       
                      <div align="center">       
                        <input type="submit" name="regsubmit" onclick='return CheckValue()'; value="修  改" />      
                      </div>      
                    </td>      
                  </tr>      
                  </form> 
				</table>               
<jsp:include page="inc/jumpboard.jsp" flush="true"/>   
</body></html>    

<html><script language="JavaScript"></script></html>
<jsp:include page="inc/online.jsp" flush="true"/>