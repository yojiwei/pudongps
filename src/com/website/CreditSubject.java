/*
 * Copyright (c)Beyondbit Internet Software Co., Ltd. 
 * 
 * This software is the confidential and proprietary information of 
 * Beyondbit Internet Software  Co., Ltd. ("Confidential Information").
 * You shall not disclose such Confidential Information and shall use it 
 * only in accordance with the terms of the license agreement you 
 * entered into with Beyondbit Internet Software Co., Ltd.
 */
package com.website;

import java.sql.ResultSet;
import java.sql.SQLException;

import com.component.database.CDataCn;
import com.component.database.CDataImpl;

/**
 * @author chenjq
 * Date 2006-6-29 <br>
 * Description: <br>
 * 
 */
public class CreditSubject {
    private String _id;
    private String _name;
    private String _dir;
    private String _link;
    private String _sonids;

    public CreditSubject(String id)
    {
        _id = "";
        _name = "";
        _dir = "";
        _link = "";
        _sonids = "";
        _id = id;
        setValues();
    }

    public String getNamebyId()
    {
        return _name;
    }

    public String getDirbyId()
    {
        return _dir;
    }

    public String getLinks()
    {
        return _link;
    }

    public String getSonids()
    {
        return _sonids;
    }

    private void setValues()
    {
        CDataCn dCn = new CDataCn();
        CDataImpl dImpl = new CDataImpl(dCn);
        setLinks(dImpl, _id, true);
        setSonIds(dImpl);
        ResultSet rs = dImpl.executeQuery("select sj_name,sj_dir from tb_subject where sj_id='" + _id + "'");
        try
        {
            if(rs.next())
            {
                _name = rs.getString("sj_name");
                _dir = rs.getString("sj_dir");
            }
        }
        catch(SQLException e)
        {
            e.printStackTrace();
        }
        finally
        {
            dImpl.closeStmt();
            dCn.closeCn();
        }
        return;
    }

    private void setLinks(CDataImpl Impl, String sjId, boolean islast)
    {
        ResultSet rs = Impl.executeQuery("select sj_id,sj_name,sj_parentid,sj_url from tb_subject where sj_id='" + sjId + "'");
        String sj_id = "";
        String sj_name = "";
        String sj_parentid = "";
        String sj_url = "";
        try
        {
            if(rs.next())
            {
                sj_id = rs.getString("sj_id");
                sj_name = rs.getString("sj_name");
                sj_parentid = rs.getString("sj_parentid");
                sj_url = rs.getString("sj_url");
                if(sj_url == null || sj_url.equals(""))
                    sj_url = "/website/credit/subIndex.jsp?sj_id=" + sj_id;
                if(!islast)
                    _link = ">" + _link;
                if(sj_parentid.equals("-1"))
                {
                    _link = "<a href='/website/index.jsp'>Ê×Ò³</a>" + _link;
                } else
                {
                    _link = "<a href=" + sj_url + ">" + sj_name + "</a>" + _link;
                    setLinks(Impl, sj_parentid, false);
                }
            }
        }
        catch(SQLException e)
        {
            e.printStackTrace();
        }
        finally
        {
            try
            {
                rs.close();
            }
            catch(SQLException e1)
            {
                e1.printStackTrace();
            }
        }
        return;
    }

    private void setSonIds(CDataImpl Impl)
    {
        ResultSet rs = Impl.executeQuery("select sj_id,sj_name,sj_url,sj_dir from tb_subject connect by prior sj_id=sj_parentid start with sj_id='" + _id + "' order by sj_id");
        String sonids = "";
        try
        {
            while(rs.next()) 
                sonids = sonids + rs.getString("sj_id") + ",";
            if(sonids.length() > 0)
                _sonids = sonids.substring(0, sonids.length() - 1);
        }
        catch(SQLException e)
        {
            e.printStackTrace();
        }
        finally
        {
            try
            {
                rs.close();
            }
            catch(SQLException e1)
            {
                e1.printStackTrace();
            }
        }
        return;
    }

    public static void main(String args[])
    {
        CreditSubject testCredit = new CreditSubject("171");
        System.out.println(testCredit.getNamebyId());
        System.out.println(testCredit.getSonids());
        System.out.println("link=" + testCredit.getLinks());
    }
}
