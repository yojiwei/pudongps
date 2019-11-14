// Decompiled by Jad v1.5.7g. Copyright 2000 Pavel Kouznetsov.
// Jad home page: http://www.geocities.com/SiliconValley/Bridge/8617/jad.html
// Decompiler options: packimports(3) fieldsfirst ansi 
// Source File Name:   TicketCache.java

package edu.yale.its.tp.cas.ticket;


// Referenced classes of package edu.yale.its.tp.cas.ticket:
//            TicketException, Ticket

public interface TicketCache
{

    public abstract String addTicket(Ticket ticket)
        throws TicketException;

    public abstract Ticket getTicket(String s);

    public abstract void deleteTicket(String s);
}
