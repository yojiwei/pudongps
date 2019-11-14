package com.platform.UI;

public class toolFrame extends Frame {
  public toolFrame() {
  }

  public String getTopHtml()
  {
    strTopHtml="" +
               "    <table width=\"100%\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\" height=\"100%\">\r\n" +
               "      <tr>\r\n" +
               "        <td width=\"6\" height=\"2\">&nbsp;</td>\r\n" +
               "        <td  width=\"100%\" height=\"2\" nowrap>\r\n" +
               "        </td>\r\n" +
               "        <td width=\"5\">&nbsp;</td>\r\n" +
               "      </tr>\r\n" +
               "      <tr>\r\n" +
               "        <td width=\"6\" height=\"19\">&nbsp;</td>\r\n" +
               "        <td width=\"100%\" height=\"19\" nowrap  align=center valign=bottom>\r\n";

   if (!strCaption.equals(""))
         strTopHtml+="        <table width=100%><tr><td width=0 nowrap>&nbsp;"+strCaption+"</td><td>";

    return strTopHtml;
  }

  public String getBottomHtml()
  {
    if (!strCaption.equals(""))
      strBottomHtml="        </td></tr></table>";
    else
      strBottomHtml="";

    strBottomHtml=strBottomHtml +
                  "        </td>\r\n" +
                  "        <td width=\"5\">&nbsp;</td>\r\n" +
                  "      </tr>\r\n" +
                  "   </table>";

    return strBottomHtml;
  }
}