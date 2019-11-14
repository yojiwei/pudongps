// Decompiled by Jad v1.5.7g. Copyright 2000 Pavel Kouznetsov.
// Jad home page: http://www.geocities.com/SiliconValley/Bridge/8617/jad.html
// Decompiler options: packimports(3) fieldsfirst ansi 
// Source File Name:   ProxyTicket.java

package edu.yale.its.tp.cas.ticket;

import java.util.List;

// Referenced classes of package edu.yale.its.tp.cas.ticket:
//            ServiceTicket, ProxyGrantingTicket

public class ProxyTicket extends ServiceTicket
{

    private ProxyGrantingTicket grantor;

    public ProxyTicket(ProxyGrantingTicket proxygrantingticket, String s)
    {
        super(proxygrantingticket, s, false);
        grantor = proxygrantingticket;
    }

    public List getProxies()
    {
        return grantor.getProxies();
    }
}
