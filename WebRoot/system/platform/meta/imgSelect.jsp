<%@ page contentType="text/html; charset=GBK" %>
<%@ page import="com.util.*" %>
<%
  String path="";
  ServletContext context= config.getServletContext();
  path=context.getRealPath("system/images/button");
	//out.println(path);
	
  String files[];
  StringBuffer html;
  String imgName = "";
  String imgHtml = "";
  String URL = "/system/images/button/";
  String title = "";
  int sum,cols,w,j ;
  files = CFile.listFiles(path,"gif");
  sum =  files.length ;

  cols = sum<30 ? 3:5;
  w   =  100/cols ;
  j = 0;
  title = CTools.iso2gb(request.getParameter("title"));

  html = new StringBuffer("");

  html.append("<table border=0 width=100% cellpadding=0 align=center>");

  for (int i=0;i<files.length ;i++)
  {
    imgName = URL + files[i] ;
    if (j == 0) html.append("<tr>");
    j++;
    html.append("<td width='" + w + "%'>");
    html.append("<table border=0 width=100% cellpadding=0 >");
    html.append("	<tr>");
    imgHtml = "<img border=0 src='" + imgName  + "' onclick=on_choose('" + imgName + "') style='cursor:hand'>";
    html.append("  <td width='100%' center>" + imgHtml + "</td>");
    html.append(" </tr>");
    html.append("</table>");
    html.append("</td>");
    if (j >= cols)
    {
      j = 0;
      html.append("</tr>");
    }
  }
  for (int i = 1;i<cols - j;i++)
  {
    html.append("<td width='" + w + "%'>");
    html.append("<table border=0 width=100% cellpadding=0>");
    html.append("	<tr>");
    html.append("  <td width='100%' ></td>");
    html.append(" </tr>");
    html.append("</table>");
    html.append("</td>");
  }

  html.append("</table>");
	
%>


<body bgcolor="#D8D7CE">
<table cellSpacing="0" cellPadding="2" width="100%" border="0">
   <tr bgColor="#deefff">
     <td align=center><b><font color=blue ><span id=title></span></font></b></td>
   </tr>
</table>

        <div style="overflow: auto; width: 100%; height: 280; border: 0px solid #336699">
          <table bgcolor="white" cellSpacing="0" cellPadding="2" width="100%" border="0">
            <tbody>
              <tr>
                <td vAlign="top" width="100%" >
                  <table border="0" width="100%" cellpadding="0">
                    <tr>
                      <td style="width:100%">
                        <table border="0" width="100%" cellpadding="0">
                          <tr>
                            <td width="100%" align="left">
                              <%=html.toString() %>
                            </td>
                          </tr>
                        </table>
                      </td>
                      <td style="width=100%" valign="top">
                      <p align="right">
                      </td>
                    </tr>
                  </table>
                </td>
              </tr>
            </tbody>
          </table>
        </div>
          <table cellSpacing="0" cellPadding="0" width="100%" border="0" height=35>
                <tr>
                        <td align=center valign=bottom>
                                <input class="bttn" onclick="window.close();" type="button" value="确定" id=button1 name=button1>
                                <input class="bttn" onclick="on_cancel();" type="button" value="取消" id=button1 name=button1>
                        </td>
                </tr>
         </table>

<script>
var returnName = "";
var returnId ;

function title_click(list_id,id)
{
        eval("var node_title = node_color"+list_id+".innerHTML") ;
        returnName = node_title ;
        returnId  = list_id ;
}
function on_choose(returnName)
{
        if (returnName != "")
        {
                returnValue = returnName;
        }else{
                returnValue = "" ;
        }
        close() ;
}
function on_cancel()
{
        returnValue = "" ;
        close() ;
}
</script>
</body>
</html>
