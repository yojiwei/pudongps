// Decompiled by Jad v1.5.7g. Copyright 2000 Pavel Kouznetsov.
// Jad home page: http://www.geocities.com/SiliconValley/Bridge/8617/jad.html
// Decompiler options: packimports(3) fieldsfirst ansi 
// Source File Name:   ServiceTicketCache.java

package edu.yale.its.tp.cas.ticket;

import java.security.SecureRandom;
import java.util.*;

// Referenced classes of package edu.yale.its.tp.cas.ticket:
//            OTUTicketCache, Util, DuplicateTicketException, InvalidTicketException, 
//            TicketException, ServiceTicket, Ticket

public class ServiceTicketCache extends OTUTicketCache
{

    private static final int TICKET_ID_LENGTH = 20;
    private Map ticketCache;
    private Class ticketType;
    private static int serial = 0;

    static Class class$(String s)
        throws NoClassDefFoundError
    {
        try
        {
            return Class.forName(s);
        }
        catch(ClassNotFoundException classnotfoundexception)
        {
            throw new NoClassDefFoundError(classnotfoundexception.getMessage());
        }
    }

    public ServiceTicketCache(Class class1, int i)
    {
        super(i);
        if(!class$("edu.yale.its.tp.cas.ticket.ServiceTicket").isAssignableFrom(class1))
        {
            throw new IllegalArgumentException("ServiceTicketCache may only store service or proxy tickets");
        } else
        {
            ticketType = class1;
            ticketCache = Collections.synchronizedMap(new HashMap());
            return;
        }
    }

    protected String newTicketId()
    {
        String s;
        if(ticketType == class$("edu.yale.its.tp.cas.ticket.ServiceTicket"))
            s = "ST";
        else
        if(ticketType == class$("edu.yale.its.tp.cas.ticket.ProxyTicket"))
            s = "PT";
        else
            s = "UNKS";
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
            throw new DuplicateTicketException();
        if(!ticket.getClass().equals(ticketType))
        {
            throw new InvalidTicketException("got " + ticket.getClass() + "; needed " + ticketType);
        } else
        {
            ticketCache.put(s, ticket);
            return;
        }
    }

    protected Ticket retrieveTicket(String s)
    {
        Object obj = ticketCache.get(s);
        if(obj == null || !((ServiceTicket)obj).isValid())
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
