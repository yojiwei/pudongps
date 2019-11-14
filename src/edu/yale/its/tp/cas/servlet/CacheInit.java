// Decompiled by Jad v1.5.7g. Copyright 2000 Pavel Kouznetsov.
// Jad home page: http://www.geocities.com/SiliconValley/Bridge/8617/jad.html
// Decompiler options: packimports(3) fieldsfirst ansi 
// Source File Name:   CacheInit.java

package edu.yale.its.tp.cas.servlet;

import edu.yale.its.tp.cas.ticket.*;
import javax.servlet.*;
/**
 * hello everyone !
 */
public class CacheInit
    implements ServletContextListener
{

    private static final int GRANTING_TIMEOUT_DEFAULT = 7200;
    private static final int SERVICE_TIMEOUT_DEFAULT = 300;
    private static final int LOGIN_TIMEOUT_DEFAULT = 43200;

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

    public void contextInitialized(ServletContextEvent servletcontextevent)
    {
        ServletContext servletcontext = servletcontextevent.getServletContext();
        String s = servletcontext.getInitParameter("edu.yale.its.tp.cas.grantingTimeout");
        String s1 = servletcontext.getInitParameter("edu.yale.its.tp.cas.serviceTimeout");
        String s2 = servletcontext.getInitParameter("edu.yale.its.tp.cas.loginTimeout");
        int k;
        try
        {
            k = Integer.parseInt(s);
        }
        catch(NumberFormatException numberformatexception)
        {
            k = 7200;
        }
        catch(NullPointerException nullpointerexception)
        {
            k = 7200;
        }
        int j;
        try
        {
            j = Integer.parseInt(s1);
        }
        catch(NumberFormatException numberformatexception1)
        {
            j = 300;
        }
        catch(NullPointerException nullpointerexception1)
        {
            j = 300;
        }
        int i;
        try
        {
            i = Integer.parseInt(s2);
        }
        catch(NumberFormatException numberformatexception2)
        {
            i = 43200;
        }
        catch(NullPointerException nullpointerexception2)
        {
            i = 43200;
        }
        GrantorCache grantorcache = new GrantorCache(class$("edu.yale.its.tp.cas.ticket.TicketGrantingTicket"), k);
        GrantorCache grantorcache1 = new GrantorCache(class$("edu.yale.its.tp.cas.ticket.ProxyGrantingTicket"), k);
        ServiceTicketCache serviceticketcache = new ServiceTicketCache(class$("edu.yale.its.tp.cas.ticket.ServiceTicket"), j);
        ServiceTicketCache serviceticketcache1 = new ServiceTicketCache(class$("edu.yale.its.tp.cas.ticket.ProxyTicket"), j);
        LoginTicketCache loginticketcache = new LoginTicketCache(i);
        servletcontext.setAttribute("tgcCache", grantorcache);
        servletcontext.setAttribute("pgtCache", grantorcache1);
        servletcontext.setAttribute("stCache", serviceticketcache);
        servletcontext.setAttribute("ptCache", serviceticketcache1);
        servletcontext.setAttribute("ltCache", loginticketcache);
    }

    public void contextDestroyed(ServletContextEvent servletcontextevent)
    {
    }

    public CacheInit()
    {
    }
}
