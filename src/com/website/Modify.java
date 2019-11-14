package com.website;

//定义本类引入的类
import java.io.*;
import javax.servlet.jsp.*;
import javax.servlet.jsp.tagext.*;

public class Modify extends TagSupport{

  private int number; //计数器的数字
  public void setNumber(int iNumber) { number = iNumber; }
  public int getNumber() { return number; }

  public int doStartTag() {
    //jsp临时目录
    File tempDir = (java.io.File) pageContext.getServletContext().
       getAttribute("javax.servlet.context.tempdir");
    //加入新文件
    File countFile = new File(tempDir, "count.tmp");
    //增量计数
    //Count.setCount(countFile,400);
    Count.setCount(countFile,number);
    return(SKIP_BODY);
  }
}