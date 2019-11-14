// Decompiled by Jad v1.5.7g. Copyright 2000 Pavel Kouznetsov.
// Jad home page: http://www.geocities.com/SiliconValley/Bridge/8617/jad.html
// Decompiler options: packimports(3) fieldsfirst ansi 
// Source File Name:   TicketGrantingTicket.java

package edu.yale.its.tp.cas.ticket;


// Referenced classes of package edu.yale.its.tp.cas.ticket:
//            Ticket

public class TicketGrantingTicket extends Ticket
{

    private String username;
    private boolean expired;

    public TicketGrantingTicket(String s)
    {
        username = s;
        expired = false;
    }

    public String getUsername()
    {
        return username;
    }

    public void expire()
    {
        expired = true;
    }

    public boolean isExpired()
    {
        return expired;
    }
}
