// Decompiled by Jad v1.5.7g. Copyright 2000 Pavel Kouznetsov.
// Jad home page: http://www.geocities.com/SiliconValley/Bridge/8617/jad.html
// Decompiler options: packimports(3) fieldsfirst ansi 
// Source File Name:   PostCG.java

package com.PermuteData;

import com.component.database.CDataCn;
import com.component.database.CDataImpl;
import com.util.CDate;
import com.util.CMessage;
import java.io.PrintStream;
import java.util.*;

// Referenced classes of package com.PermuteData:
//            PostDocunment

public class PostCG
{

    public PostCG()
    {
    }

    public String GetXMlSize()
    {
        String woids;
        CDataCn dCn = null;
        CDataImpl dImpl = null;
        CDataCn dCnWSB = null;
        CDataImpl dImplWSB = null;
        String sql = "select w.wo_id from tb_owexch o ,tb_work w where o.wo_id =w.wo_id and o.OE_STATUS=0 and w.wo_status=1";
        Vector vec = null;
        woids = "";
        String woid = "";
        Hashtable map = null;
        try
        {
            dCn = new CDataCn();
            dImpl = new CDataImpl(dCn);
            dCnWSB = new CDataCn("wsb");
            dImplWSB = new CDataImpl(dCnWSB);
            vec = dImpl.splitPage(sql, 100, 1);
            if(vec != null)
            {
                for(int i = 0; i < vec.size(); i++)
                {
                    map = (Hashtable)vec.get(i);
                    woid = map.get("wo_id").toString();
                    sql = "select ow_id from tb_onlinework where wo_id='" + woid + "'";
                    map = dImplWSB.getDataInfo(sql);
                    if(map != null)
                        woids = woids + woid + ";";
                }

            }
        }
        catch(Exception e)
        {
            System.out.println(e.getMessage());
        }
        finally
        {
            dImpl.closeStmt();
            dCn.closeCn();
            dImplWSB.closeStmt();
            dCnWSB.closeCn();
        }
        return woids;
    }

    public String GetXMl(String woid)
    {
        String xml;
        CDataCn dCn = null;
        CDataImpl dImpl = null;
        CDataCn dCnWSB = null;
        CDataImpl dImplWSB = null;
        String prtarget = "";
        String prid = "";
        String prname = "";
        String sql = "select w.us_id,p.pr_name,p.pr_id from tb_work w,tb_proceeding p where w.pr_id = p.pr_id and wo_id='" + woid + "' and w.wo_status = 1";
        String contentSql = "select ow_id,ow_content  from tb_onlinework  where wo_id='" + woid + "'";
        Hashtable map = null;
        Hashtable contentMap = null;
        String stXml = "";
        xml = "";
        try
        {
            dCn = new CDataCn();
            dImpl = new CDataImpl(dCn);
            dCnWSB = new CDataCn("wsb");
            dImplWSB = new CDataImpl(dCnWSB);
            map = dImpl.getDataInfo(sql);
            contentMap = dImplWSB.getDataInfo(contentSql);
            if(map != null && contentMap != null)
            {
                prid = map.get("pr_id").toString().trim();
                prname = map.get("pr_name").toString().trim();
                stXml = contentMap.get("ow_content").toString().trim();
                if("o1211".equals(prid))
                    prtarget = "100000";
                else
                if("o1213".equals(prid))
                    prtarget = "100000";
                PostDocunment pod = new PostDocunment();
                xml = pod.getBizXml(woid, stXml, prid, prname, prtarget);
            }
        }
        catch(Exception e)
        {
            System.out.println(e.getMessage());
        }
        finally
        {
            dImpl.closeStmt();
            dCn.closeCn();
            dImplWSB.closeStmt();
            dCnWSB.closeCn();
        }
        return xml;
    }

    public void SetSTATUS(String woid, String status)
    {
        CDataCn dCn = new CDataCn();
        CDataImpl dImpl = new CDataImpl(dCn);
        dImpl.setTableName("tb_owexch");
        dImpl.edit("tb_owexch", "wo_id", woid);
        dImpl.setValue("oe_status", status, 3);
        dImpl.update();
    }

    public void UpStatus(String wo_id, String opinion, String wo_status)
    {
        String dealType = "";
        String pr_name = "";
        String us_name = "";
        String us_id = "";
        String msgContent = "";
        if(wo_status.equals("4"))
            dealType = "3";
        else
        if(wo_status.equals("5"))
            dealType = "4";
        else
        if(wo_status.equals("0"))
            dealType = "0";
        if(!dealType.equals(""))
        {
            CDataCn dCn = new CDataCn();
            CDataImpl dImpl = new CDataImpl(dCn);
            dCn.beginTrans();
            if(dealType.equals("3") || dealType.equals("4"))
            {
                if(dealType.equals("3"))
                    msgContent = "已经通过";
                else
                if(dealType.equals("4"))
                    msgContent = "没有通过";
                String sqlStr = "select us_id,wo_applypeople,wo_projectname from tb_work where wo_id='" + wo_id + "'";
                Hashtable content = dImpl.getDataInfo(sqlStr);
                if(content != null)
                {
                    pr_name = content.get("wo_projectname").toString();
                    us_id = content.get("us_id").toString();
                    us_name = content.get("wo_applypeople").toString();
                }
                dImpl.edit("tb_work", "wo_id", wo_id);
                dImpl.setValue("wo_status", dealType, 3);
                dImpl.update();
                CMessage msg = new CMessage(dImpl);
                msg.addNew();
                msg.setValue(4, us_id);
                msg.setValue(5, us_name);
                msg.setValue(1, "您申请的项目“" + pr_name + "”" + msgContent);
                msg.setValue(6, "32");
                msg.setValue(7, "外事办");
                msg.setValue(8, "外事办");
                msg.setValue(3, "1");
                msg.setValue(12, "1");
                msg.setValue(13, wo_id);
                new CDate();
                msg.setValue(9, CDate.getNowTime());
                msg.setValue(2, opinion);
                msg.update();
            } else
            if(dealType.equals("0"))
            {
                String sqlStr = "select us_id,wo_applypeople,wo_projectname from tb_work where wo_id='" + wo_id + "'";
                Hashtable content = dImpl.getDataInfo(sqlStr);
                if(content != null)
                {
                    pr_name = content.get("wo_projectname").toString();
                    us_id = content.get("us_id").toString();
                    us_name = content.get("wo_applypeople").toString();
                }
                dImpl.edit("tb_work", "wo_id", wo_id);
                dImpl.setValue("wo_status", "2", 3);
                dImpl.update();
                CMessage msg = new CMessage(dImpl);
                msg.addNew();
                msg.setValue(4, us_id);
                msg.setValue(5, us_name);
                msg.setValue(1, "您申请的项目\"" + pr_name + "\"需要补充材料");
                msg.setValue(6, "32");
                msg.setValue(7, "外事办");
                msg.setValue(8, "外事办");
                msg.setValue(3, "1");
                msg.setValue(12, "1");
                msg.setValue(13, wo_id);
                new CDate();
                msg.setValue(9, CDate.getNowTime());
                msg.setValue(2, opinion);
                msg.update();
            } else
            {
                Pe("状态设置错误!");
            }
            dCn.commitTrans();
            dImpl.closeStmt();
            dCn.closeCn();
        }
    }
    //环保局办事回复
    public void UpHbjStatus(String wo_id,String wo_name, String opinion, String wo_status,String us_uid)
    {
        String dealType = "";
        String pr_name = "";
        String us_name = "";
        String us_id = "";
        String msgContent = "";
        if(wo_status.equals("4"))
            dealType = "3";
        else
        if(wo_status.equals("5"))
            dealType = "4";
        else
        if(wo_status.equals("0"))
            dealType = "0";
        if(!dealType.equals(""))
        {
            CDataCn dCn = new CDataCn();
            CDataImpl dImpl = new CDataImpl(dCn);
            
            dCn.beginTrans();
            //新增用户信息
            dImpl.addNew("tb_user","us_id");
            dImpl.setValue("us_uid",us_uid,CDataImpl.STRING);
            dImpl.setValue("us_pwd","123456",CDataImpl.STRING);//密码
            dImpl.setValue("ws_id","o27",CDataImpl.STRING);
            dImpl.update();
            //
            
            if(dealType.equals("3") || dealType.equals("4"))
            {
                if(dealType.equals("3"))
                    msgContent = "已经通过";
                else
                if(dealType.equals("4"))
                    msgContent = "没有通过";
                String sqlStr = "select us_id,wo_applypeople,wo_projectname from tb_work where wo_id='" + wo_id + "'";
                Hashtable content = dImpl.getDataInfo(sqlStr);
                if(content != null)
                {
                    pr_name = content.get("wo_projectname").toString();
                    us_id = content.get("us_id").toString();
                    us_name = content.get("wo_applypeople").toString();
                }
                dImpl.edit("tb_work", "wo_id", wo_id);
                dImpl.setValue("wo_status", dealType, 3);
                dImpl.update();
                CMessage msg = new CMessage(dImpl);
                msg.addNew();
                msg.setValue(4, us_id);
                msg.setValue(5, us_name);
                msg.setValue(1, "您申请的项目“" + wo_name + "”" + msgContent);
                msg.setValue(6, "32");
                msg.setValue(7, "环保局");
                msg.setValue(8, "环保局");
                msg.setValue(3, "1");
                msg.setValue(12, "1");
                msg.setValue(13, wo_id);
                new CDate();
                msg.setValue(9, CDate.getNowTime());
                msg.setValue(2, opinion);
                msg.update();
            } else
            if(dealType.equals("0"))
            {
                String sqlStr = "select us_id,wo_applypeople,wo_projectname from tb_work where wo_id='" + wo_id + "'";
                Hashtable content = dImpl.getDataInfo(sqlStr);
                if(content != null)
                {
                    pr_name = content.get("wo_projectname").toString();
                    us_id = content.get("us_id").toString();
                    us_name = content.get("wo_applypeople").toString();
                }
                dImpl.edit("tb_work", "wo_id", wo_id);
                dImpl.setValue("wo_status", "2", 3);
                dImpl.update();
                CMessage msg = new CMessage(dImpl);
                msg.addNew();
                msg.setValue(4, us_id);
                msg.setValue(5, us_name);
                msg.setValue(1, "您申请的项目\"" + wo_name + "\"需要补充材料");
                msg.setValue(6, "32");
                msg.setValue(7, "环保局");
                msg.setValue(8, "环保局");
                msg.setValue(3, "1");
                msg.setValue(12, "1");
                msg.setValue(13, wo_id);
                new CDate();
                msg.setValue(9, CDate.getNowTime());
                msg.setValue(2, opinion);
                msg.update();
            } else
            {
                Pe("状态设置错误!");
            }
            dCn.commitTrans();
            dImpl.closeStmt();
            dCn.closeCn();
        }
    }

    public void Pt(String key, String value)
    {
        System.out.println(new Date() + " -> " + key + " -> " + value);
    }

    public void Pe(String value)
    {
        System.err.println(new Date() + " -> " + value);
    }

    public static void main(String args[])
    {
        PostCG pCg = new PostCG();
        System.out.println(pCg.GetXMl("o487"));
    }
}
