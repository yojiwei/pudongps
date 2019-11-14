// Decompiled by Jad v1.5.7g. Copyright 2000 Pavel Kouznetsov.
// Jad home page: http://www.geocities.com/SiliconValley/Bridge/8617/jad.html
// Decompiler options: packimports(3) fieldsfirst ansi 
// Source File Name:   LoginTicketCache.java

package edu.yale.its.tp.cas.ticket;

import java.security.SecureRandom;
import java.util.*;

// Referenced classes of package edu.yale.its.tp.cas.ticket:
//            OTUTicketCache, LoginTicket, ActiveTicketCache, TicketException, 
//            Util, DuplicateTicketException, Ticket

public class LoginTicketCache extends OTUTicketCache
{

    private static final int TICKET_ID_LENGTH = 20;
    private Map ticketCache;
    private static int serial = 0;

    public LoginTicketCache(int i)
    {
        super(i);
        ticketCache = Collections.synchronizedMap(new HashMap());
    }

    public synchronized String addTicket()
        throws TicketException
    {
        return addTicket(new LoginTicket());
    }

    protected String newTicketId()
    {
        String s = "LT";
        byte abyte0[] = new byte[20];
        SecureRandom securerandom = new SecureRandom();
        securerandom.nextBytes(abyte0);
        String s1 = s + "-" + serial++ + "-" + Util.toPrintable(abyte0);
        if(ticketCache.get(s1) != null)
            return newTicketId();
        else
            return s1;
    }

    protected void storeTicket(String s, Ticket ticket)
        throws TicketException
    {
        if(ticketCache.get(s) != null)
        {
            throw new DuplicateTicketException();
        } else
        {
            ticketCache.put(s, ticket);
            return;
        }
    }

    protected Ticket retrieveTicket(String s)
    {
        Object obj = ticketCache.get(s);
        if(obj == null)
            return null;
        else
            return (Ticket)obj;
    }

    public void deleteTicket(String s)
    {
        Object obj = ticketCache.remove(s);
    }

    public int getSerialNumber()
    {
        return serial;
    }

    public int getCacheSize()
    {
        return ticketCache.size();
    }

}
