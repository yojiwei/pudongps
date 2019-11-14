// Decompiled by Jad v1.5.7g. Copyright 2000 Pavel Kouznetsov.
// Jad home page: http://www.geocities.com/SiliconValley/Bridge/8617/jad.html
// Decompiler options: packimports(3) fieldsfirst ansi 
// Source File Name:   CMail.java

package com.util;

import java.io.PrintStream;
import java.util.Hashtable;
import java.util.Properties;
import javax.activation.DataHandler;
import javax.activation.FileDataSource;
import javax.mail.*;
import javax.mail.internet.*;

public class CMail
{

    private MimeMessage mimeMsg;
    private Session session;
    private Properties props;
    private boolean needAuth;
    private String username;
    private String password;
    private Multipart mp;

    public CMail()
    {
        needAuth = false;
        username = "";
        password = "";
        setSmtpHost("localhost");
        createMimeMessage();
    }

    public CMail(String smtp)
    {
        needAuth = false;
        username = "";
        password = "";
        setSmtpHost(smtp);
        createMimeMessage();
    }

    public void setSmtpHost(String hostName)
    {
        System.out.println("设置系统属性：mail.smtp.host = ".concat(String.valueOf(String.valueOf(hostName))));
        if(props == null)
            props = System.getProperties();
        props.put("mail.smtp.host", hostName);
        props.put("mail.smtp.port", "587");
        System.out.println("set smtp port 587");
    }

    public boolean createMimeMessage()
    {
        try
        {
            System.out.println("准备获取邮件会话对象！");
            session = Session.getDefaultInstance(props, null);
        }
        catch(Exception e)
        {
            System.err.println("获取邮件会话对象时发生错误！".concat(String.valueOf(String.valueOf(e))));
            boolean flag1 = false;
            return flag1;
        }
        System.out.println("准备创建MIME邮件对象！");
        try
        {
            mimeMsg = new MimeMessage(session);
            mp = new MimeMultipart();
            boolean flag = true;
            return flag;
        }
        catch(Exception e)
        {
            System.err.println("创建MIME邮件对象失败！".concat(String.valueOf(String.valueOf(e))));
        }
        boolean flag2 = false;
        return flag2;
    }

    public void setNeedAuth(boolean need)
    {
        System.out.println("设置smtp身份认证：mail.smtp.auth = ".concat(String.valueOf(String.valueOf(need))));
        if(props == null)
            props = System.getProperties();
        if(need)
            props.put("mail.smtp.auth", "true");
        else
            props.put("mail.smtp.auth", "false");
    }

    public void setNamePass(String name, String pass)
    {
        username = name;
        password = pass;
    }

    public boolean setSubject(String mailSubject)
    {
        System.out.println("设置邮件主题！");
        try
        {
            mimeMsg.setSubject(mailSubject);
            boolean flag = true;
            return flag;
        }
        catch(Exception e)
        {
            System.err.println("设置邮件主题发生错误！");
        }
        boolean flag1 = false;
        return flag1;
    }

    public boolean setBody(String mailBody)
    {
        try
        {
            BodyPart bp = new MimeBodyPart();
            bp.setContent("<meta http-equiv=Content-Type content=text/html; charset=gb2312>".concat(String.valueOf(String.valueOf(mailBody))), "text/html;charset=GB2312");
            mp.addBodyPart(bp);
            boolean flag = true;
            return flag;
        }
        catch(Exception e)
        {
            System.err.println("设置邮件正文时发生错误！".concat(String.valueOf(String.valueOf(e))));
        }
        boolean flag1 = false;
        return flag1;
    }

    public boolean addFileAffix(String filename)
    {
        System.out.println("增加邮件附件：".concat(String.valueOf(String.valueOf(filename))));
        try
        {
            BodyPart bp = new MimeBodyPart();
            FileDataSource fileds = new FileDataSource(filename);
            bp.setDataHandler(new DataHandler(fileds));
            bp.setFileName(fileds.getName());
            mp.addBodyPart(bp);
            boolean flag1 = true;
            return flag1;
        }
        catch(Exception e)
        {
            System.err.println(String.valueOf(String.valueOf((new StringBuffer("增加邮件附件：")).append(filename).append("发生错误！").append(e))));
        }
        boolean flag = false;
        return flag;
    }

    public boolean setFrom(String from)
    {
        System.out.println("设置发信人！");
        try
        {
            mimeMsg.setFrom(new InternetAddress(from));
            boolean flag = true;
            return flag;
        }
        catch(Exception e)
        {
            boolean flag1 = false;
            return flag1;
        }
    }

    public boolean setTo(String to)
    {
        if(to == null)
            return false;
        try
        {
            mimeMsg.setRecipients(javax.mail.Message.RecipientType.TO, InternetAddress.parse(to));
            boolean flag = true;
            return flag;
        }
        catch(Exception e)
        {
            boolean flag1 = false;
            return flag1;
        }
    }

    public boolean setCopyTo(String copyto)
    {
        if(copyto == null)
            return false;
        try
        {
            mimeMsg.setRecipients(javax.mail.Message.RecipientType.CC, InternetAddress.parse(copyto));
            boolean flag = true;
            return flag;
        }
        catch(Exception e)
        {
            boolean flag1 = false;
            return flag1;
        }
    }

    public boolean sendout()
    {
        try
        {
            mimeMsg.setContent(mp);
            mimeMsg.saveChanges();
            System.out.println("正在发送邮件....");
            Session mailSession = Session.getInstance(props, null);
            Transport transport = mailSession.getTransport("smtp");
            transport.connect((String)props.get("mail.smtp.host"), username, password);
            transport.sendMessage(mimeMsg, mimeMsg.getRecipients(javax.mail.Message.RecipientType.TO));
            System.out.println("发送邮件成功！");
            transport.close();
            boolean flag1 = true;
            return flag1;
        }
        catch(Exception e)
        {
            System.err.println("邮件发送失败！".concat(String.valueOf(String.valueOf(e))));
        }
        boolean flag = false;
        return flag;
    }

    public static void main(String args[])
    {
        String mailbody = "<meta http-equiv=Content-Type content=text/html; charset=gb2312><div align=center><a href=http://www.csdn.net> csdn </a></div>";
        CMail themail = new CMail("smtp.163.com");
        themail.setNeedAuth(true);
        if(!themail.setSubject("标题"))
            return;
        if(!themail.setBody(mailbody))
            return;
        if(!themail.setTo("yaojiwei@beyondbit.com"))
            return;
        if(!themail.setFrom("yanker126@163.com"))
            return;
       // if(!themail.addFileAffix("c:\\boot.ini"))
        //    return;
        themail.setNamePass("yanker126", "nuo!@#");
        if(!themail.sendout())
            return;
        else
            return;
    }
}
