package com.website;

import com.component.database.CDataCn;
import com.component.database.CDataImpl;
import java.io.PrintStream;
import java.util.Hashtable;
import java.util.Vector;

public class NewHtmlCreate {
	public static String realpath = Messages.getString("SessHtml.0");
    public static String sql = "select fi_id ,fi_title ,fi_url,fi_img,fi_content from tb_frontinfo where fs_id=(select fs_id from tb_frontsubject where fs_code='staticpage') order by fi_sequence,fi_id";

    public NewHtmlCreate()
    {
    }

    public static void VectHtml()
    {
        CDataCn dCn = new CDataCn();
        CDataImpl dImpl = new CDataImpl(dCn);
        CUrl myurl = new CUrl();
        boolean b_flag = false;
        Vector vec = dImpl.splitPage(sql, 1000, 1);
        if(vec != null)
        {
            for(int i = 0; i < vec.size(); i++)
            {
                Hashtable map = (Hashtable)vec.get(i);
                String realpath2 = realpath;
                String fi_url = map.get("fi_url").toString();
                String fi_content = map.get("fi_content").toString();
                String fi_title = map.get("fi_title").toString();
                String fi_img = map.get("fi_img").toString();
                if(!fi_img.equals("1"))
                {
                    System.out.println(fi_title + "->" + realpath2 + fi_url);
                    b_flag = myurl.createHtml(fi_content, realpath2, fi_url);
                    System.out.println(b_flag);
                }
            }
        }
        dImpl.closeStmt();
        dCn.closeCn();
    }

    public static void main(String arg[])
    {
        VectHtml();
    }
}
