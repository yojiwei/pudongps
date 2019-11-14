// Decompiled by Jad v1.5.7g. Copyright 2000 Pavel Kouznetsov.
// Jad home page: http://www.geocities.com/SiliconValley/Bridge/8617/jad.html
// Decompiler options: packimports(3) fieldsfirst ansi 
// Source File Name:   GrantorCache.java

package edu.yale.its.tp.cas.ticket;

import java.security.SecureRandom;
import java.util.*;

// Referenced classes of package edu.yale.its.tp.cas.ticket:
//            ActiveTicketCache, Util, DuplicateTicketException, InvalidTicketException, 
//            TicketException, TicketGrantingTicket, Ticket

public class GrantorCache extends ActiveTicketCache
{

    private static final int TICKET_ID_LENGTH = 50;
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

    public GrantorCache(Class class1, int i)
    {
        super(i);
        if(!class$("edu.yale.its.tp.cas.ticket.TicketGrantingTicket").isAssignableFrom(class1))
        {
            throw new IllegalArgumentException("GrantorCache may only store granting tickets");
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
        if(ticketType == class$("edu.yale.its.tp.cas.ticket.TicketGrantingTicket"))
            s = "TGC";
        else
        if(ticketType == class$("edu.yale.its.tp.cas.ticket.ProxyGrantingTicket"))
            s = "PGT";
        else
            s = "UNK";
        byte abyte0[] = new byte[50];
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
        if(obj == null || ((TicketGrantingTicket)obj).isExpired())
            return null;
        else
            return (Ticket)obj;
    }

    public void deleteTicket(String s)
    {
        Object obj = ticketCache.remove(s);
        if(obj == null)
        {
            return;
        } else
        {
            TicketGrantingTicket ticketgrantingticket = (TicketGrantingTicket)obj;
            ticketgrantingticket.expire();//果然是这个方法
            return;
        }
    }

    public int getCacheSize()
    {
        return ticketCache.size();
    }

}
