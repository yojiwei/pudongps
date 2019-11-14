// Decompiled by Jad v1.5.7g. Copyright 2000 Pavel Kouznetsov.
// Jad home page: http://www.geocities.com/SiliconValley/Bridge/8617/jad.html
// Decompiler options: packimports(3) fieldsfirst ansi 
// Source File Name:   Xml2DataDictionary.java

package com.util;

import com.component.database.CDataCn;
import com.component.database.CDataImpl;
import java.io.PrintStream;
import java.io.StringReader;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.*;
import org.jdom.*;
import org.jdom.input.SAXBuilder;

// Referenced classes of package com.util:
//            CMessage, CDate

public class Xml2DataDictionary
{

    private String rootElementName;
    private HashMap map;
    
    private BusyFlag busyFlag = new BusyFlag();

    public Xml2DataDictionary()
    {
        rootElementName = "";
        map = null;
    }

    public void lock(){
    	busyFlag.getBusyFlag();
    }
    
    public void unlock(){
    	busyFlag.freeBusyFlag();
    }
    
    public void init(String fileStr)
    {
        try
        {
            Document doc = null;
            SAXBuilder sb = null;
            Element ele = null;
            sb = new SAXBuilder();
            StringReader reader = new StringReader(fileStr);
            doc = sb.build(reader, "GBK");
            ele = doc.getRootElement();
            rootElementName = ele.getName();
            map = getContentMap(ele);
        }
        catch(Exception ex)
        {
            System.out.println(" XMLparseException::init(): " + ex.getMessage());
        }
    }

    public synchronized void UpStatus(String wo_id, String opinion, String wo_status)
    {
        String dealType = "";
        String pr_name = "";
        String us_name = "";
        String us_id = "";
        String msgContent = "";
        if("0".equals(wo_status) || "1".equals(wo_status) || "2".equals(wo_status))
            dealType = "1";
        else
        if("5".equals(wo_status))
            dealType = "2";
        else
            dealType = wo_status;
        if(!dealType.equals(""))
        {
            CDataCn dCn = new CDataCn();
            CDataImpl dImpl = new CDataImpl(dCn);
            dCn.beginTrans();
            if("1".equals(dealType) || "2".equals(dealType) || "3".equals(dealType) || "4".equals(dealType) || "10".equals(dealType))
            {
                if(dealType.equals("1"))
                    msgContent = "进行中";
                else
                if(dealType.equals("2"))
                    msgContent = "待补件";
                else
                if(dealType.equals("3"))
                    msgContent = "已通过";
                else
                if(dealType.equals("4"))
                    msgContent = "未通过";
                else
                if(dealType.equals("10"))
                    msgContent = "已删除";
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
//                msg.addNew();
                doAddMsg(msg);
                msg.setValue(CMessage.msgReceiverId, us_id);
                msg.setValue(CMessage.msgReceiverName, us_name);
                msg.setValue(CMessage.msgTitle, "您申请的项目“" + pr_name + "”" + msgContent);
                msg.setValue(CMessage.msgSenderId, "32");
                msg.setValue(CMessage.msgSenderName, "外事办");
                msg.setValue(CMessage.msgSenderDesc, "外事办");
                msg.setValue(CMessage.msgIsNew, "1");
                msg.setValue(CMessage.msgRelatedType, "1");
                msg.setValue(CMessage.msgPrimaryId, wo_id);
                msg.setValue(CMessage.msgSendTime, getNowTime());
                msg.setValue(CMessage.msgContent, opinion);
                msg.update();
                if("10".equals(wo_status))
                    dImpl.executeUpdate("delete from  tb_work where wo_id = '" + wo_id + "'");
            } else
            {
                System.err.println(new Date() + " -> " + "状态设置错误!");
            }
            dCn.commitTrans();
            dImpl.closeStmt();
            dCn.closeCn();
        }
    }

    private String getNowTime(){
    	Calendar cal = Calendar.getInstance();
    	return cal.get(Calendar.YEAR) + "-" + (cal.get(Calendar.MONTH) + 1) + "-" 
    			+ cal.get(Calendar.DAY_OF_MONTH) + " " + cal.get(Calendar.HOUR_OF_DAY) 
    			+ ":" + cal.get(Calendar.MINUTE) + ":" + cal.get(Calendar.SECOND);
      }
    
    private void doUpdateStatus(HashMap map)
    {
        String woId = "";
        String status = "";
        String info = "";
        if(map.get("status") != null)
            status = ((String)map.get("status")).trim();
        if(map.get("workID") != null)
            woId = ((String)map.get("workID")).trim();
        if(map.get("info") != null)
            info = ((String)map.get("info")).trim();
        UpStatus(woId, info, status);
    }

    private boolean doInsertVisa(HashMap map)
    {
        boolean flag;
        flag = false;
        String dd_name = "";
        String dd_desc = "";
        String dd_id = "";
        String flag1 = "0";
        String ddId = "";
        CDataCn cData = new CDataCn();
        CDataImpl cDataImpl = new CDataImpl(cData);
        if(map.get("ID") != null)
            dd_id = ((String)map.get("ID")).trim();
        if(map.get("Name") != null)
            dd_name = ((String)map.get("Name")).trim();
        if(map.get("Info") != null)
            dd_desc = ((String)map.get("Info")).trim();
        if(map.get("Flag") != null && !"".equals(map.get("Flag")))
            flag1 = ((String)map.get("Flag")).trim();
        try
        {
            if(doCheckName(dd_name))
            {
                cDataImpl.addNew("tb_datatdictionary", "DD_ID");
                cDataImpl.setValue("DD_PARENTID", "194", 0);
                cDataImpl.setValue("DD_NAME", dd_name, 3);
                cDataImpl.setValue("DD_DESC", dd_desc, 3);
                cDataImpl.setValue("DD_SHOWFLAG", flag1, 0);
                flag = cDataImpl.update();
            } else
            {
                ddId = getDdId(dd_name);
                if(!ddId.equals(dd_id))
                {
                    cDataImpl.executeUpdate("delete from tb_datatdictionary where DD_NAME = '" + dd_name + "'");
                    cDataImpl.addNew("tb_datatdictionary", "DD_ID");
                    cDataImpl.setValue("DD_PARENTID", "194", 0);
                    cDataImpl.setValue("DD_NAME", dd_name, 3);
                    cDataImpl.setValue("DD_DESC", dd_desc, 3);
                    cDataImpl.setValue("DD_SHOWFLAG", flag1, 0);
                    flag = cDataImpl.update();
                } else
                {
                    cDataImpl.edit("tb_datatdictionary", "DD_ID", dd_id);
                    cDataImpl.setValue("DD_PARENTID", "194", 0);
                    cDataImpl.setValue("DD_NAME", dd_name, 3);
                    cDataImpl.setValue("DD_DESC", dd_desc, 3);
                    cDataImpl.setValue("DD_SHOWFLAG", flag1, 0);
                    flag = cDataImpl.update();
                }
            }
        }
        catch(Exception e)
        {
            System.out.println("Exception::doInsertVisa " + e.getMessage());
        }
        finally
        {
            cData.closeCn();
            cDataImpl.closeStmt();
        }
        return flag;
    }

    private boolean doInsertNation(HashMap map)
    {
        boolean flag;
        flag = false;
        String dd_name = "";
        String dd_nameEn = "";
        String dd_desc = "";
        String dd_id = "";
        String parentId = "";
        String continent = "";
        String flag1 = "0";
        String kind = "0";
        String embassy = "0";
        String ddID = "";
        CDataCn cData = new CDataCn();
        CDataImpl cDataImpl = new CDataImpl(cData);
        try
        {
            if(map.get("Continent") != null)
                continent = map.get("Continent").toString().trim();
            if(map.get("ID") != null)
                dd_id = ((String)map.get("ID")).trim();
            if(map.get("NationName") != null)
                dd_name = ((String)map.get("NationName")).trim();
            if(map.get("Info") != null)
                dd_desc = ((String)map.get("Info")).trim();
            if(map.get("EnglishName") != null)
                dd_nameEn = ((String)map.get("EnglishName")).trim();
            if(map.get("Kind") != null)
                kind = ((String)map.get("Kind")).trim();
            if(map.get("Embassy") != null)
                embassy = ((String)map.get("Embassy")).trim();
            if(map.get("Flag") != null)
                flag1 = ((String)map.get("Flag")).trim();
            parentId = getParentId(continent);
            if(doCheckName(dd_name))
            {
                cDataImpl.addNew("tb_datatdictionary", "DD_ID");
                cDataImpl.setValue("DD_PARENTID", parentId, 0);
                cDataImpl.setValue("DD_NAME", dd_name, 3);
                cDataImpl.setValue("DD_DESC", dd_desc, 3);
                cDataImpl.setValue("DD_ENGLISHNAME", dd_nameEn, 3);
                cDataImpl.setValue("DD_SHOWFLAG", flag1, 0);
                cDataImpl.setValue("DD_EMBASSY", embassy, 0);
                cDataImpl.setValue("DD_KIND", kind, 0);
                flag = cDataImpl.update();
            } else
            {
                ddID = getDdId(dd_name);
                if(!ddID.equals(dd_id))
                {
                    cDataImpl.executeUpdate("delete from tb_datatdictionary where DD_NAME = '" + dd_name + "'");
                    cDataImpl.addNew("tb_datatdictionary", "DD_ID");
                    cDataImpl.setValue("DD_PARENTID", parentId, 0);
                    cDataImpl.setValue("DD_NAME", dd_name, 3);
                    cDataImpl.setValue("DD_DESC", dd_desc, 3);
                    cDataImpl.setValue("DD_ENGLISHNAME", dd_nameEn, 3);
                    cDataImpl.setValue("DD_SHOWFLAG", flag1, 0);
                    cDataImpl.setValue("DD_EMBASSY", embassy, 0);
                    cDataImpl.setValue("DD_KIND", kind, 0);
                    flag = cDataImpl.update();
                } else
                {
                    cDataImpl.edit("tb_datatdictionary", "DD_ID", dd_id);
                    cDataImpl.setValue("DD_PARENTID", parentId, 0);
                    cDataImpl.setValue("DD_NAME", dd_name, 3);
                    cDataImpl.setValue("DD_DESC", dd_desc, 3);
                    cDataImpl.setValue("DD_ENGLISHNAME", dd_nameEn, 3);
                    cDataImpl.setValue("DD_SHOWFLAG", flag1, 0);
                    cDataImpl.setValue("DD_EMBASSY", embassy, 0);
                    cDataImpl.setValue("DD_KIND", kind, 0);
                    flag = cDataImpl.update();
                }
            }
        }
        catch(Exception e)
        {
            System.out.println("Exception::doInsertNation " + e.getMessage());
        }
        finally
        {
            cData.closeCn();
            cDataImpl.closeStmt();
        }
        return flag;
    }

    private boolean doCheckName(String name)
    {
        int cnt;
        cnt = 0;
        ResultSet result = null;
        CDataCn cData = new CDataCn();
        CDataImpl cDataImpl = new CDataImpl(cData);
        try
        {
            result = cDataImpl.executeQuery(" SELECT COUNT(DD_ID) AS IDCNT FROM TB_DATATDICTIONARY WHERE DD_NAME = '" + name + "' ");
            if(result.next())
                cnt = result.getInt("IDCNT");
        }
        catch(SQLException e)
        {
            System.out.println("SQLException::doCheckName " + e.getMessage());
        }
        finally
        {
            cData.closeCn();
            cDataImpl.closeStmt();
        }
        return cnt == 0;
    }

    private String getDdId(String name)
    {
        String ddId;
        ddId = "";
        ResultSet result = null;
        CDataCn cData = new CDataCn();
        CDataImpl cDataImpl = new CDataImpl(cData);
        try
        {
            result = cDataImpl.executeQuery(" SELECT DD_ID FROM TB_DATATDICTIONARY WHERE DD_NAME = '" + name + "'");
            if(result.next())
                ddId = result.getString("DD_ID");
        }
        catch(SQLException e)
        {
            System.out.println("SQLException::getDdId " + e.getMessage());
        }
        finally
        {
            cData.closeCn();
            cDataImpl.closeStmt();
        }
        System.out.println("------- ddId = " + ddId);
        return ddId;
    }

    private String getParentId(String name)
    {
        String parentId;
        parentId = "";
        String sql = " SELECT DD_ID FROM TB_DATATDICTIONARY WHERE DD_NAME = '" + name + "'";
        Vector vector = null;
        CDataCn cData = new CDataCn();
        CDataImpl cDataImpl = new CDataImpl(cData);
        try
        {
            vector = cDataImpl.splitPage(sql, 10, 1);
            if(vector != null)
            {
                parentId = ((Hashtable)vector.get(0)).get("dd_id").toString();
            } else
            {
                cDataImpl.addNew("tb_datatdictionary", "DD_ID");
                cDataImpl.setValue("DD_NAME", name, 3);
                cDataImpl.setValue("DD_PARENTID", "2", 0);
                cDataImpl.update();
                parentId = String.valueOf(getMaxID("tb_datatdictionary"));
            }
        }
        catch(Exception e)
        {
            System.out.println("SQLException::getParentId " + e.getMessage());
        }
        finally
        {
            cData.closeCn();
            cDataImpl.closeStmt();
        }
        return parentId;
    }

    private int getMaxID(String tablename)
    {
        int maxId;
        maxId = 1;
        CDataCn cDn = new CDataCn();
        CDataImpl dImpl = new CDataImpl(cDn);
        Vector vector = null;
        try
        {
            vector = dImpl.splitPage("select rc_maxid from tb_rowcount where rc_tablename = '" + tablename + "'", 5, 1);
            if(vector != null)
                maxId = Integer.parseInt(((Hashtable)vector.get(0)).get("rc_maxid").toString());
        }
        catch(Exception ex)
        {
            System.out.println("SQLEXception::getMaxID " + ex.getMessage());
            cDn.closeCn();
            dImpl.closeStmt();
        }
        finally
        {
            cDn.closeCn();
            dImpl.closeStmt();
        }
        return maxId;
    }

    private HashMap getContentMap(Element element)
    {
        HashMap map = new HashMap();
        List list = new ArrayList();
        Attribute attribute = null;
        list = element.getAttributes();
        for(int j = 0; j < list.size(); j++)
        {
            attribute = (Attribute)list.get(j);
            map.put(attribute.getName(), attribute.getValue());
        }

        return map;
    }

    public String doAddMsg(CMessage msg){
    	String rtnMsgId = "";
    	String msgSql = "";
    	CDataCn cDn = null;
        CDataImpl dImpl = null;
        Hashtable msgTable = null;
        try{
        	cDn = new CDataCn();
            dImpl = new CDataImpl(cDn);
            rtnMsgId = msg.addNew();
            msgSql = "select ma_id from tb_message where ma_id='"+ rtnMsgId +"'";
            msgTable = dImpl.getDataInfo(msgSql);
            if(msgTable != null)
            	doAddMsg(msg);
        }catch(Exception ex){
        	System.out.println("SQLEXception::getMaxID " + ex.getMessage());
            cDn.closeCn();
            dImpl.closeStmt();
        }finally
        {
            cDn.closeCn();
            dImpl.closeStmt();
        }
    	
    	
    	return rtnMsgId;
    }
    
    public void doInsertTable(String fileStr)
    {
    	this.lock();
        init(fileStr);
        if("VISAKind".equals(rootElementName))
            doInsertVisa(map);
        else
        if("Nation".equals(rootElementName))
            doInsertNation(map);
        else
        if("BackInfo".equals(rootElementName))
            doUpdateStatus(map);
        this.unlock();
        System.out.println("rootElementName = " + rootElementName);
    }

    public static void main(String args[])
    {
        String str = "<?xml version=\"1.0\" encoding=\"GBK\"?><Nation ID=\"52\" NationName=\"韩国\" EnglishName=\"KOREA\" Kind=\"0\" Continent=\"亚洲\" Info=\"韩国韩国韩国韩国\" Embassy=\"0\" Flag=\"1\"></Nation>";
        str="<?xml version=\"1.0\" encoding=\"GBK\"?><BackInfo ID=\"\" info=\"文件已受理\" status=\"2\" workID=\"o42674\"></BackInfo>";
        Xml2DataDictionary tranXml = new Xml2DataDictionary();
        //tranXml.doInsertTable(str);
        System.out.println(tranXml.getNowTime());
    }
}
