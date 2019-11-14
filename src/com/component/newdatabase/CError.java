package com.component.newdatabase;

import java.io.*;
import java.util.*;
import com.util.*;

public class CError
{
   private String _className = "";
   private String _methodName = "";
   private String _description = "";
   private String _errString = "";

   private String _time = "";
   private StringBuffer _strBuf;
   private File _log = null;

   public CError()
   {
   }

   /**
   @roseuid 3BF39F3600CF
   */
   public void raise(Exception ex, String errString, String methodName)
   {
     CDate date = new CDate();
     _errString = errString;
     _methodName = methodName;
     _className = ex.getClass().toString();
     _description = ex.getMessage();
     _strBuf = new StringBuffer();
     _time = date.getNowTime();
     _strBuf.append(_time+"\t");
     _strBuf.append(_errString+"\t");
     _strBuf.append(_description+"\t");
     _strBuf.append(_methodName+"\t");
     _strBuf.append(_className+"\t");
     setErrorLog();
     System.out.println(_strBuf.toString());
     //ex.printStackTrace();
   }

   public String getLastErrString()
   {
     return _errString;
   }

   private void setErrorLog()
   {
     try
     {
       //File _log = new File("c:\\error.log");
       String _f = "c:\\error.log";
       String _str = CTools.replace(_strBuf.toString(),"\n"," ");
       CFile.append(_f,_str);
       //System.out.print(a.getCanonicalPath() ) ;
     }catch(Exception e){
       e.printStackTrace() ;
     }

   }

   public ArrayList getErrorLog()
   {
     try
     {
       File _log = new File("c:\\error.log");
       if(!_log.exists())
       {
         return null;
       }
       ArrayList list = new ArrayList();
       BufferedReader in = CFile.read(_log);
       String s;

       while((s=in.readLine())!=null)
       {
         list.add(s);
       }

       return list;
     }catch(IOException e){
       e.printStackTrace();
       return null;
     }
   }

   public static void main(String[] args) {
     //File aa = new File("d:\\1.txt");
     CError e = new CError();
     ArrayList list = e.getErrorLog();
     Iterator it = list.iterator();
     String s ;
     while(it.hasNext())
     {
       s = it.next().toString();
       System.out.println(s);
     }

   }
}
