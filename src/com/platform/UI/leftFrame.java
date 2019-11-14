package com.platform.UI;

public class leftFrame extends Frame {
  /**
   * @deprecated
   */
  public leftFrame() {
  }

public String getTopHtml()
{
  strTopHtml="" +
             "<html>\r\n" +
             "<head>\r\n" +
             "<title>Untitled Document</title>\r\n" +
             "<meta http-equiv=\"Content-Type\" content=\"text/html; charset=gb2312\">\r\n" +
             "<link rel=\"stylesheet\" href=\"../includes/style.css\" type=\"text/css\">\r\n" +
             "</head>\r\n" +
             "<body bgcolor=\"#FFFFFF\" text=\"#000000\" leftmargin=\"0\" topmargin=\"0\" marginwidth=\"0\" marginheight=\"0\">\r\n" +
             "<div id=divScroll><table width=\"100%\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\" height=\"100%\">\r\n" +
             "  <tr>\r\n" +
             "    <td valign=\"top\" height=\"10\"><img src=\"../images/back_left_1.gif\" width=\"176\" height=\"10\"></td>\r\n" +
             "  </tr>\r\n" +
             "  <tr>\r\n" +
             "    <td background=\"../images/back_left_bg.gif\" height=\"32\"><img src=\"../images/back_left_title.gif\" width=\"176\" height=\"32\"></td>\r\n" +
             "  </tr>\r\n" +
             "  <tr height=100%>\r\n" +
             "    <td background=\"../images/back_left_bg.gif\" valign=\"top\">\r\n" +
             "      <table width=\"100%\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\">\r\n" +
             "        <tr>\r\n" +
             "          <td width=\"20\"><img src=\"../images/blank.gif\" width=\"20\" height=\"1\"></td>\r\n" +
             "          <td>\r\n";

  return strTopHtml;
}

public String getBottomHtml()
{
  strBottomHtml="" +
                "          </td>\r\n" +
                "        </tr>\r\n" +
                "      </table>\r\n" +
                "      <br>\r\n" +
                "      <br>\r\n" +
                "      <br>\r\n" +
                "    </td>\r\n" +
                "  </tr>\r\n" +
                "  <!--tr>\r\n" +
                "    <td background=\"../images/back_left_bg.gif\" valign=\"top\">\r\n" +
                "      <div align=\"center\"><img src=\"../images/back_left_icon_refresh.gif\" style=\"cursor?:hand\" onclick=location.reload() width=\"100\" height=\"26\"></div>\r\n" +
                "    </td>\r\n" +
                "  </tr>\r\n" +
                "  <tr>\r\n" +
                "    <td valign=\"baseline\" height=\"30\">\r\n" +
                "      <table width=\"100%\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\">\r\n" +
                "        <tr>\r\n" +
                "          <td width=\"9\"><img src=\"../images/back_left_b_1.gif\" width=\"9\" height=\"30\"></td>\r\n" +
                "          <td background=\"../images/back_left_b_bg.gif\">\r\n" +
                "            <div align=\"center\">操作员：管理员</div>\r\n" +
                "          </td>\r\n" +
                "          <td width=\"3\"><img src=\"../images/back_left_b_bg2.gif\" width=\"3\" height=\"30\"></td>\r\n" +
                "        </tr>\r\n" +
                "      </table>\r\n" +
                "    </td>\r\n" +
                "  </tr-->\r\n" +
                "</table></div>\r\n" +
                "</body>\r\n" +
                "</html>\r\n";

  return strBottomHtml;
  }
}