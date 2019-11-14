// Decompiled by Jad v1.5.7g. Copyright 2000 Pavel Kouznetsov.
// Jad home page: http://www.geocities.com/SiliconValley/Bridge/8617/jad.html
// Decompiler options: packimports(3) fieldsfirst ansi 
// Source File Name:   ServiceTicket.java

package edu.yale.its.tp.cas.ticket;


// Referenced classes of package edu.yale.its.tp.cas.ticket:
//            Ticket, TicketGrantingTicket

public class ServiceTicket extends Ticket
{

    private TicketGrantingTicket grantor;
    private String service;
    private boolean fromNewLogin;

    public ServiceTicket(TicketGrantingTicket ticketgrantingticket, String s, boolean flag)
    {
        grantor = ticketgrantingticket;
        service = s;
        fromNewLogin = flag;
    }

    public String getUsername()
    {
        return grantor.getUsername();
    }

    public String getService()
    {
        return service;
    }

    public boolean isFromNewLogin()
    {
        return fromNewLogin;
    }

    public boolean isValid()
    {
        return grantor.isExpired() ^ true;
    }

    public TicketGrantingTicket getGrantor()
    {
        return grantor;
    }
}
