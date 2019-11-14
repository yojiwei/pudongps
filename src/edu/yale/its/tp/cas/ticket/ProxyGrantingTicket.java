// Decompiled by Jad v1.5.7g. Copyright 2000 Pavel Kouznetsov.
// Jad home page: http://www.geocities.com/SiliconValley/Bridge/8617/jad.html
// Decompiler options: packimports(3) fieldsfirst ansi 
// Source File Name:   ProxyGrantingTicket.java

package edu.yale.its.tp.cas.ticket;

import java.util.ArrayList;
import java.util.List;

// Referenced classes of package edu.yale.its.tp.cas.ticket:
//            TicketGrantingTicket, ServiceTicket

public class ProxyGrantingTicket extends TicketGrantingTicket
{

    private ServiceTicket parent;
    private String proxyId;

    public ProxyGrantingTicket(ServiceTicket serviceticket, String s)
    {
        super(serviceticket.getUsername());
        parent = serviceticket;
        proxyId = s;
    }

    public String getUsername()
    {
        return parent.getUsername();
    }

    public ServiceTicket getParent()
    {
        return parent;
    }

    public String getProxyService()
    {
        return proxyId;
    }

    public List getProxies()
    {
        ArrayList arraylist = new ArrayList();
        arraylist.add(getProxyService());
        if(parent.getGrantor() instanceof ProxyGrantingTicket)
        {
            ProxyGrantingTicket proxygrantingticket = (ProxyGrantingTicket)parent.getGrantor();
            arraylist.addAll(proxygrantingticket.getProxies());
        }
        return arraylist;
    }

    public boolean isExpired()
    {
        return super.isExpired() || parent.getGrantor().isExpired();
    }
}
