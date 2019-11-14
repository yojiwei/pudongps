// Decompiled by Jad v1.5.7g. Copyright 2000 Pavel Kouznetsov.
// Jad home page: http://www.geocities.com/SiliconValley/Bridge/8617/jad.html
// Decompiler options: packimports(3) fieldsfirst ansi 
// Source File Name:   CUrl.java

package com.util;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.FileReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.MalformedURLException;
import java.net.URL;
import java.util.Calendar;

public class CUrl
{

    private String _backupPath;
    private String _tempPath;

    public CUrl()
    {
    	_backupPath = "D:\\pdqlgk\\tswbackup\\";
        _tempPath = "D:\\pdqlgk\\tswtemp\\";
    }

    /**
     * @param src
     * @param dst
     * @throws IOException
     */
    /**
     * @param src
     * @param dst
     * @throws IOException
     */
    public static void copy(String src, String dst)
        throws IOException
    {
        File dstFile = new File(dst);
        String fPath = dstFile.getAbsolutePath();
        String fName = dstFile.getName();
        fPath = fPath.substring(0, fPath.length() - fName.length());
        File fileDir = new File(fPath);
        if(!fileDir.exists())
            fileDir.mkdirs();

        //判断页面上是否有null，判断是否有超过五个null,如果有，就不生成文件 modify by shiweijun 2010-4-12
        BufferedReader br = new BufferedReader(new FileReader(src));
        String l;
        boolean hasNull = false;
        int hasNullCount = 0;
        while ((l = br.readLine()) != null) {
          l= l.toLowerCase();
          if(l.indexOf("null")!=-1){
        	  hasNullCount++;
        	  if(hasNullCount==5){
        		  hasNull  = true;
        		  break;
        	  }
          }
        }
        br.close();
        if(!hasNull){
        InputStream in = new FileInputStream(src);
        OutputStream out = new FileOutputStream(dst);
        byte buf[] = new byte[1024];
        int i;
        while((i = in.read(buf)) > 0) 
            out.write(buf, 0, i);
        in.close();
        out.close();
        }
    }

    /**
     * 创建首页静态页面
     * @param urlStr
     * @param filePath
     * @param fileName
     * @return
     */
    public boolean createHtml(String urlStr, String filePath, String fileName)
    {
        String tempFileName = "";
        Calendar rightNow = Calendar.getInstance();
        tempFileName = fileName + "." + intToString(rightNow.get(1), 4) + intToString(rightNow.get(2), 2) + intToString(rightNow.get(5), 2);
        tempFileName = tempFileName + intToString(rightNow.get(11), 2) + intToString(rightNow.get(12), 2) + intToString(rightNow.get(13), 2);
        File sFile = new File(filePath + fileName);
        File backupDir = new File(_backupPath);
        File tempDir = new File(_tempPath);
        if(!backupDir.exists())
            backupDir.mkdirs();
        if(!tempDir.exists())
            tempDir.mkdirs();
        try
        {
            writeHtmlToFile(urlStr, _tempPath + tempFileName);
            //if(sFile.exists())
                //copy(filePath + fileName, _backupPath + tempFileName);
            move(_tempPath + tempFileName, filePath + fileName);
            return true;
        }
        catch(MalformedURLException e)
        {
            e.printStackTrace();
            return false;
        }
        catch(IOException e)
        {
            e.printStackTrace();
        }
        return false;
    }

    public boolean createHtml(String urlStr, String filePath, String fileName, String filecode)
    {
        String tempFileName = "";
        Calendar rightNow = Calendar.getInstance();
        tempFileName = fileName + "." + intToString(rightNow.get(1), 4) + intToString(rightNow.get(2), 2) + intToString(rightNow.get(5), 2);
        tempFileName = tempFileName + intToString(rightNow.get(11), 2) + intToString(rightNow.get(12), 2) + intToString(rightNow.get(13), 2);
        File sFile = new File(filePath + fileName);
        File backupDir = new File(_backupPath);
        File tempDir = new File(_tempPath);
        if(!backupDir.exists())
            backupDir.mkdirs();
        if(!tempDir.exists())
            tempDir.mkdirs();
        try
        {
            writeHtmlToFile(urlStr, _tempPath + tempFileName);
            //System.out.println(_backupPath + tempFileName);
            if(FileStctc(_tempPath + tempFileName, filecode))
            {
                if(sFile.exists())
                {
                    //copy(filePath + fileName, _backupPath + tempFileName);
                    move(_tempPath + tempFileName, filePath + fileName);
                    return true;
                } else
                {
                    return false;
                }
            } else
            {
                return false;
            }
        }
        catch(MalformedURLException e)
        {
            e.printStackTrace();
            return false;
        }
        catch(IOException e)
        {
            e.printStackTrace();
        }
        return false;
    }

    public boolean FileStctc(String filename, String filecode)
    {
        try
        {
            boolean bool = false;
            if(!filecode.equals(""))
            {
                BufferedReader fileRead = new BufferedReader(new FileReader(filename));
                for(String line = fileRead.readLine(); line != null; line = fileRead.readLine())
                    if(line.indexOf(filecode) != -1)
                        bool = true;

                return bool;
            } else
            {
                return true;
            }
        }
        catch(FileNotFoundException e)
        {
            e.printStackTrace();
            return false;
        }
        catch(IOException e)
        {
            e.printStackTrace();
        }
        return false;
    }

    public void getHtml(String urlStr, String filename)
    {
        try
        {
            URL url = new URL(urlStr);
            InputStream is = url.openConnection().getInputStream();
            String headContent = "<%@page contentType=\"text/html; charset=GBK\"%>";
            byte byteContent[] = headContent.getBytes();
            FileOutputStream fos = new FileOutputStream(new File(filename));
            fos.write(byteContent);
            byte cont[] = new byte[1000];
            int i;
            while((i = is.read(cont)) != -1) 
                fos.write(cont, 0, i);
            is.close();
            fos.close();
        }
        catch(MalformedURLException e)
        {
            e.printStackTrace();
        }
        catch(IOException e)
        {
            e.printStackTrace();
        }
    }

    public static String intToString(int iNumber, int iLength)
    {
        String sNumber = "";
        sNumber = Integer.toString(iNumber);
        if(sNumber.length() < iLength)
        {
            String addZero = "";
            for(int i = 0; i < iLength - sNumber.length(); i++)
                addZero = addZero + "0";

            sNumber = addZero + sNumber;
        }
        return sNumber;
    }

    public static void main(String args[])
    {
        CUrl myurl = new CUrl();
        boolean b = myurl.createHtml("http://www.shyouth.net/website/index/index.jsp", "D:\\workspace\\shanghaitsw\\WebRoot\\website\\index\\", "index.html");
    }

    public static void move(String src, String dst)
        throws IOException
    {
        copy(src, dst);
        File mFile = new File(src);
        mFile.delete();
    }

    public void writeHtmlToFile(String urlStr, String fullFilename)
        throws MalformedURLException, IOException
    {
        String headContent = "<%@page contentType=\"text/html; charset=GBK\"%>";
        byte byteContent[] = headContent.getBytes();
        URL url = new URL(urlStr);
        InputStream is = url.openConnection().getInputStream();
        File sFile = new File(fullFilename);
        if(!sFile.exists())
        {
            String fPath = sFile.getAbsolutePath();
            String fName = sFile.getName();
            fPath = fPath.substring(0, fPath.length() - fName.length());
            File fileDir = new File(fPath);
            if(!fileDir.exists())
                fileDir.mkdirs();
            sFile.createNewFile();
        }
        FileOutputStream fos = new FileOutputStream(sFile);
        byte cont[] = new byte[1000];
        String stFilename = sFile.getName();
        if(!stFilename.equals(""))
        {
            String stA = stFilename;
            String stB = stFilename.substring(stA.indexOf(46) + 1);
            stFilename = stB.substring(0, stB.indexOf(46));
        }
        if(stFilename.equals("jsp"))
            fos.write(byteContent);
        int i;
        while((i = is.read(cont)) != -1) 
            fos.write(cont, 0, i);
        is.close();
        fos.close();
    }
}
