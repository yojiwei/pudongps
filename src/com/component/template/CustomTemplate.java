/*
 * CustomTemplate.java
 *
 * Created on 2006年5月18日, 上午10:15
 *
 * 说明：
 *    模板的输出
 *
 */

package com.component.template;

/**
 *
 * @author mosonchao
 */

import java.io.*;
import java.io.FileOutputStream;
import java.net.*;
import java.util.*;
import java.lang.*;
import java.lang.String;
import javax.xml.parsers.*;
//import org.apache.naming.java.javaURLContextFactory;
import org.w3c.dom.*;
import javax.servlet.http.*;

public class CustomTemplate
{
    private String baseURL="";          //网站根地址
    private java.io.PrintWriter cus_out;    //网页输出对象
    private HttpServletRequest currentRequest;

    /** Creates a new instance of CustomTemplate */
    public CustomTemplate()
    {
    }

    public String getBaseURL()
    {
        return this.baseURL;
    }
    public void setBaseURL(String url)
    {
        if (!url.trim().equals(""))
        {
            this.baseURL = url;
        }
    }

    public void setPrinter(java.io.PrintWriter pw)
    {
        this.cus_out= pw;
    }

    public void setRequest(HttpServletRequest currentRequest)
    {
        this.currentRequest= currentRequest;
    }

    /**
     *  根据指定的URL返回文件的硬盘路径
     *  @parameter
     *      fileURL     文件的WEB路径
     *  @return
     *      String      文件的硬盘路径
     */
    private String getFilePath(String fileURL)
    {
        String strRootPath=this.currentRequest.getRealPath("/");
        String filePath=fileURL;
        if(filePath.toUpperCase().indexOf("HTTP://")<0)
        {
            if(filePath.toUpperCase().indexOf("/")==0)
            {
                filePath=strRootPath + filePath.substring(1);
            }
            else
            {
                String strCurrentPath=currentRequest.getServletPath().replaceAll("\"","/");
                strCurrentPath= strCurrentPath.substring(1,strCurrentPath.lastIndexOf("/")+1);
                filePath= strRootPath +  strCurrentPath + filePath;
            }
        }
        else
        {
            filePath= filePath.substring(this.baseURL.length());
            filePath= strRootPath + filePath;
        }

        if(filePath.toUpperCase().indexOf("/")>=0)
        {
            filePath = filePath.substring(0,filePath.lastIndexOf("/")+1);
        }
        filePath= filePath.replaceAll("/","\\");
        return filePath;
    }

    /**
     *  根据指定的URL返回文件名
     *  @parameter
     *      fileURL     文件的WEB路径
     *  @return
     *      String      文件名
     */
    private String getFileName(String fileURL)
    {
        String strFileName="";
        if(fileURL.toUpperCase().indexOf("/")>=0)
        {
            strFileName = fileURL.substring(fileURL.lastIndexOf("/")+1);
        }
        else
        {
            strFileName = fileURL;
        }
        return strFileName;
    }

    /**
     *  生成指定的目录
     *  @parameter
     *      FilePath     目录
     *  @return
     *      boolean      生成目录成功与否
     */
    private boolean createPath(String FilePath)
    {
        java.io.File currentPath= new java.io.File(FilePath);
        if(!currentPath.exists())
        {
            String ParentPath = currentPath.getParent();
            if(createPath(ParentPath))
            {
                currentPath.mkdir();
                return true;
            }
            else
            {
                return false;
            }
        }
        else
        {
            return true;
        }
    }

    /**
     *  新建指定的文件，如果该文件已存在，则先删除再新建
     *  @parameter
     *      FileName     文件名
     *  @return
     *      boolean      生成文件成功与否
     */
    private boolean createFile(String FileName)
    {
        java.io.File currentFile=new java.io.File(FileName);
        if(currentFile.exists())
        {
            currentFile.delete();
        }
        currentFile = new java.io.File(FileName);
        try
        {
            currentFile.createNewFile();
            return true;
        }
        catch(Exception e)
        {
            e.printStackTrace();
            return false;
        }
    }

    /**
     *  生成指定的目录和文件
     *  @parameter
     *      FilePath    文件所在的目录
     *      FileName    文件名
     *  @return
     *      boolean     生成指定的目录和文件成功与否
     */
    private boolean createOrreplaceAllFile(String FilePath,String FileName)
    {
        if(createPath(FilePath))
        {
            if(createFile(FilePath+FileName))
            {
                return true;
            }
            else
            {
                return false;
            }
        }
        else
        {
            return false;
        }
    }

    /**
     *  重命名文件,如果源文件不存在，则无法改变文件名，如果目标文件已经存在，则先删除目标文件
     *  @parameter
     *      FilePath     文件所在的目录
     *      BakFileName  源文件名
     *      FileName     目录文件名
     *  @return
     *      boolean      重命名文件成功与否
     */
    private boolean renameFile(String FilePath,String BakFileName,String FileName)
    {
        java.io.File _bak = new java.io.File(FilePath+BakFileName);
        if(!_bak.exists())
        {
            return false;
        }
        else
        {
            java.io.File not_bak = new java.io.File(FilePath+FileName);
            if(not_bak.exists())
            {
                not_bak.delete();
                not_bak = new java.io.File(FilePath+FileName);
            }
            try
            {
                _bak.renameTo(not_bak);
                return true;
            }
            catch(Exception e)
            {
                e.printStackTrace();
                return false;
            }

        }
    }

   /**
    *   解析标签并返回标签实际内容
    *   @parameter
    *       v_tarString     一段完整的标签代码
    *   @return
    *       String          解析过后的HTML代码
    */
    private String tranTar(String v_tarString)
    {
        ArrayList tarAttributes = new ArrayList();
        int iPosStart=-1;    //标签的起始位置
        int iPosEnd=-1;      //标签的结束位置
        int iPosEndTag = -1;
        String tarAttribute="";
        String xmlTar="";
        String tarString="";
        String strReturn="";
        tarString = v_tarString;
        iPosStart=-1;
        iPosEnd=-1;
        iPosStart = tarString.indexOf(" ");
        while(iPosStart>-1)
        {
           iPosEnd = tarString.indexOf(" ",iPosStart+1);
           iPosEndTag = tarString.indexOf(">",iPosStart+1);
           if(iPosEnd==-1)
           {
               iPosEnd = iPosEndTag;
           }
           tarAttribute = tarString.substring(iPosStart+1,iPosEnd).trim();
           if(!tarAttribute.trim().equals(""))
           {
               tarAttributes.add(tarAttribute.replaceAll("\"",""));
           }
           tarString = tarString.substring(iPosStart+1).trim();
           iPosStart = tarString.indexOf(" ");
        }
        strReturn = htmlCode(tarAttributes);
        return strReturn;
    }

   /**
    *   解析URL参数并返回标签实际内容
    *   @parameter
    *       tarAttributes       URL网页名及参数列表
    *   @return
    *       String              解析过后的HTML代码
    */
    private String htmlCode(ArrayList tarAttributes)
    {
      String strUrl="";
      int i;
      int j=0;
      for(i=0;i<tarAttributes.size();i++)
      {
          if(tarAttributes.get(i).toString().indexOf("tar_source=")>-1)
          {
            if(strUrl.equals(""))
            {
                strUrl = tarAttributes.get(i).toString().replaceAll("tar_source=","").trim();
            }
            else
            {
                strUrl = tarAttributes.get(i).toString().replaceAll("tar_source=","").trim() + "&" + strUrl;
            }
          }
          else
          {
            if(!strUrl.equals(""))
            {
                strUrl = strUrl + "&";
            }
            strUrl = strUrl + tarAttributes.get(i).toString();
          }
      }
      if(strUrl.indexOf("&")>-1)
      {
          if(strUrl.indexOf("?")<0)
            strUrl = strUrl.substring(0,strUrl.indexOf("&"))+"?"+strUrl.substring(strUrl.indexOf("&")+1);
      }
      //System.out.println(strUrl);
      return getHtml(strUrl);
    }

   /**
    *   解析地址并返回对应页的HTML内容
    *   @parameter
    *       strUrl          完整的URL地址
    *   @return
    *       String          解析过后的HTML代码
    */
    private String getHtml(String strUrl)
    {
      String strReturn = "";
      String strWebUrl = "";
      int iBodyStart=-1;
      int iBodyEnd=-1;
      if(strUrl.toUpperCase().indexOf("HTTP://")<0)
        strWebUrl = this.baseURL + strUrl;
      else
        strWebUrl = strUrl;
      StringBuffer sb = new StringBuffer();
      try
      {
          URL url = new URL(strWebUrl);
          BufferedReader reader = new BufferedReader(new InputStreamReader(url.openStream()));
          if (reader.ready())
          {
            String temp = reader.readLine();
            while (temp != null)
            {
              sb.append(temp);
              temp = reader.readLine();
            }
            iBodyStart= sb.toString().toUpperCase().indexOf("<BODY>");
            iBodyEnd =  sb.toString().toUpperCase().indexOf("</BODY>");
            if(iBodyStart<0)
            {
                strReturn = sb.toString();
            }
            else
            {
                strReturn = sb.substring(iBodyStart+6,iBodyEnd);
                //System.out.println(strReturn);
            }
          }
      }
      catch (Exception e)
      {
        e.printStackTrace();
      }
      return strReturn;
    }

   /**
    *   读取模板内容并解析其中的自定义标签并输出到浏览器
    *   @Request
    *       setBaseURL      指定页面根URL地址
    *       setPrinter      指定页面输出对象
    *   @parameter
    *       templateURL     模板绝对地址
    *   @return
    *       boolean         输出到浏览器成功与否
    */
   public boolean printTemplateToBrowserByFile(String templateURL)
   {
    int i=0;
    int iPosStart=-1;       //每个标签的在网页中的位置
    int iPosEnd = -1;
    String tarString="";
    StringBuffer sb = new StringBuffer();
    String customURL="";
    try
    {
      if(templateURL.toUpperCase().indexOf("HTTP://")<0)
      {
          customURL= this.baseURL + templateURL;
      }
      else
      {
          customURL= templateURL;
      }
      URL url = new URL(customURL);
      BufferedReader reader = new BufferedReader(new InputStreamReader(url.openStream()));
      if (reader.ready())
      {
        String temp = reader.readLine();
        while (temp != null) {
          sb.append(temp);
          temp = reader.readLine(); ;
        }
        iPosStart= sb.indexOf("<tar_");
        if(iPosStart>-1)
        {
            this.cus_out.print(sb.substring(0,iPosStart));
            while(iPosStart>-1)
            {
                if(iPosStart>-1)
                {
                    iPosEnd = sb.indexOf("</tar_>",iPosStart+1);
                }
                tarString = sb.substring(iPosStart,iPosEnd+7);
                this.cus_out.print(tranTar(tarString));      //翻译标签，并输出标签内容

                iPosStart = sb.indexOf("<tar_",iPosEnd+1);
                if(iPosStart>iPosEnd)
                {
                    this.cus_out.print(sb.substring(iPosEnd+7,iPosStart));
                }
                if(iPosStart<0)
                {
                    this.cus_out.print(sb.substring(iPosEnd+7,sb.length()));
                }
            }
        }
        else
        {
            this.cus_out.print(sb.toString());
        }
      }
      return true;
    }
    catch (Exception e) {
      e.printStackTrace();
      return false;
    }
   }

   /**
    *   读取模板内容并解析其中的自定义标签并输出到浏览器
    *   @Request
    *       setPrinter      指定页面输出对象
    *   @parameter
    *       templateString     模板绝对地址
    *   @return
    *       boolean            输出到浏览器成功与否
    */
   public boolean printTemplateToBrowserByString(String templateString)
   {
    int i=0;
    int iPosStart=-1;       //每个标签的在网页中的位置
    int iPosEnd = -1;
    String tarString="";
    String sb = templateString;
    String customURL="";
    try
    {
        iPosStart= sb.indexOf("<tar_");
        if(iPosStart>-1)
        {
            this.cus_out.print(sb.substring(0,iPosStart));
            while(iPosStart>-1)
            {
                if(iPosStart>-1)
                {
                    iPosEnd = sb.indexOf("</tar_>",iPosStart+1);
                }
                tarString = sb.substring(iPosStart,iPosEnd+7);
                this.cus_out.print(tranTar(tarString));      //翻译标签，并输出标签内容

                iPosStart = sb.indexOf("<tar_",iPosEnd+1);
                if(iPosStart>iPosEnd)
                {
                    this.cus_out.print(sb.substring(iPosEnd+7,iPosStart));
                }
                if(iPosStart<0)
                {
                    this.cus_out.print(sb.substring(iPosEnd+7,sb.length()));
                }
            }
        }
        else
        {
            this.cus_out.print(sb.toString());
        }
        return true;
    }
    catch (Exception e) {
      e.printStackTrace();
      return false;
    }
   }

   /**
    *   根据模板文件生成解析过后的HTML格式文件
    *   @Request
    *       setBaseURL      指定页面根URL地址
    *       setRequest      指定页面Request对象
    *   @parameter
    *       fileURL         生成的文件的地址
    *       templateURL     模板地址
    *   @return
    *       boolean         执行成功与否
    */
    public boolean printTemplateToFileByFile(String fileURL,String templateURL)
    {
        String strFilePath= getFilePath(fileURL);
        String strFileName= getFileName(fileURL);
        String strTempFileName = strFileName.replaceAll(".","_bak.");
        if(createOrreplaceAllFile(strFilePath,strTempFileName))
        {
            try
            {
                java.io.FileOutputStream fos = new java.io.FileOutputStream(strFilePath+strTempFileName);
                PrintStream ps = new PrintStream(fos);

                int i=0;
                int iPosStart=-1;       //每个标签的在网页中的位置
                int iPosEnd = -1;
                String tarString="";
                StringBuffer sb = new StringBuffer();
                String customURL="";
                try
                {
                  if(templateURL.toUpperCase().indexOf("HTTP://")<0)
                  {
                      customURL= this.baseURL + templateURL;
                  }
                  else
                  {
                      customURL= templateURL;
                  }
                  URL url = new URL(customURL);
                  BufferedReader reader = new BufferedReader(new InputStreamReader(url.openStream()));
                  if (reader.ready())
                  {
                    String temp = reader.readLine();
                    while (temp != null) {
                      sb.append(temp);
                      temp = reader.readLine(); ;
                    }
                    iPosStart= sb.indexOf("<tar_");
                    if(iPosStart>-1)
                    {
                        ps.print(sb.substring(0,iPosStart));
                        while(iPosStart>-1)
                        {
                            if(iPosStart>-1)
                            {
                                iPosEnd = sb.indexOf("</tar_>",iPosStart+1);
                            }
                            tarString = sb.substring(iPosStart,iPosEnd+7);
                            ps.print(tranTar(tarString));      //翻译标签，并输出标签内容

                            iPosStart = sb.indexOf("<tar_",iPosEnd+1);
                            if(iPosStart>iPosEnd)
                            {
                                ps.print(sb.substring(iPosEnd+7,iPosStart));
                            }
                            if(iPosStart<0)
                            {
                                ps.print(sb.substring(iPosEnd+7,sb.length()));
                            }
                        }
                    }
                    else
                    {
                        ps.print(sb.toString());
                    }
                  }
                }
                catch (Exception e) {
                  e.printStackTrace();
                }


                ps.close();
                fos.close();
            }
            catch(Exception e)
            {
                e.printStackTrace();
            }

            if(renameFile(strFilePath,strTempFileName,strFileName))
            {
                return true;
            }
            else
            {
                return false;
            }
        }
        else
        {
            return false;
        }
    }

   /**
    *   读取模板内容并解析其中的自定义标签并输出到浏览器
    *   @Request
    *       setRequest      指定页面Request对象
    *   @parameter
    *       fileURL         生成的文件的地址
    *       templateString  模板绝对地址
    *   @return
    *       boolean         执行成功与否
    */
    public boolean printTemplateToFileByString(String fileURL,String templateString)
    {
        String strFilePath= getFilePath(fileURL);
        String strFileName= getFileName(fileURL);
        String strTempFileName = strFileName.replaceAll(".","_bak.");
        if(createOrreplaceAllFile(strFilePath,strTempFileName))
        {
            try
            {
                java.io.FileOutputStream fos = new java.io.FileOutputStream(strFilePath+strTempFileName);
                PrintStream ps = new PrintStream(fos);

                int i=0;
                int iPosStart=-1;       //每个标签的在网页中的位置
                int iPosEnd = -1;
                String tarString="";
                String sb = templateString;
                String customURL="";
                try
                {
                    iPosStart= sb.indexOf("<tar_");
                    if(iPosStart>-1)
                    {
                        ps.print(sb.substring(0,iPosStart));
                        while(iPosStart>-1)
                        {
                            if(iPosStart>-1)
                            {
                                iPosEnd = sb.indexOf("</tar_>",iPosStart+1);
                            }
                            tarString = sb.substring(iPosStart,iPosEnd+7);
                            ps.print(tranTar(tarString));      //翻译标签，并输出标签内容

                            iPosStart = sb.indexOf("<tar_",iPosEnd+1);
                            if(iPosStart>iPosEnd)
                            {
                                ps.print(sb.substring(iPosEnd+7,iPosStart));
                            }
                            if(iPosStart<0)
                            {
                                ps.print(sb.substring(iPosEnd+7,sb.length()));
                            }
                        }
                    }
                    else
                    {
                        ps.print(sb.toString());
                    }
                }
                catch (Exception e) {
                  e.printStackTrace();
                }

                ps.close();
                fos.close();
            }
            catch(Exception e)
            {
                e.printStackTrace();
            }

            if(renameFile(strFilePath,strTempFileName,strFileName))
            {
                return true;
            }
            else
            {
                return false;
            }
        }
        else
        {
            return false;
        }
    }

   /**
    *   输出字符串到浏览器，不换行
    *   @Request
    *       setRequest      指定页面输出对象
    *   @parameter
    *       str            字符串
    */
   public void writeString(String str)
   {
       this.cus_out.print(str);
   }

   /**
    *   输出字符串到浏览器，换行
    *   @Request
    *       setRequest      指定页面输出对象
    *   @parameter
    *       str             字符串
    */
   public void writelnString(String str)
   {
       this.cus_out.println(str);
   }

}
