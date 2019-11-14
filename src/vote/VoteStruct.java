// Decompiled by Jad v1.5.7f. Copyright 2000 Pavel Kouznetsov.
// Jad home page: http://www.geocities.com/SiliconValley/Bridge/8617/jad.html
// Decompiler options: packimports(3) 
// Source File Name:   VoteStruct.java

package vote;


public class VoteStruct
{

    public VoteStruct()
    {
        id = 0;
        name = "";
        upperid = 0;
        type = "";
        sequence = 0;
        dbname = "";
        frontpagename = "";
        desc = "";
        parameter = "";
        level = 0;
    }

    public int getLevel()
    {
        return level;
    }

    public void setLevel(int level)
    {
        this.level = level;
    }

    public static void main(String args1[])
    {
    }

    public String getDbname()
    {
        return dbname;
    }

    public void setDbname(String dbname)
    {
        this.dbname = dbname;
    }

    public String getDesc()
    {
        return desc;
    }

    public void setDesc(String desc)
    {
        this.desc = desc;
    }

    public String getFrontpagename()
    {
        return frontpagename;
    }

    public void setFrontpagename(String frontpagename)
    {
        this.frontpagename = frontpagename;
    }

    public int getId()
    {
        return id;
    }

    public void setId(int id)
    {
        this.id = id;
    }

    public String getName()
    {
        return name;
    }

    public void setName(String name)
    {
        this.name = name;
    }

    public String getParameter()
    {
        return parameter;
    }

    public void setParameter(String parameter)
    {
        this.parameter = parameter;
    }

    public int getSequence()
    {
        return sequence;
    }

    public void setSequence(int sequence)
    {
        this.sequence = sequence;
    }

    public String getType()
    {
        return type;
    }

    public void setType(String type)
    {
        this.type = type;
    }

    public int getUpperid()
    {
        return upperid;
    }

    public void setUpperid(int upperid)
    {
        this.upperid = upperid;
    }

    private int id;
    private String name;
    private int upperid;
    private String type;
    private int sequence;
    private String dbname;
    private String frontpagename;
    private String desc;
    private String parameter;
    private int level;
}
