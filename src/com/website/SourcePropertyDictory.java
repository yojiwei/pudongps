// Decompiled by Jad v1.5.7g. Copyright 2000 Pavel Kouznetsov.
// Jad home page: http://www.geocities.com/SiliconValley/Bridge/8617/jad.html
// Decompiler options: packimports(3) fieldsfirst ansi 
// Source File Name:   SourcePropertyDictory.java

package com.website;

import java.util.Hashtable;
import java.util.Vector;

public class SourcePropertyDictory
{

    private String sjid;
    private String sjname;
    private String sjcode;
    private Vector vect;

    public SourcePropertyDictory(Vector vect)
    {
        this.vect = null;
        this.vect = vect;
        operate();
    }

    public void setSjid(String str)
    {
        sjid = str;
    }

    public String getSjid()
    {
        return sjid;
    }

    public String getSjname()
    {
        return sjname;
    }

    public String getSjcode()
    {
        return sjcode;
    }

    private void operate()
    {
        if(vect != null)
        {
            for(int i = 0; i < vect.size(); i++)
            {
                Hashtable content = (Hashtable)vect.get(i);
                if(Messages.getString(content.get("sj_dir").toString()) == "")
                    continue;
                String value[] = Messages.getString(content.get("sj_dir").toString()).split(";");
                sjname = value[0];
                sjcode = value[1];
                break;
            }

        }
    }

    public static void main(String args1[])
    {
    }
}
