// Decompiled by Jad v1.5.7g. Copyright 2000 Pavel Kouznetsov.
// Jad home page: http://www.geocities.com/SiliconValley/Bridge/8617/jad.html
// Decompiler options: packimports(3) fieldsfirst ansi 
// Source File Name:   PasswordHandler.java

package edu.yale.its.tp.cas.auth;

import javax.servlet.ServletRequest;

// Referenced classes of package edu.yale.its.tp.cas.auth:
//            AuthHandler

public interface PasswordHandler
    extends AuthHandler
{

    public abstract boolean authenticate(ServletRequest servletrequest, String s, String s1);
}
