// FrontEnd Plus GUI for JAD
// DeCompiled : FlowNumManager.class

package com.beyondbit.soft2.onlinework;

import com.component.database.CDataCn;
import com.component.database.CDataImpl;
import java.io.PrintStream;
import java.util.Calendar;
import java.util.Hashtable;

public class FlowNumManager
{

    private static FlowNumManager manager = new FlowNumManager();

    public FlowNumManager()
    {
    }

    public static FlowNumManager getInstance()
    {
        return manager;
    }

    public synchronized String getFlowNum(String code)
    {
        String year;
        String returnNum;
        CDataCn dCn = new CDataCn();
        CDataImpl dImpl = new CDataImpl(dCn);
        Calendar calendar = Calendar.getInstance();
        year = String.valueOf(calendar.get(1));
        int num = 0;
        returnNum = "";
        try
        {
            dCn.beginTrans();
            Hashtable content = dImpl.getDataInfo("select FN_DESC,FN_FLOWNUM,FN_YEAR from tb_flownum  where fn_desc='" + code + "' AND TO_CHAR(SYSDATE,'yyyy') = FN_YEAR");
            if(content != null)
            {
                num = Integer.parseInt(content.get("fn_flownum").toString()) + 1;
                returnNum = String.valueOf(num).trim();
                int length = returnNum.length();
                for(int i = 5; i > length; i--)
                    returnNum = "0" + returnNum;

                dImpl.executeUpdate("update tb_flownum set fn_flownum = '" + String.valueOf(num) + "' where fn_desc='" + code + "'");
            } else
            {
                dImpl.executeUpdate("insert into tb_flownum(fn_flownum,fn_desc) values('1','" + code + "')");
                returnNum = "00001";
            }
            dCn.commitTrans();
        }
        catch(Exception ex)
        {
            System.out.print("error");
            ex.printStackTrace();
            dCn.rollbackTrans();
        }
        finally
        {
            dImpl.closeStmt();
            dCn.closeCn();
        }
        return "B" + year + returnNum;
    }

    public static void main(String args[])
    {
        System.out.print("dd");
        getInstance().getFlowNum("ygcg");
    }

}
