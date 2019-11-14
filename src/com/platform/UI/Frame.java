package com.platform.UI;

public class Frame {

  protected String  strCaption="";  //标题栏信息
  protected String  strPageEffect="";
  protected String strTopHtml=""; //左面框架上面部分的html
  protected String strBottomHtml=""; //左面框架下面部分的html
  protected String strStyle="";
  protected String strBody="";

  /**
   * @deprecated
   */
  public Frame() {
    strTopHtml="" ;
    strBottomHtml="";
    strPageEffect=" onmousemove='event.returnValue=false;'  oncontextmenu='return false;'  ondragstart='return false;'";
  }

  public String getTopHtml()
  {
    return strTopHtml;
  }

  public String getBottomHtml()
  {
    return strBottomHtml;
  }

  public void setTopHtml(String strHtml)
  {
    strTopHtml=strHtml;
  }

  public String getStyle()
  {
    if(strStyle.equals(""))
      strStyle="<link rel=\"stylesheet\" href=\"../includes/style.css\" type=\"text/css\">\r\n";
    return strStyle;
  }

  public void setBody(String strBody)
  {
    this.strBody=strBody;
  }

  public String getBody()
  {
    if(strBody.equals(""))
      strBody="<body bgcolor=\"#dbdbdb\" text=\"#00000\" leftmargin=\"0\" topmargin=\"0\" marginwidth=\"0\" marginheight=\"0\"><center>\r\n";
    return strBody;
  }

  public String getPageStyle()
  {
    return "<script language=javascript>function fix(){}</script>"+getStyle()+"\r\n"+getBody();
  }

  public void setBottomHtml(String strHtml)
  {
    strBottomHtml=strHtml;
  }

  public String getCaption()
  {
    return strCaption;
  }

  public void setCaption(String strCaption)
  {
    this.strCaption=strCaption;
  }

  public String getPageEffect()
  {
    return strPageEffect;
  }

  public void setPageEffect(String strPageEffect)
  {
    this.strPageEffect=strPageEffect;
  }

}