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
import com.component.database.CDataControl;

/**
 * @author chenjq
 * Date 2006-6-16 <br>
 * Description: <br>
 * 
 */
public class CCount extends CDataControl{
    
    private int _countType;
    private int _countNumber;
    private String _countName;
    private String _imgPath;

    public CCount(CDataCn dCn, String countNumber)
    {
        super(dCn);
        setCountType(1);
        _countName = countNumber;
    }

    public void setCountType(int countType)
    {
        _countType = countType;
        if(_countType == 1)
            _imgPath = "/website/images/";
        else
        if(_countType == 2)
            _imgPath = "/website/images/b/";
    }

    public void setCountName(String countName)
    {
        _countName = countName;
    }

    public int getCount()
    {
        ResultSet rs = null;
        String sql = String.valueOf(String.valueOf((new StringBuffer("select co_name,co_number from tb_count where co_name = '")).append(_countName).append("'")));
        rs = executeQuery(sql);
        try
        {
            if(rs.next())
                _countNumber = rs.getInt("co_number");
            int i = _countNumber;
            return i;
        }
        catch(SQLException ex)
        {
            int j = 0;
            return j;
        }
    }

    public String getCountHtml()
    {
        String sCountHtml = "";
        String sCount = String.valueOf(getCount());
        String addZero = "";
        if(sCount.length() < 7)
        {
            for(int i = 0; i < 7 - sCount.length(); i++)
                addZero = String.valueOf(String.valueOf(addZero)).concat("0");

            sCount = String.valueOf(addZero) + String.valueOf(sCount);
        }
        for(int i = 0; i < sCount.length(); i++)
            sCountHtml = String.valueOf(String.valueOf((new StringBuffer(String.valueOf(String.valueOf(sCountHtml)))).append("<img src=\"").append(_imgPath).append(sCount.charAt(i)).append(".gif\">")));

        return sCountHtml;
    }

    public void setCount()
    {
        String sql = String.valueOf(String.valueOf((new StringBuffer("update tb_count set co_number = co_number + 1 where co_name = '")).append(_countName).append("'")));
        executeUpdate(sql);
    }

    public static void main(String args[])
    {
        CDataCn dCn = new CDataCn();
        CCount cCo = new CCount(dCn, "work");
        cCo.setCount();
        System.out.println(cCo.getCountHtml());
        dCn.closeCn();
    }
}
