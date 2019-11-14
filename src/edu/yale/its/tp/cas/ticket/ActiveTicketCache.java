// Decompiled by Jad v1.5.7g. Copyright 2000 Pavel Kouznetsov.
// Jad home page: http://www.geocities.com/SiliconValley/Bridge/8617/jad.html
// Decompiler options: packimports(3) fieldsfirst ansi 
// Source File Name:   ActiveTicketCache.java

package edu.yale.its.tp.cas.ticket;

import java.util.*;

// Referenced classes of package edu.yale.its.tp.cas.ticket:
//            TicketCache, TicketException, Ticket

public abstract class ActiveTicketCache
    implements TicketCache
{
    private class timerThread extends Thread
    {

        public static final int PERIOD = 60000;
        public boolean done;

        private void finit$()
        {
            done = false;
        }

        public void run()
        {
            while(!done) 
                try
                {
                    expireInactive();
                    Thread.sleep(60000L);
                }
                catch(InterruptedException interruptedexception) { }
        }

        timerThread()
        {
            super();
            finit$();
        }
    }


    private Map timer;
    private int tolerance;

    protected abstract String newTicketId();

    protected abstract void storeTicket(String s, Ticket ticket)
        throws TicketException;

    protected abstract Ticket retrieveTicket(String s);

    public synchronized String addTicket(Ticket ticket)
        throws TicketException
    {
        String s = newTicketId();
        resetTimer(s);
        storeTicket(s, ticket);
        return s;
    }

    public Ticket getTicket(String s)
    {
        resetTimer(s);
        return retrieveTicket(s);
    }

    public ActiveTicketCache(int i)
    {
        timer = Collections.synchronizedMap(new WeakHashMap());
        tolerance = i;
        timerThread timerthread = new timerThread();
        timerthread.setDaemon(true);
        timerthread.start();
    }

    private void resetTimer(String s)
    {
        timer.put(s, new Date());
    }

    private void expireInactive()
    {
        long l = (new Date()).getTime();
        synchronized(timer)
        {
            Iterator iterator = timer.entrySet().iterator();
            do
            {
                if(!iterator.hasNext())
                    break;
                java.util.Map.Entry entry = (java.util.Map.Entry)iterator.next();
                long l1 = ((Date)entry.getValue()).getTime();
                if(l - (long)(tolerance * 1000) >= l1)
                {
                    iterator.remove();
                    deleteTicket((String)entry.getKey());
                }
            } while(true);
        }
    }

}
