<%@ page contentType="text/html; charset=GBK" %>
<%@ page import="com.component.database.*" %>
<%@ page import="java.util.*" %>
<%@ page import="com.util.*" %>
<%@ page import="java.io.*" %>
<link href="../style.css" rel="stylesheet" type="text/css">


<table class="main-table" width="100%">
<tr>
 <td width="100%">
   <div align="center">
        <table border="0" width="100%" cellspacing="0" cellpadding="0">
                <tr>
                        <td>
                                <table border="0" width="100%" cellspacing="0" cellpadding="0">
                                        <tr class="bttn">
                                           <td width="100%">
                                           <table width="100%">
                                                 <tr>
                                                        <td id="TitleTd" width="100%" align="left">系统错误日志</td>
                                                        <td valign="top" align="right" nowrap>
    <img src="/system/images/dialog/split.gif" align="middle" border="0">
    <img src="/system/images/dialog/return.gif" border="0" onclick="javascirpt:history.go(-1);" title="返回" style="cursor:hand" align="absmiddle" id="image3" name="image3" WIDTH="14" HEIGHT="14">
    <img src="/system/images/dialog/split.gif" align="middle" border="0">                                                        </td>
                                                  </tr>
                                                </table>
                                           </td>
                                        </tr>
                                </table>
                   </td>
                </tr>
        <tr>
          <td width="100%" valign="top">

          <!--内容-->
                    <table border="0" width="100%" cellpadding="3" height="44">
                           <tr class="bttn">
                                <td width="5%" class="outset-table" >序号</td>
                                <td width="95%" class="outset-table">产生时间-程序错误说明-系统错误说明-错误所在类和方法-错误类名称</td>
				</tr>
<%
  CError e = new CError();
  ArrayList list = e.getErrorLog();
  if (list != null)
  {
    Iterator it = list.iterator();
    String s;
    int j = 0;
    while(it.hasNext())
    {
      if(j++ % 2 == 0)  out.print("<tr class=\"line-even\">");
      else out.print("<tr class=\"line-odd\">");

      s = it.next().toString();
      //s = CTools.replace(s,"\r\n"," ");
      out.print("<td>"+j+"</td>");
      out.print("<td>"+s+"</td></tr>");
    }
  }else{
    out.println("<tr><td>没有错误！</td></tr>");
  }
%>
                                  </table>



                                <!--内容-->
                      </td>
                         </tr>

                   </table>
                  </div>
             </td>
            </tr>
</table>

