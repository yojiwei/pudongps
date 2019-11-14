// Decompiled by Jad v1.5.7g. Copyright 2000 Pavel Kouznetsov.
// Jad home page: http://www.geocities.com/SiliconValley/Bridge/8617/jad.html
// Decompiler options: packimports(3) fieldsfirst ansi 
// Source File Name:   OTUTicketCache.java

package edu.yale.its.tp.cas.ticket;


// Referenced classes of package edu.yale.its.tp.cas.ticket:
//            ActiveTicketCache, Ticket

public abstract class OTUTicketCache extends ActiveTicketCache
{

    public OTUTicketCache(int i)
    {
        super(i);
    }

    public Ticket getTicket(String s)
    {
        Ticket ticket = super.getTicket(s);
        //deleteTicket(s);²»É¾³ý by sjb 20081021
        return ticket;
    }
}
