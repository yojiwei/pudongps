//定义本类所在的包
package com.website;
//定义本类引入的类
import java.io.*;
import javax.servlet.jsp.*;
import javax.servlet.jsp.tagext.*;

/**
 * 这个类在jsp页中显示一个图形页击中次数。
 */

public class Increment extends TagSupport {
  //实现doStartTag方法
  public int doStartTag() {
    //jsp临时目录
    File tempDir = (java.io.File) pageContext.getServletContext().
       getAttribute("javax.servlet.context.tempdir");
    //加入新文件
    File countFile = new File(tempDir, "count.tmp");
    //增量计数
    Count.incCount(countFile);
    return(SKIP_BODY);
  }
}