<%@page contentType="text/html; charset=gb2312" language="java" import="java.sql.*"  %>
<html>
<head>
<META NAME="keywords" CONTENT=" 论坛  java forum jsp forum">
<META NAME="description" CONTENT=" 论坛  java forum jsp forum">
<link rel='stylesheet' type='text/css' href='inc/FORUM.CSS'>
<link href="/oa30/website/images/main.css" rel="stylesheet" type="text/css">
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
        alert("E_Mail地址不能为空");
    document.all.email.focus();
    return false;
  }

  if (form1.mobile.value!="")
   {
    if(checkNumber1(form1.mobile.value)==false)
		return false;
   } 
   if (form1.ur_oicq.value!="")
   {
    if(checkNumber2(form1.ur_oicq.value)==false)
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
       form1.ur_oicq.focus();
	   return false;
      }
 }
}

// -->
</SCRIPT>
</head>
<body> 
<%@include file="inc/left.jsp"%>
<table border="0" cellspacing="1" cellpadding="3" width="100%" background="<%=URL_HEAD%>website/images/indexsub_leftbg.gif">
<jsp:include page="inc/public.jsp" flush="true"/>
<form method="post" name=form1   action="queryuser.jsp"  onsubmit='return CheckValue();'>                  
				  
				  <tr bgcolor="#F7FBFF" height="30"> 
                    <td colspan="2" height="30" bgcolor="#F7FBFF">修改资料- 必填的项目：</td>
                  </tr>
                  <tr bgcolor="#F7FBFF"> 
                    <td width="20%" class="tablerow" height="25"  >用户名称</td>
                    <td class="tablerow" height="25" > 
                      <input type="text" name="name" size="30" maxlength="25" >
                      <font color="#FF0000">***不能含有非法字符</font></td>         
                  </tr>       
                  <tr bgcolor="#F7FBFF">        
                    <td class="tablerow" height="25" width="20%" bgcolor="#F7FBFF">用户密码</td>       
                    <td class="tablerow" height="25"  bgcolor="#F7FBFF">        
                      <input type="password" name="password" size="30" >       
                      <font color="#FF0000">***长度不能大于12小于6</font></td>         
                  </tr>       
                  <tr bgcolor="#F7FBFF">        
                    <td class="tablerow" height="25" width="20%" bgcolor="#F7FBFF">重复密码</td>      
                    <td class="tablerow" height="25"  bgcolor="#F7FBFF">       
                      <input type="password" name="password2" size="30" >      
                      <font color="#FF0000">***长度不能大于12小于6</font></td>         
                  </tr>       
                      
       
                         
                  <tr bgcolor="#F7FBFF">        
                    <td class="tablerow" height="16" width="20%" bgcolor="#F7FBFF">用户性别</td>      
                    <td class="tablerow" height="16"  bgcolor="#F7FBFF">       
                      <input type="radio" name="sex" checked value="男"   
			
					    
					  >      
                      男&nbsp; <input type="radio" name="sex" value="女"  
			
					    
					  >      
                      女&nbsp;</td>         
                  </tr>       
                  <tr bgcolor="#F7FBFF">        
                    <td class="tablerow" height="1" width="20%">E-Mail</td>      
                    <td class="tablerow" height="1" >       
                      <input type="text" name="email" size="30"  >      
                      <font color="#FF0000">***</font></td>      
                  </tr>      
                  <tr bgcolor="#F7FBFF">       
                    <td colspan="2"  height="30" bgcolor="#F7FBFF">修改资料   
                      - 可选的项目：</td>        
                  </tr>        
                    <tr bgcolor="#F7FBFF">       
                    <td class="tablerow" height="1" width="20%" bgcolor="#F7FBFF">手机号码</td>      
                    <td class="tablerow" height="1"  bgcolor="#F7FBFF">       
                      <input type="text" name="mobile" size="30">      
                      </td>        
                  </tr>     
				       
				       
				  <tr bgcolor="#F7FBFF">       
                    <td class="tablerow" height="4" width="20%">家庭地址</td>      
                    <td class="tablerow" height="4" >       
                      <input type="text" name="address" size="30" >      
                    </td>      
                  </tr>      
                  <tr bgcolor="#F7FBFF">       
                    <td class="tablerow" height="1" width="20%" bgcolor="#F7FBFF">OICQ:</td>      
                    <td class="tablerow" height="1"  bgcolor="#F7FBFF">       
                      <input type="text" name="ur_oicq" size="30"  >      
                    </td>      
                  </tr>      
                  <tr bgcolor="#F7FBFF">       
                    <td class="tablerow" height="1" width="20%">出生年生日：</td>      
                    <td class="tablerow" height="1" >       
                      <input type="text" name="year" size="4" />    
                      年       
                      <select name="month">    
                        <option value="">&nbsp;</option>
                        <option value="01">01</option>
                        <option value="02">02</option>
                        <option value="03">03</option>
                        <option value="04">04</option>
                        <option value="05">05</option>
                        <option value="06">06</option>
                        <option value="07">07</option>
                        <option value="08">08</option>
                        <option value="09">09</option>
                        <option value="10">10</option>
                        <option value="11">11</option>
                        <option value="12">12</option>
                      </select>
                      月       
                      <select name="day">    
                        <option value="">&nbsp;</option>    
                        <option value="1">1</option>    
                        <option value="2">2</option>    
                        <option value="3">3</option>    
                        <option value="4">4</option>    
                        <option value="5">5</option>    
                        <option value="6">6</option>    
                        <option value="7">7</option>    
                        <option value="8">8</option>    
                        <option value="9">9</option>    
                        <option value="10">10</option>    
                        <option value="11">11</option>    
                        <option value="12">12</option>    
                        <option value="13">13</option>    
                        <option value="14">14</option>    
                        <option value="15">15</option>    
                        <option value="16">16</option>    
                        <option value="17">17</option>    
                        <option value="18">18</option>    
                        <option value="19">19</option>    
                        <option value="20">20</option>    
                        <option value="21">21</option>    
                        <option value="22">22</option>    
                        <option value="23">23</option>    
                        <option value="24">24</option>    
                        <option value="25">25</option>    
                        <option value="26">26</option>    
                        <option value="27">27</option>    
                        <option value="28">28</option>    
                        <option value="29">29</option>    
                        <option value="30">30</option>    
                        <option value="31">31</option>    
                      </select>    
                      日      
                      </td>        
                  </tr>      
                  <tr bgcolor="#F7FBFF">       
                    <td class="tablerow" height="1" width="20%" bgcolor="#F7FBFF">头像地址</td>      
                    <td class="tablerow" height="1"  bgcolor="#F7FBFF">       
                      <table>      
                        <tr>       
                          <td>       
                            <select name=icon size=1 onChange="document.images['avatar'].src=options[selectedIndex].value;" style="BACKGROUND-COLOR: #FFFFFF; BORDER-BOTTOM: 1px double; BORDER-LEFT: 1px double; BORDER-RIGHT: 1px double; BORDER-TOP: 1px double; COLOR: #000000">      
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
                          <td height=32>&nbsp;&nbsp;<img id=avatar src="./PIC/Image1.gif" alt=个人形象代表 width="32" height="32">&nbsp;-          
                            选择自己满意的头像</td>       
                        </tr>       
                      </table>       
                    </td>       
                  </tr>       
                  <tr bgcolor="#F7FBFF">        
                    <td class="tablerow" height="0" width="20%">个人签名：<br />      
                      HTML 开启<br />        
                    </td>      
                    <td class="tablerow" height="0" >       
                      <textarea rows="4" cols="45" name="sign"></textarea>      
                    </td>      
                  </tr>      
                  <tr bgcolor="#F7FBFF"> 
				  <td></td>
                    <td class="tablerow" height="0"  bgcolor="#F7FBFF">      
                      <input type="submit" name="regsubmit" value="免费注册" />   
                      <input type="button" name="regsubmit" onclick='form1.reset();'; value="重填" />    
                    </td>      
                  </tr>      
                  </form> 
				</table>
				<%@include file="inc/bottom.jsp"%>
</body></html>    

<html><script language="JavaScript"></script></html>