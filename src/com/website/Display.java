//定义本类所在的包
package com.website;
//定义本类引入的类
import java.io.*;
import javax.servlet.jsp.*;
import javax.servlet.jsp.tagext.*;
import javax.servlet.http.*;

/**
 * 这个类在jsp页中显示一个图形页击中次数。
 */

public class Display extends TagSupport {


  private static String IMAGE_DIR="/website/images/numbers/";
  //实现doStartTag方法
  public int doStartTag() throws JspException {
      //jsp临时目录
    File tempDir = (java.io.File) pageContext.getServletContext().
       getAttribute("javax.servlet.context.tempdir");
    File countFile = new File(tempDir, "count.tmp");
    //读取计数
    String countStr = String.valueOf(Count.getCount(countFile));

    try {
    //返回给客户端
      JspWriter out = pageContext.getOut();
      int i = 0;
      int l = countStr.length();
      for (int ii=1;ii<7-l;ii++)
      {
        countStr = "0" + countStr;
      }
      while(i < countStr.length())
      {
        out.print("<img src=\""+IMAGE_DIR+countStr.charAt(i)+
                  ".gif\">");
        i++;
      }
	  	   //out.print(tempDir);
    } catch(IOException ioe) {
      System.out.println("Failed to insert counter display");
      ioe.printStackTrace();
      throw new JspException("Failed to insert counter display");
    }

    return(SKIP_BODY);
  }
}


