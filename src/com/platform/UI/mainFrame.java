package com.platform.UI;

public class mainFrame extends Frame {
  protected String strToolHtml="";
  public mainFrame() {
  }

  public String getTopHtml()
  {
    strTopHtml="" +
               "<html>\r\n" +
               "<head>\r\n" +
               "<title>Untitled Document</title>\r\n" +
               "<meta http-equiv=\"Content-Type\" content=\"text/html; charset=gb2312\">\r\n" +
               "<link rel=\"stylesheet\" href=\"../../platform/includes/style.css\" type=\"text/css\">\r\n" +
               "</head>\r\n" +
               "<body bgcolor=\"#dbdbdb\" text=\"#00000\" leftmargin=\"0\" topmargin=\"0\" marginwidth=\"0\" marginheight=\"0\"><center>\r\n" +
               "<table width=\"100%\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\" height=\"100%\">\r\n" +
               "  <tr>\r\n" +
               "    <td height=\"35\">\r\n" +
               "      <table width=\"100%\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\" align=\"right\">\r\n" +
               "        <tr>\r\n" +
               "          <td background=\"../../platform/images/back_main_1_bg.gif\" width=\"10\"><img src=\"../../platform/images/back_main_1_bg.gif\" width=\"2\" height=\"35\"></td>\r\n" +
               "          <td background=\"../../platform/images/back_main_1_bg.gif\" width=\"100\"><b><font color=\"#0000FF\">"+this.getCaption()+"</font></b></td>\r\n" +
               "          <td background=\"../../platform/images/back_main_1_bg.gif\">&nbsp;"+this.getToolsHtml()+"</td>\r\n" +
               "          <td background=\"../../platform/images/back_main_1_bg.gif\" width=\"10\">&nbsp;</td>\r\n" +
               "        </tr>\r\n" +
               "      </table>\r\n" +
               "    </td>\r\n" +
               "  </tr>\r\n" +
               "  <tr>\r\n" +
               "    <td valign=\"top\">\r\n";

    return strTopHtml;
  }

  public String getBottomHtml()
  {
    strBottomHtml="" +
                  "    </td>\r\n" +
                  "  </tr>\r\n" +
                  "  <tr>\r\n" +
                  "    <td valign=\"bottom\" height=\"30\">\r\n" +
                  "      <!--table width=\"100%\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\">\r\n" +
                  "        <tr>\r\n" +
                  "          <td background=\"../../platform/images/back_left_b_bg2.gif\">&nbsp;</td>\r\n" +
                  "          <td width=\"10\"><img src=\"../../platform/images/back_left_b_3.gif\" width=\"10\" height=\"30\"></td>\r\n" +
                  "          <td background=\"../../platform/images/back_left_b_bg2.gif\" width=\"300\"><img src=\"../../platform/images/back_left_b_icon.gif\" width=\"25\" height=\"13\" align=\"absmiddle\">浦东新区人大常委会\r\n" +
                  "            版权所有 2003</td>\r\n" +
                  "          <td width=\"20\"><img src=\"../../platform/images/back_left_b_4.gif\" width=\"20\" height=\"30\"></td>\r\n" +
                  "        </tr>\r\n" +
                  "      </table-->\r\n" +
                  "    </td>\r\n" +
                  "  </tr>\r\n" +
                  "</table>\r\n" +
                  "</body>\r\n" +
                  "</html>\r\n";

    //添加工具条，工具按钮由public void setToolsHtml(String strToolHtml)传入
    toolFrame toolFrm=new toolFrame();
    toolFrm.setCaption(strCaption);

    strBottomHtml+="<span id=\"bar\" style=\""+(this.getToolsHtml().equals("")?"display:none;":"")+"position:absolute; left:0px; top:-9px; width:100%; height:32px; z-index:9;\">";
    strBottomHtml+=toolFrm.getTopHtml();
    strBottomHtml+=strToolHtml;
    strBottomHtml+=toolFrm.getBottomHtml();
    strBottomHtml+="</span>";

    return strBottomHtml;
  }

  public void setToolsHtml(String strToolHtml)
  {
    this.strToolHtml=strToolHtml;
  }

  public String getToolsHtml()
  {
    return strToolHtml;
  }
}