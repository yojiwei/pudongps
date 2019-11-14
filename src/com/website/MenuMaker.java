package com.website;
import com.component.database.*;
import java.sql.*;
import java.util.*;
import com.util.*;

/**
 * <p>Title: oa</p>
 * <p>Description: </p>
 * <p>Copyright: Copyright (c) 2002</p>
 * <p>Company: popteach</p>
 * @author not attributable
 * @version 1.0
 */

public class MenuMaker extends CDataControl{
    private String sqlStr = "",sjname = "",sjid = "",strHtml = "";
    public MenuMaker() {
    }

    public String MenuList(int upperid,boolean isRoot,String href,String dept)
    {
        ResultSet rs = null;
        Statement stmt = null;
        Vector IdList = new Vector();
        Vector NameList = new Vector();
        if(upperid>=0)
        {
            try
            {
                stmt = cn.createStatement();
                sqlStr = "select * from tb_title where ti_upperid=" + upperid+" order by ti_sequence";
                rs = stmt.executeQuery(sqlStr);
                while(rs.next())
                {
                   //sjid = rs.getString("sj_id");
                    IdList.addElement(rs.getString("ti_id"));
                    NameList.addElement(rs.getString("ti_name"));
                }
                rs.close();
                stmt.close();
            }
            catch(Exception e)
            {
                System.out.print(e);
            }
            if(IdList!=null)
            {
                if(!isRoot)
                {
                    strHtml += "<div id=\"display" + upperid +
                        "\" style=\"position:relative\" onMouseOver=\"tsover(dis" +
                        upperid + ")\" onMouseOut=\"tsout(dis" + upperid +
                        ")\">";
                    strHtml += "<div id=\"dis" + upperid + "\" style=\"display:none;left:35;top:-20;position:absolute;zindex:0;width:70px;height:20px;\" onMouseOver=\"tsover(dis" +
                        upperid + ")\">";
                    strHtml += "<table width=\"100\" class=\"solid\">";
                }
                for(int i=0;i<IdList.size();i++)
                {
                    strHtml += "<tr>";
                    strHtml +="<a href=\"" + href + "?dept=" + dept + "&classifyId=" + (String)IdList.elementAt(i) + "&classifyName=" + (String)NameList.elementAt(i) + "\">";
                    strHtml += "<td align=\"center\" style=\"cursor:hand\" id=\"div" + (String)IdList.elementAt(i) + "\" onMouseOver=\"changeto(div" + (String)IdList.elementAt(i) + ");tsover(dis" + (String)IdList.elementAt(i) + ")\" onMouseOut=\"changeback(div" + (String)IdList.elementAt(i) + ");tsout(dis" + (String)IdList.elementAt(i) + ")\">";
                    strHtml += (String)NameList.elementAt(i) ;
                    MenuList(Integer.parseInt((String)IdList.elementAt(i)),false,href,dept);
                    strHtml += "</td></a></tr>";
                }
                strHtml += "</table></div></div>";
            }
        }
        return strHtml;
    }

    public static void main(String[] args) {
    MenuMaker menu = new MenuMaker();
    //SubjectDetail sd= new SubjectDetail();
    //while (sd!=null)
    //{
    System.out.println(menu.MenuList(121,false,"dd.jsp","21"));
    //System.out.println(sd.sj_name+sd.sj_parentid);
    //}
  }

}
