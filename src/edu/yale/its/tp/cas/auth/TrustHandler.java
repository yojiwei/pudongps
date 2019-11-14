// Decompiled by Jad v1.5.7g. Copyright 2000 Pavel Kouznetsov.
// Jad home page: http://www.geocities.com/SiliconValley/Bridge/8617/jad.html
// Decompiler options: packimports(3) fieldsfirst ansi 
// Source File Name:   TrustHandler.java

package edu.yale.its.tp.cas.auth;

import javax.servlet.ServletRequest;

// Referenced classes of package edu.yale.its.tp.cas.auth:
//            AuthHandler

public interface TrustHandler
    extends AuthHandler
{

    public abstract String getUsername(ServletRequest servletrequest);
}
