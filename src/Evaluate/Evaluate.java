// Decompiled by Jad v1.5.7f. Copyright 2000 Pavel Kouznetsov.
// Jad home page: http://www.geocities.com/SiliconValley/Bridge/8617/jad.html
// Decompiler options: packimports(3) 
// Source File Name:   Evaluate.java

package Evaluate;

import com.component.database.CDataCn;
import com.component.database.CDataImpl;
import java.util.Hashtable;

public class Evaluate
{

    public Evaluate()
    {
    }

    public static void main(String args1[])
    {
    }

    public String showCheckBoxDetail(String checkbox, int num, String title[])
    {
        String strreturn = "";
        strreturn = strreturn + "<tr>\n";
        strreturn = strreturn + "<td background=\"/website/images/mid10.gif\" width=\"1\"><img src=\"/website/images/mid10.gif\" width=\"1\" height=\"3\"></td>\n";
        strreturn = strreturn + "</tr>\n";
        strreturn = strreturn + "<tr width=\"100%\" class=\"line-even\">\n";
        strreturn = strreturn + "<td align=\"left\">" + title[0] + "</td>\n";
        strreturn = strreturn + "</tr>\n";
        strreturn = strreturn + "<tr>\n";
        strreturn = strreturn + "<td background=\"/website/images/mid10.gif\" width=\"1\"><img src=\"/website/images/mid10.gif\" width=\"1\" height=\"3\"></td>\n";
        strreturn = strreturn + "</tr>\n";
        for(int i = 1; i <= num; i++)
        {
            strreturn = strreturn + "<tr class=\"line-odd\">\n";
            strreturn = strreturn + "<td align=\"left\">\n";
            if(checkbox.charAt(i - 1) == '1')
                strreturn = strreturn + "<span style=\"background-color: #FFFF00\">" + title[i] + "</span>\n";
            else
                strreturn = strreturn + title[i];
            strreturn = strreturn + "</td>\n";
            strreturn = strreturn + "</tr>\n";
        }

        return strreturn;
    }

    public String showRadioDetail(String radio, int num, String title[])
    {
        String strreturn = "";
        strreturn = strreturn + "<tr>\n";
        strreturn = strreturn + "<td background=\"/website/images/mid10.gif\" width=\"1\"><img src=\"/website/images/mid10.gif\" width=\"1\" height=\"3\"></td>\n";
        strreturn = strreturn + "</tr>\n";
        strreturn = strreturn + "<tr width=\"100%\" class=\"line-even\">\n";
        strreturn = strreturn + "<td align=\"left\">" + title[0] + "</td>\n";
        strreturn = strreturn + "</tr>\n";
        strreturn = strreturn + "<tr>\n";
        strreturn = strreturn + "<td background=\"/website/images/mid10.gif\" width=\"1\"><img src=\"/website/images/mid10.gif\" width=\"1\" height=\"3\"></td>\n";
        strreturn = strreturn + "</tr>\n";
        for(int i = 1; i <= num; i++)
        {
            strreturn = strreturn + "<tr class=\"line-odd\">\n";
            strreturn = strreturn + "<td align=\"left\">\n";
            if(radio.equals(String.valueOf(i)))
                strreturn = strreturn + "<span style=\"background-color: #FFFF00\">" + title[i] + "</span>\n";
            else
                strreturn = strreturn + title[i];
            strreturn = strreturn + "</td>\n";
            strreturn = strreturn + "</tr>\n";
        }

        return strreturn;
    }

    public String showCheckBoxStat(String checkbox, int num, String table, String title[])
    {
        CDataCn dCn = new CDataCn();
        CDataImpl dImpl = new CDataImpl(dCn);
        String strcount[] = new String[20];
        double dcount[] = new double[20];
        double dcountall = 0.0D;
        double dcountper[] = new double[20];
        String strsql = "";
        String strCondition[] = new String[20];
        for(int i = 0; i < num; i++)
        {
            String strtemp = "";
            for(int j = 0; j < num; j++)
                if(j != i)
                    strtemp = strtemp + "_";
                else
                    strtemp = strtemp + "1";

            strCondition[i] = strtemp;
        }

        for(int i = 1; i <= num; i++)
        {
            strsql = "select count(" + checkbox + ") from " + table + " where " + checkbox + " like '" + strCondition[i - 1] + "' ";
            Hashtable content = dImpl.getDataInfo(strsql);
            if(content != null)
                strcount[i] = content.get("count(" + checkbox + ")").toString();
            dcount[i] = Double.parseDouble(strcount[i]);
        }

        for(int i = 1; i <= num; i++)
            dcountall += dcount[i];

        if(dcountall != 0.0D)
        {
            for(int i = 1; i <= num; i++)
                dcountper[i] = dcount[i] / dcountall;

        }
        dImpl.closeStmt();
        dCn.closeCn();
        String strreturn = "";
        if(!title[0].equals(""))
        {
            strreturn = strreturn + "<tr>\n";
            strreturn = strreturn + "<td background=\"/website/images/mid10.gif\" width=\"1\" colspan=\"3\"><img src=\"/website/images/mid10.gif\" width=\"1\" height=\"3\"></td>\n";
            strreturn = strreturn + "</tr>\n";
            strreturn = strreturn + "<tr width=\"100%\" class=\"line-even\">\n";
            strreturn = strreturn + "<td align=\"left\" colspan=\"3\">" + title[0] + "</td>\n";
            strreturn = strreturn + "</tr>\n";
            strreturn = strreturn + "<tr>\n";
            strreturn = strreturn + "<td background=\"/website/images/mid10.gif\" width=\"1\" colspan=\"3\"><img src=\"/website/images/mid10.gif\" width=\"1\" height=\"3\"></td>\n";
            strreturn = strreturn + "</tr>\n";
        }
        for(int i = 1; i <= num; i++)
        {
            strreturn = strreturn + "<tr class=\"line-odd\">\n";
            strreturn = strreturn + "<td align=\"left\" width=\"60%\">" + title[i] + "</td>\n";
            strreturn = strreturn + "<td align=\"left\">" + (double)(new Double(dcountper[i] * 1000D)).intValue() / 10D + "%</td>\n";
            strreturn = strreturn + "<td align=\"left\">\n";
            strreturn = strreturn + "<img src=\"/system/images/bar.gif\" width='" + dcountper[i] * 100D + "' height=\"5\">&nbsp;&nbsp;" + strcount[i] + "\u7968</TD>\n";
            strreturn = strreturn + "</td>\n";
            strreturn = strreturn + "</tr>\n";
        }

        return strreturn;
    }

    public String showStat(String radio, int num, String table, String title[])
    {
        CDataCn dCn = new CDataCn();
        CDataImpl dImpl = new CDataImpl(dCn);
        String strcount[] = new String[20];
        double dcount[] = new double[20];
        double dcountall = 0.0D;
        double dcountper[] = new double[20];
        String strsql = "";
        for(int i = 1; i <= num; i++)
        {
            strsql = "select count(" + radio + ") from " + table + " where " + radio + "='" + String.valueOf(i) + "' ";
            Hashtable content = dImpl.getDataInfo(strsql);
            if(content != null)
                strcount[i] = content.get("count(" + radio + ")").toString();
            dcount[i] = Double.parseDouble(strcount[i]);
        }

        for(int i = 1; i <= num; i++)
            dcountall += dcount[i];

        if(dcountall != 0.0D)
        {
            for(int i = 1; i <= num; i++)
                dcountper[i] = dcount[i] / dcountall;

        }
        dImpl.closeStmt();
        dCn.closeCn();
        String strreturn = "";
        if(!title[0].equals(""))
        {
            strreturn = strreturn + "<tr>\n";
            strreturn = strreturn + "<td background=\"/website/images/mid10.gif\" width=\"1\" colspan=\"3\"><img src=\"/website/images/mid10.gif\" width=\"1\" height=\"3\"></td>\n";
            strreturn = strreturn + "</tr>\n";
            strreturn = strreturn + "<tr width=\"100%\" class=\"line-even\">\n";
            strreturn = strreturn + "<td align=\"left\" colspan=\"3\">" + title[0] + "</td>\n";
            strreturn = strreturn + "</tr>\n";
            strreturn = strreturn + "<tr>\n";
            strreturn = strreturn + "<td background=\"/website/images/mid10.gif\" width=\"1\" colspan=\"3\"><img src=\"/website/images/mid10.gif\" width=\"1\" height=\"3\"></td>\n";
            strreturn = strreturn + "</tr>\n";
        }
        for(int i = 1; i <= num; i++)
        {
            strreturn = strreturn + "<tr class=\"line-odd\">\n";
            strreturn = strreturn + "<td align=\"left\" width=\"60%\">" + title[i] + "</td>\n";
            strreturn = strreturn + "<td align=\"left\">" + (double)(new Double(dcountper[i] * 1000D)).intValue() / 10D + "%</td>\n";
            strreturn = strreturn + "<td align=\"left\">\n";
            strreturn = strreturn + "<img src=\"/system/images/bar.gif\" width='" + dcountper[i] * 100D + "' height=\"5\">&nbsp;&nbsp;" + strcount[i] + "\u7968</TD>\n";
            strreturn = strreturn + "</td>\n";
            strreturn = strreturn + "</tr>\n";
        }

        return strreturn;
    }
}
