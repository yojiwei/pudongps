// Decompiled by Jad v1.5.7g. Copyright 2000 Pavel Kouznetsov.
// Jad home page: http://www.geocities.com/SiliconValley/Bridge/8617/jad.html
// Decompiler options: packimports(3) fieldsfirst ansi 
// Source File Name:   BusyFlag.java

package com.smsCase;

import java.io.PrintStream;

public class BusyFlag
{

    protected Thread busyflag;
    protected int busycount;

    public BusyFlag()
    {
        busyflag = null;
        busycount = 0;
    }

    public synchronized void getBusyFlag()
    {
        while(!tryGetBusyFlag()) 
            try
            {
                wait();
            }
            catch(Exception e)
            {
                System.out.println(e.getMessage());
            }
    }

    private synchronized boolean tryGetBusyFlag()
    {
        if(busyflag == null)
        {
            busyflag = Thread.currentThread();
            busycount = 1;
            return true;
        }
        if(busyflag == Thread.currentThread())
        {
            busycount++;
            return true;
        } else
        {
            return false;
        }
    }

    public synchronized Thread getOwner()
    {
        return busyflag;
    }

    public synchronized void freeBusyFlag()
    {
        if(getOwner() == Thread.currentThread())
        {
            busycount--;
            if(busycount == 0)
            {
                busyflag = null;
                notify();
            }
        }
    }

    public static void main(String args1[])
    {
    	System.out.println("xc");
    }
}
