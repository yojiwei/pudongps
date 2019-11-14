// FrontEnd Plus GUI for JAD
// DeCompiled : CRandom.class

package com.util;

import com.component.database.CDataCn;
import com.component.database.CDataImpl;
import java.io.PrintStream;
import java.util.*;


public class CRandom
{

    public static StringBuffer intBuf = new StringBuffer("0123456789");
    public static StringBuffer strBuf = new StringBuffer("0123456789abcdefghijklmnopqrstuvwxyz");

    public CRandom()
    { 
    }

    public static String getXinfangNumber(String type)
    {
        String rtnStr = "";
        Calendar thisDay = Calendar.getInstance();
        String year = String.valueOf(thisDay.get(1));
        String month = String.valueOf(thisDay.get(2) + 1);
        String nextNum = getNextNumber(type, year, month);
        String randomStr = getRandom(1, 4);
        rtnStr = type + year + month + nextNum + randomStr;
        return rtnStr;
    }

    public static String getRandom(int type, int length)
    {
        StringBuffer rtnStr = new StringBuffer();
        StringBuffer sourceStr = new StringBuffer();
        sourceStr = type != 1 ? strBuf : intBuf;
        Random random = new Random();
        int range = sourceStr.length();
        for(int i = 0; i < length; i++)
            rtnStr.append(sourceStr.charAt(random.nextInt(range)));

        return rtnStr.toString();
    }

    public static String getNextNumber(String type, String year, String month)
    {
        String nextNum;
        CDataCn dCn = null;
        CDataImpl dImpl = null;
        String sql = "select rd_id,rd_number from tb_random where rd_year = " + year + "and rd_month = " + month + " and rd_type = '" + type + "'";
        Hashtable xfTable = null;
        nextNum = "";
        String rd_id = "";
        try
        {
            dCn = new CDataCn();
            dImpl = new CDataImpl(dCn);
            xfTable = dImpl.getDataInfo(sql);
            if(xfTable != null)
            {
                rd_id = CTools.dealNull(xfTable.get("rd_id"));
                nextNum = CTools.dealNull(xfTable.get("rd_number"));
                nextNum = String.valueOf(Integer.parseInt(nextNum) + 1);
                dImpl.edit("tb_random", "rd_id", rd_id);
                dImpl.setValue("rd_number", nextNum, 3);
                dImpl.update();
            } else
            {
                nextNum = "1";
                rd_id = String.valueOf(dImpl.addNew("tb_random", "rd_id"));
                dImpl.setValue("rd_year", year, 3);
                dImpl.setValue("rd_month", month, 3);
                dImpl.setValue("rd_number", nextNum, 3);
                dImpl.setValue("rd_type", type, 3);
                dImpl.update();
            }
            sql = "select to_char(rd_number,'000') as rd_number from tb_random where rd_id = " + rd_id;
            xfTable = dImpl.getDataInfo(sql);
            if(xfTable != null)
                nextNum = CTools.dealNull(xfTable.get("rd_number")).trim();
        }
        catch(Exception e)
        {
            System.out.println(new Date() + "-->" + "CRandom error:" + e.getMessage());
        }
        finally
        {
            dImpl.closeStmt();
            dCn.closeCn();
        }
        return nextNum;
    }

    public static void main(String args[])
    {
        System.out.println(getRandom(2, 12));
    }

}