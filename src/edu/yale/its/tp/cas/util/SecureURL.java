// Decompiled by Jad v1.5.7g. Copyright 2000 Pavel Kouznetsov.
// Jad home page: http://www.geocities.com/SiliconValley/Bridge/8617/jad.html
// Decompiler options: packimports(3) fieldsfirst ansi 
// Source File Name:   SecureURL.java

package edu.yale.its.tp.cas.util;

import java.io.*;
import java.net.URL;
import java.net.URLConnection;

public class SecureURL
{

    public static void main(String args[])
        throws IOException
    {
        System.setProperty("java.protocol.handler.pkgs", "com.sun.net.ssl.internal.www.protocol");
        System.out.println(retrieve(args[0]));
    }

    public static String retrieve(String s)
        throws IOException
    {
        BufferedReader bufferedreader = null;
        try
        {
            URL url = new URL(s);
            if(!url.getProtocol().equals("https"))
                throw new IOException("only 'https' URLs are valid for this method");
            URLConnection urlconnection = url.openConnection();
            urlconnection.setRequestProperty("Connection", "close");
            bufferedreader = new BufferedReader(new InputStreamReader(urlconnection.getInputStream()));
            StringBuffer stringbuffer = new StringBuffer();
            String s1;
            while((s1 = bufferedreader.readLine()) != null) 
                stringbuffer.append(s1 + "\n");
            String s2 = stringbuffer.toString();
            return s2;
        }
        finally
        {
            try
            {
                if(bufferedreader != null)
                    bufferedreader.close();
            }
            catch(IOException ioexception) { }
        }
    }

    public SecureURL()
    {
    }
}
