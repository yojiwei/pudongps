// Decompiled by Jad v1.5.7g. Copyright 2000 Pavel Kouznetsov.
// Jad home page: http://www.geocities.com/SiliconValley/Bridge/8617/jad.html
// Decompiler options: packimports(3) fieldsfirst ansi 
// Source File Name:   Util.java

package edu.yale.its.tp.cas.ticket;

import java.security.SecureRandom;

public class Util
{

    private static int TRANSACTION_ID_LENGTH = 32;

    public static synchronized String toPrintable(byte abyte0[])
    {
        char ac[] = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890".toCharArray();
        char ac1[] = new char[abyte0.length];
        for(int i = 0; i < abyte0.length; i++)
        {
            int j = abyte0[i] % ac.length;
            if(j < 0)
                j += ac.length;
            ac1[i] = ac[j];
        }

        return new String(ac1);
    }

    public static String getTransactionId()
    {
        byte abyte0[] = new byte[TRANSACTION_ID_LENGTH];
        SecureRandom securerandom = new SecureRandom();
        securerandom.nextBytes(abyte0);
        return toPrintable(abyte0);
    }

    public Util()
    {
    }

}
