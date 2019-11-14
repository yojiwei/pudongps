// Decompiled by Jad v1.5.7g. Copyright 2000 Pavel Kouznetsov.
// Jad home page: http://www.geocities.com/SiliconValley/Bridge/8617/jad.html
// Decompiler options: packimports(3) fieldsfirst ansi 
// Source File Name:   StringUtil.java

package edu.yale.its.tp.cas.util;


public class StringUtil
{

    public static String substituteAll(String s, String s1, String s2)
    {
        if(s == null)
            return null;
        for(; s.indexOf(s1) != -1; s = substituteOne(s, s1, s2));
        return s;
    }

    public static String substituteOne(String s, String s1, String s2)
    {
        if(s == null)
            return null;
        int i = s.indexOf(s1);
        if(i == -1)
        {
            return s;
        } else
        {
            int j = i + s1.length();
            return (new StringBuffer(s)).replace(i, j, s2).toString();
        }
    }

    public StringUtil()
    {
    }
}
