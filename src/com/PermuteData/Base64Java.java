// Decompiled by Jad v1.5.7g. Copyright 2000 Pavel Kouznetsov.
// Jad home page: http://www.geocities.com/SiliconValley/Bridge/8617/jad.html
// Decompiler options: packimports(3) fieldsfirst ansi 
// Source File Name:   Base64Java.java

package com.PermuteData;

import java.io.*;
import org.apache.axis.encoding.Base64;

public class Base64Java
{

    public Base64Java()
    {
    }

    public void filecopy(String fileadd, byte bytes[])
    {
        BufferedOutputStream aim = null;
        try
        {
            aim = new BufferedOutputStream(new FileOutputStream(fileadd));
            aim.write(bytes);
            aim.close();
        }
        catch(IOException e)
        {
            e.printStackTrace();
        }
    }

    public String Base64File(byte bytes[])
    {
        String ret = Base64.encode(bytes);
        return ret;
    }

    public byte[] getByte(String result)
    {
        byte bytes[] = (byte[])null;
        bytes = Base64.decode(result);
        return bytes;
    }

    public byte[] ReadFile(String filename)
    {
        BufferedInputStream source = null;
        byte bytes[] = (byte[])null;
        File file = new File(filename);
        try
        {
            source = new BufferedInputStream(new FileInputStream(file));
            bytes = new byte[(int)file.length()];
            source.read(bytes);
            source.close();
        }
        catch(IOException e)
        {
            e.printStackTrace();
        }
        return bytes;
    }

    public static void main(String arg[])
    {
        System.out.println("out");
    }
}
